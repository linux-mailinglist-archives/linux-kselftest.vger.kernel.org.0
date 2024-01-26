Return-Path: <linux-kselftest+bounces-3632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2783DF4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214E31F216E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FE1EA7D;
	Fri, 26 Jan 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJtRk4sX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901771D545
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288154; cv=none; b=OGsuatPUFCMO6UXQPJmlayrJGSWzjivfwxIk65mjT5CeHuDsEaA/Zf2o75XGOqXBL8cRJ8XAmBRSMWQSF4rYlZhsE8emCYNeeajxIZsFJTNO6JWjyR4NwOyCzoH6dqJ+9IKCclXnR33qXhvAf8TlajH05ORuYCg6qD/ruWO22jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288154; c=relaxed/simple;
	bh=+I5/JfhTh8N4crZsYQFWVRK+mpoMyrHA+HUVeSxJGso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJg0LYCovOVeRlsEbI5kCKH987DPKt6ehwSlt0mM1MkyzA02drQDwtJFqMGzRf2qqvNsAgRS6Px8tdLpfZVPEWh5iOq4lpDiPUbcYhoWdBgkXefryP5TlCJp2Y0//RUoD2VLMerg3OR15JXJka6jPJo5MiVIszNRw+LmLmiIt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJtRk4sX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706288151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XFnYFuAhwC0siVn/PaZOtFk6kpRUYwtbliZlwDKqto8=;
	b=CJtRk4sXs46GArRAtnR3DJN/yu8WCyoL/Ti3mmOmtkUlpwX6t8+/g+jusd8IFgym/b4nJ3
	Z4bSg8sje03RRJ4FsBzxPtbvgN8QrVhFsufTCmlLLSKXWaNSVFHMtgiKTa6Fz/FZhcMqvD
	JMuUGNyDdaY4SkRC3an5Z3LjE+F+0HM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-nGohXo3EMnGOzZ8OwDc1HQ-1; Fri, 26 Jan 2024 11:55:49 -0500
X-MC-Unique: nGohXo3EMnGOzZ8OwDc1HQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-337d5ce8e20so6931f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 08:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706288148; x=1706892948;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFnYFuAhwC0siVn/PaZOtFk6kpRUYwtbliZlwDKqto8=;
        b=wBgNz6+mwetjGDhIcSbme6DaIKFXqpYr85JbKGnMVUenAS+7nug0SKO0pYfjTteYm4
         6+NoFfDAsDGbkQiyl3YmOItavEwElzbtqAUsjSHxH+3cYJHRP8IhiOa5uSgby/SJbsnl
         G3j62cJ2rjc2TMAGMVkfvufwP1kU+bgKAlDjqzwI9H+ZUrO8Glp8cvacaKYm+552XWHk
         zezroCa6sukrztXJMhE6xVGQHgEff4MMHyNihmag71yQcziy3FNYcvB0Hz1Xd2oe5zkT
         RixBIGEZm8kEOnJpJCriD5yTJZq8ddyCPdOE72x1flxKuExk8VBBLd9BgfKNyN2eL5IX
         SN/w==
X-Gm-Message-State: AOJu0Yz9u9y8olDa7NGByPUfze9AEG0Ot9lfGqcUSKJY4F2iqHxckqm6
	wTUVX7/s91xzcHQMKj9m9H4lkwiStMFqbP0ypq9XFEog7Eu4EkdOxjPGjrcFJU5+9a37RzibsdJ
	gydzpS1OGTk677vBd24rY7iY1/ekjSKwp+XEOEM1vQa52z6mgPqMxInDH3zgwGwzNLA==
X-Received: by 2002:adf:a197:0:b0:337:2a0b:a7f3 with SMTP id u23-20020adfa197000000b003372a0ba7f3mr2382685wru.2.1706288148550;
        Fri, 26 Jan 2024 08:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwXDv4RQuO/10OLxa/AMtgg0oC55VuwRvXTyWztIhBiNriTkSW4dsWgFS9grBwari3V9hSEg==
X-Received: by 2002:adf:a197:0:b0:337:2a0b:a7f3 with SMTP id u23-20020adfa197000000b003372a0ba7f3mr2382670wru.2.1706288148157;
        Fri, 26 Jan 2024 08:55:48 -0800 (PST)
Received: from gerbillo.redhat.com ([84.33.151.31])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b003392d3dcf60sm1623570wrt.88.2024.01.26.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:55:47 -0800 (PST)
Message-ID: <eaf41d9c6942669343509d96ec82b85fc181d4ac.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  Xin Long <lucien.xin@gmail.com>, Florian Westphal
 <fw@strlen.de>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Date: Fri, 26 Jan 2024 17:55:46 +0100
In-Reply-To: <f7til3g130y.fsf@redhat.com>
References: 
	<21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	 <f7til3g130y.fsf@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 11:18 -0500, Aaron Conole wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>=20
> > The big_tcp test-case requires a few kernel knobs currently
> > not specified in the net selftests config, causing the
> > following failure:
> >=20
> >   # selftests: net: big_tcp.sh
> >   # Error: Failed to load TC action module.
> >   # We have an error talking to the kernel
> > ...
> >   # Testing for BIG TCP:
> >   # CLI GSO | GW GRO | GW GSO | SER GRO
> >   # ./big_tcp.sh: line 107: test: !=3D: unary operator expected
> > ...
> >   # on        on       on       on      : [FAIL_on_link1]
> >=20
> > Add the missing configs
> >=20
> > Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
>=20
> Thanks for the fix.
>=20
> Maybe we should also add the config for NET_ACT_CT since we will
> invoke it on setup.  I guess there's some dependency that must be
> pulling it in for us already so we don't explicitly call for it, but we
> do require it in setup() if I understand correctly. =C2=A0

This patch already adds NET_ACT_CT=3Dm:

> @@ -71,6 +74,7 @@ CONFIG_NET_CLS_FLOWER=3Dm
>  CONFIG_NET_CLS_BPF=3Dm
>  CONFIG_NET_ACT_TUNNEL_KEY=3Dm
>  CONFIG_NET_ACT_MIRRED=3Dm
> +CONFIG_NET_ACT_CT=3Dm
>  CONFIG_BAREUDP=3Dm
>  CONFIG_IPV6_IOAM6_LWTUNNEL=3Dy
>  CONFIG_CRYPTO_SM4_GENERIC=3Dy

Cheers,

Paolo


