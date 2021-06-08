Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1939F607
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhFHMJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 08:09:59 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40879 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhFHMJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 08:09:59 -0400
Received: by mail-lf1-f50.google.com with SMTP id w33so31720006lfu.7;
        Tue, 08 Jun 2021 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VAfOBJoc1qJNCS5nTSrY8FxqwUZx35xYD+QCSQcyg/E=;
        b=gn64nh7H881kvZgdilDwQQ/Jmn2UA8fEd1UbSbmD6vcVzDGXoWj+Nn5nSR0S6QoxPO
         H3mNiulZtS3oKNI7sHVOzOyyPDx902fEFvTKHiJnC90feEVmxY2i0VseO2TpI1W0onKV
         ZeuP9g9Hp1v0qDw1Bi22W0HgKnLJVfOdjJjtRn5XP6djlTCTIS1MopXnneN4kNsxqzrs
         VLaxfwHk4CIILPxaDnGtRcLU8g7w3fq/dEOzbsvw32i5u5GAUZh3tAKXHV8IWJnbNIFJ
         uMvqO0sXt6811JdoV8pJrpbFM4SBfgDG7ouobLuWvYnajcWYmLd8PVEhQv1Tr4ZX7/Bo
         rwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VAfOBJoc1qJNCS5nTSrY8FxqwUZx35xYD+QCSQcyg/E=;
        b=pJ7rlXFHMwVPGRt+/T5HwZWCQmpfl9WlSkb2cwX4fg+jaVON7UHvxr1Q5Lx4NzUMLy
         P5SQtzgXvFx8I2R84tp82VwqQm7lq9FMUPfGS/4bTRpFJ68PVlzUYhfDvEPE9sZuw8O2
         m0VcDJ178rP6pcsClA2fmpjrvqOCGdSMWNdcexPeOBi1PKN5BMnQNH54UUlrGCPhQm1E
         i+JT3wlkdzKnLQc8CxvAn4v78TPvg7PKaMzzyjPuwwjTkTrpFxIcqluPfDATzndBw9Ic
         IVB2BWfg4VL9wxm2LpcaBXw4NrOAyd6mJqca60fshIZK6l6/nNGAcxCK6En+7yXq4C5+
         7Uwg==
X-Gm-Message-State: AOAM530boDnhNPz7T/IHUH1jY2H3f1tf2CNbayPK10RDjUdb8f80B/OU
        rOfV7zYjfoXiPQpGUfiOGz0=
X-Google-Smtp-Source: ABdhPJx03eSmJ9FhPW+rTuJviNDwxGGatMgrCUkFgc7SNHhcFzH+edpMyCXYZIBzNDbjsRSA+sGX9Q==
X-Received: by 2002:a19:c211:: with SMTP id l17mr2198353lfc.500.1623154010243;
        Tue, 08 Jun 2021 05:06:50 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id q14sm584450ljc.31.2021.06.08.05.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 05:06:49 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com> <YL9Q2tKLZP6GKbHW@kroah.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com>
Date:   Tue, 8 Jun 2021 15:06:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL9Q2tKLZP6GKbHW@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/21 2:13 PM, Greg KH wrote:
> On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
>> On 6/8/21 4:25 AM, Nicholas Piggin wrote:
>>>
>>> Are shared pthread mutexes using existing pthread APIs that are today
>>> implemented okay with futex1 system call a good reason to constrain
>>> futex2 I wonder? Or do we have an opportunity to make a bigger change
>>> to the API so it suffers less from non deterministic latency (for
>>> example)?
>>
>> If futex2 is not able to cover futex1 use cases then it cannot be viewed as
>> a replacement. In the long term this means futex1 cannot be deprecated and
>> has to be maintained. My impression was that futex1 was basically
>> unmaintainable(*) and futex2 was an evolution of futex1 so that users of
>> futex1 could migrate relatively easily and futex1 eventually removed. Maybe
>> my impression was wrong, but I would like to see futex2 as a replacement and
>> extension of futex1, so the latter can be deprecated at some point.
> 
> You can never delete a kernel system call, so even if you "deprecate"
> it, it still needs to be supported for forever.

If I'm not mistaken, some syscalls were dropped from kernel in the past, 
after it was established they are no longer used. So it is not 
impossible, though might be more difficult specifically with futex.

> Best of all would be if internally your "futex2" code would replace the
> "futex1" code so that there is no two different code bases.  That would
> be the only sane way forward, having 2 code bases to work with is just
> insane.

Yes, implementing futex1 in terms of futex2 internally is a possible way 
forward. Though I'm not sure it is reasonable to require that to be done 
in the initial futex2 submission. This requires all of the futex1 
functionality to implemented in futex2 from the start, which I think is 
too much to ask. Even with some futex1 features missing, futex2 would be 
already very much useful to users, and it is easier to implement the 
missing bits incrementally over time.

Also, one other point I'd like to make is that not all futex1 features 
might need to be reimplemented if futex2 provides a better alternative. 
For example, as a user, I would like to see a different approach to 
robust futexes that does not mandate a single user (libc) and allows to 
use robust futexes directly.

>> (*) I use "unmaintainable" in a broad sense here. It exists and works in
>> newer kernel versions and may receive code changes that are necessary to
>> keep it working, but maintainers refuse any extensions or modifications of
>> the code, mostly because of its complexity.
> 
> Adding additional complexity for no good reason is not a good idea,
> especially if you are asking others to maintain and support that
> complexity.  Would you want to have to do that work?
> 
> So what's keeping the futex2 code from doing all that futex1 does so
> that the futex1 code can be deleted internally?

I think, André will answer this, but my guess is, as stated above, this 
is a lot of work and time while the intermediate version is already useful.
