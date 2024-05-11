Return-Path: <linux-kselftest+bounces-10096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9B8C2FC7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 08:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61C41F2339F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701694E1CB;
	Sat, 11 May 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6A+/yff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E3847A;
	Sat, 11 May 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715407756; cv=none; b=G04Oh+qBwvJ8pQVW3ay8375GptEd0sFgo5UQQxT95+81Q1qVeYOAWYBV4hYnM2z3S65u0iQQKNENNyY7ZWKZjz2sI56rx9UditpCRiebklCPi3/LZ0Pcv2KJAXHbMTNAIdxsKQ514GFmWQ4qr0yOzaaK9USNF1YcPIJ1dzfFIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715407756; c=relaxed/simple;
	bh=4Cw67AAJdkqX2gyzq12KaP3i0akQNIRyP6BdXDvGxLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyvudBVNTq+RCibRTsWXKu+55rKqDZISuGHzg+U1yUnPszsoPbr/bBDBc40v244bYwbbJ9ytFZHtQmQCuVAOM4TVAZ6SaS/ai00bdEa8nLadbU/65ra8c1+HzQ5zCcdqqcmJ+14KSWYlE3h8aecsZ6mDewBlVi1UceHZxV9pyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6A+/yff; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b2b42b5126so2440357a91.3;
        Fri, 10 May 2024 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715407754; x=1716012554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MHW7pEn2GFg162daMmi7jC9NBXHcilw+F/P1PhFFzU=;
        b=F6A+/yffHp/4wLYJFbM822jJWyBqXVi0B7TSPSU8964uBt6eBhCqK5iVr6jx1xEYov
         ceLLPSUJtoNMU7iPaayPLKCSoC8xH+CKA+sEMchjtrZ3CUl6DJjBXoC3J9VinSVx0Bn/
         I+3umDcQTk2XeLxKro/m3AhZkwkYK5nXMULFuC0Wh+rtoZcPwAmGZU5pChoy+moN7QFN
         ilsGArN9v642NQqe5ZkS5YnKM2E9wTHkH13UhK2DZH5B7Vm5kAkfTIV+DEu7SvXMjCfk
         l2uEZvMZTxZXQHNn6ZvvMvky5AxGIWVv2G76xb/hM2TJRNuHrspybFPjEK+co9bU+Zar
         SD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715407754; x=1716012554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MHW7pEn2GFg162daMmi7jC9NBXHcilw+F/P1PhFFzU=;
        b=C6md0tOhWYj8Ju1zThwj4lEFoScDDoXaMRt7O4fGgzKvYMQA6axQTNmRsn2nyibI6A
         OY/lc0b1+4zpxBMMtj0XBJmEPUhj3EU1emymnBv8HO6fN3KmFjkXDiGykvh6gftOUBpz
         A5XVUYqKEsN9qRbvNYwysd/WgdmAw+alKgbmyAQPPjFXqM5aq3VpZwLSQpnjeL66f7R/
         TTjPF+0VfdPIOkNq1baaTwsE2AOGMeWYitM9nw0/DbBaIT1WUPcvKqdP+keFICJzPz/1
         JsdE+vIWEL2rp27WlJVSqvSiF3njjIssxab8JKwoHhWb6SKbVVlcrQlgUwD+tJsSxv1B
         mkLA==
X-Forwarded-Encrypted: i=1; AJvYcCVSSF5lpR7/dzkU/ARf3wrCr5v3GexoNouTBpXZFAqeNgeALkfD54klbZlaHZqJverwBJPCozSJpkeqDYFSHzRPK7HQfWnAF4SsK3jT85C2c34IG+GUTVfp8CbW7qmJrMs+4BQzQxWE
X-Gm-Message-State: AOJu0YwIMXC+pIC5vG5picAF2rweD291sWrWIu/dJGO9D+PUFxu4qOVE
	0L14Io88SNKq47eV/aj2I0ssIeGRY3s1Ah74+JrYtC6lTSeTGu1l
X-Google-Smtp-Source: AGHT+IH5UD/ZuC/NMVFuPPpJdFQeAbDdNkQlZGDQJtmPunI+R1nbjIWne3PH0smEwpQLy4oXIt/bvQ==
X-Received: by 2002:a17:902:eb86:b0:1eb:4a40:c486 with SMTP id d9443c01a7336-1ef43d17f42mr62917825ad.14.1715407754172;
        Fri, 10 May 2024 23:09:14 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137f14sm42125855ad.259.2024.05.10.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 23:09:13 -0700 (PDT)
Date: Sat, 11 May 2024 14:09:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: net: local_termination: annotate
 the expected failures
Message-ID: <Zj8LhK28QvLAEhEq@Laptop-X1>
References: <20240511013236.383368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511013236.383368-1-kuba@kernel.org>

On Fri, May 10, 2024 at 06:32:36PM -0700, Jakub Kicinski wrote:
> Vladimir said when adding this test:
> 
>   The bridge driver fares particularly badly [...] mainly because
>   it does not implement IFF_UNICAST_FLT.
> 
> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
> local_termination.sh").
> 
> We don't want to hide the known gaps, but having a test which
> always fails prevents us from catching regressions. Report
> the cases we know may fail as XFAIL.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: liuhangbin@gmail.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> v2:
>  - remove duplicated log_test_xfail
> v1: https://lore.kernel.org/all/20240509235553.5740-1-kuba@kernel.org/
> ---
>  .../net/forwarding/local_termination.sh       | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

