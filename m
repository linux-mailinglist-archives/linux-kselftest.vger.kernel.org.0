Return-Path: <linux-kselftest+bounces-8000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1578A5724
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F131DB23963
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816AB8005B;
	Mon, 15 Apr 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjXxXsfm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5647F7EF
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197365; cv=none; b=npxID5d6sSUsmLmAaXfelBriXcmbyuHFckTeMgD4uXySgZsSr/ZFV2Ws+99roUZsYe5QccHpR0/1Pv4pZIi/AmDWKARUpZgS0G6Nl1IcgnSvpZoikMLju9fJte0rorwgQ5xI0L00kGT3c18H9QQDr+Bg1GK7KkCKiPVbJ+OECDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197365; c=relaxed/simple;
	bh=3Zh80JPSryowBZLANIsp7Zr2FfKLqAS7PBCMqtsGz40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVoTcGwr/Hohr6/6pS3+sf8FB4wgzHeDTHDGt/u0YLjOoM4El8Qi0d6iakeGTwwCLbrDjFbmkpNdGKK7lDzYJwC6e8UymXD46/Ihn0ehwpKURVEeLKHCHO7/tSnSif4nuzcTDzqQ7jSsz/tAe3yPSR5mDBRGuUQ678i4qsIkXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjXxXsfm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713197362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rKI2tlDGlTTbSFeh1O6HwK6knZX0i4+ANwkgdRtQfhI=;
	b=TjXxXsfmM84OvwIb50xrZAEKr/x5FbCUYnDXlzr0aqVTSrEgG2MqCZGe1IOb0nGuFKaaEg
	p0Vysrzr8R9u9WWwBBd3fYO7g6rCJ/82VzOgSRX+Ss6n5KnM/m1BUmKVllZea8UTZw0/kC
	L7xPN7V1PLHfhVemW3U3SW960Vgx84I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632--wJiRPy1PLG_hnDn-wkiJA-1; Mon, 15 Apr 2024 12:09:21 -0400
X-MC-Unique: -wJiRPy1PLG_hnDn-wkiJA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2da79470959so2426011fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197360; x=1713802160;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKI2tlDGlTTbSFeh1O6HwK6knZX0i4+ANwkgdRtQfhI=;
        b=LErplSqRVz0Qj6u2am+mKoxBzgKUfXDIZvXQmwNkg/BxQ51b7cmTVJAZqvWwSyEZFI
         oUiqk7pfjeUAGILUFPPRG5KiC29d8YbkAQuwkrBzkzbJH4b4frQpYCW0KTWKlJrKEF0g
         7E+2rShaxYT9mtaG0kT1xvdd6EI36O4a+lDbmDUnZkVsKZA2h9TuvKtbnGIIOmBuv9bZ
         G/4kmSUCZi5SCkqc/4qaPjDLVwohcvRbpLvYIHI2SZ0L9JO8BP01zBT2nGuH0ryniU7f
         w5IsT879mJHUDtPoDoLPEMLla8IYJJmLp5L8nXm1umqSFv6BU3Vr2/pIF9808Vdtyn5I
         ptjw==
X-Forwarded-Encrypted: i=1; AJvYcCUTgYDhkNa4/eWfUJFtrNV11id5D8YDMWWV+0GUq59gPyZ8pJF44kDJlYU9/tKsT7lFSBn8sTGX8nrpy/w4mIwIYExpdRlviT0mbkt0x/8P
X-Gm-Message-State: AOJu0YynymZOV0Q/f3XbBQ9OB9yBteMgBCMzIMbuxLV8vmfKHUjiHflH
	Johm8zQnyVIOrlhnDie2LwTqOnuSrb8bN+BalOgIk3q78jyvu9XUuOPBFqUjsnY2o7jNE4Tdsp6
	2SgRyiiwiA0N1Kojitz26AV8MNQTro+LGCHYPvTh3o/edCYJHWcn5iLsLnnyKxzDBCA==
X-Received: by 2002:a2e:7016:0:b0:2da:590:db77 with SMTP id l22-20020a2e7016000000b002da0590db77mr5288661ljc.0.1713197359827;
        Mon, 15 Apr 2024 09:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ANBrqbbcSLy7HUz6/jGdBvOrBvWPDcFM4Pn6JwGc+nZ3qpoeMU1dHED5oIYrroivu2hWVw==
X-Received: by 2002:a2e:7016:0:b0:2da:590:db77 with SMTP id l22-20020a2e7016000000b002da0590db77mr5288641ljc.0.1713197359486;
        Mon, 15 Apr 2024 09:09:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c139100b0041496734318sm20039352wmf.24.2024.04.15.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:09:19 -0700 (PDT)
Message-ID: <d6a773cd3091d07822e49049dc0a8c95066c9510.camel@redhat.com>
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: add a trivial ping test
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	shuah@kernel.org, petrm@nvidia.com, linux-kselftest@vger.kernel.org, 
	willemb@google.com
Date: Mon, 15 Apr 2024 18:09:17 +0200
In-Reply-To: <20240415073323.351c888b@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
	 <20240412233705.1066444-6-kuba@kernel.org>
	 <49deeded3764fd43b9af23f2f6e1b8f4ab599910.camel@redhat.com>
	 <20240415073323.351c888b@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 07:33 -0700, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 11:31:05 +0200 Paolo Abeni wrote:
> > On Fri, 2024-04-12 at 16:37 -0700, Jakub Kicinski wrote:
> > > +def ping_v4(cfg) -> None:
> > > +    if not cfg.v4:
> > > +        raise KsftXfailEx()
> > > +
> > > +    cmd(f"ping -c 1 -W0.5 {cfg.ep_v4}")
> > > +    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=3Dcfg.endpoint) =20
> >=20
> > Very minor nit, I personally find a bit more readable:
> >=20
> > 	cfg.endpoint.cmd()
> >=20
> > Which is already supported by the current infra, right?
> >=20
> > With both endpoint possibly remote could be:
> >=20
> > 	cfg.ep1.cmd()
> > 	cfg.ep2.cmd()
>=20
> As I said in the cover letter, I don't want to push us too much towards
> classes. The argument format make local and local+remote tests look more
> similar.

I guess it's a matter of personal preferences. I know mine are usually
quite twisted ;)

I'm fine with either syntax.

Cheers,

Paolo


