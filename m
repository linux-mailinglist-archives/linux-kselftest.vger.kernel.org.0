Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBE185032
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMUVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 16:21:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:48456 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMUVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 16:21:03 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCqnk-0000G8-Gk; Fri, 13 Mar 2020 21:21:00 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jCqnk-0009P1-68; Fri, 13 Mar 2020 21:21:00 +0100
Subject: Re: [PATCH bpf-next] tools/bpf: move linux/types.h for selftests and
 bpftool
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>, arnaldo.melo@gmail.com
References: <20200313113105.6918-1-tklauser@distanz.ch>
 <CAEf4BzZS9mrJAhQaDOXvYG+3Hob0ntRu3rWNffHTJ82TDN6x6A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5beb49b7-f73e-5160-38ce-1087e7ee75dc@iogearbox.net>
Date:   Fri, 13 Mar 2020 21:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZS9mrJAhQaDOXvYG+3Hob0ntRu3rWNffHTJ82TDN6x6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25750/Fri Mar 13 14:03:09 2020)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ +acme ]

On 3/13/20 5:52 PM, Andrii Nakryiko wrote:
> On Fri, Mar 13, 2020 at 4:31 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>>
>> Commit fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for
>> profiler build") added a build dependency on tools/testing/selftests/bpf
>> to tools/bpf/bpftool. This is suboptimal with respect to a possible
>> stand-alone build of bpftool.
>>
>> Fix this by moving
>> tools/testing/selftests/bpf/include/uapi/linux/types.h to
>> tools/include/uapi/linux/types.h
>>
>> This requires an adjustment in the include search path order for the
>> tests in tools/testing/selftests/bpf so that tools/include/linux/types.h
>> is selected when building host binaries and
>> tools/include/uapi/linux/types.h is selected when building bpf binaries.
>>
>> Verified by compiling bpftool and the bpf selftests on x86_64 with this
>> change.
> 
> Thanks for following up!
> 
> My only concern is that tools/include/uapi/ is also used at least by
> perf and libperf, we need to double check that they are fine with this
> as well.
> 
> Given this is needed for BPF target compilation only, one way to limit
> the scope of this change would be to have a `#if defined(__bpf__)`
> check and falling back to "normal" uapi/linux/types.h. Alternatively,
> we could have a bpf-specific subdirectory and put this header into
> tools/include/bpf/uapi/linux/types.h.
> 
> I don't have any strong preferences, whatever maintainers are happy with.

I would prefer to keep it generic if possible before we take measures of
making special cases for bpf in tools include infra. Compilation of perf
and libperf seems fine on my side as well, so I've applied it, thanks!
