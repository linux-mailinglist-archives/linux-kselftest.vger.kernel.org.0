Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE487E262B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFN6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFN6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 08:58:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77671BF;
        Mon,  6 Nov 2023 05:58:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD348C433C8;
        Mon,  6 Nov 2023 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699279095;
        bh=146Hv24u0iSEfP0Lcoz7MmQS/jc9ccb6iAZD/d2PjY8=;
        h=From:Date:To:Cc:Subject:References:In-Reply-To:From;
        b=PyUgHft7oDTb28dERhjiXG7ymjucR0IV3zsIgfoMhonHCtvSfIqGeXiBs4IKUbuZ5
         C7wAD6ia7eObwcY43OU5btkXZKbi/XnI4EEDpk8qt483bh2SwD8PfhqviMyMlhXcf+
         Ly3RVdmvbAnKJri08i+Op1Tjle50Xsn+QgWJIVPOt9MPZUVr91MjLNQRnJy7t/bqMu
         Tnwvfyw8bAC1fBq/S9hoGsxom/XHiMm7m8Y2UFrtxP5K24Gc3AmLwWmrNI3js3Ax7Q
         oaeVl6aQv5HgEns4FF82Bera9+OddYbodYnd3Tr4WINKQHLAiFlaVJ+JBlefgC1/8b
         CRC4oab8dM2Dw==
From:   mripard@kernel.org
Date:   Mon, 6 Nov 2023 14:58:12 +0100
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        kv-team <kv-team@linaro.org>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
65;7400;1cFrom: Maxime Ripard <mripard@kernel.org>
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
 <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
 <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqbcpamsz7sm4ktx"
Content-Disposition: inline
In-Reply-To: <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xqbcpamsz7sm4ktx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 01, 2023 at 12:08:00PM +0300, Dan Carpenter wrote:
> Let me add Richard to the CC list.  See lore for more details.
> https://lore.kernel.org/all/CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=3D7_uFcybBSL=
=3DQP_sQvQ@mail.gmail.com/
>=20
> On Tue, Oct 31, 2023 at 09:57:48PM +0530, Naresh Kamboju wrote:
> > On Mon, 30 Oct 2023 at 14:33, Dan Carpenter <dan.carpenter@linaro.org> =
wrote:
> > >
> > > We have started printing more and more intentional stack traces.  Whe=
ther
> > > it's testing KASAN is able to detect use after frees or it's part of a
> > > kunit test.
> > >
> > > These stack traces can be problematic.  They suddenly show up as a new
> > > failure.  Now the test team has to contact the developers.  A bunch of
> > > people have to investigate the bug.  We finally decide that it's
> > > intentional so now the test team has to update their filter scripts to
> > > mark it as intentional.  These filters are ad-hoc because there is no
> > > standard format for warnings.
> > >
> > > A better way would be to mark it as intentional from the start.
> > >
> > > Here, I have marked the beginning and the end of the trace.  It's more
> > > tricky for things like lkdtm_FORTIFY_MEM_MEMBER() where the flow does=
n't
> > > reach the end of the function.  I guess I would print a different
> > > warning for stack traces that can't have a
> > > "Intentional warning finished\n" message at the end.
> > >
> > > I haven't actually tested this patch...  Daniel, do you have a
> > > list of intentional stack traces we could annotate?
> >=20
> > [My two cents]
> >=20
> > I have been noticing following kernel warnings / BUGs
>=20
> Some are intentional and some are not.  I had a similar thing happen to
> me last week where I had too many Smatch false positives in my devel
> code so I accidentally sent a patch with a stupid bug.  I've since
> updated my QC process to run both the devel and released versions of
> Smatch.
>=20
> But a similar thing is happening here where we have so many bogus
> warnings that we missed a real bug.

IIRC, there was a similar discussion for lockdep issues. IMO, any
(unintended) warning should trigger a test failure.

I guess that would require adding some intrumentation to __WARN somehow,
and also allowing tests to check whether a warning had been generated
during their execution for tests that want to trigger one.

Maxime

--xqbcpamsz7sm4ktx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUjw9AAKCRDj7w1vZxhR
xVHxAP9+MVNkRhFAcYBlsPMe3eQ/ZiQV5eqW/Q8okxFof/9xegD/WBapKwZv6qgF
CyoizI3A8AGSVFpMUx9COGghvklOAQE=
=iyFQ
-----END PGP SIGNATURE-----

--xqbcpamsz7sm4ktx--
