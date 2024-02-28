Return-Path: <linux-kselftest+bounces-5531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7486AFC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A403289501
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816B149DE2;
	Wed, 28 Feb 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RzXv6sUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59414691C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125424; cv=none; b=MapUnuAgsimp8eISb88cDw5yc7zRtzCbfb/R7xerf/gFN06lPfqvl2/mAPgj4x9fklYQpWpTeo/3LrvTFh6U0CLoFLwrcElEl0s+H/ZCeWQf0BDFMI2q7srZg1me0McWoYML8rNn1Z5G83TNQm+e36gr2jNFAqMxY3QnvR1/AOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125424; c=relaxed/simple;
	bh=49cG36IgRgH/aZMT+wxVEMhCBHfNfgfEAKJY6/++VIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOjhQc/BHnvUp+RRqpZhI8Avld4mtdgP1x/pZ9oP1x4WsNwwsdV4S3RtYmIEarHHdGzfCFwrNC+NPmQXqiJ3KMprQxTQCj6Pp0oz/odZw8beZaUCxZCXv5u3lmkCo8F9dceQVKyiXCbRuKIONqZVR9m1IdMwlY4eR9ebf4S/Mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RzXv6sUz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso7448596a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709125421; x=1709730221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFXQvGUsk1gt0qCtFqOPcrEsIWVhxYHprqeQMVcPhiQ=;
        b=RzXv6sUzkIVuiNF1plr7C20IEl7kjt+3ycnZRqDuy21Ns2qL0Fp2KX/YX0vO3Is9hK
         x2f+xgG31TRIVTtKxpJJRIgbVkKWV/EyHqtatJVF+T9mHhs/HIit5lYmPcMMfwLdS7Vc
         UggPTSokRy+SxZthJ4YbJmNDjAiR/9++iwZ6FxiJCFU5esamJ5kuM4au9XbwJvy42Rq4
         8Zm1z+b3xGFsyoFzPzyktnrrOTO9sQIn8itl+yXjzLp2u/V6iM3z4muwB09KsSZYUlxd
         VKN106MqyQYgqduXkt5bmkp0Sgd5Fx7mt+b0MLcxRXXsy9OYZV9nYnTUXLTFC4yzMLdY
         wggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125421; x=1709730221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFXQvGUsk1gt0qCtFqOPcrEsIWVhxYHprqeQMVcPhiQ=;
        b=TmTjAwQ+Mt1yVC81TjtdZzVAeAp6Y1sNSQnazhOBylMWr+gjpHP1g9UCdq+8Xtb8wD
         Ki7bUz8UDQ3+JPvnXL7fqEkIrXZ9Y0IK23Rpeo3tVqCSUOFZi+dfsah+LvYqRJ0Mz/RT
         Lb3TPVEIDzLnI1yrgLZlv6giF08jnb2S2DOeD04jeivbQWqHjwZCMP2GqEzEduBK2mc9
         /GB9vMIm/9G2q4glijMLcaT2JTdPudbtOo7/ivmOm7wRtoHYiU0RUDlO/eWE5bH4PD6s
         SjGU3fOjWScolFC8N1sP617hFtxm3QjgRN52D0HOVNJLE/OJSAOowojmFOSYK6mjwKC/
         U/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnVFJBKNgqy743enIWjX8aPCbbal55NSakt7IQf5frxS5eG/t4aigsp7xuuQWyIEu/XpAygVU3DHzm/4SM4pg+4YOM6kth8EI0uW7Y4lO
X-Gm-Message-State: AOJu0YyS+Eik14BoRSXbXJ9mZM3ji5Lwl6+8muW8WsdLRWLe0IbBldhP
	sMEcOgydBCl5unuzVn1U3Nm3TI6r7OA+oWDHSPq3/wMMl5Yk+I995uXzxHLIaDE=
X-Google-Smtp-Source: AGHT+IGvHaZpaUKN38zrJM3JDTNxolRHG6m9JTolps7oKVeZD8z9mLSzqZ67XkfY3F7ks+tZteHSgA==
X-Received: by 2002:aa7:d80e:0:b0:566:d15:1458 with SMTP id v14-20020aa7d80e000000b005660d151458mr4961658edq.21.1709125421040;
        Wed, 28 Feb 2024 05:03:41 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id fe9-20020a056402390900b0056470bf320asm500629edb.43.2024.02.28.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:03:40 -0800 (PST)
Date: Wed, 28 Feb 2024 14:03:39 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/5] RISC-V: KVM: Forward SEED CSR access to user space
Message-ID: <20240228-e87f7a9a9cf6fa701e621f41@orel>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
 <20240214123757.305347-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123757.305347-2-apatel@ventanamicro.com>

On Wed, Feb 14, 2024 at 06:07:53PM +0530, Anup Patel wrote:
> The SEED CSR access from VS/VU mode (guest) will always trap to
> HS-mode (KVM) when Zkr extension is available to the Guest/VM.
> 
> We must forward this CSR access to KVM user space so that it
> can be emulated based on the method chosen by VMM.
> 
> Fixes: f370b4e668f0 ("RISC-V: KVM: Allow scalar crypto extensions for Guest/VM")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_insn.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 7a6abed41bc1..ee7215f4071f 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -7,6 +7,8 @@
>  #include <linux/bitops.h>
>  #include <linux/kvm_host.h>
>  
> +#include <asm/cpufeature.h>
> +
>  #define INSN_OPCODE_MASK	0x007c
>  #define INSN_OPCODE_SHIFT	2
>  #define INSN_OPCODE_SYSTEM	28
> @@ -213,9 +215,20 @@ struct csr_func {
>  		    unsigned long wr_mask);
>  };
>  
> +static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
> +			unsigned long *val, unsigned long new_val,
> +			unsigned long wr_mask)
> +{
> +	if (!riscv_isa_extension_available(vcpu->arch.isa, ZKR))
> +		return KVM_INSN_ILLEGAL_TRAP;
> +
> +	return KVM_INSN_EXIT_TO_USER_SPACE;
> +}
> +
>  static const struct csr_func csr_funcs[] = {
>  	KVM_RISCV_VCPU_AIA_CSR_FUNCS
>  	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
> +	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
>  };
>  
>  /**
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

