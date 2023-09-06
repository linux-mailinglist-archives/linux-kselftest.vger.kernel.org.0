Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB3793983
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjIFKIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjIFKIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 06:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CF1981
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693994826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=/RQY8EhQSYV947okEcMf9SCXpiOLyQ4TKDc7ZGfngFs=;
        b=NSyp8QmzmcFH/yw2e/HBg0ACV/uqCLoK4dHVvRMuPnsiVGaSkyVhJ5iCG5LaQRYJeea+gc
        1Ana9zULx1DniKQ1DJuGMpWq7NMndCHfXtQ5V3T+0/p4Gh0wsPlDe7Y64nBDgg0eeasBlw
        FDWLbhZIf/6eH7qsyi3s1KSAAN7Jc5I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-_cT4XLm5OqOtsluE489fYw-1; Wed, 06 Sep 2023 06:07:04 -0400
X-MC-Unique: _cT4XLm5OqOtsluE489fYw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6553ab83954so33380066d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Sep 2023 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994823; x=1694599623;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RQY8EhQSYV947okEcMf9SCXpiOLyQ4TKDc7ZGfngFs=;
        b=cqKCQL9gplaOpYUzgSapPS/YKzXVn+/kG5fDFCiv9HtSOM497LqL/BtdHnoPlQ6Ep+
         /QWnQJiYeJ33QlTWDfYD40kKFbc2qSHc37BrpN/3N2Rx+4QH5BPncp7gdh+fsK+whZpZ
         LaLeerxS3oddV34axGWloHU2jM9yYQKkUqr/Jo1B0ykpHQMOgAm5HTnPMTyfjnD5p5kn
         x4meamBasDIjIQJuQYLdIfLIzELBEVr3PQK07KxyzYLP0ASMJ0WzstPWrbH/8tgT8Tjt
         bQPq6NmHbXbNS7VaEgjjAW+Q/Tbzjyg7ZLStMkoTwr/hhzmi0H/EwuM2/JwnmalRQgU4
         Chbw==
X-Gm-Message-State: AOJu0YwZT7LtD8V9x5ma4UbleIyORqYDnD2ic3ovzs59hf0ygA2FfzFX
        2SElblHQVk1tLe1+8NJ5wbrITv0BanPWkdwaf7bRE+D16PqcWenMhH7oJtYHdVd1XyNzmWmzZ7V
        0ScQcnFqw8G5y7lldEQOplOvtWEMj
X-Received: by 2002:a05:620a:450e:b0:767:d0c:9ec1 with SMTP id t14-20020a05620a450e00b007670d0c9ec1mr18790043qkp.59.1693994823231;
        Wed, 06 Sep 2023 03:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER6lA3GZ2HJx02uZDFzEvMD289KltLM2voUWuDrrPLQUuyA++SmLKTw5IhFvw4+QV3T8+bMw==
X-Received: by 2002:a05:620a:450e:b0:767:d0c:9ec1 with SMTP id t14-20020a05620a450e00b007670d0c9ec1mr18790022qkp.59.1693994822882;
        Wed, 06 Sep 2023 03:07:02 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id oo20-20020a05620a531400b00767f14f5856sm4822652qkn.117.2023.09.06.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:07:02 -0700 (PDT)
Date:   Wed, 6 Sep 2023 12:07:00 +0200
From:   Maxime Ripard <mripard@redhat.com>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [Intel-xe] [PATCH 2/3] drm/tests/drm_exec: Add a test for object
 freeing within drm_exec_fini()
