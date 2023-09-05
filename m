Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A6792634
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjIEQHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354513AbjIEMKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 08:10:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470361AB;
        Tue,  5 Sep 2023 05:10:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdUsf-0006J5-Ge; Tue, 05 Sep 2023 14:10:05 +0200
Message-ID: <1d79cc64-46d8-42ab-8219-e45e8d19532f@leemhuis.info>
Date:   Tue, 5 Sep 2023 14:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Don't fill the kernel log with memfd_create messages
Content-Language: en-US, de-DE
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <1693408388.rwssx8r1h9.none.ref@localhost>
 <1693408388.rwssx8r1h9.none@localhost>
 <14b4a922-a31a-a329-0264-3d8bd101ee6b@suse.cz>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <14b4a922-a31a-a329-0264-3d8bd101ee6b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693915807;afc559ae;
X-HE-SMSGID: 1qdUsf-0006J5-Ge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 04.09.23 15:31, Vlastimil Babka wrote:
> On 8/30/23 17:52, Alex Xu (Hello71) wrote:
>> Hi all,
>>
>> Recently "memfd: improve userspace warnings for missing exec-related 
>> flags" was merged. On my system, this is a regression, not an 
>> improvement, because the entire 256k kernel log buffer (default on x86) 
>> is filled with these warnings and "__do_sys_memfd_create: 122 callbacks 
>> suppressed". I haven't investigated too closely, but the most likely 
>> cause is Wayland libraries.
>>
>> This is too serious of a consequence for using an old API, especially 
>> considering how recently the flags were added. The vast majority of 
>> software has not had time to add the flags: glibc does not define the 
>> macros until 2.38 which was released less than one month ago, man-pages 
>> does not document the flags, and according to Debian Code Search, only 
>> systemd, stress-ng, and strace actually pass either of these flags.
>>
>> Furthermore, since old kernels reject unknown flags, it's not just a 
>> matter of defining and passing the flag; every program needs to 
>> add logic to handle EINVAL and try again.
>>
>> Some other way needs to be found to encourage userspace to add the 
>> flags; otherwise, this message will be patched out because the kernel 
>> log becomes unusable after running unupdated programs, which will still 
>> exist even after upstreams are fixed. In particular, AppImages, 
>> flatpaks, snaps, and similar app bundles contain vendored Wayland 
>> libraries which can be difficult or impossible to update.
> 
> It's being reverted:
> https://lore.kernel.org/all/20230902230530.6B663C433C8@smtp.kernel.org/

in that case:

#regzbot fix: revert "memfd: improve userspace warnings for missing
exec-related flags".
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
