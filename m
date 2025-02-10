Return-Path: <linux-kselftest+bounces-26214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC3A2F9D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8522F3A398A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE524C69B;
	Mon, 10 Feb 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQvM/5/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C024BCFD;
	Mon, 10 Feb 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218855; cv=none; b=IMnzXyZr0CA4EHbEWpwlwQb5HEhxM8bM15Dfm1WweF3m8S0YKQELCBo4KH/fhpuHwXhYT7BKvDRw1an4/OGs9g/Grni2Pd5VtY8OEAyHVR6OO/RORm98YRwg2P4fxY+uFjgmcq/Juh4pvSNz+UfhS+fa784xVxZcMKPeLlq09OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218855; c=relaxed/simple;
	bh=ys45DKwqBT2EZf6VkkJgb2kGSEyOBWQxiOG3jBxAVPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b22A2qhlpOXbSt8HaRjQO+xB3j+cUkyeVxhyobjxQAkzimNUtrVm9kqf9awJq6SOPKJUMnW/TK+OExbGszXdy6xsvId9qwSPttkByutegdJSMjrhmxv81UJf29Z5kHdecBUz0J+evTPpxBLJNuWv22Dp2Xnulh1m4xwigU6oJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQvM/5/w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f4af4f9ddso54375905ad.1;
        Mon, 10 Feb 2025 12:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739218853; x=1739823653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+U4SNtAYoNj/slS851MmEMQHfNyRR3XcIfGGghXow/M=;
        b=WQvM/5/wPQTAb56ShBkdPpesMdHYf1UevrgJhlwd2iVQQhP8A9WPvdWTNf41lJajwG
         OT1FMN5t4XNl7rEkpEMPZsMhU8JYnCGb5hhOQA377A70T6lYjWMBOohTpLWHmmvLa5RS
         Fe+aHoY1THLvUEL6wHxjCRm0YXTunUJWwKXLGIVyz6soZelTlE9vS4fW/35Su7sa5f8B
         U1nOnE39u13JrpjL19XpGHnWH1Glb5knlNnfVc/8KxAxs/89VkvEJ3y+8IT8K1O0NzO1
         viOpQH5Gsi1YkFdrsotGgjHvl2WyNht91+nXbUzqb/BX928nx4KXnY64QmRy6y6fxG9U
         A4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739218853; x=1739823653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U4SNtAYoNj/slS851MmEMQHfNyRR3XcIfGGghXow/M=;
        b=RD+yO89KtMVeQIM/pVHljDDHvTOZ8EGIOamCuRTzo7PcoDAqo5fgzqALHP29U4lgSv
         sGEzRz3rhQTNntQUAixJhqklbE/XWZHxxWu+96eTjpTd65YDnw50OD/74lBLaqxZQL6c
         7rRORV7fDV7F1HTEf0VlWCsuZ8dHOkVUoAmFMxIfkX/bW/iZX11Wl8QraEfXhnx/Onqg
         hNcUEFQ6gMskWolLptEBsKNrw2aGVjdbtc4v8d4ZJ81KfSvP8N+w0Y2/JeZBKmhDIgeB
         aPz0O1WPJ/GSuKQcX6la6ARIcaTpr+mZjHP3vZpxurzCb6Ps+1srWYXTJOi00tx5UF3a
         TmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4aoKx8g+OTsBs+PYu+0wu+8pb1mWHvfmmjH0cmHah2bTBiHsM41Rzn4nKRikFnBI5gQm2O3MOCw+4dU=@vger.kernel.org, AJvYcCWmZBg0uJ1kVWD5TG9nfO8D6XM5Awmyonf9Rb6NmSN55++PHO+uMwK6EPFMsBpAuOWdGsr5aeyEC+GjaKcFXDSu@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTUgldiEWxuwJGhIkTi4Sekz3pqrfFQskuX0vRSFzvwngTX6X
	ypgA74tsjBcrG1ZNCaqYeyIiSkubkTuBEY9hISnjusuzDtERCgas
X-Gm-Gg: ASbGnctLROzOabT1mZIfkdzKFJHxQQX8Y83REp0xSt+D+lbFBzhCYB3Cu6Dw9Zfk3DH
	webg/iwOt5fS3rGFD3sdMW2lw0MnutD1bJk3DfYq+WhDmav5Kj928a94ww1Dvop7Y12rCbXtyRt
	qScnxqCc5zFx4UZ3tV5QHeI6MLipgYFCEY78Cgtz5k/UulqGKfYlokZMy6KXbH7Mw1uDCj9/fCN
	VP2UcdL9e0lVmsOnPizGDfZkyHjxlpDQVmD/kcsd2sop1Zihe0ni9KlQnKnDNt9u9MKjCkMeEdX
	DK6UyIX+ygv+Rgs=
X-Google-Smtp-Source: AGHT+IFFp7T1utLBt4O/HjDrewHfjUvFxkAs6j6ggHA+b7oWllB60ZkZFVyLSjMCjdbjvvvdajt23Q==
X-Received: by 2002:a17:903:94e:b0:215:9470:7e82 with SMTP id d9443c01a7336-21f4e6a035bmr293695885ad.4.1739218852479;
        Mon, 10 Feb 2025 12:20:52 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce0bsm82768025ad.21.2025.02.10.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:20:51 -0800 (PST)
Date: Mon, 10 Feb 2025 15:20:50 -0500
From: Yury Norov <yury.norov@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Tamir Duberstein <tamird@gmail.com>,
	David Gow <davidgow@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Brad Figg <bfigg@nvidia.com>, David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
Message-ID: <Z6pfomw-3LuWoQQo@thinkpad>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad>
 <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>

On Mon, Feb 10, 2025 at 11:35:48AM -0800, John Hubbard wrote:
> On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
> > On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> > > > On 7/27/24 12:35 AM, Shuah Khan wrote:
> ...
> > > > The crux of the argument seems to be that the config help text is taken
> > > > to describe the author's intent with the fragment "at boot". I think
> > 
> > IMO, "at boot" is a misnomer, as most tests can be either builtin
> > or modular.
> 
> Right.
> 
> > 
> > > KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
> > > on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
> 
> OK so I just bought a shiny new test machine, and installed one of the
> big name distros on it, hoping they've moved ahead and bought into the kunit
> story...
> 
> $ grep KUNIT /boot/config-6.8.0-52-generic
> # CONFIG_KUNIT is not set
> 
> ...gagghh! No such luck. One more data point, in support of Yuri's complaint. :)
> 
> > 
> > I think distros should start setting CONFIG_KUNIT=m.
> 
> Yes they should! kunit really does have important advantages for many use
> cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the main
> obstacle.

Hi John, Geert, Tamir,

Can you please explain in details which advantages KUNIT brings to
the test_bitmap.c, find_bit_benchmark.c and other low-level tests?

I'm not strongly against moving under KUNIT's hat, but I do:
 - respect commitment of my contributors, so I don't want to wipe git
   history for no serious reason;
 - respect time of my testers, so no extra dependencies;
 - respect time of reviewers.

Tamir,

If it comes to v2, can you please begin your series with an exhaustive
and clear answer to the following questions:
 - What do the tests miss now?
 - What do _you_ need from the tests? Describe your test scenario.
 - How exactly KUNIT helps you testing bitmaps and friends better?
 - Is there a way to meet your needs with a less invasive approach,
   particularly without run-time dependencies?

Thanks,
Yury

