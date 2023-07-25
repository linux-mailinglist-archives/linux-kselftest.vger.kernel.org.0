Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30824761E5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGYQXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGYQXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 12:23:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28F197;
        Tue, 25 Jul 2023 09:23:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 096A16015F;
        Tue, 25 Jul 2023 18:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690302192; bh=a82ds4IhDyA0Ek1BfPDooey1kwHm8FJGh4Iyc8T7Piw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=CFd8/Kg9c48yDeDwWNx8PE/R7IyufDRNAGTOvqokxdxAQPGfwyZbelJRAqH6ChXI5
         uEnQkBQ4Kt5tut7pUYepDHn1mVe92mehCUpcGbLLE22n38z/b432Otuxr1pGLtl/uo
         RWJy+SSb67X1PmgsWDdHNV7GR1UfyqTKSuvfpFvEfColM6ltAN4cv5tk+C0CV4axeg
         N5EsIk5mJXhM6cZvOEW1KNTCWECv8yO6kiegerEZZv5zc1IqDc4AeTz0casUC8MMhr
         OMDE2UJvpXfiFz/269ePNOCT0f+tUXb711W+bEtH4oJhFlKZ33PWTrbk8UbMN2JdR6
         l87hXfMaJEg5g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7DbcnmC5btGb; Tue, 25 Jul 2023 18:23:09 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id D61916016E;
        Tue, 25 Jul 2023 18:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690302189; bh=a82ds4IhDyA0Ek1BfPDooey1kwHm8FJGh4Iyc8T7Piw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=OwyZ3swXzx/Wo3S/0imXB6fP9upCpyQpG85S6QolTZv/XVa85S/DIhSCRSgBJJSeY
         lR1Zneyi0vS9SqB5chnbzPDxIvKr9hoq2g8CDkgr2GXipekrL6fkNX9lJIbk7bC940
         rqr7hQTHb8x2lLyuE/OoyQ6IHb6627DX54w6D6L3a9oHInAXUgbO8GTaiHi+f4D62j
         rTaq3j+qVV9ITXIE62U0TL5/aJeJFPQVQJFm1viQR1wNZ2ZZJHjE3t/1EkWzV/kKWw
         VDthWzDd1S98BBn1QzQZ+OVcHrmsFy6OK/OzP+tOqONQ5c04xBTkkX7FUbsE0oqn/6
         2sHCV0IdJv82g==
Message-ID: <10f4d621-7376-0266-b8e3-1da065c4aac5@alu.unizg.hr>
Date:   Tue, 25 Jul 2023 18:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
To:     Petr Machata <petrm@nvidia.com>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <87mszkjrvc.fsf@nvidia.com>
Content-Language: en-US
In-Reply-To: <87mszkjrvc.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/25/23 10:44, Petr Machata wrote:
> 
> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:
> 
>> Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
>> keyboard, for the test times out and leaves incoherent network stack.
>>
>> Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
>> Cc: Ido Schimmel <idosch@nvidia.com>
>> Cc: netdev@vger.kernel.org
>> ---
>>   tools/testing/selftests/net/forwarding/custom_multipath_hash.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
>> index 56eb83d1a3bd..c7ab883d2515 100755
>> --- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
>> +++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
>> @@ -363,7 +363,7 @@ custom_hash()
>>   	custom_hash_v6
>>   }
>>   
>> -trap cleanup EXIT
>> +trap cleanup INT TERM EXIT
>>   
>>   setup_prepare
>>   setup_wait
> 
> I believe the EXIT trap covers whatever the cause of the exit was, i.e.
> INT and TERM are implicitly covered:
> 
>      $ vim tmp/x.sh
>      $ cat tmp/x.sh
>      foo() { date; }
>      trap foo EXIT
>      read -p Ready.
>      $ bash tmp/x.sh
>      Ready.^CTue Jul 25 10:44:20 AM CEST 2023

Thank you Petr for going to the bottom of this.

This is probably specific to bash. I tried to figure out from the manual,
but it wasn't so precise as direct experiment.

