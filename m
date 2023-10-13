Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97FB7C8903
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjJMPpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 11:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjJMPph (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 11:45:37 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34ABCF;
        Fri, 13 Oct 2023 08:45:33 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C2C75153EFD9;
        Fri, 13 Oct 2023 17:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1697211926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GF/P3UK58QtWzAMZuYI1b/cNsajjo8+2kJ1HkJvuQz4=;
        b=JD3mEtxLUQ2J2+Vax0UJsf2QngVA5PWdjV1VljOvAyCGii8cy2yagHAHAi7XWDiTGqWY2k
        mkMK1Yi5RV8+SVfY7T6h0rcenpAfUiVhBXsWd1q2Ccg7A4GNQXEUz73SfA/02LkLwm70Zg
        qlmCzCurmIH+zK8G92v+FW1Cs5Iu2L8=
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
Subject: Re: [RESEND PATCH V9 0/7] amd-pstate preferred core
Date:   Fri, 13 Oct 2023 17:45:15 +0200
Message-ID: <12303526.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5719407.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--nextPart5719407.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [RESEND PATCH V9 0/7] amd-pstate preferred core
Date: Fri, 13 Oct 2023 17:45:15 +0200
Message-ID: <12303526.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 13. =C5=99=C3=ADjna 2023 5:31:11 CEST Meng Li wrote:
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
> Changes form V8->V9:
> - all:
> - - pick up Tested-By flag added by Oleksandr.
> - cpufreq: amd-pstate:
> - - pick up Review-By flag added by Wyes.
> - - ignore modification of bug.

Thanks for this submission.

The bug you refer to, I assume it should have been fixed by this hunk:

```
=2D-- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -542,7 +542,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf =3D DIV_ROUND_UP(cap_perf * target_perf, capacity);
=20
=2D	min_perf =3D READ_ONCE(cpudata->highest_perf);
+	min_perf =3D READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf =3D DIV_ROUND_UP(cap_perf * _min_perf, capacity);
```

which is now missing from this patchset as it was suggested to send it as a=
 separate patch.

Am I correct? If so, are you going to send it as a separate patch within th=
e next round of this patchset, or it will be sent separately (if it hasn't =
yet)?

> - - add a attribute of prefcore_ranking.
> - - modify data type conversion from u32 to int.
> - Documentation: amd-pstate:
> - - pick up Review-By flag added by Wyes.
>=20
> Changes form V7->V8:
> - all:
> - - pick up Review-By flag added by Mario and Ray.
> - cpufreq: amd-pstate:
> - - use hw_prefcore embeds into cpudata structure.
> - - delete preferred core init from cpu online/off.
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
>  Documentation/admin-guide/pm/amd-pstate.rst   |  59 ++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 204 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |  10 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 305 insertions(+), 20 deletions(-)
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5719407.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUpZgsACgkQil/iNcg8
M0saeQ/+ITtu+L9VzE+fm2PU5Ym/icfRCnp0TME5PQY+YNAnWNKMJeeyP+IVIsGK
mC/Yru7gP4UxbWz8Ex/eKV+J3B7Afe5V7Z5vrVjRyJVAwU5RbuKLYvxZPQSDuy16
8gK75tCK639bYViG9q0zWgZulc0qtjt7zsS5lRM0m+XRbEbvNR4Sr0gh2c1lHOa+
nA5DwkUDbEtmCgebyEbBHidtklha9yTuhEVL38BpiNra+KjzC81A+Acc+VyPCTP0
hgYf/NHtI6jzZo+f/Jvg1Y4bEvjsn8VDruUQ7GHuvAGshunkqLUsHJwAUfUJZbPX
tjuFyp/ah2861e+Q1/kyjMr2tsfglBu2ISxsM51P5KN2s/bqdws2+mv+CMLj8iph
6Jrp3aDgPainEwyMXONsyZRcNvMQtFGLZOLosOJOZ7N98B8cN+EnyAoLC02S1VAO
U31S9O0Xef5bancSf/0VsKQ0opD1Rw9Vn5orSWJIRXm5u+bN+8SFIroz77dHuokZ
+t+bD/3KnmUHzKG8PDaS96yE65Jd9ZS1f460lKQ0Au82rSpdMWCW3AbdJw57TpAa
9lqMSnbRos75cPc3T455e1XTnwiiIqsygu53x9chZF+mU+w8+SZoMCmeKXhQ5qtk
M1x9isx4WxZ4M2MJKCVkbIz3gBTflv1YW9laJJ2WrDOU79KuCn8=
=GFQL
-----END PGP SIGNATURE-----

--nextPart5719407.DvuYhMxLoT--



