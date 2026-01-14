Return-Path: <linux-kselftest+bounces-48954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600DD20190
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CEF2300530D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B77389E13;
	Wed, 14 Jan 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOClJ7xB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E9299922
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407093; cv=none; b=AAnBPk9u1fw8jbb2co16+1L+nMNDSZKFKR1xDjr8VC8n8WINAQyxahChLJ7TXA5K/3/G8tDGxi+BCvoMR6Aem5esf+yHiQcf3WBx9qCXkbxUAM7LNmfusbotTGjslPersRLbd+PoUDxuE/xOrSUNmqp/LUsu803hx/kSUZLyWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407093; c=relaxed/simple;
	bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O1S4ZyAl1XcJ0xGlvonY3UIcOGE4mdwG0lScYsYcKaa3GXfMrbLRG0ltVO+K1AlUgCcRU7b5LHpzXgBHTl8qIZj0pgqxu2yGOli1VcwQLfI/aw3LdkIwqu7NR4TxyRkj0z1EH4OuEhhGWzo1jvASGU1rmywoPyKAzzw8Fgl3irw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOClJ7xB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5384ee23fso31428285a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407091; x=1769011891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=WOClJ7xB7lsFmXaBv09/+xnLsOb30Hr1Lc9S3jbXYZSm3z02tiKRv06d1vkDIyMzu6
         dWxq4XzEssQox116YjQ7wcjq8/9wuotufrwSAEO/AZKKUc4HIdLiGhpJPlyziwr8wUP7
         BMpTFTwr3GA1QJZW2fPahmfIi9pmU0TQTaBC8DRYTFMYvax1riYpK4mauASRrPhu/a0Y
         TSjDd76J75FZEAKv0qERCZQ/OHtzte1Uma6Q3C+29HPD6+EVuhEtbFmaEWn6sS9Weljb
         WywcO3VSoj7whXpBPJF9rXGotEcb1JK5KJZRIMSFGxteClNgYMnZki+jtxRnISdY80uH
         3GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407091; x=1769011891;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=BIOgPT1rJGfLgVIVqHBhmBf4obHTDRLK4X1ClBYR5sC6RKiwO4SKWWoBsuyXdGfYkC
         mNK0DLHexo0mvIuan8d5HqTH+okKzYeuxbvvDqwIcsQrfctCzaA16fPoMyEqle+hLvom
         PMSd1LfY5YKreIeCSrKYSxzvXBswkKHPtiVH/5/76ytdbeDqPWN94Z2+B0Jn8FgYSeZy
         qtbsQDunRHEiZk82o1a0CEtbnI5KKn/v/sfbQuVPm3gZqKxAIOseWOlvjD7/mhAJPq/6
         +ZvwwfQS5JCFYNnpYJYKPjJzSOWkKq2MPYVoVOJTEdpwYZf+f/Zm+HwgHibRKWbjUfGP
         ugsw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHd0Qcj24p5Ld/rZRAH4LyI+PUggzIXlJn4RLWzp7dZf5xt7rukAnJCI0u8HmMWCW5h28igCb6v9xZkt12WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvwt1cmFb0Djg6ZqKXAZx4GuwIykqp8S9ZFDzaoi7zl/yjC57F
	ckYIi2oo+RRRgzW1k5WkcnLR0rxo3PstBsZc0dqNPiDe7JLHMKaAPuyz
X-Gm-Gg: AY/fxX5Wn0vYdZ4V2I5MFM2sIlfWni7zzZ4VyVgMGlPMR+Sm73JYpUcjJsldmSBVNbE
	3LUCfyP/Yk7ke402i+krW6fuHZ7xJw2n1myBf7CvcIOKXjKie4xcroLx/A3F2SziOVmckGLo0me
	ihhAr/tS5D1rmOLUYkQYs1WwKC6eUuSVNt8GM9775n5kRKwBJ8SUty5tN2Bt9rlk82fyvmYq4p3
	DdRTElKNmaCRaaVGTwjQP2Ru4aPTuCr/Aa94kuQsffFcybcvXP2yQJ62epYqN8iNzleRm+RjA9/
	EAdqWGDZQVbhxdM3urNS0pyABNJwMxpfz7+lKTuAFMb8M+fdMGfyN/f6n9LE6yu9qgxWtr8SC4y
	76hz+e9ErTDNKOMEMCOSl8S/NxoSUxIlS5OLIjMVBniT8CyoiNH/fnJ8DRHLEVP96Y183F48kd1
	80PJiHKGoCZ2N25mWIyTHZzD6EVrFH4jEdNIKOe+X2JLSYfBvVOJRsL/K4kvI=
X-Received: by 2002:a05:690c:9c0a:b0:78c:25fa:1bb7 with SMTP id 00721157ae682-793a1d6fa34mr22055957b3.60.1768400306350;
        Wed, 14 Jan 2026 06:18:26 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670ec0sm91265417b3.36.2026.01.14.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:18:25 -0800 (PST)
Date: Wed, 14 Jan 2026 09:18:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
 Neal Cardwell <ncardwell@google.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "parav@nvidia.com" <parav@nvidia.com>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "corbet@lwn.net" <corbet@lwn.net>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "dave.taht@gmail.com" <dave.taht@gmail.com>, 
 "jhs@mojatatu.com" <jhs@mojatatu.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
 "ast@fiberby.net" <ast@fiberby.net>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "ij@kernel.org" <ij@kernel.org>, 
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
 "g.white@cablelabs.com" <g.white@cablelabs.com>, 
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
 cheshire <cheshire@apple.com>, 
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
 Vidhi Goel <vidhi_goel@apple.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.a2eb52bfa5d5@gmail.com>
In-Reply-To: <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Subject: RE: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com> =

> > Sent: Thursday, January 8, 2026 11:47 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-d=
oc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org;=
 kuniyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.tah=
t@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andre=
w+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org=
; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@erics=
son.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@c=
omcast.com; Vidhi Goel <vidhi_goel@apple.com>; Willem de Bruijn <willemb@=
google.com>
> > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill pack=
etdrill cases
> > =

> > =

> > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional i=
nformation.
> > =

> > =

> > =

> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options =
to =

> > > cover several scenarios: Connection teardown, different ACK =

> > > conditions, counter wrapping, SACK space grabbing, fallback schemes=
, =

> > > negotiation retransmission/reorder/loss, AccECN option drop/loss, =

> > > different handshake reflectors, data with marking, and different sy=
sctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---
> > =

> > Chia-Yu, thank you for posting the packetdrill tests.
> > =

> > A couple thoughts:
> > =

> > (1) These tests are using the experimental AccECN packetdrill support=
 that is not in mainline packetdrill yet. Can you please share the github=
 URL for the version of packetdrill you used? I will work on merging the =
appropriate experimental AccECN packetdrill support into the Google packe=
tdrill mainline branch.
> > =

> > (2) The last I heard, the tools/testing/selftests/net/packetdrill/
> > infrastructure does not run tests in subdirectories of that packetdri=
ll/ directory, and that is why all the tests in tools/testing/selftests/n=
et/packetdrill/ are in a single directory.
> > When you run these tests, do all the tests actually get run? Just wan=
ted to check this. :-)
> > =

> > Thanks!
> > neal
> =

> Hi Neal,
> =

> Regards (2), I will put all ACCECN cases in the tools/testing/selftests=
/net/packetdrill/
> But I would like to include another script to avoid running these AccEC=
N tests one-by-one manually, does it make sense to you?
> Thanks.

All scripts under tools/testing/selftests/net/packetdrill are already
picked up for automated testing in kselftests:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D8a405552fd3b

