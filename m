Return-Path: <linux-kselftest+bounces-13258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243C928F78
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CC2846D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA0146593;
	Fri,  5 Jul 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="me8hNNEe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4513D608
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221044; cv=none; b=e3yFi8EpIUFj4KeAGykrK9nDEb+R2XJ0xDEMcQhuLV8wisFE5fMwbvvI8nwlE9l+Ic9P+z5KPDtzC2vjHrfzFGH5GZrO8LrwigLGX+BIOczCc8cpwpH1EJ/hZNsBSr7AnpZ/EDfxsNpkNo8MQcVOgpjIndlSvG9KF2uZM5y8TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221044; c=relaxed/simple;
	bh=4CEqD7VmRndX/qN6v0TFl5xl7rdwJo23W+D2nNPbChY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwrgEAMGcf0eEW0/v93JuyLBv29mtSZ96iFWgs0BlYzlq8Hj0sXmzHRtl5X1gEs5F1BMj9Tfdtvuh72Zgjr5ot0RGBnOesGZdnuilrtJVHzagtdlDacHcaHeqtDzrf+J99SePBO/8AX6ZM4CW24clRBCo9xpvbv0J5MXsZgyr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=me8hNNEe; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: matttbe@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720221040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYSTaBvET+7Y92pC4W26UTSlgkepbfTnQLMrMemfNbQ=;
	b=me8hNNEesaK3JInhevdUm0hR3gV8oybY6jYc26r6lfTHDKE9vrBfNkSMKvP4W2oU+nvRZ6
	BHj5L+4KLS/ywY4cbb88o1ZyRNGsZs2ILYOGuQBH8bPxktRYXPvxBHj5c5j81IOSQLgSPI
	+97Vo9G+TKKCxFWTGjHImfVxTcQ+rQQ=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: kuba@kernel.org
X-Envelope-To: hawk@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: mptcp@lists.linux.dev
X-Envelope-To: martineau@kernel.org
X-Envelope-To: geliang@kernel.org
X-Envelope-To: shuah@kernel.org
Message-ID: <90e916e8-ec4e-447b-8ee6-eb247f3a72ad@linux.dev>
Date: Fri, 5 Jul 2024 16:10:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
 mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
 <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
 <08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/4/24 3:48 AM, Matthieu Baerts wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index e0b3887b3d2d..204269d0b5b8 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
>>   	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>>   	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>>   	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>> -	xdp_features bpf_test_no_cfi.ko
>> +	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
> On the BPF CI, we have such errors:
> 
>     mptcp_pm_nl_ctl.c:20:10: fatal error: 'linux/mptcp.h' file not found
>       20 | #include "linux/mptcp.h"
>          |          ^~~~~~~~~~~~~~~
> 
> On my side, I don't have any issue, because the compiler uses the
> mptcp.h file from the system: /usr/include/linux/mptcp.h
> 
> I suppose that's not OK on the BPF CI, as it looks like it doesn't have
> this file there, probably because it still uses Ubuntu 20.04 as base,
> which doesn't include this file in the linux-libc-dev package.
> 
> When I look at how this 'mptcp_pm_nl_ctl' tool -- and all the other
> programs from that list -- is compiled (V=1), I see that the following
> "-I" options are given:
> 
>    -I${PWD}/tools/testing/selftests/bpf
>    -I${BUILD}//tools/include
>    -I${BUILD}/include/generated
>    -I${PWD}/tools/lib
>    -I${PWD}/tools/include
>    -I${PWD}/tools/include/uapi
>    -I${BUILD}/
> 
> It will then not look at -I${PWD}/usr/include or the directory generated
> with:
> 
>    make headers_install INSTALL_HDR_PATH=(...)

It sounds like the tools/testing/selftests/net/mptcp/Makefile is looking at this 
include path, so it works?

iiu the bpf/Makefile correctly, it has the bpftool "make" compiled and installed 
at tools/testing/selftests/bpf/tools/sbin/. May be directly compile the 
pm_nl_ctl by "make tools/testing/selftests/net/mptcp/"?

> 
> I guess that's why people have duplicated files in 'tools/include/uapi',
> but I also understood from Jakub that it is not a good idea to continue
> to do so.
> 
> What would be the best solution to avoid a copy? A symlink still looks
> like a workaround.
> 
> In the other selftests, KHDR_INCLUDES is used to be able to include the
> path containing the UAPI headers. So if someone built the headers in a

Meaning KHDR_INCLUDES should be used and -I${PWD}/tools/include/uapi can be 
retired? I haven't looked into the details. I quickly tried but it fails in my 
environment.

> seperated directory -- INSTALL_HDR_PATH=(...) -- KHDR_INCLUDES can be
> overridden to look there, instead of ${KERNEL_SRC}/usr/include. Would it
> be OK to do that? Would it work for the CI without extra changes? Or do
> you still prefer a copy/symlink to 'tools/include/uapi' instead?

> 
> Cheers,
> Matt


