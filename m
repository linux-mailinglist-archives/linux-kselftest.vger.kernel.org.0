Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6100454049
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhKQFla (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 00:41:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:43269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhKQFla (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 00:41:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="213916872"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="213916872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:38:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="454529752"
Received: from xinshuob-mobl.ccr.corp.intel.com (HELO [10.167.226.45]) ([10.255.31.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:38:29 -0800
Subject: Re: [PATCH 1/3] selftests/tc-testing: add exit code
To:     shuah@kernel.org, kuba@kernel.org, dcaratti@redhat.com,
        linux-kselftest@vger.kernel.org
Cc:     lizhijian@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com, philip.li@intel.com
References: <20211117053247.29052-1-zhijianx.li@intel.com>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <8201aa59-af0e-cb55-a45c-67e5098d961a@intel.com>
Date:   Wed, 17 Nov 2021 13:38:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117053247.29052-1-zhijianx.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

my bad, it's wrong version


On 17/11/2021 13:32, Li Zhijian wrote:
> Mark the summary result as FAIL to prevent from confusing the selftest
> framework if some of them are failed.
>
> Previously, the selftest framework always treats it as *ok* even though
> some of them are failed actually. That's because the script tdc.sh always
> return 0.
>
>   # All test results:
>   #
>   # 1..97
>   # ok 1 83be - Create FQ-PIE with invalid number of flows
>   # ok 2 8b6e - Create RED with no flags
> [...snip]
>   # ok 6 5f15 - Create RED with flags ECN, harddrop
>   # ok 7 53e8 - Create RED with flags ECN, nodrop
>   # ok 8 d091 - Fail to create RED with only nodrop flag
>   # ok 9 af8e - Create RED with flags ECN, nodrop, harddrop
>   # not ok 10 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>   #       Could not match regex pattern. Verify command output:
>   # qdisc mq 1: root
>   # qdisc fq_codel 0: parent 1:4 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
>   # qdisc fq_codel 0: parent 1:3 limit 10240p flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64
> [...snip]
>   # ok 96 6979 - Change quantum of a strict ETS band
>   # ok 97 9a7d - Change ETS strict band without quantum
>   #
>   #
>   #
>   #
>   ok 1 selftests: tc-testing: tdc.sh <<< summary result
>
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
> ---
>   tools/testing/selftests/tc-testing/tdc.py | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
> index a3e43189d940..29832fce66ac 100755
> --- a/tools/testing/selftests/tc-testing/tdc.py
> +++ b/tools/testing/selftests/tc-testing/tdc.py
> @@ -716,6 +716,7 @@ def set_operation_mode(pm, parser, args, remaining):
>           list_test_cases(alltests)
>           exit(0)
>   
> +    exit_code = 0 # KSFT_PASS
>       if len(alltests):
>           req_plugins = pm.get_required_plugins(alltests)
>           try:
> @@ -724,6 +725,8 @@ def set_operation_mode(pm, parser, args, remaining):
>               print('The following plugins were not found:')
>               print('{}'.format(pde.missing_pg))
>           catresults = test_runner(pm, args, alltests)
> +        if catresults.count_failures() != 0

my bad, it's wrong version, where i missed a ':' at the end.




> +            exit_code = 1 # KSFT_FAIL
>           if args.format == 'none':
>               print('Test results output suppression requested\n')
>           else:
> @@ -748,6 +751,8 @@ def set_operation_mode(pm, parser, args, remaining):
>                           gid=int(os.getenv('SUDO_GID')))
>       else:
>           print('No tests found\n')
> +        exit_code = 4 # KSFT_SKIP
> +    exit(exit_code)
>   
>   def main():
>       """
> @@ -767,8 +772,5 @@ def main():
>   
>       set_operation_mode(pm, parser, args, remaining)
>   
> -    exit(0)
> -
> -
>   if __name__ == "__main__":
>       main()

