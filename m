Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC05784BEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHVVTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHVVTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 17:19:08 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC5187;
        Tue, 22 Aug 2023 14:19:06 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c11d53221cso3211929fac.2;
        Tue, 22 Aug 2023 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692739146; x=1693343946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QhSveUjFRzvbJU6tcbAhse1vUw7fPnNXtA2uAa/rMA=;
        b=qIUyYszHLUZcW2OKsfDF+dzMqEhUCeh80QBC3PMO7XI7SNozglQEm5xcI2ZeEldTAv
         qDl4Fh1AFGQZRoqz0xRf1e34ExTn3vnOc1OviGk+Zxj8Yp2u1exYErEmKwkVayQql9hC
         is6OEY3HcbSYjIKXWzEibfmJfW4od51K2+LWYbjGEXjfp1i2CVMfZKFY7Aoa7yVCLbo7
         hMV0Eo060XabIUg+s5bApOrxFXJbRYp5mYzWugANFlShkROofqlrGOKhhgMlla0S6k9q
         fYH0O8OMtAmmnYO28eEcRvwtKZYaqT6u659DZtakBdY5Be9Z3N3CSx+w5D/uFrapJrfl
         2I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739146; x=1693343946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QhSveUjFRzvbJU6tcbAhse1vUw7fPnNXtA2uAa/rMA=;
        b=lt9UyoDO3CSTzf5zUtMB0bmzxuvwd8Sp9ImazcTKguAgFECvTdu+ZUdFPU2HI8iRlF
         jWVJ+zFAdKLtowu2xVGz7xMuiokQMx3FJX0zlIPU5RTY9iaSVpu7Sa9fX1/ywb/7A0jG
         JtueVWMT1eIxunws670FbBgWKcsRcd6eMfqeVTh05cOKEhd+rsj+pwc7pC+3TFAPwT3u
         gJn2708oHn2/Ncs/RizUWgZfZ+PhGYHLr0suvjQIJxhQy6D36jGs/E0FXfMOdh/ehGHm
         Q0OcWgAlwutPbvQx1o6rmueLCJeHXSUkWWZiYr8zsJUpPlAb/R14KOmpj/hFi9LfGiHp
         k7Xg==
X-Gm-Message-State: AOJu0YyCge3JK6PUUBU5gGI6yipAgb5OUTEY9MCpkarHEMw6S95Z59vJ
        PGkt82nNCACuWHP+qtBgv94=
X-Google-Smtp-Source: AGHT+IH9ARwrK7Hw//4wT+MQqCnHM3I0jA6XZg97anoJAG2e950XptF80owYzz3XYMGYzqQ7X6J85Q==
X-Received: by 2002:a05:6870:f10f:b0:1be:e066:acc with SMTP id k15-20020a056870f10f00b001bee0660accmr13068411oac.50.1692739145693;
        Tue, 22 Aug 2023 14:19:05 -0700 (PDT)
Received: from debian.org ([168.227.196.240])
        by smtp.gmail.com with ESMTPSA id c5-20020a05687091c500b001b03e0c0970sm6125210oaf.2.2023.08.22.14.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:19:04 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:19:14 -0300
From:   Ricardo Marliere <rbmarliere@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: make LDLIBS consistent
Message-ID: <20230822211914.nxc3fzxcpgpxyepg@debian.org>
References: <20230822131544.38152-1-rbmarliere@gmail.com>
 <2fd85cbe-9909-4200-be38-450d4c57425b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tbfghwmrzlagbpi6"
Content-Disposition: inline
In-Reply-To: <2fd85cbe-9909-4200-be38-450d4c57425b@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--tbfghwmrzlagbpi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 03:05:27PM +0100, Mark Brown wrote:
> This seems like an undocumented bodge for whatever limitation the
> checker script has.  If nothing else someone might come along later and
> switch back to using the standard variable name, and TBH it does feel
> like it'd be better to teach the checker to understand the pkg-config
> idiom here.

I agree, I submitted a patch to fix the checker script.

Thank you Mark


--=20
Ricardo Marliere	    https://marliere.net/
030A 8E9E 424E E3C0 6557 87E1 C90B 8A7C 6386 58A6

--tbfghwmrzlagbpi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEAwqOnkJO48BlV4fhyQuKfGOGWKYFAmTlJk8ACgkQyQuKfGOG
WKYb7hAAqwAsFLsCv615f3KEbWQXUkDllrKdvhGip1ZKDOJWtjA0k+GomFgO3VaG
zdoswCgIzbaCPPI7AO/CtCqFJrFZOTx9/23FLOC6XKgAxGOZMJaoWeg/D+1DeFkw
nnT6UJJDEsQ15KnNMGhJnXOskVnKWdG1pVrq6O+16Tk71oWJnLB07SFLKFCbsySB
21LDe+FGDia5xzUbD7Y8vC5QI+2OLPWb1dIViJVWao3do6sGsOJnSACRp1G+MpFs
qqYf69M/tD1VoPzpEBTUfrjHXCWFrZJizoOgzLFrZDexZIg672GyG0QX8Bs/HAUu
KU4LIRMGBstygvLiEzk+5B+1hBt6Q9H1HtqTo7MKetTL7BQG+r8QHGHILuldT8kb
CbH+JcQSsSNPUPlGc288MI7PL60iF0tH0nqzyb3wGlJ8zEOlhCWNTH55f1+3L5JA
7R1142H5g/V2IkDkAeakvrTWYa06pzrfYk61l4mOBerxaMHr6snWaVsIBnVVrUv/
SRKE4JoXnS5s+nDrfghI6TqRGKViSqVBQ5kcmjRiVhrB43/doOXjaAwK+n5BxgtN
kxxEtB/faMTQqOkDUU9lOaGL0KPTP2CmC1Cw4imEueteHI47EhYoDMEFDy3TSln4
N/ltUZ9jhuODs4g0zR7YdbIClaZGgsIUW6tfDeQ5OzIbHKhdWX0=
=tALc
-----END PGP SIGNATURE-----

--tbfghwmrzlagbpi6--
