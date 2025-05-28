Return-Path: <linux-kselftest+bounces-33947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2FAC6DE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0997B406F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5D28C86C;
	Wed, 28 May 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEf2JTUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB82798EB;
	Wed, 28 May 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449252; cv=none; b=Vvv33eRHx8FRBv9vxs0N8SPQz3z5am4SjG+1XJT/w2Z0w7od6L8Npsi2r5fJgnUO0St8dtzJ6mnLZjrjY5Zz86TjiuuLk4ivl8oHCXQ7VYGtVyeg/kx1LDVGJavtSDXXBFql/mCzmHWOu49HlaUk4GJKZ03zbbA1kWwXbOkJG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449252; c=relaxed/simple;
	bh=pVfN9eS0l7ihongB0LOBdjBA6cxaKVHJrt34QSlJ1sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7nkNzyh2zfNMNZsx0UlNMAIsDGsXdTHKx4p90ceTv8eUtSqp85JrA/ujix7kq6r4p0Mkr4qwie44CRwkrrAx3cckVT3F1dxHqbKicX+EIJadEsYk4wK559EQd2YB0VTKib5KbiF6/pb0FVs+UQrgqcBQJX/vrWtS6uYyWk1GjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEf2JTUg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32a6083ef65so28461551fa.2;
        Wed, 28 May 2025 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748449249; x=1749054049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX1eTIuJOFJ1d8HmF81QUkvA4Oc+VUDTFQ5Tkm2VlKI=;
        b=LEf2JTUg47tDz/5Nq7NOGOb4KMtNOvx07nVAjiktSk+5JnCPovnVhpO8TX3h1EThIO
         ofaTvc+ylFwiZpfFviudq4g1V7itEzsA1B5Bt3K5FzUxoC7c7YY/SDWlpigOFkLFxpoD
         QuIdktaKP9pPtBMF1LrZwzl08wr2JcHimmbUPA2G6+k3Okg4FYJ9NkbFpDm+i1vT1YNC
         5mgtTlTAcB45iGm/Q7OLASkrdEGrycRcGqbfBCHW8M5d20HhGv6GqyrmocsYMxRIoJdJ
         xf5fY48Fx8ZGXqIgTGSlr9T9HIAA0V7Z64UnwWOFgp/Bj0EH9qFZu72V8cl2pUIIthgr
         6oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748449249; x=1749054049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX1eTIuJOFJ1d8HmF81QUkvA4Oc+VUDTFQ5Tkm2VlKI=;
        b=w7wTF9fFbCC1NbXp8Q/cMARpG0K/KjA5yRwFkkfzsdhkljnl4ub7HnYCzVPeS/pECZ
         Nz+8miNi4zV7+4n7B5XLInTmShCIsyBbGl7wl5NMbt68wleaBpRAxuM4Pa3qrJ0GuvLi
         7nlKcHEphYXvfFD6ax1yKWKwJEdu4H4NcNzg44x8I0aniVDIDsxjeh0527sUhUPoD4RW
         x0Lp9ypJXHSI7paOoaunmFsZXV4JQ85Nbd4QcWE9IIGmKBZtXLU67blsqXCCZTutYo6J
         4bNQX5movTYe94yAezM1oDBQLvOLX+Sk24uRXBof+WirYi54Ty8YxW94bTXZnFXPY2N+
         iEKw==
X-Forwarded-Encrypted: i=1; AJvYcCUcgXQE5XdUiDLiOKDK27I2/Q8yq2VNNx1ncLxA5JlK1FXzxO5Os6ffDha1wvhqn+78APsTjmuY+MtqwpB/Xk8=@vger.kernel.org, AJvYcCVLfn8Qs6JbIpW6QjvGrALzIxaBdsGXfz7Vb99KOQ7UgdPHgI0mfArGK7jwnLetVIYzVZJrq7DLslM/8FM=@vger.kernel.org, AJvYcCWexzghDyiomsrJHUkafl40ClvqcXtXsxqdbiFEftUZhnOhyd7hpi0oqP9fsVroEdLCsfZoJGZ+ObCuuS4SJNtu@vger.kernel.org
X-Gm-Message-State: AOJu0YxqF9+5AddQp3FqHuxbtHMMK4tanYtQu8ycfnlcu78tr0PcvB7b
	YtD7jHF/sGxhMX7IbOeaNipGhv+Is0hwPcxBGr4cNnEuEgRPXuhySioOORD7I9vvPAY+y/b9p7N
	D8EOMzkSQVia/pz9TVG8eaIffJ+funx4=
