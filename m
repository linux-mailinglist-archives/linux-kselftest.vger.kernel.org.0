Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E65A8AB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 03:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiIAB32 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIAB3A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 21:29:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D1155D42;
        Wed, 31 Aug 2022 18:28:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so963782pja.4;
        Wed, 31 Aug 2022 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Ku+oDe019jQV+bvEaEkfd4frzVRnrZ2aNZC2IczdqoE=;
        b=Hx6ZYs4+0dpZaVEYgMldoagI3dzhcW5Loqv9r9bGZHf25n1tI6e6nRzrblQHBsTR3i
         0MzRxIFaO9C5imLAfShWGpje3WbJEOaMRTGMfMA1YGi1f/DYsgJclf+2+RFd5Mt22j+5
         whLZOV0LrjhKFF8P1ednR4LMmDBkktyEGvFfmbyAuDzEP8MQR0le+AG3wtNcZmf7t2w2
         MoxiGOr1Og5W5yUqZRQDg1xDs0c4Zl6RQg9fmV+YglXfElNokw37ltw2fu7y5HPjO+Ny
         CC/1bmSX87LRQFv4DDLKtTfQjawKsgkZ07G/JxZ+H+yTA2Q2coEHyPaLLT3wVz1bA22t
         io9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Ku+oDe019jQV+bvEaEkfd4frzVRnrZ2aNZC2IczdqoE=;
        b=7jeyP6HhEGzKlzzBiRdXiriRfGDimGkKUExAj8U8tBt8aWvCV1IzSsaBiIx15RwPuf
         aA5iUA+44+OMqPl6fMahnpal+MXRwQFm1ggHYkBsFUburiIr0t+BsOj9wv4LjUflgXbs
         gDq4OsiJY0nYQwywt8mM0b/KWRQQcycr10syyICzo2NhqRg/mJ3qaW1hZv2MipBifu8j
         F2hkUREkXvEHzTH2EY0lzD9XELcziaS26qW6c1+FPHTTkkMZc9xkvLeLbGT9oJEhCmKG
         UVm8K1yeqw4PQDFKgTPBmiUagJuLAqR01Yj9M/6z7p+HF3SDvIUl56et3bClufFJ9NBt
         yflQ==
X-Gm-Message-State: ACgBeo3agjZFbhUQoJuHN7V29WjwHDsLzt77Kpt6t8MmEtzoOSSFLhU7
        JuvK08Qzk2rkOxj7c0qRw0Q=
X-Google-Smtp-Source: AA6agR6nLBFy943t35VbsHgT2fsKgoqBPdGZO7H/AqXnvw4bFq3mlKL2u/jpEg3UBub5TZ6Y8jO6Lw==
X-Received: by 2002:a17:903:22cf:b0:174:a5cd:31e0 with SMTP id y15-20020a17090322cf00b00174a5cd31e0mr18001431plg.23.1661995735628;
        Wed, 31 Aug 2022 18:28:55 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id w13-20020a6556cd000000b0042ba1a95235sm3981596pgs.86.2022.08.31.18.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:28:55 -0700 (PDT)
Date:   Wed, 31 Aug 2022 18:28:53 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sagi Shahar <sagis@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [RFC PATCH v2 00/17] TDX KVM selftests
Message-ID: <20220901012853.GF2711697@ls.amr.corp.intel.com>
References: <20220830222000.709028-1-sagis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here is one more test to exercise KVM_TDX_CAPABILITIES on top of this patch
series.

From f9c4c9013040ce7dee84e1d3370875e5158900bf Mon Sep 17 00:00:00 2001
Message-Id: <f9c4c9013040ce7dee84e1d3370875e5158900bf.1661995648.git.isaku.yamahata@intel.com>
In-Reply-To: <6ce32225079b83991b9f170730a8810005a079b0.1661995647.git.isaku.yamahata@intel.com>
References: <6ce32225079b83991b9f170730a8810005a079b0.1661995647.git.isaku.yamahata@intel.com>
From: Isaku Yamahata <isaku.yamahata@intel.com>
Date: Wed, 16 Mar 2022 09:15:40 -0700
Subject: [PATCH] KVM: selftest: tdx: call KVM_TDX_CAPABILITIES for
 test

