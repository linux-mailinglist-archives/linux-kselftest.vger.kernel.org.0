Return-Path: <linux-kselftest+bounces-160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DED7EC887
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E881F27D49
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D03BB37;
	Wed, 15 Nov 2023 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WFuvjd7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035539FE4
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 16:28:45 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93E8AB
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:28:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso9960939e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700065722; x=1700670522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=WFuvjd7xuhCBhnJzRLvJiaDaDpenV7NQDapH0uL43DQC9r3vDlwdEULAfiYiGV3uRV
         4zYkTYj3R8rBHrJaBvuyP0WGvF3QOoMbfE89C8tp5MMqYjg5AVqD/Um3XbHDugLfRdui
         a2Lb9RNab2KQFGzcx5M6XKshzqUTNvYEVQwAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065722; x=1700670522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=aATEen1S3/IG/ipZuLe1QfLL3h1i+3aVAeQZ5KFJGT5KQUMJhQCsVbL7uokmZTwXVz
         hJkHvJuiG8IcwUXCERiKeJBby6MnYRHYB+3GpNic6O7ChcQ1SXBocmc684a/JKlsXU+f
         U6LW6b9TVcG+WSpyoBQVOIj1n6zBgmWPaTmSerxA2uGFOiXyZ1y/jCThacpncW4QheuG
         gZSGEfL3q0dvOSZ6V+wc26gaxulDnNsB5vw78masZ9dPZsovnSTR1Ob6omguxiiUAZtU
         IYiIOqlOA1ONUe5PHiTJnCdH6yIZbxZUaB/J830KGOemxHbvFAmZr4cjMtIZbrdx/Kiz
         MRIA==
X-Gm-Message-State: AOJu0YzwM0ASRgUK9x8ccayyWG9JSXlTQuWi5v/JtcBBeDPAhecscCuQ
	jhErqb27q7bZdcIqbWj89qXLmuyZ6EhDinAcRlJNpxmp
X-Google-Smtp-Source: AGHT+IFuPULkOrrTsRkmR5lScYWsLxirNjmkqK+3PzbaDwy2C+iO9h50LMu7lwgn+JzaqyXZ28qaeA==
X-Received: by 2002:ac2:54a8:0:b0:503:5cd:998b with SMTP id w8-20020ac254a8000000b0050305cd998bmr8372106lfk.28.1700065721862;
        Wed, 15 Nov 2023 08:28:41 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00507a1df9224sm1677900lfv.289.2023.11.15.08.28.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:28:40 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso93115421fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:12cf:b0:503:3781:ac32 with SMTP id
 p15-20020a05651212cf00b005033781ac32mr12684125lfg.41.1700065720301; Wed, 15
 Nov 2023 08:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-9-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-9-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:28:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iov_iter: Add benchmarking kunit tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
> iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
> and fills them in (similar to a maximal bio struct being set up).

I see *zero* advantage of doing this in the kernel as opposed to doing
this benchmarking in user space.

If you cannot see the performance difference due to some user space
interface costs, then the performance difference doesn't matter.

Yes, some of the cases may be harder to trigger than others.
iov_iter_xarray() isn't as common an op as ubuf/iovec/etc, but that
either means that it doesn't matter enough, or that maybe some more
filesystems could be taught to use it for splice or whatever.

Particularly for something like different versions of memcpy(), this
whole benchmarking would want

 (a) profiles

 (b) be run on many different machines

 (c) be run repeatedly to get some idea of variance

and all of those only get *harder* to do with Kunit tests. In user
space? Just run the damn binary (ok, to get profiles you then have to
make sure you have the proper permission setup to get the kernel
profiles too, but a

   echo 1 > /proc/sys/kernel/perf_event_paranoid

as root will do that for you without you having to then do the actual
profiling run as root)

                Linus

