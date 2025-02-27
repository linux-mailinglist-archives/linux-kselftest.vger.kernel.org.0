Return-Path: <linux-kselftest+bounces-27727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB1A478B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E616E1B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C1226885;
	Thu, 27 Feb 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0SYf27+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144B2222BA;
	Thu, 27 Feb 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647331; cv=none; b=ie2ZpgmzmdvQY6HbF53wiG/Xb9of170zQLGNTVtxXQBUNq6VFDu72WQwUuYzbej+au64IEMRbc7W0249aAAua75OuhVrFxryp3LKlTH6bJfLOD6nk6FnciXEwmjt50Koqr54y0Jmu5/TEZgVpG6vijBhLYOriu3pdMq9BaXtkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647331; c=relaxed/simple;
	bh=JOL+QBSvYEPxGbstJirDhY6SK7GKdJbrZwpNPl+HZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8zf6dkynhTEMZYpq+ULSqX6AseqsQX9J5/yPMnlRASD3lYeHQw3xtaybVg9BmmIY3O2PyC+vvYk21Wreemv/9KOWAzHPNCYijjYvfctRGDILOq0aUzhPHzz/KAy1ZL0OjGCTK5KXWu02RDwQL1wHVbDOq2ZSHNiQ9HTE/wNvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0SYf27+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38779C4CEDD;
	Thu, 27 Feb 2025 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740647330;
	bh=JOL+QBSvYEPxGbstJirDhY6SK7GKdJbrZwpNPl+HZxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0SYf27+idIvmyfRAYY6kViB6BJ2c7mO085i8JKFH9zyWuRonms+/fNmrZfgHrXDR
	 S7izsZnEXpawhnsxVFAcFmev3o9Du/OS0AVMKIjuaYQmkikcRQDVLik82ZP/lZdRz0
	 3zByjM+7W3edgmlQuxgUDnDu9ddNTC5hvygf3Z7cLtIx5QMHjfT7x6C4cQMiAAov8c
	 dIW/SvdGm7KF5ki985K4R11cJpdmkxpqvaWorMxpF8Mv0Py+28p+J+xWB4qmBow1nU
	 PW8UOdOldXWMMX8ZDBtA6mJ/ZYR4AUIeoeRJvmU7BS9eifZbVLNofwpRPjnT0Wt+e9
	 cAqghIOYBuqGQ==
Date: Thu, 27 Feb 2025 10:08:42 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: kees@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH sysctl-next v2] selftests/sysctl: fix wording of help
 messages
Message-ID: <segxcbty2dr7oawsyxytxeo3lwyknfgrunb2glbdcj4fpn6nj2@s3wigyuldgxr>
References: <20250221102151.5593-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221102151.5593-1-bharadwaj.raju777@gmail.com>

On Fri, Feb 21, 2025 at 03:51:49PM +0530, Bharadwaj Raju wrote:
> Fix grammar such as "number amount of times is
> recommended" etc -> "the recommended number of
> times".
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index f6e129a82ffd..db1616857d89 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -857,7 +857,7 @@ list_tests()
>  	echo
>  	echo "TEST_ID x NUM_TEST"
>  	echo "TEST_ID:   Test ID"
> -	echo "NUM_TESTS: Number of recommended times to run the test"
> +	echo "NUM_TESTS: Recommended number of times to run the test"
>  	echo
>  	echo "0001 x $(get_test_count 0001) - tests proc_dointvec_minmax()"
>  	echo "0002 x $(get_test_count 0002) - tests proc_dostring()"
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
> -	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recommended"
> +	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 the recommended number of times"
>  	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
>  	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
>  	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
> -- 
> 2.48.1
> 

pushed this to sysctl-next; thx.

-- 

Joel Granados

