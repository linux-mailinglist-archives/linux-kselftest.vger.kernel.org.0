Return-Path: <linux-kselftest+bounces-29233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43FA65506
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794FB173D61
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C724502E;
	Mon, 17 Mar 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5SBu4VV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBC21C194;
	Mon, 17 Mar 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223888; cv=none; b=lpj3mg+1W+xbYBaMRo6V4y3HpvLMPAsEfT6yRIHvIMqEK5KcXZNeXtmZRZCI2Zuk0boKUhc9Ro8zXZv6SAP+gt31YkRKZssh7LL0OnDZc2D8W30kdu5RnKIhvWshr5znqFnXajUHqXQ798mlFbqhhsrFxZD0cmkrxrJCsQ5dq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223888; c=relaxed/simple;
	bh=dvV/UXPx7k0Bp/O7ZeVMaIo8X4bYnnZqpVVHk2iNOnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQ5RMM+IG94XjFHAB8hAnilEy8pr2ouT7sP5xbFHpSLv8b1ubOS9A/f2VR1yLz9/sg/PWcwOTqACeUOmDNEh97yOd+RueZ1552ahluhMfXBRec3raKkP4l7uHK33oOl6v1PU8GctW7inM1yZr3d/xyW6C2sifD6/GE3X4jfN9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5SBu4VV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso46135381fa.1;
        Mon, 17 Mar 2025 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742223885; x=1742828685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvV/UXPx7k0Bp/O7ZeVMaIo8X4bYnnZqpVVHk2iNOnE=;
        b=m5SBu4VVZ2Ql144SXytUUn4IL7O40pAFOxKSl6AfxxbLcS9JEN33VCWh7aHDng7bAQ
         vXQJGMbcgrWyDbmCcn2tqKCT/aP9d4XSQp3It7Wj3c60oceAiVVoLZdpA+6lkEWhXJU9
         DeecI5GVkZ9OtJzbZ8BIsToJ8iZKLnPNM2C1GZ7GZALHpkTg0j//7Sg1BqCXA/2SvcEA
         1P9MIZaQGwA+/SdzdpDX+83K7Csm8LSSamhEdDfCb758h1TOJuMfmsei+ulVYskzB0gQ
         z8CBPSSelGPpkSuaw6G2HrvdT4AlMbcuPgn/1n7yOg8o3MFqHdv+5LN7w18zWGtWm+2n
         pePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223885; x=1742828685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvV/UXPx7k0Bp/O7ZeVMaIo8X4bYnnZqpVVHk2iNOnE=;
        b=ko3GRZCw4KD6gHyDQaui110NLJAb40oZmu8aHpEKqA33dbOH9m58qSZ8Er8vSXMl2l
         8VHK2LMM6+vb0geDQ9NYI8OigbOUY/1VFdDDTd665u7UIddlb5H0lHxKkTzq8fLMQDY8
         CgFCtD0xpU/D3QLkEA7+qnj1tzUG4ICwqrSrN577iJCsVGs2R4U6W606duO37AYecFXY
         MDzOvMii4YB/VfETMam/kEKKxMZX96zQehRXii9AZVSfkOs/Ck2GQ24MyqCBtdUBN4gN
         3XWOa8Kbv2xvmfBiNr5DVB2x1L6o7ufrnDO32yYdE2f+25UfFcGKX/2eTXadmjSPcTIg
         rA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSVtn3NqBFxfUmGV2my4VNB4AdF1DHBUugpfTOOK9iln1ZVv+L6BrFXF8a4CA6RGverwCs9ekEpPVE/UbY@vger.kernel.org, AJvYcCV58RnKiTEZJbTEJsXbu+2LU7CmX12WvHXr0RhgTZF1dcnOY75E1bHKzOZ7h602sP2z4j/pJifS6Sq3@vger.kernel.org, AJvYcCWQ7GX4uw7aB+45TFlfpgUmewY8HZRuVqk9cecTY71GzoR6WETvmKGatC95GhJOFg/oEDq8uMc2aglPuOg=@vger.kernel.org, AJvYcCWbAXW7ejgXc4Li2eyVj65jm/xa/t+Tkqy1Vq4bpNHCybVdAO3k8DmSLwcV56sq7N/aVejE8NKJAewoKBRBF2Zz@vger.kernel.org, AJvYcCWuB2McuGhZZYkq3vxnK+X3FJUdHnxMzMQ9F1Y2Ut/QdFHe2qQ+veilsoXK4jzK2q4lEva8UHf8Bga7bSkf6kA=@vger.kernel.org, AJvYcCXo/E2rQ2ZbkP10GFXoDmPF/1Ega2kZESylpm5UeM0SLaYe0lYqggEuTAkVIXfsq+5v4YQbt6ymCMN2@vger.kernel.org
X-Gm-Message-State: AOJu0YxyA21GKQpLmrQnzsxFfIDBRIMzmthWlZk1Sh7k4/UFmip28Efx
	JCrTv2HD+3ZE77Lr+xgH5HHdGe2qtikhvtM8XAOX/VZ5TY2b950vlO9eBmrmLuH85PpdMeWyROH
	OShge3HRPBHYP0P/KJznZdvHGksTtTHlRo11wlA==
X-Gm-Gg: ASbGncuIb2Tig+UU0k0cCUN5CBYT7JTZP2NdsWaJUOON0EGhrc28E0phBE57K444aOU
	KPfJf1OEFLHg67YVwvYwwv51i+SYo7DOuawG9YggX9AnagUwzf6UoadOpEyCEaPTUnbvnkwwrnv
	jPKBvyp66vv8HfJJB1JBAaw5/N10DKd3Mx4lTdmU3vMsOP5aa9B+5la7IrQJCB
X-Google-Smtp-Source: AGHT+IHmVgJtSNYLkZaRzNpE6HP4wyihn0rjt7KnDqgNADuLUcHY0++O0fXvQGwGOiqydLENMHn7E4D2IwhvWvm9+PE=
X-Received: by 2002:a05:651c:1a0a:b0:30b:f2d7:1e7c with SMTP id
 38308e7fff4ca-30c4aa9fdd8mr66558431fa.5.1742223884425; Mon, 17 Mar 2025
 08:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 11:04:08 -0400
X-Gm-Features: AQ5f1Jqz7-ZXmJNFs_YhRQRGhbHO2cgIBb8ny_OJeurceVHHPcJUVWK0PvgHo-A
Message-ID: <CAJ-ks9kc5nGuY-8DXST_kK-u9PHjR9QHpVT7RVtkBctLKdFqaQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:24=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Throughout the tree, use the strict provenance APIs stabilized in Rust
> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> functions at the `kernel` crate root along with polyfills for rustc <
> 1.84.0.
>
> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> 1.84.0 as our MSRV is 1.78.0.
>
> In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> compiler flags that are dependent on the rustc version in use.

As Benno pointed out on v4, this should probably include:

Note that the enablement of the strict provenance lints does not
extend to the `kernel` crate's doctests.

