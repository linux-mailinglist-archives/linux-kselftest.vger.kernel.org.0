Return-Path: <linux-kselftest+bounces-28497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3BA56D97
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D4117629B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D223BCFF;
	Fri,  7 Mar 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV7mfH7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545A1E1E0B;
	Fri,  7 Mar 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364744; cv=none; b=KN1CG68NryOCveoQJyyTZJz8ql8zxKG+Km72KJ2iilrFkcl/faUZl44lOFnSYb7sUBOPK/0e3BMRQXZTVc1pH/dBGQWi6B3/Kzc6mRb5f2tTRwYVaZ5gQbq2Qi6zs4hB2rBWnR6ruwLkSkzM15CSU64PJCI3HXUwzkQsleymdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364744; c=relaxed/simple;
	bh=giPxlOl7TDridoBWV8RecilAZ2Za0fOPCa3TpMO7LiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPC49r5V/7pSDronRtiSMxMfO3rBeGcUvo7rUfnJ8DeqwNQP8KoA+c64kow+qITuo9hXfP4Abyr4b5BUvRINOJPhpsRIL2KM6kVpIBk9ce5eDvSWTOHpuEpItDrk4R12v2acT6duZle30dum+vmX4SSrsqhZptLomBwaTBIyqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV7mfH7o; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso7386121fa.0;
        Fri, 07 Mar 2025 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364741; x=1741969541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GniiXwrf8dME3pfrOSLg2j3Gf/5JWPlw9dqX608bhBE=;
        b=XV7mfH7ou5I4Hqoz0gLwOI8/fk3z/ofLrfQUw/8aOr3k/VTA7Td3Bj+2XdeDpZzFUJ
         p9EsnTiCxhGzm8b0TmjC40OWwVmU4Rd8xOrm3ETjMPGKUDxuJ+6lkJ+sj6+MAKaObhFB
         fnW4YMt8qLdy9CrWL1gFGwzQi7IylQCQm/NlwUWo61vtHQ4K5I+p9LiwMrHfAp5BvvAf
         pfLnRoaHzjbie2Sj1s7ZDUC3BFJHK6MI4OOGfIPROQWlzXLbx0dIkgh3EAxAEtdZtO8h
         EEnZb1Ud836dNE1t2XQyjIhONPoyzxwXFgCJpZUvZrBv5OJyG3qkja1t8OueNGwkA+GD
         pBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364741; x=1741969541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GniiXwrf8dME3pfrOSLg2j3Gf/5JWPlw9dqX608bhBE=;
        b=lKOpwj8mc7APzr8wYYVuQPZ/nW8OmrM6EGRKnG4CefR33Ns904TUrccAw3Xwjq4ndn
         l3UI72z+ZmENJyQsagmatju+ProH2yOnd+kwNRXMP5QRs8PJe6p695Cuftzh/+Fb5kTK
         BKWYCY5jRSGP3KzGUcLDGti6shvCMC5DXUkwWMB/axPqekeRqzLnQYR9LN1uaaJ8sfYZ
         tfKIZbaWNPIMtzYgM7TSxg27soT8n6Q3a341gxKYeB0Vc6XewriFyLf6ACzSltO2dYLn
         ljQB6Czu/3Kpn/mreb9IaEVrKC2guHc5MSh2yKOiwp3T3U31BpE8e8G2O1nldP3/8axv
         6leQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1dgg3xyAegf/JD8nBqMw8GQzMQxn1dgcfEeXkhNL87PAxOUuWmZDBFmOFBzkTHsmK7UfImCIjpZ5L3EU0qs0p@vger.kernel.org, AJvYcCUMVJfPC7vI9/q59oj925FNw8VuGjF5MDGyznEaxHj3VF1x5+POGjydCK16k44TtJzi9PRS9YPkfofz7GPi@vger.kernel.org, AJvYcCXj5RnNz+tJwOkydW3+ZHLb8hbEK0zsb4pfkWWtUAsKgv3Ctf0YRJ1Vo/lj9ECdLahTPI9Iyc8wZ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VDWah46X+/pNnIaP9ZdNKYP3CZ7QModzxHaaQw3C/XCAetMN
	ckAPAHyZ/w1NdJl7BdJso+/y0jypS8Maj2fPyK2dN0CTZ7h0MLVYO+NlzWX1c06vUuR1iQ62LYD
	bMmkVYOmHnfbNjrkqGnn52fxWx4Y=
X-Gm-Gg: ASbGncvKOQ+yEt3+g5ybtbJVJQyyn+0W3fxQbHbJesyjpMClmdf8al0QiT9hjZZjsCr
	k+AIqycuBVRCaShJwfWboNXWHIH9RRlEO9KaEfGn0txDzhZJgzpwuH9Dl78bDaqPN/44HrIs9gD
	u3/+yl1iNZS4o8q3mHvV3qafJP6jL2PCOEcC8jbQoG6FepWrzyGNNeg5C2tR4p
