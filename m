Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694F65C8CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjACVSX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 16:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjACVR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 16:17:57 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD0CCE;
        Tue,  3 Jan 2023 13:17:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9279B604F0;
        Tue,  3 Jan 2023 22:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672780672; bh=G5V1cU0HYZhDxE9taU2aOMLqHjB6CkikceEOy3RebCU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rM0OCUlrNeWNRKeYoEotzSEJCeD6i4c/wffL2JHXhRp9rSyQ8Khl01pP/BArH2/gY
         qWqH12fdJLiwbgt8EguSm+plRCtw2vt192+/J2X2jZU2GX8eyrQMgrAu68SYWlzGHF
         Nmjcy6FyoCjFpSB+OwqFFIliFTSchpNjupV/664mrdnzZAlBkq8f0WbNA01e47AYI6
         nBQRGE8pKhAeOmHnH5lWwxZOTUc9G1LhaCVN1EQIqOXikrDkqFRA628gmmYxsjjmTm
         ycPWGrgNt7l25Ii3OWDDVlekK6CaE8rulM2g/fflQPDw224wD38MMG+AO4H9QjuqCR
         qRx5WR9wao23A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWxoyVTuGw-N; Tue,  3 Jan 2023 22:17:50 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 2FA9A604EE;
        Tue,  3 Jan 2023 22:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672780670; bh=G5V1cU0HYZhDxE9taU2aOMLqHjB6CkikceEOy3RebCU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JnmnFw+LigC4b6T+8aqKLeTTtswqfEIAaeEpmFE7aPaPL6ZgTaCH3yPbJnK/4oUwQ
         vQFsq6DjjZ8AlfbdiNJr7hIqWRl6CVcX3UE2SOu1DBDkAk3BIJkrJnqb62CDUt4cFV
         RiP/Rh+fAur7zXI6uDJrx8Xj69FRCfDaVVtUksSFuX+6mrRHFj67Uk9biGvY81zdj/
         UmuY0cELg9oaCFSIoTXhwnJ23P4IYwBaPzqc+MP/p3LqHqb2lw4qbokdLTBp16CYMk
         oMjH8r1LqJQLboEX/BbyIO+JnvwSLd/iXcab7M7JSsX3Vc41vAGrtPkWccWSFg+eqx
         RGWFf6nEyqN8w==
Message-ID: <714c3712-a390-ac60-40d4-c759b326e3c5@alu.unizg.hr>
Date:   Tue, 3 Jan 2023 22:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: PROBLEM: Hang in selftests/netfilter/nft_trans_stress.sh
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>
Cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <281b5a5e-4b56-ef6f-9896-49b364924662@alu.unizg.hr>
 <20230103142817.GA19686@breakpoint.cc>
 <11cc1fca-01b3-f83b-eb9e-3ceffd68b6d4@alu.unizg.hr>
 <20230103161101.GB19686@breakpoint.cc>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230103161101.GB19686@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03. 01. 2023. 17:11, Florian Westphal wrote:
> Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
>>> Can you send me the output of 'bash -x nft_trans_stress.sh'?
>>> It should tell which command/program isn't making progress.
>>
>> Hi, Florian!
>>
>> Well, when ran alone, the script ended successfully:
>>
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter# bash nft_trans_stress.sh
>> PASS: nft add/delete test returned 0
>> PASS: nft reload test returned 0
>> PASS: nft add/delete with nftrace enabled test returned 0
>> PASS: nft add/delete with nftrace enabled test returned 0
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter#
>>
>> There was no stall after "nft reload test" in a standalone superuser run.
> 
> Hmm.  Does this patch make it work when running via 'make kselftest'?
> 
> diff --git a/tools/testing/selftests/netfilter/nft_trans_stress.sh b/tools/testing/selftests/netfilter/nft_trans_stress.sh
> --- a/tools/testing/selftests/netfilter/nft_trans_stress.sh
> +++ b/tools/testing/selftests/netfilter/nft_trans_stress.sh
> @@ -10,12 +10,20 @@
>   ksft_skip=4
>   
>   testns=testns-$(mktemp -u "XXXXXXXX")
> +tmp=""
>   
>   tables="foo bar baz quux"
>   global_ret=0
>   eret=0
>   lret=0
>   
> +cleanup() {
> +	ip netns pids "$testns" | xargs kill 2>/dev/null
> +	ip netns del "$testns"
> +
> +	rm -f "$tmp"
> +}
> +
>   check_result()
>   {
>   	local r=$1
> @@ -43,6 +51,7 @@ if [ $? -ne 0 ];then
>   	exit $ksft_skip
>   fi
>   
> +trap cleanup EXIT
>   tmp=$(mktemp)
>   
>   for table in $tables; do
> @@ -139,11 +148,4 @@ done
>   
>   check_result $lret "add/delete with nftrace enabled"
>   
> -pkill -9 ping
> -
> -wait
> -
> -rm -f "$tmp"
> -ip netns del "$testns"
> -
>   exit $global_ret

I've got the following output:

make[2]: Entering directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter'
TAP version 13
1..17
# selftests: netfilter: nft_trans_stress.sh
# PASS: nft add/delete test returned 0
# PASS: nft reload test returned 0
#
not ok 1 selftests: netfilter: nft_trans_stress.sh # TIMEOUT 45 seconds
# selftests: netfilter: nft_fib.sh
# PASS: fib expression did not cause unwanted packet drops

It did not hang, but still did not finish all 4 tests correctly like when ran standalone:

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter# time ./nft_trans_stress.sh
PASS: nft add/delete test returned 0
PASS: nft reload test returned 0
PASS: nft add/delete with nftrace enabled test returned 0
PASS: nft add/delete with nftrace enabled test returned 0

real	1m11.014s
user	0m6.470s
sys	0m20.344s
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter#

I hope we're closer to the solution.

Kind regards,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

