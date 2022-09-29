Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF45EEAA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 02:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiI2Az7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 20:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI2Az6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 20:55:58 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73CFE659;
        Wed, 28 Sep 2022 17:55:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="90990079"
X-IronPort-AV: E=Sophos;i="5.93,353,1654527600"; 
   d="scan'208";a="90990079"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Sep 2022 09:55:51 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E1D9AE0A42;
        Thu, 29 Sep 2022 09:55:49 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 218722545B;
        Thu, 29 Sep 2022 09:55:49 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 48EC611456BD;
        Thu, 29 Sep 2022 09:55:48 +0900 (JST)
Message-ID: <9052fe6c-6a56-8662-2747-9387447d11fa@fujitsu.com>
Date:   Thu, 29 Sep 2022 08:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] selftests: pidfd: Fix compling warnings
Content-Language: en-US
To:     brauner@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27170.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27170.003
X-TMASE-Result: 10--6.994800-10.000000
X-TMASE-MatchedRID: mafpUJSAc1CPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizx4YeSlHZYFonTv
        92h/oRdlEhcTmtHgW4Vr5U7TCgYEcFpgkh9rbl/7A9lly13c/gFr2qJoNIuCjcZygq/CPmroMix
        W3F7hYwl05submuetCbXYdqC9vAOOL/tBTZzO5Q23D7EeeyZCMxjxUZ5vLZHpS7NxD4SLUR3gb4
        cxsdTjEOfOVcxjDhcwAYt5KiTiutm/v0UhTKC9nMRB0bsfrpPIcSqbxBgG0w7MT+6D5YKLzfQWh
        lYlwDx4eUV3BwjD/VTmP1kbg+Hita2DzeJzKjS5VuGRAluFTho0RYKNmLXZErmYcxaiLtZdWeUR
        XS9WGyW77+uoEX6CVwYeaoQaeqG2prxnt+VIMqupajfyGgWYcg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping

On 01/09/2022 11:17, Li Zhijian wrote:
> Fix warnings and enable Wall.
>
> pidfd_wait.c: In function ‘wait_nonblock’:
> pidfd_wait.c:150:13: warning: unused variable ‘status’ [-Wunused-variable]
>    150 |  int pidfd, status = 0;
>        |             ^~~~~~
> ...
> pidfd_test.c: In function ‘child_poll_exec_test’:
> pidfd_test.c:438:1: warning: no return statement in function returning non-void [-Wreturn-type]
>    438 | }
>        | ^
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> v2: fix mistake assignment to pidfd
> ---
>   tools/testing/selftests/pidfd/Makefile     | 2 +-
>   tools/testing/selftests/pidfd/pidfd_test.c | 2 ++
>   tools/testing/selftests/pidfd/pidfd_wait.c | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index f4a2f28f926b..778b6cdc8aed 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS += -g -I../../../../usr/include/ -pthread
> +CFLAGS += -g -I../../../../usr/include/ -pthread -Wall
>   
>   TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
>   	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 9a2d64901d59..d36654265b7a 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -435,6 +435,8 @@ static int child_poll_exec_test(void *args)
>   	 */
>   	while (1)
>   		sleep(1);
> +
> +	return 0;
>   }
>   
>   static void test_pidfd_poll_exec(int use_waitpid)
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index c3e2a3041f55..0dcb8365ddc3 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -148,7 +148,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>   
>   TEST(wait_nonblock)
>   {
> -	int pidfd, status = 0;
> +	int pidfd;
>   	unsigned int flags = 0;
>   	pid_t parent_tid = -1;
>   	struct clone_args args = {

