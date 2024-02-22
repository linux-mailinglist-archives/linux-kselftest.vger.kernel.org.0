Return-Path: <linux-kselftest+bounces-5301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB986002C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABED28C610
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116D157E66;
	Thu, 22 Feb 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C/GZKSCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E24156960
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624643; cv=none; b=YfQc/ybM/qbL061Td7kWiWBr4fE2U6ccADRvaaedxpcEMQsZCh62AryyisF285jjs8SFXCSXs1i/TIc75oTGo699RLhVR8yG8SkbwOvx7jmOU+dSsVk+OWl57eNRrvyXxhHl+ZV33Av9D/YkdwNHKHKBSt3sMI6mJBZDAiYxO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624643; c=relaxed/simple;
	bh=hlPKjlQSc0kMs/W05kmcLVH3IEjiTit6toh7GkaAPKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMoSAfXBKBuARnz+b0EuSPMb9MX9a0hK5H3DFSugsh2dWwa5+yYRrnwuBYaTfBC6PmIqX5pf9KXt2NRHU4mqe9zpIVZKhU6Ze8UBjWix/4VWpaXf+Vv0fgNMnP4vxnQAtCc/83Yoj4lM+VofbnJiCn7WqQjaGR2Lf40bjlCa/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C/GZKSCx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512e4f53dbfso17643e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708624639; x=1709229439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=C/GZKSCx9krnzW/91GYSpXCFzd4lSh/fVce4znbLwfR8AxIHeSj99gMXHqiEgt+MYl
         zhUlkyyYyhXJ47/KDPwISDkS/uDO9DYrfAXEN7Yefz03EBkVymKB3ugTh4dKQ2oIbS8P
         BRSLPUJqVNlkHCSOQDeDKklgoNgB2P8ZbIQD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624639; x=1709229439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=RWZF6SHHwnEH3+V3P7brRrqDMc6wwRffaysMlgIa1rhxvpsxonWtRiKnCANNgjJaRc
         t2enh8Z6Gm3E0+wRa6neMnMsqi6XZQIJK1MxCgn9vbeKYJN4a1+tKJ+o2vZ9vrjZoSls
         +JD/RKsH5vhp586kTxTJoXm7AZ2AiyXvuu+Vq5G8dKdUIFk31YWgTa8E99/Ge45D0FKt
         OZxON+RGIubrwhmkqJyGLQNr5xjQgH0luGDNgpwWYwBybCyXXQg2CbLRvqb39UGrd85h
         enzDeLjJUTo82CC1aP5iShRcNbLwqzRJqELqNgG/6Mg29F/+tz35RadKWUSCqxv/VYuu
         tPEw==
X-Forwarded-Encrypted: i=1; AJvYcCVp1lnsnEyKQNJUBWCa0YqrD1UHORHEXHiZKShd8DHbPxVAAEDILf63+a04GKlHXZxy9XJQnSP+Z/K7Eb0dWtk9VTJAqi0hlJHPNnt/VKgM
X-Gm-Message-State: AOJu0YxSefOpd9LBvSJfEo9lI33yuFkLlq8O5IOTucF5jhQWI6V/9DxV
	NNSSc8lHXCvETg0davAjHXFw9NUseZ630P10UvYMOCAbd4dEiTCXQML0ikn9eAGmERAHASkfzqV
	vfQbyDw==
X-Google-Smtp-Source: AGHT+IEPK/T2/s3HRWzQKCnhcFIIo82kymJNB7rd61mNvNh53gmon65taodTz7LbSrKFtLwHQnbnxg==
X-Received: by 2002:a05:6512:3f29:b0:512:ca34:664a with SMTP id y41-20020a0565123f2900b00512ca34664amr6511773lfa.32.1708624639477;
        Thu, 22 Feb 2024 09:57:19 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w25-20020a0565120b1900b00512daf246f3sm374114lfu.269.2024.02.22.09.57.18
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso56230e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 09:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqRgMCHtZJ3tDMacVyrw73kW+9D5aGnDkLVWdRqJdpWFMCOXKi8n91Nf1inH1cq+naHQJfCHBbiAZ5u/Zn5Ev+JzCIydjo7OxkGe8i0ur4
X-Received: by 2002:a05:6512:3089:b0:512:acf1:6970 with SMTP id
 z9-20020a056512308900b00512acf16970mr11555378lfd.35.1708624617484; Thu, 22
 Feb 2024 09:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-3-davidgow@google.com>
 <20240221201008.ez5tu7xvkedtln3o@google.com> <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
 <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
In-Reply-To: <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2024 09:56:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
To: Daniel Latypov <dlatypov@google.com>
Cc: David Gow <davidgow@google.com>, Justin Stitt <justinstitt@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 09:36, Daniel Latypov <dlatypov@google.com> wrote:
>
> Copying the line for context, it's about `p-r` where
>   p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> `p-r` should never be negative unless something has gone horribly
> horribly wrong.

Sure it would - if 'p' is NULL.

Of course, then a negative value wouldn't be helpful either, and in
this case that's what the EXPECT_PTR_EQ checking is testing in the
first place, so it's a non-issue.

IOW, in practice clearly the sign should simply not matter here.

I do think that the default case for pointer differences should be
that they are signed, because they *can* be.

Just because of that "default case", unless there's some actual reason
to use '%tu', I think '%td' should be seen as the normal case to use.

That said, just as a quick aside: be careful with pointer differences
in the kernel.

For this particular case, when we're talking about just 'char *', it's
not a big deal, but we've had code where people didn't think about
what it means to do a pointer difference in C, and how it can be often
unnecessarily expensive due to the implied "divide by the size of the
pointed object".

Sometimes it's actually worth writing the code in ways that avoids
pointer differences entirely (which might involve passing around
indexes instead of pointers).

                 Linus

