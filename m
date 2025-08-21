Return-Path: <linux-kselftest+bounces-39484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A7B2F99A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7A5683937
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229E321447;
	Thu, 21 Aug 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEQJcZ/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91832039A
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781475; cv=none; b=dtOC0E83bSrkFx+RG35CY9QzytC2L/AQG6j2nAOVjUyZ+4XYVGW5D4rokje2vsqaRdkx4Z+u4fdMZNZoB7JoTzjBQuWeyiDI2tlb6Flnuz2yGEZQ7Zd6KDtGVOA/yQiQIhd5TM8WbxFsCYi9szZTfE9/wIulKKRb42q6bJwWGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781475; c=relaxed/simple;
	bh=dksXjVdpoZxSgSUQEjTqurSba+l6eHHY6MPN1daXJck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TedjCoDT1SySrMm32OfR42mRDJWViJXoGfF5OlZ0EsWkRbLZZzzJDhv2+PFBCrrnEZS6tTmRbTFzkAH2BJPRqxvbm2a9qx+KLqajTdCobAjeGuxnJsTQ9gL3WEsjN8y9QaN6BloBzrPJ8AGn0YYaM/uEwGcvcv+PkxI/h/pTL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEQJcZ/O; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e864c4615aso214388885a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755781473; x=1756386273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=mEQJcZ/O65dATBlYGtnKTmDmhKhukdF45BXUwIsXmz/8E2kVElQXFQwIHNWVg8q8ug
         9KJSNf+LkwVn+QrVlYkNYyuvRTL9mIdG9Jrlu/ZE5Lv/ct+K7HFLzF6WiD8i9UVn7Wf+
         NT69uI9ElWNrfOgQedsLVuF58qC/tyoHAFUrCDC/GW0uaK2YjuA1K94TUmfEu0hbBZZA
         UY4SvTIZnpW2fAWKbH0tWJ4WXPnlpUnZ2QqdgYmJUllauwdS6LkRSkJFxRsCnnCgkBv5
         CqWkiB7g+KDAy7u1MxPXXdLedySimf/Nm+WOoyMjaMsRFTJ6sfiV6QhGoIxyu/F4zGVz
         5mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781473; x=1756386273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=O/mP60DXZN2GBu622ofnDSa/ndAqhTKlvLzQfFh+Wa5wCWwdeg5ZD7Lakz6p87/YeV
         Huph8znfT1F8W9LX1673BxmKEoOuwzHmXntjlBtdCdFXknzuguQJTEpuy/mirGL7ZvVG
         vSL4Ddps2dRTjEHgVESXIEAbw8Q3xbyVNpIebDw7wryIp2Rb1+ywREYqbwY2sQYJN92Z
         sOiUVd3WWor7MEvib3ivpKSZkKljdj6E2zJsLGSO1OdSJ+L8JsVsOffDkmLcY2L4Qp62
         68s3tctA48DYDrg/x2O86xfo4ASO1VdPg3rSGZoTIrDagLZ/WL2OkSnU5atxQqSabs2w
         nfVA==
X-Forwarded-Encrypted: i=1; AJvYcCX3BjCgnROs4L5TsoQCYFdcsa9E5oWqRYWTgkFwkGi37MwztQdPaGXfBOqpTVlKRom6U9i/ECYvmgf5Dr5uHXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCu7FNlZFla/YPdK3jWldqeFCpjWtysAPRu5TvhvF7LEgKk6Bp
	VoMpiL6Kjz0XUJ6cLiT3H289K3m2efcrjxGKFvj8K71zvsTm9hG6quZn7LVxjO9oFZEyyP8AI9j
	wG4+1s0QRFSyqh/6bCEhL6BSHElrSw1OMD+TP4VwO
X-Gm-Gg: ASbGncvl79ltH6MFf/JFxTa5ghgt8u5zWPPON1Y4aoE4oP0ZmyVv+0AOmXEJJ1BZ/H5
	t76aD/GxhJC1dxBSYLOxRwmbHuutr4LOy0eLv/GCgTAAf0s7qxU9N1/+AMsA+BYICjwRjJrkNAX
	DQbKOj3CftFc+2YwxGMzteUWxPr3CpNcqO5utZhzsWEnmFhx2DCGkFS36talfkSDiruLDRm4pUF
	Y2+DmbuM+NOW6Yg9EzZ7IcotQ==
X-Google-Smtp-Source: AGHT+IE/rVuZ9SCIHg1gU7wHZFKJcVFlbis3SdAosQsMQXAAs3D+JvW5TH6jC+V2oisrZbfPgFfUQfa4iF740e0XHhA=
X-Received: by 2002:a05:620a:1915:b0:7e9:f820:2b32 with SMTP id
 af79cd13be357-7ea0972ad73mr237461685a.39.1755781472346; Thu, 21 Aug 2025
 06:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 06:04:20 -0700
X-Gm-Features: Ac12FXyJZ2QzT9xkYMMFg0cMwGaeSy-IVq_aPmJhAwN18-ZLuJFS365DtCRetGA
Message-ID: <CANn89iLFEM+mbU2d0AEH3O+3zg5Cwm7pdmaadUxXifUqLuaQLg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
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

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>

It is unclear if this chart takes into account the TCP TS option ?

Can you clarify this point ?

