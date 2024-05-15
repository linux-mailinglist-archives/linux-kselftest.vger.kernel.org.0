Return-Path: <linux-kselftest+bounces-10253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59C8C654D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2821C217A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61C627E2;
	Wed, 15 May 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2jODLZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CEF5684;
	Wed, 15 May 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771003; cv=none; b=tLFTfCp13Y9ZOIDcAtExGyWmfT+qr6z//qpjAdcYXyz4aRWfwLuk6/ji90WSCUI5MfjksW1nudYxf6tbE57Ki6tmKOsvA0mgk2rUvoEa/ozN+N3PcYnS50qahreRlKjJX6RehbZfl04FYHo0iiY4GoxbeSv1sLC392ROB0zNODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771003; c=relaxed/simple;
	bh=bhPWCNAUIK6VfX6XoxIhdW3f+hVkZo9HiaN1p3ULkuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/3nUVf+kuF0qyzPnRIauI4PiYAx33x6GZjWWaOCEyk8vR/HpgVSwG70aHLi3BpDgbI5kxb523VYJho8ycRlEPZykDHC89IXp5W/OcM7OeVlUc4vGTPM0pdyDNtH1DFniV0i8mgLu+zcifQbxxrTfR2jmUegiNYb6P7nUt9fduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2jODLZD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so2068773a12.2;
        Wed, 15 May 2024 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715771000; x=1716375800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhPWCNAUIK6VfX6XoxIhdW3f+hVkZo9HiaN1p3ULkuc=;
        b=I2jODLZD7VpFLPkrBw2Abr+rAbvL/CpQxBlU45ZUcPq8P67dhhGu1J9vJFETarZi2Z
         VGWvcDea66i3UalaTuyw+8xmVj/ZQqB4n4wtoCL2n/ecaWPAtF1LRjTg0MUboDcGCEpl
         LOiFjGEC5GcTE8lfonlkgIktiQF4ozNjfm6MejTrQk51j4TEkXGjIgVmyWkf3xXMDO9m
         P95ZYo3FLjiSS+KbuStjMqIYLVdS3mBSvYQpqhfZXfr1CQAQfDMct0nzGl7SGikYCMFd
         +kPwj0V6jH+hQZmzrNNwpasXgM3rlBUkhRqg6B1Pm+fNCJx6uP+L3BcYbFQNJScY9y44
         cy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715771000; x=1716375800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhPWCNAUIK6VfX6XoxIhdW3f+hVkZo9HiaN1p3ULkuc=;
        b=jYL0CSSsRzFVD5g5OmxjJLmjQ4iz4jcbhWbCQBMhGmENk5dhs/l47Gk9PyVAbOqL1r
         9wVhxhA/J9fEA1ydkla0wlUbyrdvrVsnOJZA/Pfv/vRLiVz4XDBGXz59V3NrOZoZC/VI
         XLoAwXVmLsQtX7VbiawXenzufU97YqY8pJVn2rH8sQPbnQajYcJqqai6B++gVll8Wb6N
         rhQL/iLgJt73A+H+FroCScoJ5acXASZ4Hg9H0lGwrcdaZM6wMTSZJDv28+Wjmve5SFoo
         OFT/enV81Db/AJAzpAS3MYDdPFZCc4/YVdrBluMA0xtVvZQL567/QaTAhDmaRi9lTsak
         EUaA==
X-Forwarded-Encrypted: i=1; AJvYcCXUKrr3er+NPk6vbDJNdoCagbIUi6vWKmtFHjA9RSStxYoROZMGIOtUku3bM6vqMrM21fwryR3Q9LkmBKCyjYtr4ypdioxSEORYwbJcjyLMNvJ7/14UWurLGmYkoKIujr/jjkQ8vEvq
X-Gm-Message-State: AOJu0YxRijf7GIUdQiDqJogod4hCeoCm0CwWNZ7PlyL2je0y9tHnkH2K
	xqxKt5pDphvKJDlhulvwu0q4j+fbblACI3ckFy+sazyhY7Iu26x8b2MZW5NVF+rIMnNGahIVoqc
	NHr+SUw1PEb7xlHbPZNB4/ufHbb4=
