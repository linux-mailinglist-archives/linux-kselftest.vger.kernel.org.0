Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F805EEAA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 02:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiI2A4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI2A4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 20:56:22 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D78FE668;
        Wed, 28 Sep 2022 17:56:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="90990129"
X-IronPort-AV: E=Sophos;i="5.93,353,1654527600"; 
   d="scan'208";a="90990129"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Sep 2022 09:56:18 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E970CD5026;
        Thu, 29 Sep 2022 09:56:16 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2590610132;
        Thu, 29 Sep 2022 09:56:16 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id EA71A234036D;
        Thu, 29 Sep 2022 09:56:14 +0900 (JST)
Message-ID: <8b921394-e7c4-2c85-da76-0ebd05e6ef07@fujitsu.com>
Date:   Thu, 29 Sep 2022 08:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ksefltests: pidfd: Fix wait_states: Test terminated by
 timeout
Content-Language: en-US
To:     brauner@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>
References: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27170.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27170.003
X-TMASE-Result: 10--10.193700-10.000000
X-TMASE-MatchedRID: PYYU0ZXim+GPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizzvJ+necCyol7ow
        i5z3C6ZAsBAAmnpYMTt751tTDA2z+CYX9xlRB3xlvR08UROkEAfQxDD776KHLzUvQN19brjgj+v
        Rrcokg+XDeCYEpLFeRPMW54P2B2tdD7lLiXNUhrM8o3fwIs8rQUfLPdsHmQbnXtXt17pSeWDi0n
        VT9rWZ+SimJNrMe3aRUUG0x+61aZEqXuKH5Jbj7O9S+n/TuQfm1KDIlODIu+VcvdqWtCoykpGHZ
        85Onc+2J2o10m2bLBJaq/6AkfzLhNHpEovtNFNuEXjPIvKd74BMkOX0UoduuVaSZ4yU9Q2HXpMk
        2W6rZUiRigXI/55G6lX71r5lUalZTX7PJ/OU3vKDGx/OQ1GV8rnUfzScNiR3DWKb6PcVvpiOhzO
        a6g8KrUyblknw4+A9+LphlqyNPyaCBOUNmNaC6JbIkO7qU+b1eoiGkqreB1A=
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


On 01/09/2022 11:10, Li Zhijian wrote:
> 0Day/LKP observed that the kselftest blocks forever since one of the
> pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
> the source, we found that it blocks at:
> ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
>
> wait_states has below testing flow:
>    CHILD                 PARENT
>    ---------------+--------------
> 1 STOP itself
> 2                   WAIT for CHILD STOPPED
> 3                   SIGNAL CHILD to CONT
> 4 CONT
> 5 STOP itself
> 5'                  WAIT for CHILD CONT
> 6                   WAIT for CHILD STOPPED
>
> The problem is that the kernel cannot ensure the order of 5 and 5', once
> 5 goes first, the test will fail.
>
> we can reproduce it by:
> $ while true; do make run_tests -C pidfd; done
>
> Introduce a blocking read in child process to make sure the parent can
> check its WCONTINUED.
>
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> I have almost forgotten this patch since the former version post over 6 months
> ago. This time I just do a rebase and update the comments.
> V3: fixes description and add review tag
> V2: rewrite with pipe to avoid usleep
> ---
>   tools/testing/selftests/pidfd/pidfd_wait.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index 070c1c876df1..c3e2a3041f55 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -95,20 +95,28 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>   		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
>   		.exit_signal = SIGCHLD,
>   	};
> +	int pfd[2];
>   	pid_t pid;
>   	siginfo_t info = {
>   		.si_signo = 0,
>   	};
>   
> +	ASSERT_EQ(pipe(pfd), 0);
>   	pid = sys_clone3(&args);
>   	ASSERT_GE(pid, 0);
>   
>   	if (pid == 0) {
> +		char buf[2];
> +
> +		close(pfd[1]);
>   		kill(getpid(), SIGSTOP);
> +		ASSERT_EQ(read(pfd[0], buf, 1), 1);
> +		close(pfd[0]);
>   		kill(getpid(), SIGSTOP);
>   		exit(EXIT_SUCCESS);
>   	}
>   
> +	close(pfd[0]);
>   	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
>   	ASSERT_EQ(info.si_signo, SIGCHLD);
>   	ASSERT_EQ(info.si_code, CLD_STOPPED);
> @@ -117,6 +125,8 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>   	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
>   
>   	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
> +	ASSERT_EQ(write(pfd[1], "C", 1), 1);
> +	close(pfd[1]);
>   	ASSERT_EQ(info.si_signo, SIGCHLD);
>   	ASSERT_EQ(info.si_code, CLD_CONTINUED);
>   	ASSERT_EQ(info.si_pid, parent_tid);

