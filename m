Return-Path: <linux-kselftest+bounces-22465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901599D671E
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 02:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FD2282D38
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6916D30B;
	Sat, 23 Nov 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mouQgEsd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7B165F01;
	Sat, 23 Nov 2024 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326860; cv=none; b=h7ePpjDT3usfLfFC9gqqFrRh4Q97c4a0wYXnUBrk1Z2sOt+51MmI+dBQzuTPUe0q7SSiLJQZcItgWd3yzBtZN+TEN741gkd5BHjW20HmJxkymx+JFOBlP2s+uzdbM/mqYxRgGTlcGLCi5k+c1kFoCi4w1F+mREcwemQOROp+h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326860; c=relaxed/simple;
	bh=QujWJg/j/KlrXu16O9JlD+ghYNILn4x0FiRi2LhEivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbamgUW/9PBIxeH+0x/5OUXrfLYg9gLur3j2nbLUt+4v2D7UW9jAmECGl1NRLCLKKvnwFC64KpQ+FOOmn3V+33BdZU4QZHwGJVjuMl2EDHbmYmJjmMxxIA+W7L7MJJbwU2Nsc4DG2UkNc3hAgYC2YC1SijO7Z6BdC+Q8zJwhv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mouQgEsd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so2304740a91.1;
        Fri, 22 Nov 2024 17:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732326858; x=1732931658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlpv7zYDhEzSJeSt/GR+Zk814jy10VXiLign7bJf1Gc=;
        b=mouQgEsdLOEbPieFDpx4NOfYUmWSaVbYEzFXtqm4a/przhq8+ugUJE8IyVKfie4Z4S
         8oVVev8GFpZkJe7HYJ800PHjXVtRC8DMMmpxFFcBuEjYpByAZNQ8lFI86MD/YXiAR+qk
         rEJtJ85ehhM0NTnXZHfctSWqlvEVZVjBO991HWrtbyg01HfsEv76JSPUGSr7HaRyzT3M
         7h8dPaf93uxJ2Lml0G2j96gvRsuMlwWPTon3vfyaZyqZ1d702LmVdTUR806fLKbm8T4A
         x6wAIARMNnlGgpG1607blrt2vMfQ/kdNXUf7lsQCtlsr42yOKv2jeHd4Gaw+h4YTc6TA
         6vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732326858; x=1732931658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlpv7zYDhEzSJeSt/GR+Zk814jy10VXiLign7bJf1Gc=;
        b=imLvySdVxso7rcVpJdZZbqtVso9MKcvDAD0rgDyXi4SziQj+OVqBiAR5jw+wErkEU4
         K51mPpXxTDKqLCNe15RDY3nzlzOGpJKswZWtTY8vBmQ7SMk7L7njpt9aR/FohlvY+MEu
         cY811kekx8jQp+6J3jq0rwKFTkNgCh++BlgX9RhASIJpJ1UFZq2Y0QtgdnpUlKyGmiGh
         aVaAwRsbF3M0LW3TLWe+7jPCxpNv/M1+wVDrKLtMHg5J+ZUR89oDt3VNWjPRqqbDQKZj
         SkQwdXlvl8ZoyT7uwPsgxeam0GOdTCjSf3j6exq6kRwEG9Cx13dl963MU+XuCPK8UZ3u
         /6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVEw5r0bvSNEtsfJ/hqEA3DhsgBQilmIwUk7R2I/+zxD1XXzBT0cB2ek8OvZS42lDOR41MA92F0k1sGEjAhZZY7@vger.kernel.org, AJvYcCWAs6bOY9XeCRHE+1JfWcAlsVpQFJjLF2KrmaV2z5I5bVic3dNZfnpCT/YTfUDneY/acdGlpLy+CBUmTQ==@vger.kernel.org, AJvYcCWh02LysYKTeyf2wkntgQ/kUJ7b3aqHyBgMXNLLy0yodoW7qwp7HreOYk/YVS48cawLvt5Hqp3apBr1zpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KqGnQKyB9VL968kKOmKPZCHaWxxXHUGRIQo+61BHeW9woYVB
	T9jcKLCtQNxR2q+q9xP385bwMZq/VkoUHWgJOTkOIQwa3bGd3OEP
X-Gm-Gg: ASbGncsjUgXmEKuDsZx5xnN/J4CgoDumFLHWsovRt4XUCGRKDOwiOwHLzoJTZZvqmA9
	05bRZnY4gAzfFZ74+fOPb5rbq5+E1PC8BkmVw0pPXtKXEku08NIBcwytRG+sGQtWwHe2r8O54Tz
	fUMQ6MHzWs7sGktl5CcWOfCcp5LfhVTLaQUZ85SVkIqpzOmxXKXRdARHsWUY/GqdjeZpdVqPKM1
	hELnduSrKf23KOrtQEb60HJzfCWDOE4TPUgCwF7Q3VwUfFi1y9TIXI=
X-Google-Smtp-Source: AGHT+IEPeMcQjD3hd3aJX0sQ1H72vTVDcJsqpdChjiw1hKxmKK4kX0f8mxvqFpH7A7HvxqaAsVhcbw==
X-Received: by 2002:a17:90b:17c9:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2eb0e234c02mr5833180a91.10.1732326858371;
        Fri, 22 Nov 2024 17:54:18 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d06003csm2298548a91.43.2024.11.22.17.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 17:54:17 -0800 (PST)
Date: Sat, 23 Nov 2024 01:54:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: netdev@vger.kernel.org,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: rds: move include.sh to TEST_FILES
Message-ID: <Z0E1wZ75xGCLvNC7@fedora>
References: <20240927041349.81216-1-liuhangbin@gmail.com>
 <20241122150129.GB18887@dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122150129.GB18887@dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com>

On Fri, Nov 22, 2024 at 03:01:29PM +0000, Maximilian Heyne wrote:
> Hi Hangbin,
> 
> On Fri, Sep 27, 2024 at 12:13:49PM +0800, Hangbin Liu wrote:
> > The include.sh file is generated for inclusion and should not be executable.
> > Otherwise, it will be added to kselftest-list.txt. Additionally, add the
> > executable bit for test.py at the same time to ensure proper functionality.
> > 
> > Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  tools/testing/selftests/net/rds/Makefile | 3 ++-
> >  tools/testing/selftests/net/rds/test.py  | 0
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >  mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py
> > 
> > diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
> > index da9714bc7aad..cf30307a829b 100644
> > --- a/tools/testing/selftests/net/rds/Makefile
> > +++ b/tools/testing/selftests/net/rds/Makefile
> > @@ -4,9 +4,10 @@ all:
> >  	@echo mk_build_dir="$(shell pwd)" > include.sh
> >  
> >  TEST_PROGS := run.sh \
> > -	include.sh \
> >  	test.py
> 
> Should test.py also move down to TEST_FILES? I think run.sh is executing
> test.py anyway but does a couple of sanity checks before, so I think
> this it's not necessary to let the runner execute test.py standalone.

I was not aware of this. Thanks for the report. I will post a fix for this.

Thanks
Hangbin

