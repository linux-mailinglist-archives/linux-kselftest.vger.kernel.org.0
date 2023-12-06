Return-Path: <linux-kselftest+bounces-1327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DC807A30
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 22:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0270C1F21858
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB036EB5A;
	Wed,  6 Dec 2023 21:13:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760AFD5B;
	Wed,  6 Dec 2023 13:13:12 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fae54afb66so36735fac.1;
        Wed, 06 Dec 2023 13:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897191; x=1702501991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFsoZNpkyJn47ZwKMdi9sP3iJ2LR9kBDxH0bVwrrCjc=;
        b=maRjG98B8KQRJS70V1MajVCuW0Kh0srSeE2lVBEp0ET2q27fLzvNUX1AU3Y+u3WwF5
         dzHwB5ratd61/MkBLpqmxX21BUPmCU4XG+ERGVpO5Om+NqVjxYOc3/c+dW+NIDck04TX
         u0yV6TbIEG6/gTj+PmHtUv5kaoKS8YTXF2qMAbYhnkdPuteVZrRgUNkpZjCjDIc5NsVd
         QiZbz4rwdTLbs8PCJEhPBKBhO+S05Hkr9QARsHsi3CJ5FNZ3O/oCWFceHDhiMFxV1ReR
         Vhx35BVSIUYeBf+SkT24IPucb4rBhYQhFBFULJUEtgObu3GSQn7pCEDv8dNioKvEf42g
         w+UQ==
X-Gm-Message-State: AOJu0YyAvDBV4FGEHE1WcudOEWHrWe6Abxbl6ibqAzCM7dp5C701WxFX
	i4Dhl2JYHZp1foBV+hI4tSSA1JwE4uKglxAz29g=
X-Google-Smtp-Source: AGHT+IEOX8vI91Uo/xk0HohK4105WhBHzaTXQyrb9EaDx76RReLo4RomS8An2VWI2SUe0jhfQIceSuilyjwuCIl73TQ=
X-Received: by 2002:a05:6870:944d:b0:1fa:df87:4eba with SMTP id
 e13-20020a056870944d00b001fadf874ebamr2694804oal.5.1701897191604; Wed, 06 Dec
 2023 13:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-5-li.meng@amd.com>
 <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 22:13:00 +0100
Message-ID: <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
Subject: Re: [PATCH V12 4/7] cpufreq: Add a notification message that the
 highest perf has changed
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Dec 5, 2023 at 7:38=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
> >
> > ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> > emmitted to cause the the OSPM to re-evaluate the highest performance
>
> Typos above.  Given the number of iterations of this patch, this is
> kind of disappointing.
>
> > register. Add support for this event.
>
> Also it would be nice to describe how this is supposed to work at
> least roughly, so it is not necessary to reverse-engineer the patch to
> find out that.
>
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Mode=
l.html#processor-device-notification-values
> > ---
> >  drivers/acpi/processor_driver.c |  6 ++++++
> >  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
> >  include/linux/cpufreq.h         |  5 +++++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
> > index 4bd16b3f0781..29b2fb68a35d 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -27,6 +27,7 @@
> >  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> >  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
> >  #define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> > +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED      0x85
> >
> >  MODULE_AUTHOR("Paul Diefenbaugh");
> >  MODULE_DESCRIPTION("ACPI Processor Driver");
> > @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle=
, u32 event, void *data)
> >                 acpi_bus_generate_netlink_event(device->pnp.device_clas=
s,
> >                                                   dev_name(&device->dev=
), event, 0);
> >                 break;
> > +       case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> > +               cpufreq_update_highest_perf(pr->id);
>
> And the design appears to be a bit ad-hoc here.
>
> Because why does it have anything to do with cpufreq?

Well, clearly, cpufreq can be affected by this, but why would it be
not affected the same way as in the ACPI_PROCESSOR_NOTIFY_PERFORMANCE
case?

That is, why isn't cpufreq_update_limits() the right thing to do?

