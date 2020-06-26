Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6720B2A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFZNiz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 09:38:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726770AbgFZNiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 09:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593178734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsFehEv1OUOatwx+S43XjusrlgWYrjMc9ZPpHVwNiv0=;
        b=bzge9EZL37NO18Z8IRja0Hozczcd6t0RkCrdo8oLeN1cUIwcmD3V0A8z1PIekLh0DAjKYs
        B1EcHZimWv0qQkQIsfPvodMRC/n9eFh2vzxhQvfOma1t9tIYq61ek6xO2j0ikW24IdTDmR
        mB9dv63f8RLrZaZChgWaGvNVfWbfNKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-RTrJ4L5INJWpa7hRomPr0g-1; Fri, 26 Jun 2020 09:38:47 -0400
X-MC-Unique: RTrJ4L5INJWpa7hRomPr0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4B7107ACCA;
        Fri, 26 Jun 2020 13:38:45 +0000 (UTC)
Received: from [10.10.112.56] (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79BC470915;
        Fri, 26 Jun 2020 13:38:44 +0000 (UTC)
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Petr Mladek <pmladek@suse.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Shuah Khan <shuah@kernel.org>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
 <20200624083955.GF8444@alley> <20200624201247.GA25319@redhat.com>
 <20200626080252.GL8444@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <762d9ca5-82f3-588c-b147-b0954a764ea7@redhat.com>
Date:   Fri, 26 Jun 2020 09:38:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626080252.GL8444@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/26/20 4:02 AM, Petr Mladek wrote:
> On Wed 2020-06-24 16:12:47, Joe Lawrence wrote:
>> On Wed, Jun 24, 2020 at 10:39:55AM +0200, Petr Mladek wrote:
>>> On Tue 2020-06-23 23:48:36, Joe Lawrence wrote:
>>>> On 6/22/20 4:51 AM, Naresh Kamboju wrote:
>>>>> On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>>>
>>>>>> It is Very Rude to clear dmesg in test scripts. That's because the
>>>>>> script may be part of a larger test run, and clearing dmesg
>>>>>> potentially destroys the output of other tests.
>>>>>>
>>>>>> We can avoid using dmesg -c by saving the content of dmesg before the
>>>>>> test, and then using diff to compare that to the dmesg afterward,
>>>>>> producing a log with just the added lines.
>>>>>>
>>>>>>>>> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
>>>>>> index dadf819148a4..0b409e187c7b 100755
>>>>>> --- a/tools/testing/selftests/lkdtm/run.sh
>>>>>> +++ b/tools/testing/selftests/lkdtm/run.sh
>>>>>>    # Record and dump the results
>>>>>> -dmesg -c >"$LOG"
>>>>>> +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
>>>>>
>>>>> We are facing problems with the diff `=%>` part of the option.
>>>>> This report is from the OpenEmbedded environment.
>>>>> We have the same problem from livepatch_testcases.
>>>>>
>>>>> # selftests lkdtm BUG.sh
>>>>> lkdtm: BUG.sh_ #
>>>>> # diff unrecognized option '--changed-group-format=%>'
>>>>> unrecognized: option_'--changed-group-format=%>' #
>>>>> # BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
>>>>> v1.27.2: (2020-03-30_164108 #
> 
>> I did a bit more hacking to work that awk script into the livepatching
>> tests.  The changes aren't too bad and coding it ourselves lets us drop
>> the temporary dmesg file business.  If this looks good, I can send out
>> as a real patch, but then that raises a few questions:
> 
> The patch worked and I agree that it is not that bad.
> 
> Well, what about using "comm" as proposed by Michael in the other
> mail? It seems to be part of coreutils and should be everywhere.
> 
> I guess that many people, including me, are not fluent in awk.
> So, I am slightly in favor of the "comm" approach ;-)
> 

comm is definitely simpler and for some reason I forgot about the 
leading timestamps (again!) dismissing it thinking that the inputs 
weren't sorted.  But luckily they are and if Naresh or anyone can 
confirm that comm is well supported in the BusyBox testing environment, 
then using that is fine w/me.

-- Joe

