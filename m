Return-Path: <linux-kselftest+bounces-25724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308FA27B02
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF199161941
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA5204F85;
	Tue,  4 Feb 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhwOSXoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EB16D4E6;
	Tue,  4 Feb 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696657; cv=none; b=T1eik8OMGFYOgZt4k52gBj3Qk/aO1GzB8Kpp7GLAhc+i0NCceTMNLiSPlLldWR4FbG77+hw26T8N2TWtsziJx8anA/bq4BMKKMT9zEMZpZisKQUXqOm+p4T2vPSs3oYp8Be+snSXpQnyQ1wdNVDyk6Jpy0JenTtAMVVc8dUDxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696657; c=relaxed/simple;
	bh=+YuyIAfOCIL25rF8RErTwQhW66DgEpQZOPKE4cAxT0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m18IXDUALFFfLftEuUHUeZtsz+1HtwTGTcXSKzohlsQlohwbbsBP7ZBdJf54JgeHdnwhbQ4CSgUC2ChJojt5CVJMltiGKASEVMTToDqFCZxnq91QQqNmPzIF3fPBQOkiEWYXuTKVBV8nlAo/CkRXBYNpuhhlgD8drUopzLAg7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhwOSXoE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3072f8dc069so57579241fa.3;
        Tue, 04 Feb 2025 11:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738696653; x=1739301453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YuyIAfOCIL25rF8RErTwQhW66DgEpQZOPKE4cAxT0w=;
        b=dhwOSXoEwMf8KyRzNpzgq9zye9qtavFuGYGz4SCQYLWYRx/C5EodZmddHEfRDMhkpe
         2qcz1YaANI2vMlTu1C+aiJxu5qJANmiAN8eolRPiVJ4e46zTcuOH7tb81H3IreHg3OcQ
         Xxdb+x+fouCtHm1pKs3dx9XPE+CXNmdLV+3F1M5iSI4mrmfAp1JvZqXLGhQLL6PGCRRZ
         YHNI5ciR8HUQ1PMrH1GK9oWgNZYn8oThy4cySZcaWM3PSoNigze2mcjrDJEmJnHHLL9G
         zkk0y3RkpDF35eHxemb44f3YEgKH7xwyueIaztSt3e14ZVo1hFk7O4qSetSa/r4oVZdr
         xq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696653; x=1739301453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YuyIAfOCIL25rF8RErTwQhW66DgEpQZOPKE4cAxT0w=;
        b=HyGBSdhQTOzXaA+6BHvl/z9QJUOpeny1Y0N1dCKKY8KOIkDOEHixGfDXbcHCVplMv3
         invWrobXtaa0Jiw7nIB9n0e8MlwaC7pilQOoBO+5wx1zFpmTLrt6tJmPkcd6zLh2VdcC
         WNork2ggv3aTU8XSGvutkK17bLndLn6Ze2L25kJWfaHjYcBdLvY1XaDzUjGU8DNrjzfg
         LckWxfcZpKmmIc8JfzBeZEK9jlXO/wPg8kxX6TZ2A5mhbldsrShuY2ILK9S+z6I9MF4c
         Ot3nW51wtbxZ97QqjNvx1Jp5cz/Ln1P3MdBwhoalrpOt0hkbKsmxod3RTxoCSDKqB62Z
         DcGA==
X-Forwarded-Encrypted: i=1; AJvYcCUryqjG7VF4huLYPn3kHM4jLDIP5VnUjU51oFhQ/Cr+3T01HRCy1Zr0vEslha8AQpWxxShwvIRpY0znq2yEfAJ2@vger.kernel.org, AJvYcCVMrfoFboljzMyxVL/b4oc6qmxVN250P7CutoF9rim2z5hMmwF9Li/saIs1yOjVaUNXsCXTEKlsnP7RY3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdojbF5l072JhbpJi9OmLcQRXuINTgsRjhBfyLbiMFZ1pcap7
	FwA+0apyf8/uPwJWzAQPUbfRSUpD7YflpgxBK6cbbacVmexqmxo0CzdSlMOZhphaZZ8BONq2iHc
	4ZRnK8OmWgwWKU0hwGXjFuhvDWGQ=
X-Gm-Gg: ASbGncuBw4fy6VQsQ1B3pgAT+QZlUXZVdWthDl2LjmRH8RTJ9peatq9YIBuM6rQvWDm
	l9dNmslGJHWu4k57NiXda3b2v3juEV5cBP011s8YJNTV0IL3n9y1U3fIYBGq8cUqBIbo78KjnxG
	uzbmFVu6VAT2Ey
X-Google-Smtp-Source: AGHT+IGgZMFxdnVFdeC0qRI8h8kUiXMb+CtkwPpSfu8pu32enK99NQABDDlyItOPo8rgjg/mZpyZcMBZwkzY33WRmHk=
X-Received: by 2002:a2e:b892:0:b0:2ff:cc65:68aa with SMTP id
 38308e7fff4ca-307cf39e57dmr526841fa.31.1738696653269; Tue, 04 Feb 2025
 11:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com>
 <Z6HSFvvgxFVGDQeI@pathway.suse.cz> <CAJ-ks9mfmM-SzkEiJsKL56jSuyXzLrKd4XHgRnp63C9AYcDoAA@mail.gmail.com>
 <Z6IFPAuCz0_vDdB4@pathway.suse.cz>
In-Reply-To: <Z6IFPAuCz0_vDdB4@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 4 Feb 2025 14:16:57 -0500
X-Gm-Features: AWEUYZl59AjKFP9VutQZYuwBYdW29fYOvq_8TbKx0d06XVaLnBsEOaCAGTeeBBI
Message-ID: <CAJ-ks9n6fFhmF+VruGNKjmoWh0hMHGS7xoEuceVMvZoJFb7avg@mail.gmail.com>
Subject: Re: [PATCH v2] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 7:17=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2025-02-04 05:27:23, Tamir Duberstein wrote:
> > Oops, meant to address this in the last reply.
> >
> > On Tue, Feb 4, 2025 at 3:39=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > Should this go via the printk tree, please?
> > > Or is David going to take it via the kunit tree?
> >
> > Going via printk would be my preference.
>
> I am fine with it. I assume that you are going to send v3 with
> the updated Makefile. Well, let's wait a bit for more potential
> feedback.
>
> Best Regards,
> Petr

I'll send v3 today - I'm adding an extra patch that breaks some tests
down into proper cases for better output.

