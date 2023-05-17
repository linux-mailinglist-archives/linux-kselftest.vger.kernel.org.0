Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A48706627
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEQLHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEQLHW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 07:07:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117910E3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:06:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f450815d02so4458715e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684321601; x=1686913601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHibOxhRy8kN9AvhSOL0bsBVnNnX/fAscOpL7oGTKzk=;
        b=Ic3LCD/wKx/0IleHoLFdEVrimzoAC5FImH027Wz7gd+wue687oerJaifFTuCi3SF4W
         ZBBg8FO4btvO5Yddk3c8UGZZbtRHSG0iWRP/j9srquVuQgYT/zMU1Goqx2XwBUHjDGhQ
         rnL6fYGtO32dqJGRWg57muszuEj6bjLwvuthkn4DzWXQwUCZvaHc5eeZCSClIFTGm1H/
         n+u4DC/9AtgQpgX+k72he4mZqVNX5JTMe5s3wHdTTEs0A5gBREf5S6KHnvUzlJv5xBPe
         eMtXbC677jqhqwSpRBfhLcsGNwWRzlz+Wr20QHwnuWC+pWziPTG7CrmvRiKRNHMTMXGW
         nL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321601; x=1686913601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHibOxhRy8kN9AvhSOL0bsBVnNnX/fAscOpL7oGTKzk=;
        b=S3hek01Y0zS6NZx4k9wCKaWozi11tiqZ57INJ1gCiJb5u5LF7+sKx/BSlKV8vWU9LB
         MF0HmeV5s4JXsXxj8+2+tN15solt+Q5eZi9S/AO6+8iDkgY/yLHUjuIEEnyUWsCnOAql
         RrDZdPWk7MyFgxDddZCtSSOmk6li038HRglZzPyheWoK89JpPcO5D+GT2zmK0HYE3YHH
         Q/bziqMS9tUmIf+RlG7bk6GsCUAglGohMlvuubqXDvAVAU0yj76yVh0SS5CmTz7WlSPm
         CSIq3f/JtMzZy3fULeBXA3sHk6AijtPi9of95Xcyf6Z7+YeSX7MluRRsnf4Lx2v8ICU7
         DqvA==
X-Gm-Message-State: AC+VfDydlSSy6x1JzraV7VN4qldCHOyVhnPF8hsA8JB0ufUYKrNdiJk9
        zWmin7h8W50GrtNl3zB7+ejdyg==
X-Google-Smtp-Source: ACHHUZ7mZ6ToObSYnLojAO+FbW/0/Y6r/giIaDf4cPQe0tk9ENYAa1hfBeQvuTPMnL4vuwunvi13rw==
X-Received: by 2002:a05:600c:3657:b0:3f4:2267:10cf with SMTP id y23-20020a05600c365700b003f4226710cfmr22626781wmq.32.1684321600484;
        Wed, 17 May 2023 04:06:40 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a1c750c000000b003f17eaae2c9sm1983440wmc.1.2023.05.17.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:06:39 -0700 (PDT)
Date:   Wed, 17 May 2023 13:06:38 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Add riscv get-reg-list test
Message-ID: <20230511-28ec368a8168342c68ca2187@orel>
References: <cover.1683791148.git.haibo1.xu@intel.com>
 <751a84a9691c86df0e65cdb02abf1e073892d1ca.1683791148.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751a84a9691c86df0e65cdb02abf1e073892d1ca.1683791148.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 05:22:49PM +0800, Haibo Xu wrote:
> get-reg-list test is used to check for KVM registers regressions
> during VM migration which happens when destination host kernel
> missing registers that the source host kernel has. The blessed
> list registers was created by running on v6.2.

v6.2? But get-reg-list is getting introduced with this patch, so it'll
land in a 6.4 rc at the earliest. I don't see how can we generate the
initial blessed list with anything earlier?

> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   3 +
>  .../selftests/kvm/include/riscv/processor.h   |   3 +
>  .../selftests/kvm/riscv/get-reg-list.c        | 869 ++++++++++++++++++
>  3 files changed, 875 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 7a5ff646e7e7..fbb2e984297a 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -13,6 +13,8 @@ else ifeq ($(ARCH),arm64)
>  	ARCH_DIR := aarch64
>  else ifeq ($(ARCH),s390)
>  	ARCH_DIR := s390x
> +else ifeq ($(ARCH),riscv)
> +	ARCH_DIR := riscv
>  else
>  	ARCH_DIR := $(ARCH)
>  endif
> @@ -171,6 +173,7 @@ TEST_GEN_PROGS_s390x += rseq_test
>  TEST_GEN_PROGS_s390x += set_memory_region_test
>  TEST_GEN_PROGS_s390x += kvm_binary_stats_test
>  
> +TEST_GEN_PROGS_riscv += riscv/get-reg-list
>  TEST_GEN_PROGS_riscv += demand_paging_test
>  TEST_GEN_PROGS_riscv += dirty_log_test
>  TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index d00d213c3805..0adf9cb34126 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -38,6 +38,9 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>  					     KVM_REG_RISCV_TIMER_REG(name), \
>  					     KVM_REG_SIZE_U64)
>  
> +#define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
> +					     idx, KVM_REG_SIZE_U64)

                                                  ^ KVM_REG_SIZE_ULONG

> +
>  /* L3 index Bit[47:39] */
>  #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
>  #define PGTBL_L3_INDEX_SHIFT			39
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> new file mode 100644
> index 000000000000..dec1df0c6e72
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -0,0 +1,869 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Check for KVM_GET_REG_LIST regressions.
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + * Copyright (c) 2023 Intel Corporation
> + *
> + * The test was port from the get-reg-list.c on aarch64.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "processor.h"
> +
> +static struct kvm_reg_list *reg_list;
> +static __u64 *blessed_reg, blessed_n;
> +
> +struct reg_sublist {
> +	const char *name;
> +	long capability;
> +	__u64 *regs;
> +	__u64 regs_n;
> +	__u64 *rejects_set;
> +	__u64 rejects_set_n;
> +};
> +
> +struct vcpu_config {
> +	char *name;
> +	struct reg_sublist sublists[];
> +};
> +
> +static struct vcpu_config *vcpu_configs[];
> +static int vcpu_configs_n;
> +
> +#define for_each_sublist(c, s)						\
> +	for ((s) = &(c)->sublists[0]; (s)->regs; ++(s))
> +
> +#define for_each_reg(i)								\
> +	for ((i) = 0; (i) < reg_list->n; ++(i))
> +
> +#define for_each_missing_reg(i)						\
> +	for ((i) = 0; (i) < blessed_n; ++(i))			\
> +		if (!find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
> +
> +#define for_each_new_reg(i)							\
> +	for_each_reg(i)									\
> +		if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
> +
> +static const char *config_name(struct vcpu_config *c)
> +{
> +	struct reg_sublist *s;
> +	int len = 0;
> +
> +	if (c->name)
> +		return c->name;
> +
> +	for_each_sublist(c, s)
> +		len += strlen(s->name) + 1;
> +
> +	c->name = malloc(len);
> +
> +	len = 0;
> +	for_each_sublist(c, s) {
> +		if (!strcmp(s->name, "base"))
> +			continue;
> +		strcat(c->name + len, s->name);
> +		len += strlen(s->name) + 1;
> +		c->name[len - 1] = '+';
> +	}
> +	c->name[len - 1] = '\0';
> +
> +	return c->name;
> +}
> +
> +static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_regs; ++i)
> +		if (reg == regs[i])
> +			return true;
> +	return false;
> +}
> +
> +static const char *str_with_index(const char *template, __u64 index)
> +{
> +	char *str, *p;
> +	int n;
> +
> +	str = strdup(template);
> +	p = strstr(str, "##");
> +	n = sprintf(p, "%lld", index);
> +	strcat(p + n, strstr(template, "##") + 2);
> +
> +	return (const char *)str;
> +}
> +
> +#define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
> +
> +static const char *config_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CONFIG);
> +
> +	/*
> +	 * reg_off is the offset into struct kvm_riscv_config
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_CONFIG_REG(isa):
> +		return "KVM_REG_RISCV_CONFIG_REG(isa)";
> +	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> +		return "KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)";
> +	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> +		return "KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)";
> +	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> +		return "KVM_REG_RISCV_CONFIG_REG(mvendorid)";
> +	case KVM_REG_RISCV_CONFIG_REG(marchid):
> +		return "KVM_REG_RISCV_CONFIG_REG(marchid)";
> +	case KVM_REG_RISCV_CONFIG_REG(mimpid):
> +		return "KVM_REG_RISCV_CONFIG_REG(mimpid)";
> +	default:
> +		/* Config regs would grow regularly with new pseudo reg added, so
> +		 * just show "##UNKNOWN##" to indicate a new pseudo config reg.
> +		 */
> +		printf("%s: Unknown config reg id: 0x%llx", config_name(c), id);
> +		return "##UNKNOWN##";

