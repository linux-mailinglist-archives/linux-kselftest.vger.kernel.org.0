Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDA23D094
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHETut (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgHETuo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 15:50:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C0C061575
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Aug 2020 12:50:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so14257030oti.7
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VuI/sJKChWIgcA9YX17Vw0/G7XG/JpOM9iBt62Uihj0=;
        b=QyMrRJ2Sdo1u1Ywbj9MGXheY1I0xnqtLQfoPR3Om141/eW9ET5BsyaqPDvXBZB4GTs
         v0A3L/WNkHm9SCfyID7NAx9JCGgnfJfc9Go+T9kxD8QefiCVxXfGfLoezYJQYdUqjoWp
         snrKykkM1x5AvEB4ZkAGuuGfzAjmCDL3T3xMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VuI/sJKChWIgcA9YX17Vw0/G7XG/JpOM9iBt62Uihj0=;
        b=nobd0TrmYs3j0sTwmSWc0EBxkQ3Sa1n5qE5T5XfjFdTyKeTv+TNap5HGqdSgTWjRy1
         beSSGLk8uLlctC9BBi549dDHXS+Ykn+9qc2DjDhURIMVcBId8l3CBKJPnwVX0GHLZx3d
         etzQrukmF5bm3SUSU6jyBztC+IpDLPalyelOLCcXvmivJbnX96vSrwPSisxvku1UDvRk
         IXt2azk3OP6Oidh6xGwn+vq8kHxnZOpNKpAxoX82lFhqhPpWJaU1tkwXZixLEf5Fm435
         4gGxSGAxhQt2ZtamATgzRN4k1jePx12wDiL+Z6D2TqPLw5dD+U+Fdu9Zo/qM2USubaPM
         Jfgg==
X-Gm-Message-State: AOAM532WHJUeyEmjMIKQE53GFngfVU1Nf3fTGpbb+jQ8S2j0EVtXOSXK
        a4/vDLI5jV9/zorL0FM+CCU6DA==
X-Google-Smtp-Source: ABdhPJzVbpJRF9EmzEMLmBRCP07DM7eTcfR++AGDxEhQrnCm23HC8AzoYmVBFzNMocQQh1OVmG5p2g==
X-Received: by 2002:a9d:3bb5:: with SMTP id k50mr3971985otc.361.1596657043297;
        Wed, 05 Aug 2020 12:50:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a66sm638956oob.44.2020.08.05.12.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:50:42 -0700 (PDT)
Subject: Re: [PATCH] selftests: more general make nesting support
To:     Greg Thelen <gthelen@google.com>, Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200728073241.3625015-1-gthelen@google.com>
 <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d949545-a7f2-4057-1204-600eabfd8f28@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 13:50:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/5/20 1:36 PM, Greg Thelen wrote:
> On Tue, Jul 28, 2020 at 12:32 AM Greg Thelen <gthelen@google.com> wrote:
>>
>> selftests can be built from the toplevel kernel makefile (e.g. make
>> kselftest-all) or directly (make -C tools/testing/selftests all).
>>
>> The toplevel kernel makefile explicitly disables implicit rules with
>> "MAKEFLAGS += -rR", which is passed to tools/testing/selftests.  Some
>> selftest makefiles require implicit make rules, which is why
>> commit 67d8712dcc70 ("selftests: Fix build failures when invoked from
>> kselftest target") reenables implicit rules by clearing MAKEFLAGS if
>> MAKELEVEL=1.
>>
>> So far so good.  However, if the toplevel makefile is called from an
>> outer makefile then MAKELEVEL will be elevated, which breaks the
>> MAKELEVEL equality test.
>> Example wrapped makefile error:
>>    $ cat ~/Makefile
>>    all:
>>          $(MAKE) defconfig
>>          $(MAKE) kselftest-all
>>    $ make -sf ~/Makefile
>>      futex_wait_timeout.c /src/tools/testing/selftests/kselftest_harness.h   /src/tools/testing/selftests/kselftest.h ../include/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /src/tools/testing/selftests/futex/functional/futex_wait_timeout
>>    make[4]: futex_wait_timeout.c: Command not found
>>
>> Rather than checking $(MAKELEVEL), check for $(LINK.c), which is a more
>> direct side effect of "make -R".  This enables arbitrary makefile
>> nesting.
>>
>> Signed-off-by: Greg Thelen <gthelen@google.com>
>> ---
>>   tools/testing/selftests/Makefile | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 1195bd85af38..289a2e4b3f6f 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -84,10 +84,10 @@ endif
>>   # of the targets gets built.
>>   FORCE_TARGETS ?=
>>
>> -# Clear LDFLAGS and MAKEFLAGS if called from main
>> -# Makefile to avoid test build failures when test
>> -# Makefile doesn't have explicit build rules.
>> -ifeq (1,$(MAKELEVEL))
>> +# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
>> +# implicit rules to sub-test Makefiles which avoids build failures in test
>> +# Makefile that don't have explicit build rules.
>> +ifeq (,$(LINK.c))
>>   override LDFLAGS =
>>   override MAKEFLAGS =
>>   endif
>> --
>> 2.28.0.rc0.142.g3c755180ce-goog
> 
> Is there any feedback on this patch?  It's not high priority but something that
> will help me make more use of selftests.
> 

No issues with the patch. I will apply it once the merge window ends.

thanks,
-- Shuah
