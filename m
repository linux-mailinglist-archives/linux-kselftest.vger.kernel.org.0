Return-Path: <linux-kselftest+bounces-9985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB58C1D83
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 06:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EF11F22FE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C114C596;
	Fri, 10 May 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYy31U+4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D913C3C1;
	Fri, 10 May 2024 04:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317085; cv=none; b=TI3KrXACUBUzGwlrVkzOZ/ZPgWJfCOL23JXsxmD0uYzeaHT1kHm/6R2IXhPG3m/iDRWfIu1QIhjzg5MOtBXYa8efbusdA0tBjH/0+47+RAN9/WM4Lmnx8Rb2/H7KVCHDWepRJRmyg+eZy3Hqf3QJZT7u0YGwuoEPLgYqdv4PRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317085; c=relaxed/simple;
	bh=ZfZhRWYMX4moU6HQ7mqkmcHxdy41tks5snJ397Mvqfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3l4U5wjUw2L/MTBe8WX5fKfnvHJVvM+1J2szGnJCbP+crrBxVGrUciSBTJGRhIK/DEX3S2UJeeFJeNY/pPtc4ChXkpJpUHHF8ZLWSKPxFu3I5k+vYc8BuOyRMqCUzg3uskHgLAdLs2+0nk+y4K1etiKuPg/JvEN4xFExyp6r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYy31U+4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2df83058d48so20582041fa.1;
        Thu, 09 May 2024 21:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715317081; x=1715921881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg99FC5PTS8Fg78W7A6USREyKpZrakyOalm2O94BqdY=;
        b=KYy31U+4BW1sjtEpUyr5mpKO9mLMwM0IpPNdQ3Lf97oIvhNXL21/fytBIB0gQqbNgX
         PkqCvgTvlq4n7p8RctphQJVhMwFgYDHmieW7Qxvo4royml0X8IxyiBChSXTKDIdpYVxW
         Ij0j0P6R50ypYdtyL+BBNGtQghSQ2OkkXaRLiIkgWw6TGBnZOfT6OAffFJHkL7W4fWj8
         70y6GUUC2w/4Q7VHf+Y7POBn7xSsdW6X3TmFm5SP5Ka8QSJ0MdelAsPYdE2rZJCZWZjp
         21vBZWdaRkeVmmEWwZdcIhRrQ9iPh3XpZQCMJmE3pJDxf/TYDTPA+JvyD5fSOCXb8kPr
         N8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715317081; x=1715921881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg99FC5PTS8Fg78W7A6USREyKpZrakyOalm2O94BqdY=;
        b=seaooP+f8XGXKrXLpUNnunj+JcWs6GCPm837vbeZqWD4eP1IakuJbbVmZZla0zj5Iz
         AKAZ7UdlKQCbreBrC2SLbEIZcyr7WOKSJ41tvGBXaUW3KlSLrdoiqwl5YUsUbLTczw3b
         d21CdmOHuHpxRiZ3EBMXfVD1/h5x136AjXOvIoviGqtqs4C/wZp5vSGfcwL2CnM4aLs+
         tjJwvqrazncxSgjMtvmadjRd6HVl8BDDiZBqS7x/kc2WHXW9aL4eBVQk+lwTxJBvaNDF
         FI80nGWaBSOGTwp5P10n5RsVszHZjIGPNmMVON4pSyqo4JYJaKFf1FAu/BOmX7C/4MJl
         DjLg==
X-Forwarded-Encrypted: i=1; AJvYcCW6onpGXal29O421S1Vzs30emts/S0TjfezoRpC1ncRh3XnpquQoT5l+syL+/ag7Ycas9FZlf1TenwrMTsasaxwLN7XbjBLFIX6Sam6KAg4VoPhXRz9ewQsA+UPNCCmVSTS5xI7vypK
X-Gm-Message-State: AOJu0YziER2+R6fcrU6wGi5/wAAQYpGz0xnkRVuEAEH1BNuspU8BIvnH
	QjgidSG1Fuigb3zbUs4+81nysdEMATcBm4QVHafHY5qHg0bsFSGqxPzC/SEjh1oM3S4X/ApQYOe
	GRRaSSeT06DDOW3VW5Ur2Ja6EeTiKKSR+igk=
X-Google-Smtp-Source: AGHT+IGrh8O/C3NIBVTu2S5+nnSDnAOzhVN56CUcJITw9k0zjx9lRzTL1AnlORZ9faJDiqiaCQKK7pPTPLMxprw/I4Y=
X-Received: by 2002:a05:6512:3b08:b0:51a:cafd:3872 with SMTP id
 2adb3069b0e04-5220fc736b0mr1012301e87.3.1715317081279; Thu, 09 May 2024
 21:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508040643.229383-1-ap420073@gmail.com> <20240509083819.GJ1736038@kernel.org>
In-Reply-To: <20240509083819.GJ1736038@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 10 May 2024 13:57:49 +0900
Message-ID: <CAMArcTV6zPVNjay=ka3NVEUq2iEZ_W2dy8V6UJkT9Mf2PRKA0A@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:38=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>

Hi Simon,
Thanks a lot for the review!

