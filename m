Return-Path: <linux-kselftest+bounces-25272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1207A204B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 07:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED3218887BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A301684AE;
	Tue, 28 Jan 2025 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnJpbdjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BE5789D;
	Tue, 28 Jan 2025 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738047053; cv=none; b=gN3J7cnD+PQGbE3uX26eA0JeiVOIwunLjXyFIyYiAhbcVYIckFayiuV/dQow2uEFUWr1Rec/ri4aE+m5E66pBoAQ7oMfRdWIlU2qc1nRzLRL2ah+DLesJ7LdQA0G83M0nuHQHD4vK5kOpIGO4LcyGcyC6oMa01ZSCwdEMIDz9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738047053; c=relaxed/simple;
	bh=+YSMJ1m29VdDOxyH040P+w9Vkz06gzsujkOpgPIM4+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm+YInGuL3c6fINQqsdANAXMfQKdTslOJT9bLEzXTZBb0xfTj6xKErJhcZOqnXcAYHvrWFcEhkOI5soMJs4/RUNtH3YipVKt61vHIuok9BTax27w/H7/0eh6MaWZ6QLLGH4jm3pDXzMeVNS+CC+73P2MpP/iPD0U8ZHc/7NyYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnJpbdjW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee534d6800so1241954a91.2;
        Mon, 27 Jan 2025 22:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738047051; x=1738651851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YSMJ1m29VdDOxyH040P+w9Vkz06gzsujkOpgPIM4+c=;
        b=NnJpbdjW7gFHYPj4UnzBQm6GPX7zix4Mut89T39eZD+P80tOZmwGjXX00zhOz4ByDL
         8nYTZSkOVyNEVxLGS8/Q9KqFqu+U2WK7Fx6OJPRjP1hH71LnAWLz/2PKk/dPFNXGC1wU
         8WejVi+AsYpdA8e/qa4WTt7pskDoabPY3kxxK1LAa82MxYFP/aUD5/IzuZv2trSyxYQK
         cB6jWZyH7UMqcQ+v+6vrJ72cd/7Jh9Zu9cMiav47ySrP4/9Gf4f1p+WfamyoksHdOcBZ
         xIEfHg2bu2X1kcDtFVHUneLFbX2KZ681esuSxf+H37BOzeAUdHw7b9Dzq+jV2HMm32F8
         7iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738047051; x=1738651851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YSMJ1m29VdDOxyH040P+w9Vkz06gzsujkOpgPIM4+c=;
        b=Cx5f0DCB5skgGYxwcaAuu7/0agIaInLGkXkT/pY0q02c+HRjNm5fev9majFvx7z8HD
         tYi+yUbQ8937P9Doh1RvS9ISz+FzcAAQXpIA4+K3nAxP++O/U6FvHkd2IN2CCUN27iKB
         zKe+FLU+eDk6NBNRvHCUj5J6wQBecX5myvEEsr7Z57+/TGAQZkH3NI+jPQURXuQbbvQe
         0AYjEW0HldqnzuDAqm9XYZA/k13VUDGgDytpWN7z1bvqzjnVxScZ3zugF+1Ja9+axSf7
         KIqrWpsIu663IAAGBlAhitR+F0L12Vxfhc1xGeQZPIIhhxxoNiZet3roZAkyj0Gv/aC8
         UqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQGy7GjW47K6vV9dwd0VwWHQ8DsU4pCcUL4uUM3/XT2X6gpTs4knjqtJW9AvJbS6HqE5WsCbsBhkswAa8YHA=@vger.kernel.org, AJvYcCV0VZS6d4f+v3zlavouXbT2PlbOJWQSW51SgBGi5Gwa8BJ636eh73pn05dncipp+w1gbBJRg3nIdXEcvjAV5XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4XmJAcFZ2j7WHdCCLlNEdGnGajB7dFgbEMMBRThF7ZrySI58
	HXVgomPQuCCyuGuVlmE43wTy9lj8RJmHP7/sPh/GDZM6yqt3/jqiX/EEtQ1M8GMUODlJVk6N9By
	yVHTYtSvAP71LcGv0/r4xCnJjE/E=
X-Gm-Gg: ASbGncu0YQLqo5l8cIHYOwqhRv+Je6orM5Ot9wrGfXJZR8zEzD5uLbLSKk56mTYD5+g
	8qD45S9Q/NIToq+WUpyUNP1dShW77zjqt5+miE50WURXaRfom7V7j7bqaxzrB169VahKkwXbw
X-Google-Smtp-Source: AGHT+IEfp7cO4bf8yADlA1Z+8V8k5ciAQm03DwLjjokSfH7zhBc0LxhJv485HCzDvJLhBQ32BVGcqycfwWvqEVCiwok=
X-Received: by 2002:a17:90b:6c3:b0:2f2:a9bd:afe9 with SMTP id
 98e67ed59e1d1-2f782c562e7mr23122134a91.2.1738047049928; Mon, 27 Jan 2025
 22:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126223627.732451-1-sergio.collado@gmail.com>
In-Reply-To: <20250126223627.732451-1-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Jan 2025 07:50:37 +0100
X-Gm-Features: AWEUYZmLxC6KL9K30h8XJdv0Z8Z3c6IuB3wDnbcZnECn4wf69K4pE2T6v41KhZo
Message-ID: <CANiq72koWg-GGD3w5mJw3F-hGrOBZ7hiK1G4pHY+y_rQmtG5+Q@mail.gmail.com>
Subject: Re: [PATCH v6] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:36=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> +#include <linux/kallsysms.h>

Typo?

Cheers,
Miguel

