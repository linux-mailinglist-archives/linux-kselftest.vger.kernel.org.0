Return-Path: <linux-kselftest+bounces-29223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE17A6528C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E691177962
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BE23FC61;
	Mon, 17 Mar 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6OtoGuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34F24167B;
	Mon, 17 Mar 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220842; cv=none; b=olfMYCCp2HEC0uLzmxMyyS/7XSmMlvvsuQjKml8TxmkCE78S16wkOuFY9fvkPzAofJ6s/KhqMtFqgPrYBlC3S8fhgc229UDFsn+vgqJ0TsFAiSIIauuBVBTQrIDsqybp0ZilpvoaCVkt99hug5Ek07OZJc0w20Y0BjhxSOBYg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220842; c=relaxed/simple;
	bh=CVOajz0SswfE5RdPvrmC6YAfTKi/WwrIPgt8fN6yta8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw6/qSLU8ykQqWSBVQhV0e8UtqqBNHp/X7G4hlkXu5fcJlOeEWcj2ckmB3/ICphPXSRDAI+9ar3MfjrgHEqqrFzhVFAKjUV0iXw1vvXm1FjgJh1QAq6Q7dnSx2pFh0ezatD680LxA3mz0UaLeR4IihXIoWHEwsP771twyY7S4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6OtoGuQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c091b54aaso41852061fa.3;
        Mon, 17 Mar 2025 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220838; x=1742825638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfFVIXEKkQVbIszXnDVMJcC2+/nJ/AFJtrMqjwVFnME=;
        b=F6OtoGuQ1vbhLl90fMRgvPDydu59e+mJ03zqn3o6g8T7Nu6tW/njKtwqBK8ocVFMpb
         wG5jcpXnAUb6r1z4k6VQC0L4mbKgKoUq1ftndLnXkyY2h2K1VPkCJHzFymClvTeq5v6T
         7I0aFI8mr0oTXOQ0VicaZTXC3AFJeV8ibkRlURpqHeR1gdYdbJok2wP46Mh33DzPbAJX
         Q1H6w/PGKyGuiQyLbhmLiwreYhGROl41eTD3mia56so50f2pqxFXGXIepoxF2NRBQ/yw
         Hk929vCCyHN0q/aI+oXm5N/R8507Os1v9v/5n+PxXTKrsLyMiPMMrUrYNozw8kVDGzHZ
         VbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220838; x=1742825638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfFVIXEKkQVbIszXnDVMJcC2+/nJ/AFJtrMqjwVFnME=;
        b=nxc7nVChFlbbDq/Il7HZeGrDwqCLS0/cahc3+hS4kuy6cGGJkoZs5gDap5c3dUicDl
         B+8SDPq0QGJ0Hxd8AbQgMlhSOkT3YN3pMLY8okdHzuO0YuySeil643dR2mTXVeBwU1S3
         QtSYV3jov668C6IFU6Z9lBEbpZlJee7H98X40h+uQ2Jm328XoknZfbuMenKcGMkPrJfJ
         wa4xbg2Y+LAuiLUcVw1K23n+C+TaG+HiuYVen6xsutjvsX8CzCu4z+70raTenKdygquD
         BrRehdBmF3TKBWT7OcmcABeqXitnvSDepQPxnVFmxLvYjIEF11Qxj+WGf19llqBS3cwp
         8mLw==
X-Forwarded-Encrypted: i=1; AJvYcCULLaQ0G7w8TA/1RCE+aaF/jN/8o+zDJNXnw1de+SmirmEWq2zb38VovNVCCMkIqV8+SNJplcbd6NKOfJWx@vger.kernel.org, AJvYcCUa5iprp2dvlswLqejKaeDwu/wlibkj+oTKsNlgcKznOI77uU/oJzGnXlHcMo+5mtjhbXdNISF4SgCa@vger.kernel.org, AJvYcCVj93oO9dgwQPph6+ddU1Gdmi6+kRGIVhynQkBLSk3bktjfQE3KYBpMR/PlL5AwSI3oSdXy51Ym2lrnCxx2y/I=@vger.kernel.org, AJvYcCVp2gvftT1iN0gFJ6XuagFjmUFeaH+eqzuI5V6SpDvKe7ssEdmJJm8xSoFMoQyBMDJiT5KBK3R22CgWUuJLDol5@vger.kernel.org, AJvYcCW1X1FiSQdyrtsLvg7oLCUyjPNG22t75wNWeFiabSbHcPh8bDAci3oBjPC+xi0bZDSuJFyriOTDWIN22ON+@vger.kernel.org, AJvYcCXf3NCxE4v8WCayXAPz3Xe5+Jy6Md60TL8YC37/LgIIxG44IJbe8VLp97Yqyx1WM4ZsRveYBpLLLBrWmdE=@vger.kernel.org, AJvYcCXg35VC0Y8qzEgr27YTV9F/7PlyX2p67IJQt06xjXazMzk0o8cNM/9otwnBMA5ikToe+cYFrydQGnKR@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3e3wYyBH2uaNUjmrr2JjyzJPnavUwv3ATWBdwT+oPQfp02FH
	Epr8so0Xd6WT1Tj5KbyvnfH1+y0K779/dJ/rJesDePms6kIoBt69UOMvDe/drHjhaZ3h+BRwaHB
	veFd66iupicvSplXqXfnaTyI8FA8=
X-Gm-Gg: ASbGnctSCPiicIq+s35z8mwCI+p1OlDYc5JRUASCi9hAL4H78LgIOiV1pKIlj93+4E4
	KBofl2n+Znk2k45VqsZNpx30+APo/9LEYAlGiay9LKXmVKk9JDLRu9TAyhB/n/auDkMj8+9qOzI
	BrTVcPMkUr3hyOkw1mQHgWROdQmGZyvhxm9fkPNgieEk3jGbolOPg5XhoHFbsCxNRBoOLpdtc=
X-Google-Smtp-Source: AGHT+IFzkocQJqEpLAgVqhznM9G/c3svmZ3XdUy82l82HgzT7cMT4RMKww3UccU4uaWF5zmyfhHhEJgkJu0nmVO2QMg=
X-Received: by 2002:a2e:a541:0:b0:30c:2efb:6608 with SMTP id
 38308e7fff4ca-30c4a8d99dfmr80436951fa.34.1742220838076; Mon, 17 Mar 2025
 07:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
 <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com> <D8IFS7175NNQ.3VAP8WA2QC8WF@proton.me>
 <CAJ-ks9mXzM6D++vq0QCugaFOS9ES0j7GpeWZqckY0dA3JwpnJw@mail.gmail.com>
In-Reply-To: <CAJ-ks9mXzM6D++vq0QCugaFOS9ES0j7GpeWZqckY0dA3JwpnJw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:13:20 -0400
X-Gm-Features: AQ5f1JqznMa6k2lJIiCnZwHn6x-b5GCvJwIRUhiNMHYfyIvOPnUOor0S-U9RHGU
Message-ID: <CAJ-ks9kH3SE91XSadBx1qFaG5dem93o_ctR0t2FwW-0ZfkRNwQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Mon, Mar 17, 2025 at 6:53=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 17, 2025 at 5:34=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > > +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> > > +        addr.expose_provenance()
> >
> > Instead of having these stubs here, you can probably just do
> >
> >     pub use core::ptr::expose_provenance;
>
> This doesn't work for the methods on primitives, but it works for the
> free functions. Done.

Have to revert this, writing `pub use ...` directly causes the MSRV
clippy lint to fire at the caller.

