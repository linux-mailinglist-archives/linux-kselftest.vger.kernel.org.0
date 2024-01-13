Return-Path: <linux-kselftest+bounces-2948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FF82CE56
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 20:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07A31F2211A
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 19:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84C6AB9;
	Sat, 13 Jan 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwoW5vCB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6B63CB;
	Sat, 13 Jan 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72d26a40so474075e9.2;
        Sat, 13 Jan 2024 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705175357; x=1705780157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HammmbmKVZr2MOKZbNt/I1t0w3fHw/pSzTd2SPHXwE=;
        b=WwoW5vCBL3h7lbECyKBVHtgbzwX8+k72jbjt8QU74bmUO1szbPbgdDO2fFvvSTRwk5
         h2rVvPFaFrRji/ACDztJZT5LswOYqwPWe8wymYmtiIWMiK+NI/aSeLx1y8hdURHAnvrb
         FNmxXQkmTwrvuiZhz/iieE7npT6qYW6fOoSFUga/2xaVHx0Jy+mG+6Sk32CvFn0DzxvF
         XJ1ecKOR4SVW3wlwtBD28G8pzpZ3fKy64CA8Sro3Xd0/AA/lHFNzS2juL7lXIrW1T0VK
         A6ast1EpGUSHvWqPhB0lC7A0ggroAGkpv+dWgIGji1BPEy2gZP3WgPy4GiIxi28Ta3xv
         jHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705175357; x=1705780157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HammmbmKVZr2MOKZbNt/I1t0w3fHw/pSzTd2SPHXwE=;
        b=k9BaPTk8SaUyxVLcXhcaz6fRsC4/v34K2injmUrbNu9EJQBoJpqVsKOb76IrcaGAGy
         xswuPk8J37Ja8CHreJF/hJyNs8TBq6vcGQbgpbodVaH66bGmL/WDCgFAkV6aa2ZxtWNu
         RRwTrBgp6AQcY4gZt4VPnfITL4JSmJisPe1D1dBpp+LbJ0aGxutsX6W0PKfG3UWGtPjT
         JvKHxTATIIiROoPCwvgLmKkY2HVJLcAu3i6b7LJQz3MaO8aT/65qtgXGO2UuTZTvJswH
         GoBPiybL/B7n3mL+NfpR8BumsCEhNmAUKaMepUvjNwm2M0qQN+HJNLv/OC5txvKmsHq+
         Qw0A==
X-Gm-Message-State: AOJu0YzNTQ6x55Nk4ZEfkwC1BlhUPnX+k7juvmXuM9Z4qXIUVs9nNF3b
	WyQ8+3c5l6pFHsKpkCcWTvQ=
X-Google-Smtp-Source: AGHT+IGB6b1STgkpJhSgj3KuApjLbo2cpOqH+Lo8IF+ZLe2NNqtVVUnWy/HbRsbdtahuuLtgdZIrFQ==
X-Received: by 2002:a1c:7510:0:b0:40e:50e9:9b0c with SMTP id o16-20020a1c7510000000b0040e50e99b0cmr1665802wmc.181.1705175356706;
        Sat, 13 Jan 2024 11:49:16 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c349600b0040d83ab2ecdsm10412099wmq.21.2024.01.13.11.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 11:49:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jan 2024 20:49:14 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-input@vger.kernel.org,
	coreteam@netfilter.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	fsverity@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	cgroups@vger.kernel.org, alexei.starovoitov@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <ZaLpOoi9qu1f-u5B@krava>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <ZaFm13GyXUukcnkm@krava>
 <2dhmwvfnnqnlrui2qcr5fob54gdsuse5caievct42trvvia6qe@p24nymz3uttv>
 <ZaKW1AghwUnVz_c4@krava>
 <nhpt647n2djmthtdkqzrfbpeuqkhfy567rt7qyqtymxejncbgr@4tpiyxy2sbcm>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nhpt647n2djmthtdkqzrfbpeuqkhfy567rt7qyqtymxejncbgr@4tpiyxy2sbcm>

On Sat, Jan 13, 2024 at 09:17:44AM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> On Sat, Jan 13, 2024 at 02:57:40PM +0100, Jiri Olsa wrote:
> > On Fri, Jan 12, 2024 at 01:03:59PM -0700, Daniel Xu wrote:
> > > On Fri, Jan 12, 2024 at 05:20:39PM +0100, Jiri Olsa wrote:
> > > > On Sat, Jan 06, 2024 at 11:24:07AM -0700, Daniel Xu wrote:
> > > > > === Description ===
> > > > > 
> > > > > This is a bpf-treewide change that annotates all kfuncs as such inside
> > > > > .BTF_ids. This annotation eventually allows us to automatically generate
> > > > > kfunc prototypes from bpftool.
> > > > > 
> > > > > We store this metadata inside a yet-unused flags field inside struct
> > > > > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > > > > 
> > > > > More details about the full chain of events are available in commit 3's
> > > > > description.
> > > > > 
> > > > > The accompanying pahole changes (still needs some cleanup) can be viewed
> > > > > here on this "frozen" branch [0].
> > > > 
> > > > so the plan is to have bpftool support to generate header file
> > > > with detected kfuncs?
> > > 
> > > Yep, that's the major use case. But I see other use cases as well like
> > 
> > ok, any chance you could already include it in the patchset?
> > would be a great way to test this.. maybe we could change
> > selftests to use that
> 
> I haven't start working on that code yet, but I can.
> 
> Here is my plan FWIW:
> 
> 1. Bump minimum required pahole version up. Or feature probe for
>    kfunc decl tag support. Whatever is the standard practice here.
> 
> 2. Teach bpftool to dump kfunc prototypes, guarded behind a flag.
> 
> 3. Flip bpftool flag on in selftest build and remove all manual kfunc
>    prototypes atomically in 1 commit.
> 
> I thought it'd be nicer to do it incrementally given all the moving
> pieces. But if we want to land it all at once that is ok by me too.

I think it'd be best to try the whole thing before we merge the change
to pahole.. I guess the tests changes can come later, but would be great
to try the kfunc dump and make sure it works as expected

jirka

