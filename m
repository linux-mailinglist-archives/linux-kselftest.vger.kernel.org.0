Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265B646C68
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHKHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 05:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLHKHO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 05:07:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB59537C9;
        Thu,  8 Dec 2022 02:07:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so814017pgh.4;
        Thu, 08 Dec 2022 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azH8vhU54GosLh7lwHUracVYJc2QuzVFmCokYEdpuKk=;
        b=cRa07z0qLNahcn2gcM9CaS5oBzSUQpWuhiBwerSzQL+V4dFZZ82bYj0Qy2DOvNePiy
         QXt4ZQbTFN+UxYryuKuXt5TjadRCMo1KhVKPp3y9sKjGlTbLg7xcQywHMhX4Q2hl/2Bq
         z9UPuA2BgWPRSYmm6iZGEe2gMh0bk+BJV3xWitWevsII0Aff9uklZHke/pRn89Qg7qVt
         C+Yedc11osnH5OBEzWj3/g0g0D4PY4NaAO6kqrpCHlg1+MDlIl9HUPphfj6EVrrux8ak
         ta0OvwJTNkpxwrO42K9Sd37Nr360o+B5KUaeQtfUJ+1IX66AvyR4dZHmUFAjJsLJBfVh
         8Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azH8vhU54GosLh7lwHUracVYJc2QuzVFmCokYEdpuKk=;
        b=kIc3Cfw6sJieaVltCt0Gf5+oVkz83ndP3PQVkO4YGjkxyD1GEKQqN9ziW+zjrBTjPt
         gT9d9TdAfEvhMSA/C1ydU44zpIEYxrtXK+gLCIuhAfGhiOg9L3Bk6e9iGyU0bg+CjGHo
         +pKVKxXtRAbhVHelvI+WGUXnm59eM611FtM/gvIkGkDXlT6IWrmIn2Eq25QzEwDP1JGE
         0O+P1h+Vkr/EBpHRkKgaMY0qYojJ1qv5Q6xHCkag80BntUy5dWgp65FSZP9mEz4Y9OEa
         7g4eRNshti8Nv0mc+4+W6W2FLgEMDipelqF02jwjtVmHFDb/ybYWuWCA2amtNsIA0Al5
         CieA==
X-Gm-Message-State: ANoB5plCf3tDkNkVMUl613YY3XnyJ4EHpzyEoGBluVsMQTSRYNlYM1mP
        34mXnnq2JjEQ0tJa5xOmN8o=
X-Google-Smtp-Source: AA0mqf6SVpF926Fsz2vwiTZjxtt4SS8JuW/eiU+4U6tuBet8aOM/vVXu4CgLqvK3nmex1Hmd8TKG3A==
X-Received: by 2002:a62:1792:0:b0:56b:e975:cf98 with SMTP id 140-20020a621792000000b0056be975cf98mr78781249pfx.63.1670494032361;
        Thu, 08 Dec 2022 02:07:12 -0800 (PST)
Received: from debian.me (subs03-180-214-233-1.three.co.id. [180.214.233.1])
        by smtp.gmail.com with ESMTPSA id p128-20020a62d086000000b00574db8ca00fsm7765499pfg.185.2022.12.08.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:07:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5209A104652; Thu,  8 Dec 2022 17:07:05 +0700 (WIB)
Date:   Thu, 8 Dec 2022 17:07:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: Add Function Redirection API docs
Message-ID: <Y5G3SVt+oQvLjW1e@debian.me>
References: <20221208061841.2186447-1-davidgow@google.com>
 <20221208061841.2186447-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qj61xjsUlsZVQwL+"
Content-Disposition: inline
In-Reply-To: <20221208061841.2186447-3-davidgow@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Qj61xjsUlsZVQwL+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2022 at 02:18:41PM +0800, David Gow wrote:
> From: Sadiya Kazi <sadiyakazi@google.com>
>=20
> Added a new page (functionredirection.rst) that describes the Function
> Redirection (static stubbing) API. This page will be expanded if we add,
> for example, ftrace-based stubbing.

s/Added/Add

> diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/=
Documentation/dev-tools/kunit/api/functionredirection.rst
> new file mode 100644
> index 000000000000..fc7644dfea65
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/api/functionredirection.rst
> @@ -0,0 +1,162 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Function Redirection API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When writing unit tests, it's important to be able to isolate the code b=
eing
> +tested from other parts of the kernel. This ensures the reliability of t=
he test
> +(it won't be affected by external factors), reduces dependencies on spec=
ific
> +hardware or config options (making the test easier to run), and protects=
 the
> +stability of the rest of the system (making it less likely for test-spec=
ific
> +state to interfere with the rest of the system).

Test reliability is test independence, right?

> +
> +While for some code (typically generic data structures, helpers, and toh=
er
> +"pure function") this is trivial, for others (like device drivers, files=
ystems,
> +core subsystems) the code is heavily coupled with other parts of the ker=
nel.
> +
> +This often involves global state in some way: be it global lists of devi=
ces,
> +the filesystem, or hardware state, this needs to be either carefully man=
aged,
> +isolated, and restored, or avoided altogether by replacing access to and
> +mutation of this state with a "fake" or "mock" variant.

"... or hardware state; this needs ..."

> +
> +This can be done by refactoring the code to abstract out access to such =
state,
> +by introducing a layer of indirection which can use or emulate a separat=
e set of
> +test state. However, such refactoring comes with its own costs (and unde=
rtaking
> +significant refactoring before being able to write tests is suboptimal).
> +
> +A simpler way to intercept some of the function calls is to use function
> +redirection via static stubs.
> +
> +
> +Static Stubs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Static stubs are a way of redirecting calls to one function (the "real"
> +function) to another function (the "replacement" function).
> +
> +It works by adding a macro to the "real" function which checks to see if=
 a test
> +is running, and if a replacement function is available. If so, that func=
tion is
> +called in place of the original.
> +
> +Using static stubs is pretty straightforward:
> +
> +1. Add the KUNIT_STATIC_STUB_REDIRECT() macro to the start of the "real"
> +   function.
> +
> +   This should be the first statement in the function, after any variable
> +   declarations. KUNIT_STATIC_STUB_REDIRECT() takes the name of the
> +   function, followed by all of the arguments passed to the real functio=
n.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +	void send_data_to_hardware(const char *str)
> +	{
> +		KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> +		/* real implementation */
> +	}
> +
> +2. Write one or more replacement functions.
> +
> +   These functions should have the same function signature as the real f=
unction.
> +   In the event they need to access or modify test-specific state, they =
can use
> +   kunit_get_current_test() to get a struct kunit pointer. This can then
> +   be passed to the expectation/assertion macros, or used to look up KUn=
it
> +   resources.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +	void fake_send_data_to_hardware(const char *str)
> +	{
> +		struct kunit *test =3D kunit_get_current_test();
> +		KUNIT_EXPECT_STREQ(test, str, "Hello World!");
> +	}
> +
> +3. Activate the static stub from your test.
> +
> +   From within a test, the redirection can be enabled with
> +   kunit_activate_static_stub(), which accepts a struct kunit pointer,
> +   the real function, and the replacement function. You can call this se=
veral
> +   times with different replacement functions to swap out implementation=
s of the
> +   function.
> +
> +   In our example, this would be
> +
> +   .. code-block:: c
> +
> +        kunit_activate_static_stub(test,
> +                                   send_data_to_hardware,
> +                                   fake_send_data_to_hardware);
> +
> +4. Call (perhaps indirectly) the real function.
> +
> +   Once the redirection is activated, any call to the real function will=
 call
> +   the replacement function instead. Such calls may be buried deep in the
> +   implementation of another function, but must occur from the test's kt=
hread.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +        send_data_to_hardware("Hello World!"); /* Succeeds */
> +        send_data_to_hardware("Something else"); /* Fails the test. */
> +
> +5. (Optionally) disable the stub.
> +
> +   When you no longer need it, the redirection can be disabled (and henc=
e the
> +   original behaviour of the 'real' function resumed) using
> +   kunit_deactivate_static_stub(). If the stub is not manually deactivat=
ed, it
> +   will nevertheless be disabled when the test finishes.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +        kunit_deactivate_static_stub(test, send_data_to_hardware);
> +
> +
> +It's also possible to use these replacement functions to test to see if a
> +function is called at all, for example:
> +
> +.. code-block:: c
> +
> +	void send_data_to_hardware(const char *str)
> +	{
> +		KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> +		/* real implementation */
> +	}
> +
> +	/* In test file */
> +	int times_called =3D 0;
> +	void fake_send_data_to_hardware(const char *str)
> +	{
> +		/* fake implementation */
> +		times_called++;
> +	}
> +	...
> +	/* In the test case, redirect calls for the duration of the test */
> +	kunit_activate_static_stub(test, send_data_to_hardware, fake_send_data_=
to_hardware);
> +
> +	send_data_to_hardware("hello");
> +	KUNIT_EXPECT_EQ(test, times_called, 1);
> +
> +	/* Can also deactivate the stub early, if wanted */
> +	kunit_deactivate_static_stub(test, send_data_to_hardware);
> +
> +	send_data_to_hardware("hello again");
> +	KUNIT_EXPECT_EQ(test, times_called, 1);
> +
> +
> +
> +API Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/kunit/static_stub.h
> +   :internal:
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/=
dev-tools/kunit/api/index.rst
> index 45ce04823f9f..2d8f756aab56 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -4,17 +4,24 @@
>  API Reference
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  .. toctree::
> +	:hidden:
> =20
>  	test
>  	resource
> +	functionredirection
> =20
> -This section documents the KUnit kernel testing API. It is divided into =
the
> +
> +This page documents the KUnit kernel testing API. It is divided into the
>  following sections:
> =20
>  Documentation/dev-tools/kunit/api/test.rst
> =20
> - - documents all of the standard testing API
> + - Documents all of the standard testing API
> =20
>  Documentation/dev-tools/kunit/api/resource.rst
> =20
> - - documents the KUnit resource API
> + - Documents the KUnit resource API
> +
> +Documentation/dev-tools/kunit/api/functionredirection.rst
> +
> + - Documents the KUnit Function Redirection API

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--Qj61xjsUlsZVQwL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5G3QQAKCRD2uYlJVVFO
o7d9AP9hdicMpUSxiGamNuKbr1vGWMZHglVBa3X8VEbpOEOEAAD9Hb7THLpE/FPT
Hbhs1yr+LPO498vT2Ks4MJJFMP+UKQk=
=tRls
-----END PGP SIGNATURE-----

--Qj61xjsUlsZVQwL+--
