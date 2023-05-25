Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B0710D9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbjEYNvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjEYNvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 09:51:39 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8241A2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 06:51:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4397b040c8fso229666137.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685022696; x=1687614696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n19tabLNtFp1Iz9K9pxIJD1OumeleMtFy/K7WnzgIfg=;
        b=sdx1I3H43CqY0+7VjcSBTZyBmaYW73mvbcH9NIAIuik6vBNGrDhItHXEkqI+Y3O65w
         IXmiIBFCzLj249aZ+DwxEGpozd5ptsurxC8lwyRrA4UUvWb8FWcEvDDyKU9WERlAC5KW
         Fyi/AsQb2yEuUyC1GLSLsMjTZ6IlXOc1gCbfCXPpgmCCaG52xCb901LcHQ6eRnBBA8pL
         Py1MzKDCP9+Qor6Wq/3uDyE9jreXmHQWET7nBZoGHdMM1iBPwqeKsXNMBeZXhIvgGDu0
         biNTEtWFtWMhtNBDmGrgsNaYPBZH3Rb8RKHYxv0KGG1A9G6Sr3+NY09m2h+5WeIU7OSY
         wB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022696; x=1687614696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n19tabLNtFp1Iz9K9pxIJD1OumeleMtFy/K7WnzgIfg=;
        b=ZF4uQJ+liwunEFCsC5i1sCzc9HQBx5De0ovnnWMwFy9zYrs8jUKlL5LxOg+whIx6wd
         iTLzPP/v1YBFzvvYOcwCgeJCwdgvgCwRZa6UxONs8vpIQFyUCoKSb4u70E/qCqDasv7H
         C1jeo1Y0F7YzwvZaO9t8U/T4ZN6R04KrHqpESD+VE6fpaoPV+FvvvQYVDMyjxqHsPZoF
         4aKq5UEiL+ReRhO99KLBBmKVrTFyx9NjuAugGWsFIs+AjI13sTQ3bd4qCE6EWWq07suT
         WRLxHuV6xH34SE9N6hE5EQFIin1x4FjnenfHsbA17caxKE4ZetbdFgy7Xwa5mB6aPkYE
         EvDw==
X-Gm-Message-State: AC+VfDyhUsakF21zoXu4+M6Yotcg4DS/k2ny/G/9l5idGyd1P912FbE8
        teFqIDnvVTy5ez8aXqd36GF7vk+WOEbK+Xc7i99IPg==
X-Google-Smtp-Source: ACHHUZ45iqVUZWAxmYQp90u1RQkVeX/4NHZY3Nm3bCxxSaV1E/EC64hFIztI5ZcN0+eOub/1YGI6qrhg3cAjP/LsJPI=
X-Received: by 2002:a05:6102:2856:b0:42c:78e4:ef23 with SMTP id
 az22-20020a056102285600b0042c78e4ef23mr5714739vsb.31.1685022695691; Thu, 25
 May 2023 06:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <b4bfd69f-2092-4d15-b7ce-b814f5f10ff2@sirena.org.uk>
In-Reply-To: <b4bfd69f-2092-4d15-b7ce-b814f5f10ff2@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 May 2023 19:21:24 +0530
Message-ID: <CA+G9fYv=uyQaJs0JLMmZWLeLH0G5FF7WGcTa7y0bi0nCDfoi+A@mail.gmail.com>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     Mark Brown <broonie@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 23 May 2023 at 03:42, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
>
> > # To install tuxrun on your system globally:
> > # sudo pip3 install -U tuxrun=3D=3D0.42.0
>
> I'm not thrilled about the idea of installing some Python package
> outside of my distro package manager, especially not running as root,
> but I *do* have a checked out copy of tuxrun which normally seems to do
> something...
>
> > #
> > # See https://tuxrun.org/ for complete documentation.
> >
> > tuxrun   \
> >  --runtime podman   \
> >  --device fvp-aemva   \
> >  --boot-args rw   \
> >  --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5Nv=
LiBcWRMuy6lXftDVQMvca/Image.gz
> >   \
> >  --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5N=
vLiBcWRMuy6lXftDVQMvca/modules.tar.xz
> >   \
> >  --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4=
.xz   \
> >  --parameters SKIPFILE=3Dskipfile-lkft.yaml   \
> >  --parameters KSELFTEST=3Dhttps://storage.tuxsuite.com/public/linaro/lk=
ft/builds/2Pq5NvLiBcWRMuy6lXftDVQMvca/kselftest.tar.xz
> >   \
> >  --image tuxrun:fvp   \
> >  --tests kselftest-arm64   \
> >  --timeouts boot=3D60 kselftest-arm64=3D60
>
> This command does not work for me, after fixing up the fact that
> multiple lines have continuation characters that are nonfunctional due
> to being wrapped onto the next line I get:
>
> | Error: error getting default registries to try: short-name "tuxrun:fvp"=
 did not resolve to an alias and no unqualified-search registries are defin=
