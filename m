Return-Path: <linux-kselftest+bounces-28782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A2A5D110
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 21:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C3A17C019
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316D26461F;
	Tue, 11 Mar 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0bUizCs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E62620F9;
	Tue, 11 Mar 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726211; cv=none; b=eyj2WYMi/PDrLSm56oZTm+L1Q39OCvBH1d9rTgnrhPaDrLpiSQf0vNMn+n+FHLFlMyWJ37YWSjtPA6ZYIK2D20XIa051L9xFdMfwP9QEceriLwdAne4ELWt1IR2vdLq3C78XNAZkISgA0xZO7MKSF2SkveivLlOcHFHzsNyTGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726211; c=relaxed/simple;
	bh=JWdKg5zoGBpY28zuxaqBxi6+dP6Re/Qr912PEvIfcXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz6oqNvGCl1MjOKIV73SgOocjmmFLCFeIe0TwjcoQckpXDd4cmNI3wRbUuX2pH5GeVXr9GEjYk8Y16qmNEfB+UcA606ML3/C+mWlz8WqdCNdtbktyriYi7VYhSBGC0j2hz7I0BwAGDzCQxckxesvgzzT9DbyfF9SIWcTelHEnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0bUizCs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2217875d103so13012575ad.3;
        Tue, 11 Mar 2025 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741726210; x=1742331010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWdKg5zoGBpY28zuxaqBxi6+dP6Re/Qr912PEvIfcXY=;
        b=H0bUizCs18oHpEp1Olr4prlrkbDaq9aHcupuydxe/XcmmoEqf/S51BUDftog0YS1Yo
         WLKJTS59n8OBbOrc8WW9S2NDLC12pGy1CxdxNjQFfyUijbG6ovPX2iS/mF97131RfOxB
         P6VbtbptFVTL/AQ1HYt8YJowL0bK+9XRl1khkERW1Db/Tv/k0qRBr1lIDqM6JRltiHrz
         0oESvkYcC4vC010JQbEMfokEhQIwN5pkWareD4MXi0IdTHe9nLVdB6XwUZcnOurgqtk/
         k4jXLIBwSvWramERRs359LKOLq8N2vKFQZq4/1RQ2H82ATxZmFJYTZ93kFjse+75w9Eh
         Bw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741726210; x=1742331010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWdKg5zoGBpY28zuxaqBxi6+dP6Re/Qr912PEvIfcXY=;
        b=YAdisoZAtERcCK40SWjzkcj3NwhItKnFKWKQ4Rwr2fyduu6JOzdwaZ18a4sPIBM7yX
         JuUqpxjqZbmATkHgxBfPYbGZL5nhT8H7u2qkB3oosa1nF2MAQbjQJFR1c4eykaEcKhVU
         UGr9n7ytf8O/ThK1lqJwwkrFdJjiVUMD6N+sHH4Ao7PDq7rq1/d4NxMmteqekH2gzb09
         5JkfnaLv5+1vofBlSDm/YF1/QJ9kYpjcX+raJ3tdNFWp72yabSt+ve+NzhcWFHpiGnLe
         baPtgcgSe4XXASfYzg8mWpIrK3aMeZOuI2y6GIYYOiah1sifCzTCw37yKkrtMeP3nkfx
         OM8g==
X-Forwarded-Encrypted: i=1; AJvYcCUrv0uUrrDp0Glw68FdgRMfKgLliruCkXqF0ejoxn8i6eBXfW3iximsNAk2JIOsTU6l7C2HvCUwe8aQFjG4LSE=@vger.kernel.org, AJvYcCV1HZZXulFP4keccihcjnABTsSCvdSxdi7Fw2Iru0bwbqiRybYTUKL5OpxA7R9HI0wY0MYxjahnZUv+@vger.kernel.org, AJvYcCV9Q9mSF+IzhDPsOs3r0Qur/nPDR2fJRxMZxcggk1EjGoeGAHH/6mNczdFEwdkgPnpfumyslnTlzzeAAWFxg6zs@vger.kernel.org, AJvYcCVYklpJrhGblkPoYBz+WGBpKVCAPcTU96Vqf78HCdQILVJLZla/ipohoLQcV7COsxB3vbAAGkJ25HAk9UM=@vger.kernel.org, AJvYcCXS7f4TpD+ooRIdlev30yVPIkPE3hovYNJq4VtbaDCt+R+jpF4h3KnYuwmaNHADRE9R7viTtwhEhrELm/OI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7N1PhtBaaLP44nYGJfMDP1V23IJM/zjDMO0Pw8N/PnvnKmBWg
	XPKX0rpSSirvthB64mb2UB8MvWSTPkSqPp2qCld5qD3W08ethEwUE+GemZdYcgqaB05Lic6IK2I
	ADcaXBhgt1WHNIsQkisONoi09IH3Cltc3fLq7hA==
X-Gm-Gg: ASbGncs29ePX9eiq5F9mOtVI4H800FNQdmwsHewfkA9D1FuqXWHesmt5BHY2WHOYoio
	OeFxg4MAaoEkq+dsFUDVoRAV/JKGxNUyRbVC54Nn8I+Bh8mNFtHqgSsRahYbERz9sR9qorBWMOz
	vmq+gwcyQZh3eqOSmuOSq0NWmziw==
X-Google-Smtp-Source: AGHT+IF6Iu5cJXNrmMcH037VEuQgEw5FQiSeS4rw7qJG+vfgUlX6Z+xe0TEh54YrTrzNEmVy1nOOetWOtZm26Z9qTGA=
X-Received: by 2002:a17:902:c952:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-22593302b09mr26173505ad.12.1741726209805; Tue, 11 Mar 2025
 13:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
 <202503120332.YTCpFEvv-lkp@intel.com> <CAJ-ks9mkbs9KG5D5yETvOJfeqyzTts1gVZyNAogbxjXbwOreZg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mkbs9KG5D5yETvOJfeqyzTts1gVZyNAogbxjXbwOreZg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 21:49:56 +0100
X-Gm-Features: AQ5f1JpxGxSGer3XisukrOBay0DQPLazUdlb5Q5D9ZecG6Ve_YwoPvaVLT-TLE8
Message-ID: <CANiq72n2cYvAWkz+QwG9++NknaN-A2g=N4AeatADwRZ1pWtk0A@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:44=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> By the way, it would be great if the email also included the rustc versio=
n used.

Yeah, I think I may have mentioned it at some point... For the moment,
one can look for it manually in the linked config (i.e.
`CONFIG_RUSTC_VERSION_TEXT`).

Cheers,
Miguel

