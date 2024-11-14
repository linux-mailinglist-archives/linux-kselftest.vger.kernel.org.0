Return-Path: <linux-kselftest+bounces-21993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E699C80BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05696281F6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120EB1F4FB7;
	Thu, 14 Nov 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="21nS5M3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EA1F1304
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551092; cv=none; b=VqjK1gqvnZkVnInXDkIu506qqb4GCXZU1ZJmjsNO2cW2B7pIcnSjkvGp6GZbGeM/kUN5EiFQn9huYte+B6pNdJB7eJ9fQdB3CFpSfjSrhSi/Ec3fhEFooPHbgE5LYFbLogWvq7n30QMgeqQ2mCDvRm3Fuv9e788W5/jyOtts6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551092; c=relaxed/simple;
	bh=04s8nDoCSLpivX7fgLAtuIRzvTm1jQi5mR5RZ+R6pjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eragBjMuDmTax9aKugOT3mL3kf9Z63KNPv1DNSSE9Ybtgj2UhBP0xQKRYD3uNd6yKto1L7r6XbPZNpSYAia44TwdRdgPzQTD3qOuLlpYtyL4/xDLru8QzxnaS5U6QxEK8VneYehCSOjzapI0iaVPfy+g0nB5MtIL4VGW50O3QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=21nS5M3y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e6981ca77so990985ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731551089; x=1732155889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bOcIjTHmkKYE/MldB59+Mp7THVJA1dMXMhLp3+u7Zpk=;
        b=21nS5M3yK54DmA6u12c/sYhRVsS3FkR5a8Z4vLDh4l8dUJekGhoLQnnwzu7jo59W5k
         EvH2nCnZFEHImJHRh6rtVhXHAYEW889rgpkqGpz2feN5brv9hbWxbMohk25IjerzyBpx
         q3jWzut7bOvJR7YHyLdtICzvbB3I/oQDIIZ1GRmNYk9XR9aTGfEHFBlKkkHfLZ1a29Ps
         sl7Yd+bGquFs5lGpYGLLvhuR9F3rOmNX9gV8EYe1tjEJjUvlyA1C1txcW+RHim9tm3ID
         t/y+vvl17Xn7aF5ssGFW5YkfM4lZXJ2YFKSwVuPGN8fRQQus5aqIv5YBl2mWikuSlvSZ
         RXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731551089; x=1732155889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOcIjTHmkKYE/MldB59+Mp7THVJA1dMXMhLp3+u7Zpk=;
        b=JLQ6EqtsSKWn43NayWDA9sCyDq1TJ61ZPm1E10HuId/m/kahvawiJ4nzD7At8Do5jp
         Z/uRnsJVnvVZCHq9TKdIpPhrbUTA0vlbEuqHtLRzGzQW0yosanLmspTFhp7UGqJmQ5CT
         qVLlmPfSTvLkvjkolBan3ZYoz/sAFxZx1/RRj02gOlSEVMW0g7rKHBUOXdQdHiRzekj7
         5eMorXfpUxBXhvBWMD9pMEJuPtuS8ThvHDo1WX1G2h8iH9dpeBQtpG3yi8eSdYdppQ8m
         mypOrTOPdjnLkpf8zAMzaRayAAmqPtRKSjkAc0nPXZ4lJwBzmllsstxe+WXbjl7rtmMZ
         FiYg==
X-Forwarded-Encrypted: i=1; AJvYcCV8qWjL4jFpVBgDDeI4JXiWJP+H1M2VHOszV5Oh1Bh3sqyc8iy6H510ihasrozHYHXN7t2gDfOGIX5RE6o9FPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDJA6SrWvnDPn6hMHvJIO7vi1AOUQxTxsN7i1cmopbqfV1q3l
	smvFzBJXwm/ES4jWulgYIh6djiECr9X+3txiEvRvcENwSsGh8QF4IsHU+6nes3U=
X-Google-Smtp-Source: AGHT+IFIy/N8ljrKihYLsmstk+E2hofbr+iVsyyNJcXN7lh1fccE1mzDgwapJOQoIdXEKN3f21A9eg==
X-Received: by 2002:a17:903:2a8e:b0:20b:6d71:4140 with SMTP id d9443c01a7336-211b5d2a3b4mr74048485ad.44.1731551089470;
        Wed, 13 Nov 2024 18:24:49 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c2d520sm439875ad.29.2024.11.13.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:24:48 -0800 (PST)
Date: Wed, 13 Nov 2024 18:24:45 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v10 05/14] riscv: vector: Use vlenb from DT for thead
Message-ID: <ZzVfbS8-NizjKkst@ghost>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
 <tencent_2EF88DF37C4B82B2DA0B8E49B85C312E2108@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2EF88DF37C4B82B2DA0B8E49B85C312E2108@qq.com>

