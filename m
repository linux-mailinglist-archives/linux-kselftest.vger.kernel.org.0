Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C9752FE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjGNDZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjGNDZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 23:25:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6862113;
        Thu, 13 Jul 2023 20:25:07 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R2Gxv1CljzLnld;
        Fri, 14 Jul 2023 11:22:43 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 11:25:04 +0800
Message-ID: <9c5a138d-e6f1-9085-d1a4-4b30334d2462@huawei.com>
Date:   Fri, 14 Jul 2023 11:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net 3/3] selftests: tc: add ConnTrack procfs kconfig
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Blakey <paulb@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        <mptcp@lists.linux.dev>
CC:     Pedro Tammela <pctammela@mojatatu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
 <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/7/14 5:16, Matthieu Baerts wrote:
> When looking at the TC selftest reports, I noticed one test was failing
> because /proc/net/nf_conntrack was not available.
> 
>    not ok 373 3992 - Add ct action triggering DNAT tuple conflict
>    	Could not match regex pattern. Verify command output:
>    cat: /proc/net/nf_conntrack: No such file or directory
> 
> It is only available if NF_CONNTRACK_PROCFS kconfig is set. So the issue
> can be fixed simply by adding it to the list of required kconfig.
> 
> Fixes: e46905641316 ("tc-testing: add test for ct DNAT tuple collision")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [1]
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>   tools/testing/selftests/tc-testing/config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
> index d1ad29040c02..71706197ba0f 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
>   CONFIG_NF_CONNTRACK_MARK=y
>   CONFIG_NF_CONNTRACK_ZONES=y
>   CONFIG_NF_CONNTRACK_LABELS=y
> +CONFIG_NF_CONNTRACK_PROCFS=y
>   CONFIG_NF_FLOW_TABLE=m
>   CONFIG_NF_NAT=m
>   CONFIG_NETFILTER_XT_TARGET_LOG=m
> 

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>