The idea of these *to_str functions is to dump output that can be
copy+pasted into a reg array (hence the trailing commas in print_reg
lines). So we can't just print random lines here or return '##UNKOWN##',
as that won't compile. Instead, the default should return

  str_with_index("KVM_REG_RISCV_CONFIG_REG(##)", reg_off)

> +	}
> +}
> +
> +static const char *core_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CORE);
> +
> +	/*
> +	 * reg_off is the offset into struct kvm_riscv_core
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_CORE_REG(regs.pc):
> +		return "KVM_REG_RISCV_CORE_REG(regs.pc)";
> +	case KVM_REG_RISCV_CORE_REG(regs.ra) ...
> +	     KVM_REG_RISCV_CORE_REG(regs.t6):
> +		return str_with_index("KVM_REG_RISCV_CORE_REG(regs.regs[##])", reg_off);
> +	case KVM_REG_RISCV_CORE_REG(mode):
> +		return "KVM_REG_RISCV_CORE_REG(mode)";
> +	}
> +
> +	TEST_FAIL("%s: Unknown core reg id: 0x%llx", config_name(c), id);
> +	return NULL;
> +}
> +
> +static const char *general_csr_id_to_str(__u64 reg_off)
> +{
> +	/*
> +	 * reg_off is the offset into struct kvm_riscv_csr
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_CSR_REG(sstatus):
> +		return "KVM_REG_RISCV_CSR_REG(sstatus)";

We also need the subtype. So this should be something like

 #define CSR_GENERAL(csr) \
     "KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"

  return CSR_GENERAL(sstatus);

and similar below for the AIA CSRs.

> +	case KVM_REG_RISCV_CSR_REG(sie):
> +		return "KVM_REG_RISCV_CSR_REG(sie)";
> +	case KVM_REG_RISCV_CSR_REG(stvec):
> +		return "KVM_REG_RISCV_CSR_REG(stvec)";
> +	case KVM_REG_RISCV_CSR_REG(sscratch):
> +		return "KVM_REG_RISCV_CSR_REG(sscratch)";
> +	case KVM_REG_RISCV_CSR_REG(sepc):
> +		return "KVM_REG_RISCV_CSR_REG(sepc)";
> +	case KVM_REG_RISCV_CSR_REG(scause):
> +		return "KVM_REG_RISCV_CSR_REG(scause)";
> +	case KVM_REG_RISCV_CSR_REG(stval):
> +		return "KVM_REG_RISCV_CSR_REG(stval)";
> +	case KVM_REG_RISCV_CSR_REG(sip):
> +		return "KVM_REG_RISCV_CSR_REG(sip)";
> +	case KVM_REG_RISCV_CSR_REG(satp):
> +		return "KVM_REG_RISCV_CSR_REG(satp)";
> +	case KVM_REG_RISCV_CSR_REG(scounteren):
> +		return "KVM_REG_RISCV_CSR_REG(scounteren)";
> +	default:
> +		TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
> +		return NULL;

nit: It'd be nice to have a pattern for this TEST_FAIL. Either
outside the switch and not have a default or always the default.
It seems to be changing function by function.

> +	}
> +}
> +
> +static const char *aia_csr_id_to_str(__u64 reg_off)
> +{
> +	/*
> +	 * reg_off is the offset into struct kvm_riscv_aia_csr
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_CSR_AIA_REG(siselect):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(siselect)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(iprio1):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(iprio1)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(iprio2):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(iprio2)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(sieh):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(sieh)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(siph):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(siph)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(iprio1h)";
> +	case KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
> +		return "KVM_REG_RISCV_CSR_AIA_REG(iprio2h)";
> +	default:
> +		TEST_FAIL("Unknown aia csr reg: 0x%llx", reg_off);
> +		return NULL;
> +	}
> +}
> +
> +static const char *csr_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CSR);
> +	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +	switch (reg_subtype) {
> +	case KVM_REG_RISCV_CSR_GENERAL:
> +		return general_csr_id_to_str(reg_off);
> +	case KVM_REG_RISCV_CSR_AIA:
> +		return aia_csr_id_to_str(reg_off);
> +	default:
> +		TEST_FAIL("%s: Unknown csr reg id: 0x%llx", config_name(c), id);

Maybe better to report "unknown subtype"?

> +		return NULL;
> +	}
> +}
> +
> +static const char *timer_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_TIMER);
> +
> +	/*
> +	 * reg_off is the offset into struct kvm_riscv_timer
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_TIMER_REG(frequency):
> +		return "KVM_REG_RISCV_TIMER_REG(frequency)";
> +	case KVM_REG_RISCV_TIMER_REG(time):
> +		return "KVM_REG_RISCV_TIMER_REG(time)";
> +	case KVM_REG_RISCV_TIMER_REG(compare):
> +		return "KVM_REG_RISCV_TIMER_REG(compare)";
> +	case KVM_REG_RISCV_TIMER_REG(state):
> +		return "KVM_REG_RISCV_TIMER_REG(state)";
> +	}
> +
> +	TEST_FAIL("%s: Unknown timer reg id: 0x%llx", config_name(c), id);
> +	return NULL;
> +}
> +
> +static const char *fp_f_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_FP_F);
> +
> +	/*
> +	 * reg_off is the offset into struct __riscv_f_ext_state
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_FP_F_REG(f[0]) ...
> +	     KVM_REG_RISCV_FP_F_REG(f[31]):
> +		return str_with_index("KVM_REG_RISCV_FP_F_REG(f[##])", reg_off);
> +	case KVM_REG_RISCV_FP_F_REG(fcsr):
> +		return "KVM_REG_RISCV_FP_F_REG(fcsr)";
> +	}
> +
> +	TEST_FAIL("%s: Unknown fp_f reg id: 0x%llx", config_name(c), id);
> +	return NULL;
> +}
> +
> +static const char *fp_d_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_FP_D);
> +
> +	/*
> +	 * reg_off is the offset into struct __riscv_d_ext_state
> +	 */
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_FP_D_REG(f[0]) ...
> +	     KVM_REG_RISCV_FP_D_REG(f[31]):
> +		return str_with_index("KVM_REG_RISCV_FP_D_REG(f[##])", reg_off);
> +	case KVM_REG_RISCV_FP_D_REG(fcsr):
> +		return "KVM_REG_RISCV_FP_D_REG(fcsr)";
> +	}
> +
> +	TEST_FAIL("%s: Unknown fp_d reg id: 0x%llx", config_name(c), id);
> +	return NULL;
> +}
> +
> +static const char *isa_ext_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	/*
> +	 * reg_off is the offset into unsigned long kvm_isa_ext_arr[]
> +	 */
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_ISA_EXT);
> +
> +	static const char * const kvm_isa_ext_reg_name[] = {
> +		"KVM_RISCV_ISA_EXT_A",
> +		"KVM_RISCV_ISA_EXT_C",
> +		"KVM_RISCV_ISA_EXT_D",
> +		"KVM_RISCV_ISA_EXT_F",
> +		"KVM_RISCV_ISA_EXT_H",
> +		"KVM_RISCV_ISA_EXT_I",
> +		"KVM_RISCV_ISA_EXT_M",
> +		"KVM_RISCV_ISA_EXT_SVPBMT",
> +		"KVM_RISCV_ISA_EXT_SSTC",
> +		"KVM_RISCV_ISA_EXT_SVINVAL",
> +		"KVM_RISCV_ISA_EXT_ZIHINTPAUSE",
> +		"KVM_RISCV_ISA_EXT_ZICBOM",
> +		"KVM_RISCV_ISA_EXT_ZICBOZ",
> +		"KVM_RISCV_ISA_EXT_ZBB",
> +		"KVM_RISCV_ISA_EXT_SSAIA",
> +	};
> +
> +	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
> +		/* isa_ext regs would grow regularly with new isa extension added, so
> +		 * just show "##UNKNOWN##" to indicate a new extension.
> +		 */
> +		printf("%s: Unsupported isa ext reg id 0x%llx", config_name(c), id);
> +		return "##UNKNOWN##";

