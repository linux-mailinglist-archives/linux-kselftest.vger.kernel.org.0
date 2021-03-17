Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD433EF35
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCQLID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 07:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231302AbhCQLHf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 07:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSWPdHkyybmSgopy3PguxB1SkYa45HMIPNmr6xk1zOk=;
        b=DVici8hGaD3AkGaLWTeby7KaIlBIgKY9x3l5wnYD+cK7w2HJjRI7wpap4GOFUJKX5ytRsb
        MoZ7a2lkZ1f2ETerEORLxqpK1iTaAxbhZKd35YQ4oRNOSY3hVc15miYErDK0A7ll2gGZUJ
        13zv0oOlIpq+PxmckD48D6ovXyr2mps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-JlDeP0xVP1SSTbMfRxVhnA-1; Wed, 17 Mar 2021 07:07:33 -0400
X-MC-Unique: JlDeP0xVP1SSTbMfRxVhnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A978911E3;
        Wed, 17 Mar 2021 11:07:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91A7A53E35;
        Wed, 17 Mar 2021 11:07:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 3/5] MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
Date:   Wed, 17 Mar 2021 12:06:42 +0100
Message-Id: <20210317110644.25343-4-david@redhat.com>
In-Reply-To: <20210317110644.25343-1-david@redhat.com>
References: <20210317110644.25343-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MEMORY MANAGEMENT seems to be a good fit.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..b00963f4aa09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11560,6 +11560,7 @@ F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/vmalloc.h
 F:	mm/
+F:	tools/testing/selftests/vm/
 
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-- 
2.29.2

