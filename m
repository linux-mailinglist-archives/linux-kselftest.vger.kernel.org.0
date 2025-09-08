Return-Path: <linux-kselftest+bounces-40914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6072B48335
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 06:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6371E17BD08
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CC21D596;
	Mon,  8 Sep 2025 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELhI86dg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68621B19D;
	Mon,  8 Sep 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304950; cv=none; b=MYUtAMHA+hYPvkUhm5NeNouZHXkAeFUq5Lh1tilAAZjHEG4wIbxE+SzzW7L7O52Zw5dA5zkXXDlaHHRWh0rI60yT0FaGqNxsLr1rZrNKFX3tO4BCbGv2tdK5tZpagaP0iiizwYvvOL812SzZ6TladQZ5BI+pP2zMIX4fu3GfxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304950; c=relaxed/simple;
	bh=UCdNo4tJLMfRG2ThjczsmLh1pxSCdjn77qJ/oH+Pgh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEkOz6TVkWgs4rqKDUO5/DQ+vVHc9+SS1ZxDTFrn9xcGaX+sw9Y/uRmkHX51+7FRrA3BS2dS3oHJC/gPW+AqB3gImEu00D058mTR6psSO8wL40NBFnx8SNbdFCZds7UeThDIh1/xA5lk38JUVwgrujHY654cLdIfh1LIAWH/JbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELhI86dg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso3528234a91.1;
        Sun, 07 Sep 2025 21:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757304948; x=1757909748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QmVHYdYnytQawmE/GlyC7TmQ4rj+TZYEN+n5OB2Z78=;
        b=ELhI86dglR9AoiA6jVui4471PNylvXm6g4Yk1O/wM4ZVFdKy59JkZCILoe1ocJYhdF
         lOplp1AZ8GLIJQqWeIcxGs075oPAvmY9PKwBNJI4Ac06RLRsvvuV3pX8Lu2GqjRGDPkU
         vRNIb5H+py1mKf+6FbG3/K+E/Y9JvKr1cDnkJqbrv+/kl1jrjY3mSsNXnOioqPiaMGy3
         fZsDNY98TRnCZZyK+Zu6m9AkkmrpgsFSlG6TWZxSU8K8CoB0kPelBuNj972r7aRGNk6l
         oXlMR7P/cRG03RWF6IbdrHfiWos+EXhQjb0fBeau+p1wDQDp5jPowHgYiuXcLB/cojfc
         IPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757304948; x=1757909748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QmVHYdYnytQawmE/GlyC7TmQ4rj+TZYEN+n5OB2Z78=;
        b=jN17EnIskEy428SMFKEuOurI/MS60jyhZaMUyZ1TilpaL7ReV2EoYOFG/iwHy1ytg3
         jMiDVHYWywvBcji6QmrdclDB3m3lTFGf7f9RvIXCVAFDNlT3bxrUWyHhKhFuOMmSxE68
         /PMUY8hFwCvw/hY1RybgRy9kKpKqcW+8vk5cw1j4+Yogtzv6Xs5ufvtgG6hZhogPLMvi
         kdgsOPzsn6s+Tsk2II5WgIv9yWgrxwbws9eK7Pg4KqbsiHmyBfdDFyf2RFKGdTXHFjCX
         p0VAYU5Qq6bC/QFIdlNhRD8QtmoOWAYKS6+ASTJI4FpF/fC0gnH7kXEw9B2FJ9t0cLTE
         DBiA==
X-Forwarded-Encrypted: i=1; AJvYcCWnL6NogU11RzX8uxy/pYseV3BJNA5pWGOx4+hEWdah6uarvwnO748bjRWJM7MXWp41LJMz+C/C953dXP1ni1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++licmg5nMjb/DFPpTojnBAWPk2Vp6YedqX71gCRIyXRlcdlc
	MNfCQRqP5jmvItuOeYL1RFQ117cs0x2ltfW34dsb1dfYzmbcsaty8Yup
X-Gm-Gg: ASbGncsfKQ/JcxNK61KkZq/XWlyNsjAg4aDI7cuRlmN+gkOucA/vSXJjsreF8KtIAu6
	cM4aFHQqDbpQZ/juW3FrXVVDzmHm/xU1swjmdMu8cxo+Kq1vy1vZyMJt19alfr7Gpt7yNK+jJAr
	FH0aWiceOsXU/zO04JHr43eg7Gj4GSEKumNRlbkeXyGzN5i4mFmXdHHgCUKWGQfvS5O18AISiCS
	tboXp7Ww1pzsGvg6W+A9ZfEmy8mY64Oyid1gE4VqMiK8rlZ0UTXxmLB+8ABJYxaIqdFUgUeClQv
	IXE+yZwrTOvkHo60xFrwR/crVA4rSLYPVLep5/Ilz3+7nJf/daYt6zCjySpi8o5tBkxc9kQ6BBR
	7kIXPaFzhwo+doUt2K/RScZZ8cvs=
X-Google-Smtp-Source: AGHT+IGFie3VQxK6NB2GC5r4dkSoil0H/yHLmWPqvuY/cl1GmZ+3lR6o3zidk2O+qIHaVF5KClDjCA==
X-Received: by 2002:a17:90b:1646:b0:32b:7475:2aa with SMTP id 98e67ed59e1d1-32d43f9346amr8616078a91.26.1757304947965;
        Sun, 07 Sep 2025 21:15:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93317f0sm29097956a91.6.2025.09.07.21.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 21:15:47 -0700 (PDT)
Date: Mon, 8 Sep 2025 04:15:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL5YamjbZB5gsL30@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLyoEiWnuvQ-5ODz@krikkit>

On Sat, Sep 06, 2025 at 11:30:58PM +0200, Sabrina Dubroca wrote:
> > +check_xfrm()
> > +{
> > +	local dev=$1
> > +	local src=192.0.2.1
> > +	local dst=192.0.2.2
> > +	local key="0x3132333435363738393031323334353664636261"
> > +
> > +	RET=0
> > +
> > +	ip -n "$ns" xfrm state flush
> > +	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
> > +		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
> > +		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
> 
> It's maybe not something you would expect, but this codepath will not
> check that NETIF_F_HW_ESP is set on $dev (you can verify that by
> running "ip xfrm state add ... offload ..." on the same bond+netdevsim
> combination before/after toggling esp-hw-offload on/off for the
> bond). Why not use __check_offload again for this feature?

The esp-hw-offload is fixed on netdevsim

# ethtool -k eni0np1 | grep -i esp-hw-offload
esp-hw-offload: on [fixed]

There is no way to disable it. After we add the netdevsim to bond,
the bond also shows "esp-hw-offload off" as the flag is inherit
in dev->hw_enc_features, not dev->features.

It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
is try set xfrm offload. As

static int xfrm_api_check(struct net_device *dev)
{
#ifdef CONFIG_XFRM_OFFLOAD
        if ((dev->features & NETIF_F_HW_ESP_TX_CSUM) &&
            !(dev->features & NETIF_F_HW_ESP))
                return NOTIFY_BAD;

        if ((dev->features & NETIF_F_HW_ESP) &&
            (!(dev->xfrmdev_ops &&
               dev->xfrmdev_ops->xdo_dev_state_add &&
               dev->xfrmdev_ops->xdo_dev_state_delete)))
                return NOTIFY_BAD;

Please correct me if I made any mistake.

Thanks
Hangbin

