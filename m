Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5391FAFE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFPMJB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 08:09:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPMJA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 08:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592309338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqZs+hqanGL9wIjAP1yJ+a+U37tmuYG6HORjMjf4l70=;
        b=aj3oKuxhBQJcqbZA7O5xtRMUtW9w29Tu08DRpoIHilB6+iUublx/17ghDa28tvSRXRWytp
        MmRUn6E/GoYKFTGEAxLL6RVqwdTrPBbciAsuTRVl3WwzBrzX1gBjy5Dr04lDGZcAd+zwvQ
        Gr42lCFyvmzal3Iak7vBO9Angtu9ld0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-YGHFISkFPfCG82RCQ7oDMQ-1; Tue, 16 Jun 2020 08:08:53 -0400
X-MC-Unique: YGHFISkFPfCG82RCQ7oDMQ-1
Received: by mail-wm1-f70.google.com with SMTP id a7so871617wmf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 05:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqZs+hqanGL9wIjAP1yJ+a+U37tmuYG6HORjMjf4l70=;
        b=sWDLAzGUslRIlWf2ly3Sq4w9/+xocyb2eYzdqKz41b7hwKN6Th4PjM9+ZaUaXKywUK
         820FZ2WNOh0ppzeRSwZXX56dfAtrj2+Y0E+9V/LZPwjAvJENhKD2holsVXmjOdE5QGTH
         J1BgONlksxiKnyuikLgw43LKVtc6bpxqtC40ZKGKB4HFlN7QDFmK4OlMfHCZqeVrfUjc
         pxw5ayt2cmWLfdYYENwuwD73rXmPeyBNS1i7xlBqFc66OFwPzw0MjJamcvVNjTz1ute+
         4EO18MyJe2hmRjkNNmmnGYBTRDT/L/D7+r5MpcDcwQCTWVDArP08wKpsbUv1JMhGICAh
         3sHA==
X-Gm-Message-State: AOAM5323MDomqmbO/Ag7Si5PVpcZTF49xf16sDjI9tgRT4nwdB56Z3gP
        90GTfuOOGQZBAze0h3sTNtxx/5h7/M2m11hPf8WSjujgzvbrGjcnxGp6sXqvcKl66gjab66Mlyb
        dFwd0AYqExX7z62f2jQHr+nNzHNv1
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2896936wmb.90.1592309331960;
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCcM0xA8rD4IpmIFhk1JYlN8RaP69+JBsyEA1C5OCkZnr0VhIH2DGhRBeLEKEWZqRRDvjmWQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr2896914wmb.90.1592309331627;
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.88.161])
        by smtp.gmail.com with ESMTPSA id z12sm31645155wrg.9.2020.06.16.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:08:51 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
Date:   Tue, 16 Jun 2020 14:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/06/20 21:07, Bird, Tim wrote:
>> Note: making the plan line required differs from TAP13 and TAP14. I
>> think it's the right choice, but we should be clear.

As an aside, where is TAP14?

> With regards to making it optional or not, I don't have a strong
> preference.  The extra info seems helpful in some circumstances.
> I don't know if it's too onerous to make it a requirement or not.
> I'd prefer if it was always there (either at the beginning or the end),
> but if there is some situation where it's quite difficult to calculate,
> then it would be best not to mandate it. I can't think of any impossible
> situations at the moment.

I think making the plan mandatory is a good idea.  "Late plans" work
very well for cases where you cannot know in advance the number of tests
(for example in filters that produce TAP from other output), and provide
an additional safety net.

>> "Bail out!" to be moved to "optional" elements, since it may not appear.
>> And we should clarify TAP13 and TAP14's language to say it should only
>> appear when the test is aborting without running later tests -- for this
>> reason, I think the optional "description" following "Bail out!" should
>> be made required. I.e. it must be: "Bail out! $reason"
> 
> I'll make sure this is listed as optional.
> I like adding a mandatory reason.

