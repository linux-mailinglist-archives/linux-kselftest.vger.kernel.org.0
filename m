Return-Path: <linux-kselftest+bounces-48216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09FCF4CB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84593307BF93
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5762FFDE6;
	Mon,  5 Jan 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOR+skdZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FE2C21F4
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630599; cv=none; b=RUeLE9e8EVWV1PsOZW6hFkap0DL8BTRsafIFeN6J6K+hCIvu5em5Y2oSJGxXFvGD7/A8hkhmmQiYTMZ8rAX7itUDmciwXHadKle/JnTwchORZdFr0TpPLAQOeF1RIBSOCcdIX0+2cB/C+oZoSyvO4sgmbugJeGQz/TCc5zjiUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630599; c=relaxed/simple;
	bh=IzBhnusFCAMo84Jb940P1czWpL3xxUZizLdSUlWRJKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDgStt7WkuI4yCzoSHwSBdIWWZVdJCaDqtc5MrlNjSvhZ/PLThVoxzB5i7E/dq317950sQJVqWotS0CGom8PzMM0LcJ9RULODs4JGxWLTIT/34A1hymBjhH4LlnKCRQ1FHUD+Qp10XRMotPD0NuH2+8T+ddXJvCbZN/KU2b6UwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOR+skdZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a35a00502so471226d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767630597; x=1768235397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzBhnusFCAMo84Jb940P1czWpL3xxUZizLdSUlWRJKk=;
        b=fOR+skdZuZRjmwHXixhb7ykv5VaS5GLFAKkq6QWyivqkrfkMhTgprClSEBsNxNj9JC
         2uN3236MgzSLIqOAMyFgcN3tseIu+LweRcUNE1HbWfcUVmIqSGplWBFdvPECeaPme+w+
         DYSlHaqESsnedpmIuq1YNaiOEMSyibsvIVYu98/UQbNGCcR0ynVdXUZvxsYIRkHfzpMu
         xRwEyx2cbAWknDzGVbT6f8EEReeCOZb5WRw8bQSDpUoBmcT/TbMS5NL/q94JVWx7HZAB
         Ng+2pSWqItwLGBfzUaidzllmPxiM+AS5tDbPSMBUwr+4qfaFgAt0HGZ2vbnTkA38F4h1
         B2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630597; x=1768235397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzBhnusFCAMo84Jb940P1czWpL3xxUZizLdSUlWRJKk=;
        b=Bh4CiL2x9npCG30cktoQf/v4TLiAwKDwHg8fR8JASnkOyG/M1tdjFmdlBh4sVzO4bx
         VFOmYohKboVDanctol+3r3D3lhasTMwlZaS9kml/vhWFifgGMlR/eFLzkBQvgSRh+ZWH
         8vRacQTF01SyvmZ43nF5xVxLjAU6nmtC0g1d/BzCTs5hJK0+vjy4nJj16yOSu29bkbIF
         OM2ahgqF5o8X3eMAdYJ0W1xPxHRY3BrkYC9pI1dAVuVY2OUF56uhLfPN9xfspi/aYyFe
         Yid0pvnALeKJ9UkQINpJr+ri6E8d49yiPVeRFElbgPerk7teZuXs3liadBPwTiZRXJql
         wYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVxyWQzUHOLapGID9F5eqUS8LIq2yM+Oq3XgmTLwgV+QVxZQ0Ew3piXdT+ZDuWIIsQyKtlByEO3pQb7VaeZRHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy9igI9FeUiLtU0ZFGvtYZ4J+epcjqFH8FGGAMS95uTydb52u
	DbUywWDZOjHDFDdIsoQAKJ9/+wIZSQo9atfQmOIT0IvqTX4/9kfosKf1qW6BPtubaNTwu43Ulhi
	Brr8GjxSkwwwMSSkFCJ0WLcg1ttmI0fk=
X-Gm-Gg: AY/fxX5JSutxZ1P9KQYosA2GttO87xZXXKEoQ6vT4zjdCbZdfybF6i3WzlQB8uYLv1a
	tNdVGCFUyn29HRQC+SHGeV1K/4M7sr1AAXWdVQRFIrkRHGjrz6aL1CYN6rgvk61XXyDJoFJeklJ
	lI6fvMnJf0OtmnTrg1SlJVjpc/fv/Du48pRFf0HG+VqqpKfM4g0a8QQRnPiXVlPwr4K/qaZDZY1
	/HHGazjvU41zfpaFiL2aLHPkgHXTVktsmuqr887r1bYiMFB87BaETjwEyRwezHBitpaLJA=
X-Google-Smtp-Source: AGHT+IFTMOpc/8e+uL1GQ7fF5sBChaKWHwd9UMrGA46OOZLEB+u39SXKG9KG7vh8NI4XWoafXHtvl+RW2njzMIlVMK8=
X-Received: by 2002:a05:6214:2309:b0:88a:42b1:25e7 with SMTP id
 6a1803df08f44-89075e22fdfmr2571306d6.29.1767630596862; Mon, 05 Jan 2026
 08:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-kunit-kbuild_output-v1-1-f1fb30fe060f@gmail.com> <CABVgOSkE1ndm+Mv0S5+XO3Ofd8eP5Ke7-ZbfVBc=-kOEDAkrYA@mail.gmail.com>
In-Reply-To: <CABVgOSkE1ndm+Mv0S5+XO3Ofd8eP5Ke7-ZbfVBc=-kOEDAkrYA@mail.gmail.com>
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 6 Jan 2026 01:29:45 +0900
X-Gm-Features: AQt7F2oCUemgSYC49zy--7_67pmbR5yR2khaji_-HNZAxMz0rJofaVbGqGViY5E
Message-ID: <CAHMDPKXwtOLuM9Qj2AMcjoMGe8JbBFgLAOgyqg1UpCgxArEGmg@mail.gmail.com>
Subject: Re: [PATCH RFC] kunit: respect KBUILD_OUTPUT env variable by default
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,
Thank you for your review.

On Mon, Jan 5, 2026 at 5:53=E2=80=AFPM David Gow <davidgow@google.com> wrot=
e:
> Two small thoughts:
> - Do we want to make KBUILD_OUTPUT the KUnit output directory
> directly, rather than nesting .kunit?
> - Do we want to make the --build_dir option relative to KBUILD_OUTPUT,
> instead of the current directory?
>
> Personally, I think the answer to both of those is probably no, so I'm
> happy to take this as-is.

I agree with you that the answer for both points is no. Keeping the nesting=
 in
KBUILD_OUTPUT seems cleaner, and keeping --build_dir explicit avoids confus=
ion.

I will send v2 shortly with the Reviewed-by tag and remove RFC.

Regards,

