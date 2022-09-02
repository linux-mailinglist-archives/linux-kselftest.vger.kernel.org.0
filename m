Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2895AAD11
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiIBLEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiIBLEL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 07:04:11 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A2C6508
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 04:04:07 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJw5d5TyKzMpvhR;
        Fri,  2 Sep 2022 13:04:05 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJw5d0KwBzlh8kt;
        Fri,  2 Sep 2022 13:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662116645;
        bh=2NupZEbQhzLkAmKzohlpC8jqcOh9uHWcOTqm5iFnBo4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1xYd1nX4oRzTFfwoTyTfk4ekb+ct01DJz3FFBMRyzLRXc//Dq3/bVvsXMB9QZU0LI
         vPNR4/RmMqxVVeRaaFMu0vDQ4unFAMKpmEeSdSOBYesRTX9FrYVyqLKFi8kjD6wLkF
         2Mt1PJyxGQYsBtwxi/XUJfL4tT3r0Xj2/vlN/Qnw=
Message-ID: <b1cfb8d4-ad54-9cc1-3d9d-e690c81da016@digikod.net>
Date:   Fri, 2 Sep 2022 13:04:04 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC PATCH v1] checkpatch: Handle FILE pointer type
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
References: <20220901145948.1456353-1-mic@digikod.net>
 <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
 <b028cf83798fd562f5d1b992d2651d53e21acaa2.camel@perches.com>
 <b079d162-fa10-8cf0-bfc9-91f72a440e34@digikod.net>
 <026c08d9ab841ef626f80d968a532dea94a37c62.camel@perches.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <026c08d9ab841ef626f80d968a532dea94a37c62.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 02/09/2022 12:39, Joe Perches wrote:
> On Fri, 2022-09-02 at 11:04 +0200, Mickaël Salaün wrote:
>> On 01/09/2022 20:22, Joe Perches wrote:
>>> On Thu, 2022-09-01 at 11:49 -0400, Joe Perches wrote:
>>>> On Thu, 2022-09-01 at 16:59 +0200, Mickaël Salaün wrote:
>>>>> When using a "FILE *" type, checkpatch considers this an error.  Fix
>>>>> this by explicitly defining "FILE" as a common type.
>>>> []
>>>>> Another error may be throw when we use FIXTURE_{DATA,VARIANT}() structs,
>>>>> as defined in kselftest_harness.h .
>>>> []
>>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> []
>>>>> @@ -576,10 +576,17 @@ our $typeKernelTypedefs = qr{(?x:
>>>>>    	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
>>>>>    	atomic_t
>>>>>    )};
>>>>> +our $typeStdioTypedefs = qr{(?x:
>>>>> +	FILE
>>>>> +)};
>>>>
>>>> I'm fine with this.
>>>>
>>>>> +# our $typeKselftestHarnessTypedefs = qr{(?x:
>>>>> +# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
>>>>> +# )};
>>>>
>>>> But not this.  Random userspace typedefs should likely
>>>> be kept in some local version of checkpatch.
>>>>
>>>> Or maybe add a command line option like --additional_typedefs=<file>.
>>>
>>> Oops.  I forgot it already exists:
>>>
>>>     --typedefsfile             Read additional types from this file
>>>
>>> commit 75ad8c575a5ad105e2afc2051c68abceb9c65431
>>> Author: Jerome Forissier <jerome.forissier@linaro.org>
>>> Date:   Mon May 8 15:56:00 2017 -0700
>>>
>>>       checkpatch: add --typedefsfile
>>>       
>>>       When using checkpatch on out-of-tree code, it may occur that some
>>>       project-specific types are used, which will cause spurious warnings.
>>>       Add the --typedefsfile option as a way to extend the known types and
>>>       deal with this issue.
>>
>> This doesn't work for the FIXTURE_DATA() case.
> 
> checkpatch is a stupid little script.
> It's not a c preprocessor nor a syntax complete compiler.
> It's really easy for macros to make its output invalid.
> If you feed obfuscated c to checkpatch, it'd be confused.
> (Same is true for tools like coccinelle btw, though cocci is far better)
> checkpatch will never be comprehensive nor perfect.
> It's expected its users will use their common sense about its
> output message validity.
> 
>> And I'm not sure how
>> contributors would know that they need to use this option with a
>> specific file.
> 
> --help exists
> 
> Maybe Documentation/dev-tools/checkpatch.rst could be expanded for
> --verbose mode.

I was thinking about which file to use, but I understand your point. 
I'll send a v2 with only the "FILE" addition.
FIXTURE_{DATA,VARIANT}() will just not be handled but that's OK.
