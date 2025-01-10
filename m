Return-Path: <linux-kselftest+bounces-24171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804FA08551
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22712167657
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F61B0437;
	Fri, 10 Jan 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VJh9DpUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8401E1A3B
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476148; cv=none; b=b03uKW1rbPFYoC+F7x4LwjgxzzIZP+Vu2uyijJvmDiyAI+MDimBm1ywb12aZjzQe5thvjQh/Et5XwUg9T5KrCIH/hzw9gP8T1v7JIW0Ti0XSF5o27E0TxOVeB91Tqj4TosOgdbK68Xmw4MUYkYsvkLQCSH+8ziuGRYzEHDALj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476148; c=relaxed/simple;
	bh=aL6r/+SEPgx57xFSbHh4t2LZIgw+wFA5cXGQFKi4U/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUlcHgOAqFOyhtq30s66nCNvE1Sv5/SrGMHgYQfl8asvcxX7bsM+1diN7o0jktgU9pfk9W7qXFbfljosJRj0wla1rYJMObFjnuL8QMVPXc/KsVc6j11DJnU+G8OHYKwxJQWfdLis8u/qhRSFpx5G1dLtJ/MV4FE0tZLHPsClboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VJh9DpUr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163dc5155fso27451905ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736476144; x=1737080944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uKw2ypbHF5i7qZwaig7Kl4LaoMnJ49oOkiXeVny0o0=;
        b=VJh9DpUrp4nGUXx3TJwVddcec0fRKAxq+bHamkVGfoNhFKDvhcWllnEnA/QyjTXSyl
         ALwstWHhLrCiriSXhV8kpQ7zKLQ7oVdfjw5Bx62rxaRRSgW+2RwqArpS7LlmQaCh3WR3
         9SOWiSyl1HiyFNjbccBbYGRFWYQrZWGegAsJ1Tk85L6SyGjTr5RHVI14IzqxXq2bubhH
         /xZs0xrfkhQ/AFEVHh4+rB+8gTTy0w4OOPYL+We4Rf1hnh6D/wDE1XjoRzlpHG9sufSK
         l/tCZqNMzi3SipxRZwK2sWxMP/73+ELroLbPmYzm2fCq+S7erP4S3LWi6JH64jHWX2JI
         H/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736476144; x=1737080944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uKw2ypbHF5i7qZwaig7Kl4LaoMnJ49oOkiXeVny0o0=;
        b=rsDqOQTemG+pAE2Y06TwAIymiGE4ueaeaYKp1+40ftOVBEJpxo3/R4FdvZpTZCgVRa
         RB3sWAb/bKAzSivSZx6OMcl4+jueOowH8CNr+B1phB3sHCrdL+gaqVTCJkdIIzOrEHoI
         2i2R0Uv6FmykGdm3alXEFkjxmJSU5ybZZ5PXn39UDrlhXVlQ+jxtOIGDpuV93cJMcetw
         aYmNiWTMRfwIHwE4/eHHXmB6aHfk1aycVuAzmr+/hDk4LH/JDSuI8kZ6AYliGUAubAuc
         PlXUUvoLZnfYeBQfg4CVWgZngNtebMnD94h3HVK82C8Oz0p8iMMNBKTkdQWULSFBTe72
         7Ynw==
X-Forwarded-Encrypted: i=1; AJvYcCXNIzsXocMEU/OR59aTdRrCEDAsnIXcp1cXMfg7QfUVyKQZgJycnTc4ccwai0wmBC5LYeV4jLCIMuE/9sveQcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqHag0pVGApahAs8+LtOGNebB5N5C6Er68PPM44kwxIsSePYc
	gsjFyK63kR2Zq++6sngSvyNNJIB2ZC20lQtBpfGvbHK6VicTMpKvZTcwz+fIevezxAsdsAoDIBx
	R
X-Gm-Gg: ASbGncuXpb9tTgSoooexIOd5+FbHzi3ZP2Ww8WIpe3+UX7v6pOMo54teowvoha7xlCb
	VV3LI0GUiNqojpUvzBYw2UPCeZaWQ7L6Mdo20Ql+njsE4rOrM+BG+/HlBnUbmC8k/XY3iBENrH2
	155vsEpXGDek1DtI3LraNBeSBOwkF9BeOOp1LiSPUtLnSKT/RjPXixqSJvsDhORuByd1Jx6x2cl
	SQ3I/awBt/xzunSDkg30sfRuJI086POjYFtbhMin425YJmdOmyt
X-Google-Smtp-Source: AGHT+IHrKeVYa5o7IHDpdaSUF8BXSqbcoJI/r1FJmD+YU3SJipUjrwV88LTYTCzioCu2qn/Z+ob8mw==
X-Received: by 2002:a17:902:f68b:b0:216:2a5a:89d3 with SMTP id d9443c01a7336-21a83f70d13mr121213805ad.25.1736476144200;
        Thu, 09 Jan 2025 18:29:04 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217565sm4478495ad.125.2025.01.09.18.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 18:29:03 -0800 (PST)
Date: Thu, 9 Jan 2025 18:29:01 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] rseq/selftests: Fix riscv rseq_offset_deref_addv inline
 asm
Message-ID: <Z4CF7a89_eCkAMNV@ghost>
References: <20250103040326.2603734-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103040326.2603734-1-shorne@gmail.com>

On Fri, Jan 03, 2025 at 04:03:26AM +0000, Stafford Horne wrote:
> When working on OpenRISC support for restartable sequences I noticed
> and fixed these two issues with the riscv support bits.
> 
>  1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
>    passed to the macro.  Fix this by adding 'inc' to the list of macro
>    arguments.
>  2 The inline asm input constraints for 'inc' and 'off' use "er",  The
>    riscv gcc port does not have an "e" constraint, this looks to be
>    copied from the x86 port.  Fix this by just using an "r" constraint.
> 
> I have compile tested this only for riscv.  However, the same fixes I
> use in the OpenRISC rseq selftests and everything passes with no issues.

Thank you for these changes! I suppose these tests hadn't been ran on
riscv before... I ran the tests on QEMU and they all passed :)

Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

This should also have a fixes tag:

Fixes: 171586a6ab66 ("selftests/rseq: riscv: Template memory ordering and percpu access mode")

> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  tools/testing/selftests/rseq/rseq-riscv-bits.h | 6 +++---
>  tools/testing/selftests/rseq/rseq-riscv.h      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> index de31a0143139..f02f411d550d 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> @@ -243,7 +243,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
>  #ifdef RSEQ_COMPARE_TWICE
>  				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
>  #endif
> -				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
> +				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
>  				  RSEQ_INJECT_ASM(4)
>  				  RSEQ_ASM_DEFINE_ABORT(4, abort)
>  				  : /* gcc asm goto does not allow outputs */
> @@ -251,8 +251,8 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
>  				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
>  				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
>  				    [ptr]			"r" (ptr),
> -				    [off]			"er" (off),
> -				    [inc]			"er" (inc)
> +				    [off]			"r" (off),
> +				    [inc]			"r" (inc)
>  				    RSEQ_INJECT_INPUT
>  				  : "memory", RSEQ_ASM_TMP_REG_1
>  				    RSEQ_INJECT_CLOBBER
> diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
> index 37e598d0a365..67d544aaa9a3 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> @@ -158,7 +158,7 @@ do {									\
>  	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
>  	"333:\n"
>  
> -#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
> +#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
>  	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
>  	RSEQ_ASM_OP_R_ADD(off)						\
>  	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
> -- 
> 2.47.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

