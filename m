Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A3364562
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhDSN4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 09:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240414AbhDSNzx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 09:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618840523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46rZbB15ID/Xikp/GN7w2EKErT1D4ahWFjblQC95gas=;
        b=Hmb8mrWyFGQABSTPsWOk0Sz7fGSG+du4AAeVHlyPllsPpGDECiIAqwTBs0hyuQMiofQgVK
        MytjR/206dykSDhMbu6WIgA0sRfeFrH84OAUc6jBdnNwSWg+ijhw3S0l2074DSTav2BLAH
        HD9aK+Z/AhdLa1fiCTPXqIEwXOQTiOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-8rlyLwMHPPGa-Z6SrvJ4mA-1; Mon, 19 Apr 2021 09:55:14 -0400
X-MC-Unique: 8rlyLwMHPPGa-Z6SrvJ4mA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F73EC1A0;
        Mon, 19 Apr 2021 13:55:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-67.ams2.redhat.com [10.36.115.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75E2610013D7;
        Mon, 19 Apr 2021 13:55:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/5] selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
Date:   Mon, 19 Apr 2021 15:54:42 +0200
Message-Id: <20210419135443.12822-5-david@redhat.com>
In-Reply-To: <20210419135443.12822-1-david@redhat.com>
References: <20210419135443.12822-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We missed to add two binaries to gitignore.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 9a35c3f6a557..b4fc0148360e 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -22,3 +22,5 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 local_config.*
+protection_keys_32
+protection_keys_64
-- 
2.30.2

