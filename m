Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9807D5A70FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiH3Wnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiH3Wn2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E8F7FFA7
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n18-20020a25d612000000b0069661a1dc48so811263ybg.20
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=FnC2MODp1Ilbo/3qVuV673Djb8hUYYAKXHPp7uV/l3U=;
        b=QPd795t1C0ahrsS55brxetoonol6V2jAppY01knmBO6dTEexYKdxvNbkTSQcIcPS0g
         2kVquW8pntnzZ8ayf2KGc74LWg1ImA0LODvDVKrQ5RNE9iPAZqoluWZufVPBUn48fc67
         kW1IFw4yDbnloy5QQ/STgOmCIxz9plIKPFM0HDvfvRd0xIR/a+XXnVcrsaDE4dXMXlvp
         2IrquyFJf8Ta/3dM4DHzEUE06trbxbXXW3PUtdEzPpNE9l9jhx85/6oghBZ5fuiPnSIa
         HihGAukLvraBpoNRHwoZwUflCiTPtuG2KVmnc5uUF0aSGnXsPpEIuWMW3HwQM/7lAwtJ
         qghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FnC2MODp1Ilbo/3qVuV673Djb8hUYYAKXHPp7uV/l3U=;
        b=BKIHvrSwwBndBF8uvi1ZasQkg9u4jO8/iNF/O++7pkFRcaXNQrSVSWa6sEZ6sb3wr6
         NchOpmrO4gi8qTZtisX5qmJQgFgiQO+ehJ4JuPm2cfcZgU4CaG5+NcI39nnlGmQlsnNf
         QIhlAIVqHtSm+0VmxHvamD45QbvXMbPF4K6fAXYP4KNy2q0dOxX/yq5gzZW8HGpYohzD
         76PuGz9pnpHaV2Q5LWak2HRB+hnom5xoGI/kMnvE7yNLZZtdpuIQUyJWuTivf4ShXUpu
         dvo/lexh3HkgwUNGuy7oZzI4c1hP7xcw6xWKBNpfJ2sXtZHYXanbztyaw3plVCJR6GVi
         FDZA==
X-Gm-Message-State: ACgBeo0jfxMdeWY3RzVdOFNBCTgkvM8w/ZP8AsrPqYXxyCbVJIhAkynm
        FrFqAMTBx+0FxSaEFJERMsrgIR/p7KwxSj+y
X-Google-Smtp-Source: AA6agR7J2g4yWWCjTXSW8bJGJNJQDF4Q6cZWWSd4WOmEIBPpC8PfIDGdBXAbKzkcTBd8rZjpqBovURMzodQSv4dn
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a81:bb43:0:b0:33d:cdd9:aa56 with SMTP
 id a3-20020a81bb43000000b0033dcdd9aa56mr15659487ywl.240.1661899403835; Tue,
 30 Aug 2022 15:43:23 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:55 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-5-vannapurve@google.com>
Subject: [RFC V2 PATCH 4/8] selftests: kvm: sev: Support memslots with private memory
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

Introduce an additional helper API to create a SEV VM with private
memory memslots.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/sev.h |  2 ++
 tools/testing/selftests/kvm/lib/x86_64/sev.c     | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index b6552ea1c716..628801707917 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -38,6 +38,8 @@ void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
 struct kvm_vm *sev_get_vm(struct sev_vm *sev);
 uint8_t sev_get_enc_bit(struct sev_vm *sev);
 
+struct sev_vm *sev_vm_create_with_flags(uint32_t policy, uint64_t npages,
+	uint32_t memslot_flags);
 struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
 void sev_vm_free(struct sev_vm *sev);
 void sev_vm_launch(struct sev_vm *sev);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 44b5ce5cd8db..6a329ea17f9f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -171,7 +171,8 @@ void sev_vm_free(struct sev_vm *sev)
 	free(sev);
 }
 
-struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
+struct sev_vm *sev_vm_create_with_flags(uint32_t policy, uint64_t npages,
+	uint32_t memslot_flags)
 {
 	struct sev_vm *sev;
 	struct kvm_vm *vm;
@@ -188,9 +189,12 @@ struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
 	vm->vpages_mapped = sparsebit_alloc();
 	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
 	pr_info("SEV cbit: %d\n", sev->enc_bit);
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
-	sev_register_user_region(sev, addr_gpa2hva(vm, 0),
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages,
+		memslot_flags);
+	if (!(memslot_flags & KVM_MEM_PRIVATE)) {
+		sev_register_user_region(sev, addr_gpa2hva(vm, 0),
 				 npages * vm->page_size);
+	}
 
 	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
 		sev->sev_policy, npages * vm->page_size / 1024);
@@ -198,6 +202,11 @@ struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
 	return sev;
 }
 
+struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
+{
+	return sev_vm_create_with_flags(policy, npages, 0);
+}
+
 void sev_vm_launch(struct sev_vm *sev)
 {
 	struct kvm_sev_launch_start ksev_launch_start = {0};
-- 
2.37.2.672.g94769d06f0-goog

