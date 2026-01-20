Return-Path: <linux-kselftest+bounces-49491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF75D3C5C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E4165837E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFC3ECBD1;
	Tue, 20 Jan 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVH0iemt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19733A8FE4
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904555; cv=pass; b=YRJRIUXIZqf+KE+oWnX0SQPH6Iu7eBAhcZ4rx8TeLVEUJ9TSpk/jaxRsd00vTA5MlBjOGYvZxk9SR3BwmIff5wMjvgI4wbxI+sJDG9JTbuc9iUK5IikuykJesy0NEPmKuhjzTwlXgATL0GD9jpZuB2p+0tGwBaqzknS9B+eCIc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904555; c=relaxed/simple;
	bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOhH9AWVdQ36rC6SsBR1Vz/LLB6F5b5cNFtPelAcePWYFSt/UUNRYXl4CCx7P2fq0jYN9HoOK/vszsiFhhZ56irTYYLF8IhaZnx5TNcp7N6bQyv6SZS8Znx6ctSUBpg/X881WIuvIRTSnF6awPQOoEo960MPl9xSuRMxmW+de4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVH0iemt; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502a789834fso30467521cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 02:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904553; cv=none;
        d=google.com; s=arc-20240605;
        b=IM6DEtIknPU+FOlQGMemADq+Ya88WQqmhsiRx8oru5nriYG13zLUT1uIN8cLTUxpUY
         Er5eTNX1wB2DKVxw+4mGcYKt2dRpgYo/bEd59uo64U9jtgWmNp9yE0sCm2Wt7DRw+fU3
         H56mRVjjKZ3gP+VIGt/J3Kwq+vKucI86OLac6JfgZZbwihmn57Z/YKPCEC3fjFi49tU2
         BowyH1P9P2JeS0OiGvWIq6GwRnWleJi26x4WMfeogNHy01e7aQQ7H5+lW+VFGka4yBAg
         Io8yUDT0meNSjVNYtdHPJPEvZi1rOMZx93k+s9nNBT/btuOHSQlYiTIQIw5o80OWVt6d
         vqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        fh=bdy8aO9zrWtv0lEs+2OOQ4vjkUtGc/17AmvXx8Z/fM8=;
        b=FbTRKhyuaBWQJxcuv9s6PeMcB+hkJXUzdsdwvATo4xtjKWSmSXJnsdC2mgJHteUxLy
         O6ScsEY2DWpLZqnEtDo0TnehPzE85qp080K8QWuuxLB4AHGd4dTCfWlvI8WwKlPgtfR6
         ZCL/BoqOFmx4Rw9SdfcqfvwBZaUmKCfd3ACV12sKEktFhUNzsq+dMu1QgU6kvVV0kSmT
         /FqAxw6f6MgHzIJtnu0xRGoWu7sKqFqKjcVDxTx6OTvqrTDgrn82Le/15uPvTK5VQaOq
         RfhGnHBeoV8uEo3prhM/kDjqUNLB4DAkiqXM/W77jJAll44jVwGHniWVOhtGOFCvE9Qp
         wdcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904553; x=1769509353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=BVH0iemtJXKgFzcspkojUU8TuSs21rpLoDur2zzJ922EnIgWrkLaRMp0B9iuSoktNz
         5khK03tz7j7PR5kUv2f2CyTtzux3YZlaF5IHhlZ5DXMbV81KSbPJC99Eqlpk1RAFtCX1
         kcgM+g1EuR3S1b9x62NLLLBHhV7l5ORtqmC8YWruZ5CW30RV1vxOD7/nagZH4UIyLHGi
         YSWeK48Q3xFjL/2JjJpn+NjaEeggPzhKQy1pmtns8mcq5b2RM9ONHdWaB8hceS2Yvc0B
         c9kotr6V+LvrwRvSfFWeLTyNXlGEM/3lI/7canEuRoqj+bHKm0ZXuIq2Q8s102nxLK3U
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904553; x=1769509353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=DG7+nQB2r6+oB4Rny/jLnFIp3mbDWj6T7dj4hGnwf2rAtpvUfLFAhFTWRWWptnX1C4
         Irv90ENy/CzQbDdigjbP74O2NDL1VmJITj0y9vCcDzs1xTswNq9zNUS+Y8/+4dYtxV8+
         1ChIVxu8AOFAeoCo5jMn/kFk0VUF6r/U9L01FV9XjL+WPyyukZfZLV4bNJikJoHKOGaN
         AKpBi4wmI3ZAQQD9ouNqMgxSEEhNP/1BNnaY0sJ3/x9B5nd5KoSbdsKhSP7wSYX+bSLO
         32iPbDepu384k/OB6iJ+GbIwz5DwoSZWpygmmX/2xKJwp8/cEWcUnJ3O9BDT5RMTnROZ
         BBYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfMgXstdtZ0XBPVgOafXwqSQDPLMYPyWQwHr36qLn56AqFjoTluVvxdO7j3+EYTTy2E0wsVwAenUwTeqg8RQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAANlNd+qbt+8wbk6WWJofXufJT8xGklyvjPS1CCMYY4b+u0W
	HTnBkZY/oHCOLS2Tu8mdD1r7lhih6THdhsYnnPqJRkJhdQSBGvvxOMeMpwnl3q8HgVk4VbH6Eyf
	E4XzE7Q5WVeToXtYeaz5D2dlE0ye8N8P09umuKMYm
X-Gm-Gg: AY/fxX6Iu7hR1hHUlN4pLMJvCEFiL/+SftTDmMcuvdk5lPJ6kdftqrE4A3VBRqXGzK6
	iU81oeoX2wbJT0ZQYqZzJv9Hs61/y7nuWYCDowHpHL7ZnPldqlUFsmwDD3+3CmbYXlIES3W0o6h
	2RaKpqDIAj3DH7aU0AB2e47Q3r1frt2FixM6ufK7/ZSEBCqqeFYMOTOqL/G+Q2OZCer9FzLLbwV
	fBvPM9GpDO7vm0prtI4baa50ZRr9OsCQ3UhPnPOLOXnxEaPMvUmFzdcNFtkSB91eoNKkS0=
X-Received: by 2002:ac8:7dc3:0:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-502a17de1edmr195650251cf.83.1768904552249; Tue, 20 Jan 2026
 02:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:22:20 +0100
X-Gm-Features: AZwV_Qj6HtGAH-_1CoFAtwz8z7DAfNNNRGDqqnAwXby63-7-acE9435g0aUmmD4
Message-ID: <CANn89iKKQH=moYMied14AHrsDTOKK0pM4kVQHdh1FS4WcnU7ww@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 07/15] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
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
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) =3D (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
>
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) =3D (0,0,0).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

Please amend the changelog to give the RFC precise relevant chapter
(3.1.4.1 if I am not mistaken)

Reviewed-by: Eric Dumazet <edumazet@google.com>

