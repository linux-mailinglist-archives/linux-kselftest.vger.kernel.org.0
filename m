Return-Path: <linux-kselftest+bounces-6005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475B873E69
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973421C20D47
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CBE13DB96;
	Wed,  6 Mar 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSDSt4M9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397921369B7
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749458; cv=none; b=MVKBFqxeR0ILva2calbpz8hLJhLtkRJNsNFD3t+eM+GwJ2JP1GCV2rZX1QeCG0sxpmEFQyMCwEQUkVKL/DuKWdeSfu7ROSJdrHjloeoIEvxJwgo5nNdCczM+93j6k3giZbyZ3voyCUmdrUr8emeJD+lgK3fEV/66vXjNsv3h+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749458; c=relaxed/simple;
	bh=WytS40ZdmsM5zwjaJMMr9w3erghzLSkCQiyje+s3eGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chel+otxsaMoIZ6KBGFbowI5DJQ+U1jGuCc3doI2fpqxR6n8Ha1AOTbbyfQT2tAVRSm8p3K+h9oDFPl1x9tEWxyROXKPOTYOWTF0hlRqVOplQ6Y2LbUyqty0geVWUG2mSZnmOyiNPT/cqIQu0yFi0Sn3BFm5rfiMWPuqxertCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSDSt4M9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so5238111a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Mar 2024 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709749456; x=1710354256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWWS4LnVP/asDNzm/6wkKWnD1LdXMDQVgVaviFZ4aPg=;
        b=xSDSt4M9UoLeDP7OmunKwSARN+zE8oqO+Vx00xIodsni+Jai1c6Oo1sgafAF+ggn6q
         FjeR+7UjMDREMOatQi7cqH0B7Ae4eXdLJCD45B7kxTVv+ZozK6sG3NsyJgxYik7t23Uo
         I0ekengU3Gg3M2aWWBhsUO/sdc7TYx2rKXZQ0pMH7BE87AKqmZucvGmabW7HZHTfBQ+J
         60lJ/k6QKlIWfT5zhsXpqs4xz6SQKfIa2X6FzIJ0/QzGacD0Yq5s/JGxxasW4KQ5gwyk
         +Ua95cMya9C8VrcfWP42WOvMQt2T9fHpseneaFXvE8I/EE5FeO3YmUh7cSLt2O8p6vSG
         ZBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749456; x=1710354256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWWS4LnVP/asDNzm/6wkKWnD1LdXMDQVgVaviFZ4aPg=;
        b=gDic8Z5LXpk9Xm3zL383sGq/gPkTweoMYt45s4ilbb9w2ib46l8G/UBJ7o2NMUUgNm
         Q8q3e4a/fau23ztuB0Nl573sABqyCQLwrti6ND4ZLm+xsiF1zT3k0fZwmdyXTLyQNMVT
         oEhqAZLmGYefC6URAH/iDz/JxxFOgXz1BdJWnuU1QBpbTb1714nVuVRX/k+4ISK93IST
         BMCrUL2/QvLXYwkOZ2OUUeTVPpg3EWbGEBKJsC4OJ9RymarpD17dyB+9CF4sqG8MR4dC
         Wp2h5f0UP8Zlj8PC1gRcOWgZOLkNGQknGOElR0cQnFW4ZyrrEPX6cqN6BZORdaSvIqia
         202g==
X-Gm-Message-State: AOJu0YyvDF1IBmqzwdu0YjY60OPyB8M6Zds1lkbzxJz5OJdnxCCfijT6
	P1Q/OsRlCJqEKI/puXu04UpZxZAjA7B4d01fYJ8STbyAC2GZnimzayQ8krATMrYAY8W+z/kNaE+
	JJbA3gfKhd5kTNpgHfIVv3/go5Abs/6ZgHn1J9Q==
X-Google-Smtp-Source: AGHT+IHKPEqxOppMA9uKtWnzKAyEDN9QbdCsWR4IDnjuRlBVf+wG6gTH/NYYdjq2Jeob5XWC2zp4Hl1RW9kYPP1CSp8=
X-Received: by 2002:a17:90a:8986:b0:29a:c886:243e with SMTP id
 v6-20020a17090a898600b0029ac886243emr14404213pjn.39.1709749456443; Wed, 06
 Mar 2024 10:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305184033.425294-1-linux@roeck-us.net>
In-Reply-To: <20240305184033.425294-1-linux@roeck-us.net>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Wed, 6 Mar 2024 12:24:05 -0600
Message-ID: <CAEUSe79fwDAhTdAD3OecCAw=LRzajxA3b-B2r8YtVDPeH7LCtA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Tue, 5 Mar 2024 at 12:40, Guenter Roeck <linux@roeck-us.net> wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
>
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons.
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad-hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
>
> One option to address problem would be to add messages such as "expected
> warning backtraces start / end here" to the kernel log.  However, that
> would again require filter scripts, it might result in missing real
> problematic warning backtraces triggered while the test is running, and
> the irrelevant backtrace(s) would still clog the kernel log.
>
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multipl=
e
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum. Architecture specific changes are kept at minimum by
> retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
> CONFIG_KUNIT are enabled.
>
> The first patch of the series introduces the necessary infrastructure.
> The second patch marks the warning message in drm_calc_scale() in the DRM
> subsystem as intentional where warranted. This patch is intended to serve
> as an example for the use of the functionality introduced with this serie=
s.
> The last three patches in the series introduce the necessary architecture
> specific changes for x86, arm64, and loongarch.
>
> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-=
4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.
>
> Checkpatch note:
>   Remaining checkpatch errors and warnings were deliberately ignored.
>   Some are triggered by matching coding style or by comments interpreted
>   as code, others by assembler macros which are disliked by checkpatch.
>   Suggestions for improvements are welcome.
>
> Some questions:
>
> - Is the general approach promising ? If not, are there other possible
>   solutions ?
> - Function pointers are only added to the __bug_table section if both
>   CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled. This avoids image
>   size increases if CONFIG_KUNIT=3Dn. Downside is slightly more complex
>   architecture specific assembler code. If function pointers were always
>   added to the __bug_table section, vmlinux image size would increase by
>   approximately 0.6-0.7%. Is the increased complexity in assembler code
>   worth the reduced image size ? I think so, but I would like to hear
>   other opinions.
> - There are additional possibilities associated with storing the bug
>   function name in the __bug_table section. It could be independent of
>   KUNIT, it could be a configuration flag, and/or it could be used to
>   display the name of the offending function in BUG/WARN messages.
>   Is any of those of interest ?

Thank you SO very much for this work! This is very much appreciated!
We run into these warnings at LKFT all the time, and making sure that
the noise doesn't drown the relevant signal is very important.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