This should be

  return str_with_index("##", id);

so it can compile.

> +	}
> +
> +	return kvm_isa_ext_reg_name[reg_off];
> +}
> +
> +static const char *sbi_ext_single_id_to_str(__u64 reg_off)
> +{
> +	/*
> +	 * reg_off is KVM_RISCV_SBI_EXT_ID
> +	 */
> +	static const char * const kvm_sbi_ext_reg_name[] = {
> +		"KVM_RISCV_SBI_EXT_V01",
> +		"KVM_RISCV_SBI_EXT_TIME",
> +		"KVM_RISCV_SBI_EXT_IPI",
> +		"KVM_RISCV_SBI_EXT_RFENCE",
> +		"KVM_RISCV_SBI_EXT_SRST",
> +		"KVM_RISCV_SBI_EXT_HSM",
> +		"KVM_RISCV_SBI_EXT_PMU",
> +		"KVM_RISCV_SBI_EXT_EXPERIMENTAL",
> +		"KVM_RISCV_SBI_EXT_VENDOR",
> +	};
> +
> +	if (reg_off >= KVM_RISCV_SBI_EXT_MAX) {
> +		/* sbi_ext regs would grow regularly with new sbi extension added, so
> +		 * just show "##UNKNOWN##" to indicate a new extension.
> +		 */
> +		printf("Unsupported sbi ext single reg 0x%llx", reg_off);
> +		return "##UNKNOWN##";

  return str_with_index("##", id);

> +	}
> +
> +	return kvm_sbi_ext_reg_name[reg_off];
> +}
> +
> +static const char *sbi_ext_multi_id_to_str(__u64 reg_subtype, __u64 reg_off)
> +{
> +	if (reg_off > KVM_REG_RISCV_SBI_MULTI_REG_LAST) {
> +		/* sbi_ext regs would grow regularly with new sbi extension added, so
> +		 * just show "##UNKNOWN##" to indicate a new extension.

It'll only grow every 64 SBI extensions, so it won't be very regular.

> +		 */
> +		printf("Unsupported sbi ext multi reg: 0x%llx", reg_off);
> +		return "##UNKNOWN##";
> +	}
> +
> +	switch (reg_subtype) {
> +	case KVM_REG_RISCV_SBI_MULTI_EN:
> +		return str_with_index("KVM_RISCV_SBI_MULTI_EN[##]", reg_off);

KVM_RISCV_SBI_MULTI_EN[] doesn't exist, so that won't compile. This should
be

  str_with_index("KVM_REG_RISCV_SBI_MULTI_EN | ##", reg_off)

> +	case KVM_REG_RISCV_SBI_MULTI_DIS:
> +		return str_with_index("KVM_RISCV_SBI_MULTI_DIS[##]", reg_off);

  str_with_index("KVM_REG_RISCV_SBI_MULTI_DIS | ##", reg_off)

> +	}
> +
> +	return NULL;
> +}
> +
> +static const char *sbi_ext_id_to_str(struct vcpu_config *c, __u64 id)
> +{
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI_EXT);
> +	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
> +
> +	switch (reg_subtype) {
> +	case KVM_REG_RISCV_SBI_SINGLE:
> +		return sbi_ext_single_id_to_str(reg_off);
> +	case KVM_REG_RISCV_SBI_MULTI_EN:
> +	case KVM_REG_RISCV_SBI_MULTI_DIS:
> +		return sbi_ext_multi_id_to_str(reg_subtype, reg_off);
> +	}
> +
> +	TEST_FAIL("%s: Unknown sbi ext reg id: 0x%llx", config_name(c), id);

