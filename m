Return-Path: <linux-kselftest+bounces-23920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE0A019A2
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178241882AE1
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDC51E535;
	Sun,  5 Jan 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA10PAHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993D1E485;
	Sun,  5 Jan 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084049; cv=none; b=OMlIzeoJCJjbOzCyjo62GH2xvhl2P0sLrJ0SFwuspTYG+esmh6Mi8KKSUaKUk/Qg57365wRNEkaBbPNruhJWbJhxwmesn1/nUurihilMBYHiikj70z2bVin4+/lr5J/E+3eoqvYVXEK534/XYgLSpJRmcR8THnuz1RWeVU2YiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084049; c=relaxed/simple;
	bh=sHYU5YGMQPzJkuw7LdRWjvh8Qb/SisWxK140pFcK4/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6O+MIPfzYTU6p41/i4ryoWt0ukSORqKJ0TdIe6+SQFwXzx41BI8YBVM5ZaP0MKVhPB4dtaGtALkevz5d2iA3Dl48EBqmLamKB6oEImzb1tRMiy3mze2xvbv0dpug2JM0Rv47FJxaRhUnhc+Su4YZJ5u+dwEVI7HExNB9GBCw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA10PAHm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so2760961a91.3;
        Sun, 05 Jan 2025 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084048; x=1736688848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RvtPVpQUDZYQyy4W0YLNqt9ec0D50dW+OTyYllUecw=;
        b=dA10PAHm3FnEjnchlwKHTIjfnGNJ5FNghlDJSDhvz2ugjrt+wfZ682nGuBYVOGx8+L
         dN9qjtJVNDdULxzPWNnp3h6nwumjigfsXcr14AuJS8BSrbhHtJS5X90KW0bFXAmZLCix
         WcuLWvKvmD71HeIoZ80swLTcg2PboQelYPADAuzbcgEiTO6dqQf084srwgNJaO/P++zt
         0GZWH11JqZAHhVfT55jOq+nxvTjob/rIykeisQhoXPXH2c5KpZoLgHRkBH/CqTqgNXIv
         dMmK9V9yW1X+qbgtU2BGwqK28YlzGwn/784f9bjCQetZ+FK2JusZF9PLEd8C6DlnKAzP
         1JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084048; x=1736688848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RvtPVpQUDZYQyy4W0YLNqt9ec0D50dW+OTyYllUecw=;
        b=X/Ilzics45vwmYwaMwAUdLwv+EccU/mMYf76/zTskZ1OCDXAsXZTuZ71C072aJO9sC
         1yhUvh6zhLBmZSmSnqCI9W/ciiLp5+mLoe6tDHYQHRQ+wLoZMVhR6A3eCPJN7SZg3bxe
         IEUV2atWp9F9MbKc0EcqPnhPE5A5KoaoHk1OdFIOCK3w2aMegc5gkcAO6vWrGEz58cuq
         qZUNqxjgQ7G1nfifa491eUruBQA80xkHpbDjRyi62qyh+rrT/Ox2fhUiugjk5S5mCneu
         h67AeVQYvHLno6mgRbOmHCMl19SVhhvgSVB/UNnH5DEsZnp1NfRoVfcbOb8q6a9gqNwC
         HNAg==
X-Forwarded-Encrypted: i=1; AJvYcCVlMdK8sIPAMnZJ0k/igC6NlxT9iLL2li8khL+Hcj/Gs1pJqVmubv85DGsV6NmOsV42utSikUcKpIBnwBh8XP4=@vger.kernel.org, AJvYcCWDBCScObznEH57V/Zsu2KA0h8i9Tl9U7UGH5D7u6FvO9JhU4Ko/zdQ4vuPQJa3nSC/GMC1dTl7SXX1XK8GyNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDrAa1APvkLKw9bEDvV/VEmgd2lq7aLIkOh856h/2TFyxe7wf
	lHZ02Qsb9UQGouk2y5RdE6QpL8TF/S8U4MOemh3GhIRJ6qt5rNOfjN22RLnI0Vt4EiOeIffR4t2
	MNtJBsmJnqJu/rsC7C7FCMYvIlQRfRorf
X-Gm-Gg: ASbGncuvuAePE15Onl4brVHRQM5mzACuIVFumec8FOFwB/SO1asKr1vCwr3WNXtCSZP
	qPtcJxYv93rwsghVrH7gQkOnWABBa2LaWRaft/g==
X-Google-Smtp-Source: AGHT+IGhAQT371nKxmaH8vlp3RgkBvFgyLagooOKijX0LuPewuplUERiQHzADDs25UttZ06GLEYh3U8t95HmWnQ4Esc=
X-Received: by 2002:a17:90b:3bcb:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f452de8c1bmr31993001a91.1.1736084047613; Sun, 05 Jan 2025
 05:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
In-Reply-To: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jan 2025 14:33:55 +0100
Message-ID: <CANiq72mMo9fyw-NbLUQi_5jD68W78Q5ZMn-ubstWCa6hue7qHA@mail.gmail.com>
Subject: Re: rust/kernel/lib.rs:17:12 : warning: the feature `new_uninit` has
 been stable since 1.82.0 and no longer requires an attribute to enable
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Sasha Levin <sashal@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 9:42=E2=80=AFAM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> The following kselftest rust builds failed on sashal/linus-next.git
> due to following build warnings / errors.
>
> Good: 829d8581c398a96deea1d6bc78578950347dcbec
> Bad:   b2d472701a703596889c3fd067fd8929aeffc4be

These seem unrelated, old but rebased/recommitted recently (without SoB).

> warning: the feature `new_uninit` has been stable since 1.82.0 and no
> longer requires an attribute to enable
>   --> /rust/kernel/lib.rs:17:12
>    |
> 17 | #![feature(new_uninit)]
>    |            ^^^^^^^^^^
>    |
>    =3D note: `#[warn(stable_features)]` on by default

This should not happen since commit 8e95e53ca379 ("rust: allow
`stable_features` lint"), which is in v6.11-rc7.

> error[E0658]: use of unstable library feature 'box_uninit_write'
>   --> /rust/kernel/alloc/box_ext.rs:41:12
>    |
> 41 |         Ok(Box::write(b, x))
>    |            ^^^^^^^^^^
>    |
>    =3D note: see issue #129397
> <https://github.com/rust-lang/rust/issues/129397> for more information
>    =3D help: add `#![feature(box_uninit_write)]` to the crate attributes =
to enable
>    =3D note: this compiler was built on 2024-11-26; consider upgrading
> it if it is out of date

This should not happen since commit 0903b9e2a46c ("rust: alloc: eschew
`Box<MaybeUninit<T>>::write`"), which is also in v6.11-rc7. (The file
is gone nowadays too, since v6.13-rc1).

>  toolchain: rustgcc
>   compiler: 'name': 'gcc', 'version': '14', 'version_full': 'gcc
> (Debian 14.2.0-8) 14.2.0'

By the way, it would be nice to mention here the Rust compiler too, if used=
.

Thanks for the report! I think there is nothing to be done here given
the details above.

Cheers,
Miguel

