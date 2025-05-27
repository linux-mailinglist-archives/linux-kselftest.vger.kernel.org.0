Return-Path: <linux-kselftest+bounces-33856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FBAC503A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961E33A6505
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB02750EC;
	Tue, 27 May 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsA3NYur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435D274FD9;
	Tue, 27 May 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353897; cv=none; b=ClguTCSov6jEzU6h8L0UcndsEegDRBE2HYBUiKLuyn+r/KlIVcECAxfxjCEckZOEcQzqxO8rKVk3V0HrMCOTe6WG21ITIupv96wO6c1vOxjfcO/m/NpnVN20QpIle1wiscuIV0iJqSMTkmYMlIjlEgvIUvNa+mzi7bwf4xMb6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353897; c=relaxed/simple;
	bh=7F1ee+yy/Njni7Dw2zSyIXqtdK6yXJhzoen+bfGcQ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezqWbBTNPUmuOTgOUNZMPjpNWqbISrWk3PYMwOF7+uUjDX+Lm7DoEqohUB4IXBnzSEUus1uYWC3e+sZQ8dWv96eRWAoJ8sogzwxEa0dbXNgNdJ796jaX8skH5ys260eI+WPaefzDnqqrWSLwGqn608Sw/UoVlEb/BnG0x4KeuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsA3NYur; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b26ed340399so355760a12.2;
        Tue, 27 May 2025 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748353895; x=1748958695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F1ee+yy/Njni7Dw2zSyIXqtdK6yXJhzoen+bfGcQ68=;
        b=PsA3NYur8KJIrZv559PYgIeX2mhFNpgo7c3xZTqtCsr+bjIjuNQACrPMOzgjTAldaJ
         0jC2+Vv5y1AKDxlAXt3K4HpYOgaXOGqIt/kJRYsEl7xKRak4i/dnFkMc5Mo/AbGMsxhs
         KjGINLQAsYlm3mHxVrGG4JYfKyC0xOGd0Os6ARUvzZgTAP/G5xldz7TUikzrbHLDyONR
         yvGFUm2H6LosBk2mXhRhDeuy6hpgTE6zR2ZBgZXYp6cNXDPYRh9WES/+Ggk8LHQbeyMu
         N7y0DFUULJTLxR/+UhKdTFRHKw6cTNCZE+KIBlplBjMgOWDSyd7nkBiBrbwtXIeam8cB
         TqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353895; x=1748958695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F1ee+yy/Njni7Dw2zSyIXqtdK6yXJhzoen+bfGcQ68=;
        b=g9E+hg+c+ho8G9LDYFqWtu8mAkyzyT40OvPBEwfF3wKdprALe9GVd49/jdtMQpeFVM
         oBxES3+IHpYpyFyKvEvEeuQWSi+t3nLduXhQCXjAgrT/VgKMSiiw2GkgAy6qpKyxd2tX
         EEaZSOZM9E4MdYRaUFQUJn4mWvdEYJIrY4EOQzFP++xIJtmFFWobf6MchqKfi+Mh9RKz
         b42VOlmk/pGrbxAHuM7uhgolw5Xy5MxNr/ghyrsEI1P3fxPaPrRKfeKInlxvSAffPOBJ
         ullMfzwxZe6PEUb7iqtqftBoFukLR9U0IrIt3H6uy7k2CbPcuQ8FzmOTzc3UlA0DkW9o
         SO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVET4+Pn34GeonO/HRDWVZBLtK3SYS3Dh8V1UhU9HfG2P6LRk3jLwtySkt7u6ORH1MWSXtFLI0fxLwniz40CP8=@vger.kernel.org, AJvYcCX5S/zamVEwk2HWT7LA6y5eL4Blug/dSVl8CO87yEqRFY06BP47rjEudqyp6kzVF4eLxmuHypEM3V1FVG6Xt2tO@vger.kernel.org, AJvYcCXvJSVQteSAwXD51Ws+o7oy06553DXV6ylxMOFgjrng8vTg1khY8DynMi3SnKHyNxlbAQ/FzHU4NhUmAiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIG6ctxoTfq5yZT7qvUQqAlt9s7yXkChPzpbcLyKmu6PN7VNH
	l/yTxkpLMWB1r5eF/4nKZ2Mf50Pz1ahaHnOxTDmUn1o/l9SJ+ItUftdAMZnxUikmgeaTPzdiNOY
	OTbdSgd621mq/qTnTBZrRf88t//41I+k=
X-Gm-Gg: ASbGncumfSFYQv6I67olSQvYpwZNhOba0lVC4WgbA25WLrThIkSKFr9RUSi7zZnI8Uw
	VsuNjCJZ87EXtAotrCQaud5v5YcNK1jPpO2S+2ztK3ZibXUPdwo1SZcXgW6kb2GmMv8ceeUeayH
	xepNgVNSUHCXiUTE10XBPueZo+Oe7AnwDBY3hOIgyBCNM=
X-Google-Smtp-Source: AGHT+IEtIQ1z32zAY2NEFKsK2DZNLLbwjhnGL64WMVavBityRy9+1/bAxBjuVOOV9i2JKI6LmOxTYNC0DZF59fX+M1Y=
X-Received: by 2002:a17:90b:17cb:b0:305:5f20:b28c with SMTP id
 98e67ed59e1d1-3110f33ecacmr7596771a91.5.1748353895332; Tue, 27 May 2025
 06:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162429.1114862-1-y.j3ms.n@gmail.com> <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
In-Reply-To: <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 15:51:22 +0200
X-Gm-Features: AX0GCFsfs3QdZvA4icfA5wPLKbrCfW_02pE3_eM6-6sXiZ7RxS8FT94BATqtVvY
Message-ID: <CANiq72=ue5Fw+7TPPpRcK+0Zk4KTRhH+5YnAY8BQQVX_4YUWqA@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: use crate-level mapping for `c_void`
To: Benno Lossin <lossin@kernel.org>
Cc: Jesung Yang <y.j3ms.n@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:06=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> We don't need to explicitly import it, as `c_void` is present in the
> prelude since 3d5bef5d47c3 ("rust: add C FFI types to the prelude").

Hmm... But the prelude isn't there yet in this patch, no? i.e. our
prelude is (so far) not a "real prelude" that gets injected
automatically. So I guess you mean importing the prelude instead.

(It is imported in the KUnit series anyway, so it will llikely be
there either way)

Thanks!

Cheers,
Miguel

