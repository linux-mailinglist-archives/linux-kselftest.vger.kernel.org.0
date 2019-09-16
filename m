Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D41B3EC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfIPQUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfIPQUa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:20:30 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E60A20678;
        Mon, 16 Sep 2019 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568650829;
        bh=maSxzYrr5pFG2qKQV/ihmvMZ8wDG7ArRqAZ2PSyd/r8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bRMxbQwgLFd4uU5UwHSxFBT1WYtGzYMJ+T9V0iIiB0AZBcMQOFseRdwDmdE0kJ1A/
         fLLh2fz7IskVKzZlhhQ/FiwYgADsS3BLbYDBgTArkDEX9EFG7I8WL0rOWfC2R6h0KH
         MMHdrW+Ti8D/plcrZJWegfGH66M6YVfxQlM30p2g=
Subject: Re: Plan for hybrid testing
To:     Brendan Higgins <brendanhiggins@google.com>,
        Knut Omang <knut.omang@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190913210247.GA86838@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <9db4c7b4-f8f1-083e-5e3a-d195d4d6a5d6@kernel.org>
Date:   Mon, 16 Sep 2019 10:20:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913210247.GA86838@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Brendan,

On 9/13/19 3:02 PM, Brendan Higgins wrote:
> Hey Knut and Shuah,
> 
> Following up on our offline discussion on Wednesday night:

Awesome. Thanks for doing this.

> 
> We decided that it would make sense for Knut to try to implement Hybrid
> Testing (testing that crosses the kernel userspace boundary) that he
> introduced here[1] on top of the existing KUnit infrastructure.
> 
> We discussed several possible things in the kernel that Knut could test
> with the new Hybrid Testing feature as an initial example. Those were
> (in reverse order of expected difficulty):
> 
> 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
>     one of the more complicated subsystems to work with, it was probably
>     the best candidate for Knut to start with because it was in desperate
>     need of better testing, much of the testing would require crossing
>     the kernel userspace boundary to be effective, and Knut has access to
>     RDS (since he works at Oracle).
> 
> 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
>     Chamberlain (CC'ed) would like to see better testing here, but
>     probably still not as good as RDS because it is in less dire need of
>     testing, collaboration on this would be more difficult, and Luis is
>     currently on an extended vacation. Luis and I had already been
>     discussing testing KMOD here[2].
> 
> 3. IP over USB - Least desirable option, but still possible. More
>     complicated than KMOD, and not as easy to collaborate on as RDS.
> 
> I don't really think we discussed how this would work. I remember that I
> mentioned that it would be easier if I sent out a patch that
> centralizes where KUnit tests are dispatched from in the kernel; I will
> try to get an RFC for that out, probably sometime next week. That should
> provide a pretty straightforward place for Knut to move his work on top
> of.
> 

That will be awesome.

> The next question is what the userspace component of this should look
> like. To me it seems like we should probably have the kselftest test
> runner manage when the test gets run, and collecting and reporting the
> result of the test, but I think Knut has thought more about this than I,
> and Shuah is the kselftest maintainer, so I am guessing this will
> probably mostly be a discussion between the two of you.
> 

Yes. This is what I have in mind.

> So I think we have a couple of TODOs between us:
> 
> Brendan:
>   - Need to send out patch that provides a single place where all tests
>     are dispatched from.
> 
> Knut:
>   - Start splitting out the hybrid test stuff from the rest of the RFC
>     you sent previously.
> 
> Knut and Shuah:
>   - Start figuring out what the userspace component of this will look
>     like.
> 

Once Knut decides which one of the above options he chooses and sends me
RFC patches, we can start discussing the details based on the RFC.

thanks,
-- Shuah
