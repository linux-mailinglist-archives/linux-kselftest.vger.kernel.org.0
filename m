Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34B7A5BBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjISH5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 03:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjISH5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 03:57:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBC100;
        Tue, 19 Sep 2023 00:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA4FC433C8;
        Tue, 19 Sep 2023 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695110229;
        bh=htQQ2FKHvXLVeL8p+eXAdtx1fMJOjR4PUpElFMKZmN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPrYWXipXZJdXGi4m4osl3qZ7MBnh8weLjgO7/xXIO5pQl8clIxe/0Y0NZxtBJ9UY
         nUOO9CZDTA0arOa8FsurXadf0pzWwjCBNfFOXdXIC4WOUDMV+4Z/Emdo/qH2TOy0/N
         czCoFE0oyL3+SY1NbA1+93AlBKQkXDhGKUd312ao2Le0mPIQVjvcDfj0c8UZ5/4wfz
         7uhbnt8zod5c3QxB5ktAOEcQu6wvpan2wWQFugq5mpQIC1qfIfoSsuE0U/V0MPZEAK
         n2q7xpXKC2f5aNSo+9Js1azxyt+xv86exbrDS753wojB/7IN3cAg9/J/ThbIGokR/8
         I7H/DBkCJybwg==
Date:   Tue, 19 Sep 2023 09:57:07 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com,
        Benjamin Berg <benjamin.berg@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [RFC PATCH] kunit: Add a macro to wrap a deferred action function
Message-ID: <aylskx5ylpgbjj2k7vxzhggo7qs6kw5lbwqfusewmwu6xuusgl@zjsdgy57362n>
References: <20230915050125.3609689-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzavn4uvzmrnbux4"
Content-Disposition: inline
In-Reply-To: <20230915050125.3609689-1-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qzavn4uvzmrnbux4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 01:01:23PM +0800, David Gow wrote:
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> callbacks, and gcc's -Wcast-function-type seems to ignore cases where
> the only difference is the type of the argument, assuming it's
> compatible (i.e., they're both pointers to data).
>=20
> However, clang 16 has introduced -Wcast-function-type-strict, which no
> longer permits any deviation in function pointer type. This seems to be
> because it'd break CFI, which validates the type of function calls.
>=20
> This rather ruins our attempts to cast functions to defer them, and
> leaves us with a few options:
> 1. Stick our fingers in our ears an ignore the warning. (It's worked so
>    far, but probably isn't the right thing to do.)
> 2. Find some horrible way of casting which fools the compiler into
>    letting us do the cast. (It'd still break CFI, though.)
> 3. Disable the warning, and CFI for this function. This isn't optimal,
>    but may make sense for test-only code. However, I think we'd have to
>    do this for every function called, not just the caller, so maybe it's
>    not practical.
> 4. Manually write wrappers around any such functions. This is ugly (do
>    we really want two copies of each function, one of which has no type
>    info and just forwards to the other). It could get repetitive.
> 5. Generate these wrappers with a macro. That's what this patch does.
>=20
> I'm broadly okay with any of the options above, though whatever we go
> with will no doubt require some bikeshedding of details (should these
> wrappers be public, do we dedupe them, etc).
>=20
> Thoughts?

Looks awesome :)

We ended up using a wrapper in KMS to workaround this issue and would
benefit from it too.

Maxime

--qzavn4uvzmrnbux4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlUUwAKCRDj7w1vZxhR
xTUeAQCXea7YsXjxXaDvxqjnE997V4ealgCJYazsP/VqEvHEawEAp7F5FghSDNVD
/T5BI0YgKuv0gkRyUl7Mzj3oYZDKEg0=
=Vf6p
-----END PGP SIGNATURE-----

--qzavn4uvzmrnbux4--
