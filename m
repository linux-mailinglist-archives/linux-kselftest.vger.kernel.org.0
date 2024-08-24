Return-Path: <linux-kselftest+bounces-16206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CB95DD63
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A69283715
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28783155A52;
	Sat, 24 Aug 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJQAtUrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69361BDDB;
	Sat, 24 Aug 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724495847; cv=none; b=U/MfATElCzX6C7H4le59PE63aiel2AwUKvEjSsUvHPTgwkxVU19y9k09HHxfIvPyiCWDFqe3RBYdjWqrlOuUFrvv4ASlXrgOvcKplFi3d2x1jzOyPMCeKvwaHy56q7b+2u9P+gae/NijoD/Rt4sd1tXDhEUQoA3KPyFf7Ol+ZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724495847; c=relaxed/simple;
	bh=q+x8G2jarjJ6qOxoQeX3ujnPs9B2vsWfrT5NzufbFGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkPBVSdD1/y1NdPrRGfAJS42M3BCozRQs7Pw440ShMqfritv+Gf0rDNp2R94rF6L0JOykOzWB4AYSIv8GgET/eRJ4xbhR4WXdaGNBTLKuGbT+278LQ8eEhgwWcOgSlckD5iw7l4gilzSkgHzaMQveAndFHKhPTI8dbNvkCb/0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJQAtUrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA69C32781;
	Sat, 24 Aug 2024 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724495846;
	bh=q+x8G2jarjJ6qOxoQeX3ujnPs9B2vsWfrT5NzufbFGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EJQAtUrbhOy7vciZu8iBogR8n1EACYNOsSE+6eCIVgup98erFbCRpJlBbep/RRcYx
	 tt8L4mxCH5evJraZSLS/ASNkhay8onSK7Ulh/JGTMfQo77iyx4ohiJmNZoWkoJ7qzD
	 LPv0pczTtewjezuWbuXvFS+5hdOgm8Y4yX/VeOgI84w9UyQlRJ4o2OdXYcVS28tFcL
	 Klq6s2AUyY3PhaL0UlxBbU0JIUjhyGHvqmJ2seFwS3CraeNhF1AMTr6f8tE0Wr4yHI
	 u/02DsaeDxZQBUE5fWr6sPSWYlhiAJnTUYzhpTflkfumMKnLYOQ1VysdrScCMMtGU0
	 8/lij3wRx8YNw==
Message-ID: <41ef2c53-600a-47d6-a35f-674e1e7860f8@kernel.org>
Date: Sat, 24 Aug 2024 12:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
 <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
 <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
 <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for your reply!

On 24/08/2024 00:28, Alexei Starovoitov wrote:
> On Sat, Aug 17, 2024 at 7:51 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Alexei,
>>
>> Thank you for the review.
>>
>> On 17/08/2024 09:22, Alexei Starovoitov wrote:
>>> On Fri, Aug 16, 2024 at 7:56 PM Matthieu Baerts (NGI0)
>>> <matttbe@kernel.org> wrote:
>>>>
>>>> Instead of duplicating UAPI header files in 'tools/include/uapi', the
>>>> BPF selftests can also look at the header files inside the kernel
>>>> source.
>>>>
>>>> To do that, the kernel selftests infrastructure provides the
>>>> 'KHDR_INCLUDES' variable. This is what is being used in most selftests,
>>>> because it is what is recommended in the documentation [1]. If the
>>>> selftests are not executed from the kernel sources, it is possible to
>>>> override the variable, e.g.
>>>>
>>>>   make KHDR_INCLUDES="-I${HDR_DIR}/include" -C "${KSFT_DIR}"
>>>>
>>>> ... where ${HDR_DIR} has been generated by this command:
>>>>
>>>>   make headers_install INSTALL_HDR_PATH="${HDR_DIR}"
>>>>
>>>> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
>>>> files for userspace test programs, and these programs can include UAPI
>>>> header files without the 'uapi' prefix.
>>>>
>>>> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
>>>> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF programs,
>>>> not to conflict with what is already defined in vmlinux.h.
>>>>
>>>> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details [1]
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/bpf/Makefile                       | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
>>>>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
>>>>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
>>>>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
>>>>  12 files changed, 14 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index 4eceb491a8ae..6a7aeae7e206 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic                                   \
>>>>           -Wall -Werror -fno-omit-frame-pointer                         \
>>>>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>>>>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>>>> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>>>> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>>>>  LDFLAGS += $(SAN_LDFLAGS)
>>>>  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>>>> index 989ee4d9785b..3d06bf5a1ba4 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>>>> @@ -1,6 +1,6 @@
>>>>  // SPDX-License-Identifier: GPL-2.0
>>>>  /* Copyright (c) 2023 Isovalent */
>>>> -#include <uapi/linux/if_link.h>
>>>> +#include <linux/if_link.h>
>>>
>>> No. This is not an option.
>>> User space shouldn't include kernel headers like this.
>>> Long ago tools/include directory was specifically
>>> created to break such dependency.
>>> Back then it was done for perf.
>>
>> I'm sorry, but I think we are not talking about the same thing here:
>> here, I'm only modifying the "normal" userspace programs, not the ones
>> used to generate the BPF objects. Perf is a special case I suppose, it
>> needs to know the kernel internals. It is the same with BPF programs
>> requiring vmlinux.h. But I think "normal" userspace programs in the
>> sefltests can use the UAPI headers, no?
> 
> Not really. perf is a normal user space that doesn't look into
> kernel internals.
> It's used to rely on a few .h from kernel src tree for convenience,
> since they're not present in what's installed after 'make headers'.
> Hence the tools/include dir was created.
> 
> Using KHDR_INCLUDES is fine, but it's not ok to search replace
> s/uapi\/linux/linux/ everywhere.
> Like the example I quoted above.
> tools/.../if_link.h is much older than include/uapi/linux/if_link.h
> and it's ok.
> We're not planning to update it.
> It's like building selftests on the system with older glibc.
> There is no requirement to have every .h in the tools/ dir
> up-to-date with the latest in include/.

