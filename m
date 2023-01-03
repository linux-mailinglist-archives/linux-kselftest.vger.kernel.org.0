Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBB65C314
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjACPft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 10:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbjACPfb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 10:35:31 -0500
X-Greylist: delayed 5521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 07:35:29 PST
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01B1055B;
        Tue,  3 Jan 2023 07:35:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DB11E604F0;
        Tue,  3 Jan 2023 16:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672760126; bh=a3P3VZV/vKFzhB5kbODTll7OaZDp12BZ7vE/AQVmr2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=asZBEf7G3vrxL4lSBqG6NhOmGAME85KIYA4Axyx8IVlZmRFBuEtNnNKht42rYrhW9
         5yo9nysV3HuegKdSBA2Ef/f6D6uopsmsJZ8VRbRiSgd7xrOGoqM0LGBPBPSHbHKNVD
         nc/fTuBBlqvrQJURgGPBlasey8SDMXkaD3yb82vOY47kU+PKL41nbWVzAyiaYXJ5sa
         do6v81m8BxaL+yPMHcCsxv476IbTnxkf6Nkbc8MTgEaIntED0B+Y/ADi02zJruT3bu
         spfbFcWcJp475IxOW/rv/rkJudNRlW4eKkgThdGwN1o9uo0g90QjFcC77IxMqlWnUG
         gvnQ1idhRS0uA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uYfpoRNTr7OV; Tue,  3 Jan 2023 16:35:24 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 78FD7604EE;
        Tue,  3 Jan 2023 16:35:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672760124; bh=a3P3VZV/vKFzhB5kbODTll7OaZDp12BZ7vE/AQVmr2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PFp2fP1h9XsrATFGSRTysd5DP4iArHiUdSvnYEuJG6HHoIIv5skv7uEtfUfKGXKJT
         DrkbPS8T33RifxY5Ijk+SDAVSVqV++FXeGC2+/qCZBnz3sWfeMzAOqAkc/dDKMj0xZ
         n8dMcvjux+rLLnCNclPHKsLpMfgPH+JviUrySAIj9aHD2vuw6h8QXCNzhRbcayNGsE
         89YvVYVOszRtwDwb/MNFhyDN+PS8qyo2gS8yu2VEpPW35Gm+f46I81+NZlToWibdCu
         B17c122NvtCourlqawO8Gd67xmIsZE3cGd2GeNP0SL5dmE7C/UUWU62ZCbdA/yEEW6
         Kha6HtjBOY74w==
Message-ID: <11cc1fca-01b3-f83b-eb9e-3ceffd68b6d4@alu.unizg.hr>
Date:   Tue, 3 Jan 2023 16:35:23 +0100
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230103142817.GA19686@breakpoint.cc>
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

On 03. 01. 2023. 15:28, Florian Westphal wrote:
> Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
>> Hi all,
>>
>> The `make kselftest` hangs in netfilter/nft_trans_stress.sh test when testing 6.2.0-rc2
>> (attempted 2 times, waiting half an hour at least):
> 
> This script completes in 49 seconds for me.
> 
>> # selftests: netfilter: nft_trans_stress.sh
>> # PASS: nft add/delete test returned 0
>> # PASS: nft reload test returned 0
>>
>> The test script seems to be stuck in ping flood:
> 
> No, it gets stuck in the sub-test after 'PASS: nft reload test returned 0'
> 
> Can you send me the output of 'bash -x nft_trans_stress.sh'?
> It should tell which command/program isn't making progress.

Hi, Florian!

Well, when ran alone, the script ended successfully:

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter# bash nft_trans_stress.sh
PASS: nft add/delete test returned 0
PASS: nft reload test returned 0
PASS: nft add/delete with nftrace enabled test returned 0
PASS: nft add/delete with nftrace enabled test returned 0
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/netfilter#

There was no stall after "nft reload test" in a standalone superuser run.

Hope this helps.

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

