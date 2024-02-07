Return-Path: <linux-kselftest+bounces-4285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9F84D381
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 22:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732211F243AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C8128360;
	Wed,  7 Feb 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljSFTzJ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09541127B65
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340314; cv=none; b=W4k27F2TUzr7aMaHojeUyQhKTLZJ/sVMbQ8XxejNDFEE6stUVCGLFgr0o1YO5dkpFdYHIO4L0p/+o4xO4bSkfupWgWShHQmBM02qlxHTAVWNzpWkjDCMCCAVjJXkxsGRV+U3dr1h6D9ZBtQbg/Dbcih8G/jfzspRv8gZYxDh9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340314; c=relaxed/simple;
	bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUT1CzGuWXf6GEUTQriboJVN7sL7Qgn7GPOx6kwdoCdtG1Gnmlu/q5JcopxgfuDT+RRL2lXq0s2CodJbT37sqeWEDjkms9g5Mr9be/no0vTsTaxGeD/iNazzQ9b/10UEF50B4NyMwti2RnktVstP7RbCczOqfyEFRFoPfu0Ketc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljSFTzJ9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a99dc9085so44681cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707340311; x=1707945111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
        b=ljSFTzJ9btyq2arL5dnTtWO0oiqo+ehG7d8oshtnfGoR2dXB0q6TMX9tM+y3f4nUrv
         OncqqALO5YwZlkbizs2sia7Jn/k+iy71YLwVsbiT7mdltW9JYnrOktmLZ0q4LRoL4M1/
         Y9kAnHSXnpZkddZnMlUoE+LzOJwWCwxEn30cvzBrJHW/F2jfWrmKO9pGDhzDIhsakJ/v
         nZecCUDi3iUsliK9ky5URuL8FWPnfBIZ2eUFzatSvY32z9pB6sKCV3coAgvi5NS93MOf
         JywEL1lGJ3K2HR5RLuXW1H3bzlDIseDmJ0FhJMEwpuxbMtCbYIyWoK47GCO5eGChtbZZ
         WsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340311; x=1707945111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW28iX6KIVBtvtjzICL/te0QeihY9cawvgUOGVCQrgc=;
        b=MVHEfeOPGcrBIj26yJwATxJgkgC1St5aUh9IfkcfH1GFCeCpXteagLZsrxeulI/fNg
         fpT/tk9Wiy8evyOIgDyM2ZN13fJxabCKXOc6ATVntYnLtP4n3Udh/3FlrRoIrcyUviPi
         bnScSmqhCTyB71FyTW/86sV51i+C/morD9x0riKAqeMUgvjOncO8BXSo7bHE6wjUJL6N
         T+z1o8Zjkr/fxKrJwrNLmKdW68UUiyvTg0H3BrX4Y2/HnX5YFERMyEjHRECEzLGPpnIc
         7uvM8y+vLuf3boY1o6V7vVY/0UH2QpF4mmL/IrgjRL+vFDOdbRWrBRdetoeIHUmmV83m
         ruYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgWywJGKCOvqJKMEVtVYrAqPndgfQgZclkM4uA9Krth61bma0IJgE/hcx9z18CJa+L6OCuwN6cWnGABxdjKQ5UApcgae7y0Jz4b+kVLPY0
X-Gm-Message-State: AOJu0YzSuD2YFIauttP0xrLjemkHBKbZqyoNFoKgV8aFDVRgT2ilAJh7
	2ZqUxEAH9DJLrUSklFkUFPgSBCe8lmgXKHsOD+7QLvIwYT9TMvXMSAC9lmqt7kCqvJepzGukO1j
	bX6q5ViIM42ldXewd6pEoZ9ZfeffdjLCF3pCy
X-Google-Smtp-Source: AGHT+IGjkQ4vwciNuicvZuMpXoICkkqK6RD7xqZv/i6SCSru8J2w2x3R+ElthRxkYJ7ULf9xIwKRFJEMFfdx31dRnTY=
X-Received: by 2002:a05:622a:1987:b0:42c:2706:bad4 with SMTP id
 u7-20020a05622a198700b0042c2706bad4mr251429qtc.27.1707340310654; Wed, 07 Feb
 2024 13:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201060437.861155-2-davidgow@google.com> <CA+GJov6Swgvc+wrCvW3Ujqh_UW1BSRDrp9ccHUX2CVRjWpe1dQ@mail.gmail.com>
 <878r3wcs7e.fsf@intel.com>
In-Reply-To: <878r3wcs7e.fsf@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 7 Feb 2024 16:11:38 -0500
Message-ID: <CA+GJov4zrcbiANMgJ5uSQs6Siv0+NAB5big0bec-WWgkhfFJ+Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: device: Unregister the kunit_bus on shutdown
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Maxime Ripard <mripard@kernel.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	Chaitanya Kumar <chaitanya.kumar.borah@intel.com>, Jani <jani.saarinen@intel.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:36=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:
>
> On Fri, 02 Feb 2024, Rae Moar <rmoar@google.com> wrote:
> > On Thu, Feb 1, 2024 at 1:06=E2=80=AFAM David Gow <davidgow@google.com> =
wrote:
> >>
> >> If KUnit is built as a module, and it's unloaded, the kunit_bus is not
> >> unregistered. This causes an error if it's then re-loaded later, as we
> >> try to re-register the bus.
> >>
> >> Unregister the bus and root_device on shutdown, if it looks valid.
> >>
> >> In addition, be more specific about the value of kunit_bus_device. It
> >> is:
> >> - a valid struct device* if the kunit_bus initialised correctly.
> >> - an ERR_PTR if it failed to initialise.
> >> - NULL before initialisation and after shutdown.
> >>
> >> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> >> Signed-off-by: David Gow <davidgow@google.com>
> >
> > Hello,
> >
> > I have tested this with modules and it looks good to me!
> >
> > Thanks!
> > -Rae
> >
> > Reviewed-by: Rae Moar <rmoar@google.com>
>
> Thanks for the patch and review!
>
> Is this on its way to some v6.8-rc's? The regression in -rc1 is hurting
> our CI.

Hello!

This patch has been accepted on the kselftest/kunit-fixes branch
(https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/=
commit/?h=3Dkunit-fixes&id=3D829388b725f8d266ccec32a2f446717d8693eaba)
and is heading towards a future v6.8-rc.

Thanks!
-Rae

>
>
> Thanks,
> Jani.
>
>
> --
> Jani Nikula, Intel

