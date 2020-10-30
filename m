Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7286C2A03DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3LQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 07:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgJ3LQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 07:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604056589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnT8yDT00QyRsUEZ7gp5zTCd68WeeplEqh2AFWI8M0Q=;
        b=Ra6B7yggExj0OqVP6QeJjBzgLO8EYuzv5LwGrpjm6JuHFmnEW1W8aWk0Ij31hYzRa+dKc8
        jtYcFzTlTD9rIOstUN23+Rekz2yR6W9acB7V5OXUJIYDhr+iGPjacQHRLdhpP+cNOlT9+c
        9rPTGc3IxmVBfLahMsVtodFMYjbctC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-mXSXqv9EPbi8R7k9h-V3SA-1; Fri, 30 Oct 2020 07:16:27 -0400
X-MC-Unique: mXSXqv9EPbi8R7k9h-V3SA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CFD1006700;
        Fri, 30 Oct 2020 11:16:26 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-14.ams2.redhat.com [10.36.114.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 345D010027AA;
        Fri, 30 Oct 2020 11:16:24 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH net-next v2 1/3] net/sysctl: factor-out netdev_rx_queue_set_rps_mask() helper
Date:   Fri, 30 Oct 2020 12:16:01 +0100
Message-Id: <02f88c3f7fb2dedb96b764328360c36d92bad95c.1604055792.git.pabeni@redhat.com>
In-Reply-To: <cover.1604055792.git.pabeni@redhat.com>
References: <cover.1604055792.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Will simplify the following patch. No functional change
intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/net-sysfs.c | 66 ++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 94fff0700bdd..b57426707216 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -737,42 +737,18 @@ static ssize_t show_rps_map(struct netdev_rx_queue *queue, char *buf)
 	return len < PAGE_SIZE ? len : -EINVAL;
 }
 
-static ssize_t store_rps_map(struct netdev_rx_queue *queue,
-			     const char *buf, size_t len)
+static int netdev_rx_queue_set_rps_mask(struct netdev_rx_queue *queue,
+					cpumask_var_t mask)
 {
-	struct rps_map *old_map, *map;
-	cpumask_var_t mask;
-	int err, cpu, i, hk_flags;
 	static DEFINE_MUTEX(rps_map_mutex);
-
-	if (!capable(CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	err = bitmap_parse(buf, len, cpumask_bits(mask), nr_cpumask_bits);
-	if (err) {
-		free_cpumask_var(mask);
-		return err;
-	}
-
-	if (!cpumask_empty(mask)) {
-		hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
-		cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
-		if (cpumask_empty(mask)) {
-			free_cpumask_var(mask);
-			return -EINVAL;
-		}
-	}
+	struct rps_map *old_map, *map;
+	int cpu, i;
 
 	map = kzalloc(max_t(unsigned int,
 			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
-	if (!map) {
-		free_cpumask_var(mask);
+	if (!map)
 		return -ENOMEM;
-	}
 
 	i = 0;
 	for_each_cpu_and(cpu, mask, cpu_online_mask)
@@ -799,9 +775,39 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 
 	if (old_map)
 		kfree_rcu(old_map, rcu);
+	return 0;
+}
+
+static ssize_t store_rps_map(struct netdev_rx_queue *queue,
+			     const char *buf, size_t len)
+{
+	cpumask_var_t mask;
+	int err, hk_flags;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = bitmap_parse(buf, len, cpumask_bits(mask), nr_cpumask_bits);
+	if (err)
+		goto out;
 
+	if (!cpumask_empty(mask)) {
+		hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+		cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+		if (cpumask_empty(mask)) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	err = netdev_rx_queue_set_rps_mask(queue, mask);
+
+out:
 	free_cpumask_var(mask);
-	return len;
+	return err ? : len;
 }
 
 static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
-- 
2.26.2

