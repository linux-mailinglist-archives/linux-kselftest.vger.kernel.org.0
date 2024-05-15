Return-Path: <linux-kselftest+bounces-10207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D218C5E65
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD41A1C20FC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E17812;
	Wed, 15 May 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Plx7n0X8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA487FB
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733848; cv=none; b=evaYu4joje2f3uaoMKta4EFMYFfaPzr1xapN8DBhesjRMcEKjvzcyWZ/Nb/O9BM/N5Iy9BBiMZTSJhjjn18dg9MiEWA+wUoH5hoz5GJz2IR8bsOJkJ7qZLXABqUGt1ajuxVePNkHyi96MnAdWm2Gi6UdehvW4hYFSi22v4g8I1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733848; c=relaxed/simple;
	bh=iyxC/dRXIM6KYxQfRCHr8g+kv1gexJCsm8khro+Q+uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr5qSdLjCVjkkzxfQyWU72+zg0GbIUMjTHScDTeExIvPV+2dutImM+nIRHjRs9O6HsdBCgzqGqX4cUSjYb76xqUqKR+ls56glfY1HalBjHCftoM1BuY5B5iEQBOM2MDsAQmcC//j4EzohnTklLuM5vIbmGBBa90+Jw7+AIWqPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Plx7n0X8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so994372a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715733844; x=1716338644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=Plx7n0X8y6yIj1mJsUk4XX/ArUcg4viBPqKx5/GYYIgD8qVXolUkF9LIVxsPrvqjB5
         h5m3wBZxFld2j0pJ/nZvHDSYVl5D8nOfB3Ziyn63ywsxLFj+EiwQ7y9Z0nn6KkLuY/hA
         MfOo2nAxUyCX8zEcG/D+hnpHNMne6beAjxCrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715733844; x=1716338644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=Pn1XEPPWpuSAvv4ml+yaVJwGiy/z8jj1yurWcJhVQoowYeoGoYYFLgkgc0huZipPpv
         c2sU/CAzwqe64djZXyYofuqx5jg3OowrJ+oZNMCxFuxnWX+0mcPXdLe5fbPoniBsefFU
         kSFmTdMxJ0/6+76lAXM98dudGFELmY/XFHY8TaM8aueRXJgH45mWOEKEAm4KD2qacmsP
         eJPUVkwZkfNiEsGx5bOsKJ5qNWOXhVp+CffJJPOCFcI38W4fUyAPnxYIdKB8k/TDNV2w
         Z2LLy7tj4RoEMmhUAEeIN6uCXwsFG32dV+NkF3LyZt3Ty9jS0uJkTFng5FfKpwsE3sf3
         h+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVjuwuNnrgV1Noz7hT+8pAYpdPM/vHI2F1sPdvPvsOWZk/zHMNJ7xK0QEqo1mgQoF66z+QKgd4X9VJqaIaLX2HCSpsWjHFdNpMgC7gLM9lq
X-Gm-Message-State: AOJu0YxUE4S8LaXwo4vaKIjoQE5tzOBHoHzbUZ8vS3Em9PNHjukkBFBu
	8pVz6jbeac49obCU/bWjuHi6lZNY/P3cedOvTv4unyz9o9A0TBq9ohoW2G1MU9aG1EoVKy2zRO9
	+0tnaWA==
X-Google-Smtp-Source: AGHT+IGk+EhC3U2BIioYpyPr9wRtO3AHfQiQedV4xROQLpn9O85t3IzOUf7ChXud+nAQFTrEhxl54A==
X-Received: by 2002:a17:906:ac8:b0:a59:d0be:dba4 with SMTP id a640c23a62f3a-a5a2d53aed6mr1317801166b.13.1715733844597;
        Tue, 14 May 2024 17:44:04 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d708sm782924966b.41.2024.05.14.17.44.04
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 17:44:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso84228766b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 17:44:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwgmA6SqAE79kGiDAHV4zVoOzCEHsJzLUelqe9mLky41iEvkwyDTrcbV85g+Q97eLsF27enpqTVkt7G+jLui9XwbXEalWWExCz6rPAQ1yu
X-Received: by 2002:a17:906:a010:b0:a59:a9c0:57e6 with SMTP id
 a640c23a62f3a-a5a2d675dafmr1290775966b.75.1715733843947; Tue, 14 May 2024
 17:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org>
In-Reply-To: <56001.1715726927@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 17:43:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 15:48, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> and can't imagine it affecting a single application

Honestly, that's the reason for not caring.

You have to do actively wrong things for this to matter AT ALL.

So no, we're not making gratuitous changes for stupid reasons.

> I worry that the non-atomicity will one day be used by an attacker.

Blah blah blah. That's a made-up scare tactic if I ever heard one.
It's unworthy of you.

Anybody who does mprotect/mmap/munmap/whatever over multiple
independent memory mappings had better know exactly what mappings they
are touching. Otherwise they are *already* just doing random crap.

In other words: nobody actually does that. Yes, you have people who
first carve out one big area with an mmap(), and then do their own
memory management within that area. But the point is, they are very
much in control and if they do something inconsistent, they absolutely
only have themselves to blame.

And if you have some app that randomly does mprotect etc over multipl
memory mappings that it doesn't know what the f*^% they are, then
there is no saving such a piece of unbelievable garbahe.

So stop the pointless fear-mongering. Linux does the smart thing,
which is to not waste a single cycle on something that cannot possibly
be relevant.

             Linus