> Also, the interrupt trap seems to prevent the exit actually:
> 
>      $ cat tmp/x.sh
>      foo() { date; }
>      trap foo INT TERM EXIT
>      read -p Ready.
>      [petr@yaviefel ~]$ bash tmp/x.sh
>      Ready.^CTue Jul 25 10:43:35 AM CEST 2023
>      ^CTue Jul 25 10:43:35 AM CEST 2023
>      ^CTue Jul 25 10:43:36 AM CEST 2023
>      ^CTue Jul 25 10:43:36 AM CEST 2023
> 
> (I see the same when I kill -TERM the script.)
> 
> This would call cleanup, which would dismantle the configuration, but
> then would happilly proceed in the script. I might be missing something,
> but I don't see how this can work.

Certainly, an explicit 'exit' from the 'cleanup' function would do.

It is bound to exit in any case, so explicit exit can't hurt. But if 'trap cleanup EXIT'
catches all cases, then my patch set is clearly obsoleted.

I didn't see the logic in EXIT catching SIGINT and SIGTERM when there are explicit
traps, but that's bash issue, not  selftest/net/forwarding issue :-)

I should apologise, but my understanding of the manuals went after the 'ash' semanthics
of the trap.

The manual does say:

       trap [-lp] [[arg] sigspec ...]
              The command arg is to be read and executed when the shell receives signal(s) sigspec.  If arg is absent (and there is a  single  sigspec)  or  -,  each
              specified signal is reset to its original disposition (the value it had upon entrance to the shell).  If arg is the null string the signal specified by
              each sigspec is ignored by the shell and by the commands it invokes.  If arg is not present and -p has been supplied, then the trap commands associated
              with  each  sigspec  are displayed.  If no arguments are supplied or if only -p is given, trap prints the list of commands associated with each signal.
              The -l option causes the shell to print a list of signal names and their corresponding numbers.  Each sigspec is either a signal name defined in  <sig‐
              nal.h>, or a signal number.  Signal names are case insensitive and the SIG prefix is optional.

              If  a  sigspec  is EXIT (0) the command arg is executed on exit from the shell.  If a sigspec is DEBUG, the command arg is executed before every simple
              command, for command, case command, select command, every arithmetic for command, and before the first command executes in a shell function (see  SHELL
              GRAMMAR above).  Refer to the description of the extdebug option to the shopt builtin for details of its effect on the DEBUG trap.  If a sigspec is RE‐
              TURN, the command arg is executed each time a shell function or a script executed with the . or source builtins finishes executing.

              If a sigspec is ERR, the command arg is executed whenever a pipeline (which may consist of a single simple command), a list, or a compound command  re‐
              turns  a non-zero exit status, subject to the following conditions.  The ERR trap is not executed if the failed command is part of the command list im‐
              mediately following a while or until keyword, part of the test in an if statement, part of a command executed in a && or ||  list  except  the  command
              following  the  final && or ||, any command in a pipeline but the last, or if the command's return value is being inverted using !.  These are the same
              conditions obeyed by the errexit (-e) option.

              Signals ignored upon entry to the shell cannot be trapped or reset.  Trapped signals that are not being ignored are reset to their original values in a
              subshell or subshell environment when one is created.  The return status is false if any sigspec is invalid; otherwise trap returns true.

Maybe "If  a  sigspec  is EXIT (0) the command arg is executed on exit from the shell." should
have had less assumptions on what is obvious to the reader?

But from this it wasn't obvious to me that EXIT will catch exit by signals SIGINT and SIGTERM.

Perhaps mostly because of the leftovers after cleanup()?

Still it seems impossible to run two consecutive test runs without an intermediate reboot.
('systemctl restart networking' didn't help on ubuntu 22.04).

It doesn't seem impossible to fix these, but I think you as authors and knowers of the Linux
networking stack will do a better job at it.

Though I seem to benefit from these brainstorming exercises as well :-)

Thanks
Mirsad
