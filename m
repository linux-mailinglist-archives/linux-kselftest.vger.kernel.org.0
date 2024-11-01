Return-Path: <linux-kselftest+bounces-21297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF79B9245
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4CD1C20E1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2116F0F0;
	Fri,  1 Nov 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQG0Fvr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CD2D600;
	Fri,  1 Nov 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468712; cv=none; b=kQ5UGF4mzUGeVIXVBVfUASWjRM+ka/5Q1+qNHryUbaMZno0R6D7+0bVEBVFocZnbBXrbN3CGzwQXCYxjs/frzUAWCN7vb3Zp5fsGFzABhA2NVdNsUgly0jL/hYOyojp4CKbuq/jayACI5Zs1lt79cobZ5YDIlvtQQ+5Z6vZXdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468712; c=relaxed/simple;
	bh=vci9jydUwTZ/may1ziLxV8PAIyMusaHDSrKasyYmULU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsdehs5vUHv+VufQ1T8fC5+7Psu725W7+YhprwjkiwV6EZh9G4agcylWX5Bzqal9NWsDIItPgHRWIfM/aPk5RqOI/iFZ1bSWu6zKANGP1UNVRLJNCMLZcKl6tsAl/Hn97YdiJwOCc+NBnMd5vifZtBwllyDjNxcOz4Yb9SKvwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQG0Fvr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF29C4CECD;
	Fri,  1 Nov 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730468712;
	bh=vci9jydUwTZ/may1ziLxV8PAIyMusaHDSrKasyYmULU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQG0Fvr812IVtksh/oMua+p1jCDLfH+5WMaMXELTJ/RPqOWb7aRZ8/bhuaVBoxLzs
	 lE8v/QR7fxVT3MNl4OtbzjnY9tn6J9iwmHIze4lzRPTiw4d9u8UpS2exciPWX9HOWw
	 zB857Tcp90DUST3/eZm2KjaMCKba8AgF8Y0cpBIj42kB42tcu3Y1etHq8Cq6IXPSOH
	 15Q08KGT9XLO9qlTftXd8eSM642Hu0TmnQbSZ+vQHMxhsavclNDUjz5MCD+nO5W16T
	 /yevLGSr9ci1TO3niI1SxeOK98aJ13XsJYKTyBRNKrJnz+L+IyS3piFQcjOkLdkGD2
	 VjmnES8gFxiNA==
Date: Fri, 1 Nov 2024 06:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 idosch@idosch.org, edumazet@google.com, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH v5] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
Message-ID: <20241101064511.1ef698db@kernel.org>
In-Reply-To: <20241101104922.68956-1-deliran@verdict.gg>
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
	<20241101104922.68956-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 10:48:57 +0000 Vladimir Vdovin wrote:
> +	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"

This new test seems to fail in our CI:

# TEST: ipv4: PMTU multipath nh exceptions                            [FAIL]
#   there are not enough cached exceptions

https://netdev-3.bots.linux.dev/vmksft-net/results/840861/3-pmtu-sh/stdout

Also some process notes:
 - please don't post multiple versions of the patch a day:
   https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
 - please avoid posting new versions in-reply-to the old one
-- 
pw-bot: cr