X-Google-Smtp-Source: AGHT+IEtXNaXRMhwfYMzWT333xACm9XANBbz96ElsQaKYUeGoZRpoAaYTuoUVKMvt1tPjthuQ3VsFiFR8s3pNeR7Ayk=
X-Received: by 2002:a50:aa94:0:b0:56b:cecb:a4c8 with SMTP id
 4fb4d7f45d1cf-5734d70603cmr16238930a12.39.1715771000175; Wed, 15 May 2024
 04:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513060852.1105380-1-ap420073@gmail.com> <20240515094831.GA154012@kernel.org>
In-Reply-To: <20240515094831.GA154012@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 15 May 2024 20:03:08 +0900
Message-ID: <CAMArcTW4G+_XM1Gf=1mJCptGYLEc=+b8FeOAD_+Cuba8tvjyKg@mail.gmail.com>
Subject: Re: [PATCH net v2] selftests: net: kill smcrouted in the cleanup
 logic in amt.sh
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:48=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>

Hi Simon,
Thanks for the review!

> On Mon, May 13, 2024 at 06:08:52AM +0000, Taehee Yoo wrote:
> > The amt.sh requires smcrouted for multicasting routing.
> > So, it starts smcrouted before forwarding tests.
> > It must be stopped after all tests, but it isn't.
> >
> > To fix this issue, it kills smcrouted in the cleanup logic.
> >
> > Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> > The v1 patch is here:
> > https://lore.kernel.org/netdev/20240508040643.229383-1-ap420073@gmail.c=
om/
> >
> > v2
> > - Headline change.
> > - Kill smcrouted process only if amt.pid exists.
> > - Do not remove the return value.
> > - Remove timeout logic because it was already fixed by following commit
> > 4c639b6a7b9d ("selftests: net: move amt to socat for better compatibili=
ty")
> > - Fix shebang.
> >
> > tools/testing/selftests/net/amt.sh | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftes=
ts/net/amt.sh
> > index 5175a42cbe8a..d458b45c775b 100755
> > --- a/tools/testing/selftests/net/amt.sh
> > +++ b/tools/testing/selftests/net/amt.sh
> > @@ -1,4 +1,4 @@
> > -#!/bin/sh
> > +#!/bin/bash
> > # SPDX-License-Identifier: GPL-2.0
> >
> > # Author: Taehee Yoo <ap420073@gmail.com>
>
> Hi.
>
> I think that the change above is not related to the fix below.
> I think it should be in a separate patch targeted at net-next.
> And as net-next is currently closed it should be posted once it
> reopens, after the 27th May.
>
> The changes below look good to me.
> I suggest resending only those changes, targeted at net, as v3.
>

Okay, I will send a v3 patch that will not change the shebang.

> Thanks.
>
> > @@ -77,6 +77,7 @@ readonly LISTENER=3D$(mktemp -u listener-XXXXXXXX)
> > readonly GATEWAY=3D$(mktemp -u gateway-XXXXXXXX)
> > readonly RELAY=3D$(mktemp -u relay-XXXXXXXX)
> > readonly SOURCE=3D$(mktemp -u source-XXXXXXXX)
> > +readonly SMCROUTEDIR=3D"$(mktemp -d)"
> > ERR=3D4
> > err=3D0
> >
> > @@ -85,6 +86,11 @@ exit_cleanup()
> > for ns in "$@"; do
> > ip netns delete "${ns}" 2>/dev/null || true
> > done
> > + if [ -f "$SMCROUTEDIR/amt.pid" ]; then
> > + smcpid=3D$(< $SMCROUTEDIR/amt.pid)
> > + kill $smcpid
> > + fi
> > + rm -rf $SMCROUTEDIR
> >
> > exit $ERR
> > }
> > @@ -167,7 +173,7 @@ setup_iptables()
> >
> > setup_mcast_routing()
> > {
> > - ip netns exec "${RELAY}" smcrouted
> > + ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
> > ip netns exec "${RELAY}" smcroutectl a relay_src \
> > 172.17.0.2 239.0.0.1 amtr
> > ip netns exec "${RELAY}" smcroutectl a relay_src \
>
> --
> pw-bot: changes-requested
> >

Thanks a lot!
Taehee Yoo

