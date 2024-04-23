Return-Path: <linux-kselftest+bounces-8721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E68AF5E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6807A1F25111
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814813E02B;
	Tue, 23 Apr 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtH+ihZm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E113D88A;
	Tue, 23 Apr 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895068; cv=none; b=KjpU0Oq/4oOP3lM7pcxI9EkiDmsuPDxGmxeNoH/45R2hjtOwrXLdM/5PeqnvGcWmmL4Ux+fuP5ibB6/NB4azivJM6tFaGJa0ftYG4p22cQ/goXxQcDYMfwPArWZeCIe2phcVFwd5oENOyPXHnUwAFHaOPCTTRIzNtgx31t1M89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895068; c=relaxed/simple;
	bh=ukjuO26jgon0wpjky2t60XqXUoz2/Ht6XKoq7YcOQhM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c5J00vk9h0C++Em6KbGIaNWb0KLC+2xXe9hjGdSgwuVGIk9DKSKXVkWP3NngTNWfAERrBVvzz0dz/PtkiPseO3bvrTY68QV/OHhwBjFao7PT70K5YziCXufCPtQ5fSGWCuf4GInxFWX2dJeT575RWx5XLAtltA7tvM6t6IjZrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtH+ihZm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-437b3f256easo29551791cf.0;
        Tue, 23 Apr 2024 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895066; x=1714499866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCq/PCbFgz4O8/YgzTB5xOi6bKv32RP1D/qh+aPHEgQ=;
        b=QtH+ihZmx/geoRnRG2WZl4B8lH/y2tku1ePtK/cWE+RqfsLl4ynPJ0vfRHiLCOjHpg
         91n4mfnbHDChBI6XwQDMlcRhmTQzaKrXEIHd/I9WJSJC+zJlxDI8qsXHqddbNDHRJryD
         13lKGyLUFS9YYknqR3sdjrHnvDtL1TUb3Bmmoz35Aen9Mw4C8H1CsIbCE/xxKuf1vLnz
         asighUw8qaqpQcn2BGz4oIPytgQNB/y/t5zsRpeKPWMm1Hr1COb4mvweYrOw6e6dtrbz
         Xqblt+RvY5ngH53uSYoTWP4sJlJfSDori04wtrhMKHF2aL67poN7/sr5aRwzQr7NLAvG
         8QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895066; x=1714499866;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lCq/PCbFgz4O8/YgzTB5xOi6bKv32RP1D/qh+aPHEgQ=;
        b=lgbraJ0Ge5AcTvRUECk2ogwRVZ+Otdq5VbUZLQ7JPz22ScmJlVSVkAG+xf80idnZhI
         tefVVd0eozvElVaKV0fXuQx2otB5PUOzLHgRmbLG/KGk9yUuW0GgE9vvPb6s13uQR/4N
         ktfpm/nZhUDYygWt8J+v7dkbWsybOKZreOHN/Z8HEZIOXjMKL64uAqrHI9fCvU7krTP3
         ggpLpYungITrLMi1ecqsRI5pw8IUMrLNLtuRgLfE650tCYSLmmZP1MkhnZppGZDDBQdL
         m43evqfBp6U+6DKzNRZ1vG8LNh+Vn1pUIbGtqKD6gsIw81elTu8NHIvNbNVWKvxewgNI
         cTtg==
X-Forwarded-Encrypted: i=1; AJvYcCXbPqKOc/56buMNPMGQfLy75DcpuXeCRQ27gb6JyI0d8YonmECWui7w7vIXaYY6zA97cEM0I8m9ln78QkwAu3Lic19WBGMU88YBZRvOIcDz
X-Gm-Message-State: AOJu0Yz7/px2GKaZd5vlOaFKghEgcGM2FxGqVVFyFomUAyhwMmG51uLA
	iCFZ+0cs4FOUcjL9FsHOV1JSZo22fDTLLjawl5lJ5c9NzAUV5DtPZ1NfeQ==
X-Google-Smtp-Source: AGHT+IFiU8fYAdqThQp32rJsLeYsD7PbA91dCOHnspJFmZeFRqsc4Y3S+fuBk/ZIIA3mntoGDzkmXQ==
X-Received: by 2002:a05:622a:1a9b:b0:439:f37c:18c4 with SMTP id s27-20020a05622a1a9b00b00439f37c18c4mr199988qtc.17.1713895065811;
        Tue, 23 Apr 2024 10:57:45 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id jt56-20020a05622aa03800b00434ec509ce9sm5404545qtb.46.2024.04.23.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:57:45 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:57:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
References: <20240420025237.3309296-1-kuba@kernel.org>
 <662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing with
 a remote system
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > Hi!
> > 
> > Implement support for tests which require access to a remote system /
> > endpoint which can generate traffic.
> > This series concludes the "groundwork" for upstream driver tests.
> > 
> > I wanted to support the three models which came up in discussions:
> >  - SW testing with netdevsim
> >  - "local" testing with two ports on the same system in a loopback
> >  - "remote" testing via SSH
> > so there is a tiny bit of an abstraction which wraps up how "remote"
> > commands are executed. Otherwise hopefully there's nothing surprising.
> > 
> > I'm only adding a ping test. I had a bigger one written but I was
> > worried we'll get into discussing the details of the test itself
> > and how I chose to hack up netdevsim, instead of the test infra...
> > So that test will be a follow up :)
> > 
> > v5:
> >  - fix rand port generation, and wrap it in a helper in case
> >    the random thing proves to be flaky
> >  - reuseaddr
> >  - explicitly select the address family
> > v4: https://lore.kernel.org/all/20240418233844.2762396-1-kuba@kernel.org
> >  - improve coding style of patch 5
> >  - switch from netcat to socat (patch 6)
> >  - support exit_wait for bkg() in context manager
> >  - add require_XYZ() helpers (patch 7)
> >  - increase timeouts a little (1,3 -> 5 sec)
> > v3: https://lore.kernel.org/all/20240417231146.2435572-1-kuba@kernel.org
> >  - first two patches are new
> >  - make Remote::cmd() return Popen() object (patch 3)
> >  - always operate on absolute paths (patch 3)
> >  - last two patches are new
> > v2: https://lore.kernel.org/all/20240416004556.1618804-1-kuba@kernel.org
> >  - rename endpoint -> remote
> >  - use 2001:db8:: v6 prefix
> >  - add a note about persistent SSH connections
> >  - add the kernel config
> > v1: https://lore.kernel.org/all/20240412233705.1066444-1-kuba@kernel.org
> > 
> > Jakub Kicinski (7):
> >   selftests: drv-net: define endpoint structures
> >   selftests: drv-net: factor out parsing of the env
> >   selftests: drv-net: construct environment for running tests which
> >     require an endpoint
> >   selftests: drv-net: add a trivial ping test
> >   selftests: net: support matching cases by name prefix
> >   selftests: drv-net: add a TCP ping test case (and useful helpers)
> >   selftests: drv-net: add require_XYZ() helpers for validating env
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Too late, but 

Tested-by: Willem de Bruijn <willemb@google.com>

I tried this yesterday on a pair of Google cloud instances. In
anticipation of converting some of my tests, like csum to this.

Only possible non-obvious observation is that some kselftests expect
as root, and the ssh remote logic extends that to expecting ssh
root access to the remote host.

Would it make sense to explicitly add sudo for all privileged
operations, to allow for non-root ssh and scp?


