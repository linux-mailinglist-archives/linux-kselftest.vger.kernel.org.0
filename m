Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EFD5A8A8C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIABWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiIABWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 21:22:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F875136B28;
        Wed, 31 Aug 2022 18:22:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so15719756pls.4;
        Wed, 31 Aug 2022 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+0+HN/s3K0NpAKgv9NYnh6iIwfvsfyIVk74B+Fut/KA=;
        b=MkbNQwUFQQkP11Q9RtytsGbyDyXzFBP7LCHqeZAailwaE79eaqZ7E45hmx9+iqEROB
         5wUqNnEIEgkJPcJHdITxhEnflFwaBCrWwvwxtP1P9cSqIU/px2OPPnKReJHTEp3GNTTi
         e82q7oBauXVi00CpeuiDPwHCVGy/Pbr9ZICorZ7kxUxTXcCItfDMH8YOpre8+dvAAQ7h
         uZq7r+HiHQmEPxFlBjZlD5VvFie6XBdWsjxaUTIQteDxJLmLOxbbuVgKDO/9UCmn7WNR
         g51pQI1ndppnYAVBrwhy4TmQXgAofi90zAoQebdsc2FfpmTmkjmcYYxhXIwWm4+ljobf
         BEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+0+HN/s3K0NpAKgv9NYnh6iIwfvsfyIVk74B+Fut/KA=;
        b=UebzIThmpuw22jq0dQxPGcgg7hzJC9OUG11PeVrNqe25t8pNarfdbT4alyMb8eVUkR
         YwMjycRYUWKalQG9dFsxxDrz6IAUeTNWr0EakZb4GdJ3JaXhrl9t9/liZ1sps/rrcNRB
         txY/GnnlHrtac6f48DBxw0vu+vS/m2Z0FhA1g2weww4AyREDt9uW2IsQx6hKuCuOcQKI
         CRmoP1D1EeE4oII6Ur5bbs7TmXM7tge4cZ4hnibD4ycG+nYlegZhQsmvfXLsAMuvzYmp
         v68w3Mn+kJDIp84MeofNrMdu84cpfZrG7wfX3R+Wj+MdGWqtZgIimP6hbQVAfUcZ/Y2G
         r8/A==
X-Gm-Message-State: ACgBeo15dD6KiN8n4Atp87kqBB2Uqo91lcPCNnMeJ1uPs51dughsnIpR
        eqU/o3cka549HVxgmZaeMDo=
X-Google-Smtp-Source: AA6agR5fLlXmiGovBn0OOghPlUNEt6hr4NypsWyDoBd1v0zdLj94IQUHJQwMPC3VbsoEK19W2ze0Rg==
X-Received: by 2002:a17:902:d4c4:b0:170:9fdb:4a2a with SMTP id o4-20020a170902d4c400b001709fdb4a2amr27456600plg.137.1661995366819;
        Wed, 31 Aug 2022 18:22:46 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001755ac7dd0asm307368plg.290.2022.08.31.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:22:46 -0700 (PDT)
Date:   Wed, 31 Aug 2022 18:22:45 -0700
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
Subject: Re: [RFC PATCH v2 02/17] KVM: selftest: Add helper functions to
 create TDX VMs
Message-ID: <20220901012245.GE2711697@ls.amr.corp.intel.com>
References: <20220830222000.709028-1-sagis@google.com>
 <20220830222000.709028-3-sagis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830222000.709028-3-sagis@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 10:19:45PM +0000,