OK, sorry, I didn't know it was fine not to have them up-to-date.

KSelftests doc indicates that it is important to use the headers from
'make headers' to be able to find regressions in these header files. But
thanks to your comment below, I now understand bpf selftests are not
really kselftests.

> We're doing it for bpf.h because new selftests typically need
> something from bpf.h that was just added in the previous patch.

OK. Then, if I understand correctly, this doesn't apply to if_xdp.h, and
we can remove the warning mentioning this file is out-of-date, but not
remove the duplicated header file. This file in tools/include/uapi is a
snapshot of an old version on purpose, no need to warn people it is not
up-to-date then.

>> I understand that I could indeed fix my initial problem by duplicating
>> mptcp.h in tools/include/uapi/linux/, but this doesn't look to be
>> allowed any more by the Netdev maintainers, e.g. recently, 'ethtool.h'
>> has been duplicated there in commit 7effe3fdc049 ("tools: Add ethtool.h
>> header to tooling infra"), but removed quickly after in commit
>> bbe91a9f6889 ("tools: remove redundant ethtool.h from tooling infra").
>> In this case, it was fine to simply drop it, because the linked test
>> doesn't require a recent version. Jakub mentioned [4] that these
>> duplicated headers should be avoided, and the ones generated by 'make
>> headers' should be used instead: what is being suggested here.
> 
> This is a different issue. There are very few .h in tools/ that
> needs a sync.
> bpf.h is one of them. ethtool.h is certainly not.
> 
> you need something for mpctp.h. Let's talk about it,
> but switching everything to KHDR_INCLUDES is not ok,
> since there are a bunch of things in play.
> Sometimes selftests are built standalone and with non-glibc-s.

I didn't know there would be issues to use the latest version of the
UAPI headers. It was fine on my side, but indeed, I didn't check all the
possible combinations. Without [1], I cannot ask the BPF CI to check.
Fine not to switch everything to KHDR_INCLUDES then.

Now that the CI runners have been updated to use Ubuntu 24.04 [1], we
can use mptcp.h from the system headers, or do some actions via
IPRoute2. So not having KHDR_INCLUDES is no longer blocking us for the
moment. I think it might still be useful to add it for future use, and
also to use the latest version of the UAPI headers that are not in
'tools/include/uapi', but I don't want to insist if you prefer not to
use the latest version.

[1] https://github.com/libbpf/ci/pull/131
[2]
https://lore.kernel.org/bpf/364C4C5B-27A0-4210-84E2-8CA9867E4127@meta.com/

> Also realize that bpf selftests are not really kselftests.
> We use a few common .mk for convenience. That's about it.

OK, sorry, I didn't know about that! That explains why they cannot be
used like the other ones.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


