Return-Path: <linux-kselftest+bounces-24198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C7A08D1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174F07A327F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3582209F56;
	Fri, 10 Jan 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl+BeJwY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5217F4F2;
	Fri, 10 Jan 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502991; cv=none; b=BZzXYxqI9E/UzNYSXpucDG2x5ZPg2A0vRx0zP/lF07TFqavKym8pF67j/FOXX9IAOYFfTQmkSN1nBZnPA9hLdjviVh5V5WXVUsdL9aKCcYTxpldxjR/ftnOhylg70Fz3nW/CPdJeKoWYC4gozN5PM336EDgc5EZI411t/rpZIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502991; c=relaxed/simple;
	bh=s/iJGBFf1Cxb70U1DPkCrxtxP7Wv2VhvqogfahzdieQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+zR3BrMkVCuFc6T5Hq5xZWGV3/FUNZT7/jHc6u5QA/2OpgQKGpnSA0dnGWKaRUqJfqFt2oKQjrFlBr8eKhXsCS/9WTDYVnPcW84eFBE0kMWp1hlw04AaUsXfUcfLpaX+8FR27Ooj+Tk5AQ+54ChYRFiIRyt44rE0Y2doinPNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl+BeJwY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso13400015e9.3;
        Fri, 10 Jan 2025 01:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736502988; x=1737107788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr3QW35l+ROuCXllxyigQs1tyTlV+AXBbBIdlycxIm8=;
        b=hl+BeJwYOB6PTvLGiivDaVW2oeA7pDAd1f2S+WwzAGTAaOB6PTnxao/x/rVPTWfvLJ
         QFCo9SrxTyVOnYNzdKI1U26ySE5dBYlPm/xi2f+lSzMcHj7dGnlyDQwxR8VD+VPu3VQg
         w4EkXcqkqt7pAHhfM/uNJp3cD8F8v96SfUWJDvhLrvvRsBes4mCdfyD5wE5NiEgXiXUI
         aJzB500tREUbmePH9Zn2fjW3UctjA90IqAcmHc0JuI5Zc2OvT40cZerI79c4MW/lo2km
         vCwAjREiblZB9oRXDtLw/HDP042HaCCHmLI6RDzGQdCbaD/UdA7mh6vvThVpTHkJi0DC
         ICCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502988; x=1737107788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr3QW35l+ROuCXllxyigQs1tyTlV+AXBbBIdlycxIm8=;
        b=rXiq6ccrUfPdZCVB+PQbgkR6lL0wLwzprtd5objrWNDwaZh37ofDi5tKh0KEnSIpyZ
         TvUB/Dcqz+W1FtgU0VOcmdf8pxU99CVL/xfGJYVCM9/LnNxJqNy8t3PVwl4XwoNsurhO
         bG7LPBBvZL6GT0uVkbf8VYNEPykuTSy7kGflmJks9Xuy4uqgQyyFfdxqQoBZe/sDRC6x
         uZQcSHA2Xb5QGGTLkOePq4ulXOXHijSZL6hH3wVch5zMUhUt+p9VzopRBNk0HyXai/6W
         69/nlfD/4/MSgej/6Z0COzED6oSXWIkWTRrs8bPnWx2PM1vlZ2UHqA8Mj105SzSzZmUm
         zwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbLzjEhEFklokCuYAty0iM/ph0ngY1CrnqZnJiEwuXQDvIPLQOzuf61TKgzh9VGEW7u41Jp0Y0lzd5Ewi5qkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt23VGSdc9s3lzbJQ5kTPx0ELU6C5E0adpHqeJdwH1t06Oq7K5
	qa1bS7Yk8QwUTMDWhalId31Ib56m4OIV88OWZxmrVfpl1FQ6IY17
