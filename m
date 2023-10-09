Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C27BDCF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376651AbjJINAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 09:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376642AbjJINAP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 09:00:15 -0400
X-Greylist: delayed 21923 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 06:00:10 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E38F;
        Mon,  9 Oct 2023 06:00:10 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3B27B15356C3;
        Mon,  9 Oct 2023 15:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1696856403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jv2ouviQ9JRHif0I/YLnvZflUpDg+74ZEHaRP9yz9pQ=;
        b=SyC27gtbDH3QDTNFIdvBJtuFRvpF3fh3D0LX8kavoo6AzY2DbprZSgzRAhoaHiwd/fsFuZ
        K6pZ+u6mhpNuWagg++7qU8tnR2W/PV+iFtZdeKKdqlPHKLBj+EHA8DhGldGz/a8HiPzfWU
        BzIKKFI0dffSU2nmJEWn0xeN1UTLJuA=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
Date:   Mon, 09 Oct 2023 14:59:51 +0200
Message-ID: <5718037.DvuYhMxLoT@natalenko.name>
In-Reply-To: <DM4PR12MB63512D20912A9F66561B9FA1F7CEA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <12301186.O9o76ZdvQC@natalenko.name>
 <DM4PR12MB63512D20912A9F66561B9FA1F7CEA@DM4PR12MB6351.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5979562.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--nextPart5979562.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
Date: Mon, 09 Oct 2023 14:59:51 +0200
Message-ID: <5718037.DvuYhMxLoT@natalenko.name>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 9. =C5=99=C3=ADjna 2023 9:23:29 CEST Meng, Li (Jassmin=
e) wrote:
> [AMD Official Use Only - General]
>=20
> Hi Oleksandr:
>=20
> > -----Original Message-----
> > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Sent: Monday, October 9, 2023 2:55 PM
> > To: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > x86@kernel.org; linux-acpi@vger.kernel.org; Shuah Khan
> > <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org; Fontenot,
> > Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> > Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> > Borislav Petkov <bp@alien8.de>; Meng, Li (Jassmine) <Li.Meng@amd.com>
> > Subject: Re: [PATCH V8 0/7] amd-pstate preferred core
> >
> > Hello.
> >
> > On pond=C4=9Bl=C3=AD 9. =C5=99=C3=ADjna 2023 4:49:25 CEST Meng Li wrote:
> > > Hi all:
> > >
> > > The core frequency is subjected to the process variation in semicondu=
ctors.
> > > Not all cores are able to reach the maximum frequency respecting the
> > > infrastructure limits. Consequently, AMD has redefined the concept of
> > > maximum frequency of a part. This means that a fraction of cores can
> > > reach maximum frequency. To find the best process scheduling policy
> > > for a given scenario, OS needs to know the core ordering informed by
> > > the platform through highest performance capability register of the C=
PPC
> > interface.
> > >
> > > Earlier implementations of amd-pstate preferred core only support a
> > > static core ranking and targeted performance. Now it has the ability
> > > to dynamically change the preferred core based on the workload and
> > > platform conditions and accounting for thermals and aging.
> > >
> > > Amd-pstate driver utilizes the functions and data structures provided
> > > by the ITMT architecture to enable the scheduler to favor scheduling
> > > on cores which can be get a higher frequency with lower voltage.
> > > We call it amd-pstate preferred core.
> > >
> > > Here sched_set_itmt_core_prio() is called to set priorities and
> > > sched_set_itmt_support() is called to enable ITMT feature.
> > > Amd-pstate driver uses the highest performance value to indicate the
> > > priority of CPU. The higher value has a higher priority.
> > >
> > > Amd-pstate driver will provide an initial core ordering at boot time.
> > > It relies on the CPPC interface to communicate the core ranking to the
> > > operating system and scheduler to make sure that OS is choosing the
> > > cores with highest performance firstly for scheduling the process.
> > > When amd-pstate driver receives a message with the highest performance
> > > change, it will update the core ranking.
> > >
> > > Changes form V7->V8:
> > > - all:
> > > - - pick up Review-By flag added by Mario and Ray.
> > > - cpufreq: amd-pstate:
> > > - - use hw_prefcore embeds into cpudata structure.
> > > - - delete preferred core init from cpu online/off.
> >
> > Could you please let me know if this change means a fix for the report =
I've
> > sent previously? [1]
> >
> [Meng, Li (Jassmine)] Yes.
> I have deleted online handle function of amd pstate driver.
> It doesn't re-initialize preferred core.
> This online function will set incorrect des perf value.

