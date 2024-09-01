Return-Path: <linux-kselftest+bounces-16900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951C96752A
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39251C20F63
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701D3987B;
	Sun,  1 Sep 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdUGtAVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929682F28;
	Sun,  1 Sep 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170541; cv=none; b=BVlAQsbKNDeJnhOg1g3aASZ8lu/jybBJy8z1BLhdlwcu7orzgE3YQqo7FSWRIK1RjxB38gLGHqCz9qjDeuzjPIXa+f4CExxT6pEz79cEIFau8jbWocgs3w66EwfZeHaur9IPcMP3mhkXbJQKey4nW9Y5fd/LTHmedt+v/axcv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170541; c=relaxed/simple;
	bh=2Z0D2hMIKz3+/vZrOwAIMDJApJ7hBHuotOaT19CLilM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGtl281WipnE4UTdhLp2cgSxX+uH9UvWrhW1rglMsfheUP02zV+e6/T/M6TDe4AqHIaFBexXdIuYDtK4fMBWcxfLm3lYItDa+I9JmH4ekX1DYv7KfFgQD0CZfw6Qgj+phcWfvWKi0IycBkKV03v4XIC+8yODhnXU+I2QK7/NtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdUGtAVf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d873bec4f5so1338538a91.0;
        Sat, 31 Aug 2024 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170540; x=1725775340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmkGIIaRE9TAPobIbJVRqRTRakz3HQxMpBrwuBGlIXI=;
        b=GdUGtAVf8ElNA++LPyXOdSWM2kQV8X2PKx/3liE9qPWI+Gp2SJSk32fn+usV4HMsDJ
         7U7sHiFRc/pKC2GL2t23FRrdBao722jL6anGEAAC7k0Wiosl3/ahqUSm0nfh5LfriOJe
         YiOjTn66/ATQFR+E52ML4wk+ezL7nWYcGDxxJvATtu9fgRjYAG9Vqwjr/EoR9sYmJBb9
         Vp0gkrTJ3hmfe6DqJkbuRLkgRoFbX9XkzRzzpxp5tPDP8+2tvSBqLjuLEWk3RY2+dpB8
         BWV7ZGsbg0bdJ6/mFuq4qVPYEwOuvGT7GMk2JQGc2jyvVW51Oe51d2P26tmb/+zwERU6
         bhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170540; x=1725775340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmkGIIaRE9TAPobIbJVRqRTRakz3HQxMpBrwuBGlIXI=;
        b=kwBKrU8b38uDqaA77rYi1l2b8LCT0PM52DzZjp+ShvvXVWwohkmhee4smonqWoWDVA
         Aw6rMpD/axss/iyv30VAseYDadOODT+YQCKzP/f2JN5EIyMQo/XkKaSfsjAGPXrUJu62
         tCSCZ2OejjM9aq4pX+EHsrYkkQf8ZIOH0XvuL/1qYIbQMj3w97ZdV3ihTxCMMaRq9NXO
         zD6xgWw4M7Hlym62tTTehl2nMe9uztwa2rTyHHrl4zQE0+35n7pA4XWkcjkKNQ8E6381
         /N0gJ33jKSf1yCHeeAkvAT3RjiFzyRRniqepYNNgRSb6kCsaGCdtHuHPbGTT/iwZUZEQ
         3JGA==
X-Forwarded-Encrypted: i=1; AJvYcCVHk8E9qgz1RK3DQ5IOtVn/i1y5yN32qGfx5iX/E2K++XPAD3nOVu3T8JxiwmIwaoEOWFHtAtORLhIrMBor3M2s@vger.kernel.org, AJvYcCVvfT9BWrw5mDhA8C8QntOUxcMRKaCwm+KlYF/HoTA36y444RFgcP22j/chcrrUvo9WQO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuiJfZPnnYbXylikQvrNgaq9ltr9z5nNKW+O8z3nO7T0J+ktNG
	2o2lL5/LNr9w2fyJ0+xxeXD0Q0JrlBb3rT8mJ0EpDApRmHwkcdRF
X-Google-Smtp-Source: AGHT+IEvQTbwEYdF4eaYRWwMX/qUgE6Z/nuh4Fay9uoZL/YrTfdJ3o8vrweqwmNDThmy80wn0v/Mog==
X-Received: by 2002:a17:90a:eb02:b0:2d8:a731:7db0 with SMTP id 98e67ed59e1d1-2d8a7317ed9mr2637640a91.35.1725170539858;
        Sat, 31 Aug 2024 23:02:19 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d38ffff9sm40294a91.39.2024.08.31.23.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:02:19 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:02:17 -0700
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v4 7/8] libbpf: Support creating light skeleton
 of either endianness
Message-ID: <ZtQDaWdoxTodv9BB@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <ed17daaceb6fd12a62c7286958239bb34fc3f55b.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>
 <CAADnVQLXYL66nCYpRrMmeR0c-ANtUW-6d5SoEE76cjPb3rVBTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLXYL66nCYpRrMmeR0c-ANtUW-6d5SoEE76cjPb3rVBTg@mail.gmail.com>

On Fri, Aug 30, 2024 at 06:24:47PM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 30, 2024 at 2:31 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> >
> > for the rest, Alexei, can you please review and give your ack?
> 
> It looks fine.
> All of the additional pr_debug()s look a bit excessive.
> Will take another look at respin.

Thanks for taking a look. My experience is the added pr_debug() were
essential to troubleshooting problems with the loader blobs, and only
provide indexes to embedded data. I'd hate for someone else to debug
without these. I think several of them could be consolidated however,
so let me have a try.

There's another area where I'd appreciate your help. The loader code
includes some inline debug statements, but I wasn't ever able to make
these work or see them in trace logs. Could you share an example of how
to enable these (e.g. for test_progs tests)?

Thanks,
Tony

