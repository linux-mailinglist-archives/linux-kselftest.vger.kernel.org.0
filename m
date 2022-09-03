Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07E5ABDB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiICHjM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Sep 2022 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiICHjL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Sep 2022 03:39:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817D6F549;
        Sat,  3 Sep 2022 00:39:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 145so3988756pfw.4;
        Sat, 03 Sep 2022 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ROgdEwGTwKSezP6yTg8Bn5b9HWITXNuPp4Q731RWP+M=;
        b=aDZMg+5Gm5Z4KOXdcDeuVimJyU0uVQjdAQwcQwrupA3dK9GcXnOTJ1Go03nMO5UyIi
         FeAOY3WR4t3d4kBYiXdbh/karp3nWeMzIKPNe1GjSRWstX3jcBW+G6NKSbCfW5u/Tvg+
         5kRi8bZBQvV92jv9FWMu5Yq7yXg9X4fnz00+Ywyb6vEMoDYl10D7q2ZMToCtXPL1C0xe
         i4S4ZxWiI/RjCU6JKkX3JksmRs7gdmwWGLazYwyeHMTJ+bEBxJ/2TGUQ54iwSfdrxgCu
         kBsyEt+iDL7CP3ZUpk+gRIWGP1ZYIPLIuV5DjlxubDNmsPUdBKT/6Sl9T0UFhfL9BGe0
         FuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ROgdEwGTwKSezP6yTg8Bn5b9HWITXNuPp4Q731RWP+M=;
        b=zbppJsQ4vf362KGbMZDmEkp44estlEpz1+13ReSLKdCTW20Q05Ehy2Gnwwfy3HElyY
         jDkG7bILRR6y6u6eFAvLtnHFknEy702kPv4VW39PTaieDSPVUDwOdLO4UQd8IE2LzmiF
         I8YW/NGdfb/wKpaB3BuaSBRHePXmbyMc2LszJAFQ8oI/2dvNf1sa8hJkRQEbp5/ouLvs
         YJ5fmtTRuwSTxJrGOrUb46YdQGR9IDnI6l+cK+Y5pCFW8hSQKr/tU09Hk5ay2yCw9gU4
         j9lM4JsnMcYemKj2DPm7y8Af40CsRCC4N91sTbT0bZBo+Mnr8Sy0WcFnufDNP1MpezCE
         3EJg==
X-Gm-Message-State: ACgBeo1MqZfOIuwjWyj2tmMpFH7eGVYDnKEAxgd/vThS1261e+XJXFI+
        vDJIWeKWW4DvUZxdkrMV/vw=
X-Google-Smtp-Source: AA6agR57jxS7L9aa+NHczXrLUs5tGLCFmC508F1B/uwdaU5GBjHzXDuYk1MADtsscXoIC3Xfvhxabw==
X-Received: by 2002:a05:6a02:104:b0:430:93ec:776f with SMTP id bg4-20020a056a02010400b0043093ec776fmr8025194pgb.544.1662190749090;
        Sat, 03 Sep 2022 00:39:09 -0700 (PDT)
Received: from biggie.. ([103.230.148.184])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090adb8e00b001fd6066284dsm2738133pjv.6.2022.09.03.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 00:39:08 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, seanjc@google.com,
        guang.zeng@intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/kvm: Use num_vcpus when testing ICR in the xapic_state_test
Date:   Sat,  3 Sep 2022 13:09:01 +0530
Message-Id: <20220903073901.73862-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A TODO in xapic_state_test asks to use number of vCPUs instead of
vcpu.id + 1 in test_icr(). This patch adds support to get the number 
of vCPUs from the VM created and use it.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c     | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 6f7a5ef66718..de934e8e5e41 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -96,9 +96,8 @@ static void __test_icr(struct xapic_vcpu *x, uint64_t val)
 	____test_icr(x, val & ~(u64)APIC_ICR_BUSY);
 }
 
-static void test_icr(struct xapic_vcpu *x)
+static void test_icr(struct xapic_vcpu *x, int num_vcpus)
 {
-	struct kvm_vcpu *vcpu = x->vcpu;
 	uint64_t icr, i, j;
 
 	icr = APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_FIXED;
@@ -110,11 +109,11 @@ static void test_icr(struct xapic_vcpu *x)
 		__test_icr(x, icr | i);
 
 	/*
-	 * Send all flavors of IPIs to non-existent vCPUs.  TODO: use number of
-	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
+	 * Send all flavors of IPIs to non-existent vCPUs. Arbitrarily use vector 0xff.
 	 */
+
 	icr = APIC_INT_ASSERT | 0xff;
-	for (i = vcpu->id + 1; i < 0xff; i++) {
+	for (i = num_vcpus; i < 0xff; i++) {
 		for (j = 0; j < 8; j++)
 			__test_icr(x, i << (32 + 24) | icr | (j << 8));
 	}
@@ -137,9 +136,13 @@ int main(int argc, char *argv[])
 		.is_x2apic = true,
 	};
 	struct kvm_vm *vm;
+	struct list_head *iter;
+	int nr_vcpus_created = 0;
 
 	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
-	test_icr(&x);
+	list_for_each(iter, &vm->vcpus)
+		nr_vcpus_created++;
+	test_icr(&x, nr_vcpus_created);
 	kvm_vm_free(vm);
 
 	/*
@@ -153,6 +156,6 @@ int main(int argc, char *argv[])
 	vcpu_clear_cpuid_feature(x.vcpu, X86_FEATURE_X2APIC);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
-	test_icr(&x);
+	test_icr(&x, nr_vcpus_created);
 	kvm_vm_free(vm);
 }
-- 
2.34.1

