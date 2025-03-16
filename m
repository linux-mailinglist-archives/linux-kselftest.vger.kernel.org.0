Return-Path: <linux-kselftest+bounces-29154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2811A635B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BC6188F662
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F31A83E2;
	Sun, 16 Mar 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzJ1ozKn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A581A3166;
	Sun, 16 Mar 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742129687; cv=none; b=ZxuiMdypxbs/nQPX0Jxx4td7FWOyrZ+pdwMq+44cxnwVGJ8bRIaenTH2vJPDADjgjU4QnwonXO33StdQ/SzA8uPi11bJjkWz01rxp4Mdwk/qDiOzvxXTyc+4xgOtYbnW1ZfjYDgaa+V4TC0oGQiEMyiYUrcqJF7PGaJgJDDWRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742129687; c=relaxed/simple;
	bh=la8iWv4aKLDOW0r7llYW7xIb+W8ddGrURAKkkeCgcDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBzYuUnF0zwciAfol2TuLr5ae7KTemmsk6LnurUkY0+jrGi2rYrbJ3DBYmCoawDkL0jHm5ecssn+7crO7UB4DcuSl5Au2E0AwuDJSPn8zNfO2WNljVhMVW1EdR3IXypm+A598d0bAWeA3I35jK5MUPdCaMKoYezzFEyGg50sofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzJ1ozKn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bae572157so36825201fa.3;
        Sun, 16 Mar 2025 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742129683; x=1742734483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m72Ysl4ko4hY5HZYX4qrB+VwpHKR3dQw5Vbh4xYJNfA=;
        b=LzJ1ozKnTBK3Nuks3YCvLJW7/Z/EgJgIT+3DVVjlxG0cEo3AjIIqyITHuNZcgCvdNG
         ckvoPbVH7s4LIV+Eb8W42Y0RmHfkOOQrgDG7eH4m5REbTCfONTLexr77qTPXjBT0X2uK
         C8tNEWxvNiWNIIsL1FYCr1FVPeTbabcOsEzbqkCe/KofTBJlpObvczW5n8gCbQAqbXYA
         ni1gAVBY6EiwWvYD8SUTOyyUTfnLnUSb/4byMTJOl+yJKGzzbtD7G6yDHRKR3cbannAI
         tYpMNrEyuHng7ezK4ZbMPndMnNYgKyY8D3dwdt2H7fe+zUTSCZTfLKTIGtg/6rrjXJ51
         eXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742129683; x=1742734483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m72Ysl4ko4hY5HZYX4qrB+VwpHKR3dQw5Vbh4xYJNfA=;
        b=gv99bfCGwAGJvDkbgP26SE+bgfjfIlIBiWAk4lA7pto2km5SXytDRbzz2cgvIWVZg3
         mortDva990284TCukzWVZqbC6UA6J9eujJxQe4UUmamZ5T6c2DwL3X6s59MxmqpFnyCK
         +5fFqA9U0rURglxrQyNnG22fLpMebPbqf1SxJtW7AQVMeV/7wyLh7iZeLlMD5muGFGwy
         f68WXrtx0UMsC9/vB/+Q81RmrfR2WmVJq3+ZHI0JirmOEr4NQyf80gEqxwXregLK4uE4
         VzOnFI2esBGU7/vfYlZsbzRhxkBBzVAhEqx9DOWiAN5l9tXIhQ5sp/yjFkCaDdjn2uDS
         p6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU2dhLCV85wGtXu3yEePIZK4bNWZvQxnPh7dq8U/gHcndt/CliEvlUUjNCUhshx37/KElPv/pI/LA98Vi4=@vger.kernel.org, AJvYcCV/U53Oo/PSiZEmtbzR/nK5raK8kyocbCWtZjLSLRFjh51qO/FpKtRt2ZmXOZssHRlNKuOkBpzypY5G@vger.kernel.org, AJvYcCV6pxQlOQzoiEB53tuH+MlSNik8GKAQmhyjRYJnDyqOkvuia3x6olG6EpTNdm30Q0ee3Nx6fHYUborDlkb5GUeQ@vger.kernel.org, AJvYcCVID1K3veLYfT7XuVDwnywSuxbs3rcH4z59WP4InNShqnwi9Fg2O3XHhJtBNUchF5uGoOf7ueITjqjcpYNN@vger.kernel.org, AJvYcCXLk2pifFd39Im7duj+7xtz+Y30iLga6qVyU+OYs5aEZlbO8AuCofT+v+SwiEOy6UgwmUzcxf+2MVf4@vger.kernel.org, AJvYcCXVfAkKd75cOvtRCJPaW3d+dGAwIFhMTlnppWRoWZwGOHtgG0v+Hzrjan2AVHTyIz+Fl223DGJbtyQWPsIOBXo=@vger.kernel.org, AJvYcCXaS39X6QebQQr7K6IGzJgLEY6n6/ZkKygkXmym4LPwBtbV2WYxj6aPMrhbJNNRBf2I5n/JVgYfh0LM2Mi2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy521CC1DqjXoztkQSjYqGM8frgwcgske38ps3FBv1OsbgBDDo
	T7mTmhYAov8aq0WlPE9/Xe9hrn0BSLQFJn6S/ESvA+xGflocp8PtkAhwWLslq7hmQ7tKbprg49t
	0C0cx5qUEeJQ0r+6rzjOFr0jtOPI=
X-Gm-Gg: ASbGnctES8i5UEnZ4poeOrMM8Kk7QcpYB3zmDMCjL63nAD7esNbwhzWMEM1xx2kMDjD
	5sAOwTdW2jpQ6bPSTyFk87z/rp/1jR07aVq2PFWX9TJW2nzmQGV2VfZyupIcwIww3qT6BbXhrtz
	EqhoI01rDkxNgc2dnBzLsB+fxtVZzPYaCuZGFci2KuwmNIihMex9HpyKpy+lmF
X-Google-Smtp-Source: AGHT+IE6iBXWS50nKSAYwo5FCXBdnhbNHVXtxORgs/RwlrM4JXF7GGDHtXE0EnpBEkJ1e6Y0/wbpMEdDeSo/iTCQCcY=
X-Received: by 2002:a2e:a98e:0:b0:30b:d17b:269a with SMTP id
 38308e7fff4ca-30c4a749070mr42282761fa.7.1742129682837; Sun, 16 Mar 2025
 05:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
 <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com> <Z9ZbNY2XR10vt3Ro@Mac.home>
In-Reply-To: <Z9ZbNY2XR10vt3Ro@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 08:54:06 -0400
X-Gm-Features: AQ5f1Jq4oEInzEsIP6AyCUxxntLRsaKIunWuOaZj1h8pyzZQkrJrV4gfLymNygE
Message-ID: <CAJ-ks9ntUhnD2D1qUCosrKk2bEYHXFDLEanznpNn51d6CbD6aw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
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

On Sun, Mar 16, 2025 at 1:01=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Sat, Mar 15, 2025 at 08:17:30AM -0400, Tamir Duberstein wrote:
> [...]
> > diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> > index 40d1bd13682c..f9459694cbdc 100644
> > --- a/rust/kernel/of.rs
> > +++ b/rust/kernel/of.rs
> > @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
> >      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings=
::of_device_id, data);
> >
> >      fn index(&self) -> usize {
> > -        self.0.data as usize
> > +        crate::expose_provenance(self.0.data)
>
> Even though of_device_id::data was defined as `void *`, but in Rust we
> use it to store index, see kernel::device_id::{IdTable::info(),
> IdArray::new()}. Hence we should use self.0.data.addr() here.

Good point, thanks.

