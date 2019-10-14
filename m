Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741F2D69D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfJNTB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 15:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfJNTB4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 15:01:56 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B05206A3;
        Mon, 14 Oct 2019 19:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571079715;
        bh=v0P3jCH9m4OlR1IqxDWMCSz3uyJCav3I/AXtUoY+K2Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=doWmsBEhsUJtwnvXPxN61ojXtsnLwR3e6JswVvRkW2JkCuCc0Fak19JTa92JUm3d0
         ybOIeIxR0InfXQwJVl1EGqCgdU6i7wfq2zbEwRbSQBf6oLoWb84R+DeF0MfZNSAEtH
         QeCL7jEmdGbXDeZE4BXdAwirxcO5AR5iY9SvAB1E=
Subject: Re: Plan for hybrid testing
To:     Knut Omang <knut.omang@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        shuah <shuah@kernel.org>
References: <20190913210247.GA86838@google.com>
 <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
Date:   Mon, 14 Oct 2019 13:01:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/14/19 12:38 PM, Knut Omang wrote:
> On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
>> On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
>>> Hey Knut and Shuah,
>>>
>>> Following up on our offline discussion on Wednesday night:
>>>
>>> We decided that it would make sense for Knut to try to implement Hybrid
>>> Testing (testing that crosses the kernel userspace boundary) that he
>>> introduced here[1] on top of the existing KUnit infrastructure.
>>>
>>> We discussed several possible things in the kernel that Knut could test
>>> with the new Hybrid Testing feature as an initial example. Those were
>>> (in reverse order of expected difficulty):
>>>
>>> 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
>>>     one of the more complicated subsystems to work with, it was probably
>>>     the best candidate for Knut to start with because it was in desperate
>>>     need of better testing, much of the testing would require crossing
>>>     the kernel userspace boundary to be effective, and Knut has access to
>>>     RDS (since he works at Oracle).
>>>

Any update on if you are able to explore this work.

>>> 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
>>>     Chamberlain (CC'ed) would like to see better testing here, but
>>>     probably still not as good as RDS because it is in less dire need of
>>>     testing, collaboration on this would be more difficult, and Luis is
>>>     currently on an extended vacation. Luis and I had already been
>>>     discussing testing KMOD here[2].
>>
>> I'm back!
>>
>> I'm also happy and thrilled to help review the infrastructure in great
>> detail given I have lofty future objectives with testing in the kernel.
>> Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
>> target I think test_sysctl.c would be a good target. I think the goal
>> there would be to add probes for a few of the sysctl callers, and then
>> test them through userspace somehow, for instance?
> 
> That sounds like a good case for the hybrid tests.
> The challenge in a kunit setting would be that it relies on a significant part of KTF
> to work as we have used it so far:
> 
> - module support - Alan has been working on this

I see the patches. Thanks for working on this.

> - netlink approach from KTF (to allow user space execution of kernel
>    part of test, and gathering reporting in one place)
> - probe infrastructure
> 
>> The complexities with testing kmod is the threading aspect. So that is
>> more of a challenge for a test infrastructure as a whole. However kmod
>> also already has a pretty sound kthread solution which could be used
>> as basis for any sound kernel multithread test solution.
>>
>> Curious, what was decided with the regards to the generic netlink approach?
> 

Can this work be be done without netlink approach? At least some of it.
I would like to see some patches and would like to get a better feel
for the dependency on generic netlink.

> I think in some way functionality similar to the netlink support is needed
> for the features in KTF that we discussed, so I get it is a "yes" to add
> support for it?
> 

See above.

thanks,
-- Shuah

