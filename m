Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757251F5B14
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgFJSW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 14:22:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39545 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728776AbgFJSW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 14:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591813376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSjai+DFDzFrxMEYWRAg/j6/ardpz/bet/R5ZQH8NOQ=;
        b=LMnP6Aekzfxar0qSobyAcOZT/WPLopkEOC6fUfW/1rL92SbEnO3yx6RRe+dcZtkUTmK+kb
        EVi2hGYlINAK8o+xPxKf4Rdbt3pXTE5aYoQRS/hp4euEAq9q6o31A7bepNydY7SHxi37Vh
        3Go4NYByod4zpmyhin9E/U/UMSN0YyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-TZPONffhN1uDLzhszE3AWA-1; Wed, 10 Jun 2020 14:22:54 -0400
X-MC-Unique: TZPONffhN1uDLzhszE3AWA-1
Received: by mail-wr1-f72.google.com with SMTP id c14so1422208wrw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jun 2020 11:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSjai+DFDzFrxMEYWRAg/j6/ardpz/bet/R5ZQH8NOQ=;
        b=C3mHmCRxyzpl1TzCtvHiDpjaVUPIxx4BY+R/Z+0u+kGPbODZ5P64SO3IXpLDqjfgXJ
         8Oqf6YBO1ZNqYIIO5AeRMMHut4EbWchck4pRvTG3yYakxGEOvr1bvRpJqN6jcqx1rnz2
         wHojlQqLz57iIfPXxvxO7IBtapjedT2MIZYFjI8YY/g9U2ajoQRoB3OJEKkFGH35wTRB
         1RtkR2ghgP5gLKg9t8YBON16xLiU33SrFP2F8dB5GzyceYp3lkqFKztPidYYGrw86oKf
         UwkrMDuqkuRB4KiKyYDE5rGO0GlN7jHVBuxmttXnU/qRc6bgupCcPYUxfVJXyg9HJ1dj
         LZzg==
X-Gm-Message-State: AOAM530xW5b9PpNNL4cTt4LZ337stRJ/xwDSit7ZYEiP98hNZbvLuTup
        Dla2qU0qJvq3Z89AroB484UbwFbnEj2ebi8BlS+pLVjaKZH2WEou1u+DqMpIzO/r9gYy3UvA8WF
        /MnSwkPmTCannls1hHcea/PoV1FD9
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5459678wru.118.1591813373334;
        Wed, 10 Jun 2020 11:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL+HRgXUT5dVlw53IXZIty7joPl0qkXidchmFCFVFqHTrz1BuekJ/juSrrBdN78oDX42KGJw==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5459653wru.118.1591813373088;
        Wed, 10 Jun 2020 11:22:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b5a1:606f:4d92:f4e1? ([2001:b07:6468:f312:b5a1:606f:4d92:f4e1])
        by smtp.gmail.com with ESMTPSA id n23sm593760wmc.21.2020.06.10.11.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:22:52 -0700 (PDT)
Subject: Re: [PATCH] kselftest: runner: fix TAP output for skipped tests
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20200610154447.15826-1-pbonzini@redhat.com>
 <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
 <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6461f067-0fea-4419-dd56-2661c44a803a@redhat.com>
Date:   Wed, 10 Jun 2020 20:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/06/20 19:43, Bird, Tim wrote:
>>>   		(rc=$?;	\
>>>   		if [ $rc -eq $skip_rc ]; then	\
>>> -			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>>> +			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> 
> This is a pretty big change, and might break upstream CIs that have come to
> rely on kselftest's existing behavior.  I know it's going to break Fuego's parsing
> of results.

Do you have a pointer to this code?

> kselftest has a few conventions that are different from the TAP spec, 
> and a few items it does that are extensions to the TAP spec.

Yes, there are extensions to directives are not a problem and parsers
might raise an error on them.  That can be an issue, but it's a separate
one (and it's easier to ignore it as long as test pass...).

> IMHO, the TAP spec got this one wrong, but I could be convinced
> otherwise.

Here the TAP spec says that a skip starts with "ok" and has a "SKIP"
directive, and anyone can parse it to treat as it as a failure if
desirable.  But doing something else should be treated simply as a
violation of the spec, it's not a matter of "right" or "wrong".

So, if you want to use "not ok ... # SKIP", don't call it TAP.

However, I noticed now that there is another instance of "not ok.*SKIP"
in testing/selftests/kselftest.h (and also one in a comment).  So they
should all be fixed at the same time, and I'm okay with holding this patch.

Paolo

> But I think we should discuss this among CI users of
> kselftest before making the change.
> 
> I started work quite a while ago on an effort to document the
> conventions used by kselftest (particularly where it deviates
> from the TAP spec),  but never submitted it.
> 
> I'm going to submit what I've got as an RFC now, for discussion,
> even though it's not finished.  I'll do that in a separate thread.
> 
> 
>>>   		elif [ $rc -eq $timeout_rc ]; then \
>>>   			echo "#"
>>>   			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>>>
>>
>> Thanks. I will pull this in for Linux 5.8-rc2
> Shuah - can you hold off on this until we discuss it?
> 
> Thanks,
>  -- Tim
> 

