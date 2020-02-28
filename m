Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD2173FD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 19:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1Snf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 13:43:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46750 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgB1Snf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 13:43:35 -0500
Received: by mail-io1-f68.google.com with SMTP id e7so4464870ioe.13
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2020 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=moBvHo+PTilRWFkHOSs3qSLIv/tOzADb8Es4P0sl9A4=;
        b=SsiA+gq4Oo+ubZQXvcRExrh5NfW6GLe9g4JUQI/KH4QsPvKRz4QNqomuzJzwyk7YDa
         lMTgOTmFuYCvxYc5xXgthDOExlRMgtWcfRrgkCotfmYIALKHgnSgXtUONERx+9ZPRnWA
         +skhwvRdMP3b21fpLh78V52Ee8lz1/l1XMfvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moBvHo+PTilRWFkHOSs3qSLIv/tOzADb8Es4P0sl9A4=;
        b=oQTlnWFKGYbIqzYi0DX/7ivGmAfEFm0m00MFRExrJMmH/vHJjzSSh0WvLoYydeqw+t
         4pXZNra0lRVCVIp699GUMv7BKxj6y3qsXaaT5oF2GfusEW6CAnsRiWf+VTGH2ZfCwVFd
         upleSU0PUeFyOYV1a/ho91K0DiuQr28O4NNA8kJhg+o7mKhp+wH1DutXIO4VPxbXxiNE
         XnzIrLj44/lddHaSFoy2EX2jo+q01TAATer3/aPQGw9uQOTHJrKfbd6Of3WdQA745HnH
         Ci8JGQD2SOmPzA05QgZVAyDNWgTb7eUCZt4Cp+mW7SnMc1uGXzlL3f55uMUpsXYslrQV
         VnAg==
X-Gm-Message-State: APjAAAV1Z69UZ2wOvqkjJIbxXwJ73jTv1/e0cH97RaUCpa328P7PDlfW
        tMD1gsu3NIsZkWtY5cl8xktz7Q==
X-Google-Smtp-Source: APXvYqwcG8lwkJgB3d/ZO1F4ZoMeFM/E3+QmylfeUoe+iG4RNtc5jkbVqye8lQKuc9S4XFj6YfaKnA==
X-Received: by 2002:a05:6638:501:: with SMTP id i1mr4392752jar.25.1582915414850;
        Fri, 28 Feb 2020 10:43:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g16sm2150292ioc.13.2020.02.28.10.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 10:43:34 -0800 (PST)
Subject: Re: [ANN] Kselftest integration into Kernel CI
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org>
 <MWHPR13MB08954921D3B29D9AA824A2A0FDE80@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f361d23d-f721-ab2c-6797-3b04f0616567@linuxfoundation.org>
Date:   Fri, 28 Feb 2020 11:43:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB08954921D3B29D9AA824A2A0FDE80@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/28/20 10:50 AM, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From:  Shuah Khan
>>
>> Integrating Kselftest into Kernel CI rings depends on Kselftest build
>> and install framework to support Kernel CI use-cases. I am kicking off
>> an effort to support Kselftest runs in Kernel CI rings. Running these
>> tests in Kernel CI rings will help quality of kernel releases, both
>> stable and mainline.
>>
>> What is required for full support?
>>
>> 1. Cross-compilation & relocatable build support
>> 2. Generates objects in objdir/kselftest without cluttering main objdir
>> 3. Leave source directory clean
>> 4. Installs correctly in objdir/kselftest/kselftest_install and adds
>>      itself to run_kselftest.sh script generated during install.
>>
>> Note that install step is necessary for all files to be installed for
>> run time support.
>>
>> I looked into the current status and identified problems. The work is
>> minimal to add full support. Out of 80+ tests, 7 fail to cross-build
>> and 1 fails to install correctly.
>>
>> List is below:
>>
>> Tests fails to build: bpf, capabilities, kvm, memfd, mqueue, timens, vm
>> Tests fail to install: android (partial failure)
>> Leaves source directory dirty: bpf, seccomp
>>
>> I have patches ready for the following issues:
>>
>> Kselftest objects (test dirs) clutter top level object directory.
>> seccomp_bpf generates objects in the source directory.
>>
>> I created a topic branch to collect all the patches:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kernelci
>>
>> I am going to start working on build problems. If anybody is
>> interested in helping me with this effort, don't hesitate to
>> contact me. I first priority is fixing build and install and
>> then look into tests that leave the source directory dirty.
> 
> I'm interested in this.  I'd like the same cleanups in order to run
> kselftest in Fuego, and I can try it with additional toolchains
> and boards.  Unfortunately, in terms of running tests, almost all
> the boards in my lab are running old kernels.  So the tests results
> aren't useful for upstream work.  But I can still test
> compilation and install issues, for the kselftest tests themselves.
> 

Testing compilation and install issues is very valuable. This is one
area that hasn't been test coverage compared to running tests. So it
great if you can help with build/install on linux-next to catch
problems in new tests. I am finding that older tests have been stable
and as new tests come in, we tend to miss catching these types of
problems.

Especially cross-builds and installs on arm64 and others.

>>
>> Detailed report can be found here:
>>
>> https://drive.google.com/file/d/11nnWOKIzzOrE4EiucZBn423lzSU_eNNv/view?usp=sharing
> 
> Is there anything you'd like me to look at specifically?  Do you want me to start
> at the bottom of the list and work up?  I could look at 'vm' or 'timens'.
> 

Yes you can start with vm and timens.

thanks,
-- Shuah
