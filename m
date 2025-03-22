Return-Path: <linux-kselftest+bounces-29599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D859BA6C8AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965591894FAD
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F11E9B30;
	Sat, 22 Mar 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8j/zwb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784341E9907;
	Sat, 22 Mar 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635528; cv=none; b=JirsG45PXTKQWCkXWP6huHEx8nXCilxa+tCxIP6mr8A5zT8vu25RwEGK6PtV0a6ju8aCrDlixV0uUBqZavONxGpkbKhKgMBlQwI6J40EB4OUezzpgZkfBcBMLcab12GELHsqqztDa56JqEyhQIYi8yndY4ptiqNRCW7gJAwTkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635528; c=relaxed/simple;
	bh=zXysE9+eZmHFbPbkVxXeKnl96KXqFxCLHJZD2dVakVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEfsrOHomYbLxnl6rvW2F/Y5R7NBhBnE+Y0ASprgci069o1J1BKpZC6jQ9YynnCQGEkh4+pzAlEuuJWeQ95BIIST+/K2k6QhHMP0qgCeS5C6L+ibusbrsA0Vk1pxM6X95eQoVNVYs88obU9NTllyrVUW86N0A87cm2KC9Myn8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8j/zwb0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239c066347so65130835ad.2;
        Sat, 22 Mar 2025 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742635526; x=1743240326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAxmjD+4ShrH2qVul5h8U6ZQKpv0SeH27W7krvXTAuY=;
        b=Q8j/zwb0Mg0pQA3ua9J3X3jGEhWLIEEyBGM/UEEnOF/sMGDsj1TV1DYcTjj5jOylJh
         +MN5Nfbm+qbfZI6xwMH3Efyv+PUYeWDeKvJZurd9H3edORcYhPXD/lNIb5wTV/KavI0Q
         pQ7QVqp4YTT4q6bDOUAX5cBkBGDlP0/GRGqmTiVXKKdKyX2Np+59F8mQQyVcuPK/Dftu
         +smXJt2+4CGHiIEWgy6pauCVK5sOOLlVa/ZJPhckMuhl48OcSrKe1sCzm85yFnIwq42U
         XD8mGpMuBmDi5Ke2fNtPfJniag5v2HuM7yWdwcB3HSChq/uhx3U5NpaZLlEk7HFnUauQ
         w6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742635526; x=1743240326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAxmjD+4ShrH2qVul5h8U6ZQKpv0SeH27W7krvXTAuY=;
        b=MfJC94sUp7p6dtlGOFI2yZF95XZbdois1kR4OmBtD7FHiFHzrNPfGiHcJfzmNPuUkL
         m3vXYz6uwL9K3Ly7Puc6unfJZ12HrWHpHf2x98fYgE9L4fX3TUXvhkOXFLyLWkMfRAEI
         i2q1xXYw62hhYVZGKsQMJ/HLLsh8rwiw7jujuF/WD2uza92IH21KaOl+DGlwLVoWNaCh
         bS1zWaCsI8Zq9dEUj23glKIeBAfyj+hrR/FaPyrxpAaMrAq6lxpFIDHSqCV1DACpfTnt
         As6+/LVChwkqCgJTL9IEUmOJyRYWIGCpn/itbP3UTvSD2xN41fzVsE2UKmfDAVIcDDhT
         Ai1A==
X-Forwarded-Encrypted: i=1; AJvYcCURCzda0XDB7trjzMGCBf68FhxNYvM+RscVNNR7eJcpui6Q/HnlCpumnIfnSwAyLZVWHVg5ZnKNRNzF6ama@vger.kernel.org, AJvYcCVREvE5U7pt1yJzvjChC3vBQz1aopThKRR+WZiFFTjQ2AWommME+VT9GvUf0S1O926/f64ojw6DYrnA1mjBlnPR@vger.kernel.org, AJvYcCW6qznKGl5xNY1aH26HrilTKDXVRFqWntMdy3ZLBz6DFGFAdNEIOeUGbmCn2a4SaKrqhHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgX4RSLD+0NsHWtiC9IWo/TWkh2NamyPnUMPVrQOrRSbuSemZ
	P5XXrvKbcbQ+wxx9Owzv6fFeBpUgQAcSIf0MRoSiuZcEFqnqnN0W
