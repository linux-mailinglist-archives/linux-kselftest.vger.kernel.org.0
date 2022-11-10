Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55763623AE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 05:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiKJEKi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 23:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiKJEKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 23:10:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5331FA3;
        Wed,  9 Nov 2022 20:09:35 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o13so600892pgu.7;
        Wed, 09 Nov 2022 20:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WskVOImJZNx90wFjb/aNKvdlnfoFwNZVW3UipbyhnFE=;
        b=C1F8CS/GA+Eh79VmaKocXQuf2YEEfFg7i4a2vzHekUiGOe8Aaeee6AH6NcEdXxB1B1
         hsZMcoOy06X54kAavGnbQcbWtlfqUE6SFqiCa2VjpKZwE7gyr3MKSbTM3pJUWB0+qS6R
         /kSVdS6Fj2tIZUvZAD8AMPY0ApDwHnY2RFtuRfSX3edmI9MbMDE1r92Yle89zpSiQ1q6
         H4BZVNtkwyVkuZILnWG/i6Tvig95hDzZu1oAlwqDFpKmnBhfQegHDcqUr3qXLeZnWraZ
         7loA7K8gzS516rh0xkKgPtw7n9hHYmmzpxuTukO/lECveM3IUieaiFdAZ/P4rLmb8vp+
         pTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WskVOImJZNx90wFjb/aNKvdlnfoFwNZVW3UipbyhnFE=;
        b=aI4MqBbxhHX5PMA/HpEPYn4urD+1y+gYjwNYf/T8sjSBY6xqtrZYi98fdEc4zZRoYp
         l4cXZ2e6W/iEYfK/T2CBvPtYKjQyTLf7npLYLYkzqSaY/w7uI5aKSBKT7CnarHoF9f+K
         N3+bUv/Ic8RI0SsN8B3rFbqrmQ5afDdTTxRpuTZ0oB+2GdcdJXWST5qXJeBUXzJcFJXD
         oImJx3uUqVFeKK0UWXsvpIMeonI20MsI+ekQ3eaICRaekqsqMOH1Qt1W6AHNziTj0rRk
         f239KykFwkmU+vp/cM1joxJXPmHtze9He4Di08Yt4g/xri5OS3NQFZfXbcB22jrKaVN2
         2dUA==
X-Gm-Message-State: ANoB5plnp8K0VvaEqz7xJxVz/ii5f14ntIAubwG59v4n5PWJwbOZ4KWV
        f1X7yLkQRyZ3rJfvD6qzz3A=
X-Google-Smtp-Source: AA0mqf7dkW08NMq9EBbh2alcYP0V/5nBgBY9oX3TvR26GjYIUe4reWG1WA1r1sRo5C6s8jiyAkWqiw==
X-Received: by 2002:a63:ef12:0:b0:470:862e:ad2a with SMTP id u18-20020a63ef12000000b00470862ead2amr11374033pgh.470.1668053374931;
        Wed, 09 Nov 2022 20:09:34 -0800 (PST)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902768700b00186b549cdc2sm9923551pll.157.2022.11.09.20.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:09:34 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AE254103F55; Thu, 10 Nov 2022 11:09:30 +0700 (WIB)
Date:   Thu, 10 Nov 2022 11:09:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Subject: Re: [PATCH RESEND 0/7] KUnit documentation rewording
Message-ID: <Y2x5emMB6opN5Mlx@debian.me>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2IAzyiGk8CMOMEah"
Content-Disposition: inline
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--2IAzyiGk8CMOMEah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 23, 2022 at 08:08:40PM +0700, Bagas Sanjaya wrote:
> Hi everyone, sorry for quickly resending this patch series due to
> duplicated patch [7/7] sent as result of amending the corresponding
> commit.
>=20
> The proses written in KUnit documentation are IMO incomprehensible (my
> brain has to process what the meaning of words used) and different from
> wordings that I normally read from technical writings. Thus, rewrite these
> using clearer words.
>=20
> Anyway, it's great to see native English speakers help reviewing this
> series.
>=20
> The first two patches are v3 of rewriting "Writing Your First Test"
> section of "Getting Started" patch [1], which was submitted about a
> month ago. The rest are actual documentation rewriting.
>=20
> Note that this series only rewrites intro, test writing and running docs.
>=20
> [1]: https://lore.kernel.org/lkml/20220929132549.56452-1-bagasdotme@gmail=
=2Ecom/
>=20

ping


--2IAzyiGk8CMOMEah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2x5dgAKCRD2uYlJVVFO
o2eaAP93Zz1AtML2RdwzrudpDIVJvJrKYjlJ0z1SYzK2vamYhAEAidIAw/2EhAnS
/5PMzOMF3qAWU+EEvbclMSmph7gAIwU=
=GH4c
-----END PGP SIGNATURE-----

--2IAzyiGk8CMOMEah--
