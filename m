Return-Path: <linux-kselftest+bounces-36149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C53AEEFFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86E17AA60E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EA325C6EE;
	Tue,  1 Jul 2025 07:46:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530525A2D2;
	Tue,  1 Jul 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355963; cv=none; b=dLGgiu4F6aKyXSBzzGd94EnATkotRjeRhqIEydC81VeIZwJOjEazGE6yDVStgztdIXnwZOGlIqL/2T84HQJE85sT7UT/g4x4VrOH/RhkEE32Rx1yikgaZR2O7WvrUnlj4hXPNVGKURz/HSLHrL1ZrF352eM9a2DT5qXrNjEtA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355963; c=relaxed/simple;
	bh=KYCIopdcYOqITgSHrx5R2OAh+KSRtv99A2CuSNv+DUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mle9CuAUblr1s1bdEqpYuMnH0dJeP+g0TuR2WzFG6roBjQhhjcWglHY+K79EG8ci8gk8uT0fsDQFzWMDVWSe3hyYEH2fG/ZYiITTkyIhbWbyoqfUUqsxmw7hH5bH+R/nDO4aMo/I+gb+bVSyUwSP/mOvGbdTfBsRgIzp1tvIB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso3284844137.3;
        Tue, 01 Jul 2025 00:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751355959; x=1751960759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCqKuQsKUMvVOd8fh20zK2WhSobsJMoICT4U7xI4uWs=;
        b=UeN3Kes6R5BuV+s7VXDIbh7f5jSeT1AvAAO0jsWOt9eITGUL9hOHJ4vugj3bezAVKW
         JlAriYJDQHMshYMbptJc6Wl0A+5Q5+CeUBOkRJ3s1lPwRp6+EyRd2W78A60EzxEtQiOw
         gsLnfw+RrT/Q/wSdbq/AVcajS4ljsjo+atug2Csf6sIRzSkqiB5EjpI8p0J2ch+OysK3
         p9JBZAA5TX25ul9FXmxDYvXpPZzhNxOtVKrhDbPXWQRwX4GR+B1HNF0dE7ZRFzpxtPhC
         5uPKVdJGbZY2ipaY4Br80hcim4gPg6NdMakKJM3chtpqCvr50ix05SbhrJsWP/hIwEgp
         Jvqg==
X-Forwarded-Encrypted: i=1; AJvYcCUdE0PWKbG5P3MZ9t8+qMsxA+E4quagmDVSP9Tu6Iueuq/BSnAY9VmHnz0d/p6STTNPZCjxqz4Rg23d@vger.kernel.org, AJvYcCW3FfBTkke+wi3tiJIJWsE2PExpTPvj+V+BWycRiyyzpmRqWPB1QW7enkh9/Y0MmTJSNp8fT397vtE/DY8=@vger.kernel.org, AJvYcCWt8DlF+IZXvQdOHPwl8omWplsxe9gA3anI3a3ob/7/2J3auBSDwWn4YmObbJLy/Utopx5ZpmN7wEj9DNeGR2+o@vger.kernel.org
X-Gm-Message-State: AOJu0YxedoiyKR8nwdForGp1NWaakBx6G/mFCNP9lD4cK4vYb5Z+eN+g
	GtX8o1lRI3qm4gTQ574A9gge9FuWULJQCRSvxoplV7YvKX8HawsFa3jskkfNwgjX
X-Gm-Gg: ASbGncteRnxd5F5FIoJtu1kJb7ZSChEBCCnXZy/m9Qr1F0HpLxJq1SHn79LaWYnGnqP
	yVOS8vWPUo0IUTzJlluAKrMftyiulrGlFY8SYsG5U+//4US5aN5UXCUkNHNSE74pKm2lyYB/vqI
	JNTT616c8wMRv48OW5PbPsdctNtIpxQHDr4+u4e8YAxD90QBOlVRVq/R27d7/OQri5ivROCExqF
	hlxCPYmywHj5AJ0stv/Pn6vZJQpri3Jw6raDgnvsgqiK9TSJpwy0VKAzm+jsBII3prpe3UmTQ6P
	QCCqOReg3GBBfZ9wZUmuJzT+QMIBjbdR8pJrbgciXFEjMyG2kzMcEVqjV8y+70AnkKEFuvTmRYK
	/MxTGNY+CN+3f8L4Mc53ATeVF
