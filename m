Return-Path: <linux-kselftest+bounces-45803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3AC66450
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 24ECC242A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A08325715;
	Mon, 17 Nov 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQS3Y9RZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21B3128A6
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414834; cv=none; b=kDbNz1gXLTDlyN8kVf1sacBCGCG/v0JG83hoDQOqUTFvbMdQ5zqv18X/qbQUCuViVpXxnfk7BrcTNGNikkqnqLj2vPT11gsalXJJ4ZJUrP1LzgtjB3glJkc/ec8F4G8pHoZ71oa/+xjVF6AXHwSHKh3ZT3lhiStCT3VfaSNg/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414834; c=relaxed/simple;
	bh=7fPlXJYjsSilCDIe8k2o+rTnQyrHViW9qFIFSlnjorI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/5CqWScnkL5hSjjbepfFq1yw+F1/10RIVbxql9YNtI/XceYUvU+lF/kILsXeYheWmZsyidbRjg6bm2/aKXz/V3YBmDxp/CfT5uacbo4DLUPq3qHAD8PtZd3TCeoQGtUzMv7pov1Tbs9WRoWE1EBIZ7uQuAm5G65ZxDMS56beAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQS3Y9RZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e2736308so4239015ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763414830; x=1764019630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fPlXJYjsSilCDIe8k2o+rTnQyrHViW9qFIFSlnjorI=;
        b=LQS3Y9RZG6vRiN4TSPJO1Pf+HHj4fKZqYHf4csvQ1r+RV2o7gLBARifRaYQZWjGijF
         NU7uIMrh/rLf70kQ/w8lAEFOkd3uG/VB77wmglmB1Vlp4Md67Dv/NJBjxGfUVowqbkTF
         rpHpOf8iB6pER7+HloF6oQdAn9OU0rZNGO3s2SaOD+8CS0Bm/ZmazJ5ELDNZGdYdMRkq
         M+3+Yyqt4UUXqnyFeXq3XBu9Dprt/1Qn80RR6zS1FpvzNDS/KF5VmwZeZ8Fn9Bdh9r/C
         vSLV1GIEAo28tg/bDjb/b9CtDeBe4V0tmm65eFYmrOPQyqhI8GoU0nphLHctyDe4BEZT
         2+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763414830; x=1764019630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fPlXJYjsSilCDIe8k2o+rTnQyrHViW9qFIFSlnjorI=;
        b=dWfVIq5G4pWIn8FTp9iI7Dw2XJBr04DrtA9YkZIYi88TewFVwlh3Lk5tLBFJ78EHoD
         1QZ4SxXHNbRGYxgk1TPC2j1PMj8sVY5y3BgTi9bi9t/R5PJwlB82xyV5ljKroN4IDUuv
         7otGgBXmY8xvl5DJen7Q4ijA4yzIKr6QgNWyTgKfDqkVIneo4Ry/HkAXDmGrIrJINsXw
         sKbefUvaA3sHSninzoO/nVQRv/8j8L+RAAHKQ3fR92JMsh+ZBZmZDqwlPB8K3Q+gXGoa
         w3RtBSFPagR46xJGvu0vr7urAOEZLDQPUHGbzvHtSXUcR57iGzGu5c6gicXxcmatQsGx
         cNOg==
X-Forwarded-Encrypted: i=1; AJvYcCW9QzxZdl1iCpBOve4awAQfKF1TxDsqiGobfeKh27BNXq36nNwJn8GrQLIgd/tnJs/T43BYIXMKwafntChhCOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqXDCJXAS+iYfsqDrpeY5a4etlOu8Mk2gUBKQ6szrWn5x1HR0
	jWwHp0MX0wTxf5N/0ueZnzmiFAay3E39NEhhHOQ/m8S6OfTL/0IeRXTxxYcmLyek+/x/VvdMjUz
	/53eHujForm07YgnU7N1BnKg2K1qoQL0=
X-Gm-Gg: ASbGnctCLhGe3pniPeREThV8m/8M83di6ozbEMlIct2QCpoHngHfUkzKnKMZSMme/vU
	N1eyZ0QvYYMzs18TqCddAhKHJvFCACmCgd79zOlIhwEKmdSncC9vwpbTWuqbHi0Pff2B2RuShEn
	NQY9v3OBsTGe3AHlLUPFYl9GmoQVjhPomKj/j2jpYB1uXCcYYaQwaODr1aBXRiYo2faB/K2Xg5C
	zXIJGOlAaEl6oE9YME5/LedADHOJRJ7iiUz5R3xb9FZaDbtiCFz1swxj8NnGG1HrId8kVa9Oupq
	o0h8ETywkfIW2yworOyC3SjGFUnf62AfCudnfLSZcH67pGNnbRkS4BoSvE2Sw/2eWsbYfPZdTSR
	Ce+zOqFBvaLSdiQ==
X-Google-Smtp-Source: AGHT+IEdsu/Qgk454YfNKkEm3dxgZd63f+Euy5hTycBzZybjRHcCjF7RFqpoUEYdE2tEOHrEkK6aqX8cPhz5W4io1bA=
X-Received: by 2002:a05:7300:d0a7:b0:2a4:3593:5fc7 with SMTP id
 5a478bee46e88-2a4ab8a954cmr4688445eec.1.1763414830128; Mon, 17 Nov 2025
 13:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117080714.876978-1-ojeda@kernel.org> <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
 <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
In-Reply-To: <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 22:26:57 +0100
X-Gm-Features: AWmQ_bmCoQhe0tDaYS23xSdPDegbNWBwAWpbPsNqHFk8KCfWm6zlxE8mP2aCibo
Message-ID: <CANiq72mXN3U-oZDMfkCNTNLtvReZjROdgNmUDQ0H=kDP5FbopQ@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:13=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> The current set of disallowed names is inherited from clippy's defaults [=
1],
> which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
> which so far has no entries for disallowed names.

As for this paragraph, I am confused why we would want to add it.

This isn't about extending the disallowed names or about how the lint
works in general. It is just about disabling the lint entirely for
doctests.

So adding that paragraph would make it the commit more confusing.

Cheers,
Miguel

