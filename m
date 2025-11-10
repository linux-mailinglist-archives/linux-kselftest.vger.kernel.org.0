Return-Path: <linux-kselftest+bounces-45223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5BC4676B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 13:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D33D189BA64
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1830C36F;
	Mon, 10 Nov 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRo1jBDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEB308F18
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776263; cv=none; b=dHjQ0lpjnY99VoFMqrxC1P6i+scFslq+ckx0lqbWSnASlx/hLMf0WJWp6gPkx0PzT1hV0X5+ylwFba9h7KyHA0zWdoUF5q1+3C3xhxRQPoM0Q8gJe5qs+gqBvfVeFbyhAaVmvuybZZC1dZXUOzc45UAiYIlc1d9HTqQidyidgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776263; c=relaxed/simple;
	bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHJdIBx8zf3/H/raPaxTddPgYq/XCC+nGmULa8YcGu656tMeGx0KzMygq+cmDpJJ21Zhjj9jO5HDoRwyGfG2wzWf4ItMde/nmI3t9iXXo1GOh+VxWFCZirMaFMbbPWiXaVYI4BlSHssFlesq556R5R7KBYEoK4OwiuIOLTdaHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRo1jBDN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e2736308so1037965ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762776261; x=1763381061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
        b=fRo1jBDNOiODeONp2SpTugjWLgOK/efWMsHQLlQHcC39kP7+sh9HhPLPj8/JizonyG
         7b+QCsSt3zqOWPgd+pwpn+79kM+Tr8XpShLgFpvK9sMrxUKcafSB+bvJWIr0APKJPJg7
         FfGmp6mGdLDLVVDc/3CMatGQRzDhuP14hfaMDLh5eXTBTTKJpB2tfGfVMO8UGhsboMd8
         0wN66lqOn9Lx8RL+khOb2Xs2xWJs92R3N/wyljDcWri9FjTgglb3XYeu1hzEG0LGrpMO
         WNintcuhk3OKBHp6Bk8NmnCMaSr7/2x9d0tZpj+cQfVkCU+sDg1w2CE8Gmq4SmTzGKUa
         fZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776261; x=1763381061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
        b=jKJ7qlNklAidnKWyADmX/5mh6ynl5WNRVZnK4v9eX+n9jzzdVWYi/nyqGmU9NeuOcc
         1HiCpK/GrVtJi9nONgtwUxa0Ijd4ao1RRp/KUhZpwNV+BUrafUJJp5s+s/K6bg2TMxvQ
         seMG/nyXzXgXjKlgsQW0HGMLrt1W13zVSzmmZnm/Y6KIyMJReQxWaaZqNherqi19dzcd
         mSnYld8Ay0Uy4X6Wbnt6fQvwADkLy5nBRg1Xzr8i6PSnB3/VfLvttY+2+6YXkmo1Q5vy
         97CqHw7rACXnMmHinAlFteZatYUVhKF7Uj4UfGo5RtWAlWaf997SX11mpv7ahctuMayD
         2/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWxZJ/h6K/AwrirS32jhy9MK3S+/2fl0CyoKwQc2ipZxIydI0l+JBcu/aAmQQ8+KlS86Fy3AHLbEKdk/mdlxgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqqAYLzKvb595Te8av7P8Epk+bAx6hspQdIPNtquIyBK2mJ6M
	jCpZ0FWcZo0xjEZjo9GfLPWaV2WZV7axq3VQE3+NkxojmeUmtWOqPbHbOYlAcYMBCJ5fKX3yCzg
	PKcwONAre895EgkUL+dgrOig39jCAIh4=
X-Gm-Gg: ASbGncvdTpnl4pM2oXsofaHMgOE9CWGiHcnhkpjZ46Mzsrj3kE9GIeQJx1NkBrhMjux
	y8ymhf5qcalA9qTs+WidjHwGPUSBa0IWL70qv1XGkPwXo3VGfZYXOG+HjoW1p/a8Lqq5iOuPAPQ
	KHtIXu5pT0pqFQ+jbhyFWY9ZtJSBevrkY3H6b3VoafOxnzsxpN2Rd2nCrSARTA40enTar+IrCbY
	Y6aZN5OXJm7SVno/7v1kM6P1KQtqGj32apR/9zOR/C10qe2BpQjNw71VCSplCsHFXSgwYmAllke
	/8z0rexV1y26HrnOTbc6cq7UcZIOacDNzZyJS3lu70AJGzgLEAGVYnPuwIepjly+PRlxBvESAC/
	bjf/Nw/bZM2mnsA==
X-Google-Smtp-Source: AGHT+IExnxjKRMhBvCvd9Nw1Vzpg0dilgRX0ilaQeygPAtmrJ/VO92XIw2N3ZJ7sb6hS/zOwLVLxlgfmv0VAGSAIzy8=
X-Received: by 2002:a17:903:230f:b0:295:70b1:edd6 with SMTP id
 d9443c01a7336-297e5643e76mr52737955ad.3.1762776260815; Mon, 10 Nov 2025
 04:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org> <aRHSLChi5HYXW4-9@google.com>
In-Reply-To: <aRHSLChi5HYXW4-9@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 13:04:08 +0100
X-Gm-Features: AWmQ_bklNKkIpzDaIt0BmvJnv6iHBReLEFoejSD6lCAMShx-lppQSbZzdpW8AeA
Message-ID: <CANiq72n29SUnmm3Dos_NvWbxW-vuX2Y2j7AAYROpa6ruQWguSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:53=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Maybe we should also allow disallowed_names in doc tests?

Not sure -- I thought it may point people to try to come up with
better names in examples. On the other hand, for abstract facilities,
it is true that there may not be good names anyway.

Cheers,
Miguel

