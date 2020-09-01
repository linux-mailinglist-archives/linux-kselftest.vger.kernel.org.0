Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B47258E5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIAMlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 08:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgIAM3j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 08:29:39 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802FE206FA;
        Tue,  1 Sep 2020 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598963379;
        bh=qQzW+ZmfKF4lyEIhtxGAjHs1qPP1InSUuZuGx3+YfvY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PFaPiSTpVGaRR1zqSPf0yKcc6rxZnECy9ZiON9Cjxw69LEYOUPHTIn4CteMuNteu0
         rs1lteWv8Ocdd3IrI12y08htnVgc9Ycnf5yDbP5JfXvJCgfHysNCVU4AehXtSGtBC/
         gNFczMC/U0x9bxcC+Y/83cpw7RkShpOjPodJvZQA=
Date:   Tue, 1 Sep 2020 14:29:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Anatoly Pugachev <matorola@gmail.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: vm: add fragment CONFIG_GUP_BENCHMARK
In-Reply-To: <20200616122618.GA24819@yogzotot>
Message-ID: <nycvar.YFH.7.76.2009011429210.4671@cbobk.fhfr.pm>
References: <20200616122618.GA24819@yogzotot>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Jun 2020, Anatoly Pugachev wrote:

> When running gup_benchmark test the following output states that
> the config options is missing.
> 
> $ sudo ./gup_benchmark
> open: No such file or directory
> 
> $ sudo strace -e trace=file ./gup_benchmark 2>&1 | tail -3
> openat(AT_FDCWD, "/sys/kernel/debug/gup_benchmark", O_RDWR) = -1 ENOENT
> (No such file or directory)
> open: No such file or directory
> +++ exited with 1 +++
> 
> Fix it by adding config option fragment.
> 
> Fixes: 64c349f4ae78 ("mm: add infrastructure for get_user_pages_fast() benchmarking")
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> CC: Jiri Kosina <trivial@kernel.org>
> CC: Shuah Khan <shuah@kernel.org>
> ---
>  tools/testing/selftests/vm/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
> index 3ba674b64fa9..69dd0d1aa30b 100644
> --- a/tools/testing/selftests/vm/config
> +++ b/tools/testing/selftests/vm/config
> @@ -3,3 +3,4 @@ CONFIG_USERFAULTFD=y
>  CONFIG_TEST_VMALLOC=m
>  CONFIG_DEVICE_PRIVATE=y
>  CONFIG_TEST_HMM=m
> +CONFIG_GUP_BENCHMARK=y

Doesn't seem to be in linux-next as of today, I am picking it up. Thanks,

-- 
Jiri Kosina
SUSE Labs