X-Gm-Gg: ASbGncvPx8OX4VqkhlieocMMid459Y8rYJ8RWq2VXAAdjFqJ58CDi+4jf5soBnNfcwA
	+ar31x2QYseCYSz6ekUd3w+Pqn+6mGhxzywNo0GMckf03m3mEg+nJYCKwfONCIkr8f1/5owhJeu
	oB3inA0rOobLPzBzSEpRXFju78OTVKY6pv4tfMCbnfKmdpwO2Y
X-Google-Smtp-Source: AGHT+IERNF6nJP16os1FaKc3/sdXmm8EwNv8eCauOgOToi64bP3nXEDmXCRmFZmrwxC0g1SSj5SgySzC5xDlCsB7Oow=
X-Received: by 2002:a05:651c:214e:b0:32a:5e74:5726 with SMTP id
 38308e7fff4ca-32a5e745900mr27333001fa.38.1748449248922; Wed, 28 May 2025
 09:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com> <202505282330.oOHtt60s-lkp@intel.com>
In-Reply-To: <202505282330.oOHtt60s-lkp@intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 28 May 2025 12:20:12 -0400
X-Gm-Features: AX0GCFtwpZSAhj_4TToLyRo1WFyFxvpTkmyybwSPHteM3wp-9wZFIJXZ0dupnGM
Message-ID: <CAJ-ks9m30hV+OiN3yO5nU47EoVfuBr=OhjS8QHpgBSWcoB4vWw@mail.gmail.com>
Subject: Re: [PATCH] rust: replace length checks with match
To: kernel test robot <lkp@intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:58=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Tamir,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bfc3cd87559bc593bb32bb1482f9cae3308b6398]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/r=
ust-replace-length-checks-with-match/20250528-001121
> base:   bfc3cd87559bc593bb32bb1482f9cae3308b6398
> patch link:    https://lore.kernel.org/r/20250527-idiomatic-match-slice-v=
1-1-34b0b1d1d58c%40gmail.com
> patch subject: [PATCH] rust: replace length checks with match
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/202=
50528/202505282330.oOHtt60s-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250528/202505282330.oOHtt60s-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505282330.oOHtt60s-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    PATH=3D/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin
>    INFO PATH=3D/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cros=
s/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>    /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=3D -Wno-error=3Dretu=
rn-type -Wreturn-type -funsigned-char -Wundef W=3D1 --keep-going LLVM=3D1 -=
j24 -C source O=3D/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=3Dx86_64 S=
HELL=3D/bin/bash rustfmtcheck
>    make: Entering directory '/kbuild/src/consumer'
>    make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust=
'
> >> Diff in scripts/rustdoc_test_gen.rs at line 90:
>                 "No path candidates found for `{file}`. This is likely a =
bug in the build system, or \
>                 some files went away while compiling."
>             ),
>    -        [valid_path] =3D> {
>    -            valid_path.to_str().unwrap()
>    -        }
>    +        [valid_path] =3D> valid_path.to_str().unwrap(),
>             valid_paths =3D> {
>                 eprintln!("Several path candidates found:");
>                 for path in valid_paths {
>    make[2]: *** [Makefile:1826: rustfmt] Error 123
>    make[2]: Target 'rustfmtcheck' not remade because of errors.
>    make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>    make[1]: *** [Makefile:248: __sub-make] Error 2
>    make[1]: Target 'rustfmtcheck' not remade because of errors.
>    make: *** [Makefile:248: __sub-make] Error 2
>    make: Target 'rustfmtcheck' not remade because of errors.
>    make: Leaving directory '/kbuild/src/consumer'

Yep, I already noticed this. Will send v2 with proper formatting.

