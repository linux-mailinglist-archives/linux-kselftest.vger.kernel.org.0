Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5F637B04
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKXOEA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 09:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiKXODf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 09:03:35 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548C11E829;
        Thu, 24 Nov 2022 06:01:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 10C032B06842;
        Thu, 24 Nov 2022 09:01:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 24 Nov 2022 09:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669298466; x=
        1669305666; bh=4jIAn2lueWeOwVkOG/WC5OUeXxRyuqGWxy80FbSFYkU=; b=e
        qE3tHPPtqSf2ZlRLKRvMe8490eUorbxIPbR0H4ULV8nQghhKqp5ss/9vTme8mymX
        Wa3py471Rdh+fPeIAzMVkoQl6aeMBnfzjwQFfmit3QF0c0tpDpOImZXbCmkvYpqH
        0Mgh+v2jXIpsIhJ2kuRbfTwJ5OpmdaDdnugMwWgjP6RbGOcH0dKgu0q2txkgDEUA
        YvcogazJb1A/8UAuHke2hu4dbEfN+BJz7QoK/h3OPExqr19VR7oXa8bfSl+2eu+E
        8nw3hafR0oekv2iU1RwuNptkZycN/KvvC6RTAtHTDLBJHUrk8tG3RAf/NETJwYbu
        3+DqHJoEWbVAyFO9ceiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669298466; x=
        1669305666; bh=4jIAn2lueWeOwVkOG/WC5OUeXxRyuqGWxy80FbSFYkU=; b=l
        T/mRiRFHe9A8a30ZwTwRCn7Atjq0eCn00PtFaChL5BXbD1p2ENm1wDe21wcAksFs
        auGh1enyGhzlnelBo3eNDJ/uOpMX9J7tZYgRt/nAPlONro6RUYbhccaaXtzH1JCS
        tNomDb+/7p9NVkzhX4q4xrvcnHo3rSKNvC8Kqv2dvMeP72TG8Hi33RrYo4iPlVQf
        0Rw+qlK9SEYrojPSnFEOOZmhPRDc/BVN6IsGgOp6x0Q3Q1tqvCZUTKZh2VdD5yYX
        Uiz8Mf5s8/XhZDbZ8ZnTIPD8A7UDSKlBTXyNx8tHLlINbYpknGbuveNLDrkXeTPl
        QZ1nWcu2JE5j3/iErJSYw==
X-ME-Sender: <xms:IXl_Y8j8Pe5Kk__SG2mhP6Ann5BycT9QheZVDYH0GgCUUz1-S3PoIw>
    <xme:IXl_Y1Bt1uFmB6JyuOfMwn6vEA3YAiWsGT7JkPaH5ohuANNBfvlK25MaXKQTtlgJr
    janSOgWnauP2n6XCWU>
X-ME-Received: <xmr:IXl_Y0HDout03brAXwQ6rGHhIWie8H1A4aEUjHEsrRDck1m_dtNePnHLK1fnb2v4QWzN6-8JB5qZ1R4k2NU_cCLPtXy8gV0PZJWQWbOKeB_Yyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieefgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeitdeuffevieeufedtuddvffffffegfffgkeeihfelleektdelhfevhfdu
    udfhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:IXl_Y9T0iDI5dOBpGDqiUte33CYb-6DYmvKVj6GMWZvMZq_q6Slzgg>
    <xmx:IXl_Y5x6-leO15H1x3BYXERG-NZ1OIul1ZuFOsSHXaUf-ev4qS7_oA>
    <xmx:IXl_Y774hFD8EI4QojFjc2Ebo_3IkTfGg2cRx-NYbi3kHg_rZ6DQ7g>
    <xmx:Inl_Yy9vQHMkcwqNo4mOrRhHdbYgg7s5FDAU5jV92omxMq0_BXkDnnVR5m8>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Nov 2022 09:01:04 -0500 (EST)
Date:   Thu, 24 Nov 2022 15:01:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        linux-media@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 00/24] drm: Introduce Kunit Tests to VC4
Message-ID: <20221124140103.saf2fyal75dscoot@houat>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <CABVgOSmtiPMd+GB40_o=eDPg3cKVA3qPNbbYFoRJvJRxQBDj5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSmtiPMd+GB40_o=eDPg3cKVA3qPNbbYFoRJvJRxQBDj5A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Thu, Nov 24, 2022 at 04:31:14PM +0800, David Gow wrote:
> On Wed, Nov 23, 2022 at 11:28 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > This series introduce Kunit tests to the vc4 KMS driver, but unlike wha=
t we
> > have been doing so far in KMS, it actually tests the atomic modesetting=
 code.
