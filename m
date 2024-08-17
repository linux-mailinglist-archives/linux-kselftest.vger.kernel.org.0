Return-Path: <linux-kselftest+bounces-15582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A995586D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD25C1C20B42
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC81B677;
	Sat, 17 Aug 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRPV0IqE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175048BF0;
	Sat, 17 Aug 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906268; cv=none; b=DInFCgbhtifXZtJ/D6qFnaySWK/1+U3GxTpIswbdEuCANkf4mmAEupu/sbQe73waCKPk5w3S49YCHxqTlXOMvtsa1NjuY5eZ0kx4bhYn5wyCee0H2q+JUGO0RVt82IVd1VDn1XSa12l82RxtkMoUF1pE3RlP4mGCgsgpG96PwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906268; c=relaxed/simple;
	bh=xX30yY9QWtJC/hwv9MWYyIBUgw+j0dFH2V19RSTRVXQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lQrLxYOgXVkgxN/qjGH3Rffg2/i1f6gIY/t1JRefaz7gXfBLWHKXFZH2B0Op5ooBfndXw+DsAMjf0jvh+bKDScIVeaiOGVUppuzOEyYAmv54WvBNKO6QB7dXgWca9VxONZEW5kby1fMJ1ArEIj/GcvZ0vds2fAYzJsgXkZ8LE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRPV0IqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01618C116B1;
	Sat, 17 Aug 2024 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723906267;
	bh=xX30yY9QWtJC/hwv9MWYyIBUgw+j0dFH2V19RSTRVXQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=gRPV0IqEqa4Qs27n1S195VCMTcTx1mU2J1tALiRBfzU4kdk3zWYo1JaCTfgdRgSSM
	 o2+48dM/thpP5UgxRqVkZH5v3b567X7G4cZMd3fu7mndSjkiCyBF/+RGuCrJmgnmSo
	 QgyXSjP7Q/wb6YTPnU910/lfRtbwita8W6/AI9o2+9bHwEcSIdTyUYLNn2pmUqbG1b
	 +3PQ0adzHY8YsjngYiqqdVEDTm0a9j5A/bBtkRW8GTIqA/0iBof6X/kcizhbqgSenw
	 DKviEBhdKNcs2v0fFAI4e0hpMlY4hMbsEf5D3ZTfAv78W0yE7jqXqtu7p5/W+rKu3P
	 RXQQU2qfA+Leg==
Message-ID: <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
Date: Sat, 17 Aug 2024 16:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
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
Content-Language: en-GB
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the review.

On 17/08/2024 09:22, Alexei Starovoitov wrote:
> On Fri, Aug 16, 2024 at 7:56 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> Instead of duplicating UAPI header files in 'tools/include/uapi', the
>> BPF selftests can also look at the header files inside the kernel
>> source.
>>
>> To do that, the kernel selftests infrastructure provides the
>> 'KHDR_INCLUDES' variable. This is what is being used in most selftests,
>> because it is what is recommended in the documentation [1]. If the
>> selftests are not executed from the kernel sources, it is possible to
>> override the variable, e.g.
>>
>>   make KHDR_INCLUDES="-I${HDR_DIR}/include" -C "${KSFT_DIR}"
>>
>> ... where ${HDR_DIR} has been generated by this command:
>>
>>   make headers_install INSTALL_HDR_PATH="${HDR_DIR}"
>>
>> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
>> files for userspace test programs, and these programs can include UAPI
>> header files without the 'uapi' prefix.
>>
>> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
>> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF programs,
>> not to conflict with what is already defined in vmlinux.h.
>>
>> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/bpf/Makefile                       | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
>>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
>>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
>>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
>>  12 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 4eceb491a8ae..6a7aeae7e206 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic                                   \
>>           -Wall -Werror -fno-omit-frame-pointer                         \
>>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>>  LDFLAGS += $(SAN_LDFLAGS)
>>  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>> index 989ee4d9785b..3d06bf5a1ba4 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /* Copyright (c) 2023 Isovalent */
>> -#include <uapi/linux/if_link.h>
>> +#include <linux/if_link.h>
> 
> No. This is not an option.
> User space shouldn't include kernel headers like this.
> Long ago tools/include directory was specifically
> created to break such dependency.
> Back then it was done for perf.

I'm sorry, but I think we are not talking about the same thing here:
here, I'm only modifying the "normal" userspace programs, not the ones
used to generate the BPF objects. Perf is a special case I suppose, it
needs to know the kernel internals. It is the same with BPF programs
requiring vmlinux.h. But I think "normal" userspace programs in the
sefltests can use the UAPI headers, no?

Here, the BPF userspace programs will take the kernel headers generated
by 'make headers', not directly from 'include/uapi' in the source.
That's what is done in other kernel selftests, and what is documented in
the kselftests doc [1]. With this modification, I'm able to compile the
BPF selftests.

I see that the BPF CI didn't manage to build them, but I think that's
because it sets 'KBUILD_OUTPUT', and build the BPF selftests directly,
not via the 'tools/testing/selftests/Makefile', which is the recommended
way, which supports 'KBUILD_OUTPUT'. Please see [2] for a fix for the
BPF CI.



A bit of context: my goal here is to be able to add new BPF selftests to
cover cases where BPF is used to modify MPTCP sockets and subflows. To
setup these tests, we need to communicate with the kernel, either by
using IPRoute2 -- but the BPF CI is still using IPRoute2 5.5 from
pre-COVID time -- or with a dedicated userspace program. This program
[2] has nothing special, it needs to include <linux/mptcp.h> to get the
value of some defines and enums to be able to communicate with the
kernel via Netlink. If I want to compile this program on my system,
outside the kselftest, the compiler will use the file from
'/usr/include/linux/mptcp.h', coming from the kernel UAPI. When
validating new features in the selftests, it will use the version from
the kernel source, the result of a 'make headers'. That works fine, we
don't have to duplicate the MPTCP UAPI header file when building the
MPTCP selftests. Same with the other selftests. Without this patch, I
would need to duplicate the 'mptcp.h' header if I want to use the same
program in the BPF selftests, because KHDR_INCLUDES is not used in the
CFLAGS when compiling the userspace programs like everywhere else in the
selftests.

I understand that I could indeed fix my initial problem by duplicating
mptcp.h in tools/include/uapi/linux/, but this doesn't look to be
allowed any more by the Netdev maintainers, e.g. recently, 'ethtool.h'
has been duplicated there in commit 7effe3fdc049 ("tools: Add ethtool.h
header to tooling infra"), but removed quickly after in commit
bbe91a9f6889 ("tools: remove redundant ethtool.h from tooling infra").
In this case, it was fine to simply drop it, because the linked test
doesn't require a recent version. Jakub mentioned [4] that these
duplicated headers should be avoided, and the ones generated by 'make
headers' should be used instead: what is being suggested here.

Do you think it would not work? If not, any idea what I can do?
Duplicating the defines and enums I need in the .c file doesn't seem
like a nice solution either.

[1] https://docs.kernel.org/dev-tools/kselftest.html
[2] https://github.com/libbpf/ci/pull/131
[3]
https://elixir.bootlin.com/linux/v6.10.5/source/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
[4] https://lore.kernel.org/netdev/20240429132207.58ecf430@kernel.org/T/#u

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.



