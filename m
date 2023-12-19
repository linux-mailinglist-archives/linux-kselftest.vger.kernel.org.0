Return-Path: <linux-kselftest+bounces-2245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE98819442
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 00:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43915288178
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57363B190;
	Tue, 19 Dec 2023 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Abku/Gk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB63D0AE
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so1858a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703026899; x=1703631699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJBKIVMxwZw2B/0wRnInm6AhoZ+wrkkWV1uAdEbTnzk=;
        b=0Abku/GkVyr5XL2raqIIZ1Dxk+/90pFJFIsjfG0yYdzENMDN0GaflT2vFbhqEH7m9B
         CbE8S5mrjt8IeKGj4sBmWP3InbOHuFxxahg/fT8lrW0sEm/cq4WzLNBDs6GvuCOEU8BE
         Z0saMzk51JOlWsT5clszgm8oUorw0+z9F/KEY0pCISiYFIe6IyHiSB2/PIDgCOiJWQ6s
         Pp69r5lTILwT3Gv8LZhzNOPDAEVTxI5mPW8+dTvR5j/txoRaFYEfLXj0rdl2uxhX2EAN
         27+W4GLlSwRjce4Y+hrT9psYsfWyhN8kwN6xvv2MVrvfRA2ZciIiT0uQLs9l1aAxagtN
         btFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703026899; x=1703631699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJBKIVMxwZw2B/0wRnInm6AhoZ+wrkkWV1uAdEbTnzk=;
        b=rHqXbV10cV1o3fGrMpji86u0RnraH9/HR4cTFG0AOyJ16JaOg6JkdYTK/Zs/cU1Igf
         I/Bmsfv0Q9tO/rJosBWub/5NujqEEK+YN0EkGRjwKRxJ2qSsOvp6xFzMg038lXATAEpy
         th3M6lS14BJelGZcXHF8e/s9lgOPTTg07NZFF44SeBKWT0/yOcm9V+Y7ivUGpf1aeao1
         dAfMyHKN3jm2C5yVLWeJC5jgpZ7FJ1+JTxDXLraYuaP11gdwnsZvUGMSBxP4txkbh4XC
         oJ2NRnZg0jIKAUmo8s02lnw09GWGvfWL2evTpml2ipoVbn5Hq6UO2WM4Hh64mddfHqcO
         PYEw==
X-Gm-Message-State: AOJu0YxEEKIbB4fXZekY0XRKUbAthWc5jyaP4rxmArhAszdtzfi21llb
	RrF2rV/UHhesjUWsipBzGwedYZ8vYSKKByAozOceUnzzjQ25
X-Google-Smtp-Source: AGHT+IEnD16yDeBoH8vHeGXt/po5r40RhLX0x2wLWPJ3Qs9KkumHHID3+syMZCqvIBy1lxwwX9jr69q2YeA2+74v3Og=
X-Received: by 2002:a50:c11a:0:b0:553:6de7:43d7 with SMTP id
 l26-20020a50c11a000000b005536de743d7mr41886edf.6.1703026899366; Tue, 19 Dec
 2023 15:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218161044.215640-1-rf@opensource.cirrus.com>
In-Reply-To: <20231218161044.215640-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 19 Dec 2023 18:01:27 -0500
Message-ID: <CA+GJov4nSo0Zh7p7CA63Jame-+Y88zRyFqRy_=ezW2wYykjXeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Allow passing function pointer to kunit_activate_static_stub()
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:10=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Swap the arguments to typecheck_fn() in kunit_activate_static_stub()
> so that real_fn_addr can be either the function itself or a pointer
> to that function.
>
> This is useful to simplify redirecting static functions in a module.
> Having to pass the actual function meant that it must be exported
> from the module. Either making the 'static' and EXPORT_SYMBOL*()
> conditional (which makes the code messy), or change it to always
> exported (which increases the export namespace and prevents the
> compiler inlining a trivial stub function in non-test builds).
>
> With the original definition of kunit_activate_static_stub() the
> address of real_fn_addr was passed to typecheck_fn() as the type to
> be passed. This meant that if real_fn_addr was a pointer-to-function
> it would resolve to a ** instead of a *, giving an error like this:
>
>    error: initialization of =E2=80=98int (**)(int)=E2=80=99 from incompat=
ible pointer
>    type =E2=80=98int (*)(int)=E2=80=99 [-Werror=3Dincompatible-pointer-ty=
pes]
>    kunit_activate_static_stub(test, add_one_fn_ptr, subtract_one);
>       |                             ^~~~~~~~~~~~
>    ./include/linux/typecheck.h:21:25: note: in definition of macro
>    =E2=80=98typecheck_fn=E2=80=99
>    21 | ({ typeof(type) __tmp =3D function; \
>
> Swapping the arguments to typecheck_fn makes it take the type of a
> pointer to the replacement function. Either a function or a pointer
> to function can be assigned to that. For example:
>
> static int some_function(int x)
> {
>     /* whatever */
> }
>
> int (* some_function_ptr)(int) =3D some_function;
>
> static int replacement(int x)
> {
>     /* whatever */
> }
>
> Then:
>   kunit_activate_static_stub(test, some_function, replacement);
> yields:
>   typecheck_fn(typeof(&replacement), some_function);
>
> and:
>   kunit_activate_static_stub(test, some_function_ptr, replacement);
> yields:
>   typecheck_fn(typeof(&replacement), some_function_ptr);
>
> The two typecheck_fn() then resolve to:
>
>   int (*__tmp)(int) =3D some_function;
> and
>   int (*__tmp)(int) =3D some_function_ptr;
>
> Both of these are valid. In the first case the compiler inserts
> an implicit '&' to take the address of the supplied function, and
> in the second case the RHS is already a pointer to the same type.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

This seems fine to me. I have tested it and the reasoning behind this
seems sensible. However, let's see what David thinks when he returns
to office as he is the expert on static stubbing.

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  include/kunit/static_stub.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> index 85315c80b303..bf940322dfc0 100644
> --- a/include/kunit/static_stub.h
> +++ b/include/kunit/static_stub.h
> @@ -93,7 +93,7 @@ void __kunit_activate_static_stub(struct kunit *test,
>   * The redirection can be disabled again with kunit_deactivate_static_st=
ub().
>   */
>  #define kunit_activate_static_stub(test, real_fn_addr, replacement_addr)=
 do {  \
> -       typecheck_fn(typeof(&real_fn_addr), replacement_addr);           =
       \
> +       typecheck_fn(typeof(&replacement_addr), real_fn_addr);           =
       \
>         __kunit_activate_static_stub(test, real_fn_addr, replacement_addr=
);     \
>  } while (0)
>
> --
> 2.30.2
>