Thank you for the confirmation. I've built v6.5.5 with this patchset applie=
d, and now the frequency is as expected after the suspend-resume cycle.

I've also added the following modification to accommodate recent feedback:

```
commit 1450ac395434c532f995521e1a2497d09ddf106c
Author: Oleksandr Natalenko <oleksandr@natalenko.name>
Date:   Mon Oct 9 11:19:50 2023 +0200

    cpufreq/amd-pstate: show prefcore_ranking separately
   =20
    Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d3369247c6c9c..86999d861e87b 100644
=2D-- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -954,6 +954,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpu=
freq_policy *policy,
 	u32 perf;
 	struct amd_cpudata *cpudata =3D policy->driver_data;
=20
+	perf =3D READ_ONCE(cpudata->highest_perf);
+
+	return sysfs_emit(buf, "%u\n", perf);
+}
+
+static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *pol=
icy,
+						char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata =3D policy->driver_data;
+
 	perf =3D READ_ONCE(cpudata->prefcore_ranking);
=20
 	return sysfs_emit(buf, "%u\n", perf);
@@ -1172,6 +1183,7 @@ cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
=20
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
@@ -1182,6 +1194,7 @@ static struct freq_attr *amd_pstate_attr[] =3D {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	NULL,
 };
@@ -1190,6 +1203,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
```

with the following output as a result:

```
[~]> grep . /sys/devices/system/cpu*/cpufreq/policy*/amd_pstate_highest_perf
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy1/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy2/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy3/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy4/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy5/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy6/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy7/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy8/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy9/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy10/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy11/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy12/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy13/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy14/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy15/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy16/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy17/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy18/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy19/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy20/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy21/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy22/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy23/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy24/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy25/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy26/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy27/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy28/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy29/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy30/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy31/amd_pstate_highest_perf:166

[~]> grep . /sys/devices/system/cpu*/cpufreq/policy*/amd_pstate_hw_prefcore
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy1/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy2/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy3/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy4/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy5/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy6/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy7/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy8/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy9/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy10/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy11/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy12/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy13/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy14/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy15/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy16/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy17/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy18/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy19/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy20/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy21/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy22/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy23/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy24/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy25/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy26/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy27/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy28/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy29/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy30/amd_pstate_hw_prefcore:supported
/sys/devices/system/cpu/cpufreq/policy31/amd_pstate_hw_prefcore:supported

[~]> grep . /sys/devices/system/cpu*/cpufreq/policy*/amd_pstate_prefcore_ra=
nking
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking:226
/sys/devices/system/cpu/cpufreq/policy1/amd_pstate_prefcore_ranking:231
/sys/devices/system/cpu/cpufreq/policy2/amd_pstate_prefcore_ranking:211
/sys/devices/system/cpu/cpufreq/policy3/amd_pstate_prefcore_ranking:236
/sys/devices/system/cpu/cpufreq/policy4/amd_pstate_prefcore_ranking:216
/sys/devices/system/cpu/cpufreq/policy5/amd_pstate_prefcore_ranking:236
/sys/devices/system/cpu/cpufreq/policy6/amd_pstate_prefcore_ranking:206
/sys/devices/system/cpu/cpufreq/policy7/amd_pstate_prefcore_ranking:221
/sys/devices/system/cpu/cpufreq/policy8/amd_pstate_prefcore_ranking:191
/sys/devices/system/cpu/cpufreq/policy9/amd_pstate_prefcore_ranking:201
/sys/devices/system/cpu/cpufreq/policy10/amd_pstate_prefcore_ranking:186
/sys/devices/system/cpu/cpufreq/policy11/amd_pstate_prefcore_ranking:196
/sys/devices/system/cpu/cpufreq/policy12/amd_pstate_prefcore_ranking:171
/sys/devices/system/cpu/cpufreq/policy13/amd_pstate_prefcore_ranking:166
/sys/devices/system/cpu/cpufreq/policy14/amd_pstate_prefcore_ranking:176
/sys/devices/system/cpu/cpufreq/policy15/amd_pstate_prefcore_ranking:181
/sys/devices/system/cpu/cpufreq/policy16/amd_pstate_prefcore_ranking:226
/sys/devices/system/cpu/cpufreq/policy17/amd_pstate_prefcore_ranking:231
/sys/devices/system/cpu/cpufreq/policy18/amd_pstate_prefcore_ranking:211
/sys/devices/system/cpu/cpufreq/policy19/amd_pstate_prefcore_ranking:236
/sys/devices/system/cpu/cpufreq/policy20/amd_pstate_prefcore_ranking:216
/sys/devices/system/cpu/cpufreq/policy21/amd_pstate_prefcore_ranking:236
/sys/devices/system/cpu/cpufreq/policy22/amd_pstate_prefcore_ranking:206
/sys/devices/system/cpu/cpufreq/policy23/amd_pstate_prefcore_ranking:221
/sys/devices/system/cpu/cpufreq/policy24/amd_pstate_prefcore_ranking:191
/sys/devices/system/cpu/cpufreq/policy25/amd_pstate_prefcore_ranking:201
/sys/devices/system/cpu/cpufreq/policy26/amd_pstate_prefcore_ranking:186
/sys/devices/system/cpu/cpufreq/policy27/amd_pstate_prefcore_ranking:196
/sys/devices/system/cpu/cpufreq/policy28/amd_pstate_prefcore_ranking:171
/sys/devices/system/cpu/cpufreq/policy29/amd_pstate_prefcore_ranking:166
/sys/devices/system/cpu/cpufreq/policy30/amd_pstate_prefcore_ranking:176
/sys/devices/system/cpu/cpufreq/policy31/amd_pstate_prefcore_ranking:181
```

