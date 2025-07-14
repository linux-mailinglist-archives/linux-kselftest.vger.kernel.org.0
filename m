Return-Path: <linux-kselftest+bounces-37289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC528B0491F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D313B4ED4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1C25A33E;
	Mon, 14 Jul 2025 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giyJ68Je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210E13D521;
	Mon, 14 Jul 2025 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527362; cv=none; b=P6hmEzpQds+uWVuyiYQ/nqq2arsm1N8M0O8JDkRSOtNJBjUD87m8IUgc/2leyNWcSnw1xc/Ab/pSwAyWcF1x94PAW1BOFfSSonQ6ZX+B6xqEDTJAT6b/Hxukl3ocWdM6xDPcOQNE6tHSOE9a2gvglWKHa7jJ5rPuDi/foN4F61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527362; c=relaxed/simple;
	bh=pp7EZJHNhKgZVRNgGdA+nKTDA2ZEIWR5JbdJfIvQgqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrodm6r/2bES8u+ddEiewxATV1cbM3/NbU9jHQA/2nsgcGeLdYpaFEc7fVjL9EGAeJ03eaFlV9PMaNDcAqbtrvyaolkWjhp5HotUiDvpkBxfeK0lp2Rrg5jxN79Xa1IoYFWZB9Y0cSgQ1ESa1GQ933QkPRrX+qBpGDTc8ZdlsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giyJ68Je; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b5226e6beso41368691fa.2;
        Mon, 14 Jul 2025 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527359; x=1753132159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2NGUJZIs6JXP/sAdJptIUUuAIdinFtA6zHN1UcDf48=;
        b=giyJ68JeAIjFE3R1OsNHERrrF1kv4a/i4iIVcwZwJbH/vjZfEyDXWC8H8XG9lTBt51
         akYCqGpkGqqnq5C85eUwf46/XVcVQQBmFzE6vXwr4ys+xRHuaWlVgNu8NVCBYq1tu1ZF
         JEozwXi7YbpwvF5JX1rVjTeI25+E0jEKso/Nc3BW906bqAbagL9Dr6qcFLxrnzp5j/CM
         jurUNWY6q2NGz/i5GePeNDgR/yDr8roWNcu6w6JMPtfod7k+b4Ua+nUDsNDyr7SGnHKJ
         gB4tJSd3BTFTyNRvfWvtKSiqzkWPfVUr6zZRflzK9/ybMKz1NXfyb74x/7i92fO3bX9r
         Vc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527359; x=1753132159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2NGUJZIs6JXP/sAdJptIUUuAIdinFtA6zHN1UcDf48=;
        b=XrZ+xPbzd4OfnopCSOYN28IiGl3x14jJY6ypIHp1sI6ee7i1fGVm7mVgbQfpqyImQO
         TiHRIuv2EZ98zpmscspz0tdeK46AQLdfRmdseclqYUdsm1tA/OvCvflc9vdWs5FuS7hY
         jtPEKGzvka0W7boi7VEPROWAO9iNDhAoBgI+kgMga7q3t4nco0bcNLCjb4qe0ndeZ/ks
         lnPMYAts/1E8peb2jKEAHv0wwaNMRwgUBe6H30bmUl5ScqJt5TnFB7oiT7m6I1yp2HwD
         3Q7Li4lZ7+H140tXYeuz/rfRmOPZShMFuZSWWOmH1F3V7nEzI2VtxnzCjWrVUPIwuH+Y
         zbtg==
