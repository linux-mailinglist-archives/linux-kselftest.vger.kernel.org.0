Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109A4C3E07
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 06:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiBYFuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 00:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBYFuJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 00:50:09 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D0B458A;
        Thu, 24 Feb 2022 21:49:36 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee37.dynamic.kabel-deutschland.de [95.90.238.55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1675D61EA1939;
        Fri, 25 Feb 2022 06:49:33 +0100 (CET)
Message-ID: <bfab82a0-bf21-7782-f6fb-3adaf827ad25@molgen.mpg.de>
Date:   Fri, 25 Feb 2022 06:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] torture: Make thread detection more robust by using
 lspcu
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220222120718.17141-1-pmenzel@molgen.mpg.de>
 <20220222120718.17141-2-pmenzel@molgen.mpg.de>
 <20220222174328.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <1084da08-f67d-b5d7-add4-580e9246b7b7@molgen.mpg.de>
 <20220224205617.GY4285@paulmck-ThinkPad-P17-Gen-1>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220224205617.GY4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Paul,


Am 24.02.22 um 21:56 schrieb Paul E. McKenney:
> On Thu, Feb 24, 2022 at 09:24:11AM +0100, Paul Menzel wrote:

>> Am 22.02.22 um 18:43 schrieb Paul E. McKenney:
>>> On Tue, Feb 22, 2022 at 01:07:17PM +0100, Paul Menzel wrote:
>>>> For consecutive numbers *lscpu* collapses the output and just shows the
>>>> range with start and end. The processors are numbered that way on POWER8.
>>>>
>>>>       $ sudo ppc64_cpu --smt=8
>>>>       $ lscpu | grep '^NUMA node'
>>>>       NUMA node(s):                    2
>>>>       NUMA node0 CPU(s):               0-79
>>>>       NUMA node8 CPU(s):               80-159
>>>>
>>>> This causes the heuristic to detect the number threads per core, looking
>>>> for the number after the first comma, to fail, and QEMU aborts because of
>>>> invalid arguments.
>>>>
>>>>       $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
>>>>       $
>>>>
>>>> (Before the last patch, the whole line was returned.)
>>>>
>>>>       $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
>>>>       NUMA node0 CPU(s):               0-79
>>>>
>>>> *lscpu* shows the number of threads per core, so use that value directly.
>>>>
>>>>       $ sudo ppc64_cpu --smt=8
>>>>       $ lscpu | grep 'Thread(s) per core'
>>>>       Thread(s) per core:              8
>>>>       $ sudo ppc64_cpu --smt=off
>>>>       $ lscpu | grep 'Thread(s) per core'
>>>>       Thread(s) per core:              1
>>>>
>>>> Note, the replaced heuristic is also incorrect for that case, where the
>>>> threads per core are disabled.
>>>>
>>>>       $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
>>>>       8
>>>>
>>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>
>>> Makes sense, and thank you for chasing this down and for the fix!
>>>
>>> But should this patch and 1/2 be merged?  Or am I confused and they
>>> are somehow affecting two different lines of scripting?
>>
>> You are right. I guess with 1/2 I just wanted to document clearly, what I
>> learned in #sed@irc.libera.chat, that means, how to avoid using grep, when
>> sed is used.
> 
> Nothing wrong with that!
> 
> I have merged the two patches as shown below.  Does this work for you?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9f0daba62e958c31326c7a9eae33651e3a3cc6b4
> Author: Paul Menzel <pmenzel@molgen.mpg.de>
> Date:   Tue Feb 22 13:07:16 2022 +0100
> 
>      torture: Make thread detection more robust by using lspcu
>      
>      For consecutive numbers the lscpu command collapses the output and just
>      shows the range with start and end. The processors are numbered that
>      way on POWER8.
>      
>          $ sudo ppc64_cpu --smt=8
>          $ lscpu | grep '^NUMA node'
>          NUMA node(s):                    2
>          NUMA node0 CPU(s):               0-79
>          NUMA node8 CPU(s):               80-159
>      
>      This causes the heuristic to detect the number threads per core, looking
>      for the number after the first comma, to fail, and QEMU aborts because of
>      invalid arguments.
>      
>          $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
>          NUMA node0 CPU(s):               0-79
>      
>      But the lscpu command shows the number of threads per core:
>      
>          $ sudo ppc64_cpu --smt=8
>          $ lscpu | grep 'Thread(s) per core'
>          Thread(s) per core:              8
>          $ sudo ppc64_cpu --smt=off
>          $ lscpu | grep 'Thread(s) per core'
>          Thread(s) per core:              1
>      
>      This commit therefore directly uses that value.

Maybe extend: …, and replaces `grep` by using using sed’s switch `-n` 
and the command p.

>      
>      Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index c35ba24f994c3..66d0414d8e4bc 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -301,7 +301,7 @@ specify_qemu_cpus () {
>   			echo $2 -smp $3
>   			;;
>   		qemu-system-ppc64)
> -			nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> +			nt="`lscpu | sed -n 's/^Thread(s) per core:\s*//p'`"
>   			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
>   			;;
>   		esac

Thank you for doing that, and sorry for the extra work.


Kind regards,

Paul
