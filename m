Return-Path: <linux-kselftest+bounces-19042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1D9908BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3492284258
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A191C3029;
	Fri,  4 Oct 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU5DI7kd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B9381AF;
	Fri,  4 Oct 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058434; cv=none; b=k9lAU34mgPAK4R8jdS9SVwFaESdbHTSeo+k30HqraVQOeAyZ3hOCpAtQCzmzbQW+/FipiD+bZ757uMB1PmttjrSdaruZFCz2HKgxhC25dM3kDRBf0l/5/rUppGvmJ8ULfVDpKuqp5LOL0TP2lUV0MeAcCmn7DH9DviWyrM0p9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058434; c=relaxed/simple;
	bh=dJAfntnZzQya7mN+gT3g+rTVith19gd7qVwVeRJ2oBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjSlf8iy59b5Jmt9wXMKz6cdAPldNTCH4aMbnGxLmqeuioePWnLafTzqR5aKY797kNkGcxRRSiVg093X6ACq70ejeQOAKx/0/U+P2XqFnArJ7+22pl9JZ287GkJ+GFo0z1P2Hui6acoIC3kRFE/f1x3qzYba0a25ePty/U3LHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU5DI7kd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e0438e81aaso1487144b6e.3;
        Fri, 04 Oct 2024 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728058432; x=1728663232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPXkDiio5eXbULzjvO9np+NwvbpW7NE+9+S5kYGgGQY=;
        b=iU5DI7kd0+H6eY4m6GnNsM8C7pEBrbRSEJFcUQ6CoSwhCqnGuG91QBXb4DjZ2JCPdv
         BK0YsSV4WRK73VjHZMQITrEWoNbs/onFYwT+bRkLWz6Zyki5G31C6cuwnTYJ/NGFgPbj
         E6HbyCxSk2bwlgq+U/kt6tMdreIy5taDifJLs1RivmvssC/VMuBtP+SJAgpyCcHNHJWZ
         lA8CDNFuCJertOnnpaiA4ka3gaa2cSDDjTYW3V0YG78a+yn4PEMZ2CnpCDME2xqx69T0
         0NXuTh7VNMEoP4oifPwKK8T2UNRu1F63E9v3MxwVLm/Rk2/JyNVDPE7crZ7bzqyrDuFR
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058432; x=1728663232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPXkDiio5eXbULzjvO9np+NwvbpW7NE+9+S5kYGgGQY=;
        b=HWs6m4l6s6Twf3/+6/30L61UUPh4nqgHiEA0Cixc72santq3cY4s+5dCKPYh2jN740
         +uT4nhtSilaaRaKe0bICLhkFza5upNNIofCwbbhSDunJ3XHzw/Izg794dlTrSJPAIwi+
         OmDR9Kydl7OovTLYACR6Y+vYu+eREQcnHqtl1cq2PuuccHaBZlVlbK/qfyyZunsEGERu
         lJchh4ty+v0eyQ8J4JyAZigIqK0HANJK3t5UIoRI7XuGxMRYhnv0lM6YLWIknEYetv1l
         zSYxizlmh8c8lP1FSjxVBY7kwTc++Zc4FKrFVsISApf1C8j/zjTjD9T1N5N4zCTiDC7f
         vJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp7+5Oc+r3L5xDGo1VAnVE4G7dADVWRu5I1KwjcPV06PLP/J98NHc605rgWNpbjsnq+vRS3XkgSm+agnUiUwJu@vger.kernel.org, AJvYcCWYv02h2nxiMMqa8uexUrsG3HGfOaCyWKzbSLvrAweiUyPDeMTIBHPDTNCFBuTl3Hy2bO+RGPzqv64X+rE=@vger.kernel.org, AJvYcCXZ1n6aK2EmQR43/IGS4lxn4Qrb5XNCik1ydsqynRkuxi0auw7Rr8H9oCZXKuLKcIbcc20TobqZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyznM96SUGzezF5XZLq90SAF8mzLd/jemjr7Q7TnNQruKXd4nIM
	/f4LG322ZPKqEwlXobf23ehfepqVJ3w4RPxSrwOGMrjvCQHc55p01HCZHueknsh6ZCKUkZs1gez
	+/aEG8jKcFO6mSulspz75hKYq6w9W6oKAfWU=
X-Google-Smtp-Source: AGHT+IG2wG7zvp8lD22cxclwAlfI49tPJqndqP3wcYiVayug01oP69knhRI+zufZ7ETFh+vPoSdqohTHdIPOykVnly8=
X-Received: by 2002:a05:6870:c1d5:b0:25e:24a0:4c96 with SMTP id
 586e51a60fabf-287c1da0268mr2415162fac.11.1728058431958; Fri, 04 Oct 2024
 09:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net> <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 4 Oct 2024 17:13:40 +0100
Message-ID: <CAD4GDZyZruh+gbA+=Wu_2aSOnaF8R6eDRU0=EE0qnWe-bTi2-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 10:03, Antonio Quartulli <antonio@openvpn.net> wrote:
>
> +definitions:
> +  -
> +    type: const
> +    name: nonce-tail-size
> +    value: 8
> +  -
> +    type: enum
> +    name: cipher-alg
> +    value-start: 0

value-start defaults to 0 for enum so this is unnecessary. Same for
the following enum definitions.

> +    entries: [ none, aes-gcm, chacha20-poly1305 ]
> +  -
> +    type: enum
> +    name: del-peer-reason
> +    value-start: 0
> +    entries: [ teardown, userspace, expired, transport-error, transport-=
disconnect ]
> +  -
> +    type: enum
> +    name: key-slot
> +    value-start: 0
> +    entries: [ primary, secondary ]
> +  -
> +    type: enum
> +    name: mode
> +    value-start: 0
> +    entries: [ p2p, mp ]
> +

[...]

> +operations:
> +  list:
> +    -
> +      name: dev-new
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Create a new interface of type ovpn
> +      do:
> +        request:
> +          attributes:
> +            - ifname
> +            - mode
> +        reply:
> +          attributes:
> +            - ifname
> +            - ifindex
> +    -
> +      name: dev-del
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Delete existing interface of type ovpn
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex

There's no dev-get do/dump op. I think there should be one for
diagnostics and metrics.

> +    -
> +      name: key-new
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Add a cipher key for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - keyconf
> +    -
> +      name: key-swap
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Swap primary and secondary session keys for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - keyconf
> +    -
> +      name: key-swap-ntf
> +      notify: key-new

This doesn't work because key-new doesn't have a reply. You should
define it with an event: block instead. You can see the build errors
here:

make -C tools/net/ynl

CC ovpn-user.o
In file included from ovpn-user.c:8:
ovpn-user.h:1194:33: error: field =E2=80=98obj=E2=80=99 has incomplete type
 1194 |         struct ovpn_key_new_rsp obj __attribute__((aligned(8)));
      |                                 ^~~
ovpn-user.c:835:35: error: =E2=80=98ovpn_key_new_rsp_parse=E2=80=99 undecla=
red here
(not in a function); did you mean =E2=80=98ovpn_dev_new_rsp_parse=E2=80=99?
  835 |                 .cb             =3D ovpn_key_new_rsp_parse,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
      |                                   ovpn_dev_new_rsp_parse
make[1]: *** [Makefile:41: ovpn-user.o] Error 1

> +      doc: |
> +        Notification about key having exhausted its IV space and requiri=
ng
> +        renegotiation
> +      mcgrp: peers
> +    -
> +      name: key-del
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Delete cipher key for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - keyconf
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: peers

