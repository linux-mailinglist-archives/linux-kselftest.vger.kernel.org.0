Return-Path: <linux-kselftest+bounces-156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634947EC80B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A0E1C208FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF8433D7;
	Wed, 15 Nov 2023 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gT6deisK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6131725
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 16:00:48 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF65194
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:00:47 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f48b6e0388so1154969fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1700064046; x=1700668846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=gT6deisKI4WEaVwsq+NFFTt6ergwIaW4HqJ4M5a1BlMxrKIPGufiSXnGNKkhonwvBW
         ou3uzIVEUQIbGU2kWZGyg2o4A5D9R+GbXtCrgEz5eeCymCAAR18Xwyv133Cvzyog/eaS
         Gtd2f/DsabugquTwOGhyVYDMc6jrPt6bSHDO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064046; x=1700668846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=YqTTJb5EtA6A4+O2DbraSuUVNxtwYeoOuD5CPmMcH0befbHR+V6LGUqyQ1c01jFUvx
         TFuJSRvTHcCKTYuP1MQld9elCS3wY+JKUNxJqukr2nlUZgKEWHZhQJegIxXYnFqJNIdA
         qa7JTpOJkTbFvQNKlek7AMUHyePMyKx6cBcwMns9aEXFLHoHOtBOkwE4LnaaJXkXUKsU
         bDIWsv6I+prcEFeXCbwLm9KXJD7Ip/cp5RknrlENlmDWNXLKkjzRK7mhbMY8nEveNGIJ
         gKjo7tNnShZZGw7EJktwSXnwK2aCvONo1iP271+dfD2RmN4R1S7ZluCCHBH5VNjEqlGs
         AUSA==
X-Gm-Message-State: AOJu0Yy5Qj3PaT9CxXk0EhtpB7ut1yT4IiKDj/wGC0mhN/NWM2v3UvG0
	VxSkhxKX4Ca1hnGCGwq9G4wnp3TmtAuL4evA1GAO6A==
X-Google-Smtp-Source: AGHT+IEC7e0xzEZvfFar3WHPgtO7pOAY07ejbJf+y9ARFz7vkcAW/xxvlGk01OR2uItXzOvVmoLvaArE9Pf6m0XXx+0=
X-Received: by 2002:a05:6871:5c47:b0:1e9:bbfe:6458 with SMTP id
 os7-20020a0568715c4700b001e9bbfe6458mr7237902oac.1.1700064046168; Wed, 15 Nov
 2023 08:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com> <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
In-Reply-To: <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 15 Nov 2023 17:00:35 +0100
Message-ID: <CAKMK7uG-FH6iLpNpQ74xXPZoyGoDGvg+L99oCK3nFZT43o6GcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action function
To: Maxime Ripard <mripard@kernel.org>
Cc: David Gow <davidgow@google.com>, dlatypov@google.com, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	Arthur Grillo <arthurgrillo@riseup.net>, Benjamin Berg <benjamin.berg@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Airlie <airlied@gmail.com>, 
	Emma Anholt <emma@anholt.net>, Kees Cook <keescook@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	Nathan Chancellor <nathan@kernel.org>, Rae Moar <rmoar@google.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 16:51, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, 11 Nov 2023 04:08:26 +0800, David Gow wrote:
> > KUnit's deferred action API accepts a void(*)(void *) function pointer
> > which is called when the test is exited. However, we very frequently
> > want to use existing functions which accept a single pointer, but which
> > may not be of type void*. While this is probably dodgy enough to be on
> > the wrong side of the C standard, it's been often used for similar
> >
> > [ ... ]
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Daniel Vetter <daniel@ffwll.ch> for merging through kunit
tree, since I guess that's the simplest way to land this.

Cheers!
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

