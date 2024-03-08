Return-Path: <linux-kselftest+bounces-6078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21711875BBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 02:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835DA1F24369
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A02137F;
	Fri,  8 Mar 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QM/6Wbyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C021101
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Mar 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859837; cv=none; b=PSBxGmvz+1S7sZs1tN2zRRQpzYNVgL3SxAnwdcfLQ0cEweYbgQgNgkCCOIL/AiDvvBsMb1X2+oKlxbGFx3lsnWrRGgg/72hufEDr1A5C+KK1J0LhATanRRszVFtf9+jOG8YH34wFPcwYUqEGFDbZbN+STgY/wXQOmR5Ao7p//gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859837; c=relaxed/simple;
	bh=dL3JJMCUiw12MUhjl8AX46HNwJj4h0AxngXLsUvjSkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOzx9iSb7ls+DUKCdC2426ruaIuPeTYO6gRxCf7L49PT7umo8NUH1pq6MFIULwfUkSVRWs0ZxJ7y3dJWH2pxNAx5daf+/YXdFHdI0wUak8CD/8TaHlZjILD3R1ME70vtFbZtxhU7/bOIfP7FtTiS/VqpGc9NzTNs+HzBRYzM/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QM/6Wbyp; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe323c90-bda3-4837-8daa-372073014446@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709859832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gC74MGn3Y3tSFbRYc+uvNsgQvmrsRYHxqYo53nKvO0Y=;
	b=QM/6Wbyp7018YakXgblFggvzTz1idd5bTi7zwCH+0X9UX+PlZp2nhO1xNHUS+PdLRMGiZ1
	DZC1sX0g1+CHxpYgOkUJmXNEQ/4b6vpHOs0eAIN4lIipmYhDHWQidJ1bnDY2mGuPeubccm
	mUDwqnYtH/TxAYUvscmUp0auaCwclA4=
Date: Thu, 7 Mar 2024 17:03:43 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent
 client connect before server bind
Content-Language: en-US
To: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc: Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240229140000.175274-1-alessandro.carminati@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240229140000.175274-1-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/29/24 6:00 AM, Alessandro Carminati (Red Hat) wrote:
> In some systems, the netcat server can incur in delay to start listening.
> When this happens, the test can randomly fail in various points.
> This is an example error message:
>     # ip gre none gso
>     # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
>     # test basic connectivity
>     # Ncat: Connection refused.

This explained what is the issue. Please also explain how the patch solves it.

> 
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>   tools/testing/selftests/bpf/test_tc_tunnel.sh | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> index 910044f08908..01c0f4b1a8c2 100755
> --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> @@ -72,7 +72,6 @@ cleanup() {
>   server_listen() {
>   	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
>   	server_pid=$!
> -	sleep 0.2
>   }
>   
>   client_connect() {
> @@ -93,6 +92,22 @@ verify_data() {
>   	fi
>   }
>   
> +wait_for_port() {
> +	local digits=8
> +	local port2check=$(printf ":%04X" $1)
> +	local prot=$([ "$2" == "-6" ] && echo 6 && digits=32)
> +
> +	for i in $(seq 20); do
> +		if ip netns exec "${ns2}" cat /proc/net/tcp${prot} | \
> +			sed -r 's/^[ \t]+[0-9]+: ([0-9A-F]{'${digits}'}:[0-9A-F]{4}) .*$/\1/' | \
> +			grep -q "${port2check}"; then

The idea is to check if there is socket listening on port 8888?

May be something simpler like "ss -OHtl src :$1" instead?

--
pw-bot: cr

The check-and-wait fix in this patch is fine to get your test environment going.

Eventually, it will be good to see the test_tc_tunnel.sh test moved to 
test_progs. The test_tc_tunnel.sh is not run by bpf CI and issue like this got 
unnoticed. Some other "*.sh" tests have already been moved to test_progs.



