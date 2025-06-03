Return-Path: <linux-kselftest+bounces-34209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C7ACC597
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F146718914FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B722AE65;
	Tue,  3 Jun 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fk4Hkbj9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E508226CF0
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950829; cv=none; b=CQHzMVi4gQUv4ucF0cEaoub1GA1o4f+ca94WMvgPbecsDTFsF1qYY4yjGfiUBKXQQw+fAzUgMi3mFQKifrPc6J9VStWChPJH1L8B6CsmOz/EBiTnByw5ZyPuoqE0ipu0Xfb91eDd8Hu6IzRmWuPBGYvvsguQ+kxk3phHfnb2CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950829; c=relaxed/simple;
	bh=lInIOnu02nSuzGUxFDI/H3CZR9jABCLpyMlUX8cRz+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMg0rN++heB+kjoDGubyfFCt6Sh0xCqVpj5Iwn8msDRDFgAa0skwl2NGShMRxm0jIPHsF/aSPFYU05If6rzNWx1MCcW8X68USuUAdZ4rZeq1mJTXSs522a+rnASEYgDF7fA5rpOiJeBdQ0bhqEtjZ0DtM1JFawZG+42RUKsVDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fk4Hkbj9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb5fd85996so431213566b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1748950826; x=1749555626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciIAygqOrWJd3fbCLXBzNH0Xz2cW+3EmmUs8ebciGxE=;
        b=fk4Hkbj9n00ubbVnLOmPj+7o9mUV/gPPBlCHcICoDB9H4Y1+DY1IugMP174BW3oNnj
         Kn+XufF+VkTBqIq5OOoCY2RqV2aua4IEWSdHUGfJORbY2LuU11fL1bQ2eLujVHELrasq
         vImVT7S/1FZw4mfQ6RqUqHRE7KOTFW0C0PgLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748950826; x=1749555626;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciIAygqOrWJd3fbCLXBzNH0Xz2cW+3EmmUs8ebciGxE=;
        b=TkyKTETtlFYjHYEvGVE5C7KnQBXXvtIwTNUymbyuNiODK8eguCrr1pjotup6WwGOuZ
         5yfJOtnZXSJPNuN3RocCPHieOjZTbmiuO3BUNpQmKQaxTdftASm0frXPAVYqiOkcwN7a
         GirVJmYw8n1V8fhGedOCb7eBJ6HfZJJg0mJSFpmB7JP7xFK+Aj1VGW0NKiuvwtdC9Dck
         6C04Sqo61KmUwetbu6scbpQvSEVOJsvQOJxcGG3gYi9Dyg4lcsIUbjPvTIT1/Gr1pzK9
         Uk6jk3VuXj3rAlHbbQv8d6cIuMJh8X2ng/6tmamFUQ8gZN5+Jn1KSgw/8E9EiB7cLDzU
         +iMw==
X-Forwarded-Encrypted: i=1; AJvYcCX6qBAHurM/VFSR1QR1SbUaHdMQ1jH2ySgY7Nyl0Kb788V25/HgpwnCL0yLQtHl1tVPtW1lqq4u/QRRHwAOzs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPfR+cm6ZlOJjrzsyExnOs5iocgwnuVpH7WdpiFjgoHsA0uFg
	RFNrDsef+tZzZJLjy2mDmVwjhsEjJzjoGFXpheihH52EhSP51y7NikshEos5Q3V+TmQ=
X-Gm-Gg: ASbGnct4zrFDfIREyrCWYPEMvRfLdmB13IX+aPUZQZhigf4luNuSIf+5q+hWdTNi/Mo
	S2l5dIGokx9NugZz4vZPHW94LfkjYOObedlc1BG2UvA53tRNgLknKaIn28Aq8JfkQ34eL+FvRZJ
	ZYJn2r1Cf3uF3DZgATj38CynU5+Fc58PAkwLpzEsZIVgXkpPracXTFo+oQ0raQ4x9D8SFux82Z6
	tWHEqRym0uQYDYlbihMqTNLKL9TQ1eY7qOlVcJM+LCCHrTd8jmc8/ySPZq3TP5Gecz++JRUP4bT
	q5AEzCmFMFdQK8JKKlDgzP5L3izr9av8FpYGfisr6V777kqo2FYIAFoB29Eu+wZLA284PgQYoQ=
	=
X-Google-Smtp-Source: AGHT+IFku9TE8EUVSLqmoCZBKfzqgA+/g+kH4IUAPWkSww+uTbuttoOauNZ+o0S0Qv506mn1chR6iQ==
X-Received: by 2002:a17:907:944d:b0:ace:c518:1327 with SMTP id a640c23a62f3a-adb493df457mr1224596266b.14.1748950826063;
        Tue, 03 Jun 2025 04:40:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm941360566b.173.2025.06.03.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:40:25 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:40:23 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <aD7fJxQWggfGekOf@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net>
 <8C5E309E-03E5-4353-8515-67A53EC6C9E3@kernel.org>
 <20250602075707.GI21197@noisy.programming.kicks-ass.net>
 <20250602-vegan-lumpy-marmoset-488b6a@houat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-vegan-lumpy-marmoset-488b6a@houat>
X-Operating-System: Linux phenom 6.12.25-amd64 

On Mon, Jun 02, 2025 at 12:38:10PM +0200, Maxime Ripard wrote:
> On Mon, Jun 02, 2025 at 09:57:07AM +0200, Peter Zijlstra wrote:
> > On Sat, May 31, 2025 at 06:51:50AM -0700, Kees Cook wrote:
> > 
> > > It's not for you, then. :) I can't operate ftrace, but I use kunit
> > > almost daily. Ignoring WARNs makes this much nicer, and especially for
> > > CIs.
> > 
> > I'm thinking you are more than capable of ignoring WARNs too. This
> > leaves the CI thing.
> > 
> > So all this is really about telling CIs which WARNs are to be ignored,
> > and which are not? Surely the easiest way to achieve that is by
> > printing more/better identifying information instead of suppressing
> > things?
> 
> You might also want to test that the warn is indeed emitted, and it not
> being emitted result in a test failure.
> 
> And I can see a future where we would fail a test that would trigger an
> unexpected WARN.
> 
> Doing either, or none, would be pretty terrible UX for !CI users too.
> How on earth would you know if the hundreds of WARN you got from the
> tests output are legitimate or not, and if you introduced new ones
> you're supposed to fix?

Yeah we'd like to make sure that when drivers misuse subsystem api, things
blow up. Kunit that makes sure we hit the warn we put in place for that
seems like the best way to go about that, because in the past we've had
cases where we thought we should have caught abuse but didn't. And this
isn't the only thing we use, it's just one tool in the box among many
others to keep the flood of driver issues at a manageable level.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

