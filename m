Return-Path: <linux-kselftest+bounces-49485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B798D3C5A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66E86709E41
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501183816EF;
	Tue, 20 Jan 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGEczJpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AE346763
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902843; cv=pass; b=M9+Pk65GwEqCcybhH0as9UdGv4KcPwyiJi9Ch2iQinMGvMQ2xHbcmCymDNKJ3bqohy3qvU/pausfwQqW0JrflP/tTQ+03WV8E9wh7alLqzehOnDo1Os2hqyGCqRWk6gEV7+SBz4c0dZ8ki4B5+W59L6HsfV6bu7/nKXEIgkdhuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902843; c=relaxed/simple;
	bh=bxs1d0ToON+/Bp2OpxrCQltJoJYi6G5PLdJ09NcDoJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML0iLAmBXdWFk5a4DBxwrhLYhaE2eY1YP7C908q2Gj9GWtUt1H6d//hX6JAKR8hgaZ1FasSIUS0utZF0CXocurZmzTInwE0ENR1KrwZn+81obZxvkqzWKE85Atq1eGeu1gkqfZ0pOcoL+Vy6YmddiyeGgjSxMMjVidP1heXrT3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGEczJpA; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c52f15c5b3so597943485a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768902839; cv=none;
        d=google.com; s=arc-20240605;
        b=MLP4DhmcOSw5IZblDnVwh1AMYiH78lN/cXsCzc8qTIB3ggz0rF/+7qFZ1G06NVYggQ
         QX0AYOwQp4iPTM2aYNygtEoVSamO1PxQrx0ce1wASBX92kXKOtTZYvt2aHRTDaGb49qc
         2IF3Zk9uwcS8iYUbOjzYdtulF3TJ3AGI6Kecy6KGX+sGSQfQdYaIGABQdceZockNFrI6
         U/2HI41XiAmiSogulYcD7gKTrNFKI8zXmt84t3J1/lul73Z/rQXd4hrpFFZkr/RgIKq5
         J/OeQor4oX7MGSxm7cOEOe9b6oKuMlJL2TE7NWP6TDT2C7FQ0y7GyYmsEpotBjofsWMP
         04Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        fh=/+7wjxS06E9u+etoEqh1IO1KmAD6YD7aPZv+G/T3YAs=;
        b=GWr+adQYSPJ6I5qFSBhKi5sq5WxFb9+oLpaLpY48C5sQbd7t7xEtbGT38bzdC7OubS
         bwlS1D22E3IWKm4w/V842DVso7qXozyNkrgBNgjoWNSrJVXHYsmsoZXpNtBUDM9IpRKt
         DsQb7/iCNxZHN640JZ9xpZYdwj5CDG4zpgnnJomaHqP5zC24FE+YZu2pMKuD0uuhsqSL
         UF8FOa0BpmxP7NnV/kzMWlVrepJA1FTZP9POuj9heKcTC7WoLX0HNiKSzIR0w62IJbrD
         TzVKmva/wvzdoO47hgM6iEFFLS1D4LI+Tw27gGaHfWEfLwq/v5hro0IettAMzbV+N6uy
         jMoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768902839; x=1769507639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=QGEczJpAluT8c7LsRlygARCVbVUWctoyx6kf6J4lKavXSxu8Tft8yGH7w+4VtaLNbI
         gmNxry7Zm+wZWIhsvmJRByMTZzJ0lzq8JrLRA4jOiIpwoGGEg5Y9OsSwhKAX1tPi3G64
         LMO86/ts6hjaPxxhUKc3RhjlxxRBHKsxa+gZ8qusGSXtES42rbVEntrfnUwQLLgi6fA9
         D96OsslS0f+5XajPPuRKNjUje1eFYzf1vejmO5zI/YlzInRgCCn47FJeDRiOG3ieywru
         CQMk8wn4FISM3SWopCDq5BKSOUR31+WKPJnSKhoPHo9nTobwR8Xxqu46oSg2tKeitxCz
         FALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902839; x=1769507639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=SflNQXDa7OpbITeaVrPshC5tsQ3FdIttPx43emH7Kxsvk7GDe5fBRR8ECe/KwNFGrp
         w4QDhdlPdMyDskTVIv+8QfatBsbFBzGENdtZbsIPKBGQKAcvXkUR8hnZLuN3tD5G7hkM
         9ym1k0H090Es+UpS7s+ZP4PCVwooM2adiVffsj3VVLcAFUCv8hH+bcK+aLKoqxZLXe4O
         RfRKu1B6cNT3n7X+rae/87tCjDrhlhg0+yr9Fj+rR26WoZqFyl66StBh6666xDqS0Pun
         C0lmR7TcsmZorSmOcR/4tiRT+6i3mi3ndnRqhWGZENBriaFs/SRymb1m/erG4QUHQiD4
         Vl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpzYY3HemSNcE6jDAiQgEX9wk1KViXl/tw3+YrMpRyqhisS1Qqat1hcxjhAhMyaIqktl9ljBKz84uOLxU+jS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zSK8f6ihXikOrucnYz1zPKmS72pmVNXEcp/bwPk/6n10Hr3c
	eM0mZjschaO/w6zwiN6CBOaaiRMWA/IjW/XWdyJsAT0ERnd8rH6Jl+qprGZlOI2gzBqbF7p1TgI
	eQGNLHaJi2jdWSEYbF9TAwQf9r93MS7TNzk9wxkfd
X-Gm-Gg: AY/fxX64YDVOZXFtDVYjtInqgLOkQ4J/QZRkIiOUad94BwgMckeMpiNI4QWK+o5Y3lI
	d5ATq0tm7zKvpJwaVGBSBm2ckybLsDe8n49A7+QX4v7d7mnWMZm5c4uQ2ENVFyiqAekOX8corAo
	uWwPAAco+h+6o7gC8x7vRQpGf4W9SLoQNBS/eQKq9uH1YNLnP9FTgTWrRFm0WBTj4JkTHFm/5hE
	O4+oZtC6xAsheby83t9uWktQxaVFVreS5IwPI3v+YXGNw+k+q0THT3Q1coJtfZvajTfIhQ=
X-Received: by 2002:ac8:7d45:0:b0:501:4a4a:c24e with SMTP id
 d75a77b69052e-502a160b06fmr183731541cf.25.1768902839039; Tue, 20 Jan 2026
 01:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:53:47 +0100
X-Gm-Features: AZwV_Qg0IWXghbxwuvPJvSjMMI2uFuU_uwIEWxMla7dfzpOOQkjvRiJt8IywSHk
Message-ID: <CANn89iLzynvieqZUVK3NqaSpMT=-toZ1M4QHvQin5gHQM7T8yA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Two CA module flags are added in this patch related to AccECN negotiation=
.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
>
> Second, during ECN negotiation, ECT(0) in the IP header is used. This pat=
ch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-se=
gment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT v=
alue
> in the IP header by the CA when not-yet initialized for the connection.
>
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN=
 spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

While for some reason linux uses icsk_ca_ops, I think the terminology
is about "CC : Congestion Control"

Not sure what CA means...

Reviewed-by: Eric Dumazet <edumazet@google.com>