Maybe better to report "unknown subtype"?

> +	return NULL;
> +}
> +
> +static void print_reg(struct vcpu_config *c, __u64 id)
> +{
> +	const char *reg_size = NULL;
> +
> +	TEST_ASSERT((id & KVM_REG_ARCH_MASK) == KVM_REG_RISCV,
> +		    "%s: KVM_REG_RISCV missing in reg id: 0x%llx", config_name(c), id);
> +
> +	switch (id & KVM_REG_SIZE_MASK) {
> +	case KVM_REG_SIZE_U32:
> +		reg_size = "KVM_REG_SIZE_U32";
> +		break;
> +	case KVM_REG_SIZE_U64:
> +		reg_size = "KVM_REG_SIZE_U64";
> +		break;
> +	case KVM_REG_SIZE_U128:
> +		reg_size = "KVM_REG_SIZE_U128";
> +		break;
> +	default:
> +		TEST_FAIL("%s: Unexpected reg size: 0x%llx in reg id: 0x%llx",
> +			  config_name(c), (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id);
> +	}
> +
> +	switch (id & KVM_REG_RISCV_TYPE_MASK) {
> +	case KVM_REG_RISCV_CONFIG:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CONFIG | %s,\n",
> +				reg_size, config_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_CORE:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CORE | %s,\n",
> +				reg_size, core_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_CSR:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CSR | %s,\n",
> +				reg_size, csr_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_TIMER:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_TIMER | %s,\n",
> +				reg_size, timer_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_FP_F:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_F | %s,\n",
> +				reg_size, fp_f_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_FP_D:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n",
> +				reg_size, fp_d_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_ISA_EXT:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s,\n",
> +				reg_size, isa_ext_id_to_str(c, id));
> +		break;
> +	case KVM_REG_RISCV_SBI_EXT:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s,\n",
> +				reg_size, sbi_ext_id_to_str(c, id));
> +		break;
> +	default:
> +		TEST_FAIL("%s: Unexpected reg type: 0x%llx in reg id: 0x%llx", config_name(c),
> +				(id & KVM_REG_RISCV_TYPE_MASK) >> KVM_REG_RISCV_TYPE_SHIFT, id);
> +	}
> +}
> +
> +static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, long cap)
> +{
> +	int ret;
> +	unsigned long value;
> +
> +	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(cap), &value);
> +	if (ret) {
> +		printf("Failed to get cap %ld", cap);
> +		return false;
> +	}
> +
> +	return !!value;
> +}
> +
> +static void check_supported(struct kvm_vcpu *vcpu, struct vcpu_config *c)
> +{
> +	struct reg_sublist *s;
> +
> +	for_each_sublist(c, s) {
> +		if (!s->capability)
> +			continue;
> +
> +		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->capability),
> +			       "%s: %s not available, skipping tests\n",
> +			       config_name(c), s->name);
> +	}
> +}
> +
> +static bool print_list;
> +
> +static void run_test(struct vcpu_config *c)
> +{
> +	int new_regs = 0, missing_regs = 0, i, n;
> +	int failed_get = 0, failed_set = 0;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct reg_sublist *s;
> +
> +	vm = vm_create_barebones();
> +	vcpu = __vm_vcpu_add(vm, 0);
> +
> +	check_supported(vcpu, c);
> +
> +	reg_list = vcpu_get_reg_list(vcpu);
> +
> +	if (print_list) {
> +		putchar('\n');
> +		for_each_reg(i) {
> +			__u64 id = reg_list->reg[i];
> +
> +			if (print_list)
> +				print_reg(c, id);
> +		}
> +		putchar('\n');
> +		return;
> +	}
> +
> +	/*
> +	 * We only test that we can get the register and then write back the
> +	 * same value.
> +	 */
> +	for_each_reg(i) {
> +		uint8_t addr[128 / 8];
> +		struct kvm_one_reg reg = {
> +			.id = reg_list->reg[i],
> +			.addr = (__u64)&addr,
> +		};
> +		bool reject_reg = false;
> +		int ret;
> +
> +		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
> +		if (ret) {
> +			printf("%s: Failed to get ", config_name(c));
> +			print_reg(c, reg.id);
> +			putchar('\n');
> +			++failed_get;
> +		}
> +
> +		/* rejects_set registers are skipped for setting test */
> +		for_each_sublist(c, s) {
> +			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
> +				reject_reg = true;
> +				break;
> +			}
> +		}
> +
> +		if (!reject_reg) {
> +			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> +			/* Registers that don't support set operation should pass */
> +			if (ret && errno != EOPNOTSUPP) {
> +				printf("%s: Failed to set ", config_name(c));
> +				print_reg(c, reg.id);
> +				putchar('\n');
> +				++failed_set;
> +			}
> +		}
> +	}
> +
> +	for_each_sublist(c, s)
> +		blessed_n += s->regs_n;
> +	blessed_reg = calloc(blessed_n, sizeof(__u64));
> +
> +	n = 0;
> +	for_each_sublist(c, s) {
> +		for (i = 0; i < s->regs_n; ++i)
> +			blessed_reg[n++] = s->regs[i];
> +	}
> +
> +	for_each_new_reg(i)
> +		++new_regs;
> +
> +	for_each_missing_reg(i)
> +		++missing_regs;
> +
> +	if (new_regs || missing_regs) {
> +		printf("%s: Number blessed registers: %5lld\n", config_name(c), blessed_n);
> +		printf("%s: Number registers:         %5lld\n", config_name(c), reg_list->n);
> +	}
> +
> +	if (new_regs) {
> +		printf("\n%s: There are %d new registers.\n"
> +		       "Consider adding them to the blessed reg "
> +		       "list with the following lines:\n\n", config_name(c), new_regs);
> +		for_each_new_reg(i)
> +			print_reg(c, reg_list->reg[i]);
> +		putchar('\n');
> +	}
> +
> +	if (missing_regs) {
> +		printf("\n%s: There are %d missing registers.\n"
> +		       "The following lines are missing registers:\n\n",
> +				config_name(c), missing_regs);
> +		for_each_missing_reg(i)
> +			print_reg(c, blessed_reg[i]);
> +		putchar('\n');
> +	}
> +
> +	TEST_ASSERT(!missing_regs && !failed_get && !failed_set,
> +		    "%s: There are %d missing registers; "
> +		    "%d registers failed get; %d registers failed set.",
> +		    config_name(c), missing_regs, failed_get, failed_set);
> +
> +	pr_info("%s: PASS\n", config_name(c));
> +	blessed_n = 0;
> +	free(blessed_reg);
> +	free(reg_list);
> +	kvm_vm_free(vm);
> +}
> +
> +static void help(void)
> +{
> +	struct vcpu_config *c;
> +	int i;
> +
> +	printf(
> +	"\n"
> +	"usage: get-reg-list [--config=<selection>] [--list]\n\n"
> +	" --config=<selection>        Used to select a specific vcpu configuration for the test/listing\n"
> +	"                             '<selection>' may be\n");
> +
> +	for (i = 0; i < vcpu_configs_n; ++i) {
> +		c = vcpu_configs[i];
> +		printf(
> +	"                               '%s'\n", config_name(c));
> +	}
> +
> +	printf(
> +	"\n"
> +	" --list                      Print the register list rather than test it (requires --config)\n"
> +	"\n"
> +	);
> +}
> +
> +static struct vcpu_config *parse_config(const char *config)
> +{
> +	struct vcpu_config *c;
> +	int i;
> +
> +	if (config[8] != '=')
> +		help(), exit(1);
> +
> +	for (i = 0; i < vcpu_configs_n; ++i) {
> +		c = vcpu_configs[i];
> +		if (strcmp(config_name(c), &config[9]) == 0)
> +			break;
> +	}
> +
> +	if (i == vcpu_configs_n)
> +		help(), exit(1);
> +
> +	return c;
> +}
> +
> +int main(int ac, char **av)
> +{
> +	struct vcpu_config *c, *sel = NULL;
> +	int i, ret = 0;
> +	pid_t pid;
> +
> +	for (i = 1; i < ac; ++i) {
> +		if (strncmp(av[i], "--config", 8) == 0)
> +			sel = parse_config(av[i]);
> +		else if (strcmp(av[i], "--list") == 0)
> +			print_list = true;
> +		else if (strcmp(av[i], "--help") == 0 || strcmp(av[1], "-h") == 0)
> +			help(), exit(0);
> +		else
> +			help(), exit(1);
> +	}
> +
> +	if (print_list) {
> +		/*
> +		 * We only want to print the register list of a single config.
> +		 */
> +		if (!sel)
> +			help(), exit(1);
> +	}
> +
> +	for (i = 0; i < vcpu_configs_n; ++i) {
> +		c = vcpu_configs[i];
> +		if (sel && c != sel)
> +			continue;
> +
> +		pid = fork();
> +
> +		if (!pid) {
> +			run_test(c);
> +			exit(0);
> +		} else {
> +			int wstatus;
> +			pid_t wpid = wait(&wstatus);
> +
> +			TEST_ASSERT(wpid == pid && WIFEXITED(wstatus), "wait: Unexpected return");
> +			if (WEXITSTATUS(wstatus) && WEXITSTATUS(wstatus) != KSFT_SKIP)
> +				ret = KSFT_FAIL;
> +		}
> +	}
> +
> +	return ret;
> +}