When I run `dd if=3D/dev/zero of=3D/dev/null`, the load lands onto cores 3,=
 5, 19 or 21, IOW, those that have the highest `amd_pstate_prefcore_ranking=
` value given `schedutil` is in use.

If all of the above is as expected, please add:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

> > Would you also be able to Cc me on the next iteration of this patchset?
> [Meng, Li (Jassmine)] OK.

Thanks.

> >
> > Thank you!
> >
> > [1] https://lore.kernel.org/lkml/5973628.lOV4Wx5bFT@natalenko.name/
> >
> > >
> > > Changes form V6->V7:
> > > - x86:
> > > - - Modify kconfig about X86_AMD_PSTATE.
> > > - cpufreq: amd-pstate:
> > > - - modify incorrect comments about scheduler_work().
> > > - - convert highest_perf data type.
> > > - - modify preferred core init when cpu init and online.
> > > - acpi: cppc:
> > > - - modify link of CPPC highest performance.
> > > - cpufreq:
> > > - - modify link of CPPC highest performance changed.
> > >
> > > Changes form V5->V6:
> > > - cpufreq: amd-pstate:
> > > - - modify the wrong tag order.
> > > - - modify warning about hw_prefcore sysfs attribute.
> > > - - delete duplicate comments.
> > > - - modify the variable name cppc_highest_perf to prefcore_ranking.
> > > - - modify judgment conditions for setting highest_perf.
> > > - - modify sysfs attribute for CPPC highest perf to pr_debug message.
> > > - Documentation: amd-pstate:
> > > - - modify warning: title underline too short.
> > >
> > > Changes form V4->V5:
> > > - cpufreq: amd-pstate:
> > > - - modify sysfs attribute for CPPC highest perf.
> > > - - modify warning about comments
> > > - - rebase linux-next
> > > - cpufreq:
> > > - - Moidfy warning about function declarations.
> > > - Documentation: amd-pstate:
> > > - - align with ``amd-pstat``
> > >
> > > Changes form V3->V4:
> > > - Documentation: amd-pstate:
> > > - - Modify inappropriate descriptions.
> > >
> > > Changes form V2->V3:
> > > - x86:
> > > - - Modify kconfig and description.
> > > - cpufreq: amd-pstate:
> > > - - Add Co-developed-by tag in commit message.
> > > - cpufreq:
> > > - - Modify commit message.
> > > - Documentation: amd-pstate:
> > > - - Modify inappropriate descriptions.
> > >
> > > Changes form V1->V2:
> > > - acpi: cppc:
> > > - - Add reference link.
> > > - cpufreq:
> > > - - Moidfy link error.
> > > - cpufreq: amd-pstate:
> > > - - Init the priorities of all online CPUs
> > > - - Use a single variable to represent the status of preferred core.
> > > - Documentation:
> > > - - Default enabled preferred core.
> > > - Documentation: amd-pstate:
> > > - - Modify inappropriate descriptions.
> > > - - Default enabled preferred core.
> > > - - Use a single variable to represent the status of preferred core.
> > >
> > > Meng Li (7):
> > >   x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
> > >   acpi: cppc: Add get the highest performance cppc control
> > >   cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
> > >   cpufreq: Add a notification message that the highest perf has chang=
ed
> > >   cpufreq: amd-pstate: Update amd-pstate preferred core ranking
> > >     dynamically
> > >   Documentation: amd-pstate: introduce amd-pstate preferred core
> > >   Documentation: introduce amd-pstate preferrd core mode kernel
> > command
> > >     line options
> > >
> > >  .../admin-guide/kernel-parameters.txt         |   5 +
> > >  Documentation/admin-guide/pm/amd-pstate.rst   |  59 +++++-
> > >  arch/x86/Kconfig                              |   5 +-
> > >  drivers/acpi/cppc_acpi.c                      |  13 ++
> > >  drivers/acpi/processor_driver.c               |   6 +
> > >  drivers/cpufreq/amd-pstate.c                  | 186 ++++++++++++++++=
=2D-
> > >  drivers/cpufreq/cpufreq.c                     |  13 ++
> > >  include/acpi/cppc_acpi.h                      |   5 +
> > >  include/linux/amd-pstate.h                    |  10 +
> > >  include/linux/cpufreq.h                       |   5 +
> > >  10 files changed, 285 insertions(+), 22 deletions(-)
> > >
> > >
> >
> >
> > --
> > Oleksandr Natalenko (post-factum)
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5979562.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUj+UcACgkQil/iNcg8
M0ufew//Uuqt6V9vN3k5my7d3pOKc0mdisLT/VGfY8gXDB2P3CAhpYHmo5yvEZ16
0OJgF/uWTWcw0USw6ITTO9UhcaLrxAk3nVkkJcUZY0WEjvjtoAdA2ubkVb97p2dy
6P521zyPeeVZNvBW/lP0d/5KrIWl44LFCumJOYGRnumn68I0+HCb7LzN2tPsAZvX
vU8G/Jur9dqsSQ0y/bKKVvweocwgeBezKIaXUnl+SaemXg231pW2t68/OigUqFWM
JdtY8CFf6Q+YQ5oDuSULCBJR5PbwPikc24B0IL9aKkWnZXgPBKQoLkStrDtZhPdS
GGqSom7vm+0jU+PmJjf5MtOch4+P3rIzSfCOIFSPMoaxNlSMDSfJwtfI80dRosNO
1WodeheGhaSRYnO9nw0hn/LszptAFJSBO7wBeYygHSwDRZd5HyZmCBRopP5nepWu
a4k7vrNzwwj9K6Llxe2n3/rUbfvUX1ozLSsIjRGknEP0/nrKdA+o6v3RyNzV9Qni
xjZWEr3dDI2qpfqkviDytFSbR4OZO6tZF0pshaBZQWWCF+77qZcJr8V9BMDegA5R
lcTsjSQHi/5/l2ruE0La6SW2Fv+DFAKdn9fk8/QjbZs6hbjwB3NExkW+GdBbad9t
2GAZWLtVS3+2l/KEAO8gHUhrAcyHogxSiN5qYn3OQZIPcuTvXI4=
=VmGM
-----END PGP SIGNATURE-----

--nextPart5979562.lOV4Wx5bFT--



