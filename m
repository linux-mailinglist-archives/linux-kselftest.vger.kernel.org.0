Return-Path: <linux-kselftest+bounces-27141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6207A3EF06
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2594169CB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6376200BB2;
	Fri, 21 Feb 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5L59o6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6462AE89;
	Fri, 21 Feb 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127693; cv=none; b=ghrkbbLxiyzAOUEkY38xIu/1DPqkKTKK3+HLgkmbNfjNbUOXHVj0gdv0tcwn0zwZPIDfQRYUslrkM5ZZGgrEAS3t9pwVx3mM4x8iF4uA7wEvTcjzyHq7Scf3Gtl0hZeZ1PhSz4nG81cQx4tWEDL7wvF+30KjNcgRnoM/D7u5cQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127693; c=relaxed/simple;
	bh=C99AYwNTpzaXnAlVKR4VAvbAR0R5QJS4EGZLJiCOB6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRLs397ZIHXiu91bpjXbGW3zOuQJVqsqaQQStXZWJcvUh9orJ3KrxMRx9ruxQNWZfk9IKPOLEfUHMbe7CjHTxVjg9WZwkiXphIYTTdAxQofmYr4xErZQ2TYym3LX3G1PvQMBOA4sobO5TFU3DXp2XcKuCB8R3rR8qhsHzCeOh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5L59o6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1374C4CED6;
	Fri, 21 Feb 2025 08:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127693;
	bh=C99AYwNTpzaXnAlVKR4VAvbAR0R5QJS4EGZLJiCOB6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5L59o6pec+qeXV/DtiEOJFRO9M1Ixv/AB+KSKHF7w59CLZJIIBiv0fh3lygJe1r8
	 u48hsxVsShgj2cl5WTNO9EtjBdtsXFsBjW0yp0gHpf1qB9HNzR3/oG/An+i7vN8nCT
	 WpNymiY2kdCq9FtDvQF+dm6IkFEbYnI/VfiqZSuDE1ekMPk013MA9/0IvPbc6hb2BX
	 mMc+gDoXvYwzH/n6QbuCJk7dqTTO1r7WaFdT7aL9pE9UsakikdXK7tvZWoIlz+fy5J
	 T8pd8aovPXa0cI3e8BrmwmdCChRR6BikHJWQyqKDyQHcSK2f3hHEe9F42ySdREnw2c
	 P/2MKxmEyyEvQ==
Date: Fri, 21 Feb 2025 09:48:08 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: kees@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/sysctl: fix wording of help messages
Message-ID: <jwbsuecaakpeuekxy2p6i4ycklso7rbvh6opv6ezpjcm7sfald@3y7v3e6avw6g>
References: <20250216060151.6155-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216060151.6155-1-bharadwaj.raju777@gmail.com>

On Sun, Feb 16, 2025 at 11:31:50AM +0530, Bharadwaj Raju wrote:
> Fix paramter -> parameter, and recomended ->
> recommended in sysctl.sh's help messages.
> 
> Also correct grammar: "number amount of times
> is recommended" etc -> "the recommended number of
> times".
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 84472b436c07..a8e5736e89a8 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -764,7 +764,7 @@ sysctl_test_0007()
>  	fi
>  
>  	if [ ! -f /proc/cmdline ]; then
> -		echo -e "SKIPPING\nThere is no /proc/cmdline to check for paramter"
> +		echo -e "SKIPPING\nThere is no /proc/cmdline to check for parameter"
>  		return $ksft_skip
>  	fi
I have already taken this

>  
> @@ -884,7 +884,7 @@ usage()
>  	echo "Valid tests: 0001-$MAX_TEST"
>  	echo ""
>  	echo "    all     Runs all tests (default)"
> -	echo "    -t      Run test ID the number amount of times is recommended"
> +	echo "    -t      Run test ID the recommended number of times"
>  	echo "    -w      Watch test ID run until it runs into an error"
>  	echo "    -c      Run test ID once"
>  	echo "    -s      Run test ID x test-count number of times"
> @@ -898,7 +898,7 @@ usage()
>  	echo Example uses:
>  	echo
>  	echo "$TEST_NAME.sh            -- executes all tests"
> -	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
> +	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 the recommended number of times"
>  	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
>  	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
>  	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
> -- 
> 2.48.1
> 

Can you please resend based on sysclt-next

https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next

Best

-- 

Joel Granados

