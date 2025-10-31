Return-Path: <linux-kselftest+bounces-44471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D9C22E98
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 02:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D23AEB13
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA319CD0A;
	Fri, 31 Oct 2025 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjC3aXiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854AF9EC
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875308; cv=none; b=GAApGWyX2DdNbBTdgFQxdVzunojXz6EE80Vc+ad2c7aO8icTv1jUxAaRZfuJ6mWKE0BMlb5HBsaPuXd8XCl0KXJ+NIiCSpExMEbKJaD7NzgjQfM4GpzvH//go9Pgb+RV+cfaxMGj2SvWkJSEXvlnL5ohBIbXzF3BoHU57Ve/ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875308; c=relaxed/simple;
	bh=Du9ZyS2Cbxuruu3547ww7SVm0S6hl9QhWSPLchalFho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr/BetdN0ee1SbGlTOWZIg4pqXhN7KMsMy7oagMUWhjunEcgJRUgUGw6z01atisMpO4jOghsyCNv9sCCKl93meHInrgO8omzOEWchlEx/hv61HMNHjPy/GmKsPI2vOq30Q4ztX6Rs4/nO4EKCHKYL2VQmWo7VWD3ksvYPNNDehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjC3aXiN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a74b13f4f8so717358b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761875307; x=1762480107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvW3x2A1aiKOi9TStaIpbipIp65f9ks4AmwOQj0V3qw=;
        b=DjC3aXiNFKQHdep8PFKrSmRcv6UI+Ji/eZcE+fVIsPMrgCOzHdZqvJkeMHo0DYixJS
         H93zbZ4PGJkQIqmfdlwi9+MzXuntVpS/fk7W6S2grvK/4bU9ZfruZTp22Ep0CsWXve3u
         RJSGFA0Za21qarNqddmAza2vC/b8/zVrxVpvx00mngJydT5aVcHQa8pxZjNrCeib4fS1
         C8/gznESiYX8t3NxdCj5WsRZ1oBXZlord7ksFE1hiqQgY/7nWtwaBMu1eEsAz7GTGU+y
         hCxDjkB8jaGVh5wDP7i3naAwXQsFyhN17sbZke1eUn1si04lURo9rrH8BNUgXIofz/Sq
         d76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875307; x=1762480107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvW3x2A1aiKOi9TStaIpbipIp65f9ks4AmwOQj0V3qw=;
        b=kswJ5zamt8o4TcFAzWxXklknrTgMl+IOk0K4nrANqndDBj100nHSNaliRLkXbQTUxG
         k3+KOZxpXo+8dmR4nk5JCxN7G5Ib3Qy2vSrCuD/92mWNg+kr9swaisGqHW8ETxYPd8NQ
         rN/MSfo64vZPggGfNcL2awXD6mQH5TAn0UOTuPidQG0Au6QCno46MI1E+6+ngckhTAja
         yWChQnj66YPzrs/dKPCjPTLjpRDVmrZQp9s//fR6PGur3OE1+GsioBhtARjdG7TOuUEw
         TnvzQmEFuHqx6hZpMz9X83wBiEFpl3Tw1BMBbCTmEIoTaZ0o47ClNax1wl40u5c9QnCZ
         axVA==
X-Forwarded-Encrypted: i=1; AJvYcCWHyrmedD8+hYKCM17V8/CaJCKK8j6sMQDqth511ukA2NvRqDZUake5PKmPl9dA3PnwzGulnQvFcAEyUUDO5zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCsgu4MqZ2B1vZC6Ut3bBBs2B1uRsvgEVDaCYLadlyEwiv4Mv
	HuXnkH7SdCYFQjqnWjwjYjUSxRZO7OYafeDy1n3bsGMxSN6vfMcoPxdW
X-Gm-Gg: ASbGncuK0FEXxovx0Vm5+DGnK7zP2iltWEyKMUhoRw6FmVI377riCHy0mqBsz98KfpK
	tZe2fgKOjw0DqfH34GJ8bgpN7YHRB9rQ7oJPUvdPqU7BTMl2/Ry6vOLL4o359vGmXYQ232PsL3w
	8As+g67kXPxzoFc6S5F1yqz5MvuIGgKvtmu3Yt3fZ0l1UosHEjwjuybMwCLXdyDVZ5FIGg1IHAt
	2bb+EZDZ6njlbei/GS4GeEnteEeTTXAEGzVHKKAZNB9hgW9jAyOZCGgLTKcEiff/O7JbgsHJAJf
	OVf+AZp5cKD86EYQL1uLGwCxClWiVLLGHEd/DRVUTgMO4MJeTv7CcfpHneJlY02eptlSBRuMIdB
	/P0iX9VOncMdYSPJATRsrKVOjcy56WzBw0YWADXxdQV5El1JV0zl+XfHAKKJS/hU+xWD/xaZkny
	n5TJTa
X-Google-Smtp-Source: AGHT+IFSezywW/GcQJEgVuB0h4ZGuHd0XLMgb06dMPeu74sFNrjvw9oWY8GGl1Cc6cXExGzGLt+bVw==
X-Received: by 2002:a05:6300:2109:b0:347:8414:da90 with SMTP id adf61e73a8af0-348c77e0360mr2343316637.0.1761875306608;
        Thu, 30 Oct 2025 18:48:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm214543b3a.60.2025.10.30.18.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:48:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:48:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <aQQVYU1u3CCyH8lQ@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
 <aQL--I9z19zRJ4vo@fedora>
 <20251030083944.722833ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030083944.722833ac@kernel.org>

On Thu, Oct 30, 2025 at 08:39:44AM -0700, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 06:00:24 +0000 Hangbin Liu wrote:
> > > Hm, my knee-jerk reaction was that we should avoid adding too much ynl
> > > stuff to the kernel at this point. But looking closer it's not that
> > > long.
> > > 
> > > Do I understand correctly, tho, that you're testing _system_ YNL?
> > > Not what's in tree?  
> > 
> > Kind of. With this we can test both the system's YNL and also make sure the
> > YNL interface has no regression.
> 
> Meaning we still test the spec, right?

I just do `make install` in tools/net/ynl. Both the ynl scripts and specs are
installed. So I think the specs are also tested.
> 
> To state the obvious ideally we'd test both the specs and the Python
> tools. Strictly better, and without it adding tests for new Python
> features will be a little annoying for people running the selftest.

Yes

> Maybe the solution is as simple as finding and alias'ing ynl to the
> cli.py ?

I didn't get here. The `ynl` calls pyynl.cli:main, that should be enough.
Do you mean we should find the `cli.py` path and call it like
`$source_code/tools/net/ynl/pyynl/cli.py --spec
$source_code/Documentation/netlink/specs/xxx.yaml ...`?

Thanks
Hangbin

