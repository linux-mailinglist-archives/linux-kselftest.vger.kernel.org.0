Return-Path: <linux-kselftest+bounces-44578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0ACC28385
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753AD1A22339
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B80277C8C;
	Sat,  1 Nov 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koDFtNPy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395511DB34C;
	Sat,  1 Nov 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016370; cv=none; b=lUSeJrpYkyheyRfzc/XqiTXu2iPn1QPWO7U0nwzl3z0nboOMee2FX8TjHNg6hkJSr6iy6BV6lJiTCbCJwXcKbGO8yjE84cQdgVBap1hMpVLCvw7YOmikx26EYZTS7LOBKyQnACcUpnSpXGIkTAFIrHa6U/vCdR9LqXwm6+/H+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016370; c=relaxed/simple;
	bh=c/QNy1CINC/+bHH4T8XLMHsp9R/UI4aM9zE23cc5cTE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rta+lKoqQkkAWEsIfLJ2E9Ga1Dq4BmWWCxYuryJaTFcBVIrOyOXRwcyQoIq0Koc0Bgz//l3Z4cVNQIWqB2lvvnEpR2LPS0ASu8OtUnnUZLeUQ53V7YiP6HNNLuWmz7EJZysh2qOw12MKrXAjcempC4tM2HyGfDPNzs3bE1uOFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koDFtNPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58E0C4CEF1;
	Sat,  1 Nov 2025 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016370;
	bh=c/QNy1CINC/+bHH4T8XLMHsp9R/UI4aM9zE23cc5cTE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=koDFtNPyduJ5SQEQxzsUy+uv7vnLEOAIq96Pjn00jSqzlwOmwbe/cBDMwdKFfPRh4
	 bNGIJ8026w7rmzXmRV41wRZSG8QlKnrHKp/JPtPYArnyDHB30yvz4yM9l+eRGX6S/+
	 ga9snnZfYuorxDi+0/hnNOaZ/a3D+qO7h2NRly4eSxcBzR3Rs2p7SANM36GCArNzkV
	 V8udXyhdb4CgwIQdNf3rwdQ7ay/aUNtG4q3PLE+8gKyUMcMuRZiAqHXbJx1K2lu8tu
	 nyjToKf0MMiR8bVwOtFc5w89zWBLHK8MxocsdYaENVn2VNMwgkOwYZOodljfrE83Dh
	 ycbBqHo/DO0Ig==
Message-ID: <7db88366-69b3-4b69-bf1f-3453dc95b291@kernel.org>
Date: Sat, 1 Nov 2025 16:59:24 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add test for bpftool map ID
 printing
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
 <20251030210655.3938262-3-harshit.m.mogalapalli@oracle.com>
Content-Language: en-GB
In-Reply-To: <20251030210655.3938262-3-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-30 14:06 UTC-0700 ~ Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com>
> Add selftest to check if Map ID is printed on successful creation in
> both plain text and json formats.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  .../testing/selftests/bpf/test_bpftool_map.sh | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
> index 515b1df0501e..013a64e96cbf 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_map.sh
> +++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
> @@ -361,6 +361,40 @@ test_map_access_with_btf_list() {
>  	fi
>  }
>  
> +# Function to test map ID printing
> +# Parameters:
> +#   $1: bpftool path
> +#   $2: BPF_DIR
> +test_map_id_printing() {
> +	local bpftool_path="$1"
> +	local bpf_dir="$2"
> +	local test_map_name="test_map_id"
> +	local test_map_path="$bpf_dir/$test_map_name"
> +
> +	local output
> +	output=$("$bpftool_path" map create "$test_map_path" type hash key 4 \
> +		value 8 entries 128 name "$test_map_name")
> +	if echo "$output" | grep -q "Map successfully created with ID:"; then
> +		echo "PASS: Map ID printed in plain text output."
> +	else
> +		echo "FAIL: Map ID not printed in plain text output."
> +		exit 1


Other tests in the file print a message only on failure, without a
"FAIL:" prefix. Could you do the same, for consistency and brevity? Same
for the JSON test.

Thanks,
Quentin

