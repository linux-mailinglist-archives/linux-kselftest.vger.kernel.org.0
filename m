Return-Path: <linux-kselftest+bounces-25497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E57A2424D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AC81886C70
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE01E32CB;
	Fri, 31 Jan 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHpFGU0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE71DFF0;
	Fri, 31 Jan 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346377; cv=none; b=RtWpBbf64FVni4Anpn+r5X2Vafeo9eb8dPnhPUoqKqigNsGRBclunlPhYTQyVczbz0JYUfp0Q7Jp6ZI4JSy/7QJ7pra2LdzcXemIGkTLEkNdDM+IVsF4IECRaP3MKwcq6DiCgjZivD/lB5vaSwuS3m/paYvNwwvP2UyoedP2fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346377; c=relaxed/simple;
	bh=/oVUJgC/vzPFCfg5JbIjdx5Jcx6mbmN912WCYE2F8p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxIuf5tur6OICvG8QTaUjW+K9+YpU5zNYrgGcgpyPWkL6hrrrzuJ9C9R6vR5IIUKm83P6Yg6AIJRCXRjdWsJirx5CaW87mGSqrIAvvprDB6ey7og1ZY37AzKi6RrWxDaZJqHbLXsz4U8X7iJlpNAdFrONyeQ1d95qOleg4uXSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHpFGU0+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30737db1aa9so21127881fa.1;
        Fri, 31 Jan 2025 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738346373; x=1738951173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oVUJgC/vzPFCfg5JbIjdx5Jcx6mbmN912WCYE2F8p8=;
        b=IHpFGU0+1RgGzVKev7UkqZg569hwClRT7rBDxfL6yF7egSl5+uJ/YZZsHfNqbbI8pi
         trM6nNaxjJdasKLAGpXkMj6DRSZ5laQ7jN++z31Qq+GExXJMt5C0/alKRlecRS7gP1Zk
         QARWFyeldUQJ327fic4TbdJGa/DavdPy6ZAgznVLXngNkfLYomVvxPA3xNTCIzEizOop
         0ebpuYpUL0Vbjj96yonu3XyY0A7WIb7iI0m1FDaJjv8+tUJSjzd2TPg1LDzAtxka3v9U
         ztkqoPi7Fzd6E5zYfssmJ7CkWfeqbD2i8L16tw4ARLeEZ2y2HMt/UtvAS/d10Tu+0bP0
         pSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738346373; x=1738951173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oVUJgC/vzPFCfg5JbIjdx5Jcx6mbmN912WCYE2F8p8=;
        b=vYb7qH1ifrL/hOXTBd2kG1qfIaqt4DWO7KCDfduGXsdqxkkMMWR5QiaRrEI9BO6l8e
         7AhQAAp0RHG9Mb8vcYode6aJ3FiZE10Ofp2r1t7AvNHyFBv9G1oVzR9tR74CJXsGnn9K
         XiR5cVwZIEK71eMGSCBpvB1pqcKZqaTKNoSrKRjfbCv+gaaZrbq7vDn47qQsZ310f2FP
         RUkAcDIX5SYmYOZCld3rn+NYEgjRx+KYbCpAOtdtEXIwPUJmyyzt+wd1kW+6xMUmC9aO
         hfozqAbaPKlKnMIgPn89xIJo69Ugimn7RkINidcpkqZRqXcQQWh21RRtAnb1g0pIV01B
         nR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuteJmqIHm63WhHrttfSr9IbLVzJPkRdkda/3W+iF3TWxmKRk1EcZcj1v53u7oDcHGNwPyVHvWwMsMPCbdTf5o@vger.kernel.org, AJvYcCWMtc85lifu32Lm4oPriDRwdswtNqFSX+t6grrejlRfTxGDbBRYXOL+zk2JoXH5SLh07sU2dtOQ1nAANqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrZDOI4IznyM7iYzc8YplwmMdmQeCZZ57/MBg/rio4mlzkMZo
	x6usq9gUIYcI4OdqrpNFsDec4hlT1/f0KPqvLb92z+0ar2AlTTM7fO40heudS1q+kWBt+Fd7wAo
	Cy5M42Mes2mD9QyNTP2d/67q2Gi6hzZX6DVU=
X-Gm-Gg: ASbGnctlGnzyCDUmzos0vBMP5pmo99f6CwY4Cba66qr0EaywYYQw2psNCHnQpy19vH5
	p2e4JTILsKUIN051Jynr4IUyTAKMh61/3Iu3YvhNyLr0yo3PoSWlU9NP+jV1NjXXzJcvPwMwX4H
	k/WvWxIiLup4enrZ4bXjHFjqKEQ8mKjEE=
X-Google-Smtp-Source: AGHT+IG2swpar+VI4RaxA6wkR2cNtRH6mriOvbMjIc1/+JmZGEJYFTDzv1GUefclH2X3D37t6TATaESQeJvXH+iKjTU=
X-Received: by 2002:a05:651c:1505:b0:302:1d24:8db7 with SMTP id
 38308e7fff4ca-30796858154mr45427611fa.19.1738346373019; Fri, 31 Jan 2025
 09:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
 <Z50EM7gxqyV0Eois@smile.fi.intel.com> <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
 <Z50NVYKv7JBn10hj@smile.fi.intel.com>
In-Reply-To: <Z50NVYKv7JBn10hj@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 31 Jan 2025 12:58:57 -0500
X-Gm-Features: AWEUYZlQrOGKVseS4eq5Qs6ATxK_tAN32pS2khVl7QHudzZkdePOeDxt9NwVgWI
Message-ID: <CAJ-ks9=wFZhmTE3kmVF=Ujn9xWgGoFrSnsihHmRoW1eD_3Cdww@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 31, 2025 at 12:22:39PM -0500, Tamir Duberstein wrote:
> > On Fri, Jan 31, 2025 at 12:11=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:

[...]

> There are other options like CONFIG_TEST_PRINTF or so in defconfig files.
> Why are they there to begin with? The answer to this Q will affect the ch=
ange
> you have done in this patch.

CONFIG_TEST_PRINTF still exists; that test has not been converted to kunit.

