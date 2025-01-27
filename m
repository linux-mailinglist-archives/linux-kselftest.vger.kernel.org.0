Return-Path: <linux-kselftest+bounces-25219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6DA1D3DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 10:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDEC3A5810
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168981FC7CE;
	Mon, 27 Jan 2025 09:52:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCB179BF;
	Mon, 27 Jan 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971568; cv=none; b=L2LMMahDCqllFuaz+0h5Fry8Kz2W42POCUtLEb8boO/8nx6mvmH5Jx8qfFzwWK6D/7VgUbaDLssdGuzW/6kR3PQcHkiVaSR2TvxzMykJJCxhJKZ8AunIvGAAlb38BHYOczlQX+myiiCZxLM+B3x4QVRyyxRHhEPQ01T0Gp9bIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971568; c=relaxed/simple;
	bh=sEf2lqaqotPf1mI9av3Y9XvH4rokBRV4qQ2BB2ZGMps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPvHgBhUzvPnqgrXDTQ3ldDEciQLCoUo2FkqF6MVxKpwZBLVpQKVVlz1uhOGTBDTOOiQ96IRB0erabhhzSqABUczOYU/hX8eqWHwrsnD1IX8W3MVu5bFH84zmRJJLxL37cd+ySYobQgRtIl2aEeURoTSq9y/qiRYcSS62+rbsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso1076531966b.1;
        Mon, 27 Jan 2025 01:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971564; x=1738576364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40YkW2LXcjSJharDQzWCHs9h4KhBTXSlHsAO4Ud+8ho=;
        b=H6d0Mh3EM2fmeUIrSaAZgPD06tX6/SKvsaAo05sQUSGoAoElQaoulkEFF/4WbFPtXD
         GqF4tNAn4BkEkFO5Ly41F9KZQeSNBeJW408qsJGuFt5Vp+41/qNfmROnufErtcwDOvKz
         wUqfUTeZ19Nn+ZiV7YCLwu1HuKFPsUFWg2DkzvL+hw1rP5KpKUbYbobqTbXyCKTOy7Rf
         Psy3kwLz5teVrtVvwv2A352XQPlEXbyBob3zXyoVKnFYgabuuGVLFbHqPNrKtWbMvSaC
         wloLQlf7ErXgFRJTjj/VpYHcG8ytI4GmD7Utde2VRLCCCY+hw8mrAGekY/a5ev0Zeb3r
         /adw==
X-Forwarded-Encrypted: i=1; AJvYcCW1MmbSFZ/6jRvzyzBftsdIYQ/C/+qO2By24KNoIqg88fVAA5w1bdvEUNXwl2gbMr1NVKaLkNiV@vger.kernel.org, AJvYcCW3NImfsrBPcepz3FjjPjQyPBX1toyoFrPTAIqm9t2MKiMU19lt3FFnNsAdNlPuNFYLX+rDalEKutE=@vger.kernel.org, AJvYcCXoI/vnXUSwPQQasrcJIBifNM4Obp3u+YiL4xJQ1DOwIywzxTM77AhApTgqvBzNCrdphntQds+Oe1540LzxxHm/@vger.kernel.org, AJvYcCXql/JTLvYDQJcOx1H8KRQq+mCD89cuHrEu6CVVokyaZ55VsK3mCws8P4hoOwjFkkdQ0myfwSSHtqyLk8Wr@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxMrg1kxQQRu4e7riws4KMb+z9jdhAgN1Mjgkhkeng/FJ35xE
	r6x7MJRiNUVt3v4tNA2VKXrrZjuaBnA1NZVWpR5Q01wG4jH0zwAs
