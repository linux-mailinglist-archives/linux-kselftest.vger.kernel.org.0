Return-Path: <linux-kselftest+bounces-26784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2802A38689
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244F6173F49
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF92248A5;
	Mon, 17 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH65J6Pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4722371A;
	Mon, 17 Feb 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802638; cv=none; b=pJnnm5rHszTGBBsUVz+NDiwd+G/ZrK8xzqk0+c4xqrDg2ijUZTRQSN8/JuVAxF0vviu6uXPxn6SXr839LF3gIfLXC0cH4UsF5jpSGI7tf+B/9ZgeIcvlfJlzZGWwwUAZVhl1/mnHJBa7/AYbdMNMcIpWEMIPHiOo7FK1/aS5vHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802638; c=relaxed/simple;
	bh=sY+CA8clNRQT+8d3rmvYViciBC154ua4aCipVJOVrQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO/BJf8ZOoYfXGYuRR1hcsYUDHgIwTok4UvmET8evK3wqvnxrlCgLFN4wSdYBlzadkfkkj6tEiYXTIb0RzPmJdI715C03/LDAYZTQjOpNXLjB5vmP7t6dx6tv8VKvAz4zVeXdfNmEJP93pyXYCdqlu3de1wub0rmvaZ5A2X1sBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH65J6Pq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e49a10f5so4713726e87.1;
        Mon, 17 Feb 2025 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739802635; x=1740407435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY+CA8clNRQT+8d3rmvYViciBC154ua4aCipVJOVrQ8=;
        b=lH65J6PqXsTKNocXKNybVdEjmisTU1HM5SI/J8i5rrUIw6iFbEyRkWCVv3dAVm3Sqp
         d78+qpVy8SqY7R1wdu4/P7Ymes9TWJlJ0naj9ruEg23Z6jTM5FfOhh+NJ5D9kSB7T5+f
         dvJDWQ9UkFNmUgY25t+M1sZqQraCGjJlkFwAeMe4NFwOAoIifi0Bd0xaTIFijwD0d/T4
         rAl7x4Af2oltUCOlEfmzO2wkqbXjScP7uL5R6Gymj+mtEPcB94VhWbVKTn6TNBG4jN0C
         rudPVlH8sZY1pdedPsrwVa9wgFpg8jUgebIo6AqDgul5RU8wU0bVVYaIb6fu8dApb5UP
         WvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802635; x=1740407435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY+CA8clNRQT+8d3rmvYViciBC154ua4aCipVJOVrQ8=;
        b=wcSL7ixtjShxMRjqfnUG2uP8KvckrKa51EcWxQElTSS/zzu+bT8Ai96Lzs6cUeZoVt
         Xkz4sndu30hJl5uoMc5Odi7ctgPf1D9fBtM4zAPYD4zCpFpk0mPWpfeb/LNQ0eSKtGNv
         myz4bfUhi2FwqcinQvJ4oqgC5yUM+BZjgB4WoNJYl/Kmthc4TmKIg2qCwVFqIGDR0x/C
         0X8awYwCvkET4JqnU941vHOfKeWDKb3fe+AKrimoq4kxmi16qG4yMcg6MENfZJ84sNy3
         fsSWtYHW25TsKy1pPACE62d+rv41r8rgAbkH5SBaUXnr3sxzKQDUMgjlpzLh1X+Kbu4N
         zCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUVeszlYmjSs6MIEVVoVwe2mYjG+Xqa/zoFYJmw+NP4NiR/GLH7UrG7ZgtKkcs0xUBPKTo8elyUwaiOCP2bJAhh@vger.kernel.org, AJvYcCVdciX3akwbbF8WNYR0vvXhSrTsOoyP4TuviHdf/xQYC1sxDPFHlNpm8huT/89Oo7BKSwPdRQjuTF9wcCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIJYPma2gG/iByRPvl1n15mdb6AGWbJpCRfrwN7iA2eqvW3AS
	UmYm1avxZYgSYzC/hcQFYfQqBQQddN3rgEcK+w7WDWxnpqwCSa5D8VQ40G/N/yyGSDlwJlLLJAu
	f4CBW9dyyRb10QG6aaPPAnE0gR3E=
X-Gm-Gg: ASbGnctL11PdMnW8dZULsVVm8xYmLHKGyA6dNfyHsevDsiKgOLGDrP3lbvKFZDMP48f
	ALvhkq34H+YTBNHmdUTKO9BhyRbRiz6L5uZLogGyOqnnbXkWDeFjdv6463+jUS4HAT5qEdqHL8D
	aADJquRKXYJRCkYOomau0MDUgdvEWb8i0=
X-Google-Smtp-Source: AGHT+IFO026JFAoJlQESSwcdgxRJMbNRj6JcB1YuS4pFIcRjR6IQAVsiaDlUlmG8KabgDlbneF72bHJSl1+962Y2SQg=
X-Received: by 2002:a05:6512:10c5:b0:545:576:cbd2 with SMTP id
 2adb3069b0e04-5452fe27304mr2917774e87.10.1739802634481; Mon, 17 Feb 2025
 06:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
 <202502160245.KUrryBJR-lkp@intel.com> <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
 <Z7JI-YtgZzmOtMDK@smile.fi.intel.com>
In-Reply-To: <Z7JI-YtgZzmOtMDK@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 09:29:58 -0500
X-Gm-Features: AWEUYZkuvaFnvabs_GywBbkuo44d94Kql-DWL2E60D-MWBZySmrPMuLFMaMbzos
Message-ID: <CAJ-ks9mjWOCjMOK+ktLdN0XJmRgT57CoHf_aCDLMOX6-mnKVwA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Please, when reply, remove boielrplate stuff!
> I have just wasted a couple of minutes to understand what's going on in t=
he
> message that is 2700 lines of text as the reply to the bot message which =
was
> ~700 lines.

My apologies. I forgot what a mess a mobile email client makes.