X-Gm-Gg: ASbGnct2kyTizR6xc/jG8G6cBAVoTdvbINH5HnM5wIBSi/fYQYkTcX2zoSjZdcC62Mn
	Pj6P6hI+dPXEYwPoJW2aMoRg8XXyQLUdTwI4peWVuGpbIYHC+O3prmYEaaavulTD+FE3BEZQab3
	4ZQipZG3+QbQY800kLemPrEdCaTbTCuIb1UPK4lUWCKkg1RcTOAZ01AzNiWUSMkuWaioVc7tWEO
	8qZe77UNlwyoKt9UGX+0I4OdRzRiPCuyyGWt7VlhPTKxZkz/DFJ0FlBw+ykZdz+t4CJvGt7ME9J
	n/CNUQlsTI/P+bHm/R4s
X-Google-Smtp-Source: AGHT+IEkNTbcIJFheJyZEh1/rHzrJsKyjAhfpTWKLLwfc4/boZ17G9rXbHjSeAgYDysRbgB3eu7aLA==
X-Received: by 2002:a05:600c:1c1a:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-436e26bd126mr98549175e9.15.1736502987960;
        Fri, 10 Jan 2025 01:56:27 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da66e6sm82271455e9.4.2025.01.10.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:56:26 -0800 (PST)
Date: Fri, 10 Jan 2025 09:56:25 +0000
From: Stafford Horne <shorne@gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>
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
Message-ID: <Z4DuyWhXlI---tQR@antec>
References: <20250103040326.2603734-1-shorne@gmail.com>
 <Z4CF7a89_eCkAMNV@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4CF7a89_eCkAMNV@ghost>

On Thu, Jan 09, 2025 at 06:29:01PM -0800, Charlie Jenkins wrote:
> On Fri, Jan 03, 2025 at 04:03:26AM +0000, Stafford Horne wrote:
> > When working on OpenRISC support for restartable sequences I noticed
> > and fixed these two issues with the riscv support bits.
> > 
> >  1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
> >    passed to the macro.  Fix this by adding 'inc' to the list of macro
> >    arguments.
> >  2 The inline asm input constraints for 'inc' and 'off' use "er",  The
> >    riscv gcc port does not have an "e" constraint, this looks to be
> >    copied from the x86 port.  Fix this by just using an "r" constraint.
> > 
> > I have compile tested this only for riscv.  However, the same fixes I
> > use in the OpenRISC rseq selftests and everything passes with no issues.
> 
> Thank you for these changes! I suppose these tests hadn't been ran on
> riscv before... I ran the tests on QEMU and they all passed :)

Thanks for confirming.

> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> This should also have a fixes tag:
> 
> Fixes: 171586a6ab66 ("selftests/rseq: riscv: Template memory ordering and percpu access mode")

Right, If ok I think Palmer / the maintainer can add that when picking up the
patch.  If requested I can add that to a v2 though.

-Stafford

> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  tools/testing/selftests/rseq/rseq-riscv-bits.h | 6 +++---
> >  tools/testing/selftests/rseq/rseq-riscv.h      | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> > index de31a0143139..f02f411d550d 100644
> > --- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
> > +++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> > @@ -243,7 +243,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
> >  #ifdef RSEQ_COMPARE_TWICE
> >  				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> >  #endif
> > -				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
> > +				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
> >  				  RSEQ_INJECT_ASM(4)
> >  				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> >  				  : /* gcc asm goto does not allow outputs */
> > @@ -251,8 +251,8 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
> >  				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> >  				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> >  				    [ptr]			"r" (ptr),
> > -				    [off]			"er" (off),
> > -				    [inc]			"er" (inc)
> > +				    [off]			"r" (off),
> > +				    [inc]			"r" (inc)
> >  				    RSEQ_INJECT_INPUT
> >  				  : "memory", RSEQ_ASM_TMP_REG_1
> >  				    RSEQ_INJECT_CLOBBER
> > diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
> > index 37e598d0a365..67d544aaa9a3 100644
> > --- a/tools/testing/selftests/rseq/rseq-riscv.h
> > +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> > @@ -158,7 +158,7 @@ do {									\
> >  	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
> >  	"333:\n"
> >  
> > -#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
> > +#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
> >  	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
> >  	RSEQ_ASM_OP_R_ADD(off)						\
> >  	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
> > -- 
> > 2.47.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

