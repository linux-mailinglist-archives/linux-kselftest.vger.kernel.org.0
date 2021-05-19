Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC5389763
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhESUFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhESUFP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE19C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c9-20020a2580c90000b02904f86395a96dso19328201ybm.19
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rv0ERumOf71iShog8U1qPBT9mGKIDAJp7FTVCQRkzEM=;
        b=fjxm0c3dD1xUMPOH3FFURwgbNiEivz+zKgnGl4/ugh7HjstMXcxQ8bZUAehPznuLnj
         qEEvM0iUCnDrVQu+uQ/+GW7dj/lQBRbabhpF2qFdGEuQLtdhX04acaoxk9vruMAolv04
         lsGCLIoatDTljSrzUJBKcwpIhnje354lgZQ5Y9Y3ygPBlORSzKwR2d5MMxNsXJbh930v
         S4XCWQGhr7VQzFk/cSA0mh/MErqNXrih6lLO+2LsKRXj7QEUyHO/jIN2rjJRjnBhVRdD
         BFbe5UYtR+RdUnQ7mhaIHyn/nJgRkAbDbWb07xv/RCTZmAAQTG9hLBrFkZ1zHtfLfUuB
         PDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rv0ERumOf71iShog8U1qPBT9mGKIDAJp7FTVCQRkzEM=;
        b=A0tugNUW9rJt1DwsvG0AY7/4n3v9mgU3tYfkacRWJLMzv6Ha9fz9m3+bywqj/puhkt
         SX7ASBMr4FO7RBCxnh/tIfECS+QDhLkh/jSyKlt2F3WFQ62bsJF6wfh6zQqmGROBga5l
         nil7XXTdES660Bux7+aQZQRMbLgVTV8obTsS4k5MFXzWp/8tRGw9u8GQuLCOCLSuFbj7
         kq222Jxi78/HldW+WQjalPePcs/q9CBSWT//Kt/paL17VKNyoaIbLUeRM1xiBnCWLVY3
         58QqGXz76Kkkm09HDcxkAsy+LsvuF7kp8YEkQsZEcx4vf0yd4Vfs7bHRz+wiVPy8wGZE
         FRlw==
X-Gm-Message-State: AOAM531WTl55Png1oZzaqQsdhNsRkMTDHwVAHnJsjt4uPZ8YuRoxdeO1
        lf6mEO4l9pPw0TfAJA/Lg8AbRCGZi4LQDoeiDKIY
X-Google-Smtp-Source: ABdhPJz5N3/pd5VJqKk4JxdwQ8jx0ixZaias40sAlDAIQl0ygf8hg+6TyhmnevLNUFsls+UpU62lIM4s8NmBtaMAzqZk
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6c85:: with SMTP id
 h127mr1798049ybc.460.1621454634548; Wed, 19 May 2021 13:03:54 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:32 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 03/10] KVM: selftests: print a message when skipping KVM tests
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, if this check failed, we'd just exit quietly with no output.
This can be confusing, so print out a short message indicating why the
test is being skipped.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f05ca919cccb..0d6ddee429b9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -53,8 +53,10 @@ int kvm_check_cap(long cap)
 	int kvm_fd;
 
 	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
-	if (kvm_fd < 0)
+	if (kvm_fd < 0) {
+		print_skip("KVM not available, errno: %d", errno);
 		exit(KSFT_SKIP);
+	}
 
 	ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
 	TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
-- 
2.31.1.751.gd2f1c929bd-goog

