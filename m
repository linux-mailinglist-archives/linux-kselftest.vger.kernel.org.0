Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E681FCC2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQLXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 07:23:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725967AbgFQLXD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 07:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592392982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5v23Ms6NNmHqDha3w4wza/YBCBaVL08E2YTzh7ctRs=;
        b=Fw47gu3iAlIUlTAv9vBbhJ5xXRg4MJ7e3RWl+kiliUaZnY5qrVs8U0K6K+x+XAIfFI5XWn
        EFYTuVcoLc0L2HwjOmCEhI53fVWz+J7U6cD2AO0QRTcabZ/9OAk2MDCFFw3NA5kAUbPL8z
        QvMNHxh2Yc8i0vEoj3NTyzfcrEdJA1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-4Jb4tIGnMzqLubVVK31I-w-1; Wed, 17 Jun 2020 07:22:58 -0400
X-MC-Unique: 4Jb4tIGnMzqLubVVK31I-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF8318A822A;
        Wed, 17 Jun 2020 11:22:56 +0000 (UTC)
Received: from [10.10.112.56] (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5883E5C1D6;
        Wed, 17 Jun 2020 11:22:56 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] selftests/livepatch: use $(dmesg --notime) instead
 of manually filtering
To:     Petr Mladek <pmladek@suse.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
 <20200615172756.12912-3-joe.lawrence@redhat.com>
 <20200617092352.GT31238@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <208708b2-fc70-ec1b-2fb0-715afafa28f9@redhat.com>
Date:   Wed, 17 Jun 2020 07:22:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617092352.GT31238@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/17/20 5:23 AM, Petr Mladek wrote:
> On Mon 2020-06-15 13:27:54, Joe Lawrence wrote:
>> The dmesg utility already comes with a command line switch to omit
>> kernel timestamps, let's use it instead of applying an extra regex to
>> filter them out.
>>
>> Now without the '[timestamp]: ' prefix at the beginning of the log
>> entry, revise the filtering regex to search for the 'livepatch:'
>> subsystem prefix at the beginning of the line.
> 
> I wanted to push this patchset and run full test after each patch.
> Suddenly the tests started to fail, for example:
> 

Hi Petr,

Thank you for running additional tests on your end.  I ran this on 
x86_64, ppc64le and s390 across a bunch of hosts and VMs, but never 
repeatedly so I never saw this interesting combination of issues.

> $/tools/testing/selftests/livepatch> ./test-livepatch.sh
> TEST: basic function patching ... ok
> TEST: multiple livepatches ... not ok
> 
> --- expected
> +++ result
> @@ -1,3 +1,9 @@
> +% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> +livepatch: 'test_klp_livepatch': initializing unpatching transition
> +livepatch: 'test_klp_livepatch': starting unpatching transition
> +livepatch: 'test_klp_livepatch': completing unpatching transition
> +livepatch: 'test_klp_livepatch': unpatching complete
> +% rmmod test_klp_livepatch
>   % modprobe test_klp_livepatch
>   livepatch: enabling patch 'test_klp_livepatch'
>   livepatch: 'test_klp_livepatch': initializing patching transition
> @@ -20,9 +26,3 @@ livepatch: 'test_klp_atomic_replace': co
>   livepatch: 'test_klp_atomic_replace': unpatching complete
>   % rmmod test_klp_atomic_replace
>   test_klp_livepatch: this has been live patched
> -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> -livepatch: 'test_klp_livepatch': initializing unpatching transition
> -livepatch: 'test_klp_livepatch': starting unpatching transition
> -livepatch: 'test_klp_livepatch': completing unpatching transition
> -livepatch: 'test_klp_livepatch': unpatching complete
> -% rmmod test_klp_livepatch
> 
> ERROR: livepatch kselftest(s) failed
> 
> 
> The problem is a combination of:
> 
>    + 1st patch that causes that old kernel messages are not cleared
>    + 2nd patch that removes time stamps from the diff
>    + lost the oldest messages because internal kernel log buffer overflow
>    + run the same tests more times
> 
> As a result, the diff might match with an incomplete log from
> the previous run.
D'oh.  The referenced commit f131d9edc29d uses dmesg without any 
options, so it didn't suffer this gotcha.

> Everything works when this 2nd patch is not commited. The timestamp
> helps to distinguish old and new messages. The lost messages
> are ignored thanks to the diff parameters:
> 
>         --changed-group-format='%>' --unchanged-group-format=''
> 
> If you agree, I'll solve this problem by not committing this patch
> into livepatch.git repo.
> 

Very good catch and explanation.  I'd be okay w/skipping the 2nd patch, 
hopefully the others don't conflict too much by removing it.

> It would be great to add a comment that the timestamp is actually
> important. But it might be done in a followup patch.
> 

Yeah, something that subtle should probably have a comment to that 
effect.  We all thought this was the "easy" change in the set, but never 
thought it through :)

-- Joe

