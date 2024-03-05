Return-Path: <linux-kselftest+bounces-5951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB3872806
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6D1F23899
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281586654;
	Tue,  5 Mar 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEu5tKE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA01C29B
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668451; cv=none; b=mAsiIo19IoyWgr4yYeGWPQ2oaHSwdPd2s9PLWa7uRxGYafv4HgTqQxxmYQJQppS3c6u9KqgdJEGb8Op0lXDRXAnsQ0VI2bsdadY36Y12dQtsvL94hf4meUGu4uyq72x3vCMPj5mv5Kd3/UGQ1iSPhTeaA126MXX1WknB714LwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668451; c=relaxed/simple;
	bh=Thh+og9vWfifMZ7QUJajbgXYm3QoY+CJHcawNAefhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjV9F0ZXfvH0dTfD5m572adopNZB4Rf/qcvPQJJ9pTFYO7n9ivOvYm7AlWKkkBJz99/3rzD7iC9AADUR5LitMXfoCVSlgC6yR3k67W9uVPE3Ct5De3t77mWcXxhKmMYzcvr94Utbgr6mFwKFRWIpTiF2srRkAgvvCwEU6mFqQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VEu5tKE3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so92792b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709668448; x=1710273248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OJiIuppva2X62G3XuKOpZ18Of2oWMu+/RVVvODtp4M=;
        b=VEu5tKE3ZGEMGDvffumPkT0uy9dQ8tGrLGc5mS3ynHiKSCM4jxVM5Mk1gHagvtd+va
         4Iwg26a4/Jq7rwllJwhLNbUP9PnQmbrV8ntmuSzHQaslvio2ZDd3/Xg2cJSCUEe9CPxH
         Qc2vmlAQcaToA8ldYp9nPwe1NLKlztG9Emee4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668448; x=1710273248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OJiIuppva2X62G3XuKOpZ18Of2oWMu+/RVVvODtp4M=;
        b=IZnhFYwS0vmZjF8sMVJ1hV0XeAOTFYFmeFLprnukaB8qD38j9MVqCf9AxmvWph9AXz
         hS+gsLDio5EOD1q91jT3BpaHfTm+pn4kAZQVS8qyrsuthbLwIckPZp5J+MH4PGtw2ix0
         kfhnLxMkpogATgJblK9UGjGzZCG0yqI4blNWMSmjk8FjMX/syWmdjK/WUTpKqD1MA8uP
         AWl4PDtatnEMI8qoEARbrT8cvneBOFLJijmELKgO9PBy1LygpfecDI9P+ahr1otECMNk
         keXiW7s3kkrNRdrbmJ3X7bwJlvsvXyGjFp4WgIvNF0JONLXulcejJbA8ophhxeIZ4mCo
         wSyA==
X-Gm-Message-State: AOJu0YwS4Mu5QD+K1QQnyWlrk4hn/uud2jPzWxFY3uXFG8bG60Moklfy
	v0qneiqHrSMTiiRjpqsGoxzez0P/HOlO0DWc9Qkir5mIS34DP5TaNTEntUw6gA==
X-Google-Smtp-Source: AGHT+IEPSGoV+PaXRY7JI9uSPnapXCs52p1ILPTe+H1wv+UxrhqJWz+AChv6CTzYH5Lp5odgHWXRGQ==
X-Received: by 2002:a05:6a00:8cc:b0:6e6:1df9:af92 with SMTP id s12-20020a056a0008cc00b006e61df9af92mr4909513pfu.14.1709668447845;
        Tue, 05 Mar 2024 11:54:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006e52ce4ee2fsm9391340pfo.20.2024.03.05.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:54:07 -0800 (PST)
Date: Tue, 5 Mar 2024 11:54:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] bug: Core support for suppressing warning
 backtraces
Message-ID: <202403051149.547235C794@keescook>
References: <20240305184033.425294-1-linux@roeck-us.net>
 <20240305184033.425294-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305184033.425294-2-linux@roeck-us.net>

On Tue, Mar 05, 2024 at 10:40:29AM -0800, Guenter Roeck wrote:
> [...]
>  	warning = (bug->flags & BUGFLAG_WARNING) != 0;
>  	once = (bug->flags & BUGFLAG_ONCE) != 0;
>  	done = (bug->flags & BUGFLAG_DONE) != 0;
>  
> +	if (warning && IS_SUPPRESSED_WARNING(function))
> +		return BUG_TRAP_TYPE_WARN;
> +

I had to re-read __report_bug() more carefully, but yes, this works --
it's basically leaving early, like "once" does.

This looks like a reasonable approach!

Something very similar to this is checking that a warning happens. i.e.
you talk about drm selftests checking function return values, but I've
got a bunch of tests (LKDTM) that live outside of KUnit because I haven't
had a clean way to check for specific warnings/bugs. I feel like future
changes built on top of this series could add counters or something that
KUnit could examine. E.g. I did this manually for some fortify tests:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=4ce615e798a752d4431fcc52960478906dec2f0e

-Kees

-- 
Kees Cook

