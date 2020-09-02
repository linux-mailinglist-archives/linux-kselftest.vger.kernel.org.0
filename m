Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3127825A2C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBBtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 21:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIBBtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 21:49:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37355C061244;
        Tue,  1 Sep 2020 18:49:17 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4Bh6LK5jm1z9sSJ; Wed,  2 Sep 2020 11:49:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1599011353; bh=hTaXmDx448oQYoyezs5f5Rukwes/5nA+Fn7vM9Nl0n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOsMu7X2nDHa6F7OzcSZVptEYMumaeL2UkBfmg7M3+JbgDG/3FWooN3c4DWto5Sft
         1Z27emBpzzXKPNtDQLGTVa2AMqqYC9XcDU3K2/tEaYeBQvjjwwNYZDPzEHlKW6O3rE
         G9cRpY3uUQZyK5xgKIrAHh6LywbCfTti69J8sNigC22VUC7u9fXd1tTF7gyB87KKK/
         gTnJtCaERj+NMBZgLfcMnGuIxf6gF90RM1xm25AVr3Soy4GuDuKzYd6Ko9tBIvrTql
         q/VAKEPeI5Dp8lmfixFxXTCo/SYUDSXVyLhJ2zkocUYVOWAVABWF2RiGURS1UCBa+x
         8fkzom8P1jefw==
Date:   Wed, 2 Sep 2020 11:49:08 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/watchpoint/kvm: Rename current DAWR macros
 and variables
Message-ID: <20200902014908.GA272502@thinks.paulus.ozlabs.org>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
 <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723102058.312282-2-ravi.bangoria@linux.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 03:50:52PM +0530, Ravi Bangoria wrote:
> Power10 is introducing second DAWR. Use real register names (with
> suffix 0) from ISA for current macros and variables used by kvm.

Most of this looks fine, but I think we should not change the existing
names in arch/powerpc/include/uapi/asm/kvm.h (and therefore also
Documentation/virt/kvm/api.rst).

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 426f94582b7a..4dc18fe6a2bf 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -2219,8 +2219,8 @@ registers, find a list below:
>    PPC     KVM_REG_PPC_BESCR               64
>    PPC     KVM_REG_PPC_TAR                 64
>    PPC     KVM_REG_PPC_DPDES               64
> -  PPC     KVM_REG_PPC_DAWR                64
> -  PPC     KVM_REG_PPC_DAWRX               64
> +  PPC     KVM_REG_PPC_DAWR0               64
> +  PPC     KVM_REG_PPC_DAWRX0              64
>    PPC     KVM_REG_PPC_CIABR               64
>    PPC     KVM_REG_PPC_IC                  64
>    PPC     KVM_REG_PPC_VTB                 64
...
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 264e266a85bf..38d61b73f5ed 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -608,8 +608,8 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_BESCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa7)
>  #define KVM_REG_PPC_TAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa8)
>  #define KVM_REG_PPC_DPDES	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa9)
> -#define KVM_REG_PPC_DAWR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> -#define KVM_REG_PPC_DAWRX	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
> +#define KVM_REG_PPC_DAWR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> +#define KVM_REG_PPC_DAWRX0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
>  #define KVM_REG_PPC_CIABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xac)
>  #define KVM_REG_PPC_IC		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xad)
>  #define KVM_REG_PPC_VTB		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xae)

The existing names are an API, and if you change them you will break
compilation of existing userspace programs.  I don't see that adding
the '0' on the end is so important that we need to break userspace.

Paul.
