Return-Path: <linux-kselftest+bounces-3513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9DD83B892
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 05:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473D828455B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EAA7462;
	Thu, 25 Jan 2024 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLdVv6m9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3B79C1;
	Thu, 25 Jan 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155675; cv=none; b=CK1l/ANJFJm36EdF7AcfrIwwVZroOPgvnolEbX9XxTfFVV2dYyJZ7wrcl1m8yfPde+wIxPvLKj4+Q/Obgwx01tl4nVvfpE86/xSq342vOQoWlefcEHHgJvV0Ps4gtlJkU1iL45lqERkM2iavP9vH22fZfn5cZq/g97HN0nf54Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155675; c=relaxed/simple;
	bh=Es7cVnFmyyp2WH0yfAyMcpOS93Ug95QqPa49QsV/5k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljl88sSuQgKRw/9LiVCziAPHL9LCxDNQnqCwLr3n3ulrwWDNG4yLrl4aAHKK7K0YcTLueZkfF31K+EjIR2uOtICPCMA/yl0ZgEMq+nJSPYbSxKmDUCqXLUuSh6oOB9tp98jU8SZkjUWP/2aNdcdl1UhJ1MOmZnkWPGH0ifm3/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLdVv6m9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290b219a60cso2493448a91.0;
        Wed, 24 Jan 2024 20:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706155673; x=1706760473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rd2E/T+WuRV8cQgDogqYQQMi+5ays4Gr8SHmkslOiXY=;
        b=NLdVv6m98pG8IdaL1w5HNLMBx7y8LjNj202u+a4pWynHMI/AikhkFucTgDiZmhB47u
         eBQqMgHS6dm9bn3K6GipPkqECvAahjU4l0vNttiSh+2h7ss8rbtz2T+fFtu+9NHehMXK
         2XPkm0AxGp4kmLl7FqBuDhLBu1Ts1VKSIS85N9T+3AozzwxeBjW22S9x5mJDWWK6Slz5
         bfiAIKY6LuSX57xDuoI7l3u4WZv6o5IJVzT4WElWiu9MDXfFmHtrxZRKFw3BNoKYCxVC
         sdl27MtsYh+B7qnm7yOeVZ8fQRx7svCyuOtiECVT9/TpQxsh7Psqx97tGbbrSNM4lBhs
         VaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706155673; x=1706760473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd2E/T+WuRV8cQgDogqYQQMi+5ays4Gr8SHmkslOiXY=;
        b=ClpMHUe4WRjOpV97eif3kuvMHDmc4CSVWNPLJHU+Hv6pZ64Snadig5dUrDmZsOClgR
         1zHurOlcokrwlys9btz84vuVwtN5VMiQ3Q8zNcM5yhcc4tL0GgqJn8FUwa4qkcwA7mwN
         WwdIRYG341WXNcCnGWpwr7Dfw4yVlEDs9agaW1t/3jzlz+y5CM+61QYYkm1N9yqUK27P
         vXMAgCn4KKzspmtVCvXuHpwIXrwE8c7EKhiJpDPiCrQJNn+NimierdFsuotbcAYEo/gy
         Sh8OVb3YZ5aOMJE18TOwwjn944skxdqRqScE76Lii13g11A1PkilE0TgrNQHqRwT4j6K
         jSUA==
X-Gm-Message-State: AOJu0YwDthJ++w1IO4HVTTIGg3igYe3gJEKsprj/fil25YFBp3LhVDth
	9vaGOptkYtT5OPgxdnIdsOA3kR2NkrvLtR2/e2pZh1NviFyiQjJf
X-Google-Smtp-Source: AGHT+IFlWXYMtZsp5hhjBLLIKk8wmc/+KabpXPiBz7oHltGGD+cFm8aNbBgxffvEpSDQ2jPvqJ+MzQ==
X-Received: by 2002:a17:90a:c08d:b0:28e:8c09:d09 with SMTP id o13-20020a17090ac08d00b0028e8c090d09mr168682pjs.97.1706155673131;
        Wed, 24 Jan 2024 20:07:53 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090a5b1800b00292675529afsm446576pji.44.2024.01.24.20.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:07:52 -0800 (PST)
Date: Thu, 25 Jan 2024 12:07:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] selftests: Add TEST_INCLUDES directive and
 adjust tests to use it
Message-ID: <ZbHeke4sOAQRTxmm@Laptop-X1>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>

On Wed, Jan 24, 2024 at 12:02:16PM -0500, Benjamin Poirier wrote:
> After commit 25ae948b4478 ("selftests/net: add lib.sh") but before commit
> 2114e83381d3 ("selftests: forwarding: Avoid failures to source
> net/lib.sh"), some net selftests encountered errors when they were being
> exported and run. This was because the new net/lib.sh was not exported
> along with the tests. The errors were crudely avoided by duplicating some
> content between net/lib.sh and net/forwarding/lib.sh in 2114e83381d3.
> 
> In order to restore the sourcing of net/lib.sh from net/forwarding/lib.sh
> and remove the duplicated content, this series introduces a new selftests
> Makefile variable to list extra files to export from other directories and
> makes use of it to avoid reintroducing the errors mentioned above.
> 
> v1:
> * "selftests: Introduce Makefile variable to list shared bash scripts"
> Changed TEST_INCLUDES to take relative paths, like other TEST_* variables.
> Paths are adjusted accordingly in the subsequent patches. (Vladimir Oltean)
> 
> * selftests: bonding: Change script interpreter
>   selftests: forwarding: Remove executable bits from lib.sh
> Removed from this series, submitted separately.
> 
> Since commit 2114e83381d3 ("selftests: forwarding: Avoid failures to source
> net/lib.sh") resolved the test errors, this version of the series is
> focused on removing the duplication that was added in that commit. Directly
> rebasing the series would reintroduce the problems that 2114e83381d3
> avoided before fixing them again. In order to prevent such breakage partway
> through the series, patches are reordered and content changed slightly but
> there is no diff at the end compared with the simple rebasing approach. I
> have dropped most review tags on account of this reordering.
> 
> RFC:
> https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/
> 
> Link: https://lore.kernel.org/netdev/ZXu7dGj7F9Ng8iIX@Laptop-X1/
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

