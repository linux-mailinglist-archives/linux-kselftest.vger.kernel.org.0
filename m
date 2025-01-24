Return-Path: <linux-kselftest+bounces-25126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5710A1BB2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 18:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA0164A35
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C91ADC80;
	Fri, 24 Jan 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdA47uMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3423B0
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738313; cv=none; b=Wvq6rnuMpD1W+/BKdDI9/egJtOXdfqrZyRcFCz+fGMmUqJn6MBIx3xU+4Zx+clUQKsCa44OAs1Q2zwtUyi88QohAaVaxSlXgK35OVypPnLNyborVOUBcb291PBShCOtO740WilNZ+C9KMSoC3YAk5MIwBAVAWQRh4Shd9MaKQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738313; c=relaxed/simple;
	bh=4fN1uH9lDG5fEfcui8GHEO7QetyS/U+dA8LY00hN1Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiMQ7Y4RJs/WWoinKfEHlvAQrPlUjPDXNIpuZC/rrlLISWbxbM3Xump/0rD2zzWO+01wMCztvfNm0NiMqjW4iBNoZR7KSnav7+N3rRbYsROF1D7FL14CAYJ9vWPIWnBrSb7rxHlGRweWWBjf63emg74zTnWak04J5oSK7dPEMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdA47uMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737738310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3P5t3YOD48EA0EV2RHNoq8geVxugYi56wkyKb35rHg=;
	b=VdA47uMjRGBcJiFDF/BmTYGupJoA/mS0FlwPotFhbEOlkQh4z/IEWNhoasxsoQzaBceb85
	bn1D7B5qPjb0unUc+IIF6A+zdKX9VdnP4xerdz+I5rM+2BT/niSpdL0ct8wOE1j6YL4x+7
	v8HZKggvcFxjEIk56vSe+WPXEwV3Jn0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-oCYBWtvSPcu0ONLVWq-8KQ-1; Fri, 24 Jan 2025 12:05:09 -0500
X-MC-Unique: oCYBWtvSPcu0ONLVWq-8KQ-1
X-Mimecast-MFC-AGG-ID: oCYBWtvSPcu0ONLVWq-8KQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d6ee042eso1735092f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 09:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737738288; x=1738343088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3P5t3YOD48EA0EV2RHNoq8geVxugYi56wkyKb35rHg=;
        b=E+zCloLEosUbAU4QmOpS/BKNy7whGA46flfXqQUjuLNrPqHcBrgfQT0v1cBByXARM2
         6I+zXj9JTs40gnhtoiKNzBs2foS420iL0YmSgkeTQBhdY0vDswQwIhu0x3J3N6Qw+DpZ
         RkuUdLZO8QmbL1YFGkhgYfPSLs+L48aLLDtU9VQc6cX1CME9kzgCEPXrAMozGcDLBFih
         cpoNpIyVxDyG/eB+5hv1awobtF3p33WciZc2wgq63DsItN/4tYZuGL2/R5lhHRj/fO4N
         BHZPnqtKidAYlOuNYrDhc203/8c1ep+vLVjc6yUn6E1z4UYCTh15UQtzWuiHlAb2pEHp
         Wcqw==
X-Forwarded-Encrypted: i=1; AJvYcCWaxvvoXAOFZ7mpgRF2Z2rl2QyIRre9Df+RoJWz40RAIRaHYBnWQUVJwVupTcmhbCOdqai8H3TPy2Iv6mepGjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmNXm6EY9wIretX7OOWI1iz0wKikyzNXLbH0jfCa2MJXRSnue
	agAImnmCPHlCmd0kfK1NN1L29LocWc80iGoj/Efz8cxTWaDufWeXhWdUy7bNg2PC37lSrzlA3q5
	zy+FwlW+pibdJdjj06SqFs9/mnmFH75lePmjEwgMh8FQmx9/1K006XvbstmMAeTBUWg==
X-Gm-Gg: ASbGncsR/eb1KT5Cjirog3EoOJ4tCuMpbT7DuIlsGKNgPHJ5dINGxOcd6A+DHiIvM7O
	bqu41QtOCOWykD9Bz8atVIUu+hO2B08e6zVa/0E1o3+eSgxzmgOTmlQWRSWTm0vi8+/lyLguWN8
	ktn6n9zg+og+0w3CctdkdLrfQfgEYg/1C5SksvSrIRqUkuu6jDXvZuKR0gsJ+9ou4MZbbHXaJJZ
	Cgjy2Safy25j8FdYeby2M9BIawpz2jgDq/Z9hmF9CMs5qt1cIhtSU458UjwKeLd7qpSZ/qh9Abf
	MHR5Y9P6kj1qMDffgo098ZEtBhfUNQANyfgHA+AD74dWYg==
