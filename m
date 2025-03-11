Return-Path: <linux-kselftest+bounces-28735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29774A5C1F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9547A89D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7058450FE;
	Tue, 11 Mar 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bvmEz73A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C235973;
	Tue, 11 Mar 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698514; cv=none; b=IqYSN81AqRcOpCoN1K0P9MPtwevJFyC0AHlwl9iiwqPou6A1wuLSSdgihbtR660tQaMRtnan/G0s874GR3ZouaBb0iTglXbFT0XIIDeahVyDdNKgM8jrvm3sJYL32bbt3oFdVwMeE/h7Dlrql9GpNlELfbdngCaxDS6wQex3Z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698514; c=relaxed/simple;
	bh=ck/zlJNE5eU83nztFEGSZ4ENuEUd6qotY8RuqJUlojk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROVZHjYgvqHZUCtrETjKhlMeYQY9owEuEN2AHy5uBqnoPizmMRHu3OGTBW9++50FiyH77bLEXIMtyN/bzgifF43sEaOq5yEBE5Eca7S5FiGm4LYDssBuzxByDao1S8iEGD3bYN9frw1x/uBEOq2EOR5b0FEMgn9NYU1I7iFJscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bvmEz73A; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741698503; x=1741957703;
	bh=blWTqaPziEQ/pUrrx4UHOMKEPZD4HIZJgcQ2dw8xfZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bvmEz73A4uNLFvcDdB/Xf4bNFipqifYoxkaBO4jTO0Rjf2gt2XI4K/I/VBbtCF/wn
	 6NYcVbYN4scD5WY6kOtA7/yH8rXx8eOdp9Hi7YEM5xlr59G/WzD8TYjP9KIzvfZqY5
	 XbqxJh0HAY/WO4FgWAEA4pzxaqkuyHilWZVtq4JXbQ5hLx2JzKlLyRrWuS4jrRcIHP
	 cFAFO5+RuGuD5AU7qMXjbNLLZ84AurNtodZBRfJyc0BFb/LhaJuLeUGvSh06F6ER9T
	 6KXp/xSboTLqtaLLIgyRsMtZ1vCQW1JhTTW21PYUgj/VeVyLUWSljxepU0qGmhFf67
	 /TKIb21Xfj/dQ==
Date: Tue, 11 Mar 2025 13:08:19 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] rust: enable `clippy::as_ptr_cast_mut` lint
Message-ID: <D8DGL6WY04GZ.207MFVQMKY35G@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-4-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-4-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f8bf13b601952848b958efec8bb21301139d199a
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:
>
>> Since `as_ptr` takes a `&self`, the pointer won=E2=80=99t have write
>> permissions unless interior mutability is used, making it unlikely
>> that having it as a mutable pointer is correct.
>
> There is only one affected callsite, and the change amounts to replacing
> `as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
> is more descriptive of what's going on.
>
> Apply this change and enable the lint -- no functional change intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_ca=
st_mut [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  Makefile              | 1 +
>  rust/kernel/devres.rs | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c62bae2b107b..bb15b86182a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -477,6 +477,7 @@ export rust_common_flags :=3D --edition=3D2021 \
>  =09=09=09    -Wrust_2018_idioms \
>  =09=09=09    -Wunreachable_pub \
>  =09=09=09    -Wclippy::all \
> +=09=09=09    -Wclippy::as_ptr_cast_mut \
>  =09=09=09    -Wclippy::ignored_unit_patterns \
>  =09=09=09    -Wclippy::mut_mut \
>  =09=09=09    -Wclippy::needless_bitwise_bool \
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 3a9d998ec371..598001157293 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
>              bindings::devm_remove_action_nowarn(
>                  this.dev.as_raw(),
>                  Some(this.callback),
> -                this.as_ptr() as _,
> +                this.as_ptr().cast_mut().cast(),
>              )
>          };
> =20



