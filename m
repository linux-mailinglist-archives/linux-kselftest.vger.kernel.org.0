Return-Path: <linux-kselftest+bounces-10612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E1F8CCCAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 09:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3061C2218D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6D13C9AB;
	Thu, 23 May 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDxwxxZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445A13AA24;
	Thu, 23 May 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447829; cv=none; b=POw4puAw97PN8L2WWwwd5+9PrHrtETNstbvAE7YcOLx6DyyjED5qbfNmo/HgAQhw3Q39UvlM0wHxA+rAD4xCcVtFR62AQhLnfPDsAStjAdSZB1DoyBIb4VCL2Pht3IFhZbAW+nDD0V9gFdHdHy8weV4rRUksf1LoMUh30rS2zbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447829; c=relaxed/simple;
	bh=xIcbRPGzdTAXs2WNxd0mi0Vbycy28GbQ0IRPVhzR40Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgA9TFKE2XzDzJSQsAZg4z8x6ocDlqGodkV4tQIkwuz4op851kwPj06Hj6knNc6Lj/5EFZwu6Kj/iUrc6V8h+3TGKqsuoGmAB134SWo4pONu/MTWafUtkiCQiD2wtmO3xEwIwkOonjGQ9qUKW+7mK/n38ZSdTIGP7i2GVNzfYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDxwxxZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB017C2BD10;
	Thu, 23 May 2024 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447829;
	bh=xIcbRPGzdTAXs2WNxd0mi0Vbycy28GbQ0IRPVhzR40Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cDxwxxZKGl3LJ/raRP5TzNGi3xSxshQVmJ2HOpBGJbV5dLg1Db1HHoJNuaJQ+Abud
	 QYXJrHmm35W39YfIF2qfQZP7w7hzdnr94g3ZChJ93kZpcP28aXLDe3QKK2m5dWzny3
	 KuWciZdoQGPIOphDK8DzzU5kI8YfdyX3MCRj/AGlbwbtWKdNEXHDjFD1JdwmLhWmaE
	 OCtQuWDqhKvbV3hDuSH7gfLVv3ecG1++kC6QWPxALVfDv4qorSayHnV27bflO4gKge
	 JlZKvUGvaz8XaPUWFDjy+HBc5xpPo0yc7PwijDLmDysbcQzcuGIpPqV98o6xb9wkOj
	 AESGqIAxU5Gjw==
Message-ID: <7a9df605cea389db8f76f5543cce3730faa0e5e3.camel@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use prog_attach_type to attach
 in test_sockmap
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 23 May 2024 15:03:41 +0800
In-Reply-To: <e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn>
References: 
	<e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is "Rejected", according to Jakub's comments:

https://lore.kernel.org/bpf/87zfsiw3a3.fsf@cloudflare.com/

Thanks,
-Geliang

