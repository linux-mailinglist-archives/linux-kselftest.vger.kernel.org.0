Return-Path: <linux-kselftest+bounces-41222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6253B52E29
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287671C25CEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262630F928;
	Thu, 11 Sep 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd/CHr04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3452EDD52
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585911; cv=none; b=Bf7gfqSAApSjXWsWs6QJAr1eMI5XjxjGeMlOJjtTa64BQwoliCp0181oiRgZgNOKW9I63hdx1O6DYPkm6gqmmWnndZKxWqEvxSdo7Z1SZnfAnUUvhHfvPehnMGYiPxt2CJirDCziIvF8Sor3TeGdg+Jaisg1bBp7WAgSvZkAR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585911; c=relaxed/simple;
	bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQJ9pW1BFLIOyW1irlQK4LnUGUnGrn7FTgSI+KKZ73Ae0CULbKLLtewTEprwheYH/k7sVQxCQjXhP4KR7UHeFRLwkIrm5OS3Y0IkdIsFgbzEWsQNuj1b1svnjKmuVz3rhA4i2SPQ7JenOmVei3NhrP5q98yTZSqRijtKLYjh1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zd/CHr04; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b3d3f6360cso5962601cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757585909; x=1758190709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=Zd/CHr04NiV8NK/uaWUmoo6yfow/Cm0ZQqeugNK/LjKfDLdzQSmpFAYY9SDXNibLYe
         IHyaFVfLCp0VKbQZ+lsvYirwfOp6F5tBBVsAsjb/3lrtPf9W2Vc++e19PWYXIrS7v3eP
         psh6KU0eZsU5vQ698A5+vN9NAkA6YdzJwTqvolvRWF8TI/3OC1lbSHrQGkqvrLvRpRIR
         5LrWSTomqCnvN8BOPQn9yW1VYHfGRf2+uJs++Kg/o73obEGTwlg8keD793Z8OG11Ot8w
         jjkqgYFTCmoQwkBoUXGSi9ffUqopG843/7ZrdJXLqVup9U8qQlF8mZXUdslGaeR+H5FT
         p+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585909; x=1758190709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8kOCoUNiju/FWlmhh2Efh6jL8KK7YKRK8N0sSL+ihY=;
        b=WSR69rFix0d8i9hq5TweHVl4YQOiwwZfy+4u70uP1gXdt7uVikc1F1xFXEgLq5EnKy
         7KJ9v734dhkYVFUQ/mfqriQcnjajFZCwk7prIsQiAfiVQ+F8/Phrz8rh9Gg6aC+wwDtj
         OKP+xVSkItBP5DeKkwwqOeHkRK3ygd/B8LwHZspMyy9Ma6e2qu14Vgm5SfbVJbmEkSjG
         wQXtg1BsbOZ2dWm5X9Qg/iJcVy7Z86splHnJyleNFdTxpK5BpFi9RkCzscGHednWbCw+
         KgF7ccxdpaKu8+Ve2v92mtIHJp5s1F+jBtqiyEnCvUjoeEdoME/E8r5iKB5yr3fI1Hgp
         btLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJK3W4q8pxcAc7lug8F6AixkxbJE89OCe4ZnlXpw4EXQo4RKoBJMRE1wjnt+RlU+wlQzaRpiU2fOAbDGowNb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6uU9YyhFGLiPAJ2R5/jKteBveYdgmrgHzGeMuR9OQyMVLhGW
	rzzhYQqy9GCSjBifDF/EuTzZoGpDmx9TWZeTchLGEeR6WfxG32GleIrYx478LNiBcx8Mu6JOn1y
	96KczB/XuulOmGdWnEr/lNZZNCkLAFgp0wcegkpYn
X-Gm-Gg: ASbGnctkEeTI9lII3OHfJEFMct8NWa8U0nNxURYaqu7qcLIRY2rLfrWL0bdZxnugHpR
	xGedKJHbIz9OqB/I+9i0+7l3MA4E+zZZR4anEM1bhuywftxj/qzTx3JatQ5UrcH5WYzJsfbyT6a
	+hITQGaepH3Q/6NTprrmQXet5QNyhbZevhP4r1mrwFTc7YAwuE6tJBc0HJoXkhw3oaxJogz8wUX
	XoKoGgErMcxcF5r5uonVWPCvzQBRh1PK+0=
X-Google-Smtp-Source: AGHT+IEqQMhkVh/lYGalDwkpiYZ6f35/G1vtOQ2l6IDxuZ/NsAD8i3LfdKsGnA8/soxwk9WffOfYsUldgmrLaRipwNs=
X-Received: by 2002:ac8:5e49:0:b0:4b5:e822:36e0 with SMTP id
 d75a77b69052e-4b5f839047fmr204347991cf.12.1757585908196; Thu, 11 Sep 2025
 03:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:18:17 -0700
X-Gm-Features: Ac12FXyMpCAA7q3vBOdalZhfapQxJhqhSZEIpQwkhEKdjvw-ONLg3xPKC40oLaw
Message-ID: <CANn89i+2=bNkkf89RysrYxb9DW0Vw9+jSg7FotqtaHZa7tmerA@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
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
> AccECN byte counter estimation requires delivered bytes
> which can be calculated while processing SACK blocks and
> cumulative ACK. The delivered bytes will be used to estimate
> the byte counters between AccECN option (on ACKs w/o the
> option).
>
> Accurate ECN does not depend on SACK to function; however,
> the calculation would be more accurate if SACK were there.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

