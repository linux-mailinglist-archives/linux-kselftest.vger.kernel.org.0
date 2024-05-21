Return-Path: <linux-kselftest+bounces-10485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663728CB4EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 22:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8A1B21E4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A80763F1;
	Tue, 21 May 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpskQob3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891497F49F
	for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324709; cv=none; b=Ev1A7AEQLZNjsvVuyBbPhlAyaHsBEVErQdNJxcGK3fSzlNPvaHlbhze1WN7mnQ7IK+uUcL3mj2UkSiALViPkQfpUa9Z5u5zLz1H2936cqrR6jBsSgoddjCS5hHFnyg/RkEyZR8sURT82D9SCZZmpQykn6BHZgSKYJX5inx+1Iss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324709; c=relaxed/simple;
	bh=M71SjQ8CvyRceTtPag6Y8By8insDFpbiuLeOP7ClPOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=jEkY577uG5b9HKMxLSJDIJZPoZpviwaRnA0gJBkHTcR+zL0ksCcj2sWunoImEj56KXFp6Zub0d1Sw2jIR7ehnqM4g2ksADVFBhWqcFQtxZXWyOCzyLaoznuDHcPeBolgu/9QQrf1RwLyH5Jk9A8ZN3I3kzihGJRR24nu8PDgbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpskQob3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716324707; x=1747860707;
  h=message-id:date:mime-version:subject:from:to:references:
   cc:in-reply-to:content-transfer-encoding;
  bh=M71SjQ8CvyRceTtPag6Y8By8insDFpbiuLeOP7ClPOQ=;
  b=ZpskQob3YEmgPUXSEzsMmOC/1+I12xaZZEUGpAUNb4baGQbWtGsDVhBP
   CG0C3l9eeoh+lSCKhsRQek6f0C93uCSkg/CflpIcNY8nWt7dpldTWGTiL
   eEBD22eiAISDMMHzE/Sf4tjZ2Z8yu1DLdIQ08zmM/c6apNdFjxHfTTFsC
   UufFI8EA8tW4eea4YGDSq2JZwC8GkypQ9qfUzFtKvpH0NcWUzhDzMZZVA
   QHKsjpKgRn27X3MNOe6pb9plif3ZS58/Lckq7tPlJufNSENtT6GASupOM
   W2QlGI8mwmfiGlORwB8vCPDcvUmKoisuq6QfLHcxCnOMS+DYBvzp7DN9Z
   w==;
X-CSE-ConnectionGUID: zH7OljrtTWSLDD38sDz40g==
X-CSE-MsgGUID: c4QkcM8rT1eV1bw80NdsDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30069444"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="30069444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 13:51:47 -0700
X-CSE-ConnectionGUID: W+09VOujSmK3/xEtvREZbg==
X-CSE-MsgGUID: A8LQ9IAvS3OfBjgfgBN1dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37815893"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.124.104.52]) ([10.124.104.52])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 13:51:46 -0700
Message-ID: <57ef2e87-1119-4258-80b6-920b21dbcf98@intel.com>
Date: Tue, 21 May 2024 13:51:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: selftests: Fix nx_huge_pages_test for
 default_hugepagesz=1G
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
To: "<shuah"@kernel.org
References: <20240424224434.14166-1-dongsheng.x.zhang@intel.com>
Content-Language: en-US
Cc: linux-kselftest@vger.kernel.org
In-Reply-To: <20240424224434.14166-1-dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, Shuah,
Any comment on this series?

Thanks,
don

On 4/24/2024 3:44 PM, Dongsheng Zhang wrote:
> From: donsheng <dongsheng.x.zhang@intel.com>
> 
> If the host was booted with the "default_hugepagesz=1G" kernel command-line
> parameter, running the NX hugepage test will fail with error "Invalid argument"
> at the TEST_ASSERT line in kvm_util.c's __vm_mem_region_delete() function:
> static void __vm_mem_region_delete(struct kvm_vm *vm,
>                    struct userspace_mem_region *region,
>                    bool unlink)
> {
>     int ret;
>     ...
>     ret = munmap(region->mmap_start, region->mmap_size);
>     TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
>     ...
> }
> 
> NX hugepage test creates a VM with a data slot of 6M size backed with huge
> pages. If the default hugetlb page size is set to 1G, calling mmap() with
> MAP_HUGETLB and a length of 6M will succeed but calling its matching munmap()
> will fail. Documentation/admin-guide/mm/hugetlbpage.rst specifies this behavior:
> 
> "Syscalls that operate on memory backed by hugetlb pages only have their lengths
> aligned to the native page size of the processor; they will normally fail with
> errno set to EINVAL or exclude hugetlb pages that extend beyond the length if
> not hugepage aligned.  For example, munmap(2) will fail if memory is backed by
> a hugetlb page and the length is smaller than the hugepage size."
> 
> Explicitly use MAP_HUGE_2MB in conjunction with MAP_HUGETLB to fix the issue.
> 
> Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>
> Suggested-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> index 17bbb96fc4df..146e9033e206 100644
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> @@ -129,7 +129,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
>  
>  	vcpu = vm_vcpu_add(vm, 0, guest_code);
>  
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB,
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB,
>  				    HPAGE_GPA, HPAGE_SLOT,
>  				    HPAGE_SLOT_NPAGES, 0);
>  

