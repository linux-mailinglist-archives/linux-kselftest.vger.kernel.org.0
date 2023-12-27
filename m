Return-Path: <linux-kselftest+bounces-2478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11981F0AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E251C21AD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E445C19;
	Wed, 27 Dec 2023 17:04:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAB46521;
	Wed, 27 Dec 2023 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-593f182f263so1107882eaf.0;
        Wed, 27 Dec 2023 09:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703696646; x=1704301446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChF2D9NuT+aryC9LIMkklXUUM4qM6A4dzbxpF9Dkw5Y=;
        b=S0ymUDVZJf8ldiOgXGya3BW4hV/HBeTINh+QalV9yX5RbGTxsLjlx8l/qG/O89u7U/
         X25KDQXd+bRIOx579UrXp5DoR3f1+t+2ht79b2pryR60ZABBca+e7WWdbFvea17i3O8+
         wcnqxA6zvNMFZUso6Tf39l4yeEvTB+dP/7C0tAohzaOtCOuouqB+5fDIc3LB+dxuakPw
         sgfqFcAjg+BRPB0WA6bizrjJcYtiKla0fFxYqbPk8uklMp99GdhefkfMTAdGSAPgV/sp
         mYhSNflEJh0EmCR/3FQktwvRFkRaRrO+Hi0DoPxJ62jbmv0OehqUzzGyYsIj+gH2Kzuj
         uzmw==
X-Gm-Message-State: AOJu0YymX2HBltTR7DW6p4RCIbXEpZB01BWbRKhC9EGtWsfzywX2MgOz
	loMvAoI6BnqxHnwcFSrHDQBsL8QCmoAzLcPFrVE=
X-Google-Smtp-Source: AGHT+IFVqwsopcL3FWguuGTYMy2Bpr8eEz81q/YxplhwEAyn7vCzQwSbkj+x7JRglbxNnSL/PeJ0coTY4MtFswVM8nA=
X-Received: by 2002:a4a:c719:0:b0:594:c433:66e6 with SMTP id
 n25-20020a4ac719000000b00594c43366e6mr3541007ooq.0.1703696646434; Wed, 27 Dec
 2023 09:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-5-li.meng@amd.com>
 <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
 <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
 <CAJZ5v0gYj6C_-m7dD_aN-FWiuLn6bG9MRTe_c7SryTtJJN7FKA@mail.gmail.com>
 <DM4PR12MB635185821F31AFB0D2655D01F798A@DM4PR12MB6351.namprd12.prod.outlook.com>
 <DM4PR12MB6351C4ADE9E48A06482027B0F79FA@DM4PR12MB6351.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB6351C4ADE9E48A06482027B0F79FA@DM4PR12MB6351.namprd12.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Dec 2023 18:03:48 +0100
Message-ID: <CAJZ5v0iriUv8ZMLYz43AB88rQL2DdP3Wn8WwF00XWhZyce+eYw@mail.gmail.com>
Subject: Re: [PATCH V12 4/7] cpufreq: Add a notification message that the
 highest perf has changed
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	"Huang, Ray" <Ray.Huang@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "Sharma, Deepak" <Deepak.Sharma@amd.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, 
	"Yuan, Perry" <Perry.Yuan@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 2:40=E2=80=AFAM Meng, Li (Jassmine) <Li.Meng@amd.co=
m> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Rafael:
>
> > -----Original Message-----
> > From: Meng, Li (Jassmine)
> > Sent: Tuesday, December 26, 2023 4:27 PM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> > <Ray.Huang@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; x86@kernel.org; linux-acpi@vger.kernel.org; Shu=
ah
> > Khan <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org;
> > Fontenot, Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> > Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> > Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> > <oleksandr@natalenko.name>
> > Subject: RE: [PATCH V12 4/7] cpufreq: Add a notification message that t=
he
> > highest perf has changed
> >
> > Hi Rafael:
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Tuesday, December 12, 2023 9:44 PM
> > > To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> > > Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> > > <Ray.Huang@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; x86@kernel.org; linux-acpi@vger.kernel.org;
> > > Shuah Khan <skhan@linuxfoundation.org>;
> > > linux-kselftest@vger.kernel.org; Fontenot, Nathan
> > > <Nathan.Fontenot@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>;
> > > Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian
> > <Xiaojian.Du@amd.com>;
> > > Viresh Kumar <viresh.kumar@linaro.org>; Borislav Petkov
> > > <bp@alien8.de>; Oleksandr Natalenko <oleksandr@natalenko.name>
> > > Subject: Re: [PATCH V12 4/7] cpufreq: Add a notification message that
> > > the highest perf has changed
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Wed, Dec 6, 2023 at 10:13=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org>
> > > wrote:
> > > >
> > > > On Wed, Dec 6, 2023 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org>
> > > wrote:
> > > > >
> > > > > On Tue, Dec 5, 2023 at 7:38=E2=80=AFAM Meng Li <li.meng@amd.com> =
wrote:
> > > > > >
> > > > > > ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85
> > > > > > can be emmitted to cause the the OSPM to re-evaluate the highes=
t
> > > > > > performance
> > > > >
> > > > > Typos above.  Given the number of iterations of this patch, this
> > > > > is kind of disappointing.
> > > > >
> > > > > > register. Add support for this event.
> > > > >
> > > > > Also it would be nice to describe how this is supposed to work at
> > > > > least roughly, so it is not necessary to reverse-engineer the
> > > > > patch to find out that.
> > > > >
> > > > > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > > > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > > > > > Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> > > > > > Signed-off-by: Meng Li <li.meng@amd.com>
> > > > > > Link:
> > > > > >
> > > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model
> > > > > > .html#processor-device-notification-values
> > > > > > ---
> > > > > >  drivers/acpi/processor_driver.c |  6 ++++++
> > > > > >  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
> > > > > >  include/linux/cpufreq.h         |  5 +++++
> > > > > >  3 files changed, 24 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/acpi/processor_driver.c
> > > > > > b/drivers/acpi/processor_driver.c index
> > > > > > 4bd16b3f0781..29b2fb68a35d
> > > > > > 100644
> > > > > > --- a/drivers/acpi/processor_driver.c
> > > > > > +++ b/drivers/acpi/processor_driver.c
> > > > > > @@ -27,6 +27,7 @@
> > > > > >  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> > > > > >  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
> > > > > >  #define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> > > > > > +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED
> > 0x85
> > > > > >
> > > > > >  MODULE_AUTHOR("Paul Diefenbaugh");
> > > MODULE_DESCRIPTION("ACPI
> > > > > > Processor Driver"); @@ -83,6 +84,11 @@ static void
> > > > > > acpi_processor_notify(acpi_handle handle, u32 event, void *data=
)
> > > > > >                 acpi_bus_generate_netlink_event(device->pnp.dev=
ice_class,
> > > > > >                                                   dev_name(&dev=
ice->dev), event, 0);
> > > > > >                 break;
> > > > > > +       case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> > > > > > +               cpufreq_update_highest_perf(pr->id);
> > > > >
> > > > > And the design appears to be a bit ad-hoc here.
> > > > >
> > > > > Because why does it have anything to do with cpufreq?
> > > >
> > > > Well, clearly, cpufreq can be affected by this, but why would it be
> > > > not affected the same way as in the
> > > ACPI_PROCESSOR_NOTIFY_PERFORMANCE
> > > > case?
> > > >
> > > > That is, why isn't cpufreq_update_limits() the right thing to do?
> > >
> > > Seriously, I'm not going to apply this patch so long as my comments
> > > above are not addressed.
> > [Meng, Li (Jassmine)]
> > Sorry for the delayed reply to the email.
> > BIOS/AGESA is responsible to issue the Notify 0x85 to OS that the prefe=
rred
> > core has changed.
> > It will only affect the ranking of the preferred core, not the impact p=
olicy
> > limits.
> > AMD P-state driver will set the priority of the cores based on the pref=
erred
> > core ranking, and prioritize selecting higher priority core to run the =
task.
> [Meng, Li (Jassmine)]
> From ACPI v6.5, Table 5.197 Processor Device Notification Values:
> Hex value               Description
> 0x80                    Performance Present Capabilities Changed. Used to=
 notify OSPM that the number of supported processor performance states has =
changed. This notification causes OSPM to re-evaluate the _PPC object. See =
Section 8.4.5.3 for more information.
>
> 0x85                    Highest Performance Changed. Used to notify OSPM =
that the value of the CPPC Highest Performance Register has changed.
>
> I think they are different notify events, so they need different function=
s to handle these events.

But they effectively mean pretty much the same thing: the highest
available performance state of the CPU has changed.

Why would the response need to be different?

