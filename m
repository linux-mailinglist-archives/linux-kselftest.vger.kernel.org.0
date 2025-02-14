Return-Path: <linux-kselftest+bounces-26673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D1A363AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F593AB17C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1C26773F;
	Fri, 14 Feb 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+9T88QH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B8267700;
	Fri, 14 Feb 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552032; cv=none; b=tvokuNsoQwgGGg9y4TysPgVUsTqeg5t+eCVBxtfDcGK5UUlmndbPBxGWL7+RnH7lcWA/4GCxfHE17mazyxk5UDd1MAKPHItX7PPhsR+7D1MfS4hZ+CyK4VWwxnXRocTSkoFXZXU1JJNTx17A15qinNUxU4gmPukS+boqn6pldDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552032; c=relaxed/simple;
	bh=2c5NuBDyo2m0shbPuVy5ObaCNtX5qBwlWxjze7MTKVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDZ0Vl4XrKBcFQ+xISqtvJNR5P5PHUAGZqha6tWUephuaio6/JNLvm35UBFE9zBEJUVjbrg29P9CFxaMejJkH3qQKUIBXwX17BjlOuNJuDtZRlgtuBhaGgnFPjlzJ+moTXxfcjaG59afEjcMWVw4TOiV+QU1vpkUO6nccN7aNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+9T88QH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613802a59so23406471fa.0;
        Fri, 14 Feb 2025 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739552029; x=1740156829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c5NuBDyo2m0shbPuVy5ObaCNtX5qBwlWxjze7MTKVg=;
        b=f+9T88QHHF2clw9JQku/08ewFwYw3vAM0beJS3fTWf+s+f/Lbs3YHvgmQ7m756eBSL
         Q+QNjRHWZPzJ/atrja7XLDpesNBaHogiwU+H7irju0b+oE8tlhOoZGvmfbbs1nB04Aiq
         VqSwEjLPVY4Ku2mSaUvnwSiwew+SBdL3xGUACwOa0amr0vunHUi/IWXigDLnKd4cRplr
         eqpIXzjXAwC73SFY/J2ERcaT7+z1fIaGu9kJ2T3QrI+HlCUjdaO+WpkWOqHFhOisqfUp
         v6z1gwpxtn1UXufBeBiwBSrffzKouBwIYmdx+5HbefDk5MbHAgiQsJdJH97NWGZrxPfm
         ylYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552029; x=1740156829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c5NuBDyo2m0shbPuVy5ObaCNtX5qBwlWxjze7MTKVg=;
        b=LgCYqbYbUzl9e8aJBzUBCqa+FyelZKieDSGR7hjSj353K6ewzymbQX6bcusoRyp4Ue
         E9p2CscL0zRkSg/1N1eP9tn7j745NMdLtKhcas01Jma4I4bV7zxmBoq7r/blv0GwljL6
         5d+fP6pBKG2OPmTQ7Dpzl6jHiFWTsULAmGbMEaJB9QYUcMDNHEZHmveVlQvukNoKiJxB
         +QqL6m48mSmei8WlaIQUxLwTG9SgwfeuLMF9VEEIr8jbche2nWr6OCRHfDOOlaH1dY86
         ryNT3OH+Uv8zxRlPG0SL81Rcsl2rwdAmBxOKXkFOUFDDEjoIG2W4q9h3QHGEHGCncfry
         esgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBWucI3Ptg7S4XKPRd+D/QoRQtd1VQkzNdb7CZnk8GYUbhLMFvI5Sn1C3pVYAuW+Jd+8P0Idyuh4=@vger.kernel.org, AJvYcCVFy8WeK1BolTCskSp6aDN4Cb9vCsUbOFjSQCRY7BG4iPySGpKNV8cEYLwrKbRgTZ1itv9gHtZgF9vCqlqf@vger.kernel.org, AJvYcCVVSZDxU5lVXbg9wvUrTmWnoihAUemvEN1eVJxW4xjMANFRjMIV8M32uyaNX3USlDZ1YTytAhzEOkEKjf8ggAQG@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXkHkw5D3mk5JyEmYi7qMFGaEPl1jf+FNsKZUsH73gTNpNu+u
	MGDDzhOCg4qnkkXxHgFIbK/PgcxYxIz3yNnFU63FtA3RriwdvfGfYvtf/m7PFvhpGaBrWpBfJeX
	bga0gk8PyW5e45bp/YptPkYY01o4=
X-Gm-Gg: ASbGncuAXKZiL1kH/n33Noqbx2epqmNNOLkq76oaNqtJhrMbjfC7pkXCqfsSEvZP1gz
	q+EdX3qB9wI5Cz3aag57vDClhnhp5dlxyakz9pwtWKnqv7p6k2gOKL45Jt5YO866gUK5mPB3Nax
	tRHd1/6DfN8IkZjHzfMYO63PpsnGemEhQ=
X-Google-Smtp-Source: AGHT+IH+ZY2j63cWbogB9A3vuP8zUi7lLVt1mNv8t9yoNtwWn6FsGoTMpU+6/obf1W6ICZ9peOj7KrEV5ms8Ua3/CX8=
X-Received: by 2002:a05:651c:548:b0:301:12:1ef3 with SMTP id
 38308e7fff4ca-30927a2cde4mr1356071fa.4.1739552028486; Fri, 14 Feb 2025
 08:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
 <Z69isDf_6Vy8gGcS@pathway.suse.cz> <Z69oxhkUzTfJ6YKi@smile.fi.intel.com>
In-Reply-To: <Z69oxhkUzTfJ6YKi@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 11:53:10 -0500
X-Gm-Features: AWEUYZlnq5SWYMq0W8Wtx8_gV8oE6jI4f_XCC4fWZ0NXKTJTv_1uIYIyKaB7JkM
Message-ID: <CAJ-ks9mck4DzX+WANxKSmcN=mP9ztgwWETXLmX_F-gy=EhmLNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] printf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Petr Mladek <pmladek@suse.com>, Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
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

On Fri, Feb 14, 2025 at 11:02=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 14, 2025 at 04:35:12PM +0100, Petr Mladek wrote:
> > On Mon 2025-02-10 13:23:21, Tamir Duberstein wrote:
> > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > being bitmap and scanf), the rest having been converted to KUnit.
> > >
> > > I tested this using:
> > >
> > > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=
=3D1 printf
> > >
> > > I have also sent out a series converting scanf[0].
> > >
> > > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-3=
86d7c3ee714@gmail.com/T/#u [0]
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >
> > I have just quickly tested this before leaving for a week.
> > And I am fine with the result.
>
> Seems reasonable to me. But I want a consensus with Rasmus.

I have a local v4 where I've added the same enhancement as the scanf
patches so that assertions log the line in the top-level test.

I'll wait for Rasmus' reply before sending.
Tamir