X-Gm-Gg: ASbGncunB2ZrsxQ+X6wI5+Q5bxHpoTsgqx0G+K0URSOuadg2XNM8L2J5nz7FTNalNbq
	ANqDulV7gE6GtYsBY3mHO/PHiDVttdwZ7lrexy08sWVklbtark+wNeIix7kKCElymF95UyeFLxY
	FObmXPq0XGKfiPGz9BOOBeQOBtspFJApYPIYcYFCfONmxzeE7f7+7qV7q8pR7QOZLzwmA1rAUQU
	2Ionj23zEzM3yi3sCj+W8eLJ8sqMtMEOs7ipYH95RZghczURn4gGjhwYT7/xNu83skNQvFuy1lM
	dlCviUkU+6FPAG0VyvsspCgNuk1kv6JfL3wNormOqXrIlHp+Ow==
X-Google-Smtp-Source: AGHT+IFSu+bGGQRjawLHDtslf0SzwTbnDI1kjP5psSX/njED57/1HtiodD8whtxKMq7t1GftztQyIg==
X-Received: by 2002:a05:6a20:72a0:b0:1f5:889c:3ccc with SMTP id adf61e73a8af0-1fe42f74ff5mr11146522637.14.1742635526324;
        Sat, 22 Mar 2025 02:25:26 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a27dbb2fsm3230302a12.9.2025.03.22.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 02:25:25 -0700 (PDT)
Date: Sat, 22 Mar 2025 09:25:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Phil Sutter <phil@nwl.cc>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z96B_VRDHZHPn-2w@fedora>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-3-liuhangbin@gmail.com>
 <Z9rtrVk-15Ts_BNp@zx2c4.com>
 <Z91CGRP9QLdZONiZ@fedora>
 <Z91QshzKRlmPdpv7@orbyte.nwl.cc>
 <Z91fXURX3BQFDaq9@fedora>
 <Z916VMSCEtinZl54@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z916VMSCEtinZl54@orbyte.nwl.cc>

On Fri, Mar 21, 2025 at 03:40:20PM +0100, Phil Sutter wrote:
> On Fri, Mar 21, 2025 at 12:45:17PM +0000, Hangbin Liu wrote:
> > On Fri, Mar 21, 2025 at 12:42:42PM +0100, Phil Sutter wrote:
> > > Hi Hangbin,
> > > 
> > > On Fri, Mar 21, 2025 at 10:40:25AM +0000, Hangbin Liu wrote:
> > > > Hi Jason, Phil,
> > > > On Wed, Mar 19, 2025 at 05:15:41PM +0100, Jason A. Donenfeld wrote:
> > > > > On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> > > > > > +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> > > > > > +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> > > > > > +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
> > > > > 
> > > > > Can't these be statically linked into the nft binary?
> > > > 
> > > > If I omit these, I will got error like
> > > > 
> > > > mnl_attr_put: symbol not found
> > > > 
> > > > Even though I set `--enable-static` in nft build.
> > > > 
> > > > Do you know what's the reason?
> > > 
> > > I was able to have nft linked statically against built libmnl and
> > > libnftnl by passing '--disable-shared --enable-static' to configure
> > > calls of all three build systems. With --enable-shared in library
> > > configure calls, nftables build preferred to link against the DSOs and I
> > > did not find a way to change this.
> > 
> > The patch is using
> > "./configure --prefix=/ $(CROSS_COMPILE_FLAG) --enable-static \
> > --disable-shared --disable-debug --disable-man-doc --with-mini-gmp --without-cli"
> > to build nft.
> 
> Do you pass that to the configure calls for libnftnl and libmnl, too? I
> didn't find a way to force static linking in nftables build system, so I
> disabled building of shared libmnl/libnftnl libraries.
> 

It works after pass that to libnftnl and libmnl.

Thanks
Hangbin

