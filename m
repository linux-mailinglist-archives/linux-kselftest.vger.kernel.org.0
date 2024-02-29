Return-Path: <linux-kselftest+bounces-5607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003986C37D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724BFB218AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3524A19;
	Thu, 29 Feb 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9dYnj1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090B1DDFF;
	Thu, 29 Feb 2024 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195472; cv=none; b=erCxV3RZq4m2QiafAe1/2N9l1VXOZiGuig5buetIP3sNv3+abJ0ras93zbbh8FxT5tDNfsxSUq7+9AeVKJSbL2KGHXBubind+m2lAwbvFgUpsqfsA4U98y5tRc+/rCZVpvK+Tg4hgbHj3YBm6S/Elo8nh0Fy5PSGlBwr/K9hWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195472; c=relaxed/simple;
	bh=OWd4fYTux+hAijsOgcO4XFq2Ff+muAy39DNVb8ggNhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZxSW7jiqJHzvfWSC+XO1iPVw708TavTxH4s1iy0DOCIUlLlSP1AM6p9hJA2XjyXpDG58oYvNDWJ2PNGKj/MV0Anw0eUuMQhqybMbVZCp89fl7pCdbIb1y/LygRfDca5O4u/PezjQ3p0A0ohZTEtSEQaKWQOvOX6DUl4ACrlXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9dYnj1p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709195471; x=1740731471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWd4fYTux+hAijsOgcO4XFq2Ff+muAy39DNVb8ggNhg=;
  b=K9dYnj1pLZ9QhlESdstErgjsph0SH5PzJP61nRYTQAALPGLAnO1t0gNe
   amQd6FLL/unD2183F5DnLFcrozs11EmlCKFxfUn7uAWlwx9o1z2xlG2gH
   rdumqEPNvNtTBRvVPc3Vawpb8lFtvUMRH/MNbEF1asOj7itfKfgUY3iKS
   v45acpxES9GMo8/IkXSFaizY5c7J2IFxlLC7vwMexdvq3vFSuU8msg0B0
   yQsk1K17AjgM7RnqYILqUASDazRV1snIRxRY5Xjs7lCwYZhEEZNSbpgHW
   1gQzJT6s/TiHQdlRzlIzsSxsS4TYZU5CDFtqi4thYY+1J0QbJtuc/adXD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4231409"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="4231409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="30923916"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.225.159]) ([10.124.225.159])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:31:04 -0800
Message-ID: <9ceaf8d8-383a-4989-b58e-727d70ed525b@linux.intel.com>
Date: Thu, 29 Feb 2024 16:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 06/29] KVM: selftests: TDX: Use
 KVM_TDX_CAPABILITIES to validate TDs' attribute configuration
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-7-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-7-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> This also exercises the KVM_TDX_CAPABILITIES ioctl.
>
> Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 69 ++++++++++++++++++-
>   1 file changed, 66 insertions(+), 3 deletions(-)

Nit: Can also dump 'supported_gpaw' in tdx_read_capabilities().

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index 9b69c733ce01..6b995c3f6153 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -27,10 +27,9 @@ static char *tdx_cmd_str[] = {
>   };
>   #define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
>   
> -static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
> +static int _tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
>   {
>   	struct kvm_tdx_cmd tdx_cmd;
> -	int r;
>   
>   	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
>   		    ioctl_no);
> @@ -40,11 +39,58 @@ static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
>   	tdx_cmd.flags = flags;
>   	tdx_cmd.data = (uint64_t)data;
>   
> -	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +}
> +
> +static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
> +{
> +	int r;
> +
> +	r = _tdx_ioctl(fd, ioctl_no, flags, data);
>   	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
>   		    errno);
>   }
>   
> +static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> +{
> +	int i;
> +	int rc = -1;
> +	int nr_cpuid_configs = 4;
> +	struct kvm_tdx_capabilities *tdx_cap = NULL;
> +
> +	do {
> +		nr_cpuid_configs *= 2;
> +
> +		tdx_cap = realloc(
> +			tdx_cap, sizeof(*tdx_cap) +
> +			nr_cpuid_configs * sizeof(*tdx_cap->cpuid_configs));
> +		TEST_ASSERT(tdx_cap != NULL,
> +			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
> +			    nr_cpuid_configs);
> +
> +		tdx_cap->nr_cpuid_configs = nr_cpuid_configs;
> +		rc = _tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
> +	} while (rc < 0 && errno == E2BIG);
> +
> +	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
> +		    rc, errno);
> +
> +	pr_debug("tdx_cap: attrs: fixed0 0x%016llx fixed1 0x%016llx\n"
> +		 "tdx_cap: xfam fixed0 0x%016llx fixed1 0x%016llx\n",
> +		 tdx_cap->attrs_fixed0, tdx_cap->attrs_fixed1,
> +		 tdx_cap->xfam_fixed0, tdx_cap->xfam_fixed1);
> +
> +	for (i = 0; i < tdx_cap->nr_cpuid_configs; i++) {
> +		const struct kvm_tdx_cpuid_config *config =
> +			&tdx_cap->cpuid_configs[i];
> +		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
> +			 i, config->leaf, config->sub_leaf,
> +			 config->eax, config->ebx, config->ecx, config->edx);
> +	}
> +
> +	return tdx_cap;
> +}
> +
>   #define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
>   
>   static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
> @@ -78,6 +124,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
>   	}
>   }
>   
> +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	/* TDX spec: any bits 0 in attrs_fixed0 must be 0 in attributes */
> +	TEST_ASSERT_EQ(attributes & ~tdx_cap->attrs_fixed0, 0);
> +
> +	/* TDX spec: any bits 1 in attrs_fixed1 must be 1 in attributes */
> +	TEST_ASSERT_EQ(attributes & tdx_cap->attrs_fixed1, tdx_cap->attrs_fixed1);
> +
> +	free(tdx_cap);
> +}
> +
>   static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
>   {
>   	const struct kvm_cpuid2 *cpuid;
> @@ -91,6 +152,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
>   	memset(init_vm, 0, sizeof(*init_vm));
>   	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>   
> +	tdx_check_attributes(vm, attributes);
> +
>   	init_vm->attributes = attributes;
>   
>   	tdx_apply_cpuid_restrictions(&init_vm->cpuid);