We should share all the code above, except print_reg(), with aarch64.
I'll send a patch series that splits the arch-neutral code out of
the aarch64 test that you can base this test on.

> +
> +/*
> + * The current blessed list was primed with the output of kernel version
> + * v6.2 and then later updated with new registers.
> + */
> +static __u64 base_regs[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(isa),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(mvendorid),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(marchid),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(mimpid),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.pc),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.ra),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.sp),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.gp),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.tp),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t0),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t1),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t2),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s0),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s1),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a0),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a1),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a2),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a3),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a4),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a5),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a6),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a7),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s2),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s3),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s4),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s5),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s6),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s7),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s8),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s9),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s10),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s11),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t3),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t4),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t5),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t6),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(mode),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(sstatus),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(sie),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(stvec),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(sscratch),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(sepc),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(scause),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(stval),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(sip),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(satp),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_REG(scounteren),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM,

Any register that depends on the host having the extension, like zicbom,
means it shouldn't be in the base register set.

> +};
> +
> +/*
> + * The rejects_set list registers that should skip set test.
> + *  - KVM_REG_RISCV_TIMER_REG(state): set would fail if it was not initialized properly.
> + */
> +static __u64 base_rejects_set[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
> +};
> +
> +static __u64 fp_f_regs[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[0]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[1]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[2]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[3]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[4]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[5]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[6]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[7]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[8]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[9]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[10]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[11]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[12]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[13]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[14]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[15]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[16]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[17]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[18]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[19]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[20]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[21]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[22]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[23]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[24]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[25]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[26]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[27]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[28]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[29]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[30]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[31]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(fcsr),
> +};
> +
> +static __u64 fp_d_regs[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[0]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[1]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[2]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[3]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[4]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[5]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[6]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[7]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[8]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[9]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[10]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[11]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[12]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[13]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[14]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[15]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[16]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[17]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[18]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[19]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[20]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[21]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[22]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[23]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[24]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[25]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[26]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[27]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[28]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[29]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[30]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[31]),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(fcsr),
> +};
> +
> +#define BASE_SUBLIST \
> +	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), .rejects_set = base_rejects_set, \
> +		.rejects_set_n = ARRAY_SIZE(base_rejects_set),}
> +#define FP_F_REGS_SUBLIST \
> +	{"fp_f_regs", .capability = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
> +		.regs_n = ARRAY_SIZE(fp_f_regs),}
> +#define FP_D_REGS_SUBLIST \
> +	{"fp_d_regs", .capability = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
> +		.regs_n = ARRAY_SIZE(fp_d_regs),}
> +
> +static struct vcpu_config fp_f_d_config = {
> +	.sublists = {
> +	BASE_SUBLIST,
> +	FP_F_REGS_SUBLIST,
> +	FP_D_REGS_SUBLIST,
> +	{0},
> +	},
> +};
> +
> +static struct vcpu_config *vcpu_configs[] = {
> +	&fp_f_d_config,
> +};
> +static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> -- 
> 2.34.1
>

Thanks,
drew
