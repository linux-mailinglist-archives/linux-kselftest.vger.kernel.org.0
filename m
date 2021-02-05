Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978AF3111EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhBESZb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 13:25:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10323 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhBESYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 13:24:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601da52c0000>; Fri, 05 Feb 2021 12:06:04 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 20:06:02 +0000
Subject: Re: [PATCH] selftests/vm: rename file run_vmtests to run_vmtests.sh
To:     Rong Chen <rong.a.chen@intel.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     kernel test robot <lkp@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210205085507.1479894-1-rong.a.chen@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6796b330-0a53-284e-83ae-7d7abf1f57f2@nvidia.com>
Date:   Fri, 5 Feb 2021 12:06:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205085507.1479894-1-rong.a.chen@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612555564; bh=0pOsfwhCIscPepYzMLvi0jYQRAVGAMRcZnw7cvEOMgY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=GnwJjbl5syOwyrkRNPG0Smt5VZAShyJwJb6aZieqmcysyGg9XCdt4esHAcJIuKzTf
         PIR8k7HWbXm3C6urlJUCbKjwspkAT8SfczopSpGyH7adXeZN0pR2UZA5CsCN8zUtDZ
         M/mxDH3eQ9fSwxkkyywv3A73zFJXVZyHv0CcKPDNwDgsIhox3LB+miCAra9CZ0M3xB
         YNI+zMdTknwInTg8VgiWWGbAneYQbjbPaVCo394NIYA6DJjucgM1ZLRIZKKihET+7E
         yWSpj5C/ZxAARih0cbq9uxFzzhHNpg1dT5VUE5VHEdV6R6tW4K74XU85OqwqzFGhyk
         05KuQjU9NATDQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/5/21 12:55 AM, Rong Chen wrote:
> Commit c2aa8afc36fa has renamed run_vmtests in Makefile,
> but the file still uses the old name.
> 
> The kernel test robot reported the following issue:
> 
>   # selftests: vm: run_vmtests.sh
>   # Warning: file run_vmtests.sh is missing!
>   not ok 1 selftests: vm: run_vmtests.sh
> 

I don't know exactly what is going on here, but there was originally a mistake
on my part in renaming run_vmtests to run_vmtests.sh (I was trying to set
the executable bit, which is not always supported by the patch flow), and that 
caused some churn in Andrews's tree. And so maybe that rename got lost/dropped
along the way.

> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: c2aa8afc36fa (selftests/vm: rename run_vmtests --> run_vmtests.sh)
> Signed-off-by: Rong Chen <rong.a.chen@intel.com>
> ---
>   tools/testing/selftests/vm/{run_vmtests => run_vmtests.sh} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tools/testing/selftests/vm/{run_vmtests => run_vmtests.sh} (100%)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests.sh
> similarity index 100%
> rename from tools/testing/selftests/vm/run_vmtests
> rename to tools/testing/selftests/vm/run_vmtests.sh
> 

So I guess this is OK, given that I see "run_vmtests" in both -next
and main.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
