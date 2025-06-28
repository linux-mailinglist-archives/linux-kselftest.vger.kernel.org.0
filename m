Return-Path: <linux-kselftest+bounces-36027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DDCAEC569
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3426E32CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309E221286;
	Sat, 28 Jun 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFGSgN/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A28635D;
	Sat, 28 Jun 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751094846; cv=none; b=Swp8U7KC9HGo35TDxusYexhm2AmGQt1d/ottYfljluYi63XzlInFZ9gTzXEnXQpytWu3SzkpGi4016/DvP21jCE7uxxOnLldDtLEhzshVC1tr2nfIC5vALG06SHzuGQHkXVu15t+bWQbZS2SlJNo2KHmYNvsBmaskwsEzwIjIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751094846; c=relaxed/simple;
	bh=H1N2WeCN9Ubm4R/1tsb3yfHGSgMXi8Z9AP4UNGlOFfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO7VX5D6/bOL4XxFDpJiuFseq/Xw8tOYROHTMQwVYFTt5q96GuV5rICcdrXEFT0yMwDeCSKujMAF5JC22UGq09uvzii/0vN7LI8dANngERL/CNW548mFp4TlZPDw2mong3SaJELbYC0aKxODsVfjKIouzJDeTttRVCE44MtvCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFGSgN/E; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so574963a91.1;
        Sat, 28 Jun 2025 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751094844; x=1751699644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1N2WeCN9Ubm4R/1tsb3yfHGSgMXi8Z9AP4UNGlOFfw=;
        b=jFGSgN/EQnUgnTN4l/bHq52+0ntt7f7YgHsbsqSZsSW0kw0/Ju+hP9RhLzsF+SLTBP
         h03ajTPMrZPRfppirgUPHEWrpUorGQ+rJv8p6BUGaZ0zKuFfPXvivAK3SuA+bsxWAEz6
         MrmsT6t0/iMNvBGSCFYIoMuUsWaeKLHwtCTMVNiqHxnxaIerKot4HJZIWeZ/kFBOeUp4
         Jf6QfHr/VshT9ZkVJ1R+7F0v/LCujOmTEWbL0QpehP8N49V9djidIaLquc2PeHGnYgfz
         lxzvdfc0bGdLNYDW1C2c9Pc0H67jS0CZEf5ga1mhHO+WU/Yzcb69kG9oMlxdK3+j/TcU
         A7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751094844; x=1751699644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1N2WeCN9Ubm4R/1tsb3yfHGSgMXi8Z9AP4UNGlOFfw=;
        b=Ll6hEUZEH4+bQfTf73zHxWerFraO6WJjTxqqojYER63ek3uFaKtq9dtiKC3rFjZyoz
         TUiAMNs+LRYbK1q4cU/CuZ1Qle46BEkRgk7qAr8U/xTyE4psV18lkv+UvkwAKuDkJW5s
         L8NoEW7yUkAwuMDqC0OslF32H5FHBdGGoj4wGOFycUx43O5/0Qo8QQglDioLER6Nbsyj
         Wo01c7Pp6amjCjqhfdEvkJNY7bNmhT8QECECN28p8vBx98j9IIlusDU19PcD4YnYe+z0
         0qX8Jsagh9CkM0gr0b7zu/xd4gp/SD02fxokXTtHBLArWxNA+5CIc89K6HlH8D2vWkH9
         w3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUludUmhBYeY8jNJN5B7M6U70zgEiRY+NRY7N06YKsz6isZIdC2PgKBFYRF23T3p4dVw1vf9frSaOo7kXs=@vger.kernel.org, AJvYcCVGq9GN0zkmLEqOz8nCgCjkRpJsWzEKkp1iHCPuChSaXszYYqaCrBOk0YbK379D9lNmAX/tQUv06ac=@vger.kernel.org, AJvYcCXL4a+cl/rEUOC/Ocy82JgZ05Wza34XMgR+gBb4g+I73lUH1zFHf2SotHKS7A87/EF41y8SufW9qFjt5SlEsPix@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLoUg/Cvl5pLuMAupUp5UrpwyftinLY+WycdggmHXUADlIvDX
	B2uhHPyVf4R/nNuxINslFrplR1xofWGoJs0hnK3a6W4e8dAyvFnmS1MjdUmCAq7KGQn9VNTjIdP
	D4kAHJPghF0ETJBPh9EpOtcIIY1hk10A=
X-Gm-Gg: ASbGncu568OUf0eGxl9mau9hmpQ9Z5vmNor26iXaO0ycsdVr7iGXXY5OHhiKWDNTjzL
	WsrEZU7cFGlCTKZ5oBF1xElKvCYBFMpPxRk+8xnnmdA0SNHHAotEQjJgd0OG2EYnc87e2P7xILQ
	a6pIQwLHsrQMc96sG7HXLW3ab3YKhEQLsRWI5mLEq1BwhTmpb5CZiRtg==
X-Google-Smtp-Source: AGHT+IEiaOH6ajuLpwpwZz2av1oq2F3csYt/I+OBbc6IxDRF5jDVIWZ0gicRa6bCrZYV0QOxsk9yQObhR6Jo8uBU1pg=
X-Received: by 2002:a17:90b:2e4d:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-318ec4117d4mr1196429a91.3.1751094844258; Sat, 28 Jun 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
In-Reply-To: <20250628040956.2181-4-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 09:13:50 +0200
X-Gm-Features: Ac12FXwmmYcafnkojfcG5S_KqGaI7dG-A-bId82UJsz_kOdPdtwmEEpPMVImX7I
Message-ID: <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rafael@kernel.org, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 6:10=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> Clippy no longer complains about this lint.

Do you have more context? For instance, do you know since when it no
longer complains, or why was the reason for the change? i.e. why we
had the `allow` in the first place, so that we know we don't need it
anymore?

For instance, please how I reasoned about it in commit 5e7c9b84ad08
("rust: sync: remove unneeded
`#[allow(clippy::non_send_fields_in_send_ty)]`").

(It may happen to be the same reason, or not.)

Thanks!

Cheers,
Miguel