On Wed, 2024-05-22 at 18:08 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Since prog_attach_type[] array is defined, it makes sense to use it
> paired
> with prog_fd[] array for bpf_prog_attach() and bpf_prog_detach2()
> instead
> of open-coding.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 44 +++++++++++---------
> --
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c
> b/tools/testing/selftests/bpf/test_sockmap.c
> index 4499b3cfc3a6..8c8208b82c5e 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -65,6 +65,18 @@ int map_fd[9];
>  struct bpf_map *maps[9];
>  int prog_fd[9];
>  
> +int prog_attach_type[] = {
> +	BPF_SK_SKB_STREAM_PARSER,
> +	BPF_SK_SKB_STREAM_VERDICT,
> +	BPF_SK_SKB_STREAM_VERDICT,
> +	BPF_CGROUP_SOCK_OPS,
> +	BPF_SK_MSG_VERDICT,
> +	BPF_SK_MSG_VERDICT,
> +	BPF_SK_MSG_VERDICT,
> +	BPF_SK_MSG_VERDICT,
> +	BPF_SK_MSG_VERDICT,
> +};
> +
>  int txmsg_pass;
>  int txmsg_redir;
>  int txmsg_drop;
> @@ -961,7 +973,7 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  	/* Attach programs to sockmap */
>  	if (!txmsg_omit_skb_parser) {
>  		err = bpf_prog_attach(prog_fd[0], map_fd[0],
> -				      BPF_SK_SKB_STREAM_PARSER, 0);
> +				      prog_attach_type[0], 0);
>  		if (err) {
>  			fprintf(stderr,
>  				"ERROR: bpf_prog_attach (sockmap %i-
> >%i): %d (%s)\n",
> @@ -971,7 +983,7 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  	}
>  
>  	err = bpf_prog_attach(prog_fd[1], map_fd[0],
> -				BPF_SK_SKB_STREAM_VERDICT, 0);
> +			      prog_attach_type[1], 0);
>  	if (err) {
>  		fprintf(stderr, "ERROR: bpf_prog_attach (sockmap):
> %d (%s)\n",
>  			err, strerror(errno));
> @@ -982,7 +994,7 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  	if (txmsg_ktls_skb) {
>  		if (!txmsg_omit_skb_parser) {
>  			err = bpf_prog_attach(prog_fd[0], map_fd[8],
> -					     
> BPF_SK_SKB_STREAM_PARSER, 0);
> +					      prog_attach_type[0],
> 0);
>  			if (err) {
>  				fprintf(stderr,
>  					"ERROR: bpf_prog_attach (TLS
> sockmap %i->%i): %d (%s)\n",
> @@ -992,7 +1004,7 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  		}
>  
>  		err = bpf_prog_attach(prog_fd[2], map_fd[8],
> -				      BPF_SK_SKB_STREAM_VERDICT, 0);
> +				      prog_attach_type[2], 0);
>  		if (err) {
>  			fprintf(stderr, "ERROR: bpf_prog_attach (TLS
> sockmap): %d (%s)\n",
>  				err, strerror(errno));
> @@ -1001,7 +1013,7 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  	}
>  
>  	/* Attach to cgroups */
> -	err = bpf_prog_attach(prog_fd[3], cg_fd,
> BPF_CGROUP_SOCK_OPS, 0);
> +	err = bpf_prog_attach(prog_fd[3], cg_fd,
> prog_attach_type[3], 0);
>  	if (err) {
>  		fprintf(stderr, "ERROR: bpf_prog_attach (groups): %d
> (%s)\n",
>  			err, strerror(errno));
> @@ -1279,11 +1291,11 @@ static int run_options(struct sockmap_options
> *options, int cg_fd,  int test)
>  		fprintf(stderr, "unknown test\n");
>  out:
>  	/* Detatch and zero all the maps */
> -	bpf_prog_detach2(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS);
> -	bpf_prog_detach2(prog_fd[0], map_fd[0],
> BPF_SK_SKB_STREAM_PARSER);
> -	bpf_prog_detach2(prog_fd[1], map_fd[0],
> BPF_SK_SKB_STREAM_VERDICT);
> -	bpf_prog_detach2(prog_fd[0], map_fd[8],
> BPF_SK_SKB_STREAM_PARSER);
> -	bpf_prog_detach2(prog_fd[2], map_fd[8],
> BPF_SK_SKB_STREAM_VERDICT);
> +	bpf_prog_detach2(prog_fd[3], cg_fd, prog_attach_type[3]);
> +	bpf_prog_detach2(prog_fd[0], map_fd[0],
> prog_attach_type[0]);
> +	bpf_prog_detach2(prog_fd[1], map_fd[0],
> prog_attach_type[1]);
> +	bpf_prog_detach2(prog_fd[0], map_fd[8],
> prog_attach_type[0]);
> +	bpf_prog_detach2(prog_fd[2], map_fd[8],
> prog_attach_type[2]);
>  
>  	if (tx_prog_fd >= 0)
>  		bpf_prog_detach2(tx_prog_fd, map_fd[1],
> BPF_SK_MSG_VERDICT);
> @@ -1783,18 +1795,6 @@ char *map_names[] = {
>  	"tls_sock_map",
>  };
>  
> -int prog_attach_type[] = {
> -	BPF_SK_SKB_STREAM_PARSER,
> -	BPF_SK_SKB_STREAM_VERDICT,
> -	BPF_SK_SKB_STREAM_VERDICT,
> -	BPF_CGROUP_SOCK_OPS,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -	BPF_SK_MSG_VERDICT,
> -};
> -
>  int prog_type[] = {
>  	BPF_PROG_TYPE_SK_SKB,
>  	BPF_PROG_TYPE_SK_SKB,


