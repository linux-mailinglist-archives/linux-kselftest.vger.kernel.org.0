Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9271E50D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 00:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgE0WBh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 18:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0WBg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 18:01:36 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733CD207D8;
        Wed, 27 May 2020 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590616895;
        bh=W4hqXD3cjR68Bi5sn+CzcARAdJPyDA8aLp+bLDblw/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l9ZZpgkTsr82LehY7TOERst8D9yCShSnXO2eIN+JH3AXvoUp0M3TqRycPtmfMZPVy
         QRmBy3ZMIM7tD1IPfwfMfDqZ4ZTFjXOIS0NuXqdd53TTGXrx9AG4zxZeZ+tgdox/Dz
         1lpnQOTg/oowWpHP6GknP73juwSTWBimCwklrLUA=
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <xuny367so4k3.fsf@redhat.com>
 <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
 <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
 <xunya71uosvv.fsf@redhat.com>
 <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
Date:   Wed, 27 May 2020 16:01:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/27/20 11:05 AM, Alexei Starovoitov wrote:
> On Wed, May 27, 2020 at 10:02 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
>>
>> Hi, Alexei!
>>
>>>>>>> On Wed, 27 May 2020 09:48:04 -0700, Alexei Starovoitov  wrote:
>>
>>   > On Wed, May 27, 2020 at 12:19 AM Yauheni Kaliuta
>>   > <yauheni.kaliuta@redhat.com> wrote:
>>   >>
>>   >> Hi, Alexei!
>>   >>
>>   >> >>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:
>>   >>
>>   >> > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
>>   >> > <yauheni.kaliuta@redhat.com> wrote:
>>   >> >>
>>   >> >> Hi, Andrii!
>>   >> >>
>>   >> >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
>>   >> >>
>>   >> >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
>>   >> >> > <yauheni.kaliuta@redhat.com> wrote:
>>   >> >> >>
>>   >> >> >> There is difference in depoying static and generated extra resource
>>   >> >> >> files between in/out of tree build and flavors:
>>   >> >> >>
>>   >> >> >> - in case of unflavored out-of-tree build static files are not
>>   >> >> >> available and must be copied as well as both static and generated
>>   >> >> >> files for flavored build.
>>   >> >> >>
>>   >> >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
>>   >> >> >> is chosen in analogy to TEST_GEN_* variants.
>>   >> >> >>
>>   >> >>
>>   >> >> > Can we keep them together but be smarter about what needs to
>>   >> >> > be copied based on source/target directories? I would really
>>   >> >> > like to not blow up all these rules.
>>   >> >>
>>   >> >> I can try, ok, I just find it a bit more clear. But it's good to
>>   >> >> get some input from kselftest about OOT build in general.
>>   >>
>>   >> > I see no value in 'make install' of selftests/bpf
>>   >> > and since it's broken just remove that makefile target.
>>   >>
>>   >> Some CI systems perform testing next stage after building were
>>   >> build tree is not available anymore. So it's in use at the
>>   >> moment.
>>
>>   > such CI systems can do 'cp -r' then
>> >> It's a discussion for linux-kselftest@ (added).
>>
>> At the moment `make install` is generic kselftest functionality
>> and since bpf is part of that infra it looks a bit strange to
>> break it intentionally.
> 
> selftests/bpf is only historically part of selftests.
> It probably should stop using kselftest build infra all together.
> We had breakages in selftests/bpf in the past only because
> of changes in kselftests bits.
> 

The question is whether or not the breakages addresses quickly.
Also, bpf keels breaking ksleftest builds and installs because
it has dependencies on bleeding edge tools and causes problems
for kselftest users.

You are pulling me into the discussion midway and I am missing the
context for the discussion. There is another thread on this topic
where Yauheni and I have been talking about bpf install.

I would say bpf install has never really worked from kselftest
install mechanism.

Ideally all tests use kselftest common install rule to leverage
the install and not have users do individual test installs.
It isn't productive and cooperative to say let's have bpf test
do its thing. It is part of selftests and we have to figure out
how to have it consistently build and run.

It isn't building for me on Linux 5.7-rc7 at the moment, leave
alone install.

The test Makefile has to handle OUTPUT directory. Please add me
to the entire patch series especially if it changes selftests
Makefile and lib.mk. I will review and try to see if we can make
bpf install work under kselftest common infrastructure.

I recently fixed bugs in kvm test Makefile to address the install
problems for cross-builds.

thanks,
-- Shuah
