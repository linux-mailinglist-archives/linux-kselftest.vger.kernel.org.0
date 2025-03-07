Return-Path: <linux-kselftest+bounces-28448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA47A55D21
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 02:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F4C7A60D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30967125DF;
	Fri,  7 Mar 2025 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7cKJlRK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462618027;
	Fri,  7 Mar 2025 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311072; cv=none; b=orsCVugW+DLwRqoEv+5q988g59CfmZnxIDGnNncaxMwqJg6LNzOUovCG+IrcXS0t0CuFhdpVh3Unb7viQUn5NiG6/tyq3cL1XeuK2v59WVKrLuVL5zfI11Eqp1KsBMVv93+wXlGLdrjcSYL/0Njx1Rb6p3kU+B2ErBoAzNW5100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311072; c=relaxed/simple;
	bh=2oaiC778vZL/AzgU+n7IGDRrB/Kv8HMCsp4AdcQ0bes=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qkU0Opgl4Q1h3tQNHVNLGC1mrcj93ddGvf2+6UFmVM97GYR8byKAlvX+Jso45YXD9V+q/PwH6N0daFnvCWkEtsuLoW6ZePsVgCRDw7t3oHZorlYPxIMpd7WJVEFFkHJ9Pqx+CMs926FMbN3CM2NeC6ezQqc3t6eKusQCCfBpqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7cKJlRK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fc176825so7295696d6.0;
        Thu, 06 Mar 2025 17:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741311069; x=1741915869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiTzhmHWM3AIs9vlhpCOhF67s9iWojS/DHtIVthKmLY=;
        b=O7cKJlRKlgndzH+GsgruyHPR8mv8/uUTunQc76pHRxrPoH+wT9HJ+uzIT7AvedsZvV
         Ffkgvs53oZgZN48noeaFfJWtOX9wXKddVecVojpR89xZsMsInXKILBg/Q7iDTvqjrGHe
         kGI8c71diuKB1Mav2QNZDUa2gfIA+Luvpeh+Vv813USLKutE2NUQr/dOZBAdVKCoNgPc
         dzkKf5y05dZVxtQHN3PC5KpFa/nHR0FqbonD2FO3u1EBWfCAvf5zQTor3mP7EDBqnC0W
         9ff2icDsPSwXZYE6sgySwnhSSxzeNGcRGhrjWNoUfvHpcbkDK+mZqZjxGLP1//NhWvEM
         IVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311069; x=1741915869;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aiTzhmHWM3AIs9vlhpCOhF67s9iWojS/DHtIVthKmLY=;
        b=Hg2MkQ3tGbc5U3gkG7UUd/047hlBNWXFtk+e9soRmGUiZL2aIiU7hHlmVrz+oLUhEq
         BZkTVCH0it7vbKvsOc18lDv8mNIpQe4MlGNnG7mMZkd/P6zgYeE8oz5kffLcAvWXJWdW
         udUwSThfU6ZiYh77E9OWNVLSIWOEitcmTsFdDUnXn9al/cqZNAFjdAoAwY2qUQ4E/rAb
         fLV6rGVo26/vot3qQ4P49Zl3Ik4bF0ai2BjX2zAmRfW8mWK8yVCOP5YQzzp8IAx5Hexl
         RNOk8XMGIO9GXRjdoVOt5bkzZAdpTObGK9YlW8jnhDX4GAakKaYXXuPqQVENnz62ns4j
         i3xA==
X-Forwarded-Encrypted: i=1; AJvYcCUP/PNGVtNXbdDb7R3Fzm2m4Y0B3LsxKdi1xzEs2rVj7BN8HUzTqZM6VDjZjqanMzYvSydUbrGprW3MEcrun4c=@vger.kernel.org, AJvYcCWIKS68EUPxqG3upxUXbJCsCCo9IAmaySmjuo0/i/mhuFOoJ/h68HYjjtJRCJQsmVhMjWGbpL0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80Rn4XdnRvK/sSYSvPIcOtnQ/fXgeW4AYova0PU7zx/rFcK6f
	zIjbb9adp/pECKmAiMskUcAoLhxLYYO0IagtARscNLJqqMo3n5nn
X-Gm-Gg: ASbGnctiXDs6vOdrDS8yXpyIV6P/5lWYyeZinK5R07Y7X8BudreCgx0dOC/hfZspUQo
	3rPh4KUMXGJ8loQ356qFqlSjD76dyDQ7zFBKcmjvi65I73Uj4YYu8Qd7UdQY+XdyB22R9mfJ7vH
	o5eZm8olvcf7NtvlHoRA1Gs+Alozuh5w+IwO8+p9IiJ3FmSWti/JOw2ZHjD4yYQ2shupbDcgYE4
	eTDIpwbflYELD/4vhSSkCLZYVnU2b1jeXpgBHS/ciyw5ilJmkSHTr1qqAF1zVqkBIg88AzbZaoJ
	Wm6dF90H60Y7UZv5HHufzcKJX8YsytaSuKwL2WDQ5IwZ3W/iq/cldWMhYdqc2FZ8ZQdPRaQUb4u
	ZrI+hfZOgNhI8wWzfIGfMKQ==
X-Google-Smtp-Source: AGHT+IF2SQWj/6Tqk3o0gwSxJI0JjHHKxxzM0pfy027pnViKYe3dPz5pymMaV4H+0u5eEP2iM1898w==
X-Received: by 2002:ad4:5aaf:0:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6e9005d4500mr22273616d6.3.1741311069430;
        Thu, 06 Mar 2025 17:31:09 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7170312sm13442486d6.114.2025.03.06.17.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:31:08 -0800 (PST)
Date: Thu, 06 Mar 2025 20:31:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <67ca4c5c91c2a_4cd7a29460@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250306160017.1a385f6e@kernel.org>
References: <20250306171158.1836674-1-kuba@kernel.org>
 <CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com>
 <20250306160017.1a385f6e@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: add path helper for
 net/lib
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 17:22:47 -0500 Willem de Bruijn wrote:
> > > +    def lpath(self, path):
> > > +        """
> > > +        Similar to rpath, but for files in net/lib TARGET.
> > > +        """
> > > +        lib_dir = (Path(__file__).parent / "../../../../net/lib").resolve()
> > > +        return (lib_dir / path).as_posix()
> > > +  
> > 
> > small nit that one letter acronyms are not the most self describing ;)
> > I would initially read this as local path
> 
> The other option that came to mind was to have one helper called path()
> and pass rel=CONST to it. For example:
> 
> 	prog = cfg.path("xdp_dummy.bpf.o", rel=cfg.NET_LIB)
> 
> Thinking about it now we could also store dir directly, which is
> probably most "Pythonic"?
> 
> 	prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> 
> Thoughts?

The pythonic approach is nice. No function indirection, so self explanatory.
But they all are reasonable, of course.

