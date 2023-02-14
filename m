Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E92696D38
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjBNSqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjBNSq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371630283
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h5-20020a170902748500b0019aacd1fb04so2520929pll.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3bW5FuKrIfXRo88FKUNDpYqHZp7+18tX4wacmmrm8Gk=;
        b=aB+fVOG0ZogMNPWQZ2b1Wf3xANIRYlugnuwlbdPPGPEHz6wvWyQ3TNUhDEGEfmqq0m
         TymQAkocu2l38TVGBDqJRcGkKsMZtKKGls3r3ORrZOQ3gmRHFd7nDtml1wqoiuAtyBU0
         2Pn/wGx/LAhcM8siOvd/nLPYmZOXZA/Yn0k35vv1/jU16Ulmua9W/NLy9ifYxf4eOFhN
         Mrms9i+uHgqEW9d1sVT5rY+M9Ui9+ImWRApVZjuOQTg2PpKYUAehBZ2qWD6W8iocMU/L
         goLl3zrgBxV2lL+KJAI/4taxOisx85I7gG+m1FIKQjVjRn8ldQmhSqY5G3hYDh5VNqFV
         fDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bW5FuKrIfXRo88FKUNDpYqHZp7+18tX4wacmmrm8Gk=;
        b=5oxqd8UK/tp+KIv3YYeRcDuLkBVqgAraU9aq30RlhDJzfQs+BoinV6ZUgqKm7rM6WK
         /WDZso0o+FrMZhxj5qhH9Opnt/n+nIJFZXqoFx2j421Fa2uH70nNxJRXhhYixAGpgRLv
         76JUMRhI568zic5iF+YLXH/IAwGSc6K1aKia74zMxcuZg/0W5R0FBY5kft6strHuNqVS
         NVSFRwHwBX029eQTejHJpvZLhqBPGGbFudol/TtnLk9eS79YAgwsjfboOBSFqt+MZ8dx
         duFIaSAgUfLhfIbeioe0sSkItunmtqmVq9XJPtQWVrJmttQF6PAnXncHH1vsduDtpWpS
         /zOg==
X-Gm-Message-State: AO0yUKWnTU7xQFvwU4JqX8F5JIPkpbmulmvY9dKCNb0JHL3sPFnfiP8Q
        UhW8PefRq5AW4vMUIhRCjeWRCm34Arp+
X-Google-Smtp-Source: AK7set9WUSpyDoSjh/Xxe2GtC0MW65lxlPEcpJKTam+H34pLso9YWFBBVwE8KxMflLxS11pdrY6LOmflZhQm
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:3dc4:0:b0:4fb:58bf:d25f with SMTP id
 k187-20020a633dc4000000b004fb58bfd25fmr62667pga.7.1676400386299; Tue, 14 Feb
 2023 10:46:26 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:46:03 +0000
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-5-mizhang@google.com>
Subject: [PATCH v2 4/7] KVM: selftests: Add the XFD check to IA32_XFD in #NM handler
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
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

Add an extra check to IA32_XFD to ensure the behavior is consistent with
the AMX archtecture. In addition, repeat the checks across context switch
to ensure the values of IA32_XFD and IA32_XFD_ERR are well preserved.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 847752998660..44c907215343 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -217,8 +217,10 @@ void guest_nm_handler(struct ex_regs *regs)
 	GUEST_SYNC(7);
 	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
 	/* xfd=0, enable amx */
-- 
2.39.1.581.gbfd45094c4-goog

