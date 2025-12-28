Return-Path: <linux-kselftest+bounces-47985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B16CE5803
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 23:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C118C3004215
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 22:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A1241665;
	Sun, 28 Dec 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LUZQqD51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1361D6195;
	Sun, 28 Dec 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766961263; cv=none; b=Qiuv8s36u4OanQCEeJFhFEq6JgNs6udTQfQYI+z81HdA3WxiI549AIRQ5ZEmOGmSscw3ausN2xTdUJM7OelieLWuN12+2NNpyeIf1ECxLyvQy4WaiUsDzKS3v5E05VAO8pxZtG59F6XZxAig33+MGJOoP+jZWgqyHWc5MTWNYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766961263; c=relaxed/simple;
	bh=LZXMDMNv8pBu98GkZ+il6voq9dN/ISkZctYncbOCUm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8A//ZpQoObAZCrOsNdMldk5Aa75gbOvf5bshJDvwWqakYedMRcY4Ivx9BaTfHQijyVDGRB4t+r/QEDEi3PxrpZ4kyZPQiYoTyJIJPVfCW4FPPdNhjCGQ5aJpvsiVbonf3KR2119iAGALxdjohe0sfubj1YQSDyvJTDq1M8xtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LUZQqD51; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=q766VTQ/0S2/xS6aZ/x3pEMsq4x9rm6/tOZmr5RZdF4=; b=LUZQqD510zKN1miO61GphQ2Mvq
	e5HtPTSf9ylzZspjVR1lE5BTB3snuBYhyFKV80GMlLuYcIVPkTo668OANP0ea8eAuO7dKEjvwNxD0
	YGolUdLgP96oQ2C0UoN0ZuMCpuf7mq+lbkvaOmpctyYlEI4IJKfIVJ2P2OdGjQ/xm3QwploDEqcX6
	/2PIf+F6boZ2LPK5xdOzauOP49a+WWa4oODCwlIeEomqpSXAvAZ89S5Y9KOeS3xvFOF3NTcPuo24D
	+dVdxiZvEYmw/Yhpw2yLZ+3ieO7U9RK9hov80VAHkGjQMXoTG25G6vp/rAa6lLBs4366gpMwSqzbc
	DYR/F/OA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZzL3-0000000346Q-1EUw;
	Sun, 28 Dec 2025 22:34:13 +0000
Message-ID: <24f4df13-0875-49bd-95d1-4bf1a400ff15@infradead.org>
Date: Sun, 28 Dec 2025 14:34:12 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] rcutorture: Prevent concurrent kvm.sh runs on
 same source tree
To: Joel Fernandes <joelagnelf@nvidia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251228220519.150179-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251228220519.150179-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/28/25 2:05 PM, Joel Fernandes wrote:
> Add flock-based locking to kvm.sh to prevent multiple instances from
> running concurrently on the same source tree. This prevents build
> failures caused by one instance's "make clean" deleting generated files
> while another instance is building causing build failures.
> 
> The lock file is placed in the rcutorture directory and added to
> .gitignore.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  tools/testing/selftests/rcutorture/.gitignore |  1 +
>  tools/testing/selftests/rcutorture/bin/kvm.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/.gitignore b/tools/testing/selftests/rcutorture/.gitignore
> index f6cbce77460b..b8fd42547a6e 100644
> --- a/tools/testing/selftests/rcutorture/.gitignore
> +++ b/tools/testing/selftests/rcutorture/.gitignore
> @@ -3,3 +3,4 @@ initrd
>  b[0-9]*
>  res
>  *.swp
> +.kvm.sh.lock
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index fff15821c44c..d1fbd092e22a 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -275,6 +275,23 @@ do
>  	shift
>  done
>  
> +# Prevent concurrent kvm.sh runs on the same source tree.  The flock
> +# is automatically released when the script exits, even if killed.
> +TORTURE_LOCK="$RCUTORTURE/.kvm.sh.lock"
> +if test -z "$dryrun"
> +then
> +	# Create a file descriptor and flock it, so that when kvm.sh (and its
> +	# children) exit, the flock is released by the kernel automatically.
> +	exec 9>"$TORTURE_LOCK"
> +	if ! flock -n 9
> +	then
> +		echo "ERROR: Another kvm.sh instance is already running on this tree."
> +		echo "       Lock file: $TORTURE_LOCK"
> +		echo "       To run kvm.sh, kill all existing kvm.sh runs first."
> +		exit 1
> +	fi
> +fi
> +
>  if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
>  then
>  	:
> 
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> prerequisite-patch-id: 912adecf969d167ddd35b26844249c809a2d4664
> prerequisite-patch-id: 95ca224b0870cebb545ddaf313691fd18dfd04e1
> prerequisite-patch-id: 68a218b9aaada53aa85cf33fcf4afe1592fe160f
> prerequisite-patch-id: e40912ee9655a8abef17413a1bb9b05d2d4520de
> prerequisite-patch-id: c0511755626728abcbed2f76e9a0b1d2f15e7c9e
> prerequisite-patch-id: 0a8814cf3965ce3d5fb30d18db3daf2b96c3db74
> prerequisite-patch-id: 450827b1f88e4ab714a63a24a66bd209f8c332af

Are all 54K of these required?

-- 
~Randy


