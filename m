Return-Path: <linux-kselftest+bounces-48571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CAD06880
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67714301054E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232233344D;
	Thu,  8 Jan 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoYU/nyR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60576326931
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914461; cv=pass; b=ijWcmKFHVg5NGyKqEmmQPQETyVEEc2bQItbnGkYNVcQ+KvdKLfEG5GrnB+xxaMbqQDgP6WoEmoMdYDZrHQQbGqSablraDDvpgfdFmyTfkARStJYbT4TEbzY/ooncr3DK4+eK+1PK09AoV0aHcT6nUBwTuLc7lNNzLCO6ubY/s+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914461; c=relaxed/simple;
	bh=rhCQWH/yPA2hIsQ82SImjkWBzo10eMRYT8Mz8RFa9JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHLyowJWKn2QtkFNC46iUJDH4WwivjbZM/ZtwNue1a/3w61C2JeombbJBLtFesyEkqUgzHL2/eXMH92lZl/s4yBHjTtWr8uTS0HukVhULHeOKdOMwtsLWhh+mp6P+vFARPebU9N/bDT9BBrwnOObba/gTrnw0oMyYaVuxF01COI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoYU/nyR; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee243b98caso79671cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 15:20:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767914458; cv=none;
        d=google.com; s=arc-20240605;
        b=gp/VwYBmJRFyKZl0Xlf/uNGuCVDknOWnO+QPafPrqQyDEo/48YZQPitIzU5TajY093
         S9ApHvURPi3QtogfzEwT/tePrMoiEuDqtB5nT0nKllh+KlCoiaE5Lphqz+NiFD5a6qyy
         +KfRnCh5Q0yNxM3VHBsHDkpuLP0rgnww1fl86gZgoInfJAX+f6yiB1ZSZRBYSD2IXo+t
         Cgio74Nx47LJ1xDQGL2y+xUoqWwbGWZ1nQyICkSDKPZEiiGT/OMMy0QgiWpfmAQ6xSGx
         iUIXl6xPmDsMuZtBE1Zell0DyY3z/nO8Uss342nk2/1OaDO9AVezDeiI69W585Q3MnHr
         PPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        fh=wQJfOdrvEMJZK9MWMJ6oKREN6xpFmjoE2dhmcL2B+jI=;
        b=BUyti0oN/pjCoUdyJ3aJMAcQj41Oz/a/JlDhHYB7s8JxIfnGg6ctTAGsumfTcQrgpD
         O8krh6XBTAOmPPcWnefP17s0xaApI/Akf0sPjcJd3XoQW6e4KI0b2p7cq/UVjb5qeBVK
         8Bfkes0AEAHOXRZXDAMM6tn8zixXy+gPHDusVwnhu/k8rdv6ceuDZE+Tul/eRocH1iuq
         n6fARG4HNbkxgi6cZok22nwdbkTJ5BsxXWtcWVQ9XaZvHCCnK7C91+ENeNbalZK5Hejm
         rHLAkmxQ+VyjEthtPlVyaQ1MFt+lL5bkwY68eadsQWOetjsDaIzIMVW/KXMa04nzPUzm
         P6cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767914458; x=1768519258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=PoYU/nyRL6U8AMm+w6+xHu6Rp4iz1e1Zjwndtf1P91rPFzimAMia/xk5fhd449Yzxq
         wOals5bwl/YzYefe3/yTZAjAWkISnRAZn8K1QbpSXs2ccRYiBBAN7hFiMcvfG2xwNXC1
         K57zh+rov+V7kAdpWShLKBCoQ9SSw7P9vZDUIf9q4Q8vTWZJ0QcuRBaPhvGnNIkmk64d
         tEo937ako0z2KeIh2dBrKuWwBp5257PoYUZg7RYNYYdqCoTlndR5zq6h3fwcT3bizaPf
         M86h+FD6RdajgFP379GAaSe+QJc4JG99+Zv5ieYjS26cJc7oZwDse17dx9FHSYA2SaM6
         5gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914458; x=1768519258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=JmRWlxlf+CWXQxzuRVX9liA3gCKscdLcfxR8T2UgPTwJ/m4zQ9vswCjNThXucn2ttq
         hpfSlZ7mliK3V2h0PXG5nUZgOARFbvS5WwZF1wctCbLpc9Snt52enWUvdqlLMR+13eTZ
         +3FdqNjJVrTgq/DM+/qt+6BNO7tMVAapjbsTx3TSrXN4FpcVKnim5uSCU1Jh1YPYprJa
         kJgVAoOft9ZyTpvCdQovTmDxvLpzDJH1ztjN7nV20tnCcHgfGITdLAqm81+94zg6aKZN
         y9LDI2utJd2smRO++odPda7IkcCSu5Mbih+XsuAm4HTHTCpqFb6MoDQM2fDT7NB+rUZx
         12GA==
X-Forwarded-Encrypted: i=1; AJvYcCVElZORhcvp7ovoMpaJxY+wPAN3Q/xz+zPPas3IMtOoJhIepEpb2nFwHWf7qoZqoexH+5hd2DpYAHs+7fHMR58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbau+uM5e6prNkZQUo/NEnqjhl7AFsDA7oZN9KoTG7+xT1NlNZ
	bBO9S/cFfYn2U6Qo1hmfkHGUKUuE78IhLCDGGM7GVDPitMfnKn2U7ujnnnf5FmphH1rtnUDo6F2
	vLIGT1SwVR52Yx+/AAaA7sbafoauOrB46dPjFpUaP
X-Gm-Gg: AY/fxX45qByJfXFT1x2HHiOCsCd1P0fLoHLGHm/P9jQ4NpTxCl4645UnVPtpjRN7UKT
	YEhG/+ZMJ9JveCjTE5jEmJSdxzYNJLR0zhCT7V+15qngGDjqSjQEdYP1USavzjmHeS1m/M21r3m
	yy/BO46Tv/4rLbpw+w9QpJO5mNmwAj/STtZ9RBhBFBr+Po48Kk7vROI5btcpcGC3MaYqoaHMubU
	JsC7Emquu+l4pu/+8jvZnOKbSubXxzgRx7IYTn7yKpulsLA7Fn0iBycpmsDA4vtBzu0kbkO5yVZ
	JL8clF1Gvl4ERhpthCuJYdJWixYORTF1RdLGArec9K1KIywV9983RcnBHk4cVk+pyr82XQ==
X-Received: by 2002:a05:622a:451:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-4ffcb20efa3mr2340841cf.13.1767914457681; Thu, 08 Jan 2026
 15:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 18:20:40 -0500
X-Gm-Features: AQt7F2pqVzz9M7qiJp7DfsnUleYfVSMGUfqYVX43z4keU7aZSTGIZ7pkvS8mv_0
Message-ID: <CADVnQynohH4UyvyKm9rUNcCMbnepJKMwhOCPRFzM5wTvpDR1ZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

Oh, for that part I see you mentioned this already in the cover letter:

  The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
  of the branch: https://github.com/minuscat/packetdrill_accecn

Thanks!
neal