Sagi Shahar <sagis@google.com> wrote:
...
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
> new file mode 100644
> index 000000000000..72bf2ff24a29
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/stringify.h>
> +#include "asm/kvm.h"
> +#include "tdx.h"
> +#include <stdlib.h>
> +#include <malloc.h>
> +#include "processor.h"
> +#include <string.h>
> +
> +char *tdx_cmd_str[] = {
> +	"KVM_TDX_CAPABILITIES",
> +	"KVM_TDX_INIT_VM",
> +	"KVM_TDX_INIT_VCPU",
> +	"KVM_TDX_INIT_MEM_REGION",
> +	"KVM_TDX_FINALIZE_VM"
> +};
> +
> +#define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
> +#define EIGHT_INT3_INSTRUCTIONS 0xCCCCCCCCCCCCCCCC
> +
> +#define XFEATURE_LBR		15
> +#define XFEATURE_XTILECFG	17
> +#define XFEATURE_XTILEDATA	18
> +#define XFEATURE_MASK_LBR	(1 << XFEATURE_LBR)
> +#define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
> +#define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
> +#define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
> +
> +
> +static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
> +{
> +	struct kvm_tdx_cmd tdx_cmd;
> +	int r;
> +
> +	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
> +		    ioctl_no);
> +
> +	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
> +	tdx_cmd.id = ioctl_no;
> +	tdx_cmd.flags = flags;
> +	tdx_cmd.data = (uint64_t)data;
> +	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
> +		    errno);
> +}
> +
> +static struct tdx_cpuid_data get_tdx_cpuid_data(struct kvm_vm *vm)
> +{
> +	static struct tdx_cpuid_data cpuid_data;
> +	int ret, i;
> +
> +	if (cpuid_data.cpuid.nent)
> +		return cpuid_data;
> +
> +	memset(&cpuid_data, 0, sizeof(cpuid_data));
> +	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
> +	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
> +	if (ret) {
> +		TEST_FAIL("KVM_GET_SUPPORTED_CPUID failed %d %d\n",
> +		    ret, errno);
> +		cpuid_data.cpuid.nent = 0;
> +		return cpuid_data;
> +	}
> +
> +	for (i = 0; i < KVM_MAX_CPUID_ENTRIES; i++) {
> +		struct kvm_cpuid_entry2 *e = &cpuid_data.entries[i];
> +
> +		/* TDX doesn't support LBR and AMX features yet.
> +		 * Disable those bits from the XCR0 register.
> +		 */
> +		if (e->function == 0xd && (e->index == 0)) {
> +			e->eax &= ~XFEATURE_MASK_LBR;
> +			e->eax &= ~XFEATURE_MASK_XTILE;
> +		}
> +	}
> +
> +	return cpuid_data;
> +}

CET also needs adjust.  How about the followings?

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
index 1c3e47006cd2..123db9b76f82 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -25,7 +25,7 @@ char *tdx_cmd_str[] = {
 #define XFEATURE_MASK_XTILECFG (1 << XFEATURE_XTILECFG)
 #define XFEATURE_MASK_XTILEDATA        (1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE    (XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
-
+#define XFEATURE_MASK_CET      ((1 << 11) | (1 << 12))
 
 static int __tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 {
@@ -72,12 +72,26 @@ static struct tdx_cpuid_data get_tdx_cpuid_data(struct kvm_vm *vm)
        for (i = 0; i < KVM_MAX_CPUID_ENTRIES; i++) {
                struct kvm_cpuid_entry2 *e = &cpuid_data.entries[i];
 
-               /* TDX doesn't support LBR and AMX features yet.
+               /* TDX doesn't support LBR yet.
                 * Disable those bits from the XCR0 register.
                 */
                if (e->function == 0xd && (e->index == 0)) {
                        e->eax &= ~XFEATURE_MASK_LBR;
-                       e->eax &= ~XFEATURE_MASK_XTILE;
+
+                       /*
+                        * TDX modules requires both CET_{U, S} to be set even
+                        * if only one is supported.
+                        */
+                       if (e->eax & XFEATURE_MASK_CET) {
+                               e->eax |= XFEATURE_MASK_CET;
+                       }
+                       /*
+                        * TDX module requires both XTILE_{CFG, DATA} to be set.
+                        * Both bits are required for AMX to be functional.
+                        */
+                       if ((e->eax & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+                               e->eax &= ~XFEATURE_MASK_XTILE;
+                       }
                }
        }

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
