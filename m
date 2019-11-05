Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA13F0333
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbfKEQnX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 11:43:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52527 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbfKEQnW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 11:43:22 -0500
Received: from c-73-130-187-69.hsd1.pa.comcast.net ([73.130.187.69] helo=[172.25.50.30])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mike.salvatore@canonical.com>)
        id 1iS1vL-00023X-4x; Tue, 05 Nov 2019 16:43:19 +0000
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com>
 <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com>
 <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
 <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
From:   Mike Salvatore <mike.salvatore@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mike.salvatore@canonical.com; keydata=
 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
Message-ID: <205525ba-dc2f-34a9-b7dc-4421285535d7@canonical.com>
Date:   Tue, 5 Nov 2019 11:43:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> but such approach is not mainstream.
>> I personally like the idea of testing the lowest level bits in isolation even if
>> they are not a part of any interface. I think that specifying the
>> interface using
>> unit tests and ensuring implementation correctness are complementary but
>> I haven't had much luck arguing this with our esteemed colleagues.

In general, testing public interfaces is preferable, however, I think it's
important to avoid becoming dogmatic. IMHO, it's more important to have tests
that are clear in what they test than to not write tests (or write confusing
tests) in order to adhere to a generalized principle.

> So I think this is a very subtle point which is very widely
> misunderstood. Most people write code and then write their tests,
> following this practice along with only testing public interfaces
> often causes people to just not test all of their code, which is
> wrong.

The very nature of this situation is that the code was written before the tests.

> The idea of only testing public interfaces is supposed to make people
> think more carefully about what the composite layers of the program
> is. If you are having difficulty getting decent coverage by only
> testing your public interfaces, then it likely tells you that you have
> one of two problems:
> 
> 1) You have code that you don't need, and you should remove it.
> 
> 2) One of the layers in your program is too think, and you should
> introduce a new layer with a new public interface that you can test
> through.
> 
> I think the second point here is problematic with how C is written in
> the kernel. We don't really have any concept of public vs. private
> inside the kernel outside of static vs. not static, which is much more
> restricted.

I don't think we can expect developers to refactor large portions of complex
kernel code in order to improve its testability. I imagine this will happen
naturally over time, but I think we need to allow for developers to test
"private" code in the meanwhile.

My opinion is that it's more important to have tests than not. As evidence, I
submit the following commit:
https://github.com/torvalds/linux/commit/156e42996bd84eccb6acf319f19ce0cb140d00e3.

While not a major bug, this bug was discovered as a direct result of writing
these unit tests. So, in summary, I see value in "testing the lowest level bits
in isolation", even if it doesn't necessarily represent the Gold Standard in
Unit Testing.

