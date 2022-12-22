Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D4654919
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 00:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLVXFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 18:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiLVXFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 18:05:12 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AAC26AF3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h6-20020a17090aa88600b00223fccff2efso3855650pjq.6
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AO35zZT0Yff42sOPrRxNuOogU4VodqUrhlKgNxVvKA=;
        b=aJF1ndtciA5/VQ0vui9aGcpiql44z/hN7BE9pna2NVdLJ7XJ8NjpnYM+v/LXYEGHyi
         AQU/QBurR8cFL3MlJ3lSM48jPc3XlMEdi4UTE8QuhkGu5Utmj7mfO/KD7rxo6BgRR9lz
         UY96xna912+UOVd1cuJOerNskvzrOBbgLedCEsZwAg3a0gRczRiKvlSHOH7D5nQpbab6
         GG6i3hvw5rgYd923nxkvPybjrUk8BTiKEv9FlmamZ0eP9Rnyb3hLDWyo74/bq4f7DfrY
         Nj1Hf7fEmRVBqskTAoqlh65Xc0rcYJ2hAXQndD3GdLe61gRga/BUv4Gcgqv0B2lpIa89
         TztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AO35zZT0Yff42sOPrRxNuOogU4VodqUrhlKgNxVvKA=;
        b=7cXjuu/YvZucYUeORyUqjoUp7NQdHAJ24sK0KCJNWQtjBQfyjX3J/kTIRX/lss5Ka0
         n80o+XXDza51bivSLhK5rD3s2+JH8xqOc4K+Fqdmuup2CGvNkgYdJae16mEK5N0pwzDN
         PfB3MSoVE8dGdQX1ePNj3RR0Dmlog9ghH+/MzvcSbKituoi24DaChbm8ArmSHZiIhOpP
         CI5A6a6R7ICBS0meaCeusiBdF2rlfrABSB+bEOVapEI55s1hY6XZrb7ThxNiF738xcoM
         2/uTeZ52TwXuQ0Y7mgBlKIr6zP+3IPLDG5XFwsiYtIW8sKCQ7cpyGujxtazAo36bGoyK
         g0ew==
X-Gm-Message-State: AFqh2kocI+9/NZpJLhh2Wq3eHb0LRc7lyOb++3+VK1D1mjIISERpIvOG
        h/VBvwKet3l0qUtLwwNEZiEJbzEGBOAAr3G3
X-Google-Smtp-Source: AMrXdXsE/MYtXhi7hYtJYbo7XECgkFRAmYclxWHWoMJCgI9gfsIxP+5vHkx2w3R+NlUVA7K+Tf+PgUZsxng0SPPt
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:81d4:0:b0:577:5678:bc80 with SMTP
 id c20-20020aa781d4000000b005775678bc80mr535664pfn.62.1671750311936; Thu, 22
 Dec 2022 15:05:11 -0800 (PST)
Date:   Thu, 22 Dec 2022 23:04:58 +0000
In-Reply-To: <20221222230458.3828342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221222230458.3828342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222230458.3828342-3-vannapurve@google.com>
Subject: [V3 PATCH 2/2] KVM: selftests: x86: Add native hypercall support
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an API to execute hypercall as per the cpu type by checking the
underlying CPU. KVM emulates vmcall/vmmcall instruction by modifying
guest memory contents with hypercall instruction as per the cpu type.

Confidential VMs need to execute hypercall instruction without it being
emulated by KVM as KVM can not modify guest memory contents.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h   |  3 +++
 .../selftests/kvm/lib/x86_64/processor.c       | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 4d5dd9a467e1..3617f83bb2e5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1039,6 +1039,9 @@ uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr);
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
+uint64_t kvm_native_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
+		       uint64_t a3);
+
 void __vm_xsave_require_permission(int bit, const char *name);
 
 #define vm_xsave_require_permission(perm)	\
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 1e93bb3cb058..429e55f2609f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1202,6 +1202,24 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 	return r;
 }
 
+uint64_t kvm_native_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
+		       uint64_t a3)
+{
+	uint64_t r;
+
+	if (is_amd_cpu()) {
+		asm volatile("vmmcall"
+		     : "=a"(r)
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	} else {
+		asm volatile("vmcall"
+		     : "=a"(r)
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	}
+
+	return r;
+}
+
 const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
-- 
2.39.0.314.g84b9a713c41-goog

