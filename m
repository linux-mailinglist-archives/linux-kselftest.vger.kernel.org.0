Return-Path: <linux-kselftest+bounces-29276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72519A65D8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF6D7A8590
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD61C84BD;
	Mon, 17 Mar 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gaeo3FSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913764A06;
	Mon, 17 Mar 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238386; cv=none; b=qa/YqbWLEmZ029WhrM2nShUziH4o8p1b8/c0OkAqXC3V1EK3lazy+KDX20UDN1ol5pWncU+lnu4johzMBlMDrb8zZQI4VGIF0MP2zGNSyZ6WGRvgWK96zX/sXO4ZCL6EuNd+SqGUaTvNrzzyrPp13wGY6ZS4j3fT2iNYdOFT3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238386; c=relaxed/simple;
	bh=+adJ2RDSCVAt8tW3jb2Z3h6jaxLjs2I93CEPuEM8pyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvXOf49MXE9+CI7qQ3Tx0MVDOiZAWq/fCtrLkGfSTZutO3FDNgoBf4JEpRohJjYuqbtOe8hHYoWCIbxwtVji0483i8H1rlfXOaSEDxhEHbeRkgD1gw1XSX1TfsKjHlpmu9JSgC1qpwLCzJAjBO4jaQOEhvxxnF7aRlswdwrVIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gaeo3FSo; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bd21f887aso41500421fa.1;
        Mon, 17 Mar 2025 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742238383; x=1742843183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+adJ2RDSCVAt8tW3jb2Z3h6jaxLjs2I93CEPuEM8pyI=;
        b=Gaeo3FSothIh9RMz3aJU2IK/sGUFX1pGbHZaVLxy3e6QX7fwfsgPr6YTzegMIh+11a
         ZU9MqCBG+zd0xMKrv5uCuewTJq2RdwMnAzLf+KPcANtrteXmcfxoy4R04OEJ+tdrkCCD
         AWox8E5Gz0X5QhWr9Fz8sFONbiNTGWhnyiUpY+ucJdK8QV3IRECKD6hyZ0ajyzrXCGry
         fx9B1p1z2P/gW83G0ElunCRwWbqGkuRArYbIVBPmFgMRIgk6KqSuA9ILEuR6+lxI5mQV
         H8o7X7ZS3SwcuKsYBQqASuiNl4nK20M7NNAcsR8ZZAwU2ONn67MxXvfwebVPE6GUXAKW
         y3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742238383; x=1742843183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+adJ2RDSCVAt8tW3jb2Z3h6jaxLjs2I93CEPuEM8pyI=;
        b=UfyFyqwSfCWGTXykkYNfUdvsY0YTw9cD+Yo0Vy+TrICviXGunmi7KT18wScxpie6Lw
         ngB/6F70XXq2+ENZt3zfEPWPbhmr92V5OQFkEEIkOyCXnIrKmyaOVXKUj3pz8MlKiVkm
         J1aFW3rz8huK1HyRa4ua63q5J9StYQiktkJ3mDCwKsyFH84+5jmCh24kAmBXTcC1uYIC
         slZBkF5vR/Hk9Sg8KH9BMapkGGktzZMzatN4oViyuToaqmuAB9NP3j7knjPsexJwifzb
         uyNAAggDwRCLeZVLYLMo2m5pynHvjrIXIIWruFzlcE9czrOG7BOeprEXLxH76VLYye9L
         A21A==
X-Forwarded-Encrypted: i=1; AJvYcCU5yO2r1NboC4NsZPlD6G0iyz2LLAyLNQ01qQI/wUx/Iyepqr7vAdCiJll8VsLaW6ZIOMb6vg4Mfx5Bcnh7lUAN@vger.kernel.org, AJvYcCV+3z3clB1rUJsF/chHvXcxivH1UnaJFJpriKkSetIuaUcnV0nijThHTQbY5mAj6QV5opZmt8JqYYy3ygE=@vger.kernel.org, AJvYcCVH64TigHZutf2uD66rMhIX3F1Ycg7syezo3oDeufWzb3Jv6lXWsQWz3+qYz+QWMyK0EEFnbNk1spuQfokH+ig=@vger.kernel.org, AJvYcCVn+bDAkBkg4+tSrqTbb/tb5fRodgaM8tfI/sgaqk6BmlAF8RXFreW8O9HhCVx5+N80APxLnGFD4/Id@vger.kernel.org, AJvYcCWUuAuVTlAqxs+6Bg4qbYKLDURFsBiDGgI2cbdMp+3C9DtMuodC7dpvdYRYagv7SvBH9XqM7lvwKuld@vger.kernel.org, AJvYcCWYZUmdQT83O8lyE3CYRqLTBZFNQXCjAtWo8yLeuZHasBmyWh75lxOJLS6qdCb9JSXklxlnLimwIlau0FbG@vger.kernel.org, AJvYcCXNrToOJ7JCcKkHTKW3oBShbPGhNUHME6lKt9elj8rjDVCfLOZmlzC1cDxLr6G5XGKlLGUnGQcedjSxmmgr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25zypjZkR7mNzbNu/FhaiQ5KzRxufRHO9H3E6r9KvbnbwJsir
	/ordjS1ZyuuhCsntmwYlSjWk/oOJdACoJbmIRuoyItSPsn1+DDnXwCjxrL3qxAPfm2n/RICO/nK
	ERu6+j6JvqttZUvBuM+vI2SPPSmn5iyMUig3nAA==
X-Gm-Gg: ASbGnctwhUhW7mOR2lAqTWJNIOcIJ8jRCaLX6y53p4dR9FwRjIX7KBenPeWPv42dHmh
	wHolUen6oqIehn+VMXSXA0vWV6WIbm797XNxVcWIL6LAThXf+Di5gRwCqvj1n6n2swOY+j/VWCV
	lP5A4fuhUS8++YaWZ95wuQP4HHIMd8OF+nrCOooCIzr9Kck67gJkCWb88+AMaCZBYLD69J2A==
X-Google-Smtp-Source: AGHT+IGn5Dd+UV7N7H2pfuIx7bJmRMxrm9tkNYTKUfpfQ/tyXsSm7Z0z2BOQtzX5luQ7Hh9kBuMZ/7OV/z/yCKW++R0=
X-Received: by 2002:a2e:a454:0:b0:308:fbd5:9d2d with SMTP id
 38308e7fff4ca-30c4a8f5001mr78224611fa.37.1742238382431; Mon, 17 Mar 2025
 12:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
In-Reply-To: <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 15:05:45 -0400
X-Gm-Features: AQ5f1JpyV0nQ-kkW4seOxWZTQc72pJ-QFCu1PCOmxq2F2HqkOl8_kTN98OF3Mjg
Message-ID: <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:50=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 17, 2025 at 2:17=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > Then we should fix clippy or how we set msrv rather adding the stub.
> > @Miguel?
>
> I filed https://github.com/rust-lang/rust-clippy/issues/14425.

I don't think we can wait for that to be fixed, though. Usually clippy
is distributed with rustc via rustup, so even if this is eventually
fixed, all versions between 1.84.0 and the fix will need this
workaround until MSRV is >=3D 1.84.0.

