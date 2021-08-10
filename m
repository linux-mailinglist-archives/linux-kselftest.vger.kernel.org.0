Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830E73E7BB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbhHJPHy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 11:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239566AbhHJPHx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 11:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B7F160F02;
        Tue, 10 Aug 2021 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628608050;
        bh=A5PbUmTsXQZBjkC+nNDrH6QQ31IyCLpIpv2s5zp9XCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKTePO4BVdtuE1J3Bfi4pR6TUe4GAyyU5TQmBtWIVdV7JLEAaU35ecGfEu2Zd++O2
         vTfqYPemHvn4DfJjbmz+tapfUi7dkLG4UKxDE3LvS54u7xLy8an8VdKE6aR+ByoW9H
         RHceFtR+KSvwAQgm/8GBi6PVnPea+tPdU7SkU2Mg=
Date:   Tue, 10 Aug 2021 17:07:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] selftests/kselftest/runner/run_one(): Allow running
 non-executable files
Message-ID: <YRKWMOElFHKy8DVp@kroah.com>
References: <20210810140459.23990-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810140459.23990-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 02:04:59PM +0000, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> When running a test program, 'run_one()' checks if the program has the
> execution permission and fails if it doesn't.  However, it's easy to
> mistakenly missing the permission, as some common tools like 'diff'
> don't support the permission change well[1].  Compared to that, making
> mistakes in the test program's path would only rare, as those are
> explicitly listed in 'TEST_PROGS'.  Therefore, it might make more sense
> to resolve the situation on our own and run the program.
> 
> For the reason, this commit makes the test program runner function to
> still print the warning message but run the program after giving the
> execution permission in the case.  To make nothing corrupted, it also
> restores the permission after running it.
> 
> [1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index cc9c846585f0..2eb31e945709 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -65,15 +65,16 @@ run_one()
>  
>  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
> -	if [ ! -x "$TEST" ]; then
> -		echo -n "# Warning: file $TEST is "
> -		if [ ! -e "$TEST" ]; then
> -			echo "missing!"
> -		else
> -			echo "not executable, correct this."
> -		fi
> +	if [ ! -e "$TEST" ]; then
> +		echo "# Warning: file $TEST is missing!"
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
> +		permission_added="false"
> +		if [ ! -x "$TEST" ]; then
> +			echo "# Warning: file $TEST is not executable"
> +			chmod u+x "$TEST"
> +			permission_added="true"

No, why would you change the permission of a test?  What happens if this
is on a read-only filesystem?  You should not be modifying it as it will
end up causing changes when not needed.

thanks,

greg k-h
