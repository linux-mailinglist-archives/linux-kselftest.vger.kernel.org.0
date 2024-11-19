Return-Path: <linux-kselftest+bounces-22235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BA9D20B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60581F243CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153D14F9E7;
	Tue, 19 Nov 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwOO4Dwq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EF8F64;
	Tue, 19 Nov 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000951; cv=none; b=lUDMMnrq4DrRK9+RmgTeHHmRyljlyTZT4kczRQMBfEZuGBlYlFQJU2dmjRi8FJD0epjAfOdRVXOD2uVUdEY7JW9lvC9fDt2kduVA4eYp+mZ9GvO2+N+IjhJCZqbk8lmBWShYsLUcG1TDmjmKPaPA7kTa71pK0Dr59i6f98Ljc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000951; c=relaxed/simple;
	bh=jYlYgZzrV8+PMmnVm6Kn+6PH4Ajo+OUPHV/oleWSmSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnn0YDJENHUUutuVQsPNsM5kHP6rkdd6a66S/kO9Hbcld7BICX6Iam2xOUw6e3lZM5uG2Qv0Mg9TkoNVbDMtZ+emmOIiwT0tH33X1Y0H14DzxtDMWlspNShTKHJrzb2q/X6q+58PDFeLY3CtohbAK9Peq6MnLFvjSPDvVlf82r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwOO4Dwq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so3244973a12.0;
        Mon, 18 Nov 2024 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732000949; x=1732605749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2hYIOgm2Uff4u1jweT3m4e9LzzXMUoAloHgshXGR88=;
        b=YwOO4Dwqg0SA2JWmX/uqbvUYao4GW3lz8HFniW3Mc6vUxtaS+ogDE74jKJKUEn5nda
         RONpVQMLWkeq7fep4cBDG/4IgVkiH88meL0aZ8M5thciMFMe3H0ddBUpZT/7yZvULoBI
         1H8rz0SHF5Vta+pKyHaYjyO/b28CY0SZ5yleiwhTeCBmVAfB77kfAVUVqToQb+hNO3YP
         nS+dResOAo6fgOCzAZ55MtdNZMtSr8rhnShCaDZYlzzgXDOOcrlBqNR5s+BLC5E3JFio
         1oLf66waINGNLKGMmSLsefcBLztQ320YpIJL517OxOGAL1zhQPWmtf+J6DpzWjsxFYKN
         VZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000949; x=1732605749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2hYIOgm2Uff4u1jweT3m4e9LzzXMUoAloHgshXGR88=;
        b=K66lQym8RkvkoPTZTno7PKYTpnijow6Dr3SyBVOP4fIUb+h+mXsjwEYOy1DKiGmu6Y
         mEu0SWxifv10RSEKgbe0T9dN7aWyH+A6yakS6/HTovZR8+DXB1mZyw2kQEV3nbECIJjW
         Pk/QS5y/NAfBpOMRIvsZdqf3PkE4NyzD1djE6Mv35SuoscLB0aHD6ZMZVjgmv956WZi1
         Yq/berQDY7NNG7mBISCVDJNghs5tVrsQ4oZJTS1jN61Ib9iSRDS6mAWHt72qoXOJkXQM
         yRpMwd25nVwnnLm2f8LdHfasZ7LNoWRT2euP1TSbxRsjozJ/dei1w0CUuoByj5ZeU6ax
         GltQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIxp3w/8EBgC2TZCcFg3OwXh+cXVa8+jDCcomP/z3AMDlfCXD1XwfYYyUtEKFDlRchq8+jHadjl9MXl6E=@vger.kernel.org, AJvYcCXzQBAUshSS6MAKQ69eFZ33CCBticgKTaq+WdE3XmD1FP+l4bA5mrMIMQ/W8IYAdkp1hgUYu5+3/2Od3Zuo7z57@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu9ETkA/5iphe3Xt+eheBz3+NQ8u2mxqCeSs9BF5fSYAnKhT6
	tsLmaakdpb6Z2KmNj3Kqu7Nu+QpajRqLSbFSlZDI9Ng0IiW7m9Yd4e5Z9Rd/Sg4=
X-Google-Smtp-Source: AGHT+IHpjvOJ/TXR1vPPwp8b3+0f5TCsPpSfNMW9tcKmYwoCx3JQ4QjniS/QesuBZjjSmzoHklC+3A==
X-Received: by 2002:a05:6a20:918b:b0:1dc:c19a:3a08 with SMTP id adf61e73a8af0-1dcc19a3e8emr2133510637.17.1732000949359;
        Mon, 18 Nov 2024 23:22:29 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea28300b26sm6257086a91.16.2024.11.18.23.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:22:28 -0800 (PST)
Date: Tue, 19 Nov 2024 07:22:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] selftests: wireguards: use nft by default
Message-ID: <Zzw8rb202R6FWVHs@fedora>
References: <20241111041902.25814-1-liuhangbin@gmail.com>
 <ZzpNXM17NX3nVzMl@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzpNXM17NX3nVzMl@zx2c4.com>

On Sun, Nov 17, 2024 at 09:09:00PM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 11, 2024 at 04:19:02AM +0000, Hangbin Liu wrote:
> > Use nft by default if it's supported, as nft is the replacement for iptables,
> > which is used by default in some releases. Additionally, iptables is dropped
> > in some releases.
>  
> Rather than having this optionality, I'd rather just do everything in
> one way or the other. So if you're adamant that we need to use nft, just
> convert the whole thing. And then subsequently, make sure that the qemu
> test harness supports it. That should probably be a series.

Hmm, try build nft but got error

# make -C tools/testing/selftests/wireguard/qemu/
make: Entering directory '/home/net/tools/testing/selftests/wireguard/qemu'
Building for x86_64-linux-musl using x86_64-redhat-linux
cd /home/net/tools/testing/selftests/wireguard/qemu/build/x86_64/nftables-1.0.9 && ./configure --prefix=/ --build=x86_64-redhat-linux --host=x86_64-linux-musl --enable-static --disable-shared
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
...
checking for pkg-config... /usr/bin/pkg-config
configure: WARNING: using cross tools not prefixed with host triplet
checking pkg-config is at least version 0.9.0... yes
checking for libmnl >= 1.0.4... yes
checking for libnftnl >= 1.2.6... yes
checking for __gmpz_init in -lgmp... no
configure: error: No suitable version of libgmp found

But I can config it manually like: ./configure --prefix=/ --build=x86_64-redhat-linux --host=x86_64-linux-musl --enable-static
--disable-shared correctly

Do you have any idea?

Thanks
Hangbin