On Sun, Nov 10, 2024 at 03:34:54AM +0800, Yangyu Chen wrote:
> Hi Charlie,
> 
> I have tested this patchset with ghostwrite rebased to linux commit da4373fbcf ("Merge tag 'thermal-6.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") [1] on my D1 Nezha board, with defconfig + CONFIG_ERRATA_THEAD_GHOSTWRITE=n, I got this message during boot:
> 
> [    0.027584] Kernel panic - not syncing: __kmem_cache_create_args: Failed to create slab 'riscv_vector_ctx'. Error -22
> [    0.038057] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00310-gb276cf69df24-dirty #11
> [    0.047240] Hardware name: Allwinner D1 Nezha (DT)
> [    0.052007] Call Trace:
> [    0.054434] [<ffffffff80007172>] dump_backtrace+0x1c/0x24
> [    0.059806] [<ffffffff809f6834>] show_stack+0x2c/0x38
> [    0.064833] [<ffffffff80a040f0>] dump_stack_lvl+0x52/0x74
> [    0.070206] [<ffffffff80a04126>] dump_stack+0x14/0x1c
> [    0.075233] [<ffffffff809f6db6>] panic+0x10c/0x300
> [    0.080000] [<ffffffff8017b5a0>] __kmem_cache_create_args+0x24a/0x2b6
> [    0.086413] [<ffffffff80c04c68>] riscv_v_setup_ctx_cache+0x56/0x84
> [    0.092566] [<ffffffff80c04288>] arch_task_cache_init+0x10/0x1c
> [    0.098460] [<ffffffff80c07d02>] fork_init+0x68/0x1a8
> [    0.103486] [<ffffffff80c00ed2>] start_kernel+0x77e/0x822
> [    0.108870] ---[ end Kernel panic - not syncing: __kmem_cache_create_args: Failed to create slab 'riscv_vector_ctx'. Error -22 ]---
> 
> [1] https://github.com/cyyself/linux/tree/xtheadvector_20241110
> 
> On 9/12/24 13:55, Charlie Jenkins wrote:
> >  diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 682b3feee451..9775d6a9c8ee 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
> >  {
> >  	unsigned long this_vsize;
> >  -	/* There are 32 vector registers with vlenb length. */
> > +	/*
> > +	 * There are 32 vector registers with vlenb length.
> > +	 *
> > +	 * If the thead,vlenb property was provided by the firmware, use that
> > +	 * instead of probing the CSRs.
> > +	 */
> > +	if (thead_vlenb_of) {
> > +		this_vsize = thead_vlenb_of * 32;
> 
> Then, I patched here which replaces "this_vsize" with "riscv_v_vsize". The kernel boots normally and I can see “xtheadvector" in /proc/cpuinfo.
> 
> However, when I try to run the "v_exec_initval_nolibc" test, the kernel panics with these outputs:
> 
> [  978.788878] Oops - illegal instruction [#1]
> [  978.788897] Modules linked in:
> [  978.788908] CPU: 0 UID: 1000 PID: 461 Comm: v_exec_initval_ Not tainted 6.12.0-rc6-00310-gb276cf69df24-dirty #12
> [  978.788924] Hardware name: Allwinner D1 Nezha (DT)
> [  978.788929] epc : do_trap_ecall_u+0x56/0x20a
> [  978.788956]  ra : _new_vmalloc_restore_context_a0+0xc2/0xce
> [  978.788974] epc : ffffffff80a04afe ra : ffffffff80a0e742 sp : ffffffc6003fbeb0
> [  978.788983]  gp : ffffffff81717080 tp : ffffffd60723b300 t0 : ffffffff81001268
> [  978.788991]  t1 : ffffffff80a04aa8 t2 : ffffffff810012a8 s0 : ffffffc6003fbee0
> [  978.789000]  s1 : ffffffc6003fbee0 a0 : ffffffc6003fbee0 a1 : 000000000000005d
> [  978.789007]  a2 : 0000000000000000 a3 : ffffffffffffffda a4 : 0000000000000003
> [  978.789015]  a5 : 0000000000000000 a6 : 0000000002adb5fe a7 : 000000000000005d
> [  978.789022]  s2 : 00000000000108a8 s3 : 0000000000000000 s4 : 0000000000000008
> [  978.789030]  s5 : 0000003fb42ab780 s6 : 0000002adb5fe420 s7 : 0000002adb5fb9e0
> [  978.789038]  s8 : 0000002adb5fe440 s9 : 0000002adb5fe420 s10: 0000002adb572ad4
> [  978.789046]  s11: 0000002adb572ad0 t3 : 0000003fb43c5e3c t4 : 622f7273752f3d5f
> [  978.789053]  t5 : 0000002adb5fd5a1 t6 : 0000000002adb5ff
> [  978.789060] status: 8000000201800100 badaddr: 000000005e0fb057 cause: 0000000000000002
> [  978.789069] [<ffffffff80a04afe>] do_trap_ecall_u+0x56/0x20a
> [  978.789086] [<ffffffff80a0e742>] _new_vmalloc_restore_context_a0+0xc2/0xce
> [  978.789113] Code: a073 1007 006f 1a60 7057 0c30 57fd 17fe 77d7 0c30 (b057) 5e0f
> [  978.789123] ---[ end trace 0000000000000000 ]---
> [  978.789131] Kernel panic - not syncing: Fatal exception in interrupt
> [  978.937158] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> Is something wrong with my setup?

Thanks for reporting this! I just sent out a new version with the fix.
Something went wrong with the __riscv_v_vstate_discard() and was
triggering this failure. I have tested that this new version is able to
pass the testcase.

https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com/T/#t

- Charlie

> 
> Thanks,
> Yangyu Chen
> 
> > +		return 0;
> > +	}
> > +
> >  	riscv_v_enable();
> >  	this_vsize = csr_read(CSR_VLENB) * 32;
> >  	riscv_v_disable();
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
> > index 0f27baf8d245..519dbf70710a 100644
> > --- a/arch/riscv/kernel/vendor_extensions/thead.c
> > +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> > @@ -5,6 +5,7 @@
> >  #include <asm/vendor_extensions/thead.h>
> >    #include <linux/array_size.h>
> > +#include <linux/cpumask.h>
> >  #include <linux/types.h>
> >    /* All T-Head vendor extensions supported in Linux */
> > @@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
> >  	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> >  	.ext_data = riscv_isa_vendor_ext_thead,
> >  };
> > +
> > +void disable_xtheadvector(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
> > +
> > +	clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap.isa);
> > +}
> 

