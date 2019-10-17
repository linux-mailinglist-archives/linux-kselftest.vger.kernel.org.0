Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36CDBA10
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441640AbfJQXMk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:12:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43416 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438343AbfJQXMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:12:39 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so3757248ilh.10
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+0CPSRvyze3i0OAGF6jRt0Y0jvNCqBQ68QSaFSVjuI=;
        b=GBAMPTBUAfZXEXI1lTBZvycDc1mCCN+6vmkXr3B8tr6pMw0VZj4013p22j40XQgYRX
         fpb67SZ/2Ogpm3FkoKlYuqdbN/eKlHx9GmoNczUCbzhchnzCXf0MwlFPLLrGX415b1eQ
         DmimY56OyDY61MB8fB7G8q+PBsYZtysxeUwAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+0CPSRvyze3i0OAGF6jRt0Y0jvNCqBQ68QSaFSVjuI=;
        b=aVuepCxfeiv92Z2UCxzvLU7Rwc/BaFz2caF6Dibd2J35Rdggzjafab+caNo0cbsqB/
         7UHyxyVdhY2t/1BkCavnmDP/sow2NkzWojPbbSQeK//HnlTn8JN6SdKjSqu/04wU66m4
         2ckkgDbPUUIU6f9gNNdD0envSVz+2caW/001/LLPGOBzHRVpWDAD8q2k5sdTlThEWv/k
         fqJloU3QBaPi7DCSwAjzN2n7xI7s0bb4YdMulrPC5nN58O/CBHIgOzGNYQflaytK9Ysj
         L4ORFfV3sz+hYT+PjRvXGfN6o1ltOAtMrU4g838R1wYBEmBfWkUB7yNKspf2xyUYRQj1
         qDQQ==
X-Gm-Message-State: APjAAAVD6Jm+J4qMohvsI/8KgBMeH92YtlITBrkHc6k16aBu5lstHMpd
        mtDf+rnR7U7UIJ8XQ258DV25fQ==
X-Google-Smtp-Source: APXvYqyChvp0O8KNa9NRfocOqUJ8BV+7FN2QTNBNv3UKutgU7Hz0ei9Hs7O6KQthhrPcZa4yUA8xCQ==
X-Received: by 2002:a92:5e4d:: with SMTP id s74mr6818458ilb.8.1571353958914;
        Thu, 17 Oct 2019 16:12:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c9sm1722506ilf.0.2019.10.17.16.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 16:12:38 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 17:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 5:07 PM, Iurii Zaikin wrote:
>> Having the ability to take test data doesn't make it non-deterministic
>> though. It just means that if user wants to test with a different set
>> of data, there is no need to recompile the test. This could be helpful
>> to test cases the test write didn't think about.
>>
> Again, unit tests are not meant to be babysat. They are intended to become
> a part of the codebase and be run against every proposed change to ensure
> the change doesn't break anything.
> The whole process is supposed to be fully automated.
> Imagine a KUnit test run for all tests that gets kicked off as soon as a patch
> shows up in Patchwork and the maintainers getting the test run results.
> If you can think of a test that the change author didn't for a new corner case,
> then you as the maintainer ask the change author to add such test.
> Or if some corner case comes up as a result of a bug then the new case is
> submitted with the fix.
> This is how unit testing is deployed in the larger software world. In the most
> enlightened places a change will not be accepted unless it's accompanied by
> the unit tests that offer good coverage for the possible inputs and code paths.
> A change that breaks existing tests is either incorrect and has to be fixed or
> the existing tests need to be updated for the behavior change.
> 

Okay. I am asking for an option to override the test data. You didn't
address that part.

You can do all of this and allow users to supply another set of data.
It doesn't gave to be one or the other.

thanks,
-- Shuah
