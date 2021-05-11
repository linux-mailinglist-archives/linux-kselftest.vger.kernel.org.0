Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306A737A18A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEKIR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 04:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbhEKIR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620720979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46rZbB15ID/Xikp/GN7w2EKErT1D4ahWFjblQC95gas=;
        b=JtvtR2rDljRmzJ3KQljnkjWoxD6O64H5oGn7046WRToWgLU2yjR61eZs/6QJcWs80oo9Dk
        CYdAevamGOUd1kW5PvhdV9G8G4MFkyK5EaKe7s2aG4gH9UWUHK8/rRZmZftcZgWhkm1ZxW
        4UQVBAElPlb3EVG2m4LmfaZP1Q0q2KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Edl5C0rUNQKyk7WQxwF9HA-1; Tue, 11 May 2021 04:16:16 -0400
X-MC-Unique: Edl5C0rUNQKyk7WQxwF9HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB3A31008063;
        Tue, 11 May 2021 08:16:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CABF5D6D1;
        Tue, 11 May 2021 08:16:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH resend v2 4/5] selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
Date:   Tue, 11 May 2021 10:15:33 +0200
Message-Id: <20210511081534.3507-5-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

