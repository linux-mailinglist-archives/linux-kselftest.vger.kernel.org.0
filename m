Return-Path: <linux-kselftest+bounces-8603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8D8AC8D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64424281F22
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709C7FBA1;
	Mon, 22 Apr 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twZsfRK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7A537F1
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777958; cv=none; b=cDQZnOvs01qQFPanbTW7FGnOhle24lBDudksIbbs8huAbUeF4HDrUlMFf+aeb+5HMCH/E0yR63Lkw80FQ50TGYDrWAN2blCk7H62fM40kT7CGmXskk02yJ/HhW7G4zcBVMlzkd6kN7rAkHXREjXiAYdFzotGvoMJJSCeSOnKp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777958; c=relaxed/simple;
	bh=ye+YDeypngJNVRNApH4ApNOV3asObjEsmLgFOfVV0AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tp2a5whQswCJ7cwj4bkK6MecgY5LAJOw6mjdcVQyrWMO5Gqqk8F8ezLH8NjyPurExr17voeLSKaPdQFj3RT1itI1w2sg0sjCKevjrHIhFC8bjwtJdo1rfaqeYdiuPAU5mVBXEy1W7eOyuIRNFridVPS6x/K0hwIh4fHFFyDUKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twZsfRK3; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e7cf5cc1d0so3391209241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713777956; x=1714382756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u02hciJF/25Uzt60NJ0xbu51k6rfBNzWcPBLcSlUo80=;
        b=twZsfRK3ziG0zUb1bCJXi8C9F56uvM1GjgJNPIFDkI+Z/QqUDW+ujcsdzCaqKqm6YL
         0mwFX8clbtzZmG6070BsZODiLVFyOvnD9XXXEFVhSNgbJa0vXnevR4Kz9VVs0QcAzSBB
         MTJdLjhLWgnrhN6kicMs/vxU2u9W+ompDL1GQFXLDh3IWDKiAlmn4fQzxPjv8J2WyOcR
         f1j3Q9UnrLDBTFGS/5EHfOQZiO8BfXIwB07OIpsnXNfGtRJrjuUzSR8rnLymI7Hq8I9C
         ibyqWof0mrDVQXnYgcspRBgnNYcU+HCmfE0doCBJq3F1rejFI/Mu28ItdnoSk0oF0N0T
         0hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777956; x=1714382756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u02hciJF/25Uzt60NJ0xbu51k6rfBNzWcPBLcSlUo80=;
        b=romfB4QLiW0V9j9lM8BFF2PD6KApxgTG4FjiiOJ+5pSxCXtsooDdh1jvm7j2QqFFvS
         T4oi6Jr49ynUjlt0/iEp9Xu6x0e8nbCv3kfQoamtge5HJKUOqUDlOKNzAwE3M+iqtnEY
         vpptQ7YX6jJp5GnQZ2D6h4Z3l15pbfW+cPWM7dOp/DfXFbBU42lD0nHa0rC1zw4nTu4E
         NorMLxBWeP4XQAQbtRboSZiwWKWGM1+c9eegLGA3+2k5quNEQqnzDaD5UX/k6NISm6JE
         SAtc58p9+jY9xP1UGEkApe3Leg1MCa13eiQqQ63ynqdoJlq3RWlUyPDwIMCgGnZ2/mmx
         XCmw==
X-Forwarded-Encrypted: i=1; AJvYcCXAwsoq5nMokJF2t8ggBYMPe1nt0LdEPAfzhAdRHyCPkKB2mEpDfYys+NALi6rxE6Nxuhpwvu18U9/aboxUPIUz4YowgFwVVzcDqhTfUPNE
X-Gm-Message-State: AOJu0YwOUsRp4SsCi58dh033oCNUEqkEQgoavQY7tZVHKiziAW/1+NHR
	SpiDunLMhFscn/kGmpbtVcplkDRMjsqdFcPKeDHF9XP8d8BwZt0fe/eWu9sfFn54i+mKJI6nep0
	ahWsJG17VLU01M6Wff8iUJKLdEdAHg3dem/dn
X-Google-Smtp-Source: AGHT+IFzbvs5nDCKVidubFmVhCqyTJZpX1MSVwcFBpjxWlOvQIwOZ8sgogJwUEo36R0OhEd8C3NQ+lrl6rjs+COe24c=
X-Received: by 2002:a05:6122:2008:b0:4d4:34b2:9a89 with SMTP id
 l8-20020a056122200800b004d434b29a89mr13136946vkd.8.1713777956098; Mon, 22 Apr
 2024 02:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091215.526688-1-ojeda@kernel.org>
In-Reply-To: <20240422091215.526688-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 11:25:45 +0200
Message-ID: <CAH5fLgg=v28bFJE1izZ-WF7uBLcr7D2o6Yr2ihdPAz205MiGGw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:13=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When KUnit tests are enabled, under very big kernel configurations
> (e.g. `allyesconfig`), we can trigger a `rustdoc` ICE [1]:
>
>       RUSTDOC TK rust/kernel/lib.rs
>     error: the compiler unexpectedly panicked. this is a bug.
>
> The reason is that this build step has a duplicated `@rustc_cfg` argument=
,
> which contains the kernel configuration, and thus a lot of arguments. The
> factor 2 happens to be enough to reach the ICE.
>
> Thus remove the unneeded `@rustc_cfg`. By doing so, we clean up the
> command and workaround the ICE.
>
> The ICE has been fixed in the upcoming Rust 1.79 [2].
>
> Cc: stable@vger.kernel.org
> Fixes: a66d733da801 ("rust: support running Rust documentation tests as K=
Unit ones")
> Link: https://github.com/rust-lang/rust/issues/122722 [1]
> Link: https://github.com/rust-lang/rust/pull/122840 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

