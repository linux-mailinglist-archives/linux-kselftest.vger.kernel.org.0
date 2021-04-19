Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF02364559
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhDSNzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 09:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239701AbhDSNzo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618840514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJDhWNWJbo9Ptm9zLcMb3k/e6Ksbht4IOzHgeDM+WIQ=;
        b=HBeLiis87zX8YMPSLh2lkc03L+8o67Uk577JqRcK+lvdzBDmU8htXe5rX6+ipNMXwVUWxJ
        LkgDgtlASgbYnMadMkWQ9D1EUY/ToqYY1+Zyh1fVe7ZZEqN5IB4rL4j65uniG60t8mCnbV
        aST7TAsC0uNCNZys4JrmTMBNGrPVXqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-MnGzdhoQMUaGA5EASHSAbQ-1; Mon, 19 Apr 2021 09:55:11 -0400
X-MC-Unique: MnGzdhoQMUaGA5EASHSAbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 175B687A83B;
        Mon, 19 Apr 2021 13:55:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-67.ams2.redhat.com [10.36.115.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C5AA10013D7;
        Mon, 19 Apr 2021 13:55:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/5] MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
Date:   Mon, 19 Apr 2021 15:54:41 +0200
Message-Id: <20210419135443.12822-4-david@redhat.com>
In-Reply-To: <20210419135443.12822-1-david@redhat.com>
References: <20210419135443.12822-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

