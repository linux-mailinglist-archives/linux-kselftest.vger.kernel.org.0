Return-Path: <linux-kselftest+bounces-14290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A586593DD28
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 05:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D11B22353
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7081FA1;
	Sat, 27 Jul 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu64gUQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9F197;
	Sat, 27 Jul 2024 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722052087; cv=none; b=eAmMdvg88AzFhaQnOOkIQGU3t6L1cbMLZ7wEmJbqh6UjbkCMS1AJibrc5kfwzbL8PoFmXvJRxUNT+V4aLeHOR17OvEjfV5uSev8jLOqvFz7Atr2jgsD99J1hA6infc3UXc6CIRjvdw3a05oL3L3gREZRKZM6H5bSar0WhcWeSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722052087; c=relaxed/simple;
	bh=6tZJ8trUX3kxkP3hyNdbVibiQHgkfVShNelwnL/tvl0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlsZF3DrhCrpscaYJPguCDnhBszPZ0vLINGLKs29gxB51YhceuoZ2bM9jNigWswGOwTHRWl30+qxLYHAXbf94fU399fnz0tRc7G9LIt7us4PbFfx22gfSyzPtTFSVySUIZhmQoEIxoPLFMfX8dpoUbthPZ8Q540gcF0B/VqqVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu64gUQQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70b2421471aso1090056a12.0;
        Fri, 26 Jul 2024 20:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722052085; x=1722656885; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Na2f54Fshfejc1GiyIkCh8yZjzirAGqjnUIQPdgXC/8=;
        b=mu64gUQQPNz7qNKgi1lAJDN2Zg5yg+cP6ih/AJNOdmen6buZ3jP4l2AlCQT7gs0sDb
         zk25XY9tlywRJMetZx3mQErdNpf9m916uAjgSaoRjCc+cuT0tfU7eXmt87zsFKE4VzYu
         GWqdr+LtB01iTEFZxw0qRTEu+U87E4METH12226BDs0TrvuBQoJsZ+yaGinnN5Vg9x8a
         z3vU6kTnwgkewNfhUFJA+vmkJlcMR8Wlqpodpi9LRCsKtvZwZ0GS5V9cF/JIRa5xQhcA
         38MzN9MUn8473Kcc8lqD64Zz6wDES15WjSlx5toUghnm4msAUwfkr93nflUZYjAiDk0I
         Vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722052085; x=1722656885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na2f54Fshfejc1GiyIkCh8yZjzirAGqjnUIQPdgXC/8=;
        b=rJ0GNrw9JLpynDlWVdZcgsL0RyYmwv+o5hEwW6e9yRnggw46iPeD764WK51eRnmwZR
         WbD3I6Bgrr9KNdA5XaQZES0wXeHMOe5/pLlbpzU7/7yvuLlgYtWDO3wfbtiVrMz2A5Ju
         TJyLIa7POzQ7oKcx0WecLJzzdi0lv3s9mU0fpnQqZzDE3ONfj84LaJkYM2ELgwwkQvO1
         dQFsJYmC2loayHcsNVMclmlyGUNpnFWOQ+doJRjt4grJ3ZRQCVNLd/1hCQork9oYc3A3
         XvpCW4zUQ0aTwSoFXjgS2yKtrbaWEaqRFQrKEsejwRM22BcaIuxHVSufaozPsRH5HQ2O
         v+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUy8phrpZDILOGJ+1vRh3LKp7CMGxnMXheg1LnfAy91k+BMCcE5/vqvVn+KRCOziU3izqHaIf1J5OeOaGECa5ePqk6j9rqh8USyiVAws8WEoap6c5V7nNk7J+Eaj+sXLGXl09kqK4N0
X-Gm-Message-State: AOJu0Yw+CdkxZT1KgnPMjqs4YHJEhAvMTWYr2sHpq30o4WMOnTjcUQQc
	d1Qs1CALp69u7UQdmtQAhm1ZYhlDlGBrHpSf4zyxYC0cpPidtGJm
X-Google-Smtp-Source: AGHT+IERlY5auygYdVq3h7iUGB2mNzGGCR4dHsvHEcSjSpGZ7jN8iwg0mst6I8sKUb0SPouR5h9HSg==
X-Received: by 2002:a17:902:da89:b0:1ff:4b1:dfe1 with SMTP id d9443c01a7336-1ff04b1e02amr16781545ad.7.1722052085346;
        Fri, 26 Jul 2024 20:48:05 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee6a1esm40820285ad.164.2024.07.26.20.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 20:48:04 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 26 Jul 2024 20:48:02 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: Fix compile if backtrace
 support missing in libc
Message-ID: <ZqRt8jdbWj6oQHov@kodidev-ubuntu>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
 <472c94bd42cda20154a26ef384b73488abf026c0.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4Bza_y15T4gU=Kiu2d+RbWpxEzrLe6T71bCpK383xHD8JMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza_y15T4gU=Kiu2d+RbWpxEzrLe6T71bCpK383xHD8JMg@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:22:37PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 3:39 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Use backtrace functions only with glibc and otherwise provide stubs in
> > test_progs.c. This avoids compile errors (e.g. with musl libc) like:
> >
> >   test_progs.c:13:10: fatal error: execinfo.h: No such file or directory
> >      13 | #include <execinfo.h> /* backtrace */
> >         |          ^~~~~~~~~~~~
> >   test_progs.c: In function 'crash_handler':
> >   test_progs.c:1034:14: error: implicit declaration of function 'backtrace' [-Werror=implicit-function-declaration]
> >    1034 |         sz = backtrace(bt, ARRAY_SIZE(bt));
> >         |              ^~~~~~~~~
> >   test_progs.c:1045:9: error: implicit declaration of function 'backtrace_symbols_fd' [-Werror=implicit-function-declaration]
> >    1045 |         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
> >         |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Fixes: 9fb156bb82a3 ("selftests/bpf: Print backtrace on SIGSEGV in test_progs")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 60c5ec0f6abf..f6cfc6a8e8f0 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -10,7 +10,6 @@
> >  #include <sched.h>
> >  #include <signal.h>
> >  #include <string.h>
> > -#include <execinfo.h> /* backtrace */
> >  #include <sys/sysinfo.h> /* get_nprocs */
> >  #include <netinet/in.h>
> >  #include <sys/select.h>
> > @@ -19,6 +18,14 @@
> >  #include <bpf/btf.h>
> >  #include "json_writer.h"
> >
> > +#ifdef __GLIBC__
> > +#include <execinfo.h> /* backtrace */
> > +#else
> > +#define backtrace(...) (0)
> > +#define backtrace_symbols_fd(bt, sz, fd) \
> > +       dprintf(fd, "<backtrace not supported>\n", bt, sz)
> > +#endif
> 
> First, let's define backtrace() and backtrace_symbols_fd() as proper
> functions, not a macro?
> 
> And second, what if we then make those functions __weak, so they
> provide default implementations if libc doesn't provide those
> functions?
> 
> This parts seems unavoidable, though:
> 
> #ifdef __GLIBC__
> #include <execinfo.h>
> #endif
> 

I agree that would be cleaner, will work on a v2 with this.

Out of curiosity, I saw that tools/build includes feature-detection code
(incl backtrace) and wondered if selftests/bpf ever used this facility?
> 
> > +
> >  static bool verbose(void)
> >  {
> >         return env.verbosity > VERBOSE_NONE;
> > --
> > 2.34.1
> >

