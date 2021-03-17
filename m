Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5133EABB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 08:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCQHqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 03:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhCQHp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 03:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615967158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RxzIT3AkxMjKIkvJDSVtAjMrZXxeLg+sSQ13b2gtYgk=;
        b=g4SFaHvaSYqBO1xaV60qzCppLP1TZwoWHZ3/waRnox1GQxhNWWlpTflTA70uykQM6hOVZD
        WnCPTF9vFThwcPc0lxJ3hw8lYSAxUWzW4Y7xh6Nivo4cx358C3wAO3j0ClUEVcCnxVBgX7
        T7KCiLcdZAr9HPPGtUw5vkubJXvseQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-odNBIqSpPBGlYb2scz6QYA-1; Wed, 17 Mar 2021 03:45:56 -0400
X-MC-Unique: odNBIqSpPBGlYb2scz6QYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E71189CD09;
        Wed, 17 Mar 2021 07:45:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-104.ams2.redhat.com [10.36.113.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DACF189BB;
        Wed, 17 Mar 2021 07:45:53 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] selftests/kvm: add test for KVM_GET_MSR_FEATURE_INDEX_LIST
Date:   Wed, 17 Mar 2021 08:45:52 +0100
Message-Id: <20210317074552.8550-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the kvm_get_feature_msr function to cover also
KVM_GET_MSR_FEATURE_INDEX_LIST.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index a8906e60a108..3eaa6b0172a9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -688,13 +688,20 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
 		struct kvm_msr_entry entry;
 	} buffer = {};
 	int r, kvm_fd;
+	struct kvm_msr_list features_list;
 
 	buffer.header.nmsrs = 1;
 	buffer.entry.index = msr_index;
+	features_list.nmsrs = 1;
+
 	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
 	if (kvm_fd < 0)
 		exit(KSFT_SKIP);
 
+	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, &features_list);
+	TEST_ASSERT(r < 0 && r != -E2BIG, "KVM_GET_MSR_FEATURE_INDEX_LIST IOCTL failed,\n"
+		"  rc: %i errno: %i", r, errno);
+
 	r = ioctl(kvm_fd, KVM_GET_MSRS, &buffer.header);
 	TEST_ASSERT(r == 1, "KVM_GET_MSRS IOCTL failed,\n"
 		"  rc: %i errno: %i", r, errno);
-- 
2.29.2

