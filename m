Return-Path: <linux-kselftest+bounces-29304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8878A663E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31216173912
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447D18AE2;
	Tue, 18 Mar 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Riinb0At"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873F625
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258037; cv=none; b=kS/Rz2lbQkY4//W/NSr6kAUkGynd0WhJre3TqdYoi8+88nk0qvNwPYSyUKcbR92eBafW5HoU8QBu6KwTw8pV5SqBPhyCtgG2bKs3kxHQHN1SwYsNHXdh5rPCKo5j19iQJEhtcqJYO4seVuXHZQr7dhetyYGALYKTkjkXG7Vxaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258037; c=relaxed/simple;
	bh=UFX9Amd1Sa3L7j2u30pii3KSejzTFjjeMc8qd6DXH7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcVl4cigzf9ZLptosa2afaYYct/AdnAu/okosPPKe4uzYO8Q2iz5EWXlWiYL106STUdeppjmS0glB66SFxo7qsEKyR09cPnkskqcBPW52k8afCKLo8YsWSlA1tNaxiUOM+o0021YTy0pM4E1XZQ0KXKGv9I1S/FFWy34K5Fj5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Riinb0At; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e41e17645dso45568636d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742258034; x=1742862834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SPiMm6hu0rT5t1g7jQBHzrTzsjEu+uco3Adx61lyIQ=;
        b=Riinb0AtUKUIaYt0PXHPCbM5wn8AF5LNwGvJtRdSzpP2IurkewbkbM7fHXm840WQ7B
         LyhKMfoyrx+KiYYyPryLA53rsfdSDVD4C20SsyS0icpE/Pm0QTyiQb+X8B3nEzczjSKo
         bgTtRr4mGsWNAPDbUn1u2iwyU+r74CrzfFTCAeSVzX8XnPYkwFBtdCvPVB/1QCkyvRSS
         9TPN/jHletgCjWdFN+Z8F/GSad8hRcgVKCRaESnqCbIZ90qtnsBT9Ayy1A6h13dZg+IQ
         uh1gnbP4b4zg4NPSDlfKLf1sUI6/l4eaJKrMipu6EHSoOzXsl4KMVIoOU9DF84jakXfl
         80iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258034; x=1742862834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SPiMm6hu0rT5t1g7jQBHzrTzsjEu+uco3Adx61lyIQ=;
        b=FxZDIVxkOXmq68eeYHtoDqjgsCJAVTUzxk+Q7f67Rcp3vaLDlypVaQ0v/AZuud2rcI
         1ijTU76urA7oElAulKCcwrJzHH2xitWGKK1eh8n6TMYflgjQ2Tr4NL/vK/eXdDJONCZ1
         U1iIZEkhBHmRtWDBg6U9dWNaIgWbu1RBu3Y/YKuiSv46yEZOAbLBCwVtR1rCqJ1M5PP0
         RULSIie956CzCn9sSSp6p1sQeRcXuxXxJAVlKn9LCS7YFZ3pKMBtQjGARyizv6F4umx2
         l+L4XFsi44qtzQaJ/tGOzYACmg4HRKI/CAG0YLoxHeqrmw8zFvHcG81SiUVjZz3j1eW1
         hIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfTh5ZVbBDj69irMUq6/zH2j8jEFGOBi78+gwClc6y5hSQpBPXxscOvWsD3ySqTsWxA/E/HbvJmvoebKsky5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwokwSGFJl5QILDPPUg9uL8CYHZ3FCR4KigdY0DqCCVvyQ6S5xK
	D+256lerk901gdm9A1wyv6vHUB8O4gjFApsFPmYpun8TdmK4lpk6Bpw6mJrlKwbr5b+zEvwm7IZ
	xkbU/fRuRwOs92pLsZAFoeBBMY1miPwzDuJe8
X-Gm-Gg: ASbGncuPoTU/+OTB/LMWoNzOkULszEVVNWV+xUA626N7z4pnpMvBbRj9WU9MJo94KTo
	PgtZUiZEGPyQ3MiZ2Y4n6WlVg5Caj9ATX2rwQK19FoH6193VnP3IR19eOvUoInP/2gDdsxTVaLq
	3a3qFFYMSFvgrsMRDr07QWku3Vtg==
X-Google-Smtp-Source: AGHT+IGhNmM9uCztfv3Yrx5mEjhVctcDn+m/TYBvEiVHdY6A8JWEnSXJZ3ARinshC1FdMURLcUoEMTins+O5/VtwFUc=
X-Received: by 2002:a05:6214:1d22:b0:6e8:feae:9291 with SMTP id
 6a1803df08f44-6eaeaa5f7efmr188720196d6.24.1742258034316; Mon, 17 Mar 2025
 17:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Mar 2025 01:33:43 +0100
X-Gm-Features: AQ5f1JpJfi6iMrvlbT6t2Jw10_2qAm2wyZLZ8UTdk941UBV-P6U8UE7Q69QLIy0
Message-ID: <CANn89iLQcVAwgsO-n91j48D30wwcufo72E_uS2CuppFxeUREzg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] AccECN protocol patch series
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:27=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Hello,
>
> Plese find v2:
>
> v2 (18-03-2025)
> - Add one missing patch from previous AccECN protocol preparation patch s=
eries to this patch series
>
> The full patch series can be found in
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
>
> The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28
>
> Best regards,
> Chia-Yu
>
> Chia-Yu Chang (1):
>   tcp: accecn: AccECN option failure handling


I do not see any tests, how can this be tested ?

I am extremely worried.