X-Received: by 2002:a05:6000:1aca:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38bf57b7fbdmr32674037f8f.40.1737738288529;
        Fri, 24 Jan 2025 09:04:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+G9Ly889nxwWYhEnpSlN2C9XnZE/zqCyWPABsxutMfB8Ly5aCQaffnJgn9avJEiwi5J80pg==
X-Received: by 2002:a05:6000:1aca:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38bf57b7fbdmr32673940f8f.40.1737738287978;
        Fri, 24 Jan 2025 09:04:47 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1885besm3187760f8f.49.2025.01.24.09.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:04:47 -0800 (PST)
Message-ID: <8db7c8cf-6976-4dbd-92d1-62ce5288dfb7@redhat.com>
Date: Fri, 24 Jan 2025 19:04:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, leobras.c@gmail.com,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jarkko,

On 1/24/25 6:32 PM, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 2:58 PM EET, Nikolai Kondrashov wrote:
>> Of course we could keep it outside the kernel tree. However, the point of this
>> contribution is to provide kernel maintainers and developers with an easy way
>> to setup their CI pipeline on a GitLab instance (the main one, FreeDesktop
>> one, or any other). Basically this is like a template or a library, if you
>> wish, which helps you do that. Approved by Linus too.
> 
> With all due respect, "approved by Linus" is not an argument :-) I get
> that Linus can make the "ultimate decision" but in argumentation I'm not
> a strong believer of authority based decision making process. Not
> downplaying this more than that I knowingly ignore this comment.

Sure, fair enough!

>> Why GitLab? Because it's one of the best, if not *the* best CI system these
>> days, with lots of flexibility, and it's Open-Source too (well, at least
>> open-core, which is still very capable). And also because a number of
>> maintainers and companies are already using it.
> 
> There's also Github Runners and Woodpecker CI used by Codeberg. To add,
> some companies and other organizations prefer Jenkins. This one fit for
> all strategy is somewhat short-sighted.

We're not suggesting everyone should use this. We've just been using it, know
it well, know it works, and so are trying to help people use it. Please feel
free to use something else, and of course contribute the corresponding CI
setup to the kernel repo! Not that I can stop anyone, of course, but that's
the idea behind this. Note the "/ci/gitlab-ci/" path. Anything which could
help maintainers/developers integrate testing with their development workflow
cango under "/ci/", I think.

> Also running Gitlab tasks locally is possible but is heavy-lifting.

Yeah, it's not perfect.

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.

This is not really for individual contributors, but for maintainers/subsystems
to help automate their team's (and contributor's) testing.

And this is not saying you're required to run GitLab CI for your contribution.
It's up to a particular subsystem to decide their policies: whether to just
have the maintainers send contributions off to a GitLab CI instance during
review, or larger merges, give co-maintainers access to it, or require
contributors to submit an (automatically-tested) MR.

If you send patches changing CI, then of course you're expected to test it, as
with any contribution to any project. But if you're not running it, why would
you do that? And if you or the recipient maintainer run it, then you get it
tested automatically.

> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

Well, some of the people in this discussion do that, and more are mentioned in
that talk I linked. But sure, I think contributing their setups to the kernel
tree would help others who want to automate their testing.

>> Sure, a script could be contributed too, but the value of this contribution is
>> a ready-made integration. And we want to make it easily discoverable, and
>> easily contributed to.
> 
> This is definitely NOT "lots of flexibility".
> 
> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O

No, of course not. This is simply to make life easier for maintainers, who are
not necessarily DevOps engineers themselves, and want to try it out, or have
it setup.

Of course, having well-defined CI scripts would be great, and we enjoy e.g.
well-defined make interface in CI, for example. I assume engineers who
implemented this (Helen et al.) would be happy to use such a script, if it
existed and was suitable. The problem is that it would still need to interface
with GitLab CI, which is while flexible, suffers the flip-side problem of
being complex. And that's where the devil is, and this contribution is trying
to help defeat it.

>> BTW, here's the talk we gave at last year's LPC regarding current use of
>> GitLab in the kernel and surrounding community:
>>
>> https://lpc.events/event/18/contributions/1728/
> 
> This patch set should make the case, not an old presentation.

Well, I'm sure there are angles not covered by the cover letter and commit
messages of this contribution, and I'm partially to blame, as I was one of the
pre-reviewers. However, I'm sure we have left more stuff uncovered than we
discuss here, even considering the discussion of the first version. And so I
provided the link to the talk as a rectification. But if it would help, I can
provide a summary of it here too.

Nick