Message-ID: <b5eaqvccx7iitverhenjozczpvgrehcznl2k2c43t6qlnn4sf4@wzkzsntne5mt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b3p2wfg2aaam75px"
Content-Disposition: inline
In-Reply-To: <5d25d6ea-3a96-3be1-3742-7e3c1b417d14@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--b3p2wfg2aaam75px
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:42:58PM +0200, Thomas Hellstr=F6m wrote:
> Hi, Maxime
>=20
> On 9/5/23 15:16, Maxime Ripard wrote:
> > On Tue, Sep 05, 2023 at 02:32:38PM +0200, Thomas Hellstr=F6m wrote:
> > > Hi,
> > >=20
> > > On 9/5/23 14:05, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, Sep 05, 2023 at 10:58:31AM +0200, Thomas Hellstr=F6m wrote:
> > > > > Check that object freeing from within drm_exec_fini() works as ex=
pected
> > > > > and doesn't generate any warnings.
> > > > >=20
> > > > > Cc: Christian K=F6nig <christian.koenig@amd.com>
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Signed-off-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.c=
om>
> > > > > ---
> > > > >    drivers/gpu/drm/tests/drm_exec_test.c | 47 +++++++++++++++++++=
++++++++
> > > > >    1 file changed, 47 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/=
drm/tests/drm_exec_test.c
> > > > > index 563949d777dd..294c25f49cc7 100644
> > > > > --- a/drivers/gpu/drm/tests/drm_exec_test.c
> > > > > +++ b/drivers/gpu/drm/tests/drm_exec_test.c
> > > > > @@ -170,6 +170,52 @@ static void test_prepare_array(struct kunit =
*test)
> > > > >    	drm_gem_private_object_fini(&gobj2);
> > > > >    }
> > > > > +static const struct drm_gem_object_funcs put_funcs =3D {
> > > > > +	.free =3D (void *)kfree,
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Check that freeing objects from within drm_exec_fini()
> > > > > + * behaves as expected.
> > > > > + */
> > > > > +static void test_early_put(struct kunit *test)
> > > > > +{
> > > > > +	struct drm_exec_priv *priv =3D test->priv;
> > > > > +	struct drm_gem_object *gobj1;
> > > > > +	struct drm_gem_object *gobj2;
> > > > > +	struct drm_gem_object *array[2];
> > > > > +	struct drm_exec exec;
> > > > > +	int ret;
> > > > > +
> > > > > +	gobj1 =3D kzalloc(sizeof(*gobj1), GFP_KERNEL);
> > > > > +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, gobj1);
> > > > > +	if (!gobj1)
> > > > > +		return;
> > > > > +
> > > > > +	gobj2 =3D kzalloc(sizeof(*gobj2), GFP_KERNEL);
> > > > > +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, gobj2);
> > > > > +	if (!gobj2) {
> > > > > +		kfree(gobj1);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	gobj1->funcs =3D &put_funcs;
> > > > > +	gobj2->funcs =3D &put_funcs;
> > > > > +	array[0] =3D gobj1;
> > > > > +	array[1] =3D gobj2;
> > > > > +	drm_gem_private_object_init(priv->drm, gobj1, PAGE_SIZE);
> > > > > +	drm_gem_private_object_init(priv->drm, gobj2, PAGE_SIZE);
> > > > > +
> > > > > +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> > > > > +	drm_exec_until_all_locked(&exec)
> > > > > +		ret =3D drm_exec_prepare_array(&exec, array, ARRAY_SIZE(array),
> > > > > +					     1);
> > > > > +	KUNIT_EXPECT_EQ(test, ret, 0);
> > > > > +	drm_gem_object_put(gobj1);
> > > > > +	drm_gem_object_put(gobj2);
> > > > > +	drm_exec_fini(&exec);
> > > > It doesn't look like you actually check that "freeing objects from
> > > > within drm_exec_fini() behaves as expected." What is the expectation
> > > > here, and how is it checked?
> > > Hm. Good question, I've been manually checking dmesg for lockdep spla=
ts. Is
> > > there a way to automate that?
> > I'm not familiar with the drm_exec API, but judging by the code I'd
> > assume you want to check that gobj1 and gobj2 are actually freed using
> > kfree?
>=20
> Actually not. What's important here is that the call to drm_exec_fini(),
> which puts the last references to gobj1 and gobj2 doesn't trigger any
> lockdep splats, like the one in the commit message of patch 3/3. So to ma=
ke
> more sense, the test could perhaps be conditioned on
> CONFIG_DEBUG_LOCK_ALLOC. Still it would require manual checking of dmesg()
> after being run.

I'm not aware of something to check on lockdep's status when running a
kunit test, but I'm not sure anyone is expected to look at the dmesg
trace when running kunit to find out whether the test succeeded or not.

It looks like there was an attempt at some point to fail the test if
there was a lockdep error:
https://lore.kernel.org/all/20200814205527.1833459-1-urielguajardojr@gmail.=
com/

It doesn't look like it's been merged though. David, Brendan, do you
know why it wasn't merged or if there is a good option for us there?

At the very least, I think a comment after the call to drm_exec_fini to
make it clear that the error would be in the kernel logs, and a better
one on the test definition to explicitly say what you want to make sure
of, and how one can check it's been done would be great.

Maxime

--b3p2wfg2aaam75px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPhPRAAKCRDj7w1vZxhR
xfKrAP9GJQ9krwMWKBfn+oS/xcJcENfMR2hgY8v24XvFjdc2tQD8CrK6MAaFADhH
vRBoO3UJcLAhsnt7EihZYwy1JZ/tGws=
=xOIu
-----END PGP SIGNATURE-----

--b3p2wfg2aaam75px--

