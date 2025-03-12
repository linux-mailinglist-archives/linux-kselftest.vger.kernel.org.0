Return-Path: <linux-kselftest+bounces-28825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C6A5E104
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FC4189F19F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6F2566CE;
	Wed, 12 Mar 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeWcKroP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113AF24E4B1;
	Wed, 12 Mar 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794577; cv=none; b=OJeN46Cr2apmp/1vmcbSSKo63anCeCc0/h07t7FGyb5/lZO9qoaulsAnXK1EoiDmsrotQGiFNbxMkrkofeB0e4VeGCwbPNZHB6qVbSB/jqhyg8I2BabYjr+rZ19m4MhdMeA4H5nQNd1qAJArW1tXwlxj6IDnp7r7og/OY7xEDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794577; c=relaxed/simple;
	bh=qO0bVVRsexfHs9ID5KYNSlTNf4wVGRYGPnAWO1TSDys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyKBtjd7sD9tyMiV7wO/p9q1Zas3I3bptBLoMcJqYCatbhVpEaZRFkSxhxIzKDE1UNBG1ZIDR89BLU15iElyu6NJfpNH4WMdlsG2iMvpLdD19F0ExeZ2YL9cy+FoFjjUJsI8sBZGONKzxTK7BnciWKaxIWhIG2S5VvIMFBPDMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeWcKroP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so5725a91.2;
        Wed, 12 Mar 2025 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741794575; x=1742399375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO0bVVRsexfHs9ID5KYNSlTNf4wVGRYGPnAWO1TSDys=;
        b=JeWcKroPHXglf+UM/h+h0Z+lQtJM5P+my4Ic4T0EPCy66ZNF+xzroJaUTRXiX+yrgf
         XIYmL+hvmGLmHRwFvIvYX+is9CUefGs6hDKM8VulUfVzzRAlrHuyooRsGYP5CR8QCEbg
         Oh7bWnKCHYu1filfWg+w20HhrmgNyF9uswrIURv8Skb7GAmKK8Iy7U3u1yKMJq+FQQRt
         ZnaC/7H3sQWe5lwhVX4oUt5ZenTQJ0mfkon271Xs4QMCKUruhYC2T8Nx8JR5Wt/WD5mX
         JQV0zuwAezDDBzsu171lV5GfWmESVmgbb6RRRuDGymBTOKh38gDknyup0S6yh8J7nmz4
         xUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794575; x=1742399375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO0bVVRsexfHs9ID5KYNSlTNf4wVGRYGPnAWO1TSDys=;
        b=HqdOUWxHfE/rr5iTAy8IPNHuVMsQQKdDW3Pjus9/9feqr46fQvOPoa+LIE2au5UpLg
         3hR/usyhwaBTSrvt/NcCQF787U1rb9+QQzISg6eTSiCYTJe6lT+Bmo0HtEKFTosHjnzF
         gXz3DEns4/8G2iGbHwERVlYZ/sfsPZpuESTeSaZWSVtwDOQgN8GjSFtnOuaUCK0yp22M
         ZtR1G3Nb/2bYr0kbvU97hvTlz93hjd++ViX+UIcUl7YBPI+TZOxFJI49ukBIFnInFTg9
         JCsYvIKtqeMnhm8Obzrw3hgXIuVOa5F8qAyA6wwJXoYg88i51YPmbkUilWsVaPaJ96Dv
         eThQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy/9I3t7wJg79ytUxdJyiLEbOusWnWPAlbszwvZ3Sc/IyyPczkY40qEHq094qOK7IS1KX9Q/BvRqmy8mFJrM8=@vger.kernel.org, AJvYcCV+NBioyLzMl/dFfFhElZsElULntOY4JeEnxpzyvre1SlpOThZydpa5btbqNjQXzO7e0AaC22MlwX/vsA2n@vger.kernel.org, AJvYcCWUlEGqN8CcB9KE/GQPE8OL4h8jSaFnKpE5Z4FFuTSuTAUohr3RvbKA0lXphxkJsZRl8j1fZATOWSVY/7g=@vger.kernel.org, AJvYcCWdYjiKwr3P+8XxQ7YYG+JHZg91wQ4W7fV9gzf151YAHVQI05/Ck06wazMRAc6+dTizRKBVVB2ZmFigY0BlwrMj@vger.kernel.org, AJvYcCWouRPfAKiAdybrccFcoMErIFPwg1o/19loh9AFdrM38eZW6j850jvM/dd1w0Y+WcPPL+cSABqdDykVChnx@vger.kernel.org, AJvYcCXdk00UcqKekk+pbIa9i+LHYwh+JL7E5BPsF8l945OAQL1R467Z8707nvCrQi48ag/91AgcfyzgD4jN@vger.kernel.org, AJvYcCXkGLO7djdWInS9sDiXJ5Z1IG8pODrFiAY7Fvw9UyCCIyQWHfnnmy9mvzbXpjPaBH/mrfMmOZDFv5jy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mDgg6mmKPHXnJ5nycVyqlP9MEmojPNlQ7dVvRWWDAIS+o6dU
	suRUehLTQjkj76b52S+4A9M/Tsu9zj+OGKVBae5lk5wQkCh7pkvLJenp3ONVu+to1XsbDALTjjI
	npXeoS0xjvkzIqLzFggbNGCvkT2I=
X-Gm-Gg: ASbGncsqP43kWkEQyOIAMbi+hlFDAvob19qPBXCe2qB7iS9P0fYWB8M/O1Hcd8k/B7G
	OOdM+iVvBN/z4406bay3MpkZN1gcvevgI9IN/XVxZoUrtEJnPdwk8mkQVoGbtbgIZSv6+GkWBYY
	+19BTwTw9d2eb9cNXt+musn2DebA==
X-Google-Smtp-Source: AGHT+IFe+OpuO99XWupXs4of2kQ2UK3ZQjUDx1ynodylSC86EHTfBlh7n2S/1c35NKi3CjXlMbYTtDOXmh3xmNx65n8=
X-Received: by 2002:a17:90b:3ec8:b0:2ff:6bcf:540a with SMTP id
 98e67ed59e1d1-300a578d62cmr9754852a91.6.1741794575223; Wed, 12 Mar 2025
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
In-Reply-To: <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 16:49:22 +0100
X-Gm-Features: AQ5f1JpDZ3MfaqLw9tP1SvKaWd4DrWDIczoaJSjDTCrETi3uYKBvX_O58mzb7EY
Message-ID: <CANiq72kH0AUxeMPE5qcUiMQiCCTGZvORCtnm6CA1mgksze_s8A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:36=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Yeah, we don't have strict provenance APIs (and we can't introduce
> them without compiler tooling or bumping MSRV). I'm not sure if we are

The strict provenance APIs were added a long time ago (1.61) -- in
fact we briefly discussed doing so back then (we started before that,
with 1.58).

So unless we need some detail that changed recently (i.e. since 1.78),
we should be able to use them, and it should be fairly safe since they
are stable now (1.84).

Cheers,
Miguel

