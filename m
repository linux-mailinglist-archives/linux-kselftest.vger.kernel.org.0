Return-Path: <linux-kselftest+bounces-14192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8C93BA21
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 03:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E168B1F234D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D46FC2;
	Thu, 25 Jul 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ+709QS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05486112;
	Thu, 25 Jul 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721870925; cv=none; b=iLYjwHZmZYlFUirEGexqVwEfDW4K0TMdb7ULfBsT719k3DTTHxk2wwheObs2sEQq5pcbJbSdbWkWMv/pOFMpQCMbxNyLZArzA85ul8Pn6+QU+fXbsiF0goQ0ewNyMveKUcyTIlJvChptjf78zrB81N15KPXpxcH8msD8zH144BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721870925; c=relaxed/simple;
	bh=fuymtk/uH54RFaRoaVIDqzIeL5WU6DH9CSyoQzP30vs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy+BvyLGTAXgOLyfIppPLsU7kKhj3cYjHjygdT5M1puWHUAHJLwyzksNY4DYComoLlTPAcrBdQdcIHqfmZw3Fm4TW3rMEPlHMEa1Z3T1nLEUEBRdnKyDQMHwDq4cn/YAPmlxkzAqKYdopbmQwcBuoRzEyFbBqyDpi/S9bxUmyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ+709QS; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ca9835db95so254004eaf.3;
        Wed, 24 Jul 2024 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721870923; x=1722475723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJdjH7BKC8iw059AD80TiTL+gGuvVMcoJv9CAun5gGI=;
        b=mQ+709QSpZmK+t1EVH9TM+KRXzio1dJSc6eirhvTuChXFy0T5PZcl10hqZzcH7tqm4
         QWUQSVwxB+Aiczsjxrf5e/7w8zGtdy6DT9BjeavjAzO09HgLpCLu0TLCV0AyHlaRx8C+
         plCy73z2QX/SMIfChWsyS4gIHcs8ubu8ku16gWXNWbOSBD/gYpsjBpA4CKkSIfzU3x2S
         Gz38GUJJtiFtkGArgG8kDx0dVCdT9GK89oXPY7sIapczHT7xI5HpHR+8vLgWztEGYnpF
         3Ssm5jh2MGp6yFRSRJsq1rtKFMUOicgP4I/E1HLmPQEPeFDQsjSqzd6m0dTiMT9HHjct
         rRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721870923; x=1722475723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJdjH7BKC8iw059AD80TiTL+gGuvVMcoJv9CAun5gGI=;
        b=QugXvAXU9l4Qs1wYsR1JJHotffezuu1zrOKKE06jIJ4tmMX+JAvFukHzHIjl2oAHLB
         sOTnfvFqplgT0uspfAD37BAgjne4BK/pMVsf6FcCeikIQ1GHtfPDA7Obdcv2kx8GrjlK
         m0NMgeqixeY8FYfvmbQdiBRXe+Pzy+wzfeJZdruGrcEHu2ZtOzT+ACa5JIpL6/wgFVVX
         WxU90IMHO6HmIfptfIYDFqtuHRpVr8pEZuKB2mVwBatOnAqJtEeooNTh5tRVNQezZA77
         reJQ6mv/mxe1wt6q/jnmwgLcCyykakBDz91F6Yjl7GXpca/8265hJcYR6+Lo2Whqwhna
         T03w==
X-Forwarded-Encrypted: i=1; AJvYcCXOYYXW5L71cH1fNfUDHr02BxPqs2dV3sCGmuim/N7/daPUGgmZJFqdLd1z2KxldcyHMOhromFbZ18JS+3xhZ2auqvwkDSoZCnHTGUQraRG
X-Gm-Message-State: AOJu0YxccqqeCveV1BE2/LeJ5NdezLMSRQUvJPASrzsFigtbjlWo1CQD
	bitofRYe5fJNHpkbp3hMtIFeI+edYmehzIbaDlu019ut3EFTicu443/ZKRG8
X-Google-Smtp-Source: AGHT+IGHdsA8rR4HghNgf/afk3fCglXERcy98PGcp+IEr4iDz68x1TIFl26ZsRltYmwDDPyIBIHR4g==
X-Received: by 2002:a05:6870:9112:b0:254:8ca4:a18f with SMTP id 586e51a60fabf-266cc3d8646mr571272fac.29.1721870922613;
        Wed, 24 Jul 2024 18:28:42 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e0f8fsm189860b3a.38.2024.07.24.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 18:28:42 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 24 Jul 2024 18:28:39 -0700
To: Geliang Tang <geliang@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH bpf-next v1 07/19] selftests/bpf: Fix missing
 ARRAY_SIZE() definition in bench.c
Message-ID: <ZqGqR6KpssXGwbAX@kodidev-ubuntu>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
 <bc4dde77dfcd17a825d8f28f72f3292341966810.1721713597.git.tony.ambardar@gmail.com>
 <948240d0866b93ddc60fe084bca74253c99306ff.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <948240d0866b93ddc60fe084bca74253c99306ff.camel@kernel.org>

On Wed, Jul 24, 2024 at 03:08:31PM +0800, Geliang Tang wrote:
> On Mon, 2024-07-22 at 22:54 -0700, Tony Ambardar wrote:
> > Add a "bpf_util.h" include to avoid the following error seen
> > compiling for
> > mips64el with musl libc:
> > 
> >   bench.c: In function 'find_benchmark':
> >   bench.c:590:25: error: implicit declaration of function
> > 'ARRAY_SIZE' [-Werror=implicit-function-declaration]
> >     590 |         for (i = 0; i < ARRAY_SIZE(benchs); i++) {
> >         |                         ^~~~~~~~~~
> >   cc1: all warnings being treated as errors
> 
> I'm curious why this error doesn't occur on other platforms. ARRAY_SIZE
> is actually defined in linux/kernel.h (tools/include/linux/kernel.h). I
> think you should find out why this file is not included on your
> platform.

The surprising reason is that it compiles on glibc systems by accident, due
to bench.c using get_nprocs() and needing to include <sys/sysinfo.h>. On
musl systems this header defines 'struct sysinfo', but the glibc header
version pulls in <linux/kernel.h> for this struct, which in turn drags in
ARRAY_SIZE and the rest of the kitchen sink. So not very portable...

> > 
> > Fixes: 8e7c2a023ac0 ("selftests/bpf: Add benchmark runner
> > infrastructure")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/bench.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/bench.c
> > b/tools/testing/selftests/bpf/bench.c
> > index 627b74ae041b..90dc3aca32bd 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -10,6 +10,7 @@
> >  #include <sys/sysinfo.h>
> >  #include <signal.h>
> >  #include "bench.h"
> > +#include "bpf_util.h"
> >  #include "testing_helpers.h"
> >  
> >  struct env env = {
> 

