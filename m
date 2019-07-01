Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB818327
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 03:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEIBPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 21:15:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41408 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEIBPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 21:15:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so281395pgp.8;
        Wed, 08 May 2019 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+Jfl9iXviaxHbmbhnDjk1eQnpFz6l/2Nut9ww82zvo=;
        b=a3KgZzLZ0y84UNUIY8RS+nYDRzFkAivRDtTwVjhJ1vYp+v2Z6HVSzmnnRowbVUedfI
         93zPM5T0iF4iJCU1PddnaPwpC/nrCINNvHKs9PmQ0ayrLgURqYfh7EH67znRVZxTURN5
         VsMO/ROT48Ly/mYey3OTt/dpawpdAk7DUuJetc8MAAQuinmU4P2PjwyMam4VRQGyIo8C
         F5An8gjuExmDUN5kMRWiGJsQOqa4gz/Zgv9YpcjdE85z0otG8d1GXhf4e05Hdx2o8s1c
         hn9kGYBDYT3L0e4JtQg2AhBurTKMtE9VNzBNe+yPm2LTyV/rg3Wp/BZ+nH8mhD2rC6M3
         7+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+Jfl9iXviaxHbmbhnDjk1eQnpFz6l/2Nut9ww82zvo=;
        b=a086WzWOF9zlpKfGBY4LodiG2Cqf1r78lIcu1kGog3yz0L8IXZX3AiX0Bm3K05j7UU
         zFmvbNfY35LhML5kZ7dS0fRrhsbyrASjkP6idMqmIxkj8p+AZcj7fnrv2JqgM6i6r+A+
         N6nKV0nuElLWf/e1MjnFkJYLwuAxJi++XY/wDHK654ADK4oQWqiN3aowMniqL7Q0KR2i
         PCIhm5A8fEHp0Vcj/0r0ZumSDnO0d9OqH7nTiUjIvTuPEm+mkULak+uD3GkxtLL9/DQ2
         RWZI+r6CyMa6Nq6Ra1ZcVFrKbGSEDg5OAsbcUTr2sMOotGJRRqmz615xO+V+DHzumOtc
         ew+g==
X-Gm-Message-State: APjAAAVnUsL4IZX+D6Com+KFV+QDYMijxJK67QglVIaqRDH8l8n3vztP
        KBgRmvUYpzcEje71+1MWSUfPf+n1
X-Google-Smtp-Source: APXvYqzW2wEIzqNsRgYl9IE5EX5P/24Mi1edBj4NYy1YPo+96Z3/rjpt+DtwN4pC4yu/pBUKvsKvyA==
X-Received: by 2002:a65:628b:: with SMTP id f11mr1432751pgv.95.1557362619650;
        Wed, 08 May 2019 17:43:39 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 63sm543120pfu.95.2019.05.08.17.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 17:43:38 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
Date:   Wed, 8 May 2019 17:43:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507080119.GB28121@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/7/19 1:01 AM, Greg KH wrote:
> On Mon, May 06, 2019 at 08:14:12PM -0700, Frank Rowand wrote:
>> On 5/1/19 4:01 PM, Brendan Higgins wrote:
>>> ## TLDR
>>>
>>> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
>>> 5.2.
>>>
>>> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
>>> we would merge through your tree when the time came? Am I remembering
>>> correctly?
>>>
>>> ## Background
>>>
>>> This patch set proposes KUnit, a lightweight unit testing and mocking
>>> framework for the Linux kernel.
>>>
>>> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
>>> it does not require installing the kernel on a test machine or in a VM
>>> and does not require tests to be written in userspace running on a host
>>> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
>>> can run several dozen tests in under a second. Currently, the entire
>>> KUnit test suite for KUnit runs in under a second from the initial
>>> invocation (build time excluded).
>>>
>>> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
>>> Googletest/Googlemock for C++. KUnit provides facilities for defining
>>> unit test cases, grouping related test cases into test suites, providing
>>> common infrastructure for running tests, mocking, spying, and much more.
>>
>> As a result of the emails replying to this patch thread, I am now
>> starting to look at kselftest.  My level of understanding is based
>> on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
>> and a _tiny_ bit of looking at kselftest code.
>>
>> tl;dr; I don't really understand kselftest yet.
>>
>>
>> (1) why KUnit exists
>>
>>> ## What's so special about unit testing?
>>>
>>> A unit test is supposed to test a single unit of code in isolation,
>>> hence the name. There should be no dependencies outside the control of
>>> the test; this means no external dependencies, which makes tests orders
>>> of magnitudes faster. Likewise, since there are no external dependencies,
>>> there are no hoops to jump through to run the tests. Additionally, this
>>> makes unit tests deterministic: a failing unit test always indicates a
>>> problem. Finally, because unit tests necessarily have finer granularity,
>>> they are able to test all code paths easily solving the classic problem
>>> of difficulty in exercising error handling code.
>>
>> (2) KUnit is not meant to replace kselftest
>>
>>> ## Is KUnit trying to replace other testing frameworks for the kernel?
>>>
>>> No. Most existing tests for the Linux kernel are end-to-end tests, which
>>> have their place. A well tested system has lots of unit tests, a
>>> reasonable number of integration tests, and some end-to-end tests. KUnit
>>> is just trying to address the unit test space which is currently not
>>> being addressed.
>>
>> My understanding is that the intent of KUnit is to avoid booting a kernel on
>> real hardware or in a virtual machine.  That seems to be a matter of semantics
>> to me because isn't invoking a UML Linux just running the Linux kernel in
>> a different form of virtualization?
>>
>> So I do not understand why KUnit is an improvement over kselftest.
>>
>> It seems to me that KUnit is just another piece of infrastructure that I
>> am going to have to be familiar with as a kernel developer.  More overhead,
>> more information to stuff into my tiny little brain.
>>
>> I would guess that some developers will focus on just one of the two test
>> environments (and some will focus on both), splitting the development
>> resources instead of pooling them on a common infrastructure.
>>
>> What am I missing?
> 
> kselftest provides no in-kernel framework for testing kernel code
> specifically.  That should be what kunit provides, an "easy" way to
> write in-kernel tests for things.

kselftest provides a mechanism for in-kernel tests via modules.  For
example, see:

  tools/testing/selftests/vm/run_vmtests invokes:
    tools/testing/selftests/vm/test_vmalloc.sh
      loads module:
        test_vmalloc
        (which is built from lib/test_vmalloc.c if CONFIG_TEST_VMALLOC)

A very quick and dirty search (likely to miss some tests) finds modules:

  test_bitmap
  test_bpf
  test_firmware
  test_printf
  test_static_key_base
  test_static_keys
  test_user_copy
  test_vmalloc

-Frank

> 
> Brendan, did I get it right?
> 
> thanks,
> 
> greg k-h
> .
> 

