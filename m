Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651D7091B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjESIa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjESIa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:30:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF069E52;
        Fri, 19 May 2023 01:30:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643a1fed360so2164634b3a.3;
        Fri, 19 May 2023 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684485054; x=1687077054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+hG6iy80bqSgMH7VGr3vhYMvwvtMpezDygF3zvikaA=;
        b=Jb6ajGyQnjmgZ/0uerlE40XGFd3Ay9CMjGPxuwEXMnbMLaGdlhXANamtUyR4dxvFLp
         3/xYeHAgYn3bIvWS/qGnan61MIGtcZriEIOE4tiECkZH7D+ruDxdJNDRRqqI2C3zBFAd
         QJKHHnHCOecykYBsD8dCqhiN7eQw2Apd1BNK5MEJSTSOeR2pAfjMBWtnEOSwi8+liWlv
         cVN5vroxIX+TJsDKM9LnzCrwsNWksYW2k9r5kcPyHVevi/xUe0/rwHM6r3ql+lr94x4c
         NSysP04jU4cIRJslZnB+q0eGh5SV0W6YNAilHbEDzexk3YVswaoaUiUEswYgvgRB5b9g
         p04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485054; x=1687077054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+hG6iy80bqSgMH7VGr3vhYMvwvtMpezDygF3zvikaA=;
        b=KCqBB5wDME3beUmOZ3Efym+PVXasetDtz6vzehpE+YBPm7jErkR5CHRY2rDlP8j44w
         SWQ5ON+7qgeNDs2SstWA0rke+QNo2hYv9RtsgdBlAFGHHWq866ZrgSiPpKQHI+1So3oU
         sbuFs1L8f6VxIX+PY4lp93/WqyGFAE/3cLu5mWyP847e64SQqELQdJnjF9gnQIBTiQcd
         gr6MyM978Tq/jrg8yz4MXG/Z9NajAyeLfSPNLfH63IhtDh+FOJeneIfnjPMqBjH2GBqE
         GQtSkS4nhVoulzAMR2+DAnNVcGrneIBmgj4drCxBCGaFOkGOQr+H2hmppsse7u7OgyLZ
         mBKA==
X-Gm-Message-State: AC+VfDylNT9SgaOlcROBbFqARBGqWZ0JpOggd//Ont0uleJwo0v8qf5M
        0CPnhOq4OH1l4skMesJI2N8=
X-Google-Smtp-Source: ACHHUZ5Q5NHDENKdyqYnnuOQljMbapkDtEe8OGddKJCTZG7EWD0VCcV9vXIMLkGTeb2AHaGFdFVm/g==
X-Received: by 2002:a17:902:6505:b0:1ac:40f7:8b52 with SMTP id b5-20020a170902650500b001ac40f78b52mr1601646plk.64.1684485054251;
        Fri, 19 May 2023 01:30:54 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ac2be26340sm2818252pld.222.2023.05.19.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 01:30:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BECF51056A0; Fri, 19 May 2023 15:30:48 +0700 (WIB)
Date:   Fri, 19 May 2023 15:30:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Gow <davidgow@google.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Documentation: kunit: Add usage notes for
 kunit_add_action()
Message-ID: <ZGcztwtEvf/c0kGg@debian.me>
References: <20230518083849.2631178-1-davidgow@google.com>
 <20230518083849.2631178-4-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QNlhZ+8rjoCCRHiA"
Content-Disposition: inline
In-Reply-To: <20230518083849.2631178-4-davidgow@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--QNlhZ+8rjoCCRHiA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 04:38:46PM +0800, David Gow wrote:
> +Registering Cleanup Actions
> +---------------------------
> +
> +If you need to perform some cleanup beyond simple use of ``kunit_kzalloc=
``,
> +you can register a cusom "deferred action", which is a cleanup function
> +run when the test exits (whether cleanly, or via a failed assertion).
> +
> +Actions are simple functions with no return value, and a single ``void*``
> +context argument, and forfil the same role as "cleanup" functions in Pyt=
hon
"... fulfill the same role ..."?

> +and Go tests, "defer" statements in languages which support them, and
> +(in some cases) destructors in RAII languages.
> +
> +These are very useful for unregistering things from global lists, closing
> +files or other resources, or freeing resources.
> +
> +For example:
> +
> +.. code-block:: C
> +
> +	static void cleanup_device(void *ctx)
> +	{
> +		struct device *dev =3D (struct device *)ctx;
> +
> +		device_unregister(dev);
> +	}
> +
> +	void example_device_test(struct kunit *test)
> +	{
> +		struct my_device dev;
> +
> +		device_register(&dev);
> +
> +		kunit_add_action(test, &cleanup_device, &dev);
> +	}
> +
> +Note that, for functions like device_unregister which only accept a sing=
le
> +pointer-sized argument, it's possible to directly cast that function to
> +a ``kunit_action_t`` rather than writing a wrapper function, for example:
> +
> +.. code-block:: C
> +
> +	kunit_add_action(test, (kunit_action_t *)&device_unregister, &dev);
> +
> +``kunit_add_action`` can fail if, for example, the system is out of memo=
ry.
> +You can use ``kunit_add_action_or_reset`` instead which runs the action
> +immediately if it cannot be deferred.
> +
> +If you need more control over when the cleanup function is called, you
> +can trigger it early using ``kunit_release_action``, or cancel it entire=
ly
> +with ``kunit_remove_action``.
> +
> =20
>  Testing Static Functions
>  ------------------------

The rest is LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--QNlhZ+8rjoCCRHiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGczrQAKCRD2uYlJVVFO
o/9jAQDrHL35jfTcr1SjBI6FfCy61zx+YCt53C13kD/XIJCcwAEA7U8wmdm73+Rh
MIbRXJdpUi02nfl88HIERDTHo5VFOAw=
=lpla
-----END PGP SIGNATURE-----

--QNlhZ+8rjoCCRHiA--