Add exercise of KVM_TDX_CAPABILITIES.  The result isn't used.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  1 +
 .../selftests/kvm/lib/x86_64/tdx_lib.c        | 52 +++++++++++++++++--
 .../selftests/kvm/x86_64/tdx_vm_tests.c       |  3 ++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index be8564f4672d..bfa3709a76e5 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -119,6 +119,7 @@ struct page_table {
 void add_td_memory(struct kvm_vm *vm, void *source_page,
 		   uint64_t gpa, int size);
 void finalize_td_memory(struct kvm_vm *vm);
+void get_tdx_capabilities(struct kvm_vm *vm);
 void initialize_td(struct kvm_vm *vm);
 void initialize_td_with_attributes(struct kvm_vm *vm, uint64_t attributes);
 void initialize_td_vcpu(struct kvm_vcpu *vcpu);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
index 23893949c3a1..b07af314737a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -27,10 +27,9 @@ char *tdx_cmd_str[] = {
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
 
-static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+static int __tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 {
 	struct kvm_tdx_cmd tdx_cmd;
-	int r;
 
 	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
 		    ioctl_no);
@@ -39,7 +38,15 @@ static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 	tdx_cmd.id = ioctl_no;
 	tdx_cmd.flags = flags;
 	tdx_cmd.data = (uint64_t)data;
-	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+}
+
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	int r;
+
+	r = __tdx_ioctl(fd, ioctl_no, flags, data);
 	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
 		    errno);
 }
@@ -77,6 +84,45 @@ static struct tdx_cpuid_data get_tdx_cpuid_data(struct kvm_vm *vm)
 	return cpuid_data;
 }
 
+/* Call KVM_TDX_CAPABILITIES for API test. The result isn't used. */
+void get_tdx_capabilities(struct kvm_vm *vm)
+{
+	int i;
+	int rc;
+	int nr_cpuid_configs = 8;
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+
+	while (true) {
+		tdx_cap = realloc(
+			tdx_cap, sizeof(*tdx_cap) +
+			nr_cpuid_configs * sizeof(*tdx_cap->cpuid_configs));
+		tdx_cap->nr_cpuid_configs = nr_cpuid_configs;
+		TEST_ASSERT(tdx_cap != NULL,
+			"Could not allocate memory for tdx capability "
+			"nr_cpuid_configs %d\n", nr_cpuid_configs);
+		rc = __tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+		if (rc < 0 && errno == E2BIG) {
+			nr_cpuid_configs *= 2;
+			continue;
+		}
+		TEST_ASSERT(rc == 0, "%s failed: %d %d",
+			tdx_cmd_str[KVM_TDX_CAPABILITIES], rc, errno);
+		break;
+	}
+	pr_debug("tdx_cap: attrs: fixed0 0x%016llx fixed1 0x%016llx\n"
+		"tdx_cap: xfam fixed0 0x%016llx fixed1 0x%016llx\n",
+		tdx_cap->attrs_fixed0, tdx_cap->attrs_fixed1,
+		tdx_cap->xfam_fixed0, tdx_cap->xfam_fixed1);
+	for (i = 0; i < tdx_cap->nr_cpuid_configs; i++) {
+		const struct kvm_tdx_cpuid_config *config =
+			&tdx_cap->cpuid_configs[i];
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x "
+			"eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			i, config->leaf, config->sub_leaf,
+			config->eax, config->ebx, config->ecx, config->edx);
+	}
+}
+
 /*
  * Initialize a VM as a TD with attributes.
  *
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a96abada54b6..b3f9e3fa41f4 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -197,6 +197,9 @@ void verify_td_lifecycle(void)
 	/* Create a TD VM with no memory.*/
 	vm = vm_create_tdx();
 
+	/* Get TDX capabilities */
+	get_tdx_capabilities(vm);
+
 	/* Allocate TD guest memory and initialize the TD.*/
 	initialize_td(vm);
 
-- 
2.25.1

On Tue, Aug 30, 2022 at 10:19:43PM +0000,
Sagi Shahar <sagis@google.com> wrote:

> Hello,
> 
> This is v2 of the patch series for TDX selftests.
> 
> It is based on v5.19-rc8 and Intel's V8 of the TDX host patches which
> was proposed in https://lkml.org/lkml/2022/8/8/877
> 
> The tree can be found at
> https://github.com/googleprodkernel/linux-cc/tree/selftests
> 
> Major changes vrom v1:
> - rebased to v5.19
> - added helpers for success and failure reporting
> - added additional test cases
> 
> ---
> TDX stands for Trust Domain Extensions which isolates VMs from the
> virtual-machine manager (VMM)/hypervisor and any other software on the
> platform.
> 
> Intel has recently submitted a set of RFC patches for KVM support for
> TDX and more information can be found on the latest TDX Support
> Patches: https://lkml.org/lkml/2022/8/8/877
> 
> Due to the nature of the confidential computing environment that TDX
> provides, it is very difficult to verify/test the KVM support. TDX
> requires UEFI and the guest kernel to be enlightened which are all under
> development.
> 
> We are working on a set of selftests to close this gap and be able to
> verify the KVM functionality to support TDX lifecycle and GHCI [1]
> interface.
> 
> We are looking for any feedback on:
> - Patch series itself
> - Any suggestion on how we should approach testing TDX functionality.
> Does selftests seems reasonable or should we switch to using KVM
> unit tests. I would be happy to get some perspective on how KVM unit
> tests can help us more.
> - Any test case or scenario that we should add.
> - Anything else I have not thought of yet.
> 
> Current patch series provide the following capabilities:
> 
> - Provide helper functions to create a TD (Trusted Domain) using the KVM
>   ioctls
> - Provide helper functions to create a guest image that can include any
>   testing code
> - Provide helper functions and wrapper functions to write testing code
>   using GHCI interface
> - Add a test case that verifies TDX life cycle
> - Add a test case that verifies TDX GHCI port IO
> 
> TODOs:
> - Use existing function to create page tables dynamically
>   (ie __virt_pg_map())
> - Remove arbitrary defined magic numbers for data structure offsets
> - Add TDVMCALL for error reporting
> - Add additional test cases as some listed below
> - Add #VE handlers to help testing more complicated test cases
> 
> ---
> Erdem Aktas (4):
>   KVM: selftests: Add support for creating non-default type VMs
>   KVM: selftest: Add helper functions to create TDX VMs
>   KVM: selftest: Adding TDX life cycle test.
>   KVM: selftest: Adding test case for TDX port IO
> 
> Roger Wang (1):
>   KVM: selftest: TDX: Add TDG.VP.INFO test
> 
> Ryan Afranji (2):
>   KVM: selftest: TDX: Verify the behavior when host consumes a TD
>     private memory
>   KVM: selftest: TDX: Add shared memory test
> 
> Sagi Shahar (10):
>   KVM: selftest: TDX: Add report_fatal_error test
>   KVM: selftest: TDX: Add basic TDX CPUID test
>   KVM: selftest: TDX: Add basic get_td_vmcall_info test
>   KVM: selftest: TDX: Add TDX IO writes test
>   KVM: selftest: TDX: Add TDX IO reads test
>   KVM: selftest: TDX: Add TDX MSR read/write tests
>   KVM: selftest: TDX: Add TDX HLT exit test
>   KVM: selftest: TDX: Add TDX MMIO reads test
>   KVM: selftest: TDX: Add TDX MMIO writes test
>   KVM: selftest: TDX: Add TDX CPUID TDVMCALL test
> 
>  tools/testing/selftests/kvm/Makefile          |    2 +
>  .../selftests/kvm/include/kvm_util_base.h     |   12 +-
>  .../selftests/kvm/include/x86_64/processor.h  |    1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |    6 +-
>  .../selftests/kvm/lib/x86_64/processor.c      |   27 +
>  tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  495 +++++
>  .../selftests/kvm/lib/x86_64/tdx_lib.c        |  373 ++++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1666 +++++++++++++++++
>  8 files changed, 2577 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
>  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> 
> -- 
> 2.37.2.789.g6183377224-goog
> 

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
