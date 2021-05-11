Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8565737A188
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEKIRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 04:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhEKIRW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620720976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJDhWNWJbo9Ptm9zLcMb3k/e6Ksbht4IOzHgeDM+WIQ=;
        b=UzTBXt5JSLvat2PcL0cyO+1WX260X7zTS0yWWBw+6IgSebfOajtSqSl3ZEfELQV2z2l263
        Gw76Y9Qf8Tl2GOU+X75uQaxgCvzweCT5C4brfk4oUd5jt/KQW7FcFiveXywVcr8hkgZDvi
        zeLfCZTHbz/YxOMZc3D4l1ryw9Dt3ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-X2ui0ktXNOSHBI-vpVWHNA-1; Tue, 11 May 2021 04:16:13 -0400
X-MC-Unique: X2ui0ktXNOSHBI-vpVWHNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C40107ACC7;
        Tue, 11 May 2021 08:16:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C369B5D6D1;
        Tue, 11 May 2021 08:16:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH resend v2 3/5] MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
Date:   Tue, 11 May 2021 10:15:32 +0200
Message-Id: <20210511081534.3507-4-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 9450e052f1b1..cd267d218e08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11566,6 +11566,7 @@ F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/vmalloc.h
 F:	mm/
+F:	tools/testing/selftests/vm/
 
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
-- 
2.30.2

