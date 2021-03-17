Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2280E33EF42
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 12:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCQLID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 07:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhCQLHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 07:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85XjiPbcLjcS1uFs17f6qSU11x0QTbNg8UuEj5mu7ig=;
        b=VpvUz1N+cYjXgOtinI7+ABUXEPcx0HrejTXOI+NBtiHbc/uDGD4yEvTB8lmnzwfuy7JrZ8
        TzfrCTc/bD/FS+rm8yXk2XPPPvC4pFP+keH4Zafk2nb68543wB7LYhNos9yQUi0Oz+tiMm
        J/nXE38r/gD4zgk44skwWs1xcztLfLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-iNWa0gr1M0C9fO2d_MPe_g-1; Wed, 17 Mar 2021 07:07:36 -0400
X-MC-Unique: iNWa0gr1M0C9fO2d_MPe_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9426800D53;
        Wed, 17 Mar 2021 11:07:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57E9F53E35;
        Wed, 17 Mar 2021 11:07:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 4/5] selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
Date:   Wed, 17 Mar 2021 12:06:43 +0100
Message-Id: <20210317110644.25343-5-david@redhat.com>
In-Reply-To: <20210317110644.25343-1-david@redhat.com>
References: <20210317110644.25343-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
2.29.2

