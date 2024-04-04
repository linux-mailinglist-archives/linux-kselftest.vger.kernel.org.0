Return-Path: <linux-kselftest+bounces-7224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DB898E70
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82B428B4B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B2131E41;
	Thu,  4 Apr 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oil0Tc1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243241B7F4
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257096; cv=none; b=jd437NuA1JvjqvlEQ2Yns50AtWnM6wCPHH+O6uTtuOdtJ+tB0WPSdEqAYn4w6iWiNcFmgEfVRX2qmG27pcUCzqpzjEuPa05EOO3eSMb2XoOnN0FCYZK5+RBUxaHGhgepetyHG9WctqmWgIpVq85im19I4kuCNPvFyUMIlZPFSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257096; c=relaxed/simple;
	bh=bW+qYJIcgCeHhAAtpvbzFnMst/WuvYdclKU+v5/Rbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bed8ZCMNg6ogCLk2t7xXn4akVNA/8KUWiOotAG08mxj+By4EJNcgBqEJykYf4klg+48eK7ZRFKd9IQEmV7zei3qHKouXMqT8srCXVD4tMOCs/jDxs2U8Z3hdVdobusNfLymrhiiwH5gDFEYECZ6grMuRDdjYuPmN2NP7uEeZVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oil0Tc1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712257093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iUpAfMHg+laFfCU8zqN8B3PSMZVWl02POndufzeitW0=;
	b=Oil0Tc1HvnWGuD8vpAxluoDjs1d49z5KiAOvm8Hml0fDVdk6b7QPGp7ImQVk2DTQ9B9f1R
	hC3nzFPSdm/8gUWk7slih3L6GqmXmR9jJiZ22oiZZdRksF1TAGjWeT3VeU/iduWRgSnGP0
	KR1X5kueqtFNpU0rk6GLS7IPZzx4IIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-aCzY9ktvMxqHdCdi1WBT2A-1; Thu, 04 Apr 2024 14:58:11 -0400
X-MC-Unique: aCzY9ktvMxqHdCdi1WBT2A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34364bba472so652313f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 11:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257090; x=1712861890;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUpAfMHg+laFfCU8zqN8B3PSMZVWl02POndufzeitW0=;
        b=WNq4pdfv/NsH7RJQvEMPRHnJHz8ZIRq/DiTSrK+Aq+EgY2dvWLsTU4O6SSmLxgzF19
         +pAANfN5kvna++Px8Qayy6bp1ZsFUy61AA9P1pKolL1wW2DGUe6cTU3hajQfQ4bL0F5J
         jgMNeZVgXF1hXYLrjSYf1p9+dfvYB2gLhbzlgbgKrnmlmr/Bhnxn6102xunSkW/go+xG
         Ztn60+YIPrI7L6d7IUXePG1pS8plLfgiUM5bukbCLz1N07zRGv7TbWOZTrWs/an4rMEv
         bo3HwpWPR/itraa7pZqSSeyS6MCYNjyoSlakBKUX2xEo6cuA8+t/qWdAeO/30h/Jit45
         jk3g==
X-Forwarded-Encrypted: i=1; AJvYcCVBTBeFEEahV9i89BOJGgqNKDrU5jhGt2qgf0ScZKNG0vML1OuE34co15LRztdmssVzSPSpwpFvlIbun8gLsXWrC44+DMQPBaG5BKVnegvJ
X-Gm-Message-State: AOJu0YwyQFf3Gk/bedBVk5fneyzI5q8J2pQ10lQ8x3TMVQvXXzGkz/9K
	3FxSziZx0imeDQhvOnWyA7WqPEF/0UyGCXfcgIpzQyeywdn391XWAZX72lueOeG2PBcfTC4FUqT
	olLfKNM08Nu5e8xCNwoV3/nIrhWvABV2AkqsEbuPrw0ik3dgzOoUoDViCaBEOR16fmw==
X-Received: by 2002:adf:fa08:0:b0:343:3e49:d6d9 with SMTP id m8-20020adffa08000000b003433e49d6d9mr2425586wrr.47.1712257090530;
        Thu, 04 Apr 2024 11:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIR5jv3Y+pA9R56BJ+nFHyzZuCjuoYvHQwb+bhK5m09rZk21mZB5x6rbzPgcQOkLvLeAqwTQ==
X-Received: by 2002:adf:fa08:0:b0:343:3e49:d6d9 with SMTP id m8-20020adffa08000000b003433e49d6d9mr2425540wrr.47.1712257089897;
        Thu, 04 Apr 2024 11:58:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5242000000b00343c0c24a65sm63462wrc.89.2024.04.04.11.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:58:09 -0700 (PDT)
Message-ID: <8fb37319-288c-4f77-9cd7-92f17bb567ee@redhat.com>
Date: Thu, 4 Apr 2024 20:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/29] mm: Define VM_SHADOW_STACK for RISC-V
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 kito.cheng@sifive.com, keescook@chromium.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 alex@ghiti.fr, bjorn@rivosinc.com, alexghiti@rivosinc.com,
 samuel.holland@sifive.com, conor@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-9-debug@rivosinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403234054.2020347-9-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 01:34, Deepak Gupta wrote:
> VM_SHADOW_STACK is defined by x86 as vm flag to mark a shadow stack vma.
> 
> x86 uses VM_HIGH_ARCH_5 bit but that limits shadow stack vma to 64bit only.
> arm64 follows same path (see links)
> 
> To keep things simple, RISC-V follows the same.
> This patch adds `ss` for shadow stack in process maps.
> 
> Links:
> https://lore.kernel.org/lkml/20231009-arm64-gcs-v6-12-78e55deaa4dd@kernel.org/#r
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   fs/proc/task_mmu.c |  3 +++
>   include/linux/mm.h | 11 ++++++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..d9d63eb74f0d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -702,6 +702,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>   #ifdef CONFIG_X86_USER_SHADOW_STACK
>   		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
> +#ifdef CONFIG_RISCV_USER_CFI
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
>   #endif
>   	};
>   	size_t i;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5169..64109f6c70f5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -352,7 +352,16 @@ extern unsigned int kobjsize(const void *objp);
>    * for more details on the guard size.
>    */
>   # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> -#else
> +#endif
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +/*
> + * RISC-V is going along with using VM_HIGH_ARCH_5 bit position for shadow stack
> + */

Wow, really?! I could never have guesses that from the code :P

Just drop that comment. Are them semantics the same as for the x86 variant documented?
("VM_SHADOW_STACK should not be set with VM_SHARED because of lack of")


I assume so. So it might now make sense to merge both paths

#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_RISCV_USER_CFI)


or even introduce some ARCH_HAS_SHADOW_STACK so we can remove these
arch-specific thingies here.

-- 
Cheers,

David / dhildenb