X-Gm-Gg: ASbGncvUThnqA1+u0JkEcEyIuUtBkoTUJaIBX2Wr/eZyRFr9eybJzSHd7Ugq9Ny7BA6
	gTW0BXUlinUgl4SjIMogmvgSakNfW/qzBu2w/xZeCoiIVbC2DAwDpl07/JFaBnVG8sWRGkVgE1z
	BvyCIB8dFuPY1VZC0fO1kpAuhxIJ1Y6IOVXvdJ4NSMdUnoVj/ZPh/LHipyG6ghpRIALHhMhzMhS
	mNyt4/DF28LaBOhqdJeeWzy2wnQT6/FM6m6Rlyk/7lQJTYjcW7kYifiUIEbNNSI8wXyu2Cs
X-Google-Smtp-Source: AGHT+IEBIGrKmRyzhMhTGlg7/KJLGnU3xVhUnix8IGJESgpT0glzSYucvwydW/0uowaVliDoqimPjQ==
X-Received: by 2002:a17:907:948e:b0:aae:f029:c2ec with SMTP id a640c23a62f3a-ab6629683fbmr1519661566b.12.1737971564026;
        Mon, 27 Jan 2025 01:52:44 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676116aecsm560668466b.170.2025.01.27.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 01:52:43 -0800 (PST)
Date: Mon, 27 Jan 2025 01:52:35 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rdunlap@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 0/8] netconsole: Add support for CPU
 population
Message-ID: <20250127-rampant-beryl-mamba-bdbcd5@leitao>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <d441f627-1686-40fa-80cb-e84c590b8b02@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d441f627-1686-40fa-80cb-e84c590b8b02@lunn.ch>

Hello Andrew,

On Fri, Jan 24, 2025 at 05:02:26PM +0100, Andrew Lunn wrote:
> On Fri, Jan 24, 2025 at 07:16:39AM -0800, Breno Leitao wrote:
> > The current implementation of netconsole sends all log messages in
> > parallel, which can lead to an intermixed and interleaved output on the
> > receiving side. This makes it challenging to demultiplex the messages
> > and attribute them to their originating CPUs.
> > 
> > As a result, users and developers often struggle to effectively analyze
> > and debug the parallel log output received through netconsole.
> 
> I know very little about consoles and netconsle, so this is probably a
> silly question:
> 
> Why is this a netconsole problem, and not a generic console problem?

This issue isn't inherent to netconsole. To provide more context and
clarity, let me take a step back and revisit the history of this
discussion, where the idea of adding enriched format originated.

Initially, Calvin proposed adding similar messages, such as the kernel
release version information to messages via printk, but this approach
was deemed inappropriate. The discussions could be found the following
link:

https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/

Later, we shifted to implementing such enriched messages in netconsole,
which proved to be a less intrusive solution. I implemented the release
append in netconsole, effectively addressing Calvin's original concern.

https://lore.kernel.org/all/20230714111330.3069605-1-leitao@debian.org/

The release append proved to be very useful, the concept evolved
further during discussions at Linux Plumbers Conference, where we
developed the userdata feature, where any userspace data/text can append
any message that flies together with the message.

https://www.youtube.com/watch?v=ILTqn1EYIXQ

This functionality has become *extremely* valuable for hyperscale
environments, leading to current efforts to expand its capabilities
- specifically by adding CPU information and, in future updates, the
current task name.

For instance, at meta, we append service name that is running when
"something happen" (warning, crash, etc) in the kernel. That helps to
narrow down and categorize issues very easily.

> Can other console types also send in parallel? Do they have the same
> issue of intermixing?

Interpreting logs is straightforward when dealing with a single machine.

However, the complexity increases exponentially when managing a large
number of servers and processing logs to gather metrics on systems,
kernels, and more.

For instance, let's come back to appending the kernel version. When
working with a single kernel/host, identifying the kernel version for
a host is simple. If a warning message appears, you can easily attribute
it to that specific kernel version. 

In contrast, with millions of servers running multiple kernel versions
and releases, the challenge lies in accurately mapping warnings to their
corresponding kernel versions and releases, that is why having the
kernel release together with the message make the mapping easy.

Thanks for your time reading it and the discussion,
--breno

