Return-Path: <linux-kselftest+bounces-44680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5DC2E29B
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 22:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A50C3A15E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38D2C0F62;
	Mon,  3 Nov 2025 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OC6zuqrU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857711917FB
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205524; cv=none; b=HpZY665A13Lq+thxusqRU4CpbO57MmSTppb4CgYiMgtPwnjYAyJqI/jBZq6BbuiSvOn5K5PqOuVevihWWgmt6MTARwDdvhMJrA4xr8xfoz3vW57BuUVHO0FgQDb7Fa7O241kmia9L7uu9lkEWAOM/DPdvsLX3I904AVQtopZ8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205524; c=relaxed/simple;
	bh=y1bHnHxZ8o5Dd1cQWM8ILwcypoh8chi0Suf/1YawrUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHspghsupsc/Usf7p2063bmrAKsTEWjy1LLSS8iSXfhh5ryHNdZdAtAfsozQDrUsxNXOOGAPV93IIhRvVwWn3ZGb37O3PYcy5cJtonqKcCjihBMwUNBhcV44hrz0+PRgVqDrY+pWr6KQyqJB5bj0PIUPYaHDPqF48dKcVusHm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OC6zuqrU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4cbabdf1-af2c-490a-a41a-b40c1539c1cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762205519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0eVkO0xoYEQJcHTXL1+aFZNj8ZhyzfurWGGbsfOnHE=;
	b=OC6zuqrUjjt/faS2IarINiMNZwHFE+oSeRGqYF3VFk0SSjrg5P5VbG/KvD7VF71Sdjkn6N
	7IHvToe+S+hw0arru9lL91/xe/PKkoWgsfknfoTnFI1ZsWQAsZmWgkonqw52VxBkxXQBq8
	00uPd1bkICk1tST5GGxSOdz3GCZkUVM=
Date: Mon, 3 Nov 2025 13:31:51 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: use start_server_str rather
 than start_reuseport_server in tc_tunnel
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
 <20251031-tc_tunnel_improv-v1-3-0ffe44d27eda@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251031-tc_tunnel_improv-v1-3-0ffe44d27eda@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/31/25 2:01 AM, Alexis Lothoré (eBPF Foundation) wrote:
> test_tc_tunnel currently uses start_reuseport_server because it needs to
> frequently start and stop the server, so we need SO_REUSEPORT to avoid
> getting errors on server restart due to the socket being in TIME_WAIT
> state. But the test is only using one server at a time, so it is a bit
> confusing to use this API.
> 
> Replace start_reuseport with start_sever_str, and provided the relevant
> callback to set SO_REUSEPORT.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>   .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 24 +++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index deea90aaefad..8e3fe6dc6221 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -69,7 +69,7 @@ struct subtest_cfg {
>   	int client_egress_prog_fd;
>   	int server_ingress_prog_fd;
>   	char extra_decap_mod_args[TUNNEL_ARGS_MAX_LEN];
> -	int *server_fd;
> +	int server_fd;
>   };
>   
>   struct connection {
> @@ -131,20 +131,30 @@ static void set_subtest_addresses(struct subtest_cfg *cfg)
>   	}
>   }
>   
> +static int reuseport_cb(int fd, void *opts)
> +{
> +	int one = 1;
> +
> +	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
> +}
> +
>   static int run_server(struct subtest_cfg *cfg)
>   {
>   	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
> +	struct network_helper_opts opts = {
> +		.timeout_ms = TIMEOUT_MS,
> +		.post_socket_cb	= reuseport_cb,
> +	};
>   	struct nstoken *nstoken;
>   
>   	nstoken = open_netns(SERVER_NS);
>   	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
>   		return -1;
>   
> -	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
> -						cfg->server_addr, TEST_PORT,
> -						TIMEOUT_MS, 1);
> +	cfg->server_fd = start_server_str(family, SOCK_STREAM, cfg->server_addr,
> +					  TEST_PORT, &opts);

I meant to directly enable SO_REUSE"ADDR" in the start_server_addr()
instead of each individual test using SO_REUSEPORT. I think all tcp server
in test_progs should have it enabled. Something like this:

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8bb09167399a..e8b33d902bbc 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -97,7 +97,7 @@ int settimeo(int fd, int timeout_ms)
  int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
  		      const struct network_helper_opts *opts)
  {
-	int fd;
+	int fd, on = 1;
  
  	if (!opts)
  		opts = &default_opts;
@@ -111,6 +111,12 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
  	if (settimeo(fd, opts->timeout_ms))
  		goto error_close;
  
+	if (type == SOCK_STREAM &&
+	    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
+		log_err("Failed to enable SO_REUSEADDR");
+		goto error_close;
+	}
+
  	if (opts->post_socket_cb &&
  	    opts->post_socket_cb(fd, opts->cb_opts)) {
  		log_err("Failed to call post_socket_cb");


I have applied patch 1 and 2.

