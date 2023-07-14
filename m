Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7873752F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGNC5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjGNC5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 22:57:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D116198A;
        Thu, 13 Jul 2023 19:56:59 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R2GKR2KRlzLnmC;
        Fri, 14 Jul 2023 10:54:35 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:56:56 +0800
Message-ID: <3d5a0d6c-1dcd-7a0d-1f5c-a38e0e15fd85@huawei.com>
Date:   Fri, 14 Jul 2023 10:56:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net 2/3] selftests: tc: add 'ct' action kconfig dep
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
 <20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230713-tc-selftests-lkft-v1-2-1eb4fd3a96e7@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/7/14 5:16, Matthieu Baerts wrote:
> When looking for something else in LKFT reports [1], I noticed most of
> the tests were skipped because the "teardown stage" did not complete
> successfully.
> 
> Pedro found out this is due to the fact CONFIG_NF_FLOW_TABLE is required
> but not listed in the 'config' file. Adding it to the list fixes the
> issues on LKFT side. CONFIG_NET_ACT_CT is now set to 'm' in the final
> kconfig.
> 
> Fixes: c34b961a2492 ("net/sched: act_ct: Create nf flow table per zone")
> Cc: stable@vger.kernel.org
> Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log [1]
> Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [2]
> Suggested-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>   tools/testing/selftests/tc-testing/config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
> index 6e73b09c20c8..d1ad29040c02 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
>   CONFIG_NF_CONNTRACK_MARK=y
>   CONFIG_NF_CONNTRACK_ZONES=y
>   CONFIG_NF_CONNTRACK_LABELS=y
> +CONFIG_NF_FLOW_TABLE=m
>   CONFIG_NF_NAT=m
>   CONFIG_NETFILTER_XT_TARGET_LOG=m
>   
> 

Tested-by: Zhengchao Shao <shaozhengchao@huawei.com>