+1.

>> TAP13/14 makes description optional, are we making it required (I think
>> we should). There seems to be a TAP13/14 "convention" of starting
>> <description> with "- ", which I'm on the fence about it. It does make
>> parsing maybe a little easier.
> 
> I would like the description to be required.
> I don't have a strong opinion on the dash.  I'm OK with either one (dash
> or no dash), but we should make kselftest and KUnit consistent.

I think no mandatory dash is better (or even mandatory no-dash!).  We
can suggest removing it when formatting TAP output.

>>> Finally, it is possible to use a test directive to indicate another
>>> possible outcome for a test: that it was skipped.  To report that
>>> a test case was skipped, the result line should start with the
>>> result "not ok", and the directive "# SKIP" should be placed after
>>> the test description. (Note that this deviates from the TAP13
>>> specification).

How so?  The description comes first, but there can be a description of
the directive.

     not ok 4 - Summarized correctly # TODO Not written yet

>>> It is usually helpful if a diagnostic message is emitted to explain
>>> the reasons for the skip.  If the message is a single line and is
>>> short, the diagnostic message may be placed after the '# SKIP'
>>> directive on the same line as the test result.  However, if it is
>>> not on the test result line, it should precede the test line (see
>>> diagnostic data, next).
>>>
>>> Bail out!
>>> ---------
>>> If a line in the test output starts with 'Bail out!', it indicates
>>> that the test was aborted for some reason.  It indicates that
>>> the test is unable to proceed, and no additional tests will be
>>> performed.
>>>
>>> This can be used at the very beginning of a test, or anywhere in the
>>> middle of the test, to indicate that the test can not continue.
>>
>> I think the required syntax should be:
>>
>> Bail out! <reason>
>>
>> And to make it clear that this is optionally used to indicate an early
>> abort. (Though with a leading plan line, a parser should be able to
>> determine this on its own.)

True.  However, "Bail out!" allow to distinguish issues with the harness
(such as ENOSPC) from test aborts.

>>>  - TODO directive
>>
>> Agreed: SKIP should cover everything TODO does.

XFAIL/XPASS are different from SKIP.  I personally don't have a need for
them, but kselftests includes XFAIL/XPASS exit codes and they aren't
reflected into selftests/kselftest/runner.sh.

Likewise, kselftest.h has ksft_inc_xfail_cnt but not
ksft_test_result_xfail/ksft_test_result_xpass.

It's important to notice in the spec that the TODO directive inverts the
direction of ok/not-ok (i.e. XFAIL, the "good" result, is represented by
"not ok # TODO").

>>>  - test identifier
>>>     - multiple parts, separated by ':'
>>
>> This is interesting... is the goal to be able to report test status over
>> time by name?

What about "/" instead?

>>> Finally,
>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
>>> See https://testanything.org/tap-version-13-specification.html
>>
>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
>> should be "ok"? I guess we should change it to "ok".

See above for XFAIL.

I initially raised the issue with "SKIP" because I have a lot of tests
that depend on hardware availability---for example, a test that does not
run on some processor kinds (e.g. on AMD, or old Intel)---and for those
SKIP should be considered a success.

Paolo

> I have the same initial impression.  In my mind, a skip is "not ok", since
> the test didn't run. However, a SKIP and should be treated differently
> from either "ok" or "not ok" by the results interpreter, so I don't think it
> matters.  Originally I was averse to changing the SKIP result to "ok"
> (as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial to
> change the parser in Fuego, and it would make the kernel results format
> match the TAP13 spec.  I don't see a strong reason for us to be different
> from TAP13 here.
> 
> I raised this issue on our automated testing conference call last week
> (which includes people from the CKI, Fuego, KernelCI and LKFT projects), and
> so people should be chiming in if their parser will have a problem with this change.)
> 
> [1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.com/T/
> 
> Thanks very much for the feedback.
>  -- Tim
> 

