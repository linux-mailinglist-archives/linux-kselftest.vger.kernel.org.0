Return-Path: <linux-kselftest+bounces-28407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B639A54E03
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 15:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A84C1897015
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17740188591;
	Thu,  6 Mar 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWwLPYyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738E17799F;
	Thu,  6 Mar 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272146; cv=none; b=BD7z1x7WgqSmfoMipFk3mdsrRTZB8cik61xgJkTBJc6wa5FxVqK+7ASFMKN3GYuxgJ9qH8axvV8AsA0QHAl4RFzlolJysOmzzylTjROZwTcI0S6dYnpkYD6h41jYswTZd4vJU0duifRBVP6h2eLtfgDL6xIZthI0eEtwx+zIw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272146; c=relaxed/simple;
	bh=ONcS+jkAz8j6DNU4Ezy9NisVJDwwpANbFadbPYOR5JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJjElZeOsMty8RZ/GvdB8oiFXcWzdbcKhsGlK6qhMz54V2dEddnqGLcNpsROPuVcEuM+Vxsz/ffalDEkh1tyLMPbUQZJ5bMKaD5Uu3d+lonpoJMIsZRDV/oyXY1K9G1W3SZZXD1dCFH+XIZiPaitxesqNLDn2gUTWP4sH10Py+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWwLPYyb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fcfso8403311fa.0;
        Thu, 06 Mar 2025 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741272142; x=1741876942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCk+JJxMuH+7Xc7MK7xCQnQ/UASRlAowqMx07w+Zybg=;
        b=XWwLPYyb9AJOYco4ocQT+fsr2PH2egBF7p37w9CuDUJow8sFwlk7T6RasFSYWHCCkt
         onlj3xZjQQOl1fV7jCJmOgTNZMgwkTDUO6otPJ0wufNxF9dXsPbAx/t7ZVOs3xPXl0Vx
         gCoMeJvzu/5ZfVwmm17RT4XlE34NRk1oEGbm4MiQorMYr59HuDwnZl5souRPNGJLPIyX
         dAJKpnSjZdfcRhzleN+zQZT+QT+xZaM2+0IUSQSHiRGaD+e5cwcy5aaA2EQzp4d/9jun
         DiVG5GVhhWfHiHV+xrPSGTgsECq/EXx4mBSFSSrvXiAia6QEeNpGk2/JVzO6GRy/tr0y
         VFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272142; x=1741876942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCk+JJxMuH+7Xc7MK7xCQnQ/UASRlAowqMx07w+Zybg=;
        b=dxRg8XbsneEv9nXbiPBragMtb1Rryh1SOyuF3s1jMQpq4QsC0tAqdvtfJKOb0Fx694
         Ov7ZhQkGNc13JcXfwIZqr42+MAVM4sGQzi7uzSvXfY73C4nLOO92DUWDjLfWpIVYgLi7
         jVSQh4QN+TrG4M5+yQv93qffJktc24WwKcDEF+wxIc50XfIKGhW1CiNDrKjmMBapYERb
         7GQSg5Ex88A8u9+di8NyI5QfXabtDUsDk2aJQJVysBGOd21b7GrbAxMJ/FBWkUfXnL4s
         MjrocAz4nphT//VHR8vGO7RaXVUzK4epW6u8UmIrRkMHc6zMIULovg2YA/SiKD0L1HYZ
         3a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCAznIonnVTzgR4Q2K/oUrVKAyIjg4Y7dsxQl6fIip7RUL67og8hVnXc/IiRapK1y5+C2CHYnIa3FltI7U@vger.kernel.org, AJvYcCV0hiXtnTCCCAuoBAQu3tNJj1cW2aLhEFm5uZFsf51zRv9oDUYZUL1XNE0CWq2H1AX962UuLr3gbbo=@vger.kernel.org, AJvYcCWFxhu+ITYde+xNAYwEl2ttCx8J0FoE1N3R5AeUlfAdNsZYHKWw6phVwVZshbigB4/P9w/U4menGhGhAOUFGUnw@vger.kernel.org
X-Gm-Message-State: AOJu0YywuS2x/kkTlQUQtMOJjHyMvxKHI8SO9jlpxgPUFlxGO0SRrf4F
	pqJF/Dh+3b8lKnHMK7DnNbYG2xoucq6dJaAOn30krhJ+dpKD/YpM4Tp6Ooc+33T0L7vVCbcDm+L
	qpX1n21WB5LxZCcLXqlyRKgvBgrM=
X-Gm-Gg: ASbGncu8awxkeJQZKzQzWD7WHgtVuAUtyLP3rNrlNolhtSZNlgUfqbMCaJKW/9GJUnu
	/z8p4Q3DtKe3TBUanMyQ/xhwKNtnGNZxjRsE8s3lDetsv+yS3LYTFRZOl376lRMDe3+jvy72HZR
	VcjO4gHUSQrG6LpNYRThSWipdJArmZo86l9WMNpMPLXw==
X-Google-Smtp-Source: AGHT+IGOs0tm+vlePSriOvo4exloY4uff5hQyhMGSFCdw9I6NO0PFz3l856QvBjOCsMzUglvlxiovip4pW93x04X3AQ=
X-Received: by 2002:a2e:a78a:0:b0:306:1524:4a65 with SMTP id
 38308e7fff4ca-30bd7a5453bmr26242801fa.20.1741272141974; Thu, 06 Mar 2025
 06:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-1-5db840301730@gmail.com>
 <Z8mUH0comOCpycpK@pathway.suse.cz> <CAJ-ks9nFSzRXFauavzSWhvhr2Rou7qqkWi_LZ=4e1Tyr4_bn3g@mail.gmail.com>
In-Reply-To: <CAJ-ks9nFSzRXFauavzSWhvhr2Rou7qqkWi_LZ=4e1Tyr4_bn3g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Mar 2025 09:41:44 -0500
X-Gm-Features: AQ5f1JpJWKoqf6Ad0yhsZAI6HTLS5t2uCBoOGMRrpWewZnGmz7aTZFflUPyKXMo
Message-ID: <CAJ-ks9nDLGvzZ+NDAJsk2Hy1=hsCzayg4-65gk60T_WJZzOUzA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] printf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 9:25=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Thu, Mar 6, 2025 at 7:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
> >
> > On Fri 2025-02-21 15:34:30, Tamir Duberstein wrote:
> > > Convert the printf() self-test to a KUnit test.
> > >
> > > [...]
> > >
>
> > 2. What was the motivation to remove the trailing '\n', please?
> >
> >    It actually makes a difference from the printk() POV. Messages witho=
ut
> >    the trailing '\n' are _not_ flushed to the console until another
> >    message is added. The reason is that they might still be appended
> >    by pr_cont(). And printk() emits only complete lines to the
> >    console.
> >
> >    In general, messages should include the trailing '\n' unless the
> >    code wants to append something later or the trailing '\n' is
> >    added by another layer of the code. It does not seem to be this case=
.
> >
> >
> > >                       bufsize, fmt, ret, elen);
> > > -             return 1;
> > > +             return;
> > >       }
> >
> > [...]
>
> I noticed in my testing that the trailing \n didn't change the test
> output, but I didn't know the details you shared about the trailing
> \n. I'll restore them, unless we jump straight to the KUNIT macros per
> the discussion above.

Ah, I forgot that `tc_fail` already delegates to KUNIT_FAIL. This was
the reason I removed the trailing newlines -- there is a mix of
present and absent trailing newlines in KUNIT_* macros, and it's not
clear to me what the correct thing is. For instance, the examples in
Documentation/dev-tools/kunit/{start,usage}.rst omit the trailing newlines.

