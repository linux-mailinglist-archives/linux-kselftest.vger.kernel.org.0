Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A465866C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiL1TZS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 14:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiL1TZF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 14:25:05 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4181705E
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r17-20020a17090aa09100b0021903e75f14so7090335pjp.9
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIyfuO6L8HnU8CmCldKrIpDi7aTZJyxJfn1wljTzIeI=;
        b=HbphtqtIjGcu1bCKK6wFWu4E/GlYZGDlsYger0IgbCeUkoHRrvjgvwYnY/vOQNJS3v
         FyjI7bdMglfCpRTTsNvK49p8IyLNoVRBVdcnldRVB+HUTo08LKiSrhC5Q/0Uc+QQdp+X
         IHJ89MTp65CrwucYaVMtjMiROhNdBnnGYlBREUmDHiQkTkehUA4DlpRUBvud1+SVqpMC
         6jKDiAXw31yGNOiO07z1YlMzIXbFVC8qVLvnQMkUpOleAVc5L3CryHcplcqTmY4Pt+Gf
         tXjGKaI88IH6T+SOZw737PpHr745DcyWzXyYFxhUqfzzIygXPYuztcWMdNooU6ZBsvBQ
         U5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIyfuO6L8HnU8CmCldKrIpDi7aTZJyxJfn1wljTzIeI=;
        b=MnqUbjBH5ZtEuiYBl7flzcHTKlbmPX8qehPnymH5Tej/0sgPMg68TwIFhAls5BZ6HO
         A4hUMkTWey4G3H3cFEOHE9lN3g8PyYPMrz2DgT8g67N9IkeS58COrViw37wmNBYRlh7p
         vrDg2QYS+UQxq00/ImVy1fhwPee173thyGwExywmZr4u4hXoBSJj8iW4iw8qk1Ke7Xec
         Gi43RsmR+jAIC76eeNTVP6WvdpxFO740oIEZYqCY2x3jXGscXQmmA1znfS18HjQT8usu
         Cof9OVGJgcTe6vVJ4uykWeprcTLOmiBxx19e27PkICWSDhzIWW+B30FOTkRUC1uuYvZQ
         pPDQ==
X-Gm-Message-State: AFqh2krVI7I1m59aKkDDLGEXxKpPSOEmC5LXMfMFAUV8lkZ70Talle7g
        IEkMeq/WyiiH0smEAM2rMvqqCYumrQbP6P1l
X-Google-Smtp-Source: AMrXdXvOH+6kWmrNXWr4DzT0DiqLcTz70aEBBsdc901akacOkyNgSBf4mYJaruRIUQ+DNlIh+bmPNeoAoGZ2Pser
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:7c48:b0:225:ff38:5494 with SMTP
 id e8-20020a17090a7c4800b00225ff385494mr796035pjl.151.1672255496443; Wed, 28
 Dec 2022 11:24:56 -0800 (PST)
Date:   Wed, 28 Dec 2022 19:24:38 +0000
In-Reply-To: <20221228192438.2835203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221228192438.2835203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228192438.2835203-5-vannapurve@google.com>
Subject: [V4 PATCH 4/4] KVM: selftests: x86: Invoke kvm hypercall as per host cpu
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Invoke vmcall/vmmcall instructions from kvm_hypercall as per host CPU
type. CVMs and current kvm_hyerpcall callers need to execute hypercall
as per the cpu type to avoid KVM having to emulate the instruction
anyways.

CVMs need to avoid KVM emulation as the guest code is not updatable
from KVM. Guest code region can be marked un-mondifiable from KVM
without CVMs as well, so in general it's safer to avoid KVM emulation
for vmcall/vmmcall instructions.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 18f0608743d1..cc0b9c17fa91 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1154,9 +1154,15 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 {
 	uint64_t r;
 
-	asm volatile("vmcall"
+	asm volatile("test %[use_vmmcall], %[use_vmmcall]\n\t"
+		     "jnz 1f\n\t"
+		     "vmcall\n\t"
+		     "jmp 2f\n\t"
+		     "1: vmmcall\n\t"
+		     "2:"
 		     : "=a"(r)
-		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3),
+		       [use_vmmcall] "r" (is_host_cpu_amd()));
 	return r;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

