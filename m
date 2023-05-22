Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E870CD92
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 00:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEVWM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEVWM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 18:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A119E;
        Mon, 22 May 2023 15:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3CA62C2E;
        Mon, 22 May 2023 22:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D6C433EF;
        Mon, 22 May 2023 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684793574;
        bh=YGJwc6bWE3d3AqOr6NZmZMERlp0hgMqroZJvgRuW1IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4JBT9vCZaRWHOzdZrl4zHCehpYtYUfitwXHG3v3lC4cxqnHjI1bq3vTO6bsItMvv
         CQEv7BI6g4CnL9x3XRcywxfRbBtBt5ajPspF1WJY+WoI3+2taOlSMp5A1w4GUNMFdP
         tQDPEUII0UENTqyvx4LyicBINPj8OqGNdJ1qPrnVXwvayyoXzho7AKuvlmEdhWDaYr
         AK0Lo/hXsIU3F5OcpEcl0MCWcsuv1cAVdhCQtcNrssuTYojd0ocdZvYrMMISjpZ3H1
         2vdkXTLWbgYRGSsyT3xpKo6djU4ddxnpAYI/c7vSlCcMvBzqVtoP9l3+iFwLYnYBxW
         UHbx20GTQQiTA==
Date:   Mon, 22 May 2023 23:12:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <b4bfd69f-2092-4d15-b7ce-b814f5f10ff2@sirena.org.uk>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t8ki7xtWQaeXytDL"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--t8ki7xtWQaeXytDL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:

> # To install tuxrun on your system globally:
> # sudo pip3 install -U tuxrun=3D=3D0.42.0

I'm not thrilled about the idea of installing some Python package
outside of my distro package manager, especially not running as root,
but I *do* have a checked out copy of tuxrun which normally seems to do
something...

> #
> # See https://tuxrun.org/ for complete documentation.
>=20
> tuxrun   \
>  --runtime podman   \
>  --device fvp-aemva   \
>  --boot-args rw   \
>  --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLi=
BcWRMuy6lXftDVQMvca/Image.gz
>   \
>  --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvL=
iBcWRMuy6lXftDVQMvca/modules.tar.xz
>   \
>  --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.x=
z   \
>  --parameters SKIPFILE=3Dskipfile-lkft.yaml   \
>  --parameters KSELFTEST=3Dhttps://storage.tuxsuite.com/public/linaro/lkft=
/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/kselftest.tar.xz
>   \
>  --image tuxrun:fvp   \
>  --tests kselftest-arm64   \
>  --timeouts boot=3D60 kselftest-arm64=3D60

This command does not work for me, after fixing up the fact that
multiple lines have continuation characters that are nonfunctional due
to being wrapped onto the next line I get:

| Error: error getting default registries to try: short-name "tuxrun:fvp" d=
id not resolve to an alias and no unqualified-search registries are defined=
 in "/etc/containers/registries.conf"

Trying tip of tree tuxrun gives the same result.  Grovelling around in
the documentation I see there's a need to manually build some containers
for the FVP so I was able to get the above command to boot with the
--image option removed and switching to docker as the runtime but after
faffing for a very large amount of time even by the standards of the
model it appeared to just shut down the model without starting
kselftest, possibly due to having mounted some of the filesystems read
only:

