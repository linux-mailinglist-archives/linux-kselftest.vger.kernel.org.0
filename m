Return-Path: <linux-kselftest+bounces-38693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA070B21445
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C6B1A230ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D12E264F;
	Mon, 11 Aug 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVxhaj4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A82E2644;
	Mon, 11 Aug 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936681; cv=none; b=PpBiOdPiYQ31HmEXc/EC1ls4Ytptexmpb+quq8d6jyE1tel+Ewkxe95k6GPwnxQ/qWEOpPDPqUbO/Pl23hoZgjW3Ml8kHmvsvCkrb7592mgZHSi4qz1ExLYYTFNk/p/lsjHazwZjNS6tVKYO6o5FdsVHPu1no9dJmMgzvIhBxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936681; c=relaxed/simple;
	bh=pfFM7kCVQLfzSzFeoDmiTOghqLYskzF6brez7iI/1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltEWBfIvgRrspWoXu83PlmGTEim8S08iJMc6eLiWcpG1psbYJsADw4B2yw7WHMxt/8xCe77wYNWll+wQLiS5NlA8GXy2cvTyahcGlKCHdQiq/p36sCXS5ueSxCZKFnOd7Fu+Dgcb62NXoxXcEtIpb+mvQ4cIjYHXyp6RH334T+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVxhaj4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3E3C4CEF6;
	Mon, 11 Aug 2025 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936681;
	bh=pfFM7kCVQLfzSzFeoDmiTOghqLYskzF6brez7iI/1xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVxhaj4M7kwii4x/TSy57PlIXpPLQJqW7CPSr0In6o7uLtoowc+x3o0cccRCqjDpX
	 7TB9PGb9Rk5/Ky0hF+3TtZuTqCDMjN5DcoXbkRxiqOH1sEFEI0adKs2pz1C2MouNEq
	 U4T0Wu/tJq0Uew/rbVOi3r5s71QXG4MT3FcJfVGHmdA5ChnX8oDQBvSrXv8bevqKPi
	 L1NTBzb1YW7uQHBlEe0JsIk5noDkUF3SFGvAJusfdsBvsTDsYMuQYMzvNNjmO7fwVE
	 Lv+dhKYid6RvXfKoRhVzmYkr6hTFH++JrqjdVsKWVezhvTPVeraftByxz/P9d2Aw/M
	 CluquMiz/+LyA==
Date: Mon, 11 Aug 2025 08:24:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	shuah@kernel.org, sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] selftests/sched_ext: Remove duplicate sched.h
 header
Message-ID: <aJo1aC3s4XwBqbvl@slm.duckdns.org>
References: <20250725090412.2040782-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725090412.2040782-1-jiapeng.chong@linux.alibaba.com>

On Fri, Jul 25, 2025 at 05:04:12PM +0800, Jiapeng Chong wrote:
> ./tools/testing/selftests/sched_ext/hotplug.c: sched.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22941
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to sched_ext/for-6.17-fixes.

Thanks.

-- 
tejun

