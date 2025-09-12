Return-Path: <linux-kselftest+bounces-41424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856AB5580A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 23:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A617C8461
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C74322A38;
	Fri, 12 Sep 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdbk9Rzm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BA20FA9C
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711182; cv=none; b=eGTYLxuAIxJN9p/zXnaqRZpiTaW4KqBWFsZ8tmN7+zzo56qg/bCaKC48CLv0XChm4TyZwAhUoYJmoQP9IMkTrLebTcDsYvXWl5G+xzi5jj1fBooMW3z1IeItE6w8u0qaolo1OlhEAYUw/SPMvMfjX+lt/BurfhnpKjMK/idsSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711182; c=relaxed/simple;
	bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCDA02a1G0hO05pxlCVq5O+/Gk1pgLgpnhMnvIwuKRw7GLdYkf9Qc2wyE4Ufef7vg6sJqriUmT7dFZq8iCeCXDSzP90qQiWw2ofFKfHncejzj7IKxNjzWJUI91nVN3+0RiwNBLCUx4tQoWsTFr3lYb8GATQ1N+uWQ3Q4SBDEeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdbk9Rzm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso771e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757711178; x=1758315978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=Gdbk9Rzmm43q3XC1SuwbKR27h6gTtC9UTih2MIM6UPO5RdNR0+oYmS0tXFpoJa4Iuh
         olz5CvZp9LuSdXZJPD95gxUvPFx0Ipjn6CaNTF7eHVdeKTeR8pFVCi63G+Ghklr2mSH2
         YbpJI2i3PhRv/r/z+V73avfQDsj6tpYr3iKOoO0SNi5Ruum0wOIqwPoIRiRbVZ3kfuzi
         fGgsu6pcSWrd4PJ0YVHHUlZ/zDt+njq1TT9pVtMssbMoqk0DNuoGXYPU9Glaa4Bacj8i
         Oa2J06pWBtDV7eTSD4YGaIovPLWLFAsFR21FEAnPdfgyF/EmKT2H/Glg3tvZnezV4bjc
         Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711178; x=1758315978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=j6iWsTPR4B04IpKHy7BQFEcj83NGM9ZUxrfT94xNsWH4iDgXWBgJ3FQQBOM2RQYQQh
         SSOVOX6OO8Jvw1IPcD9zcz7pYK75AWha/rR8FM4yJQ3sFPM0c+E0WEBoIsHYX/pbT8D2
         mGv5I/vRSW90p7P2x91qcVnfvHpUsenIJRFzJvj4GMt0PlfKH3LUEMKgxlIOMiiLYtzB
         4YKw/7/FwaM0VLckuhgw50siprln9dmivoMM7Bw3YFFnkRxmuQ32a0Gsa4Gr6TuVKQo7
         7i5b8G4BOrh2LHFj42UbaMskSmR8WMx9GZC52XtlX8NIwErmrddV0qlmwpqJGTuEikaq
         wLKg==
X-Forwarded-Encrypted: i=1; AJvYcCV9/frSq5Gi0/faOgvWxl4IOXQAcJ6D0I/AO4a6RhjY5l7NrtqBzTzomfk+ZEsM8RHKoZGgZA5VttbPFlFTZVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvs92iXYnn6N3tHcA+7Tdj/qUAaVKnDRq5FXhx0GVAEzaXAb3F
	egjoVeIWup2oGgIz/+gGAQXlTCVfrLVVV7bppYTfnLEHMI8mSChpY2op0P9k8p4hCGdE++2+jtX
	SeHabb1VI1SegOJKgrW9ra361Z4/i47ma3v7d0+el
X-Gm-Gg: ASbGncv2SyLBRtN9xy/UEpXXQY18kHm3BmzsU9/0JrVjq9hX+nVP5e9yMvew0Dt1kkh
	Z+/JITB1WTDzbH8cZ3dt8KrlbYJZeJQCvgzmDSLpjy8IkSfwTpQkJSNhTJ37uCgyJd/xs76B0aS
	ApC/junTCOqNnr7it6iGpKrLdhLjQuFVGijsAq7KUtXU0rFFeeEGzpybdZsF4cVYCZQ4EVVueuX
	EEdhJmH9jO/a8rlm3/1fICZdFuVLCa9J72+3C1xu+qK5eU7N6o5/PI=
X-Google-Smtp-Source: AGHT+IFo4cD/BxVNOTywCONMB0xxSgIfWIheC5wDA9CVLI7iF4J1whY/WrIulwEDO784Yw6phn3QOH0lmYu8KuRZe0o=
X-Received: by 2002:a05:6512:4284:b0:55f:6aa7:c20 with SMTP id
 2adb3069b0e04-571ec0f1920mr31259e87.2.1757711178303; Fri, 12 Sep 2025
 14:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912170611.676110-1-sdf@fomichev.me>
In-Reply-To: <20250912170611.676110-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 12 Sep 2025 14:06:06 -0700
X-Gm-Features: Ac12FXyWyx4o42PDWjsODv1chbAaWgFV6VBuUC2qYTuwYWTDLJD2IV5Da0to1WE
Message-ID: <CAHS8izNSeLSzkTsmhcVwJ1fF25Y_LY7vo_LTWtVL+Erc8dD6SQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:06=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> RX devmem sometimes fails on NIPA:
>
> https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-de=
vmem-py/
>
> Both RSS and flow steering are properly installed, but the wait_port_list=
en
> fails. Try to remove sleep(1) to see if the cause of the failure is
> spending too much time during RX setup.

OK, I can see that happening indeed.

> I don't see a good reason to
> have sleep in the first place. If there needs to be a delay between
> installing the rules and receiving the traffic, let's add it to the
> callers (devmem.py) instead.
>

Yeah, I was worried there would be something asynchronous about
installing flow steering rules (such as by the time when ethtool
returns, the rule is not yet fully active), that may cause some
flaky-iness, but that's unlikely the case.

> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

