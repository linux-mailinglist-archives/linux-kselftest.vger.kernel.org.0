Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F839ACC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFCV0m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhFCV0m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622755497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=r7Nr9zyNvu4ZyjMH6h4XMEahwlMJwXbItTVRKJ/5iiE=;
        b=FPsIPGmtvPRLMlwzzBbkVeBER19KNoAzD0Dn4YimNw785ik2L38W6MntZa+9xwzWxSRqQ/
        NrqR4Zr+vs8otu/bZZx9u6JWs+gOrhWQt7N+02LHhl+JP9sGdVrDrjxy0M1R0/iotHOczP
        l+WnjueowZqNFLF8lDW2+Y/A/2MWMk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-fWZzddPbPKewv3al71-w-A-1; Thu, 03 Jun 2021 17:24:55 -0400
X-MC-Unique: fWZzddPbPKewv3al71-w-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C47B80ED9B;
        Thu,  3 Jun 2021 21:24:54 +0000 (UTC)
Received: from llong.com (ovpn-116-222.rdu2.redhat.com [10.10.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A935150FA1;
        Thu,  3 Jun 2021 21:24:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] cgroup/cpuset: Don't call validate_change() for some flag changes
Date:   Thu,  3 Jun 2021 17:24:12 -0400
Message-Id: <20210603212416.25934-2-longman@redhat.com>
In-Reply-To: <20210603212416.25934-1-longman@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The update_flag() is called with one flag bit change and without change
in the various cpumasks in the cpuset. Moreover, not all changes in the
flag bits are validated in validate_change().  In particular, the load
balance flag and the two spread flags are not checked there. So there
is no point in calling validate_change() if those flag bits change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..65ad6995ad77 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1891,7 +1891,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_mutex held.
+ * Call with cpuset_mutex held & cpumasks remain unchanged.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -1911,16 +1911,22 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	else
 		clear_bit(bit, &trialcs->flags);
 
-	err = validate_change(cs, trialcs);
-	if (err < 0)
-		goto out;
-
 	balance_flag_changed = (is_sched_load_balance(cs) !=
 				is_sched_load_balance(trialcs));
 
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
+	/*
+	 * validate_change() doesn't validate changes in load balance
+	 * and spread flags.
+	 */
+	if (!balance_flag_changed && !spread_flag_changed) {
+		err = validate_change(cs, trialcs);
+		if (err < 0)
+			goto out;
+	}
+
 	spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
-- 
2.18.1

