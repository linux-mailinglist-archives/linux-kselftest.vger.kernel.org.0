Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD359A3A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349792AbiHSSBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351312AbiHSSAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812C104467
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33352499223so87343467b3.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=AuVkheI7zf2HhufotQWCVsTEadgVfoRpum2lNpLuQgY=;
        b=oNfW/4Vm265qJrd7LBgFAyipxhEsSAOYU5rMBq91J3s0LGLmwRyUvf2zobD+iocvGC
         rLmPshSjGeT0g6SHJPTjY6bzeGEZukNgPVySpZWZJpfpTLjOOoofeCbjE4wVpCbw1U+j
         EkJBaRsfFlCUdZpPerVytTQfdhnWQStfFmO7kpeu5jLDpn+JPjv76skvPhlgvQTXfqqd
         qmtSwwVYkomcvTIcevsLzUBDxHN2ZwIXaSb2HUrgFgcnRKsdubuMqFRTXkGKJ5xBFxue
         InSW5McVJClaekJz+JJaVASvtdAFTT6dsAldrB/2HLKN31lg84RCExNfAgiGJESuAmTK
         9iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=AuVkheI7zf2HhufotQWCVsTEadgVfoRpum2lNpLuQgY=;
        b=da/zmOyKyaY8uUDxD/6F9ND6noS7fTVFUpaWWDhGHjY22ZLSImPsTL+NSWhrKDM4ir
         S7H9zarH4p1BtbMs6vNkBX4dahE/lkXKDdoy4bEFv4nNUvTaM5ahd6sSIZJe8ZR8DbLq
         f/Omjk0wWfJAD9lsrW9GlIL6Vbd+uDki1i+93lppG09DmTs6NmQgTxmJ1K5HOeQenUzz
         6tmSvdZ/Gal/Syqcph21HlWOIgKBswFBhulyl5LVo17Y8gSFmKfSWImuHnt3BfO8v5w2
         511131ckGUKew15qkxz/CTyu2DgK6cEres+wg3QXj37X0DXJWM86ey+06C2aN939f5ag
         LB4A==
X-Gm-Message-State: ACgBeo3v3IPzh9rAn2CiimOQH70CviIW/IwyoiinhqVZcIt7y8VBIzK/
        h5kZzJry7qyvRDpGtdGfqCX8q2eEpl6uWklR
X-Google-Smtp-Source: AA6agR4gbDQtGeQ1LZYbf3EfqgoCjGcFHk/HfWY3dMdFk8KnVzrhbHImvTXkhqgRq8jomz/vDv6134KXUwVifgsT
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a0d:ee01:0:b0:324:d943:19dc with SMTP
 id x1-20020a0dee01000000b00324d94319dcmr8282915ywe.325.1660931263972; Fri, 19
 Aug 2022 10:47:43 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:56 +0000
In-Reply-To: <20220819174659.2427983-1-vannapurve@google.com>
Message-Id: <20220819174659.2427983-4-vannapurve@google.com>
Mime-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 3/6] selftests: kvm: ucall: Allow querying ucall pool gpa
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a helper to query guest physical address for ucall pool
so that guest can mark the page as accessed shared or private.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/ucall_common.h |  2 ++
 tools/testing/selftests/kvm/lib/ucall_common.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 279bbab011c7..2c6e5c4df012 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -31,6 +31,8 @@ void ucall_arch_uninit(struct kvm_vm *vm);
 void ucall_arch_do_ucall(vm_vaddr_t uc);
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 
+vm_paddr_t get_ucall_pool_paddr(void);
+
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 5a15fa39cd51..4d2abef8ee77 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -11,6 +11,7 @@ struct ucall_header {
 
 static bool use_ucall_pool;
 static struct ucall_header *ucall_pool;
+static vm_paddr_t ucall_page_paddr;
 
 void ucall_init(struct kvm_vm *vm, void *arg)
 {
@@ -35,7 +36,10 @@ void ucall_init(struct kvm_vm *vm, void *arg)
 	}
 
 	ucall_pool = (struct ucall_header *)vaddr;
+	ucall_page_paddr = addr_gva2gpa(vm, vaddr);
 	sync_global_to_guest(vm, ucall_pool);
+	sync_global_to_guest(vm, ucall_page_paddr);
+	printf("ucall_page_paddr 0x%lx\n", ucall_page_paddr);
 
 out:
 	ucall_arch_init(vm, arg);
@@ -54,6 +58,14 @@ void ucall_uninit(struct kvm_vm *vm)
 	ucall_arch_uninit(vm);
 }
 
+vm_paddr_t get_ucall_pool_paddr(void)
+{
+	if (!use_ucall_pool)
+		return 0;
+
+	return ucall_page_paddr;
+}
+
 static struct ucall *ucall_alloc(void)
 {
 	struct ucall *uc = NULL;
-- 
2.37.1.595.g718a3a8f04-goog

