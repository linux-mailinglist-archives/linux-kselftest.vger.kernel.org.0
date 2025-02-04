Return-Path: <linux-kselftest+bounces-25682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68198A273EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A08188B6FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E720E305;
	Tue,  4 Feb 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQYuRjk2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD220E002;
	Tue,  4 Feb 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677309; cv=none; b=HgeSyApQ1Fp2qQr3D6bntV1rIm5ma4LgXxacZRUImoiRjhZ4yNvbR/SiSpVcKk938+UZYlznY/T6TFy0M+y9TsPqQfcAIUpUA/Yk1TmQ92JLPc7ZmEEZwsda8j3Po3iqPyFTNPmJz/Oph9DLE3SXr3zxyGrre1yRZyBcKZfwNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677309; c=relaxed/simple;
	bh=bd7dktu3lwota/rkAuZogPvP7RR/w9nKbHqkhwdTIVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcNBx5d8CyGF2cV2D9m4j23VcGTiA3EwTrKbDeRyXn7n55dlejWpx7y+dsTrzCzGy3I/v7EM5eh0fO5gVA+CZe7DihmipwTf4Jkg33wT0WXq5Cg5LM5uqXAgvPh3sksn21ovpIwMmrH1LVSQjTxtKxexu+tmCXrsymDwfqNVJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQYuRjk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73AFC4CEDF;
	Tue,  4 Feb 2025 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677308;
	bh=bd7dktu3lwota/rkAuZogPvP7RR/w9nKbHqkhwdTIVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQYuRjk2BodxaHFV3iv8lnoUrHSHCSFNB6XGuf4rskMVpS9v2de1ySCdeuI/sfA7O
	 rTCuEHGrK75yhJz+aTnA5HkQqOmRUW5CPUMQm3mYZE4tdUHdX+wtREvPq/TcbWe/Vf
	 +wtQud+VKks546Noskygdoixsxi9IZFZWGfL0dok=
Date: Tue, 4 Feb 2025 14:55:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: kpm@linux-foundation.org, shuah@kernel.org, kevin.brodsky@arm.com,
	stable@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH Linux-6.12.y 1/1] selftests/mm: build with -O2
Message-ID: <2025020444-usable-facelift-3d78@gregkh>
References: <20250203233342.51041-1-yifei.l.liu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203233342.51041-1-yifei.l.liu@oracle.com>

On Mon, Feb 03, 2025 at 03:33:42PM -0800, Yifei Liu wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> [ Upstream commit 46036188ea1f5266df23a6149dea0df1c77cd1c7 ]
> 
> The mm kselftests are currently built with no optimisation (-O0).  It's
> unclear why, and besides being obviously suboptimal, this also prevents
> the pkeys tests from working as intended.  Let's build all the tests with
> -O2.
> 
> [kevin.brodsky@arm.com: silence unused-result warnings]
>   Link: https://lkml.kernel.org/r/20250107170110.2819685-1-kevin.brodsky@arm.com
> Link: https://lkml.kernel.org/r/20241209095019.1732120-6-kevin.brodsky@arm.com
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Keith Lucas <keith.lucas@oracle.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 46036188ea1f5266df23a6149dea0df1c77cd1c7)
> [Yifei: This commit also fix the failure of pkey_sighandler_tests_64,
> which is also in linux-6.12.y, thus backport this commit]

You also need to provide a 6.13.y version, right?

Please resend both and we will be glad to queue them up.

thanks,

greg k-h

