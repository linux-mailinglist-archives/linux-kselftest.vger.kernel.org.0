Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647977BD3D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbjJIGyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 02:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbjJIGyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 02:54:53 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF815C5;
        Sun,  8 Oct 2023 23:54:51 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DA4C6153512D;
        Mon,  9 Oct 2023 08:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696834483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IlzDoOZYiWYPbtk2kBivQRxVSaQo+uOk4lrH8b1jmYc=;
        b=XJdCdDSJLaJX82srrA7QyGsa9bfQ58KLF9OkPi3xEJi8kqJ9xtUg0teNQqbJSyRQLMktMp
        xEBWhFfVSs7rft/AVAeAEDPZqxXjYUXYtNHeZni4qQMnY/aXiUhnNSIkb2XHsTjLbS2c/3
        AKYMFs9JPpyBd3aK1wGWOmDukTVmH3g=
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
Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
Date:   Mon, 09 Oct 2023 08:54:30 +0200
Message-ID: <12301186.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5718532.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--nextPart5718532.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
Date: Mon, 09 Oct 2023 08:54:30 +0200
Message-ID: <12301186.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 9. =C5=99=C3=ADjna 2023 4:49:25 CEST Meng Li wrote:
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
> Changes form V7->V8:
> - all:
> - - pick up Review-By flag added by Mario and Ray.
> - cpufreq: amd-pstate:
> - - use hw_prefcore embeds into cpudata structure.
> - - delete preferred core init from cpu online/off.

Could you please let me know if this change means a fix for the report I've=
 sent previously? [1]

Would you also be able to Cc me on the next iteration of this patchset?

Thank you!

[1] https://lore.kernel.org/lkml/5973628.lOV4Wx5bFT@natalenko.name/

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
>  Documentation/admin-guide/pm/amd-pstate.rst   |  59 +++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 186 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |  10 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 285 insertions(+), 22 deletions(-)
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5718532.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUjo6YACgkQil/iNcg8
M0uuThAA6/ITnXoAzL1TacyVc1hZJ1c+JEC4e9sKiyp107Sf1zeYgYhjpON4bMB0
f3HJoG1rLdJAFhBRpoqoKVABAzogZmhKnLyJKIbdmcAYDMj2CSMLhBTEl6FJa8xd
NVUVrBDpq4H0ikEpSsxCbaLVdfdQPON5ok9B6C4PR+Zi4mfIey9an2g4RAUjFaSY
ZoSVYyr7JLqu0tQNLIaFbPLWZFetjIH0WF4Dobiv0pet8d5oz/XplR5WTwNDKYHT
KMGI0TTRdZscFUeaYRFGE9GSiT8Q3yZUB+fQZEchORgVrJEcdw+eqhUrNWHSV8KE
1C12lT8H6xNAoVOFTUWR8JVD7G4513y/rLCbsrqiVvAuac7zVzz0OcaeGz1BB5Q2
3KGAxfuxEFw7ql9zi0Qr9a62z38/4oTQsIvMuWCVprVwgQE54pP96NOjSdaf6aKo
N2h9U6MDOxO3qDvZ1WAfUfzQgyIOKkVUVZvt63DOeMNQBmlT2kRfF+ZBK6edZ3rH
RkH8+/qzr/VWjfNhk2f6NtaSj3juXYXuDRzSsVds1s7c4ApJgfn+369t1/9yzv8g
7BjHYs9fnyI2eYZgwvGlWMqVICUMkmyFSLl0VjuxAagryZY907wIHU1UmMqMqDOz
KFpiBZu4mx6cb5nLhFyGKf5krp7RjvkMmVr2K2w1ZulmOLau0p4=
=a/Od
-----END PGP SIGNATURE-----

--nextPart5718532.DvuYhMxLoT--



