Return-Path: <linux-kselftest+bounces-18213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31597EA35
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32702B209EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6751195FF0;
	Mon, 23 Sep 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz5Yf3TU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62517543;
	Mon, 23 Sep 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088902; cv=none; b=l+aeO0+3TBC8IspVgybHXmNS2n2fQQqGGHVo4XpJ96y8qxp4ca2F6Wi7L5QCLv7OpSQKnMtxuT6KI49eLtTmCkEFvhlRXX4RTw1QHJgb5LSDnXxgNscAEkJ8bKw7dSAoSNhCDDaVR5i68jVk8WoAAfWlHM4KsUl0Rk3TouQoYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088902; c=relaxed/simple;
	bh=rJdZumpDMtoueS0WOtj2mLIcslSowlQ0JIc5EJzS2ec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZoS54f0c7/ovz653gPQj+xdWVADNitCehZdSIlNqGAcoDmwhHXKwWs9ay3NMsUfuGK0iPjj4c9rGm/UD9En/fV+q9sLg9WHXst2GRPuXIUB6HGV5GbTYhmEEt8VKY0RnaJR9bn9LgBM11iJR/jdq9QBDVWwuubyzcp6fBFmk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz5Yf3TU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so24104165e9.3;
        Mon, 23 Sep 2024 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727088899; x=1727693699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdG2+Uri2AGDsZ90rom+fWqJfjc9BwjIrqb1r21feAA=;
        b=Oz5Yf3TU5v5+ZUoE2vsssAlr7VlH2nMU3i6QVLcnYDG+eSUYmLehDMDMxsNUylh75S
         mBzWYARc1EgamAt+gBKtS2r3HyyHRwd8eqbBPVkDvjHwX5I64xdzioM3axuA0Hf7Lfar
         M8UVvcaw5jCj7Q5JfpH5XISdCRKyoCOJViT5UmjV/LgjYlYYZgePV5yT9KmksLBChKkM
         GgRu/sQ12XdN8to/OH4xX0XQCfXMk6c/YcwWV4Cr7nyYXz3vLK6expDg3px3O+8VdCHf
         +QWCUwNJe4eFfmlJ4tMcNnougWYY8s2Mmk2sbPdFwG7buw8HYuVd/jeOIZPcc49vbfto
         +e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727088899; x=1727693699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdG2+Uri2AGDsZ90rom+fWqJfjc9BwjIrqb1r21feAA=;
        b=MHuAkxMtwigVV4yISkWewFOvwK5EOYKKh7zByGyT+kh7Gn+96LLNDHas5/9CqKIM6p
         Ah1AFEAJBz8cSSIDnrDOcTlEiFXwtuCXpaKp0vzKcfLigS5c5ilabJCLDt4tKP1DG0yX
         WqdW2MlyrhLWG8NQB48kiykEOCQKukod9Q9/Yd6xQG4PlFZPxNYc7T1cRsw2WTNPtSY3
         aFrF3C6mhhvXaZGLTViYMyEyDeN0kpC503jTy2EzQI64+FyJf+CqeEXkKbl/VMBIUGrP
         1VSuEWLa0Px0iC5JumqHDQB0X4bI9+rIsQSmfG0DLV6ZbfqNaNID6FAqx13XCCfu3ZIj
         VktQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO1WuGn9ZJ2P9i2FDtyX5s8YZDtnl4rtH5K0f80QZtXGhl7fDzWc60ux3pX007JqwMFdk=@vger.kernel.org, AJvYcCWiozpNag2WxVKtc6qsw4IUrzIZEA2D7OzMnhu916CDpWoUbKpIuVY+/7Uizk7HkNrqD6yBB5q1wKIzwGv12V1n@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvBEdsH7k36uJFfOlGh7UjZdhnDLhluD0eGPCdfad4E1GZZKK
	SYye5ARv9lvUXu1xjVA2VTeXSZLGpTw/nsKQpe5KKBh3wrumBiGm
X-Google-Smtp-Source: AGHT+IHvZWyEtuFUqpskJTlBnwlHzGHfpCFtvjug4s+1iWMQfhtLNLNNXKxiCeuPADmIOCKxOsLcsg==
X-Received: by 2002:a05:600c:45d1:b0:426:614b:1a72 with SMTP id 5b1f17b1804b1-42e7c16f909mr88253135e9.17.1727088898967;
        Mon, 23 Sep 2024 03:54:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6643sm125169755e9.29.2024.09.23.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:54:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 12:54:56 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: btf: Ensure natural alignment of
 .BTF_ids section
Message-ID: <ZvFJAJdEdK3wnyXs@krava>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
 <714d7ab8a48172c67ddc027c85b2a0dad0312a74.1726806756.git.tony.ambardar@gmail.com>
 <46d8d74883926245829f8aac3d1ab6dc5b5e4b98.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d8d74883926245829f8aac3d1ab6dc5b5e4b98.camel@gmail.com>

On Sat, Sep 21, 2024 at 02:46:17AM -0700, Eduard Zingerman wrote:
> On Fri, 2024-09-20 at 00:49 -0700, Tony Ambardar wrote:
> > While building of vmlinux employs a linker script to align the .BTF_ids
> > section to 4 bytes, other usage leaves .BTF_ids unaligned and may lead to
> > problems (e.g. [1]). Post-processing and libelf-based endian translation by
> > resolve_btfids may also potentially suffer from misalignment.
> > 
> > Update encoding macros in btf_ids.h to always align BTF ID data to 4 bytes.
> > 
> > [1]: 3effc06a4dde ("selftests/bpf: Fix alignment of .BTF_ids")
> > 
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  include/linux/btf_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index c0e3e1426a82..c10b163dc340 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -89,6 +89,7 @@ word							\
> >  #define __BTF_ID_LIST(name, scope)			\
> >  asm(							\
> >  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
> > +".balign 4, 0;                                 \n"	\
> >  "." #scope " " #name ";                        \n"	\
> >  #name ":;                                      \n"	\
> >  ".popsection;                                  \n");
> 
> This forces all id list symbols to be aligned on 4 bytes.
> Should the same be done for __BTF_SET_START?

it seems all the set macros use __BTF_ID_LIST, so it should be taken
care of by that

> 
> Also, is it guaranteed that all btf ids are organized in lists and sets?
> Grepping through the code it seems they are, but it looks like resolve_btfids
> does not really enforce this, simply looking for symbols matching a special name
> __BTF_ID__<type>__<symbol>[__<id>] .

yes, you need the BTF_ID to be part of list or set to be able to access it

resolve_btfids does not enforce some loose BTF_ID definition without list/set,
but that does not seem to be a problem

thanks,
jirka

