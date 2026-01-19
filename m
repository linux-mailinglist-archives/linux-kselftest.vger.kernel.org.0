Return-Path: <linux-kselftest+bounces-49359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17BD3AA10
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6149B30057EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB9366DDD;
	Mon, 19 Jan 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZBuxTvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84236654B
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828595; cv=pass; b=UkwU6fWu7heE3SI/JaT+n9XBlKkxkLU0U4ng2XbYtMh4FsTTfV90Nn36fcXN0eGqKGWEJczomUUOAnaZDtItZnaKnDbRMC60SVkq/19IVuc2w7ZdauNii3GLaiKJHnJG/PE+9OaZTapEa7P4PfYqR9O1Q2wq1rXnaRc3QiAHU48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828595; c=relaxed/simple;
	bh=HDgZzyCVwi6dTQrQdHlplTvT19WWgr0rTwBPV63gNaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wasxc6pXUStsUdVUzfkhBdUQe7HRc9EMkP1QR566qUbenhJqaIuae7DPOTuFUdgJIWmO9ATCiUGzowGZ3D+iGJzz/nt9QCsUEUnXXGfHo/o0oR+Ihu2TMbNPsL/nBBJAWRNmg/KbWCTEdP8GILmnlbfGP+MH3guPktB925Rehuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZBuxTvZ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so5051294a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768828592; cv=none;
        d=google.com; s=arc-20240605;
        b=JFIdj946qMh/CatByMMFsQaM68w/jAY8QEDu3LHr3C3Mm/0JllliYKLesIWZfrfCRG
         YIYjfkRvlegiBF1rFQpKAbJb50P7DU51+LpC96j4vbcfuBMnlLcOESm1X2VpkjfwRFv1
         eYVj3DKvJVRO06iLCwvb7ULh6zM1gaFSf4kHVp5KC3J96EJCT47qOKGEJOsQfBjHqFa+
         ol046paYRYFBP0hJmuINGEgbvq7ELtIab5IfZ10ui4IPZsN0rjLSzqq/btt3R5ttqhrC
         1mQcpMFrhAUGfIwke355zCNSvkpt13pdUgC/NH1zPkTP06UKdS55e8Qk+G+xNzodlHaL
         s7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        fh=fz5nMGTyyr7ELiuqtsG2y3plA+mhV/iz2Uovzq8/gcY=;
        b=F/d+XbF+jQn/NrnG3nQe4aqskqubwaDbwVscbiA+PRwPYIBPw/pdhqyg4yvK5Pv4jF
         pi3ifI7Oayvwre++CMyjy3WR4l9rp81h7577zva0ITuVALsNyfvKKZebjTXnpg5mXLod
         h7CY/T2Ue10ZqOkAHKPGfuzvqVHf/KhO635Y8vNVtaYH+fJm8XYuHcCP9sjEOC63r1VS
         wBKpFpDgUoi475hgROaoKKWzi+5VnqFy1bxHJiDXz1OFx5jZWjBnMVES7MpxF/ws6YWc
         9uGYgWEY71JWTrv4cIsru4zR97xUtwMCgSMHVB5HJVbdizi6RdAEEnOej/RTKS7mRhwP
         +RkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768828592; x=1769433392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        b=CZBuxTvZ5ag+zmmjbyPQYyq84rZ79dRLa+W9dlZIB0uk2wrirGUUWEwQTrDxi/hf6G
         XBusCQgaL8UqHco3eCQ8JUYSMk8RS/5uToSr3bbeczVdm13SnRgMcFO6XJiV1mYhUt1b
         p9P+sv6sA+RPGt7Yj6fIRGgjvUtGcjOiLCwr+E/wJczCzgZmKIYSCRhruXy83Rsjxqlj
         85ghhzys15Skc6Yu8PPJhaqghgYtjYEqIcNEz6YLJc3DUkz/2LxPfAalAK5xjsK9bzE/
         dEwQGi9SbvPjjRjM6uz9LRuHVCutDMyuLE/cT6SFwGgrniz3wEoLW6Do8Z+kFZPMN4YG
         LfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828592; x=1769433392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAc+TnrR7AyLva3poJVGcilw95QVmliW65exvyfTaYI=;
        b=INDiuHDh1KFwCZ6gLULOHLrydp8R9F1U9AmgUl6BPrR5PLoBm4VXdGcscHNpDt3orF
         m/6LwKHfUcDVRm+57AiR1+HzyRBWwoBaJrqIOq7sk6Lr6Xf5cN38PX2ICryToSt6NMva
         FOLapE7Yc6/dDwDp4sQQ5Q+8ObkPcY9dpte7+YStJ2VxahY+jwjIxAKgkVjax215Ev2n
         OKIH3Q8l6/gZaYMZ18iFimHTq+NvUtXXvdQ2zprDMn+M26lcElczAfAYj/sNXOk3Z5xz
         RxbjUkTJWI065FStqRc6+AfbXsdWMnWnWjoqRYi97e62LZDKQyWGmR+LuN9F6rGe3t7/
         D3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdiv4kbRq/TrkUIQQM/XD0b0d/waEcqzWS6IGKNTYY8ogLww+72rAR4Ol1YdFcFJRCTdL+H0LURQy3mMQTSWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsd4nQGvEj7HfNuGVmvWXBmPfmpJ0O0KkSuGF7SyoNp/1/+/K
	h5k+zz95eyhwROKNK6LKH9jIbvD9eswsjOpjHWuhfTCN7tFpKDzfbOCFqBSQMwHpaxCfAdqHyQb
	DL74n04nC2aroaooVW+286rQ5IjerWsM=