> >
> > In order to do so, I've had to improve a fair bit on the Kunit helpers =
already
> > found in the tree in order to register a full blown and somewhat functi=
onal KMS
> > driver.
> >
> > It's of course relying on a mock so that we can test it anywhere. The m=
ocking
> > approach created a number of issues, the main one being that we need to=
 create
> > a decent mock in the first place, see patch 22. The basic idea is that I
> > created some structures to provide a decent approximation of the actual
> > hardware, and that would support both major architectures supported by =
vc4.
> >
> > This is of course meant to evolve over time and support more tests, but=
 I've
> > focused on testing the HVS FIFO assignment code which is fairly tricky =
(and the
> > tests have actually revealed one more bug with our current implementati=
on). I
> > used to have a userspace implementation of those tests, where I would c=
opy and
> > paste the kernel code and run the tests on a regular basis. It's was ob=
viously
> > fairly suboptimal, so it seemed like the perfect testbed for that serie=
s.
>
> Thanks very much for this! I'm really excited to see these sorts of
> tests being written.
>=20
> I was able to successfully run these under qemu with:
> ./tools/testing/kunit/kunit.py run --kunitconfig
> drivers/gpu/drm/vc4/tests --arch arm64
> --cross_compile=3Daarch64-linux-gnu-
> (and also with clang, using --make_options LLVM=3D1 instead of the
> --cross_compile flag)
>=20
> On the other hand, they don't compile as a module:
> ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/vc4/tests/vc4=
_mock.o
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/gpu/drm/vc4/tests/vc4_mock_crtc.o
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/gpu/drm/vc4/tests/vc4_mock_output.o
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/gpu/drm/vc4/tests/vc4_mock_plane.o
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.o
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/gpu/drm/tests/drm_managed_test.o
> ERROR: modpost: "vc4_drm_driver"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "vc5_drm_driver"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "drm_kunit_helper_alloc_device"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "__drm_kunit_helper_alloc_drm_device_with_driver"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "__vc4_hvs_alloc"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "vc4_dummy_plane"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "vc4_mock_pv" [drivers/gpu/drm/vc4/tests/vc4_mock.ko] und=
efined!
> ERROR: modpost: "vc4_dummy_output"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> ERROR: modpost: "vc4_kms_load" [drivers/gpu/drm/vc4/tests/vc4_mock.ko]
> undefined!
> ERROR: modpost: "vc4_txp_crtc_data"
> [drivers/gpu/drm/vc4/tests/vc4_mock.ko] undefined!
> WARNING: modpost: suppressed 17 unresolved symbol warnings because
> there were too many)

Thanks I'll fix it

> Most of those are just the need to export some symbols. There's some
> work underway to support conditionally exporting symbols only if KUnit
> is enabled, which may help:
> https://lore.kernel.org/linux-kselftest/20221102175959.2921063-1-rmoar@go=
ogle.com/

That's awesome :)

The current solution to include the test implementation is not ideal, so
it's great to see a nicer solution being worked on.

> Otherwise, I suspect the better short-term solution would just be to
> require that the tests are built-in (or at least compiled into
> whatever of the drm/vc4 modules makes most sense).
>=20
> The only other thing which has me a little confused is the naming of
> some of the functions, specifically with the __ prefix. Is it just for
> internal functions (many of them aren't static, but maybe they could
> use the VISIBLE_IF_KUNIT macro if that makes sense), or for versions
> of functions which accept extra arguments?

It was for internal functions that would definitely benefit from
VISIBLE_IF_KUNIT indeed

> Not a big deal (and maybe it's a DRM naming convention I'm ignorant
> of), but I couldn't quite find a pattern on my first read through.
>=20
> But on the whole, these look good from a KUnit point-of-view. It's
> really to see some solid mocking and driver testing, too. There would
> be ways to avoid passing the 'struct kunit' around in more places (or
> to store extra data as a kunit_resource), but I think it's better
> overall to pass it around like you have in this case -- it's certainly
> more compatible with things which might span threads (e.g. the
> workqueues).

One thing I'm really unsure about and would like your input on is
basically the entire device instantiation code in drm_kunit_helpers.c

It's a little fishy since it will allocate a platform_device while the
driver might expect some other bus device. And the code to bind the
driver based around probe and workqueues seems like a hack.

This is something that would benefit from having proper functions in
kunit to allocate a proper device for a given test. This is already
something that other unit test suites seems to get wrong, and I'm sure
there's some bugs somewhere in the helpers I did for DRM. What do you
think?

Maxime
