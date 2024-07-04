Return-Path: <linux-kselftest+bounces-13160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EC926DEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD832281074
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF961B27D;
	Thu,  4 Jul 2024 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4iByv/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCE19BA6
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Jul 2024 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062725; cv=none; b=kg2P5f6p71UmzMYo6v6ZIFqOnFFwVINjr2qvRsTE7EJg6l4/GRSWTh0aI1fU2I1DE0IejQFlreIiXM6k5geve9fPPWm5zVAcJIHATAbqKyg9skgCRkZP0nLMnfgjDxdpYAXVk1f0JtxXrMT+Zu6Te7KmtQXgMoSQ4goACAhDSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062725; c=relaxed/simple;
	bh=/UiwJ7vry61dcxTQxjF50Ei9WLGwz7HSh/uxSqg+XYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRs0jJhbx2GsO/JeUBRR+Damk43QrB5sTucpTDD6oD2t1jROTiltw/CDvMt6OwGrLQMRf8bwy9Bu9p3k4GQZyT/CfLNA2c/cOPw+5wWTM5zz/2xVX/WysQmc+bUV6UPWSjZaCSCIxdGOeqJzQgugU9WpiKeT/ZtdjyAiukjJLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4iByv/z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4255f915611so39085e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jul 2024 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720062721; x=1720667521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hnV4ceST/LkaHatjT0/UaxHlRuB0JU9sQidd8Wmj6I=;
        b=Z4iByv/zXiVDuaheyR+bt6aCY8mWaSpcLkxQH2yEocRuAplkyNUg+xmibxIWellg57
         TprFBItVSsGSfJJxafUIdeitftSPMqWxod9ZbgkwRqMibeBqg351ToGXOnq1/tGviLkm
         GfqTmvQnvFlU3bWmYrmzYM8S9ySvw0ItWiUy0QOvP6VZBsEJgdQxMHTtjVeai+sUKrVS
         m8WlQxUwpGi/Vp8lADElhljxhiq32ptYKARnJfXWfr0lRz9NhOPCqOt2hBxWBBOetf2S
         OeRtT0r9Wx4EolbYje2E2Ct+WVWW12HM2faTFPPK46cOyYxio/koiRuZiGSbITZhUBp4
         T1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062721; x=1720667521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hnV4ceST/LkaHatjT0/UaxHlRuB0JU9sQidd8Wmj6I=;
        b=ujz0mVz/jx++R8vQkvh0fvgl9V57S/HFmnn1e3BAOxqjpY9ykxJhhqrihSg3uIVGMN
         VV+WDbOmVyVrgXsbrdB8mtGNbx6z/4v6PAqSXOcmALRaStyo2W1XPF2ZJ5KAwm4tm/M0
         3Y1W/Z7Lfjuj3AOzysqUXjgZfwNyj7HOeHE/s+NBN/V92TibJkvWGhVyM62m8XoH4xkN
         oe3bPsGt3rTm2vgQLVC3+5HnaTjZ0Seutge3W562XfSeIAxXCmmVjTIi/0dVo7VAsACr
         922P09pBBvBJL63F5wIdvk4LlwKY7lyDHP+NYzwpDts8Hbc+I5enSghSOBbbg6UZ4LXS
         AhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOAAnPOTUXHxa48PKZ+he/5vJHVuLBpd00z6C3Ebe5EM5nPzKAO1iCoppo7DOE7hNOo+MEciXOccywBRsDKorZuFWshnccft2CohLP3CO
X-Gm-Message-State: AOJu0YwhYfW6Ip5gU/37xGg16FBOw68tyyEtbelNpqL7EaxnUTrkQWzy
	lS/FddoV5FH0K+ejdgt2Q9dofY6dSclxUY1mzCkM2cLEPvnwulLUVDygm6TG64WixRGhx9XEyuN
	dZqfuH/xKhNbCCGz5easSqO3UQ4SEp72sv98=
X-Google-Smtp-Source: AGHT+IEuX2Qz/ogfT5gJgXQfb0LHWMxBUBN7AnqQd97K/HY1a2IRM5fhYc2R9zomHzZzKODquS0fRmSqFZrrC30XS4c=
X-Received: by 2002:a05:600c:45c8:b0:422:ff8d:5d25 with SMTP id
 5b1f17b1804b1-42649a552b0mr614825e9.5.1720062720857; Wed, 03 Jul 2024
 20:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704024202.84726-1-jhubbard@nvidia.com>
In-Reply-To: <20240704024202.84726-1-jhubbard@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Jul 2024 20:11:49 -0700
Message-ID: <CANDhNCpEvPL+b1mve-YJp4+yzQU-BAaAQLr1-G6Br7i83zaQaw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/timers: remove unused irqcount variable
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:42=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> When building with clang, via:
>
>     make LLVM=3D1 -C tools/testing/selftest
>
> ...clang warns about an unused irqcount variable. clang is correct: the
> variable is incremented and then ignored.
>
> Fix this by deleting the irqcount variable.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: John Stultz <jstultz@google.com>

