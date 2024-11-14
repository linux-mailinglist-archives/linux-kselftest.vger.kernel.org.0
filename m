Return-Path: <linux-kselftest+bounces-21994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB79C80EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE702845EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08C1E3DEF;
	Thu, 14 Nov 2024 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYZ/+ino"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112A2A1A4;
	Thu, 14 Nov 2024 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552194; cv=none; b=J1B6R7EZF/1PhcVMxz9DZVdEbMM3U4yP6e3dl746WDbMOWb8jTYYu7c2CERvpCEJhrkWIugmYT/ddzswCkE7b8jLT1XyZvGp+WW6a2DMObmuAlpULubrtEpRdrcw49zxpnwXRNvy536cJb7JDiH5a6C0E6jv6eQxvIoM/bS+lPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552194; c=relaxed/simple;
	bh=21qG8fZZKdIeLtBOBM20y5ukWwvSuBh8tqKKcffLyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoxNgNyXIUu4gJDbaeheOgn2R1EO+ZMLTh3zDA5cfOiunsMLgKvD2AUwda2DS8m3DKIsiNNkDEI6msqQtmKdCR+1AZOIqQhOrwvWyrmHUZ9wtF/rTHtRpBtwlsI26/OWDgcRt6yyX75bd8FjgE/xPQmMp10a3E763MrIQVEuv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYZ/+ino; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADB9C4CEC3;
	Thu, 14 Nov 2024 02:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552193;
	bh=21qG8fZZKdIeLtBOBM20y5ukWwvSuBh8tqKKcffLyDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYZ/+inoQgRI4Y8DdMSMytj4AIpC8pNBFMjK6xood3zTgLsbH03trHTbW+tpSkWN6
	 GMqHMqtfcfsyczxRiXzl8n3M9pQj5GU7NwoGjMVh1P2UKjgLyNZ5lOYRLKFYNtKkS8
	 sm9JCEIDmBDAILKF9qlRNbo14UJv6dc9AvbdfQ63tI2zzae7LrPmLX8ZbxUgHmVw8K
	 lvmPwkuyDDjuxSmc8gtOrEKpWwk5zFJDJfl3K/X2q8W/XJEebbRWUL+z7P3IFjARLB
	 uLmlqjjrpkvE+G2QPWs9N5v8HYvLO6LYDVmpqOvlE2grNwn3FetZTGwM5N7tmv+2Lm
	 4+AIfiDwiY7zg==
Date: Wed, 13 Nov 2024 18:43:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Sam Edwards <cfsworks@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <20241113184312.7a33a83d@kernel.org>
In-Reply-To: <ZzVZoe_N4_h4qWVP@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
	<20241113125152.752778-3-liuhangbin@gmail.com>
	<20241113115612.1717575a@kernel.org>
	<ZzVZoe_N4_h4qWVP@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 02:00:01 +0000 Hangbin Liu wrote:
> > # [+300.25] tempaddr not deleted for 2001:db8::1
> > # [+0.16] tempaddr not deleted for 2003:db8::1
> > # [+0.07] FAIL: mngtmpaddr add/remove incorrect
> > not ok 1 selftests: net: rtnetlink.sh # exit=1  
> 
> Is this tested with patched kernel or unpatched kernel. On my local side I got
> 
> # ./rtnetlink.sh -t kci_test_mngtmpaddr
> PASS: mngtmpaddr add/remove correctly

I believe you that you run the test before sending.
But if it doesn't pass in CI we can't merge this.
Just a shot in the dark but does it also pass without the -t ?

