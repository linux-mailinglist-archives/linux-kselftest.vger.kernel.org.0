Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC97664BC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjAJS7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 13:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbjAJS6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:36 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336138BB
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 10:58:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x8-20020a17090a1f8800b0022153149290so5259720pja.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kllhy+XCjHqoEtvfgHpVkDHrVNguIhBfnG2gA6pKcs=;
        b=bePXYChwkQOZNK0AQ+5TcDEnhI5FHwYYdzXTv5PELbTA80AbZGfbPgADOF0yr/OMjf
         H3g5h1RaztZ1SlWgdgAs1x/EmvJ819PgotnllZnKdfYLCGBhMh9MhVSQyBQCTypSE2tR
         aV7mM1Zi3YO6IXtApA1uq2WW3PEfDn0U9AllV0N4aTqcRUsMZEC1MWVCSZqWJ8QOoOO+
         PvItS+Cwhm24ba4DROZfoWv2w924oEmPULO2nDFF1vok3QsdEMF5yPTD4JopsLWWA7Kq
         Rs/1aqJf1oac3hB/X/0kOTngPb97uywso+p8Qat27rZAgf4+9S2HaArrSz0cF1PRKGCm
         l1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kllhy+XCjHqoEtvfgHpVkDHrVNguIhBfnG2gA6pKcs=;
        b=eFwsxKJrjUvv1HgmF0obKb+3RVKkS1omxY0x++aIRIt7BIhmfgs0x2m5bdYqf4R/kC
         m75K3XLBZFDuOQ5Hmsb5ZWkTByD8nRTvli+Q13dnjcBCoOU7ROKF+SbVjGSZDPRMk8jT
         owf6Cvm/N1vYl1vhQ9iuwje+CPVGQ4SdXYysQVPFvWbVxuH9of0MPCKcuj/pLhoGGSTr
         boeXcxHJdZSaBRSWx+tcaZjtDoA+aXWQQdPFp6kCECr8CkdEh/rJo4/39jVJhLwgoJqO
         9mC9Jh6xOs5v6hrPuiIpQAHf1gIxxRuIV+ek0Is6wJoHF5T1ChigzWyHEIq8TnBkElY6
         BgaA==
X-Gm-Message-State: AFqh2kokRal/6kuKoyAejel/FPgpjkeK3wN7Vxa9Vyir2TN1BgXqGG5n
        9m8ZaeqDi/0VKnS12TM0zARAf8WTO2Vs
X-Google-Smtp-Source: AMrXdXveAeZkWD48dEoeZW9phbriGh3x782ZfSYB3GzyNWru3H6hHA3HPgQplWv8D1OkeYRKd2NNsqJ/+O1f
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:ef95:b0:192:97d1:a4d8 with SMTP id
 iz21-20020a170902ef9500b0019297d1a4d8mr3704144plb.74.1673377109836; Tue, 10
 Jan 2023 10:58:29 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 10 Jan 2023 18:58:21 +0000
In-Reply-To: <20230110185823.1856951-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110185823.1856951-3-mizhang@google.com>
Subject: [PATCH 2/4] KVM: selftests: x86: Add check of IA32_XFD in amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

When #NM is triggered, the handler needs to ensure the exception is
triggered by AMX by checking IA32_XFD_ERR and not because of CR0.TS[bit 3]
is 1. Note that the value of IA32_XFD_ERR comes from "the logical AND of
the IA32_XFD MSR and the bitmap corresponding to the state components
required by the faulting instruction." (Intel SDM vol 1. Section 13.14)

Add the missing check of CR0.TS before checking the value of IA32_XFD_ERR.
In addition, add an extra check to IA32_XFD to ensure the behavior is
consistent with the AMX archtecture. In addition, repeat the checks across
context switch to ensure the values of IA32_XFD and IA32_XFD_ERR are well
preserved.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 16533949a189..b2369f956fea 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -226,9 +226,12 @@ void guest_nm_handler(struct ex_regs *regs)
 {
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
 	GUEST_SYNC(7);
+	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT((rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT((rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
 	/* xfd=0, enable amx */
-- 
2.39.0.314.g84b9a713c41-goog