ed in "/etc/containers/registries.conf"
>
> Trying tip of tree tuxrun gives the same result.  Grovelling around in
> the documentation I see there's a need to manually build some containers
> for the FVP so I was able to get the above command to boot with the
> --image option removed and switching to docker as the runtime but after
> faffing for a very large amount of time even by the standards of the
> model it appeared to just shut down the model without starting
> kselftest, possibly due to having mounted some of the filesystems read
> only:
>
> 2023-05-22T21:03:43 Using a character delay of 50 (ms)
> 2023-05-22T21:03:43 #=E2=8F=8E
> 2023-05-22T21:03:43 [?2004l[?2004hroot@runner-pqlayms-project-40964107-co=
ncurrent-5:~# #
> 2023-05-22T21:03:43 lava-test-shell: Wait for prompt ['root@(.*):[/~]#'] =
(timeout 01:00:00)
> 2023-05-22T21:03:43 #
> 2023-05-22T21:03:43 Using /lava-1
> 2023-05-22T21:03:43 Sending with 50 millisecond of delay
> 2023-05-22T21:03:43 export SHELL=3D/bin/sh=E2=8F=8E
> 2023-05-22T21:03:45 [?2004l[?2004hroot@runner-pqlayms-project-40964107-co=
ncurrent-5:~# export SHELL=3D/bin/sh
> 2023-05-22T21:03:45 export SHELL=3D/bin/sh
> 2023-05-22T21:03:45 Sending with 50 millisecond of delay
> 2023-05-22T21:03:45 . /lava-1/environment=E2=8F=8E
> 2023-05-22T21:03:47 [?2004l[?2004hroot@runner-pqlayms-project-40964107-co=
ncurrent-5:~# . /lava-1/environment
> 2023-05-22T21:03:47 . /lava-1/environment
> 2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_1' for 1 seco=
nd
> 2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_2' for 1 seco=
nd
> 2023-05-22T21:03:47 Will listen to feedbacks from 'terminal_3' for 1 seco=
nd
> 2023-05-22T21:03:47 Sending with 50 millisecond of delay
> 2023-05-22T21:03:47 /lava-1/bin/lava-test-runner /lava-1/0=E2=8F=8E
> 2023-05-22T21:03:51 [?2004l[?2004hroot@runner-pqlayms-project-40964107-co=
ncurrent-5:~# /lava-1/bin/lava-test-runner /lava-1/0
> 2023-05-22T21:03:51 Test shell timeout: 10s (minimum of the action and co=
nnection timeout)
> 2023-05-22T21:03:51 /lava-1/bin/lava-test-runne r /lava-1/0
> 2023-05-22T21:03:52 [?2004lmkdir: cannot create directory =E2=80=98/lava-=
1/0/results=E2=80=99: Read-only file system
> 2023-05-22T21:03:53 mv: cannot move '/lava-1/0/lava-test-runner.conf' to =
'/lava-1/0/lava-test-runner.conf-1684789015': Read-only file system
> 2023-05-22T21:03:54 cat: /lava-1/0/lava-test-runner.conf-1684789015: No s=
uch file or directory
> 2023-05-22T21:03:55 ok: lava_test_shell seems to have completed
> 2023-05-22T21:03:55 end: 3.1 lava-test-shell (duration 00:00:12) [common]
> 2023-05-22T21:03:55 end: 3 lava-test-retry (duration 00:00:12) [common]
> 2023-05-22T21:03:55 start: 4 finalize (timeout 00:10:00) [common]
> 2023-05-22T21:03:55 start: 4.1 power-off (timeout 00:01:00) [common]
> 2023-05-22T21:03:55 end: 4.1 power-off (duration 00:00:00) [common]
> 2023-05-22T21:03:55 start: 4.2 read-feedback (timeout 00:10:00) [common]
>
> Attempting to use podman as the runtime as your command said had various
> problems:
>
> 2023-05-22T21:07:01 start: 2.1.1 check-fvp-version (timeout 01:00:00) [co=
mmon]
> 2023-05-22T21:07:01 sh -c docker run --rm fvp:aemva-11.21.15 /opt/model/F=
VP_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version
> 2023-05-22T21:07:01 Parsed command exited 1.
> 2023-05-22T21:07:01 action: check-fvp-version
> command: ['sh', '-c', 'docker run --rm fvp:aemva-11.21.15 /opt/model/FVP_=
AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version']
> message: Command '['sh', '-c', 'docker run --rm fvp:aemva-11.21.15 /opt/m=
odel/FVP_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA --version']' re=
turned non-zero exit status 1.
> output: Missing runtime '/usr/bin/podman'
> return code: 1
>
> (I do have podman installed though I rarely use it, this looks to be in
> the LAVA container though)
>
> > Test log links:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build=
/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/test/chec=
k-kernel-kfence/log
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build=
/v6.1.28-240-gb82733c0ff99/testrun/17007082/suite/log-parser-test/tests/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build=
/v6.1.28-240-gb82733c0ff99/testrun/17007268/suite/kselftest-arm64/tests/
> >
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build=
/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/test/check=
-kernel-bug/log
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build=
/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/log-parser-test/tests/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build=
/v6.3.2-247-g5a952cfef67c/testrun/17015127/suite/kselftest-arm64/tests/
>
> None of these seem to provide me with information like what kernel
> config was used but I did manage to find
>
>   https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq5NvLiBcWRMuy6=
lXftDVQMvca/config
>
> which might be it?  Or one of them?  However even trying to use that I'm
> unable to reproduce issues with either the FVP or qemu.

You got the right config file which we are using for testing
FVP selftests.

Since it is intermittent it is not easy to reproduce always.
You are right ! that, you may have to try with full sub set run

./run_kselftest.sh -c arm64

- Naresh
