Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B6C3E590E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhHJL2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 07:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhHJL2I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 07:28:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E5E60C51;
        Tue, 10 Aug 2021 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628594866;
        bh=YD3mk7wVBKr+345hMQBi3IBiMgz7hrlLy6ovY3z2l7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTELFQUPYx5v/4wwaaSZGFLAIyYKIQuZp8UwWzyJ2eEkUUdBsp7j5BL+iX8f47USr
         HIAdWYcKQugtIeOHcBJxTYrcW7DENtDmswzMjuGKzZmG3EpNLEo3WgUkW6b73aE+IF
         ChLULpt/2/QMvBT9ODrH2K9jMKkGiaaNuOdPgoSE=
Date:   Tue, 10 Aug 2021 13:27:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] selftests/damon/debugfs_attrs: Add missing execute
 permission
Message-ID: <YRJisBs9AunccCD4@kroah.com>
References: <20210806004226.47nyd%akpm@linux-foundation.org>
 <20210810112050.22225-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810112050.22225-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 11:20:50AM +0000, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Commit 04edafbc0c07 ("mm/damon: add user space selftests") of
> linux-mm[1] gives no execute permission to 'debugfs_attrs.sh' file.
> This results in a DAMON selftest failure as below:
> 
>     $ make -C tools/testing/selftests/damon run_tests
>     make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
>     TAP version 13
>     1..1
>     # selftests: damon: debugfs_attrs.sh
>     # Warning: file debugfs_attrs.sh is not executable, correct this.
>     not ok 1 selftests: damon: debugfs_attrs.sh
>     make: Leaving directory '/home/sjpark/linux/tools/testing/selftests/damon'
> 
> To solve the problem, this commit adds the execute permission for
> 'debugfs_attrs.sh' file.
> 
> [1] https://github.com/hnaz/linux-mm/commit/04edafbc0c07
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/selftests/damon/debugfs_attrs.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> 
> diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> old mode 100644
> new mode 100755
> -- 
> 2.17.1
> 

Why not fix the tools to execute the file properly as changing the mode
of a file does not work well with all tools that we use (i.e. patch
files.)

thanks,

greg k-h
