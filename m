Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967E7A8CF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjITTes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjITTej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 15:34:39 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3B9F;
        Wed, 20 Sep 2023 12:34:31 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 74E58150A22B;
        Wed, 20 Sep 2023 21:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695238468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ieFwOXSMXwW5Z1TbA7klO5guFnw5DamdxsZ5CsxGlt0=;
        b=Wpkll7Je8Gck2iZpd4BOW50eRsftKl4A3iDUArvIOYyke7t3nm5Fli7jg4q5J3dJGqEEVy
        kEYUkhw7PIY+Cd/WggeAxoELj3T7EBZ741uOX07yatvrGaYUBgLLLU9TUsowp1OuVGQMWj
        n+h5ufMLaU9YYHTGfcKYISaR6KJC4oc=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Date:   Wed, 20 Sep 2023 21:34:17 +0200
Message-ID: <12290212.O9o76ZdvQC@natalenko.name>
In-Reply-To: <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com> <5973628.lOV4Wx5bFT@natalenko.name>
 <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5713749.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--nextPart5713749.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Date: Wed, 20 Sep 2023 21:34:17 +0200
Message-ID: <12290212.O9o76ZdvQC@natalenko.name>
In-Reply-To: <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
MIME-Version: 1.0

Hello.

On st=C5=99eda 20. z=C3=A1=C5=99=C3=AD 2023 18:56:09 CEST Mario Limonciello=
 wrote:
> > When applied on top of v6.5.3 this breaks turbo on my 5950X after suspe=
nd/resume cycle. Please see the scenario description below.
> >=20
> > If I boot v6.5.3 + this patchset, then `turbostat` reports ~4.9 GHz on =
core 0 where `taskset -c 0 dd if=3D/dev/zero of=3D/dev/null` is being run.
> >=20
> > After I suspend the machine and then resume it, and run `dd` again, `tu=
rbostat` reports the core to be capped to a stock frequency of ~3.4 GHz. Re=
booting the machine fixes this, and the CPU can boost again.
> >=20
> > If this patchset is reverted, then the CPU can turbo after suspend/resu=
me cycle just fine.
> >=20
> > I'm using `amd_pstate=3Dguided`.
> >=20
> > Is this behaviour expected?
>=20
> To help confirm where the issue is, can I ask you to do three=20
> experiments with the patch series applied:
>=20
> 1) 'amd_pstate=3Dactive' on your kernel command line.

The issue is reproducible. If I toggle the governor in cpupower to `powersa=
ve` and back to `performance`, boost is restored.

> 2) 'amd_pstate=3Dactive amd_prefcore=3Ddisable' on your kernel command li=
ne.

The issue is not reproducible.

> 3) 'amd_pstate=3Dguided amd_prefcore=3Ddisable' on your kernel command li=
ne.

The issue is not reproducible.

I should also mention that in my initial configuration I use `amd_pstate=3D=
guided` and `schedutil`. If I switch to `performance` after suspend-resume =
cycle, the boost is restored. However, if I switch back to `schedutil`, the=
 freq is capped.

Does this info help?

> Looking through the code, I anticipate from your report that it=20
> reproduces on "1" but not "2" and "3".
>=20
> Meng,
>=20
> Can you try to repro?
>=20
> I think that it's probably a call to amd_pstate_init_prefcore() missing
> from amd_pstate_cpu_resume() and also amd_pstate_epp_resume().

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5713749.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmULSTkACgkQil/iNcg8
M0sqsA//eFdiuY7Cxaer5l0lBux1QhGyN0q30uy+zbybTXSfN4BGYulhA/nihp5k
TRvwAYlSQf1Zhoi40S2xQlpblgLkiSl+a9UtdVju7RKfButrbNhFmQSygIHYQnmc
kKYu+2079+3GvpFYPxtMJBR5UNbbNZ+dFTmj8SYnQ7Zm0cizbzi+WtIphnNuhubE
fLs8Dc1XtvrqukGjffefSDjzQ7pd/LIcD1zG4nPbdyUIki52P/Y4TewqqJ8ZePg5
qw/a/pRHePddz4rnEjCuSswZ98PXfipz7C1R49b1I6E7UlFAPqWnMQbioKYPUsWW
Eszd8omTV4ejEwZ6kX22zynoCHNRg8O37SMBHxhNbIzIOVXTyGtD+9c4wd6AjAvy
/+VRk9JJGHoZfh9YOB8tHNvmxzKUEQSW93KKlD8Var5hsqzWHsUxkCn3U74hB7Px
dWmKRtau/qrarrS068QtM8QOIgfegUzvu0s6DyVFleI9Sx0zjfV1cfzgv02OYY75
9Zk+/qfNe6opvZMtGLTMUueQGMy1KGYhN55PPMxy5S1LeZPgfXZDHWdBMqQYpz3X
RyNLvfoUYHGSQJJBKvhuloW0sauhFtVnBG7CF3A8e6t3dvzqBrwem+vdFBZw4uwt
xuw0b6tGpTkmeRCtz23xGHpH9qE6uIo4Bo2FxenUm3jZHnNbALY=
=EcDU
-----END PGP SIGNATURE-----

--nextPart5713749.DvuYhMxLoT--



