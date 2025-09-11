Return-Path: <linux-kselftest+bounces-41225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE9B52EAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E456D18893EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A430DD15;
	Thu, 11 Sep 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/SMOWFm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADA2206A9
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587057; cv=none; b=FrjfjF6xszfDF6S903YrJSDedKL71W/s10SS3G3ICla/e8Nyubag+xfmpfJUpO/2Ho7vTpqjTcUvMuVfYGYEQ50ImWfZtRKi1gyCdne42eOG3ExdQ4fWoRi9VPXXJUZYNFkyqj4rjZm96vNWO/baJHgS4nkVFIv+5ASC+HVe7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587057; c=relaxed/simple;
	bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTrClAbd10emlAGj1I/wdZ5Y4XZf2wlcSwp4GGLEtFW1Ke+DQLzqp9F5eYMAVLgV8N77/bvF9bB28kfl91FLJHJqugF67ifnhRXd6XpYqA3n43TTNw06FGJGroIPpPpu0fxyM/Bqf8UGRn90kfcGho8iWboM/Wn3NtvPEyxuGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/SMOWFm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5f79aa443so5220421cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757587053; x=1758191853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=G/SMOWFm7C0PlMXZdxkgFZD+AsTFtUjBh6xfVFkGJWtS3gcJJAGefDTAw6+YdzOVxz
         ykyPFnG8F7V418YTJ0XwEbJ6uy+0SGAgyNr+6TzT4ZwVij62NP7cPStiL/gXwnV1c7Hk
         3ORrsOwdD756dR0d3xG5GPpFwOIgk8glcOJIb8nuFA+KoxrFHL+qORzQ8pECyf0KtDs6
         G1yJS2orINxkLoLfC0ZcQJ/zgd9pZE/pz2A9Zq4iAGpSUWz2rrNLP7DrpxhklRiNnEQL
         RuuSdz2tvKb7pvQdMPoQof5vdIqzPTnCmN67X8cAB71mMJkJ1EGDXENSQwCNRu7H/vfd
         aM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587053; x=1758191853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=KYgzvLsKKLJ3Fk/NCbgx1qwE0aJlGC53YrApUzAU4ZSjw8hHXPNSmxfI2vRlloHUFw
         9A4NJYLJMuiUL+R+9uOgfWWJkgg79Qbt5I/NKTCt4gLK/xhgUQcQTcsCOkrJAHi4QAJm
         gmUNgkMvqaK/IT0TlOdpfVUPpoFlhea1Y60/qGBTjRUToGVOD6528PIbYko7kDJT634O
         zi3sP/5VYQjfgNbU5jezf20dopD2RkLm/aLQQEH4l6wZCpJ9ld2/ZiwsPeVh3byraTot
         AFg4VELEjCHoMUy4kJyaFzpv6fnoGAwSA1Rr7jjTT/wR9535cklkmupjKDRCBOzzpTzF
         WFJA==
X-Forwarded-Encrypted: i=1; AJvYcCVd6vcWpye35hMuU3C81FXMK78gFCSCYWAWt/nnRHvH4Y+JyTW4SmV1ILdCdwL4QfkfyycgLptT41R9HduDsyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzM9kIhl0V7DFcnO357UA5dRW4KxxNeazEHgX7qGectzB5ptZ
	m+V0n9Yz3EL1Y2plDKysVhFHOiCjOIBziC31v0AaqedKiFo3xECVahkKXhYpgMDXXkMVveLOMFR
	KjWHVgv7AagjZJMACt0dZZ7Z3K9ci89ntK/4nQ2MB
X-Gm-Gg: ASbGnctXe7hXnCjyzSLTG3B37ghnpkC/rYwHK3xGj+h423zyVngffob/FKE79hc+Z2z
	KItWBuLMK/6nnDa18XnJpV9kPOHwx9YoqeM6e2kPgCLyDgvCgEYiI80jhO4eYLmvhtX6jwbWltz
	FmpPk0udUFvJDn7yHWXGY4DtVuIn+zzbsMZmKr6RVrsfF69JZNX+9imeHz+lPyQ/QspW6vG0p2k
	wEr5GwQWKS9Ag==
X-Google-Smtp-Source: AGHT+IGIfwTrAX+eEwWNUP+gqA0VWd7OCs6gHhATUwsNn4thDtgWH+7/hdJD/+ZIYnscPVsLZtgwRe3URHJuJj1RLH4=
X-Received: by 2002:ac8:588d:0:b0:4b4:9590:e08a with SMTP id
 d75a77b69052e-4b5f848fd2fmr189486841cf.67.1757587052957; Thu, 11 Sep 2025
 03:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:37:20 -0700
X-Gm-Features: Ac12FXwkEN44-LdnfGfkXsCmivrlKxkPkl7EsRk6tBWM_mjIrqCCXjB3OREkXDo
Message-ID: <CANn89iKaM5HbOT2wU_qSaSxzyLRfRKz6Y3+AXq9ZmQhWjftMWQ@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 13/14] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
>
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

