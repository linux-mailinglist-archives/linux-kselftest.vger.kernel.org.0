Return-Path: <linux-kselftest+bounces-46948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236ECA0D75
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D35C7331EFD9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8FE398F91;
	Wed,  3 Dec 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeJ8XFDw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45A398F9A
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781139; cv=none; b=h4eT1qTF5P+irnJ05vaAZyxHgjzk1cK1hDW/Gh4/G0zuB+H0kotBPiWtlMxDU9UNCZnjd2gS49tvwa82JDUdbQ+LiwaZct2DAccGd3Lgo2kUpwcmQzJaf1mG4hgrglPG87NRZRSGR6RyJLh8Wl7v9Cs85BuYoqxFgOP75PZFi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781139; c=relaxed/simple;
	bh=+w1fh0CLrnEXL5kEY/A4dLuPSBwVUZezWvTx+H8HRaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+Kf54AEkgw4dHf7e3QenZ16n0uKL+owVj9Ib08NaZDLK6T3gcSwmQmOUntpn98p8ViKijyoHgQPRkVk/P3Uceos8DfcLNMq4tdCK3O1/JL4ABxJeZJPeu9tRnLxwEzs6Pj2e7VS9qgYmFhQEJrVrqbZUdNlq506jtnBB4YtXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeJ8XFDw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed67a143c5so629271cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764781131; x=1765385931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWXC9hyoBsRhxJFVF8r6pSxMVZV+OmkuKYv5ee8pQww=;
        b=HeJ8XFDwdWekDq9V1b9WJsNTFib2PsBhNTiX2rmGrMIcmsVSCkVMDiqiuq9OlqQg9a
         Ay7EDzHuaOQu3QWfs6/m7Q3KMm4YOTY7Q1RHirjo+KH3AjM+4I020XQpQqigcDGHeMA5
         PmEoJtrAlSkb4bPPDYI2xhaMFa5a1Z5YCZmmaw3ge5rK/YsJOBM73EXxmtTsMDcTbWKj
         GhPpH+p7RnOvYWP7fPkg+bOA9V4xqBf7JUrmaPLD9D/VnJExi/NMadW+EEKnZwG6UqP1
         QzihSSd3ARliBhugxPMbyqOjwJ/r+6UaBuNwML+v7GS1ZWXmBv2jivFhYvOBCflqqwQ4
         nOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764781131; x=1765385931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWXC9hyoBsRhxJFVF8r6pSxMVZV+OmkuKYv5ee8pQww=;
        b=dNOyXz4w1I9DStbjSB/JdKXeD0lJsqzCo8c1ADAOV/Qf54bP4e8oh556VQ9/chc/2q
         L3oL2m+3d9s6jdASpkaAD8Ip8HdTfeUl9xJS1Bdxbd8UBG3qpvKZCHmfBl124t/aslb9
         +jSCIEjQYzl2c5Uh3M2YLXXTALRpioEvFy0A+ndkHUR1Mf0jm/F+qtsLWyLyQHjV5DWj
         OC/xKcZ4VP19mrUXAh5rTPaNum8A6u4cZvK9Mj25Otx555mgd1lBDp6IrzORiaJP9KES
         eHpnWQ1JCs2npezj1jcT2nbpQ3RiGINedfCTRUAIdzL4k7h43Umd0Q8KIdUUDTG6YSTh
         y6ug==
X-Forwarded-Encrypted: i=1; AJvYcCVmXyt9Pp/eLV4/v9eXR0s/aJaMccZueHq4nkyeyiEzu975bWerOG77X8oUWz3U2yib81931d35uGkULmq2nlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+3Mw45WBAomqWH4ws2nrvy1r0PDal7cxfiQD7VoeafUGbdT2
	eC/TzWR3L//Iu/dp/KBYQZx2qnyivO86JWcT+xlNP3iPpY01yK6SNZ4hMaiaHM6UVgq/UKlaUOL
	LV/QuqbhslYqh3tnEaRXbnlefmlNqkbdIGSssSwT1
X-Gm-Gg: ASbGncuidVe/JxPjifmo3NsHAbbnMGYrdykHg5/gwx68nzztmfsSqog1kX4Sef6Xvon
	763SaloMrlms4cdpm2XY3tjtHoYn4e9BMF5pkN0+Q8BbJJ3kYjXUBOwoEQqcUBUdr5lnH8RIrW+
	EbNxMCnDz0vwDBCFdMn4UirQhigc1geTewmR3DTjGPUXsCN1cSpun/zNJzhPhzW0o95I1i+M++R
	B8J4oViseNlM248WphjAlscjuXSM9RrDyvImBj0HYbXqgLBJ6aIVIN/l7jBz40OoBPLC6rqMLBF
	HhK+r4sC+adA8exzeqqnvRPGgTtMhrVAuhb5yQyFwBxKBZQksvaEv9/R6mji
X-Google-Smtp-Source: AGHT+IEwQDGOVT8Lgzi1wTqV6Us8oL3zoJ/xquBSspLWs/EEWhA+DJcMaq/DF7hunAbCMnNSctvo80o0agoxsFagOgY=
X-Received: by 2002:a05:622a:15ce:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-4f015798fffmr13757201cf.12.1764781131112; Wed, 03 Dec 2025
 08:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com> <20251201150509.6cd9fefc@kernel.org>
In-Reply-To: <20251201150509.6cd9fefc@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 3 Dec 2025 11:58:34 -0500
X-Gm-Features: AWmQ_bmmK0qcQ0MMg8A5oddcgrqcwdNw6rP5OvhiWOfo_lx74r4d17hh5ndUNnw
Message-ID: <CADVnQynFTrWf_waxGPH6VVPSZapSuxUb6LFdFUGj0NfiADAa7Q@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, pabeni@redhat.com, edumazet@google.com, 
	parav@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 6:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  1 Dec 2025 17:37:47 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Plesae find the v7 AccECN case handling patch series, which covers
> > several excpetional case handling of Accurate ECN spec (RFC9768),
> > adds new identifiers to be used by CC modules, adds ecn_delta into
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is ava=
ilable at
> > https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Hi Chia-Yu,

My understanding is that you still have a set of packetdrill tests you
have been using to test this AccECN patch series. For the Linux
networking stack, the recent best practice for a significant patch
series like this is to add packetdrill tests to the
tools/testing/selftests/net/packetdrill/ directory as a separate
commit in the patch series.

For a recent example, see:

  selftest: packetdrill: Add max RTO test for SYN+ACK.
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3Dffc56c90819e86d3a8c4eff6f831317d1c1476b6

When you next post the AccECN patch series for review, can you please
include a patch at the end of the series that posts your packetdrill
tests in the tools/testing/selftests/net/packetdrill/ directory? In
the commit description for that patch, please include a mention of the
packetdrill SHA1 you are using and a link to the packetdrill branch
you are using, somewhere on github or similar. Then I will look into
merging any packetdrill tool changes that you are depending on, if
there are packetdrill commits that you depend on that I have not
merged into packetdrill yet.

Thanks!
neal

