Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65596113E72
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfLEJom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:44:42 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39985 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfLEJol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575539080; x=1607075080;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XA3oZWOd5asy5rioRAKyGk2s02rOKwV9Udl1+L/1v4E=;
  b=GWaaIsrga2Wf7razKIk59blu9cEsQGKQNnXACz7FAGJBOwqKzXknve+N
   /rz2OBVx2bnMomjpn3m+/l4QSGtpbSPjrbwUnHqyM80rW+z8AMzsLozJ7
   SuLVducC5dB/cuMAKV105qlfruw8lPSm8xO0KBCCP7pqTIUysQtL5EDdb
   s=;
IronPort-SDR: oN9E6e02wCm8LbHFJfX4TowVWG/UGsHK2KJGpM9LCOW/lsg4WGpaDkCS0sw0RtFBGy5/0lIxHY
 axKXhaQXUPTw==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="7245714"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Dec 2019 09:44:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 9CB0CA1F5E;
        Thu,  5 Dec 2019 09:44:37 +0000 (UTC)
Received: from EX13D22UEA003.ant.amazon.com (10.43.61.147) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:44:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D22UEA003.ant.amazon.com (10.43.61.147) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:44:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.28.85.76) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 09:44:35 +0000
Subject: Re: [PATCH v3 0/5] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
 <20191204192141.GA247851@google.com>
 <CAEjAshrXG3GmNMAS6Upu0=cCe9KJxchQWeiqLg0b8kif9ivNTg@mail.gmail.com>
 <CAEjAshpQNVdLgtLyTu5WjxygRptZ4qomKCQaxw1YaX5ppvBcNQ@mail.gmail.com>
From:   <sjpark@amazon.com>
Message-ID: <68b23584-c82f-68b7-f428-5b6a0738e072@amazon.com>
Date:   Thu, 5 Dec 2019 10:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjAshpQNVdLgtLyTu5WjxygRptZ4qomKCQaxw1YaX5ppvBcNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04.12.19 21:28, SeongJae Park wrote:
> On Wed, Dec 4, 2019 at 9:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>> On Wed, Dec 4, 2019 at 8:21 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>> On Tue, Dec 03, 2019 at 02:41:26PM -0800, Brendan Higgins wrote:
>>>> On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
>>>>> This patchset contains trivial fixes for the kunit documentations and the
>>>>> wrapper python scripts.
>>>>>
>>>>> Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
>>>>>  - Make 'build_dir' if not exists (missed from v3 by mistake)
>>>>>
>>>>> SeongJae Park (5):
>>>>>   docs/kunit/start: Use in-tree 'kunit_defconfig'
>>>>>   kunit: Remove duplicated defconfig creation
>>>>>   kunit: Create default config in '--build_dir'
>>>>>   kunit: Place 'test.log' under the 'build_dir'
>>>>>   kunit: Rename 'kunitconfig' to '.kunitconfig'
>>>>>
>>>>>  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
>>>>>  tools/testing/kunit/kunit.py            | 16 ++++++++++------
>>>>>  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
>>>>>  3 files changed, 19 insertions(+), 18 deletions(-)
>>>> Tested-by: Brendan Higgins <brendanhiggins@google.com>
>>> I just realized that I forgot to test for something...
>>>
>>> The following command fails:
>>>
>>> ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig
>>>
>>> [11:17:13] Building KUnit Kernel ...
>>> [11:17:16] Starting KUnit Kernel ...
>>> Traceback (most recent call last):
>>>   File "tools/testing/kunit/kunit.py", line 142, in <module>
>>>     main(sys.argv[1:])
>>>   File "tools/testing/kunit/kunit.py", line 135, in main
>>>     result = run_tests(linux, request)
>>>   File "tools/testing/kunit/kunit.py", line 67, in run_tests
>>>     test_result = kunit_parser.parse_run_tests(kunit_output)
>>>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 283, in parse_run_tests
>>>     test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>>>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 54, in isolate_kunit_output
>>>     for line in kernel_output:
>>>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_kernel.py", line 146, in run_kernel
>>>     with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>>>   File "/usr/lib/python3.7/posixpath.py", line 80, in join
>>>     a = os.fspath(a)
>>> TypeError: expected str, bytes or os.PathLike object, not NoneType
>>>
>>> It seems as though you assume that build_dir is always populated by the flag.
>> Sorry for not checking the case.  The 4th patch, "kunit: Place 'test.log' under
>> the 'build_dir'" made the bug.  I fixed the 4th patch and tested with below
>> commands:
>>
>>     ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12
>> --defconfig --build_dir .kunit
>>     ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig
>>
>> Just sent the 4th version patchset including the fix:
>>     http://lkml.kernel.org/r/1575490683-13015-1-git-send-email-sj38.park@gmail.com
> Also, removed the 'Reviewed-by' from the 4th patch and didn't add 'Tested-by'
> to the patchset.
>
>
> Thanks,
> SeongJae Park
>
>> I will consider adding some tests that can check such cases in the
>> 'kunit_tools_test.py' later.

I just sent 5th version which includes this change and a fix:
https://lore.kernel.org/linux-kselftest/20191205093440.21824-1-sjpark@amazon.com


Thanks,
SeongJae Park

>>
>>
>> Thanks,
>> SeongJae Park


