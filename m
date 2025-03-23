Return-Path: <linux-kselftest+bounces-29621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A3A6D0C4
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 20:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD816C050
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Mar 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63F919C55E;
	Sun, 23 Mar 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJs0YjcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787681946C7;
	Sun, 23 Mar 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758107; cv=none; b=Xkld4p2MZ2CYsCyz43k0nxgtoXkClLdrUsUUyP1MK7JR7jmg1YCQaiv+4GRrL/nIl27tGXWDh16fqKQvAPKiBHkM/JDPruavSkWlOIutxALBEw0OhofJAKnFvBU3wGfQcCibvg+/guYFOafkc7WDzV5LC6fbYhy+aFmQkRyq9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758107; c=relaxed/simple;
	bh=kGH5/CTpQKM7kf9ZgU2OdVOxJkNxotXc5CxI5Z5VwRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oae4cocKXUPOS4o9op9d5xStod9iVKFaz8zQsWpavtlB4nTJ0pqpylNPvBu6IG80gctKCWN73J/igW8DyK1B3gIe+2Wa4rt0WyKaQLbgQKF0SanmmoEAh6ei9ZXVzV1V5mT12OwhJFOP+eWiFQEY2d5dWOIc5Qv1KoXW2RlZE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJs0YjcU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de10eso9722455ad.1;
        Sun, 23 Mar 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742758105; x=1743362905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGH5/CTpQKM7kf9ZgU2OdVOxJkNxotXc5CxI5Z5VwRY=;
        b=QJs0YjcUpXF+V6wkeS811rTa+SBwf3cf4zaBYMj4F4ZC0wAKw0g8GyTwWCxzw1b5Tl
         8RfCbN4F3YJlbR+TJCnf8MpDNuFMsYp20RhZWV0dovO4ZVQxs/c/7ukMXeeyBSNBRjNc
         59QGNKjqAY3Wn4pF3TU8NsHZVVk8d8rp6dL91BTeB8rJfxQ6rJ7pIeMPmEfW0ZgocrRW
         7vMK3o19mtBabbcMvQbWyXIIIu+hS2SrywpyZR/LMqpuuBiSIDDhxK4laSU8Tdlu9+9i
         LH6SvCJ7se79XvWeOjAcEXDOR6vBcAVu9r9l/lhosdz5qRUNLBl7KbT92yzI89+Wflb5
         P/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742758105; x=1743362905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGH5/CTpQKM7kf9ZgU2OdVOxJkNxotXc5CxI5Z5VwRY=;
        b=LKmPsqvGu+pDnvte0rsTfAjbZusIJqBcYMd8k4xD+CzSMvaZQRwgjVhw7N819B3UWK
         eDpzkBPVXj5KfAVdpXB5SIzyNyRgUeBsnhZfHQcwK+o/9qzsw2sLeYCARmbttx14ffCe
         iRad81PKmlg0TCplueJwPxTFGMVHb7LyQbCVmBcOdoYbZ/09EWmWDjQayPrS0hcNK0f0
         O1uy15HORAozX3rYReWP/8Xhf9ndF6oUlwdtRTjEMa3S7yIw6R9sU/AUdf1WcFOFQjkK
         mmMwis2822ltMk2Hs/gfupWliQ3OKKUg06ePE52Z2IPJniTrtKKtz9uFiQYeUbz2lhO7
         ZBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUaFMeo60n/UNxQcIbhtieAIxoR56aojWDctChsy1o2ycOBTts7wEn5R4k0Vjbw1NOWaHNX6Q4X1dALb4AvOi7j@vger.kernel.org, AJvYcCVoqHSGWhrZd+9lNKkSXzyxn+st9ErL3PyliXPyEcGdp6WIWlPUemBuZFvB1YOw9OccpOQlZkaO4vLsM87+UFs=@vger.kernel.org, AJvYcCXr77YU1ZFH6ssTAdlyaPAdQy4LBglPouleYIL1leZWwLzy+bUZdzwBu0QKluZ3qI8VHyzdV9rM6DP7Czo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGXkRxkTLTYMZ5fDlDJO+rZ9F5hUkqRFOfYEaB28TzZyjK01A
	rGXSF68ECJu1SNOJrW4qzwEPaogYUx2MTzpYk1V4b1P40mSKV3asfU/NiKo+P30bsnSwD4aTYr1
	AHZCDX/bkTsQqmo+GqKADI0MmW4k=
X-Gm-Gg: ASbGnctxuymlU5/ZgtR19DEqk0/+L8C/2flaAv1W8UL86xuDLlZrx+/Qb6YNcm6gjLr
	D5gvEftadC45N8QmKHI4uBsKoV0bQ5LqN9EGJXq2eF8mdsertjrgD1M5cNvnBgJO2JLFbZ1iE13
	mAPAbK40Y5YhWI3oFjmeasTaodV36toTgKYpTE
X-Google-Smtp-Source: AGHT+IEms8Zqvix1j44iZCMGR7rzEuXMhZQmOiNQtD8SeMAWae3Hu/55rylGMMQD9D/NmoQhXT3P4ZHnKpJYPWuZvYQ=
X-Received: by 2002:a17:902:d543:b0:223:4b53:7349 with SMTP id
 d9443c01a7336-22780df1736mr61515375ad.11.1742758105615; Sun, 23 Mar 2025
 12:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-9-contact@antoniohickey.com>
In-Reply-To: <20250320020740.1631171-9-contact@antoniohickey.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 20:28:12 +0100
X-Gm-Features: AQ5f1Jqvq_eKaV5-b8YwtT1cUR6hqrQQAMYIapt-T07hwVu_magImFA6N8hGwIU
Message-ID: <CANiq72nw0QOq0gJDVn8FKXqiFGHi3S1XZP-ti-KCnVwr6XB0xw@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] rust: kunit: refactor to use `&raw [const|mut]`
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:08=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Replacing all occurrences of `addr_of!(place)` with
> `&raw const place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const` is similar to `&` making
> it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

In general, you should pick the previous tags (e.g. Reviewed-by) that
you were given for each patch (unless you think there are enough
changes that it should not be done anymore etc.).

For instance, in v4, this one was Reviewed-by: David, and a couple
others were Reviewed-by Boqun; and from what I can tell, they didn't
change.

Thanks!

Cheers,
Miguel