X-Gm-Gg: AY/fxX5mnJpI1aa37hgyL12pg96ummfaXoMJm2Aws4Crwoe55SrUj3IBM7kMv50/eBM
	tJeHvKhmE14BLsXKB35S9/x0wjgHwUTZjvvJbLDV0DjZxEebS2nDotcT3ZdgDIbs3IPhoypEGfb
	50fN++KS6OwNh0bv8UbFPwqV13chxB13xKkcRErH9WQbzZHMtahi/T/Bbor1n568j5Nk055ghxu
	jOV7+uVswEoVcYO/CF8tNPzaSaaAirdxMm5nBz8FiotDBQV4nuqyHxDQCsPLPPLWzPSwjI+
X-Received: by 2002:a05:6402:210e:b0:64d:65d:2314 with SMTP id
 4fb4d7f45d1cf-65452ad66a6mr8335728a12.23.1768828591954; Mon, 19 Jan 2026
 05:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118151450.776858-1-ap420073@gmail.com> <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
In-Reply-To: <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 19 Jan 2026 22:16:19 +0900
X-Gm-Features: AZwV_QhCIwm8bHvGxgAOcsrXlHct4ndvTuoi11iKhYCLL0QT9KVopXRoEk_Jsbc
Message-ID: <CAMArcTU1nkAee2LNpv35nAGXbOipez4sNoMjz9AL622PCoOy8w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: amt: wait longer for connection
 before sending packets
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:38=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>

Hi Eric,
Thanks a lot for the review!

> On Sun, Jan 18, 2026 at 4:15=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > There is a sleep 2 in send_mcast4() to wait for the connection to be
> > established between the gateway and the relay.
> >
> > However, some tests fail because packets are sometimes sent before the
> > connection is fully established.
> >
> > So, increase the waiting time to make the tests more reliable.
> >
> > Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  tools/testing/selftests/net/amt.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftes=
ts/net/amt.sh
> > index 3ef209cacb8e..fe2497d9caff 100755
> > --- a/tools/testing/selftests/net/amt.sh
> > +++ b/tools/testing/selftests/net/amt.sh
> > @@ -246,7 +246,7 @@ test_ipv6_forward()
> >
> >  send_mcast4()
> >  {
> > -       sleep 2
> > +       sleep 5
>
> 1) Have you considered using wait_local_port_listen instead ?
>
> 2) What about send_mcast6() ?
>

Thanks, I've testing using use wait_local_port_listen instead of sleep,
it's working very well.
So, I will add the wait_local_port_listen() to send_mcast4() and replace
sleep with wait_local_port_listen in the send_mcast6() in the v2.
The sleep in send_mcast4() is still needed because of waiting for
establishment of amt tunnel.

Thanks a lot!
Taehee Yoo

> >         ip netns exec "${SOURCE}" bash -c \
> >                 'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 40=
00' &
> >  }
> > --
> > 2.43.0
> >