X-Google-Smtp-Source: AGHT+IFg699sb/+HbMpCJb8GeCilEaSMOJASSrDAdaYqyFI+aCqPg52MWr0l9OODohnGrJSXwC4WMg==
X-Received: by 2002:a05:6102:418a:b0:4e5:fe5e:2be4 with SMTP id ada2fe7eead31-4ee4f797facmr10896780137.22.1751355958885;
        Tue, 01 Jul 2025 00:45:58 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1db717esm1983189241.31.2025.07.01.00.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:45:58 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e9a7bfb3c8so3241541137.1;
        Tue, 01 Jul 2025 00:45:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJyiZtLQx7+DpLzT3clBEd7M84Qp2cpbb2ITulMbee/Jj0wo++MLSoOPxR7hk63MA4iM/gc9gHXP/K@vger.kernel.org, AJvYcCWZaIqajG4/iKVBgtp6WpdinY7Rdf1Wnc8Hs3fBPfjRpBfVBKEtSV8YFmwhyi1NU+7yMQMrF4Uf0olWiLuAAJfY@vger.kernel.org, AJvYcCWdgPbHFNvmj4GEqFnmxA3h9q3uEuFE1G/fTjRRvH2F8P16sn7+56z6NYm/wOmhN3N6mU0VNUQoA/W03EA=@vger.kernel.org
X-Received: by 2002:a05:6102:4496:b0:4e9:d951:1433 with SMTP id
 ada2fe7eead31-4ee4f6f56b5mr10527393137.12.1751355957915; Tue, 01 Jul 2025
 00:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df1a73d4a14426ae0d3e8809aed40c686b67dd3e.1751268290.git.geert@linux-m68k.org>
 <20250630135427faa6c326@mail.local>
In-Reply-To: <20250630135427faa6c326@mail.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Jul 2025 09:45:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVPDVXXYH5OJyZ0dfbU0YLfc4sUGR=o=vu1PmWGne3dZw@mail.gmail.com>
X-Gm-Features: Ac12FXwzaZ2nSq3Yc2pDrxcBOc4U-ud6Sw62tPOF4ay8rPLS8aOCdzlcQBP69Bs
Message-ID: <CAMuHMdVPDVXXYH5OJyZ0dfbU0YLfc4sUGR=o=vu1PmWGne3dZw@mail.gmail.com>
Subject: Re: [PATCH resend] rtc: Rename lib_test to rtc_lib_test
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Alex.

On Mon, 30 Jun 2025 at 15:54, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 30/06/2025 09:47:54+0200, Geert Uytterhoeven wrote:
> > When compiling the RTC library functions test as a module, the module
> > has the non-descriptive name "lib_test.ko".  Fix this by adding the
> > subsystem's name as a prefix.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/rtc/Makefile                       | 2 +-
> >  drivers/rtc/{lib_test.c => rtc_lib_test.c} | 0
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >  rename drivers/rtc/{lib_test.c => rtc_lib_test.c} (100%)
> >
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> > index 4619aa2ac4697591..aa08d1c8a32ec23d 100644
> > --- a/drivers/rtc/Makefile
> > +++ b/drivers/rtc/Makefile
> > @@ -15,7 +15,7 @@ rtc-core-$(CONFIG_RTC_INTF_DEV)             += dev.o
> >  rtc-core-$(CONFIG_RTC_INTF_PROC)     += proc.o
> >  rtc-core-$(CONFIG_RTC_INTF_SYSFS)    += sysfs.o
> >
> > -obj-$(CONFIG_RTC_LIB_KUNIT_TEST)     += lib_test.o
> > +obj-$(CONFIG_RTC_LIB_KUNIT_TEST)     += rtc_lib_test.o
>
> I'd rather have test_rtc_lib as only the drivers are currently prefixed with
> rtc.

Your wish is my command; v2 sent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