X-Google-Smtp-Source: AGHT+IEVB3KglQh/9Sn2MMnIIn4pSiWyREt2/PrZgQihsBRdaIE1s+RXe6lakVpGzZy3kRntdwBmJuURZ+hTf4hVYmI=
X-Received: by 2002:a2e:bc16:0:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-30bf44ed6f9mr12793991fa.2.1741364740761; Fri, 07 Mar 2025
 08:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com> <Z8scO-LsAWxdYIfJ@pathway.suse.cz>
In-Reply-To: <Z8scO-LsAWxdYIfJ@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 11:25:04 -0500
X-Gm-Features: AQ5f1JpnB54iyHb2NlPpIPbsEeQBbd1J-Q5YzDRd9TuRGbggczJShE8KVb5vftU
Message-ID: <CAJ-ks9mb5pz4KWN_N-wd0k932bfhSjQuFEsXDrBxj9+RHSNWGA@mail.gmail.com>
Subject: Re: crng init: was: Re: [PATCH v5 2/3] printf: break kunit into test cases
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:18=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2025-02-21 15:34:31, Tamir Duberstein wrote:
> > Move all tests into `printf_test_cases`. This gives us nicer output in
> > the event of a failure.
> >
> > Combine `plain_format` and `plain_hash` into `hash_pointer` since
> > they're testing the same scenario.
> >
> > --- a/lib/tests/printf_kunit.c
> > +++ b/lib/tests/printf_kunit.c
> > @@ -178,7 +179,7 @@ test_number(void)
> >  }
> >
> >  static void
> > -test_string(void)
> > +test_string(struct kunit *kunittest)
> >  {
> >       test("", "%s%.0s", "", "123");
> >       test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456=
");
> > @@ -215,29 +216,6 @@ test_string(void)
> >  #define ZEROS "00000000"     /* hex 32 zero bits */
> >  #define ONES "ffffffff"              /* hex 32 one bits */
> >
> > -static int
> > -plain_format(void)
> > -{
> > -     char buf[PLAIN_BUF_SIZE];
> > -     int nchars;
> > -
> > -     nchars =3D snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
> > -
> > -     if (nchars !=3D PTR_WIDTH)
> > -             return -1;
> > -
> > -     if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) =3D=3D 0) {
> > -             kunit_warn(kunittest, "crng possibly not yet initialized.=
 plain 'p' buffer contains \"%s\"",
> > -                     PTR_VAL_NO_CRNG);
> > -             return 0;
> > -     }
> > -
> > -     if (strncmp(buf, ZEROS, strlen(ZEROS)) !=3D 0)
> > -             return -1;
> > -
> > -     return 0;
> > -}
> > -
> >  #else
> >
> >  #define PTR_WIDTH 8
> > @@ -247,89 +225,44 @@ plain_format(void)
> >  #define ZEROS ""
> >  #define ONES ""
> >
> > -static int
> > -plain_format(void)
> > -{
> > -     /* Format is implicitly tested for 32 bit machines by plain_hash(=
) */
> > -     return 0;
> > -}
> > -
> >  #endif       /* BITS_PER_LONG =3D=3D 64 */
> >
> > -static int
> > -plain_hash_to_buffer(const void *p, char *buf, size_t len)
> > +static void
> > +plain_hash_to_buffer(struct kunit *kunittest, const void *p, char *buf=
, size_t len)
> >  {
> > -     int nchars;
> > -
> > -     nchars =3D snprintf(buf, len, "%p", p);
> > -
> > -     if (nchars !=3D PTR_WIDTH)
> > -             return -1;
> > +     KUNIT_ASSERT_EQ(kunittest, snprintf(buf, len, "%p", p), PTR_WIDTH=
);
> >
> >       if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) =3D=3D 0) {
> >               kunit_warn(kunittest, "crng possibly not yet initialized.=
 plain 'p' buffer contains \"%s\"",
> >                       PTR_VAL_NO_CRNG);
> > -             return 0;
>
> I have simulated the not-yet-initialized crng and got:
>
> [   80.109760] printf_kunit: module verification failed: signature and/or=
 required key missing - tainting kernel
> [   80.114218] KTAP version 1
> [   80.114743] 1..1
> [   80.116124]     KTAP version 1
> [   80.116752]     # Subtest: printf
> [   80.117239]     # module: printf_kunit
> [   80.117256]     1..28
> [   80.120924]     ok 1 test_basic
> [   80.121495]     ok 2 test_number
> [   80.122741]     ok 3 test_string
> [   80.123498]     # hash_pointer: crng possibly not yet initialized. pla=
in 'p' buffer contains "(____ptrval____)"
> [   80.124044]     # hash_pointer: EXPECTATION FAILED at lib/tests/printf=
_kunit.c:256
>                    Expected buf =3D=3D "00000000", but
>                        buf =3D=3D
>                        <28><5f><5f><5f><5f><70><74><72>
>                        "00000000" =3D=3D
>                        <30><30><30><30><30><30><30><30>
> [   80.125888]     not ok 4 hash_pointer
> [   80.129831]     ok 5 null_pointer
> [   80.130253]     ok 6 error_pointer
> [   80.131221]     # invalid_pointer: crng possibly not yet initialized. =
plain 'p' buffer contains "(____ptrval____)"
> [   80.132168]     ok 7 invalid_pointer
> [   80.135149]     ok 8 symbol_ptr
> [   80.136016]     ok 9 kernel_ptr
> [   80.136868]     ok 10 struct_resource
> [   80.137768]     ok 11 struct_range
> [   80.138613]     ok 12 addr
> [   80.139370]     ok 13 escaped_str
> [   80.140054]     ok 14 hex_string
> [   80.140601]     ok 15 mac
> [   80.141162]     ok 16 ip4
> [   80.141670]     ok 17 ip6
> [   80.142221]     ok 18 uuid
> [   80.143090]     ok 19 dentry
> [   80.143963]     ok 20 struct_va_format
> [   80.144523]     ok 21 time_and_date
> [   80.145043]     ok 22 struct_clk
> [   80.145589]     ok 23 bitmap
> [   80.146087]     ok 24 netdev_features
> [   80.146572]     ok 25 flags
> [   80.146980]     # errptr: crng possibly not yet initialized. plain 'p'=
 buffer contains "(____ptrval____)"
> [   80.147412]     ok 26 errptr
> [   80.148548]     ok 27 fwnode_pointer
> [   80.149086]     ok 28 fourcc_pointer
> [   80.149090]     # printf: ran 448 tests
> [   80.149099] # printf: pass:27 fail:1 skip:0 total:28
> [   80.149102] # Totals: pass:27 fail:1 skip:0 total:28
> [   80.149106] not ok 1 printf
>
> =3D> One test failed even though vspritf() worked as expected.
>
>    The "EXPECTATION FAILED" message was a bit tricky because
>    it printed "<28><5f><5f><5f><5f><70><74><72>" instead of "(____ptrval_=
___)".
>
>    Two tests succeeded even after a warning message which would make peop=
le
>    to investigate it.
>
> I suggest to rather skip the test in this case. Something like:
>
>         if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) =3D=3D 0) {
>                 kunit_skip(kunittest,
>                            "crng possibly not yet initialized. plain 'p' =
buffer contains \"%s\"\n",
>                            PTR_VAL_NO_CRNG);
>         }
>
>
> It produces:
>
> [  140.555055] KTAP version 1
> [  140.555413] 1..1
> [  140.555796]     KTAP version 1
> [  140.556115]     # Subtest: printf
> [  140.556450]     # module: printf_kunit
> [  140.556459]     1..28
> [  140.557757]     ok 1 test_basic
> [  140.558072]     ok 2 test_number
> [  140.558693]     ok 3 test_string
> [  140.559278]     ok 4 hash_pointer # SKIP crng possibly not yet initial=
ized. plain 'p' buffer contains "(____ptrval____)"
> [  140.560949]     ok 5 null_pointer
> [  140.561257]     ok 6 error_pointer
> [  140.561880]     ok 7 invalid_pointer # SKIP crng possibly not yet init=
ialized. plain 'p' buffer contains "(____ptrval____)"
> [  140.564159]     ok 8 symbol_ptr
> [  140.565248]     ok 9 kernel_ptr
> [  140.566346]     ok 10 struct_resource
> [  140.567642]     ok 11 struct_range
> [  140.569141]     ok 12 addr
> [  140.570395]     ok 13 escaped_str
> [  140.571407]     ok 14 hex_string
> [  140.572337]     ok 15 mac
> [  140.573572]     ok 16 ip4
> [  140.574712]     ok 17 ip6
> [  140.575743]     ok 18 uuid
> [  140.577164]     ok 19 dentry
> [  140.578248]     ok 20 struct_va_format
> [  140.579400]     ok 21 time_and_date
> [  140.580507]     ok 22 struct_clk
> [  140.581706]     ok 23 bitmap
> [  140.582739]     ok 24 netdev_features
> [  140.583808]     ok 25 flags
> [  140.585274]     ok 26 errptr # SKIP crng possibly not yet initialized.=
 plain 'p' buffer contains "(____ptrval____)"
> [  140.588403]     ok 27 fwnode_pointer
> [  140.592141]     ok 28 fourcc_pointer
> [  140.592758]     # printf: ran 408 tests
> [  140.593219] # printf: pass:25 fail:0 skip:3 total:28
> [  140.593706] # Totals: pass:25 fail:0 skip:3 total:28
> [  140.594280] ok 1 printf
>
> Best Regards,
> Petr

Thanks for testing! I didn't know how to do that. Changed to
kunit_skip as you suggested.

