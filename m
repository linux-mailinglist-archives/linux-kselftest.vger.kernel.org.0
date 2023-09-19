Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF57A6B31
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjISTKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 15:09:59 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 12:09:53 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52728B3;
        Tue, 19 Sep 2023 12:09:53 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E6E0B15062BD;
        Tue, 19 Sep 2023 21:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1695150094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dflHOnB94HvldzRUSNy/uSO4mOyWUQlh73gqe+vY1i0=;
        b=w57266V8BxxEwoEPZ5ZGfXEyFVETx/dIMIMD4TDsL11cKDENUcEhmzzecKdKquyvn7GM92
        NDCVnaa1VTaf/255g5gUmVo3JbbEjeCDrQHMNi8k21T/v2lVpsThXjPgSG/XIlfYTuQ110
        gMNwMMLpnjA8KP0FpapcZFs1aQoJI5Y=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Date:   Tue, 19 Sep 2023 21:01:20 +0200
Message-ID: <5973628.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4861953.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--nextPart4861953.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Date: Tue, 19 Sep 2023 21:01:20 +0200
Message-ID: <5973628.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 18. z=C3=A1=C5=99=C3=AD 2023 10:14:00 CEST Meng Li wro=
te:
> Hi all:
>=20
> The core frequency is subjected to the process variation in semiconductor=
s.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reach
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform thr=
ough
> highest performance capability register of the CPPC interface.
>=20
> Earlier implementations of amd-pstate preferred core only support a static
> core ranking and targeted performance. Now it has the ability to dynamica=
lly
> change the preferred core based on the workload and platform conditions a=
nd
> accounting for thermals and aging.
>=20
> Amd-pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on cores
> which can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
>=20
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
>=20
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-pst=
ate
> driver receives a message with the highest performance change, it will
> update the core ranking.
>=20
> Changes form V6->V7:
> - x86:
> - - Modify kconfig about X86_AMD_PSTATE.
> - cpufreq: amd-pstate:
> - - modify incorrect comments about scheduler_work().
> - - convert highest_perf data type.
> - - modify preferred core init when cpu init and online.
> - acpi: cppc:
> - - modify link of CPPC highest performance.
> - cpufreq:
> - - modify link of CPPC highest performance changed.
>=20
> Changes form V5->V6:
> - cpufreq: amd-pstate:
> - - modify the wrong tag order.
> - - modify warning about hw_prefcore sysfs attribute.
> - - delete duplicate comments.
> - - modify the variable name cppc_highest_perf to prefcore_ranking.
> - - modify judgment conditions for setting highest_perf.
> - - modify sysfs attribute for CPPC highest perf to pr_debug message.
> - Documentation: amd-pstate:
> - - modify warning: title underline too short.
>=20
> Changes form V4->V5:
> - cpufreq: amd-pstate:
> - - modify sysfs attribute for CPPC highest perf.
> - - modify warning about comments
> - - rebase linux-next
> - cpufreq:=20
> - - Moidfy warning about function declarations.
> - Documentation: amd-pstate:
> - - align with ``amd-pstat``
>=20
> Changes form V3->V4:
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
>=20
> Changes form V2->V3:
> - x86:
> - - Modify kconfig and description.
> - cpufreq: amd-pstate:=20
> - - Add Co-developed-by tag in commit message.
> - cpufreq:
> - - Modify commit message.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
>=20
> Changes form V1->V2:
> - acpi: cppc:
> - - Add reference link.
> - cpufreq:
> - - Moidfy link error.
> - cpufreq: amd-pstate:=20
> - - Init the priorities of all online CPUs
> - - Use a single variable to represent the status of preferred core.
> - Documentation:
> - - Default enabled preferred core.
> - Documentation: amd-pstate:=20
> - - Modify inappropriate descriptions.
> - - Default enabled preferred core.
> - - Use a single variable to represent the status of preferred core.
>=20
> Meng Li (7):
>   x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>   acpi: cppc: Add get the highest performance cppc control
>   cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
>   cpufreq: Add a notification message that the highest perf has changed
>   cpufreq: amd-pstate: Update amd-pstate preferred core ranking
>     dynamically
>   Documentation: amd-pstate: introduce amd-pstate preferred core
>   Documentation: introduce amd-pstate preferrd core mode kernel command
>     line options
>=20
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  Documentation/admin-guide/pm/amd-pstate.rst   |  58 +++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 197 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |   6 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 291 insertions(+), 22 deletions(-)

When applied on top of v6.5.3 this breaks turbo on my 5950X after suspend/r=
esume cycle. Please see the scenario description below.

If I boot v6.5.3 + this patchset, then `turbostat` reports ~4.9 GHz on core=
 0 where `taskset -c 0 dd if=3D/dev/zero of=3D/dev/null` is being run.

After I suspend the machine and then resume it, and run `dd` again, `turbos=
tat` reports the core to be capped to a stock frequency of ~3.4 GHz. Reboot=
ing the machine fixes this, and the CPU can boost again.

If this patchset is reverted, then the CPU can turbo after suspend/resume c=
ycle just fine.

I'm using `amd_pstate=3Dguided`.

Is this behaviour expected?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4861953.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUJ8AAACgkQil/iNcg8
M0ueyxAA56PZrdELCmbVNIVuREAaNkoOkxzDaS9JhELpp1yvetk6gCANs4Y1RYpg
sqZMY1b/hVh52JwnGoOwnbnJAQWRqeERW4xzhxr78JeKfAwE3jD1IO71rfOfurkA
6g1Yxou5N34mccFCF1ZiywscJznwvPKpdl0jxGFbGvHWf05hSTCExm/3XWljYEU5
qUN2/cwd3K3Jd/Q2H7i0mn9LFcuJtmP1vIdeinTxhy6bRxe86y+fireIXPxiYyHm
dhxCEhCT0OkeEmwVufec/D0G3El4BI3TJDQ98zZUD0vNFHx5dFfIbOoCHVoLfQeD
lKOl4VhuIoNL8LhZKzZeY9zMMQuRQhFL7aZhldwaS8A7bs6k6UgSOL5xoiR7bRK1
PV7Km15CY0mxkobbqtEfuRQh1gOPh/OhPCiFUBFHZkTCQnMsL5RHAAclsU+ELb4D
xRLQpaDP3usou6Gc7M4eFxm+eJ2DFeI6pfL4QHYhUsBCaJicbv+8Q1zy9PCcwAei
usIgfi5bamxD9ZdRpdvekFPMQMycOJLT+4lqF2aU4AjFk3X8zCoUidTvYOI330Rp
jx5aQQWh4+iltD6T7j935tUE7AVAiT5EKlcHWoX0+hgfaqqtjjEmGX7zu9c12IQL
fjR4ikgIGzgkbdtN7i41IYGFt9lTW2B5hShrSSiR7RhDzasg7hI=
=vH+S
-----END PGP SIGNATURE-----

--nextPart4861953.31r3eYUQgx--