X-Forwarded-Encrypted: i=1; AJvYcCUPWti49PuUMZIwpwmXLvxIMtSEOpsWYKj1bRKXdxq2SLji3i9TnCJKLOSENtWqAhEF9C+nJQ33jhfZzg==@vger.kernel.org, AJvYcCV+lPWEr9aPYrSdNAc01p7voZ5X9VbqzNqm91wxXH3/rtueBJYy3qjtgNzzOx+JgEPVCc2W5K/NRC4xIJbFvkU=@vger.kernel.org, AJvYcCVuYgjYdbf3RjABhtNGmcLi0LzB8rVAjvOZmAzNibQOfG4pC91knFpEpnDQMSIHGVbdNPyNKP9r4kMBujvNWzX5@vger.kernel.org, AJvYcCXa0FKqi/kVtDA8z6o+fVmAaldCbkfePCHvNC0P/66NB1gunYOCzxN2iX5T2k+L0OukLzYIUX+U1V6OToNW@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOcCTSpV+/0iQg5ib/kAZl5rw4VmqsCyuDIg3gsyYg7o0K219
	KFzlaUlFhnpBsWqFzF6VxDSV3I3YwuAWXguM2zz3agz3QqrVsPvJJVWDKMO0APAnQbDlopxBPJy
	9Ebl0zgWEmujDClkmePTs4Gyaj00FvnYc7Ws6BxVuAQQo
X-Gm-Gg: ASbGnct+ST05Gw974zmgdGLIUK4WbSK7gp2728dHX9I2/wMFjCLg/k7EjumG2PBkxva
	jXu3mbFpjk7pD9FoIvbdXkIyr4sTlJKYxdo+hOjrMm13p8H+1SCRbnHz8rFQ9pxZ8L5x7ZquiNR
	cD1ZHdjwn+VLnC0kxRoXaaCCiGOYtAqNFN/Bp9TAtk11ifTx3W7s9JEOp13r3w/QhYC9hNNJ9YK
	17uSqrF77fCl3gNJ9bpzzaVQ+eNQAjaecpvHyyn1g==
X-Google-Smtp-Source: AGHT+IFIVDCB7L/eB3uWUEMPtrD+l6c9ix8jySxxyANfqPuxUfbMymVsdKjgYjWTiEHRsDI7xj3AbxpdXdL0khzdR6c=
X-Received: by 2002:a2e:a594:0:b0:32b:7284:7b with SMTP id 38308e7fff4ca-3305329b33emr52619951fa.6.1752527358610;
 Mon, 14 Jul 2025 14:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com> <20250709-core-cstr-fanout-1-v1-8-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-8-64308e7203fc@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Jul 2025 17:08:42 -0400
X-Gm-Features: Ac12FXyyrImsukAEONZO1t5G1kFxNsU4eIQFIToYW9Gkgy7rbvMrpAOfWyMPO9c
Message-ID: <CAJ-ks9=ux6BuPYmRVSjhfn7kuagxPWicBZbumDFKAqmHKd8+PQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:00=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Oops, forgot to include Christian Brauner. Christian, could you please
take a look?

MAINTAINERS entry being added in
https://lore.kernel.org/all/20250714124637.1905722-1-aliceryhl@google.com/.
(Thanks Alice!)

> ---
>  rust/kernel/seq_file.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> index 8f199b1a3bb1..59fbfc2473f8 100644
> --- a/rust/kernel/seq_file.rs
> +++ b/rust/kernel/seq_file.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_fil=
e.h)
>
> -use crate::{bindings, c_str, types::NotThreadSafe, types::Opaque};
> +use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
>
>  /// A utility for generating the contents of a seq file.
>  #[repr(transparent)]
> @@ -31,7 +31,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file=
) -> &'a SeqFile {
>
>      /// Used by the [`seq_print`] macro.
>      #[inline]
> -    pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
> +    pub fn call_printf(&self, args: fmt::Arguments<'_>) {
>          // SAFETY: Passing a void pointer to `Arguments` is valid for `%=
pA`.
>          unsafe {
>              bindings::seq_printf(
> @@ -47,7 +47,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_=
>) {
>  #[macro_export]
>  macro_rules! seq_print {
>      ($m:expr, $($arg:tt)+) =3D> (
> -        $m.call_printf(format_args!($($arg)+))
> +        $m.call_printf($crate::prelude::fmt!($($arg)+))
>      );
>  }
>  pub use seq_print;
>
> --
> 2.50.0
>

