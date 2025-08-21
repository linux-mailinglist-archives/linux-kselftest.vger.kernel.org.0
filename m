Return-Path: <linux-kselftest+bounces-39468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BEB2F30F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E54F1C8215C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679642ED84E;
	Thu, 21 Aug 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34LPbofN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640F78F52
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766653; cv=none; b=ezJhDJKSLJnrJAMHrIzYJ/+QeKXTLFAvhDaXxodj72uM5SsJRzE6t480B3QhaeEBRRfH7EQh8gh0KWiwS1xlczBJ42KRem0Z/84+2BPQjv2zZH3j2mEm7NDy4UlHhU3aMMh/MJ0ymoZSE0hPSU2rJcm8e7TnkzM8LMZWKJ4KS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766653; c=relaxed/simple;
	bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnmRMD1Kei32fcWcAZu3JGPgA+/Azazx5tBE9yZ+l08AGBLjQ97ioX2l9F41nEqpTn3c2dxDbtvAhvOEgVROBddHibm5SI69JV0SxGO89Vl9+lH8QLh/AwvPbbR3j1yZbJhJ4WZMWXG2eSbIrCm4CWrpelFYXJRg0nm+LK2cQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34LPbofN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109914034so9030961cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766650; x=1756371450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=34LPbofN4P393q4BdsajQS+Dcf/7YiXG5o8TTfwaN2xa2Aj05qogAbxjT0AKPYkQ/Y
         9waoL9h0FffDGh9T+d6mnHq2Ki7OvZ13kVeIW0UkZakjsSkicWs39EJTrq6q39FCWepH
         KJ225+pQTIa7n36CaHDZBUo9rRrshfYFezAivhxyjvUPFEdXTFYKpDj7LBsI2207TGG9
         lBw7adFPKXbngAv+misegPBO/2f/FSqyk7AATVNopXqWf8nA7iq4VqWTBram7bKZ228T
         InQV5OcTf4fn4GMMv89cI1VaJQ2TL0Wf+wAL+fRPA6mYEdpFWISIXyhHvRWlfXlis0bl
         xZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766650; x=1756371450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=LkJmqeqeJat1kIoyoB2hUHeVpjRtxUjl2EM342og+j/OzztXc46HKlCTgHksOfzveu
         S/LQCjd7KC/HvI5IbaQFVazy/bCiZYyFM1OQC09Sedzxa6jMJAj6b+75h5QbqeMgmsaD
         nlaj8Aj5MTDtqOWN4Vp3F2EZ6e8XbxkfvTjYkTB0OM8wZmJRq+kmC6zapJJDCaU7EfWA
         DgB3y7yfO6opbx0DOc1Q+ecxoV3j1pClQguZKx0r/bzPvpy/f6KPo/n6hMzb3UjKWi5Z
         6RW0bv1mcYJz435LPcsGikaUOyR/BEbK/2pHiueqLkV6Cy7QvYFLE9TwYQxy9jAFupyp
         GZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCq05fjsrrwx+OH4ZyXhRD9j9Iodc1xvOvKhQOIDbIetn/F9yPxVjvSH+05SyqLgTIAPJ/0Tgmp2QX6b1mM3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOpwzSMSQm1lL5eXYPzRp4zDFirb/eT0CZrvT12BvXaa/WRED
	u4ypgM6DuWwDx9mS5fPYFqOEetp1VbfBUS5ihhkr3zmMS/Ve9gG0bMuM2Wr8POkJIqxtyPW+ZNl
	e62dszKd5qlvm4UttJdHXDLSqDcKcvm/znBehCdqi
X-Gm-Gg: ASbGncsRpUawfxvHzVKVTcDVdN9l8itfUmrUiLnGGbHAEC4tachWTq5BOlFXVReo+Jp
	yB8O9a/mVYzgSxE3ll1WOr3Z+8ysjzKelx7IsNX5X1TSA93iGYWM3tgRYJTBCoVwzHOnX9Najk7
	H+bGzKB2L6yLhy+RlWfneXpvFRfu+YOHJDZWfjCT3CUDZxGPJnMaI9lrgcBrNQCqlw+jlLZUgNh
	7uoGpDcI57v5yLyPJT0JFmFQw==
X-Google-Smtp-Source: AGHT+IHFkVfP6J3M/7hhl54OhQNkRmBSxPwdT/1PDEOLJvFDH72XGIwIh7eQr1CXffsV0ym4huij21JS8QYACP49XxI=
X-Received: by 2002:a05:622a:1a08:b0:4b0:b7cf:8cde with SMTP id
 d75a77b69052e-4b29fa3c3femr16301551cf.21.1755766650133; Thu, 21 Aug 2025
 01:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:57:19 -0700
X-Gm-Features: Ac12FXxEjL-42H9O9a-b_qJb1E8Dwb5jTLFUbV4y5evL7fDRVFtenhZTNyo0XGw
Message-ID: <CANn89iKhAKsoZX-=LkMNTjghoyuZ5r1rT=Pvu=wua4M=DPSWBA@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 07/14] tcp: accecn: add AccECN rx byte counters
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

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> These three byte counters track IP ECN field payload byte sums for
> all arriving (acceptable) packets for ECT0, ECT1, and CE. The
> AccECN option (added by a later patch in the series) echoes these
> counters back to sender side; therefore, it is placed within the
> group of tcp_sock_write_txrx.
>
> Below are the pahole outcomes before and after this patch, in which
> the group size of tcp_sock_write_txrx is increased from 95 + 4 to
> 107 + 4 and an extra 4-byte hole is created but will be exploited
> in later patches:
>
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

