Return-Path: <linux-kselftest+bounces-41803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F66B82F4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA843AD7F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252C257AC2;
	Thu, 18 Sep 2025 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bCS5Qxk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC123A9B0
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172366; cv=none; b=DBM7n+GBvqTchoTm/Bl9Gz40Y9E5P6ovt8rTWal3naJvubK8FVgkMgvuay3SuozHCrOSZpHcuVjh36PoDoMeI8SH0GaKFZfEWTs5vMxnAgbj8PgFKOxDyAU+MicCtvXy0CQlEKHBJq8KPFM6J7R71XU7/nxMIDWD1TpJCul/RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172366; c=relaxed/simple;
	bh=Mh3Rb8qzvN7yL5v05SvQTB+/2yoj8j78rm5Ni0AvREM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfEb0p3Z2i3Vlv+rHvJCSaWXm+DmWmD1j6fT1IgXjq8VDaz/Mfr+h/tR44h5KAcilEqVCQ8A9OkIXV/OKb6oauSsvMGcNtqIOZMgnba6+34CLqW1e57QmpPsxRhNMqHS2INLWfWDKUFHlJJo4nR2zGOz17F5BSRtWj+M6BsrO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bCS5Qxk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b79773a389so6007311cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758172364; x=1758777164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46GgRE9cJRD9WIMiWmVC4N43zD13z9B2YDaD/7KbtrA=;
        b=1bCS5QxkhvmDeV84fEQkaWHIfHEKLYciK6TxsyxSR3a9j+MA6X2Q8pooM4bF7wG3CH
         tYgGsYmVi3i87C4JU2dHD00d1ToTikogRuWkbWuwmjwTo+5FYhnfPNF2JngC6i6zhbQy
         0phqoZatZN9JBb4cNcVkmofa57Qbep4AFNJggV/JAU40DWT6132VktV18P/Jh4NCcMeP
         TBF3+04AaAyR5S2AktfTtmeADbO0wFQhLun+BDo+5U+/9ZAslUI4rdGxDtRyqRT9vojB
         XNv82oDmHCz+LuQ0ShBTAyxb60H84qGMMl2NY9UN4RMoPh+zrvN4tBXkt4JrisRaf+fg
         wypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172364; x=1758777164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46GgRE9cJRD9WIMiWmVC4N43zD13z9B2YDaD/7KbtrA=;
        b=tAGXwMM2crkj/kYUH6nTwG4a5sbX5tQZk+gAVh2lD5zkJS5Fn9bR9Hpw/3ggnYcna0
         dUsUF8Br0nOU4u3Hgd0wY5dDUGGFH2rA+dnaZCc+1M9RcBM4aNGfS1gOc0lYifupXGNA
         s2hhxQgC6fmC90UIryVuNkh35xCMROiqWow6DEKtEMdo5r65AO0C7FgyvvSYogPJxrT6
         xPpWe8j8+f8zOOHyOKMedxnDPp4+ZoDc8wsQtZQXiTgKCZfqLqe89xRxk6ZZsv/YI0xX
         0tnXk0Xiy3L4JD97I3XYrEAhEPtDmM/11ETyiIIwy1iIuR0hA1mO1Vcw4u5vsBLb4nC0
         Ib1g==
X-Forwarded-Encrypted: i=1; AJvYcCW0bwvHz2CzgUrpOxo1GI92rhci1X074G/XX7gy16GUq4AP27bQpx1VcySqvmRljtF5CMZULbj2ywwij14O+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQ1HWuo91WllGRof5iTbzN20bi2BQRkIAIwjzf6iJu42hAjTB
	NiFsA+MgjA1uu2njW7AnRwsWVg+Qec+1JmmeQVK2V1J8KVjiVFHqrNT0oZkFvDqloC85OonxGWO
	+Itxe6kFGSfEer5Q97aTYFf0TS/W5/uz3L7Za5ScG
X-Gm-Gg: ASbGnctqOj5eB6a/GcWAJrvxZlnGDHAUXlyRzoM4leL2qoCB3Ge313Gmf1tV173z23B
	uSBkQJMbGE/IaobI+AuuNn7K8h44Ybidaud9n8tcHbesEtWCUWZpNzavIOoHWnn4usPVYLlqxXo
	qac0Q909XJjdruVtVHX4uqleiTm9gWKdpsxG+y0aaKHZ1jIEPoxT2KEDRS3uLub8ugv2tGb9F3f
	1BKj/VombyXgKnV3/eCXeBIvq2DhBIc
X-Google-Smtp-Source: AGHT+IH2eMsycX5qrNhd3fiNSpA/EDn3RQVVh2/eFGCePPiTuhmd65h+bpks81OoXdbkceVO2QwJqAJyquBk6/CKTMQ=
X-Received: by 2002:a05:622a:1a02:b0:4b3:417a:adcb with SMTP id
 d75a77b69052e-4ba6ca8d6ebmr60180621cf.84.1758172363628; Wed, 17 Sep 2025
 22:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com> <20250916082434.100722-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 22:12:32 -0700
X-Gm-Features: AS18NWBW4UjUVwdr3JfUY4L8f3cpv4Wq-6_LdiqGPFoy9WDff-KYdYxjvm7ff7Y
Message-ID: <CANn89iLewmikW_R5hFrUiwnOBJTYxtK5_d2RVEQXM4e2hNFmyA@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 10/10] tcp: accecn: try to fit AccECN option
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

On Tue, Sep 16, 2025 at 1:25=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
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
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

