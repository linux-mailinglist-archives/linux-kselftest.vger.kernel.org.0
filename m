Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104152282D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 02:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiEKAIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 20:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEKAIh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 20:08:37 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F93D497
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020a62d113000000b0050d183adf6fso231111pfg.19
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ousdsQMGoWGPLGfdJHRlc9S6OKJxuNlkPfZprs239LE=;
        b=e3rAodX5f8r102qY1GuiiUNVeM6ToTpHYpSFbU4cVPlW3L9nkcmzWJgDA9lX+agIkr
         Qd/bEFbE9ZCvcix75fmuOcnctpaM6mvYi4Gfiw+o24cYfyNIq5I0zDiUPvmsBPlXs729
         HrOSPCyCn7ZI0Qy92j8PyfGtDJrCsCRQIe3RM3/roq6okzGovg5YE6P0S2cyeW0Hsx/E
         F9uOz81XMpK6On/HDJXdfcGYs6j/Cc75gc8HlGFYSeEq5BQ+kjrRDldiCso5cNyeWzxA
         S3CFwBiAUqGMPL2ERrhipC20Wzs7FZ6/gI2ZK47SUW/9tm79/wYkxDmNHVIbaaNR43Ym
         IfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ousdsQMGoWGPLGfdJHRlc9S6OKJxuNlkPfZprs239LE=;
        b=OIjQ0bb471p7PIVrgBRe2EQpmQYTHGVL7fAfsv2RT8+azGKOsR+ac7a9fsr9oLsRWe
         dHc0l2ZPnwa5P93mP731k7XWNKxnGZuTuH4e0jsTDDWrIIrRCm6EKV0YMzpk2FvDmCP6
         iHA9MGw6qQc5MTVpljm+UdU2OPjaHY37r7Rir1oVw3jTO4E8yn+7ChX/pWBkXZJCiIoE
         64XzaoUTPBtWzU3YmklldxLfBa0oFy0TdGVqKQxs9zacOsVl+KUwasNW/0CUdYivwbW6
         Qami1/vYaDKqT0hfwt7tHdvtDz99ZCc685YsGhV4yNV+g3G6cVjQx23cCP0BLch0KFew
         baUQ==
X-Gm-Message-State: AOAM5313N2nV+oDTDl1hYMtjfE0LS2ZiLV8g3G6Nr3twkzu7XrVTSwdC
        Jw3K75ajjtvHrjnY7PtTuqQmzuuFdxOUsA29
X-Google-Smtp-Source: ABdhPJzTmLb9y8mDaPQrDC9lq/Q88kd08tL6Wmu2p9a7OyjMRa4/Lb3QJlT+4la0xLIeV0XCQla+8xYaGu3VNwyk
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:e549:b0:15e:aa63:6fd8 with SMTP
 id n9-20020a170902e54900b0015eaa636fd8mr22998658plf.152.1652227707794; Tue,
 10 May 2022 17:08:27 -0700 (PDT)
Date:   Wed, 11 May 2022 00:08:05 +0000
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Message-Id: <20220511000811.384766-4-vannapurve@google.com>
Mime-Version: 1.0
References: <20220511000811.384766-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC V2 PATCH 3/8] selftests: kvm: priv_memfd_test: Add support for
 memory conversion
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
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
        diviness@google.com, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add handling of explicit private/shared memory conversion using
KVM_HC_MAP_GPA_RANGE and implicit memory conversion by handling
KVM_EXIT_MEMORY_ERROR.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/priv_memfd_test.c | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/priv_memfd_test.c b/tools/testing/selftests/kvm/priv_memfd_test.c
index bbb58c62e186..55e24c893b07 100644
--- a/tools/testing/selftests/kvm/priv_memfd_test.c
+++ b/tools/testing/selftests/kvm/priv_memfd_test.c
@@ -155,6 +155,83 @@ static struct test_run_helper priv_memfd_testsuite[] = {
 	},
 };
 
+static void handle_vm_exit_hypercall(struct kvm_run *run,
+	uint32_t test_id)
+{
+	uint64_t gpa, npages, attrs;
+	int priv_memfd =
+		priv_memfd_testsuite[test_id].priv_memfd;
+	int ret;
+	int fallocate_mode;
+
+	if (run->hypercall.nr != KVM_HC_MAP_GPA_RANGE) {
+		TEST_FAIL("Unhandled Hypercall %lld\n",
+					run->hypercall.nr);
+	}
+
+	gpa = run->hypercall.args[0];
+	npages = run->hypercall.args[1];
+	attrs = run->hypercall.args[2];
+
+	if ((gpa < TEST_MEM_GPA) || ((gpa +
+		(npages << MIN_PAGE_SHIFT)) > TEST_MEM_END)) {
+		TEST_FAIL("Unhandled gpa 0x%lx npages %ld\n",
+			gpa, npages);
+	}
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
+		fallocate_mode = 0;
+	else {
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
+			FALLOC_FL_KEEP_SIZE);
+	}
+	pr_info("Converting off 0x%lx pages 0x%lx to %s\n",
+		(gpa - TEST_MEM_GPA), npages,
+		fallocate_mode ?
+			"shared" : "private");
+	ret = fallocate(priv_memfd, fallocate_mode,
+		(gpa - TEST_MEM_GPA),
+		npages << MIN_PAGE_SHIFT);
+	TEST_ASSERT(ret != -1,
+		"fallocate failed in hc handling");
+	run->hypercall.ret = 0;
+}
+
+static void handle_vm_exit_memory_error(struct kvm_run *run,
+	uint32_t test_id)
+{
+	uint64_t gpa, size, flags;
+	int ret;
+	int priv_memfd =
+		priv_memfd_testsuite[test_id].priv_memfd;
+	int fallocate_mode;
+
+	gpa = run->memory.gpa;
+	size = run->memory.size;
+	flags = run->memory.flags;
+
+	if ((gpa < TEST_MEM_GPA) || ((gpa + size)
+					> TEST_MEM_END)) {
+		TEST_FAIL("Unhandled gpa 0x%lx size 0x%lx\n",
+			gpa, size);
+	}
+
+	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE)
+		fallocate_mode = 0;
+	else {
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE |
+				FALLOC_FL_KEEP_SIZE);
+	}
+	pr_info("Converting off 0x%lx size 0x%lx to %s\n",
+		(gpa - TEST_MEM_GPA), size,
+		fallocate_mode ?
+			"shared" : "private");
+	ret = fallocate(priv_memfd, fallocate_mode,
+		(gpa - TEST_MEM_GPA), size);
+	TEST_ASSERT(ret != -1,
+		"fallocate failed in memory error handling");
+}
+
 static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
 {
 	struct kvm_run *run;
@@ -181,6 +258,16 @@ static void vcpu_work(struct kvm_vm *vm, uint32_t test_id)
 			continue;
 		}
 
+		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
+			handle_vm_exit_hypercall(run, test_id);
+			continue;
+		}
+
+		if (run->exit_reason == KVM_EXIT_MEMORY_ERROR) {
+			handle_vm_exit_memory_error(run, test_id);
+			continue;
+		}
+
 		TEST_FAIL("Unhandled VCPU exit reason %d\n", run->exit_reason);
 		break;
 	}
-- 
2.36.0.550.gb090851708-goog

