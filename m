Return-Path: <linux-kselftest+bounces-4045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0E847A8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F81F24EDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C61803A;
	Fri,  2 Feb 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aFG4K6G8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C11803D
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906236; cv=none; b=G82Pnwoqxi70NPa7lmB9LhwGM5dA41ajmsDolbU3VLEPn0ZzLB6CgADptEOfsIzjagxKI0+VbgdMxKV+/bSxnXf4VlZ5tFOELAfBEAvVb1CLLVCbNHSgdhTDBJUov2DhOa55CGRU/neMTT98+le/HvbOswDnej+YpfLeeD4jgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906236; c=relaxed/simple;
	bh=7Mvu1Qvmq1BUG1gJYlb4UcjxOFlgOR8rt+Lqx6uTvnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iJ3um2e06lMU8mWJxrWfgImZg606pz4kplEk3dROzpt7y5yn7rBday5nW2tSFBgmWqWwoZPfza/EGM4WTnZkh1UIpRAuYsMIsL8BMajf33Sjdn1jC+v4+EqYGDSHHG1WmOED5nnZn/zcTqvCEeX9mhiCBYoBWH6Z0xIwtrrubCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aFG4K6G8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso29737981fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706906232; x=1707511032; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=aFG4K6G8LcqNRYTrWhlGHYSgWWcFi+gMBdQJyUy0WDu67HodFz0nNogSSUgLlcJ7nA
         4Z6dQlcbjM5hXGnWMQ/iQG8eHjY2PbGrFQszPvjuBq1V7dnF6aOwHWUsngAER1+Qvq/W
         WENmVedkobibziQAlOo6LPTaQK1KEWQ+RdPyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906232; x=1707511032;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=pd2jqQK+HHkASZ6Lsy4FVTTYmX1Nfaf9NGp5q1xbezpFWowvNfE+D3yEU0Sq1aS09m
         HjQKLE+jxlA7Hrmodws1wOIMg7ZxDaZG1AQ9FmAIte7WuGjUsiMQc2BJrzjl6WCpFpaL
         BF+KGZO1knVWexu9NCnsbabII5dC3EF+z4uaIffztkNHOANjgkmHOKrikZHGjyjRwmHx
         +ntcTES2WCNDJBlfUSi24evobW1iPRy3SOHNUF5lNTaTczDPNvvJB/Jbgp2tAoRdeB6V
         uiKoutKiMr7J3gsz51J5WTTjXmceqnsAe/c9mGL8KQB54kZh5HtLcJbhJ7Cyvf5PeP8/
         qi8A==
X-Gm-Message-State: AOJu0Yy1PlV7+m5kdIVgsAcNQaSy0VT/+YSi2CqvxFUmV4tc46WjqhZt
	qHm6hbxL9Wj5xAuq1ucWmJC6b5S2Rx70mxIO+Dnd3pWnSIVfXW50vNyNaUYOKyKAte0xcAJkUHy
	Vxm1Juw==
X-Google-Smtp-Source: AGHT+IHjI03/Nwh852mPY7LCBuZXLXOWSNU6e8FksUMCYhhQhFnVBwOzJ4Qxfp3prtUcadNnASMczQ==
X-Received: by 2002:a2e:a988:0:b0:2d0:8a73:d374 with SMTP id x8-20020a2ea988000000b002d08a73d374mr1778350ljq.53.1706906232059;
        Fri, 02 Feb 2024 12:37:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuKeiIJNFcHQAkVpEQKDMJ95EcNhwfzNfb83EzF86vgI9owHrY0z49wifYK7q0nSh+V5TnYApNkPmM/xxx/AEkWfoNEM8AsMxzsOBSuFa8
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e81d7000000b002cf5244b08asm378935ljg.83.2024.02.02.12.37.11
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:37:11 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso29737641fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 12:37:11 -0800 (PST)
X-Received: by 2002:a2e:9081:0:b0:2d0:643c:c2aa with SMTP id
 l1-20020a2e9081000000b002d0643cc2aamr2137336ljg.20.1706906231031; Fri, 02 Feb
 2024 12:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
In-Reply-To: <85714.1706902336@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 12:36:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Unix system calls must be atomic.
>
> They either return an error, and that is a promise they made no changes.

That's actually not true, and never has been.

It's a good thing to aim for, but several errors means "some or all
may have been done".

EFAULT (for various system calls), ENOMEM and other errors are all
things that can happen after some of the system call has already been
done, and the rest failed.

There are lots of examples, but to pick one obvious VM example,
something like mlock() may well return an error after the area has
been successfully locked, but then the population of said pages failed
for some reason.

Of course, implementations can differ, and POSIX sometimes has insane
language that is actively incorrect.

Furthermore, the definition of "atomic" is unclear. For example, POSIX
claims that a "write()" system call is one atomic thing for regular
files, and some people think that means that you see all or nothing.
That's simply not true, and you'll see the write progress in various
indirect ways (look at intermediate file size with 'stat', look at
intermediate contents with 'mmap' etc etc).

So I agree that atomicity is something that people should always
*strive* for, but it's not some kind of final truth or absolute
requirement.

In the specific case of mseal(), I suspect there are very few reasons
ever *not* to be atomic, so in this particular context atomicity is
likely always something that should be guaranteed. But I just wanted
to point out that it's most definitely not a black-and-white issue in
the general case.

             Linus

