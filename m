Return-Path: <linux-kselftest+bounces-1410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F83809AA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 04:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163791C208E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96F442D;
	Fri,  8 Dec 2023 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8auVz02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BA10FC;
	Thu,  7 Dec 2023 19:47:06 -0800 (PST)
Message-ID: <620df220-4b82-4102-ba56-1ed348c2f8cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702007224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRG1tZ4BUZmjduFYGxdtrgVWOq3VdOKTbXXj+ZyvQXQ=;
	b=Y8auVz02tjoEIUc5pIn0TwqMEITXkgCR9ncdXJWR54TcaBEplXik5NNufV91wm50W4GLzw
	7VVbQZlJ09/QB7mFD9brVfMbAbi69T7TzFW+6IeSyhOq0FQYFgWkUJTQx0mrIQiA2K16J1
	6fAg53MbC+XKopi+b74uquU794C1NYc=
Date: Thu, 7 Dec 2023 19:46:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
Content-Language: en-GB
To: Kyle Huey <me@kylehuey.com>, Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert O'Callahan <robert@ocallahan.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231207163458.5554-1-khuey@kylehuey.com>
 <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
 <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
 <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 5:08 PM, Kyle Huey wrote:
> On Thu, Dec 7, 2023 at 2:56 PM Kyle Huey <me@kylehuey.com> wrote:
>> On Thu, Dec 7, 2023 at 11:20 AM Marco Elver <elver@google.com> wrote:
>>> On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>> On Thu, Dec 7, 2023 at 8:35 AM Kyle Huey <me@kylehuey.com> wrote:
>>>>> The test sets a hardware breakpoint and uses a bpf program to suppress the
>>>>> side effects of a perf event sample, including I/O availability signals,
>>>>> SIGTRAPs, and decrementing the event counter limit, if the ip matches the
>>>>> expected value. Then the function with the breakpoint is executed multiple
>>>>> times to test that all effects behave as expected.
>>>>>
>>>>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>>>>> ---
>>>>>   .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++++++
>>>>>   .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
>>>>>   2 files changed, 160 insertions(+)
>>>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
>>>>>   create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
>>>>> new file mode 100644
>>>>> index 000000000000..f6fa9bfd9efa
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
>>>>> @@ -0,0 +1,145 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +#define _GNU_SOURCE
>>>>> +
>>>>> +/* We need the latest siginfo from the kernel repo. */
>>>>> +#include <asm/siginfo.h>
>>>> selftests are built with UAPI headers' copies under tools/include, so
>>>> CI did catch a real issue, I think. Try copying
>>>> include/uapi/asm-generic/siginfo.h into
>>>> tools/include/uapi/asm-generic/siginfo.h ?
>>> I believe parts of this were inspired by
>>> tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
>>> kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
>>> CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
>>> it's appropriate for this test though, if you don't want to add
>>> KHDR_INCLUDES for everything.
>> Yes, that's right. Namhyung's commit message for 91c97b36bd69 leads me
>> to believe that I should copy siginfo.h over into tools/include and
>> fix the perf_events self tests too.
>>
>> - Kyle
> That doesn't really help (though perhaps it should be done anyway so
> the selftests aren't reaching into include/) because the glibc headers
> still redefine a ton of stuff in asm-generic/siginfo.h.

Just for testing purpose, I think you can avoid includeasm/siginfo.h and directly define necessary structures in the C file 
directly, right?

>
> - Kyle

