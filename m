Return-Path: <linux-kselftest+bounces-29004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F9BA60B68
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9762417EA55
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402C1C6FE0;
	Fri, 14 Mar 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lXGyMbyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6B1AC44D
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940870; cv=none; b=YQWPCBZ8aFgCW1WFjC3qvh1nfzZlzkWqiRJGqeKrECC5pTrqXYVge0fOppV2Bw5N8ZxuA/4/b0aesJoxvgPQshBGa2YxYVzuIIXo6FIZHLcI04s463d/Q48aK6H07njENt1Gy1yLPnLWaIwfSXJNPq2vpgKWiUkPO5HhWbPSv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940870; c=relaxed/simple;
	bh=17a3PwSysj48lPS/+FE8SBsjkBQN0LxJJw0V3mx+3A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEDoIXEnK60WB3Q9G6zEIsx+fiROv36zanzXmJYtjOm4ZTeIjsAjJFQz4zL6BUlbB4e5QOghbxqI+EqUVyUevQSgVJMSgjWzTzroRiUsEW1b4DkFFi+X7zdEIDIWzEMZsEUkGgKsyiHyL6ErK7J5RqCJOh4t1XhTmsSULq8k8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lXGyMbyJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85afd2b911aso68306339f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940868; x=1742545668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bj5T6m1yE9zyibPVyLAnvEMluIIdsT4MhqvG4OGMI=;
        b=lXGyMbyJVnHCblZg3g/JTyiTy4xoXLTEc0oty0KZixAAvLU/bphTStcqgha/sCs0Fb
         xadq/gaBwC77dVLpdE4XYn+F7x19BdpQSt93xPFbmbSnGSeB/O532yzM0Kk83kCfvwrB
         jislODgATcppurGUmYYvtwGLE1MruYvgApl8Q0s2f5mvVReOspKAdBpJfYTb5/6is4GU
         70A8zUnzj5H5ocxvoN0w0CFCXBd9YQUSIBQ7ONVpjCqc9HAY2/LKWDDrkSlTLwh0xBmV
         rCv95HgU/od27rWIgNJE4RXXqGP60EvIuiqujU9ls+04dhMgm4PIAEqXD0ZAvzZZ9gAz
         o5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940868; x=1742545668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bj5T6m1yE9zyibPVyLAnvEMluIIdsT4MhqvG4OGMI=;
        b=frwoWGgtAomj9w7A/XXoD7tPuCESCXzRh65Lm40pz2rcywpRoqyjSfABmZ9ft9vrJh
         pm82kfm0QcUXCCSTM7D0MZAJF8wUjm/G/0SdryGJpy9WDNPPnHBc5G47l3qDDU50xrPX
         8BS3xKHsuYRft9e+oSsVrfTMcg6iW22tdCCOvd3SYVxqAVaCwMNh+2hqvd51ZHvOoT8n
         GOiwyi7JBgpdzUoHHCuLA/aiulUvMjeh9ke217T4ldoF1mbnsEZdWMR+Vkjqms6t60mo
         vBSJgw7CYn504NSP2PgGj3VKz5ql0ly2lQj7rt85l1OSaw6OpG8O1afdlA7mWioKiPsM
         hU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK3N6hlz/YSQCF46X49Uy0KmxAAiS2nyKi5ZFo2QmNvDyh7LB2cQZwqKcka+L7BKXulUxHowhVulBvhAf8zYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJn62tYKMnrhTDryGTUysWET85+JW58sov0bGLgkUf7MckO9A
	MSK+vm37kSyTi03CzaOyDf5T77JkpvKa8KsiTlLq8PcCrIa1aSKHEID/5k9gdYuCVVmOJB3cFtD
	axjx0caZ7/E50V4nNaVopgxS+iEJ5B6TB15LniQ==
X-Gm-Gg: ASbGncsBIgtSYRNl609Cr0h4WVYJvvbMHBAK/YK4hrGgLYNtsJt3124GI2N7Dcu5Rah
	D5KJZGCBclWbCOWdjU68LZt0jKodp5/GxoDKkIgkBtlpzLGB+fYkX1oZbysR8wo4T7HTmkvRb5s
	1ps9/MFtZQvV4dgaK1hPSxqqtwhzgxuMy6ayvY/Q==
X-Google-Smtp-Source: AGHT+IEEDueBTR/qjkseHCu/6hHmmY6d8gCCfHNJAKAWerhJ6BCGW/4G5xYr8+OUgNTAl9wCy3v958LMiQIhsbPcBw4=
X-Received: by 2002:a05:6602:3a0a:b0:85d:b14a:bb56 with SMTP id
 ca18e2360f4ac-85dc4761730mr159183339f.2.1741940868086; Fri, 14 Mar 2025
 01:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-1-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-1-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:27:37 +0800
X-Gm-Features: AQ5f1Jr6EIItMT0M4w7j1TkQMGeFFM7Vn70Ljf5lKdhIMO0pijsGnR7Gg0wOpRc
Message-ID: <CANXhq0rtY_zDcLn4_TH0F083e4K58L-V2ingTwPgyoPBXEnY=g@mail.gmail.com>
Subject: Re: [PATCH v11 01/27] mm: VM_SHADOW_STACK definition for riscv
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> VM_HIGH_ARCH_5 is used for riscv
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  include/linux/mm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..1ef231cbc8fe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_SHADOW_STACK       VM_HIGH_ARCH_6
>  #endif
>
> +#if defined(CONFIG_RISCV_USER_CFI)
> +/*
> + * Following x86 and picking up the same bitpos.
> + */
> +# define VM_SHADOW_STACK       VM_HIGH_ARCH_5
> +#endif
> +
>  #ifndef VM_SHADOW_STACK
>  # define VM_SHADOW_STACK       VM_NONE
>  #endif
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

