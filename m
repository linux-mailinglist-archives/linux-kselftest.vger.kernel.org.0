Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E659A4F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349933AbiHSSBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351364AbiHSSAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A76108FAF
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334228502a8so88316087b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Y2OAShC93kvragyfUYUREEqvnCxiWawZXRTFrrotT38=;
        b=TLuOc4UmL+jL81s7Bv8b61DGfOZAoDQzaumA9BqGp5Bmr3vL4GOkBen5wbpQN/5gsF
         4B51bN3Bfs/6AbBQ5WtaqpSpFAggpQ7wmLrLI64nqCzgZ/jt8gm1q9skBPqkJKBqZvj2
         seLae0fWfrZHAisvvxFnk4IPQv7hGyySZbJUi5/Lgy2dMdRG7Fixc6wmTnxhE57aJ+Wq
         U7pfUelfIot/tqUDDNfDJAZ/71aHD2hbHirFx44fLugoCwp7zYPtpCwNOn/nB97EJht0
         bbYPJ7di3F+90qzG3NXKm/y1aVEnD6KwHLkPJZl/Vc1hNzCb1goBMrFAssdvH+8FPUNo
         i5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Y2OAShC93kvragyfUYUREEqvnCxiWawZXRTFrrotT38=;
        b=gtCvpLL7LJN2i+BErGOmerjO2NS/ffFIacJoK2CNgL9h4P5Ys/lk715aypAlBBfb+f
         EdPTO0abtJTQP3z6wcou5XSI3LL+FGy/AYe32m/CQIHkuv6Ypa0v877fBY7eOAkGwhjQ
         SImpy7GufJpW62yYaiHxUbaQpklTEmp2q9VjMcbGphp4m0yQYAZZC8MuylfPNJGlb2XJ
         KL2TKIPemBmBOzf4JIT07Q5vujkjYvymwpOIO4IInGcggYU1EqUehNUz8cq+R5O7erCZ
         63l64LsHP5q+dUxIKRDVrlNCYo135xrWDGG/RvUulK6RB93nURSsO4AMn2tXjSuEV5LK
         0dPw==
X-Gm-Message-State: ACgBeo3yFdTyAU+Qy08FsZmmH27rsNqxpIwA2RIgflwqX2kYCpfOFJGT
        OggCE2iCMSZfKoynSGXoVI1vTNuXGW/f70hJ
X-Google-Smtp-Source: AA6agR5W8Al1N910ut7jrjDbhUtrRMQn96o/M6cFVTCXQOJx7Xf1JUkM2YfHGM6Xo3O4CAQe3mn1eG80uZ1Pggj2
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:690c:828:b0:336:bd1:1692 with SMTP
 id by8-20020a05690c082800b003360bd11692mr8629781ywb.364.1660931266161; Fri,
 19 Aug 2022 10:47:46 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:57 +0000
In-Reply-To: <20220819174659.2427983-1-vannapurve@google.com>
Message-Id: <20220819174659.2427983-5-vannapurve@google.com>
Mime-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 4/6] selftests: kvm: x86: Execute hypercall as per the cpu
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for executing vmmcall/vmcall instruction on amd/intel cpus.
In general kvm patches the instruction according to the cpu
implementation at runtime. While executing selftest vms from private
memory KVM will not be able to update the private memory of the guest.

Hypercall parameters are fixed to explicitly populate hypercall number
in eax. Otherwise inlined function calls to kvm_hypercall would call
vmmcall/vmcall instruction without updating eax with hypercall number.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 53b115876417..09d757a0b148 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1254,10 +1254,21 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3)
 {
 	uint64_t r;
+	static bool is_cpu_checked;
+	static bool is_cpu_amd;
 
-	asm volatile("vmcall"
+	if (!is_cpu_checked)
+		is_cpu_amd = is_amd_cpu();
+
+	if (is_cpu_amd) {
+		asm volatile("vmmcall"
+		     : "=a"(r)
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	} else {
+		asm volatile("vmcall"
 		     : "=a"(r)
-		     : "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	}
 	return r;
 }
 
-- 
2.37.1.595.g718a3a8f04-goog