> On Wed, May 08, 2024 at 04:06:43AM +0000, Taehee Yoo wrote:
> > In the forwarding testcase, it opens a server and a client with the nc.
> > The server receives the correct message from NC, it prints OK.
> > The server prints FAIL if it receives the wrong message from the client=
.
> >
> > But If the server can't receive any message, it will not close so
> > the amt.sh waits forever.
> > There are several reasons.
> > 1. crash of smcrouted.
> > 2. Send a message from the client to the server before the server is up=
.
> >
> > To avoid this problem, the server waits only for 10 seconds.
> > The client sends messages for 10 seconds.
> > If the server is successfully closed, it kills the client.
> >
> > Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  tools/testing/selftests/net/amt.sh | 63 +++++++++++++++++++-----------
> >  1 file changed, 40 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftes=
ts/net/amt.sh
> > index 75528788cb95..16641d3dccce 100755
> > --- a/tools/testing/selftests/net/amt.sh
> > +++ b/tools/testing/selftests/net/amt.sh
> > @@ -77,6 +77,7 @@ readonly LISTENER=3D$(mktemp -u listener-XXXXXXXX)
> >  readonly GATEWAY=3D$(mktemp -u gateway-XXXXXXXX)
> >  readonly RELAY=3D$(mktemp -u relay-XXXXXXXX)
> >  readonly SOURCE=3D$(mktemp -u source-XXXXXXXX)
> > +readonly RESULT=3D$(mktemp -p /tmp amt-XXXXXXXX)
> >  ERR=3D4
> >  err=3D0
> >
> > @@ -85,6 +86,10 @@ exit_cleanup()
> >       for ns in "$@"; do
> >               ip netns delete "${ns}" 2>/dev/null || true
> >       done
> > +     rm $RESULT
> > +     smcpid=3D$(< $SMCROUTEDIR/amt.pid)
> > +     kill $smcpid
> > +     rm -rf $SMCROUTEDIR
>
> Hi Taehee Yoo,
>
> I think this cleanup may be executed before SMCROUTEDIR exists.
>
> For consistency with other temp files, perhaps
> perpahps it is best to move the creation of SMCROUTEDIR up
> to where RESULT is instantiated above.
>
> And perhaps the pid handling can be made conditional on the
> existence of $SMCROUTEDIR/amt.pid
>
>         if [ -f "$SMCROUTEDIR/amt.pid" ]; then
>                 ...
>         fi
>

Thanks!
I will check a pid file before kills smcrouted.

> >
> >       exit $ERR
> >  }
> > @@ -167,7 +172,9 @@ setup_iptables()
> >
> >  setup_mcast_routing()
> >  {
> > -     ip netns exec "${RELAY}" smcrouted
> > +     SMCROUTEDIR=3D"$(mktemp -d)"
> > +
> > +     ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
> >       ip netns exec "${RELAY}" smcroutectl a relay_src \
> >               172.17.0.2 239.0.0.1 amtr
> >       ip netns exec "${RELAY}" smcroutectl a relay_src \
> > @@ -210,40 +217,52 @@ check_features()
> >
> >  test_ipv4_forward()
> >  {
> > -     RESULT4=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4=
000)
> > +     echo "" > $RESULT
> > +     bash -c "$(ip netns exec "${LISTENER}" \
> > +             timeout 10s nc -w 1 -l -u 239.0.0.1 4000 > $RESULT)"
>
> Hi,
>
> It's unclear to me what the purpose of the bash -c "$(...)" construction =
is
> here. Can the same be achieved using simply:
>
>         ip netns exec "${LISTENER}" \
>                 timeout 10s nc -w 1 -l -u 239.0.0.1 4000 > $RESULT
>

The purpose of using bash -s was to avoid exiting main bash program
by timeout expiration due to 'set -e' option.
But Jakub avoided that problem by adding (|| true) in the recent patch.


> Also, not strictly related to this patch, it seems a little odd here, and
> elsewhere, to call bash in a /bin/sh script.
>

Oh Thanks,
Shebang should be bash, not sh.
I will fix it.


> > +     RESULT4=3D$(< $RESULT)
> >       if [ "$RESULT4" =3D=3D "172.17.0.2" ]; then
> >               printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwar=
ding"
> > -             exit 0
> >       else
> >               printf "TEST: %-60s  [FAIL]\n" "IPv4 amt multicast forwar=
ding"
> > -             exit 1
> >       fi
> > +
> >  }
>
> ...
>
> >  send_mcast4()
> >  {
> >       sleep 2
> > -     ip netns exec "${SOURCE}" bash -c \
> > -             'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
> > +     for n in {0..10}; do
> > +             ip netns exec "${SOURCE}" bash -c \
> > +                     'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000'
> > +             sleep 1
> > +     done
> > +
> >  }
> >
> >  send_mcast6()
> >  {
> >       sleep 2
> > -     ip netns exec "${SOURCE}" bash -c \
> > -             'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
> > +     for n in {0..10}; do
> > +             ip netns exec "${SOURCE}" bash -c \
> > +                     'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000'
> > +             sleep 1
> > +     done
> > +
> >  }
> >
> >  check_features
>
> ...
>
> --
> pw-bot: under-review

Thanks a lot!
Taehee Yoo

