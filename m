Return-Path: <linux-kselftest+bounces-5201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00685E3B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF77C1C21FF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FC839F4;
	Wed, 21 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwQQdrq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A482D8D;
	Wed, 21 Feb 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534154; cv=none; b=VUmgBHzQURccrHId71eG6znzXwFfVWK10a68DKI4zzSZ0ZXThndXxq0Su0O93KBk8Lid4eS4ZTX61bBfZeoCDHL4ge04Affj/G8b+dOQWCAIqhP7ETzOB/3GOh5O86QfiDas6WdZtpYzSco6qCSzUXUQUnliy4sIe3lUo020gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534154; c=relaxed/simple;
	bh=ove3upP5O826eOpG4Bg29PjtxXHxXZjXEOc9l+LtHwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9SR6skVzVVdqV5zm0UGTqyWerVSWbgVt+2c78MQo5iJ8CKmFPhMEBBqBj/owxM4Edl+fCZsEXqxMBAjoa2r+3sr0FYIeSYWiDAJVvXdosiGwAZPDKcHMSn7ZQY2HfoUkV/3nbbuWTUeXdhWCHiou/B5Fkd2NhjERh+aLVPOQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwQQdrq/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so856684766b.3;
        Wed, 21 Feb 2024 08:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708534151; x=1709138951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/6HoAU7BqEYQlQGt88qfMyMbLkXax2QO39kfYNiHW0=;
        b=QwQQdrq/vVITNW78P8xYwZOdGiHgWln1KvHMOybZ23xzF8R3EtCNwaxSGmZtcL3VMc
         oeewQJ32byonNMnnH26LOkXIiySwMwtwp9O8FyAx/ER/LZVL4DC0uYnGN+wJ2MF2/YZi
         5AR/oFjl/v331N55/en98ZgMShypjfNqZlMWUU7szuSLK490Z6EcgqahRfBn0M0LgjGf
         j/F1GmLevgakMra06ptN/4Xr2ahvpCw7S31eovzI+jC3TU7yoaxZ3AiY7Cge3cOhD6Iu
         7i+HXjaFqBRyv2gdVzFDsOmlMU4anPwFg2TeNHD3rCUJW0/eo5Co7IdKLOxT2vtSE3id
         HEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534151; x=1709138951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/6HoAU7BqEYQlQGt88qfMyMbLkXax2QO39kfYNiHW0=;
        b=GJ6qo3+TISsvxXJxGC6UacmkjypTpByGW2CHqYiFzXM2+YuZ5XvkAtEaxGu5Iufv3m
         g63vU39+LPJro1UcGiSTuN+bfQPbPGNL4R2KVRgWsqLxQspzMMRMPb1Uh/vR/XzUXf0s
         RLhKKMFY7mruDSpRSpp5EcTWBHMpZibLKsYShuAARw6ZJfoyz/Q8uaKaVEpOwmFEa+le
         40bZJnUUrpQwlfoCbORq/kDPLJ26NlXDMMvl1tnkXzdu8/0zwv0c5uopynuwDAsZ7Jdj
         Rh8Du2P1XbGx5AK6kXl3SyUwVSglTX74AbYORNDZHPgCWYUmkyCH/rrR2BAtRKdtbDHa
         1QbA==
X-Forwarded-Encrypted: i=1; AJvYcCVxDNi5Fj4pAYMmoyh9+LHRmT1o4JYv9ihyfYbWQ2phMbyuEQ0ZYY1texnGOkOUVez3s8GBC6Ctt1sQuqAdMQZ7FiwuJP8kuIoqNtM+wYEfvtBizdEeVxp03g355ni+azrzKGfxmQQd4NhqKY+pRqTMZVPAKDgcp0ewbvnCkN0DnCtF2VVGmkKvCrkR2cEa0W70CQ5OtsxE9pbmOKNoxeG9M1th
X-Gm-Message-State: AOJu0YxAdaCCcrFMzLfxVC1F9ujKDkaTIWaMkpd1VNlIrvxep4KrkQb4
	aOKXV0Uw+BXXEBnurnY4M06IAGcrKOe16n7zsiQewrJM6VNbveg=
X-Google-Smtp-Source: AGHT+IE57bcXeYkZJP98HXfK2Uv1QXGkv8qaONWD32LAi4oHSbopeSaffA0n85T1hOOupFw1aaMi8Q==
X-Received: by 2002:a17:906:349b:b0:a3e:b5a3:acf6 with SMTP id g27-20020a170906349b00b00a3eb5a3acf6mr5647977ejb.4.1708534151368;
        Wed, 21 Feb 2024 08:49:11 -0800 (PST)
Received: from p183 ([46.53.251.190])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906591700b00a3ef17464b1sm1863338ejq.9.2024.02.21.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:49:10 -0800 (PST)
Date: Wed, 21 Feb 2024 19:49:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/31] NT synchronization primitive driver
Message-ID: <a2f8ee20-2a2b-44bb-8db2-6d2c353d6a6c@p183>
References: <5ae668e3-e275-40b0-af3c-6a459e3a0b87@p183>
 <2024021756-bakeshop-wolf-f975@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024021756-bakeshop-wolf-f975@gregkh>

On Sat, Feb 17, 2024 at 09:01:53AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 16, 2024 at 07:31:12PM +0300, Alexey Dobriyan wrote:
> > > drivers/misc/ntsync.c                         | 1146 ++++++++++++++
> > 
> > Assuming this doesn't go into futex(2) or some other existing code...
> > 
> > Can you start putting all of this into top-level "windows" directory?
> > I suspect there will be more Windows stuff in the future.
> 
> There will?  Like what?

I don't know, native PE loader is probably a must for running Excel natively.

> > So those who don't care about Windows can turn off just one config option
> > (CONFIG_WINDOWS) and be done with it.
> 
> This should all be configured under one option anyway, so I don't see
> the need.

It is handy to have 1 obvious place to nuke some features completely.
Especially for polarising ones like Windows support.

> > Name it "Linux Subsystem for Windows" for 146% better memes.
> 
> Fun with marketing!  :)

If they can "Subsystem for Linux", we can too.