2023-05-22T21:03:43 Using a character delay of 50 (ms)
2023-05-22T21:03:43 #=E2=8F=8E
2023-05-22T21:03:43 [?2004l[?2004hroot@runner-pqlayms-project-40964107-conc=
urrent-5:~# #
2023-05-22T21:03:43 lava-test-shell: Wait for prompt ['root@(.*):[/~]#'] (t=
imeout 01:00:00)
2023-05-22T21:03:43 #
2023-05-22T21:03:43 Using /lava-1
2023-05-22T21:03:43 Sending with 50 millisecond of delay
2023-05-22T21:03:43 export SHELL=3D/bin/sh=E2=8F=8E
2023-05-22T21:03:45 [?2004l[?2004hroot@runner-pqlayms-project-40964107-conc=
urrent-5:~# export SHELL=3D/bin/sh
2023-05-22T21:03:45 export SHELL=3D/bin/sh
2023-05-22T21:03:45 Sending with 50 millisecond of delay
2023-05-22T21:03:45 . /lava-1/environment=E2=8F=8E
2023-05-22T21:03:47 [?2004l[?2004hroot@runner-pqlayms-project-40964107-conc=
urrent-5:~# . /lava-1/environment
2023-05-22T21:03:47 . /lava-1/environment
2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_1' for 1 second
2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_2' for 1 second
2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_3' for 1 second
2023-05-22T21:03:47 Sending with 50 millisecond of delay
2023-05-22T21:03:47 /lava-1/bin/lava-test-runner /lava-1/0=E2=8F=8E
2023-05-22T21:03:51 [?2004l[?2004hroot@runner-pqlayms-project-40964107-conc=
urrent-5:~# /lava-1/bin/lava-test-runner /lava-1/0
2023-05-22T21:03:51 Test shell timeout: 10s (minimum of the action and conn=
ection timeout)
2023-05-22T21:03:51 /lava-1/bin/lava-test-runne r /lava-1/0
2023-05-22T21:03:52 [?2004lmkdir: cannot create directory =E2=80=98/lava-1/=
0/results=E2=80=99: Read-only file system
2023-05-22T21:03:53 mv: cannot move '/lava-1/0/lava-test-runner.conf' to '/=
lava-1/0/lava-test-runner.conf-1684789015': Read-only file system
2023-05-22T21:03:54 cat: /lava-1/0/lava-test-runner.conf-1684789015: No suc=
h file or directory
2023-05-22T21:03:55 ok: lava_test_shell seems to have completed
2023-05-22T21:03:55 end: 3.1 lava-test-shell (duration 00:00:12) [common]
2023-05-22T21:03:55 end: 3 lava-test-retry (duration 00:00:12) [common]
2023-05-22T21:03:55 start: 4 finalize (timeout 00:10:00) [common]
2023-05-22T21:03:55 start: 4.1 power-off (timeout 00:01:00) [common]
2023-05-22T21:03:55 end: 4.1 power-off (duration 00:00:00) [common]
2023-05-22T21:03:55 start: 4.2 read-feedback (timeout 00:10:00) [common]

Attempting to use podman as the runtime as your command said had various
problems:

2023-05-22T21:07:01 start: 2.1.1 check-fvp-version (timeout 01:00:00) [comm=
on]
2023-05-22T21:07:01 sh -c docker run --rm fvp:aemva-11.21.15 /opt/model/FVP=
_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version
2023-05-22T21:07:01 Parsed command exited 1.
2023-05-22T21:07:01 action: check-fvp-version
command: ['sh', '-c', 'docker run --rm fvp:aemva-11.21.15 /opt/model/FVP_AE=
MvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version']
message: Command '['sh', '-c', 'docker run --rm fvp:aemva-11.21.15 /opt/mod=
el/FVP_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version']' retu=
rned non-zero exit status 1.
output: Missing runtime '/usr/bin/podman'
return code: 1

(I do have podman installed though I rarely use it, this looks to be in
the LAVA container though)

> Test log links:
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v=
6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/test/check-=
kernel-kfence/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v=
6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/tests/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v=
6.1.28-240-gb82733c0ff99/testrun/17007268/suite/kselftest-arm64/tests/
>=20
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v=
6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/test/check-k=
ernel-bug/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v=
6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/tests/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v=
6.3.2-247-g5a952cfef67c/testrun/17015127/suite/kselftest-arm64/tests/

None of these seem to provide me with information like what kernel
config was used but I did manage to find

  https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6lX=
ftDVQMvca/config

which might be it?  Or one of them?  However even trying to use that I'm
unable to reproduce issues with either the FVP or qemu.

--t8ki7xtWQaeXytDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRr6OAACgkQJNaLcl1U
h9D7/Af/a6J1nMAJHOQgusWnZsDlQB3Sq/V9wdUYbqJ1iW5mhElmMApArvbqkApt
/FsXyKLlIBRu7nvjmMW3s7tZud7IIOwLo6e5zrJHwYKJ+TT0M2pQn1hIXvxcVPcQ
kZwgmAgOd9hGnZyuSqfaFceb1C7EYbOaZzTx9mog+HwoUNJtmZrrziiFfLyVwznD
XYmcqAtfmH6SQqB4ZMlpK3a6itNVrv/q74FDeK8n8DJRWI1ySedKol0sRGLF3AsE
Tok2eARj2tXwa+3ikSaaoxZb3cLaZ5RzRQGF5E7GPc+S6Ghb/NL5OZZTtd/vaQuk
9BCRKlmNzZyN80Gl7qPhioWjpL15pA==
=xG1w
-----END PGP SIGNATURE-----

--t8ki7xtWQaeXytDL--
