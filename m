Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE87935CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbjIFG7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjIFG7E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:59:04 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0AE50;
        Tue,  5 Sep 2023 23:58:59 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgYBR0RCrz9smb;
        Wed,  6 Sep 2023 08:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1693983535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lz6+CXqF6RhCxLhQ2DodKkhJHTcqk+cQ3N3hpcv2oo=;
        b=Cm+cT88EG4Z0nesXjvY9TFASC8fOhh9mxtsTvMTKU2yFkffEV23PtCZ1QyXg5FiUncHGQo
        Pc+jyU3IIBuNNTaDw2NGRqTOA1g4ph+Ub4fd0f4cZrHP91OopAjIBDzpGTv/s4ieWI6ibZ
        dwkOGfB1QssKaxrOnys3WIp+8gWp0zw7ibfscf618N/CpUX2RAkgjUR/UpBtGvdYtNSwP1
        IQiNri2PxRDjSHhUajgZL9NHtp8xwhjvBKX6bAIwYRn0GHJaTT/9CK4R6ulFeC0Ea92/DV
        vFZx+EZedWpdXrJQ3Ty8EDK3RQ4R+0LQoYY09xTfFU5C2jhzw9F/KQ/r8MmIZw==
Date:   Wed, 6 Sep 2023 16:58:41 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Damian Tometzki <dtometzki@fedoraproject.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
Message-ID: <20230906.065211-swollen.overhaul.chosen.plan-vGnGFFTg39x8@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
 <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
 <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
 <8734zs7ft6.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4ovhxzm5vwe74mz"
Content-Disposition: inline
In-Reply-To: <8734zs7ft6.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--p4ovhxzm5vwe74mz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-05, Florian Weimer <fweimer@redhat.com> wrote:
> * Andrew Morton:
>=20
> > OK, thanks, I'll revert this.  Spamming everyone even harder isn't a
> > good way to get developers to fix their stuff.
>=20
> Is this really buggy userspace?  Are future kernels going to require
> some of these flags?
>=20
> That's going to break lots of applications which use memfd_create to
> enable run-time code generation on locked-down systems because it looked
> like a stable interface (=E2=80=9Cdon't break userspace=E2=80=9D and all =
that).

There is no userspace breakage with the current behaviour and obviously
actually requiring these flags to be passed by default would be a pretty
clear userspace breakage and would never be merged.

The original intention (as far as I can tell -- the logging behaviour
came from the original patchset) was to try to incentivise userspace to
start passing the flags so that if distributions decide to set
vm.memfd_noexec=3D1 as a default setting you won't end up with programs
that _need_ executable memfds (such as container runtimes) crashing
unexpectedly. I also suspect there was an aspect of "well, userspace
*should* be passing these flags after we've introduced them".

I'm sending a patch to just remove this part of the logging because I
don't think it makes sense if you can't rate-limit it sanely, and
there's probably an argument to be made that it doesn't make sense at
all (at least for the default vm.memfd_noexec=3D0 setting).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--p4ovhxzm5vwe74mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZPgjIAAKCRAol/rSt+lE
b5/UAQDCyFuY5msfiPZGUSZKAqpdH2GRgP4/CT96FkXDXHqqfAD+MNiAGlVwvkBz
ZhGBQ1/LdsJ7BX4XVg53xl7uk1PfpAA=
=g5sd
-----END PGP SIGNATURE-----

--p4ovhxzm5vwe74mz--
