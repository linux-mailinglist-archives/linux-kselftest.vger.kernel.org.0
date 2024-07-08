Return-Path: <linux-kselftest+bounces-13315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824892A529
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F97280DCE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A31420DF;
	Mon,  8 Jul 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mpE2C+6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55497140363;
	Mon,  8 Jul 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450362; cv=none; b=XKj9KairqyVReo59Tyu0Kcht7f2lUHWSmyNrog8MGSrIhL4z+x/o1ifNssM1k7s38ViGALVzY5O/e54spfyz5xSc+AbRktvu8Ywcd8vmO9L1T6/Erl4O2YJjTiLrNyhRg/i3TAdns7w5ZNfrBsak1/sFPdr5Z5fTMdB1yYz7FXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450362; c=relaxed/simple;
	bh=SWfxqNvEQHUIRLFcSx1RPYodXo0um4YMYeD8T3xN4q4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HARGEtGhp3QEBg0HnjmvEJJlxCuzbVuhaIAv4G7DsydzADFHpfBsuv006JrIpjM+XIPdtwWYZv+7V4F6K6MHT83hVZ1u6D/QfMvCRJOJWGlm1zunT4GbDG+4G8TJekZkA1PTywyH+acQhpXk1NSHAZRzLz2t74w0IFpBi4Jav8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mpE2C+6C; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Gr9nzYTnjLIvdAktR9C6XyzRXUeRKDF2h70qQ3BO/nM=; b=mpE2C+6C9pLKrTktJ69VTKHbs2
	jZioccEXrQFzU7I29QZ21iv0aM+0OjXpQb2y8AFA5qt3woXNvpzjKV3cIkxPImCrzvuQEZi2/wRqc
	kZ45W371v028sO/97RVBdJLX5Cccb74Gx5h9cPSjuxV+eoUTlPzL+k3K0lMvQ0CTTzBAa2pip1U8z
	0CjxUsmsWXPQKYP3JyeeKucare0Ui+Lkj9RvVV749jxJaN0Z6lmzlRNu+mZO618pbzs8rcnYaH7Ov
	nDGgLLZRHZL3899HEvR/md53H+gIF07zc+FG1JUlJVJiZWI3lNEdbkvAtR/tAEmvdqwaNPszdQQKB
	BRglPnfg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQpjE-0008Bk-R6; Mon, 08 Jul 2024 16:52:32 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQpjD-000Mue-0M;
	Mon, 08 Jul 2024 16:52:31 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com
References: <20240705145009.32340-1-puranjay@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
Date: Mon, 8 Jul 2024 16:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240705145009.32340-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

On 7/5/24 4:50 PM, Puranjay Mohan wrote:
> fexit_sleep test runs successfully now on the CI so remove it from the
> deny list.

Do you happen to know which commit fixed it? If yes, might be nice to have it
documented in the commit message.

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index e865451e90d2..2bf981c80180 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,6 +1,5 @@
>   bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>   bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> -fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>   kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
>   kprobe_multi_test                                # needs CONFIG_FPROBE
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
> 


