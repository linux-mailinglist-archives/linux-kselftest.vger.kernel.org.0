Return-Path: <linux-kselftest+bounces-35075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141EADB2FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C0D166156
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56E10942;
	Mon, 16 Jun 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITiYpZC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EA2BEFE6;
	Mon, 16 Jun 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082769; cv=none; b=Cc4UT1M/0oZ6ZYZsqOHoiZAKXCrrJBLbXJBZxB5nxp8MTPF6HKRmx4lPApkuuruf5iyyxU51LMIK0R6d6G5RrQ8YxuWtqIl+o+05oAyy8OU15+niEAk0MTJaVHDEzv1R+QLuye+AeC0b6y7Ii03l6xoSwEKYmcqY/h+xe7+vFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082769; c=relaxed/simple;
	bh=+yTRpLcObz38mmIBNu0YhUQTQhNToxuh2dpkeXQNTgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfnkKFsYif4tgRSW70a0N+jT+pWgczzSUiB1Q6mbksIZyzHfA15+XyPWGEIRNYIRDKeuUF5CoFSnkl7uiGLvwBq9WzWwSU/OE/eOiYgbJGcCrz16E+aLVRyjdu1kG3RbUdub4eaZHoVR8fw9bVKEL6xsh0UA2UVaiBVQV9/Ytgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITiYpZC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D860C4CEEA;
	Mon, 16 Jun 2025 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082769;
	bh=+yTRpLcObz38mmIBNu0YhUQTQhNToxuh2dpkeXQNTgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ITiYpZC8DyKeqZ41hURibw1/kAmhGAlXUSOjBIpjKpuGXBReXUGZeuviQfTlAquOf
	 zEQGEkd2PpoxaTVQEB1GaZE3LGvfOoQmGPF7vHrDdVsjLJnl/YKoclBChjjmNHOiN2
	 tNiLy5Toc8hBFVL+O1JfN8h2gQSy1mkZabzRj6sjcPG689XTdmLESmxDFPADR73CY/
	 ud7DaSCnmCr4I8q9ETSJjFKThNx3BYJqWbc5W0XR2ucpazqRBwAn6wkawBxICXMcCa
	 RHxo8narCWtgZD+cohIdxFTxzDknC5Qv7P5A8ZP5k2z7ZT7EaKa3kVsncmvQKWW3XR
	 M5EUIi8EbUMFA==
Message-ID: <544524c2-e913-4181-b43a-07b029ff75e4@kernel.org>
Date: Mon, 16 Jun 2025 15:06:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Use appropriate permissions for
 map access
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-12 08:18 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Modify several functions in tools/bpf/bpftool/common.c to allow
> specification of requested access for file descriptors, such as
> read-only access.
> 
> Update bpftool to request only read access for maps when write
> access is not required. This fixes errors when reading from maps
> that are protected from modification via security_bpf_map.
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---
> Changes in v2:
> - fix for a test compilation error: "conflicting types for 'bpf_fentry_test1'"
> Changes in v3:
> - Addressed review feedback
> - Converted the check for flags to an assert in map_parse_fds
> - Modified map_fd_by_name to keep an existing fd where possible
> - Fixed requested access for map delete command in do_delete
> - Changed requested access to RDONLY for inner map fd in do_create
> - Changed requested access to RDONLY for iterator fd in do_pin
> ---
> ---
>  tools/bpf/bpftool/btf.c           |  3 +-
>  tools/bpf/bpftool/common.c        | 58 ++++++++++++++++++++++---------
>  tools/bpf/bpftool/iter.c          |  2 +-
>  tools/bpf/bpftool/link.c          |  2 +-
>  tools/bpf/bpftool/main.h          | 13 ++++---
>  tools/bpf/bpftool/map.c           | 56 +++++++++++++++++------------
>  tools/bpf/bpftool/map_perf_ring.c |  3 +-
>  tools/bpf/bpftool/prog.c          |  4 +--
>  8 files changed, 91 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6b14cbfa58aa..1ba27cb03348 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -905,7 +905,8 @@ static int do_dump(int argc, char **argv)
>  			return -1;
>  		}
>  
> -		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +		fd = map_parse_fd_and_info(&argc, &argv, &info, &len,
> +					   BPF_F_RDONLY);
>  		if (fd < 0)
>  			return -1;
>  
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index ecfa790adc13..3bdc65112c0d 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c

[...]

> @@ -1023,8 +1042,13 @@ static int map_fd_by_name(char *name, int **fds)
>  	return -1;
>  }
>  
> -int map_parse_fds(int *argc, char ***argv, int **fds)
> +int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags)
>  {
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
> +
> +	assert((open_flags & ~BPF_F_RDONLY) == 0);


Can you please "#include <assert.h>" at the top of the file? We don't
need it in the kernel repo, because the header is included from
tools/include/linux/kernel.h (from bpftool's main.h) if I remember
correctly. But the GitHub mirror uses a stripped-down version of
kernel.h which doesn't pull assert.h, so we need to include it
explicitly - I just remembered when seeing your v3, sorry.

Looks good to me otherwise, thanks!
Quentin

