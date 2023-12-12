Return-Path: <linux-kselftest+bounces-1670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67880EDE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961F92814BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92834675D7;
	Tue, 12 Dec 2023 13:43:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAAFD;
	Tue, 12 Dec 2023 05:43:53 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-590a21e977aso139156eaf.1;
        Tue, 12 Dec 2023 05:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388633; x=1702993433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+kkVTreOL3w+OZGcOfK3FYPANHbgoXJuOH1K8tFH4g=;
        b=iigb1OZrH2QZ9p4i4fu9i9YQBUVcZHlB5z0g6vpa5kAGmppjJ/D3EVslvujVKVcpgq
         HzE7AXULnv2rQ6ELFzjdHW1lzspj3Ael8VzPB1ARA7nxzaxEr76SliB9SCVuqaOPw/Qv
         L5r6QGYhdxRVXbfL5FwTI+kZcOv1qTzXtdh9UQUIRnzhLyZMO8x1FT1DtseBxAtjbVp4
         LPSPLsRYf9KAq/H4dUm2s3PcYTMbP0YqhEHESdl8vR4rHf8bNhWe0n67TrrMfUxwt5vy
         gadOxtpsrT8gBXVNccXvCfRVck7Q1Pc1SWUST/pTfG7zZLippDCZe4EuxU0LgA36cOaB
         t6nw==
X-Gm-Message-State: AOJu0YzA4dT3h8N9PHw8q7Lro/KxOB04OD1Vjeds4KQsQOAkC9eIOoma
	pAa/HZMAo3jVGxXa55lxjmmQQqYVzB2xxs6jzE4=
X-Google-Smtp-Source: AGHT+IGUqXNEdQXxBJDrx70lgBxugTVgc/vHxJshrpTuCUW1HytFQm132e4bZb55zISGfBUjiTzP1pULdprZDX/oFgo=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10175400ooq.1.1702388633020; Tue, 12 Dec
 2023 05:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-5-li.meng@amd.com>
 <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com> <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:43:42 +0100
Message-ID: <CAJZ5v0gYj6C_-m7dD_aN-FWiuLn6bG9MRTe_c7SryTtJJN7FKA@mail.gmail.com>
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

On Wed, Dec 6, 2023 at 10:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 6, 2023 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Tue, Dec 5, 2023 at 7:38=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
> > >
> > > ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> > > emmitted to cause the the OSPM to re-evaluate the highest performance
> >
> > Typos above.  Given the number of iterations of this patch, this is
> > kind of disappointing.
> >
> > > register. Add support for this event.
> >
> > Also it would be nice to describe how this is supposed to work at
> > least roughly, so it is not necessary to reverse-engineer the patch to
> > find out that.
> >
> > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > > Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> > > Signed-off-by: Meng Li <li.meng@amd.com>
> > > Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Mo=
del.html#processor-device-notification-values
> > > ---
> > >  drivers/acpi/processor_driver.c |  6 ++++++
> > >  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
> > >  include/linux/cpufreq.h         |  5 +++++
> > >  3 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> > > index 4bd16b3f0781..29b2fb68a35d 100644
> > > --- a/drivers/acpi/processor_driver.c
> > > +++ b/drivers/acpi/processor_driver.c
> > > @@ -27,6 +27,7 @@
> > >  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
> > >  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
> > >  #define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> > > +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED      0x85
> > >
> > >  MODULE_AUTHOR("Paul Diefenbaugh");
> > >  MODULE_DESCRIPTION("ACPI Processor Driver");
> > > @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle hand=
le, u32 event, void *data)
> > >                 acpi_bus_generate_netlink_event(device->pnp.device_cl=
ass,
> > >                                                   dev_name(&device->d=
ev), event, 0);
> > >                 break;
> > > +       case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> > > +               cpufreq_update_highest_perf(pr->id);
> >
> > And the design appears to be a bit ad-hoc here.
> >
> > Because why does it have anything to do with cpufreq?
>
> Well, clearly, cpufreq can be affected by this, but why would it be
> not affected the same way as in the ACPI_PROCESSOR_NOTIFY_PERFORMANCE
> case?
>
> That is, why isn't cpufreq_update_limits() the right thing to do?

Seriously, I'm not going to apply this patch so long as my comments
above are not addressed.

