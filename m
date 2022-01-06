Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1F486083
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 07:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiAFGSO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 01:18:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:15450 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbiAFGSN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 01:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641449893; x=1672985893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3jkJMJJH3hTPBzfkr/jc+jsdiPQPPhIDNwCKzGk62U=;
  b=VRspQErV2neUJm/dcNgfM5X+DU9vllirHCYOCrTKZwnUagvnm5mma+Ie
   ZGflDaAVIvO/b/sXJe4dHaMEcfUAiaukQp1YPo4Hzd0plsS8Pi9dAc8TR
   xs0zcRv0iFSC2iqIc9cdK9zB2Rm+MPEV1zUuU8B9ZiP4NZsI/xu+n6rNy
   BMZxhMJ/17IzZjWI81DhuUc4ihXDcBH8x0oSJtYCXVgFpteGIQPg9a1F2
   TNbQcmOwORMYMMtDhnu8GrgryzS2UmMkIuyONOxO020Z2bT+zMlhoFb8I
   X/vDNPBY+Sub7k2eNtv/zvjBTzUZ0wNfcM0ez60cdgnmqL54U5naqi4Ai
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223283124"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="223283124"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 22:18:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="621413992"
Received: from yangzhon-virtual.bj.intel.com (HELO yangzhon-Virtual) ([10.238.145.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Jan 2022 22:18:04 -0800
Date:   Thu, 6 Jan 2022 14:02:55 +0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v5 07/21] x86/fpu: Provide
 fpu_enable_guest_xfd_features() for KVM
Message-ID: <20220106060255.GA2395@yangzhon-Virtual>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-8-yang.zhong@intel.com>
 <c99d0b82-a44f-db8e-3f81-93d2394f9a02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99d0b82-a44f-db8e-3f81-93d2394f9a02@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022 at 02:06:40PM +0100, Paolo Bonzini wrote:
> On 1/5/22 13:35, Yang Zhong wrote:
> >+int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
> >+{
> >+	lockdep_assert_preemption_enabled();
> >+
> 
> The old fpu_update_guest_perm_features(guest_fpu) is equivalent to
> 
> 	fpu_enable_guest_xfd_features(guest_fpu, guest_fpu->perm);
> 
> Missing doc comment:
> 
> /*
>  * fpu_enable_guest_xfd_features - Enable xfeatures according to guest perm
>  * @guest_fpu:         Pointer to the guest FPU container
>  * @xfeatures:         Features requested by guest CPUID
>  *
>  * Enable all dynamic xfeatures according to guest perm and requested CPUID.
>  * Invoked if the caller wants to conservatively expand fpstate buffer instead
>  * of waiting until XCR0 or XFD MSR is written.
>  *
>  * Return: 0 on success, error code otherwise
>  */
> 
> Also, the check for 32-bit is slightly imprecise:
> 
> 	/* Dynamic xfeatures are not supported with 32-bit kernels. */
> 	if (!IS_ENABLED(CONFIG_X86_64))
> -		return 0;
> +		return -EINVAL;
> 
> since we only get here with xfeatures != 0 (if it compiles, just removing
> the IS_ENABLED check altogether would be even better).  With these changes,
> 

  Paolo, I did 32 bit kernel build tests

  (1). w/ IS_ENABLED(CONFIG_X86_64)

      if (!IS_ENABLED(CONFIG_X86_64))
      	return -EINVAL; 
    
     This 32 bit kernel can successfully build.

  (2). remove IS_ENABLED(CONFIG_X86_64)

      The 32 bit kernel build is failed, and the error as:

      ld: arch/x86/kernel/fpu/core.o: in function `fpu_enable_guest_xfd_features':
/root/amx/v5/kvm/arch/x86/kernel/fpu/core.c:278: undefined reference to `__xfd_enable_feature'

      Seems we need define 32 bit API for __xfd_enable_feature().

   I also tried (1) in desktop, but I could not reboot the machine after installed 32 bit kernel.

   thanks a lot!

   Yang 





> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks,
> 
> Paolo
