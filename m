Return-Path: <linux-kselftest+bounces-49423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F98D3B8D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AB4E3008E35
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4527D782;
	Mon, 19 Jan 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi5N8Jef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994923EA99
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855708; cv=none; b=Z0HI7XQo+fN5Nmn1cd3Faao7tad0BI889jX5e5YN3bQYrAjNXaJIoaocOpyCjClX0GxQp/MUagXjfItBArdvSd6CyBwidENO4vTR4UY6Sw/kDz3o3P8FKf6UjHpMldv14zS44fGrs2Np0eMLXrg5NZYlcuNtX40eQBjLOOeIDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855708; c=relaxed/simple;
	bh=OTIL6Loch3W5HT8K3/5drQB2NyA4JRAnkOJv2pognEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQobMkEI/1Rtwo69PUPxb489UYM0Pxu4Q1l3I/5Tkhzptb26cND0o69dNuyTno5DXW5+W92cxqB2Hnx9iu1GlsPzyl0T5Kle3HbJYnj49cfobXGEzGo1aKFZ8FKqphOBZrNsZSqhshJMpWOs7mtDbolI9Yptrh9+oO6+mjN4+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi5N8Jef; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so54366985e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768855705; x=1769460505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9zOo8J2/R5/ZECF8jXBFWc70aqTEGil4wxpiWbgmSlI=;
        b=Bi5N8JefgTI3F3lOzTajlWrBEWZnXQf14QsriR6lfGutcky8BMfxJUvqmV2VTdo5tw
         HK4FPBPs7pbkCCJzoN9+ZahvsGJiwzG97xF8NjGY9E+2PaQupjJglU1R7dJ7Yow2+7pj
         0WRG9vlhKpTE9jQ/6ywk1+YC7kqzPGzTxK7fq3GR9jW04f2Ww+oPSnjnWHaTHPdnipHF
         5QCYiiJJB0zBf+Zs2l40XUvbdjA6HU/USUoI2OH9QPw73h/RxkTdXx7oBG1BX2gF71zy
         HjBEXr3kd7GSrXstAv+Xu1Vhf+BkKS54n9jWA3blA9nQej+3EXSyiXv0fT5TL4JAUvev
         MzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855705; x=1769460505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zOo8J2/R5/ZECF8jXBFWc70aqTEGil4wxpiWbgmSlI=;
        b=mw2eiA4JEpcI60zkksg350fMbalBX1MkJyp67/mqWH6WkUh/QvjNyeSTNJKXvbxnyN
         +EKtIb/WLr9pkirjHsvy3lG4GY+4HuQNlq7I0CbOMFZ7SLBe91nXfbuWHFBc+LO7KGBU
         fNXlTXmzPwwGoRxPys4aDN3v5apO+rpkbiiu93cjJ5uSiiI4NdRVEeSNA2ja3yd2MmBb
         Wz5lUcGfqdd//WzQqq7yUH3EdpGLMzWolCGFwuRS5zeMCWLcQ6Q9Ca0dq7FMd15BSP+z
         zinrTHwVuv4yrwVY8cLdy89y7GHU2gM3OXFNG3k/DQ8i0XLCJo6rexC8FprTUn/LqFl4
         i5lw==
X-Forwarded-Encrypted: i=1; AJvYcCXkaBPNEtUus8OflZsnSRmr/RIXw2QDFISAxpj6SJFbh44Y1pjIbiLJn5alNphS2fUUySYR1Xeo6jyy858rlW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9BvFts4eXVu9NYz6wYt52t2pLfbAIOHp/AKyE9/7w1nWyN0U
	KNAK7XduEYUpowzt4S9qTwIT2SFYUs8Ketw9C17VeTfou8gvGI3QVDFs
X-Gm-Gg: AY/fxX41Xs134Khlca4hXr1CkIawofCu4j7ZiatCDpTKKtjMkuohyRwmg75cp5L/kUl
	Aj5yr6MDhigB0kfXRNvoum3jDiyZWX+MxhbqadBEJk0VNjZrIBufHaDRX6HesQr0EGpn38/fG3a
	EzMgSmLjIF2bLZol4b53Kb0xZCEpeh3SiBeyoHp68W3VlrmUl0ETt4+y8ai32ZSPAaJ2aIY1pwg
	ldKiTe/g7U5fqb78B/q8c+TybGIjO8YgCg0HbsimW+Imr1aiR9y2lNn1EsOu1aJQgu0YFZcb3Pf
	UrIY32fPeF2myVzg3CaWmzagnG5VowHkQAQolGZsUFC/TA59bC5HT86ciqVftvlKkeOdFgVHS+L
	mvEojG5HLu4LQaVcdUERrZkv72T0AyLxzYPK/MKKGvClPabKsqr3Xx+ZSzw/r6imNODTRL4c2c0
	X1SmTQ
X-Received: by 2002:a05:600c:4e93:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4801e30b737mr159086915e9.12.1768855705113;
        Mon, 19 Jan 2026 12:48:25 -0800 (PST)
Received: from curiosity ([80.211.22.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe3b01csm92808125e9.5.2026.01.19.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:48:24 -0800 (PST)
Date: Mon, 19 Jan 2026 23:48:21 +0300
From: Sergey Matyukevich <geomatsi@gmail.com>
To: Andy Chiu <andybnac@gmail.com>, Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 2/9] riscv: vector: init vector context with proper
 vlenb
Message-ID: <aW6YlXEbusvDiDWw@curiosity>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
 <20251214163537.1054292-3-geomatsi@gmail.com>
 <CAFTtA3MdoL5XjcjTrNhZ27UXZe4Mxot-rttc8cQ-K=E-Mh164A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3MdoL5XjcjTrNhZ27UXZe4Mxot-rttc8cQ-K=E-Mh164A@mail.gmail.com>

Hi,

On Wed, Jan 07, 2026 at 12:49:31AM -0600, Andy Chiu wrote:
> On Sun, Dec 14, 2025 at 10:35 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >
> > The vstate in thread_struct is zeroed when the vector context is
> > initialized. That includes read-only register vlenb, which holds
> > the vector register length in bytes. Zeroed state persists until
> > mstatus.VS becomes 'dirty' and a context switch saves the actual
> > hardware values.
> >
> > This can expose the zero vlenb value to the user-space in early
> > debug scenarios, e.g. when ptrace attaches to a traced process
> > early, before any vector instruction except the first one was
> > executed.
> >
> > Fix this by specifying proper vlenb on vector context init.
> >
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> 
> Reviewed-by: Andy Chiu <andybnac@gmail.com>
> 

Thanks for reviews !

What would be the recommended way to proceed with these patches ?
I have reviews from Andy for the patches 1,2 and 5 (selftest for 2).
They can be used independently of the remainig ptrace v-state
validation changes and their tests.

Would it make sense to split the series into two parts, so that
the v-state validation can continue evolve independently ?

Regards,
Sergey

