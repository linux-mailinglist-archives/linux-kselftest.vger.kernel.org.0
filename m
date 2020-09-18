Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E726F4C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 05:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIRDhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 23:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgIRDhn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 23:37:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E78C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 20:37:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bt0035J9Yz9sRR;
        Fri, 18 Sep 2020 13:37:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600400259;
        bh=f+WI+4Y5FqCAKO5vI/9vI4pfQazkTL/VYPrdXvYY8fc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d/6/w5s6c9CO1f97Mol+q4eV4zfmEBkZqG2s4JuhiDKVhnNJWc5BrI+ZbKp2yPZXm
         rLb+teRkc65mrjjFi+LJg8GF0cteV4C/iDp1HzFSLeUK/dNWZ3umckQ0LclSP5GfeG
         waXRmi+DsFeLUFM7gpHcWFKIe9HGtH6ZDQe9EAnZM07N5jAVZCuKaHCqI8KjRYysWi
         yVQZJJEDSU7s3+hfcQvRZdbs+BJ0EtylUCIAncVEyAzhORUMv9qVlvP2du5Im7ucvi
         TlSUp4EMTrAqCyJPK066nR0sZ0PVZ+VvAODpl4clbLW+MKNT7nn8a0aWOfx6Rk0ZOW
         b2AGwACZctcDw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
In-Reply-To: <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
References: <20200917041519.3284582-1-mpe@ellerman.id.au> <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com> <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
Date:   Fri, 18 Sep 2020 13:37:33 +1000
Message-ID: <87o8m3oiv6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 9/16/20 10:53 PM, Max Filippov wrote:
>> On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>
>>> The test harness forks() a child to run each test. Both the parent and
>>> the child print to stdout using libc functions. That can lead to
>>> duplicated (or more) output if the libc buffers are not flushed before
>>> forking.
>>>
>>> It's generally not seen when running programs directly, because stdout
>>> will usually be line buffered when it's pointing to a terminal.
>>>
>>> This was noticed when running the seccomp_bpf test, eg:
>>>
>>>    $ ./seccomp_bpf | tee test.log
>>>    $ grep -c "TAP version 13" test.log
>>>    2
>>>
>>> But we only expect the TAP header to appear once.
>>>
>>> It can be exacerbated using stdbuf to increase the buffer size:
>>>
>>>    $ stdbuf -o 1MB ./seccomp_bpf > test.log
>>>    $ grep -c "TAP version 13" test.log
>>>    13
>>>
>>> The fix is simple, we just flush stdout & stderr before fork. Usually
>>> stderr is unbuffered, but that can be changed, so flush it as well
>>> just to be safe.
>>>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>   tools/testing/selftests/kselftest_harness.h | 5 +++++
>>>   1 file changed, 5 insertions(+)
>> 
>> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Thank you both. Applying to linux-kselftest fixes for 5.9-rc7

It can wait for v5.10 IMHO, but up to you.

cheers
