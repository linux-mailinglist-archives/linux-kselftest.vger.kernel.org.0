Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7F41B5A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbhI1SHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 14:07:50 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:59192 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhI1SHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 14:07:49 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 14:07:49 EDT
IronPort-SDR: mePWzU6XxdoUSOMA2/Jg70TZhHST4d58hbeNtM052Zs8/Jw3VDqV1RpfE8gQ92f+Bw/9qK/+uf
 xgByXnAzwfEnKvbJKli8N6A7PtNafcxfoAWMdbpzfIhc9F1sKaKUYquBoZfsS2rFF2l0PEx0Cg
 Mr2trBbNvzh/BDjAvLtW0Yrj+eHNJVl1w5yoqGT4Skm/232M4xXpZEjyu5KXOowDeXd63+17SN
 +cyrA9YlpjKPKUj1gQsA6Wlv5xmbhDOST91Aig515viFdB8UeILbdF6Bu8ksA2cuugPZU8RnQS
 o/7QX06ek+wnJmaC/bvPzxy0
X-IronPort-AV: E=Sophos;i="5.85,330,1624348800"; 
   d="scan'208";a="66580246"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 28 Sep 2021 09:58:58 -0800
IronPort-SDR: Rj6wklur1DFVClW8MWEh16FKp27QeSbB/4UgZyZ13z3yEGPvxTkDUw8KEymMjqaBAHaQ4ZD2+i
 6NZkJLRYanpjMoSxT/k4PEsmy6z2Tbd6SrSEQmHJFAT+HRdnWxcNKLK+VH5Zn5LIjz3YR3+KF/
 gyqoFb22du8NW3uEPAeI/1z/vbe79/It4PomUlhtkGFwVe9EsegR0M5rfl1Ym3MmtcWyHWFxXi
 4OzrzUJQzoZiCjIy6mlsFBS3UZElKVyHIT/rr17GhDGtIYWbgOf0iDw0znZM4snXyoiGsKQPZa
 ses=
Date:   Tue, 28 Sep 2021 13:58:54 -0400
From:   "George G. Davis" <george_davis@mentor.com>
To:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: Re: [RFC][PATCH] selftests/vm/transhuge-stress: fix ram size thinko
Message-ID: <20210928175854.GA7313@mam-gdavis-dt>
References: <20210825135843.29052-1-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210825135843.29052-1-george_davis@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 25, 2021 at 09:58:43AM -0400, George G. Davis wrote:
> From: "George G. Davis" <davis.george@siemens.com>
> 
> When executing transhuge-stress with an argument to specify the virtual
> memory size for testing, the ram size is reported as 0, e.g.
> 
> transhuge-stress 384
> thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 0 MiB of ram
> thp-mmap: 0.184 s/loop, 0.957 ms/page,   2090.265 MiB/s  192 succeed,    0 failed
> 
> This appears to be due to a thinko in commit 0085d61fe05e
> ("selftests/vm/transhuge-stress: stress test for memory compaction"),
> where, at a guess, the intent was to base "xyz MiB of ram" on `ram`
> size. Here are results after using `ram` size:
> 
> thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 14 MiB of ram
> 
> Fixes: 0085d61fe05e ("selftests/vm/transhuge-stress: stress test for memory compaction")
> Signed-off-by: George G. Davis <davis.george@siemens.com>
> ---
>  tools/testing/selftests/vm/transhuge-stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
> index fd7f1b4a96f9..5e4c036f6ad3 100644
> --- a/tools/testing/selftests/vm/transhuge-stress.c
> +++ b/tools/testing/selftests/vm/transhuge-stress.c
> @@ -79,7 +79,7 @@ int main(int argc, char **argv)
>  
>  	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
>  	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
> -	      len >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> +	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));

Ping, any comments on this?

For the record, as noted, the value reported for "ram size" appears to
use the wrong variable, `len`, where `ram` should be used instead.

>  
>  	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>  	if (pagemap_fd < 0)
> -- 
> 2.17.1
> 

-- 
Regards,
George
