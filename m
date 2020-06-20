Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC692024A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgFTPD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgFTPD5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 11:03:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD118C06174E;
        Sat, 20 Jun 2020 08:03:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h23so2350367qtr.0;
        Sat, 20 Jun 2020 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=koB9IjwY2OZ28a4VwPLGjE07xqWjvDo3yhFwmqd4pvQ=;
        b=YqmaT4pUgnIt1jeea8K6Q6ZUBzHXbj8+/T5ODk76ZMVuXW22w9jMUhOcFazQR/SbrF
         QYqMPqpCznY7EcgtxgL3mus3sGj7fdFCKQs0CQhZDGT+DDvP/wB1lnqJyf7qMduUDlLl
         335xRbg64O24Thayj8D1CSfvWiQ0c2xDqDv4jhnNVTqrv8OrRXX5/3B+P4Pb3Z2YZ0lQ
         UKfFUkZaubYhNAzT1lGq7Ttdu0e7teBStm5jPwru2Q7aRs5kIPqg+Bj+Fbt2wmPXcbYf
         9hFWLyMXN/c9BWJ2G+kYiuQru2BSpd+hzYiBPdTsUO+pL4vydseWeTXZuWCOTc+ywcti
         TT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=koB9IjwY2OZ28a4VwPLGjE07xqWjvDo3yhFwmqd4pvQ=;
        b=egxubF7p52CpascOGGNB111fczJYCNbfzPVsXzTWFGvqDjDaVZmSjUCiGM9UUPGvwU
         IKXAjFDh0Qv1AYoPFDd+0TAkXh+x1J15eMght4kEMk58iWLjSh3zg6k0cBWRaoTuRnGB
         PLbCtQH0bIKU3tToLYUfjJUGPa90ILDazvNrxEyesxx78KyW4cx3vrZJpE8r1Lw3EtAu
         MZXNl+W+cPFesQiCJRuTNMEz7TIT4VTECVNjpwccw1ICSiDfbdvVGdmg1S+gZkMuDd2A
         KjF/8u5ja5eAX2+aITJyhti1w4/vIO9CRtoXQbou1KqymxlVq+3oSFisfItOAfA/rSry
         r8XA==
X-Gm-Message-State: AOAM531azVP7qKrPJqJoIsEWcxTclHC2rY8CH6owRN4Ay9DxVYY2aGNU
        QhtDUpBNiVgHLhbFeh7OGxo=
X-Google-Smtp-Source: ABdhPJykqn233SKfOq5gMysBpNrGffj3s8+eUFAxoV8wwDSIaObBG2lDYndmcop++UMy3lqTKdpKlw==
X-Received: by 2002:ac8:7552:: with SMTP id b18mr8711607qtr.150.1592665436115;
        Sat, 20 Jun 2020 08:03:56 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id u6sm1441801qtk.9.2020.06.20.08.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 08:03:55 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     David Gow <davidgow@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <dc853d83-649e-b652-819f-4766ea294d78@gmail.com>
 <CABVgOS=qSMY9xP7db4-hkSt71YKyPpJuQv=fqcfzV-kCC1k9qQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5b4c248a-f8c9-0913-5280-8e436cdc5838@gmail.com>
Date:   Sat, 20 Jun 2020 10:03:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOS=qSMY9xP7db4-hkSt71YKyPpJuQv=fqcfzV-kCC1k9qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-20 01:44, David Gow wrote:
> On Sat, Jun 20, 2020 at 1:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2020-06-16 07:08, Paolo Bonzini wrote:
>>> On 15/06/20 21:07, Bird, Tim wrote:
> 
>>>>>> Finally,
>>>>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
>>>>>> See https://testanything.org/tap-version-13-specification.html
>>>>>
>>>>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
>>>>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
>>>>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
>>>>> should be "ok"? I guess we should change it to "ok".
>>>
>>> See above for XFAIL.
>>>
>>> I initially raised the issue with "SKIP" because I have a lot of tests
>>> that depend on hardware availability---for example, a test that does not
>>> run on some processor kinds (e.g. on AMD, or old Intel)---and for those
>>> SKIP should be considered a success.
>>
>> No, SKIP should not be considered a success.  It should also not be considered
>> a failure.  Please do not blur the lines between success, failure, and
>> skipped.
> 


> I agree that skipped tests should be their own thing, separate from
> success and failure, but the way they tend to behave tends to be
> closer to a success than a failure.
> 
> I guess the important note here is that a suite of tests, some of
> which are SKIPped, can be listed as having passed, so long as none of
> them failed. So, the rule for "bubbling up" test results is that any
> failures cause the parent to fail, the parent is marked as skipped if
> _all_ subtests are skipped, and otherwise is marked as having
> succeeded. (Reversing the last part: having a suite be marked as
> skipped if _any_ of the subtests are skipped also makes sense, and has
> its advantages, but anecdotally seems less common in other systems.)

That really caught my attention as something to be captured in the spec.

My initial response was that bubbling up results is the domain of the
test analysis tools, not the test code.

If I were writing a test analysis tool, I would want the user to have
the ability to configure the bubble up rules.  Different use cases
would desire different rules.

My second response was to start thinking about whether the tests
themselves should have any sort of bubble up implemented.  I think
it is a very interesting question.  My current mindset is that
each test is independent, and their is not a concept of an umbrella
test that is the union of a set of subtests.  But maybe there is
value to umbrella tests.  If there is a concept of umbrella tests
then I think the spec should define how skip bubbles up.


> 
> The other really brave thing one could do to break from the TAP
> specification would be to add a "skipped" value alongside "ok" and
> "not ok", and get rid of the whole "SKIP" directive/comment stuff.
> Possibly not worth the departure from the spec, but it would sidestep
> part of the problem.

I like being brave in this case.  Elevating SKIP to be a peer of
"ok" and "not ok" provides a more clear model that SKIP is a first
class citizen.  It also removes the muddled thinking that the
current model promotes.

> 
> 
> Cheers,
> -- David
> 

