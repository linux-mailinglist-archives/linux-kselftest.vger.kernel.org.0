Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45B58A151
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiHDTih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiHDTig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8E6E2C3;
        Thu,  4 Aug 2022 12:38:34 -0700 (PDT)
Received: from [192.168.43.224] (92.40.178.239.threembb.co.uk [92.40.178.239])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC6A66601BFA;
        Thu,  4 Aug 2022 20:38:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659641913;
        bh=YR06TcNC313+o+tpJhkeCXhA11OnSzpwetPY80MPTq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCtIdWnL2e3j3b9gdVcogqaPJdIXpTMgJxLBj4dlqklzGGr+zjNymQNEg7n7pyu4d
         GHPEo9M+McUemcrv9Otu2/Z3Fn3IP7VHZBgkh8JdXIgkRumV3jUOUH5bWWDLXChCj1
         3kyMMD36iE+unBbMXx/uLjMr6ij+L+dRnYM/tSRs0lFwcSU2llcza8j3lFy/3rL3QO
         B0pR71xhOFsP6GtYzQ9WcKE/BEq9TueMWvOGCDNenJsuNwqohBwmv/Qunff/g1u9PP
         DO2U1/v78mnY1VI+v/I3DZXZ2f0mQesixMRx4sbXDY5m4+YPxTM8M6VhekCvZUBjIl
         oNSnzdAWn2foQ==
Message-ID: <76a2ac43-6e3d-0b62-7c8c-eec5f247f8f8@collabora.com>
Date:   Thu, 4 Aug 2022 21:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/08/2022 12:36, Mickaël Salaün wrote:
> 
> On 03/08/2022 22:13, Guillaume Tucker wrote:
>> Revert part of the earlier changes to fix the kselftest build when
>> using a sub-directory from the top of the tree as this broke the
>> landlock test build as a side-effect when building with "make -C
>> tools/testing/selftests/landlock".
>>
>> Reported-by: Mickaël Salaün <mic@digikod.net>
>> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
>> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>   tools/testing/selftests/landlock/Makefile | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
>> index a6959df28eb0..02868ac3bc71 100644
>> --- a/tools/testing/selftests/landlock/Makefile
>> +++ b/tools/testing/selftests/landlock/Makefile
>> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>>   TEST_GEN_PROGS_EXTENDED := true
>>     OVERRIDE_TARGETS := 1
>> +top_srcdir := ../../../..
> 
> Not sure it changes much, but most other selftests Makefiles use "top_srcdir = ../../../.." (without ":="). Why this change?

I didn't simply apply your diff but edited the file by hand to
test various combinations and see what side effects it might
have.  So when I added top_srcdir I typed it by hand and used :=
as a reflex since it's the standard way of assigning variables.
Using = instead only makes a difference when the r-value has
something dynamic as it will be re-evaluated every time it's
used.  So for constant values, I guess it's more of a question of
coding style and conventions.  Maybe all the top_srcdir variables
should be changed to := but that's unnecessary churn...  Either
way, it's benign.

Shuah, feel free to change this back to = in this particular case
if it's more consistent with other Makefiles.  Consistency is
often better than arbitrary rules.  Or conversely, change to :=
for the khdr_dir definition...  Entirely up to you I think.

Thanks,
Guillaume

>>   include ../lib.mk
>>   +khdr_dir = $(top_srcdir)/usr/include
>> +
>>   $(OUTPUT)/true: true.c
>>       $(LINK.c) $< $(LDLIBS) -o $@ -static
>>   -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
>> -    $(LINK.c) $< $(LDLIBS) -o $@ -lcap
>> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
>> +    $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)

