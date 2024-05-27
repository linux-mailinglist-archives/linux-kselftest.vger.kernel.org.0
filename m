Return-Path: <linux-kselftest+bounces-10736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A28D0939
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF01C1F21D0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674815DBCC;
	Mon, 27 May 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvZbSzSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C817E902;
	Mon, 27 May 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829955; cv=none; b=OycLGBhcEQ65o9wWuQ3jQNCDFgjD/Dx4v9T1PGMSEXpEBZlzXtnDhPCLsAWnYDGQ8xYfVnaRHdk5fjXV4Id1qZ13M2gk1BTyJZ/v20Bsqj7TwLliP6J6xh1MM5F0guFJSSWA1Y5bZR/07SolMZaKgzQ0TbH+HUkMADwPFPKmVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829955; c=relaxed/simple;
	bh=pqNRpjAOxcRthRPPrejlOHLt3qRMZdMxjxDbu9u4qWY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IjmiavZf3+lUClZsQjwtBtzWi53yAYcB8QO+QKlP6dOBMrTPYG0flb9iefudTeOk2aEUyZvqlmkDse7M0gvUb1jT7GIzC9zksCaNVEsT+GqmWVHxLShXfIkI8P5y857OgwRQNYh+LI/dfXxirRSbTKRkb5J8xtBw/P+EieRJSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvZbSzSx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso2749329b3a.3;
        Mon, 27 May 2024 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829953; x=1717434753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czg/ac8KMZ0qJyvYiTYaCutSE45TkfB2OVJ/WTZ4Qxw=;
        b=dvZbSzSxJAwupWCnQcRAcy56b80TO7maUmQHFNbDDv6EnWXy4HIELU7qzOl8unWkPl
         6ORuMJEOp01luaGRJS/rMT+r5bIbra2WxdAGkUyYE2R6H+sywmjZEkeqnsC8a2x2kmEd
         ZN6L12rzyQAWxVe42vNfWwbdeFBnPpo7BA42Yu0o7YrRYGla9IzR0I0VPGMXX5GD7Hhy
         MlJKR3gePXPs8FLvpYSrKnGr4JliMEfuYgfkQNerV8VLuMCoRR783q4pCsDpPgkLN5hg
         95bLUfWYT4lQ14e1/zUB78x7QV0JC01fRxr6kQPPg2qHs+MkGBB4JdVQTFrrmq41teuX
         SYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829953; x=1717434753;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Czg/ac8KMZ0qJyvYiTYaCutSE45TkfB2OVJ/WTZ4Qxw=;
        b=kbJ0xdWmJLvNsYIMTKfM0tSY3onEshDCeffOSKrlA7uYEJHNFdjWmghKaSz5F5th0G
         pFuPuTXQwjra7wynm8xZiVeUGnQFSaNN9mCSbyHNfjrDdIzNTXj64hRka7G5Isj30aZU
         rZYuFUEKaBrJeGoC0smNR6AoivuhvJE9lQQKAmhEprivglnrZ90FfVPD0Uc0BSZ32xYN
         +xhNcSnrXlL+zJiZE+jEP9vCMtGIzF7q60LmBscMaII75L1IPMK3MSpwVeSHgJMpQjCf
         JOSH2wzYdh9UyVO9ypcVMPxbMVYDs1FOQM/pPEmB0nA2KWeUyIYhYoIFkN8RfNzAIqvm
         +ieQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8xoJ3M1L72xuAII/GEu/KXUjjg80L/ZkCa4ROyu8dGtp2yMClzWHy4dScQd2X7myS2heGW/uR6+AWOdof7y2NTLhCnpkIsXkOQ123YxR81tj6cB2riUh/6hnSQHNQ6RZQzwLU
X-Gm-Message-State: AOJu0Yx62JymLJC4YmcCN9ow6YZ9XSTpV3Rgso9WGRqGj+uU1MRNEeVD
	u1cVXXE6yPqeSLueUatQ2Y69I5lC5PC24ppCWwcjjvZ2Wu9jPv3Y
X-Google-Smtp-Source: AGHT+IFQTJF4RCgPEkHhqjE+9+4j0ui8zWD++G/TLALf1iJcabxhibkJ8PB6qddmnV57XytzRyWorQ==
X-Received: by 2002:a05:6a20:a124:b0:1a9:3cda:dc3c with SMTP id adf61e73a8af0-1b212f94ef1mr10554731637.61.1716829952725;
        Mon, 27 May 2024 10:12:32 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeac2dsm5076378b3a.104.2024.05.27.10.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:12:32 -0700 (PDT)
Date: Mon, 27 May 2024 10:12:31 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6654beff96840_23de2086e@john.notmuch>
In-Reply-To: <32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Switch attachments to bpf_link using bpf_program__attach_sockmap() instead
> of bpf_prog_attach().

Sorry it took me a few days to get to this.

Is there a reason to push this to links vs just leave it as is? I had
a plan to port all the test_sockmap tests into prog_tests anyways. I'll
try to push some initial patch next week.

The one advantage of test_sockmap is we can have it run for longer
runs by pushing different options through so might be worth keeping
just for that.

If you really want links here I'm OK with that I guess just asking.

Thanks,
John

> 
> This patch adds a new array progs[] to replace prog_fd[] array, set in
> populate_progs() for each program in bpf object.
> 
> And another new array links[] to save the attached bpf_link. It is
> initalized as NULL in populate_progs, set as the return valuses of
> bpf_program__attach_sockmap(), and detached by bpf_link__detach().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 59 ++++++++++++----------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index e7dbf49a2ca6..d7581bbbc473 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -64,6 +64,8 @@ int failed;
>  int map_fd[9];
>  struct bpf_map *maps[9];
>  int prog_fd[9];
> +struct bpf_program *progs[9];
> +struct bpf_link *links[9];
>  
>  int txmsg_pass;
>  int txmsg_redir;
> @@ -960,43 +962,39 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
>  
>  	/* Attach programs to sockmap */
>  	if (!txmsg_omit_skb_parser) {
> -		err = bpf_prog_attach(prog_fd[0], map_fd[0],
> -				      BPF_SK_SKB_STREAM_PARSER, 0);
> -		if (err) {
> +		links[0] = bpf_program__attach_sockmap(progs[0], map_fd[0]);
> +		if (!links[0]) {
>  			fprintf(stderr,
> -				"ERROR: bpf_prog_attach (sockmap %i->%i): %d (%s)\n",
> -				prog_fd[0], map_fd[0], err, strerror(errno));
> -			return err;
> +				"ERROR: bpf_program__attach_sockmap (sockmap %i->%i): (%s)\n",
> +				bpf_program__fd(progs[0]), map_fd[0], strerror(errno));
> +			return -1;
>  		}
>  	}
>  
> -	err = bpf_prog_attach(prog_fd[1], map_fd[0],
> -				BPF_SK_SKB_STREAM_VERDICT, 0);
> -	if (err) {
> -		fprintf(stderr, "ERROR: bpf_prog_attach (sockmap): %d (%s)\n",
> -			err, strerror(errno));
> -		return err;
> +	links[1] = bpf_program__attach_sockmap(progs[1], map_fd[0]);
> +	if (!links[1]) {
> +		fprintf(stderr, "ERROR: bpf_program__attach_sockmap (sockmap): (%s)\n",
> +			strerror(errno));
> +		return -1;
>  	}
>  
>  	/* Attach programs to TLS sockmap */
>  	if (txmsg_ktls_skb) {
>  		if (!txmsg_omit_skb_parser) {
> -			err = bpf_prog_attach(prog_fd[0], map_fd[8],
> -					      BPF_SK_SKB_STREAM_PARSER, 0);
> -			if (err) {
> +			links[2] = bpf_program__attach_sockmap(progs[0], map_fd[8]);
> +			if (!links[2]) {
>  				fprintf(stderr,
> -					"ERROR: bpf_prog_attach (TLS sockmap %i->%i): %d (%s)\n",
> -					prog_fd[0], map_fd[8], err, strerror(errno));
> -				return err;
> +					"ERROR: bpf_program__attach_sockmap (TLS sockmap %i->%i): (%s)\n",
> +					bpf_program__fd(progs[0]), map_fd[8], strerror(errno));
> +				return -1;
>  			}
>  		}
>  
> -		err = bpf_prog_attach(prog_fd[2], map_fd[8],
> -				      BPF_SK_SKB_STREAM_VERDICT, 0);
> -		if (err) {
> -			fprintf(stderr, "ERROR: bpf_prog_attach (TLS sockmap): %d (%s)\n",
> -				err, strerror(errno));
> -			return err;
> +		links[3] = bpf_program__attach_sockmap(progs[2], map_fd[8]);
> +		if (!links[3]) {
> +			fprintf(stderr, "ERROR: bpf_program__attach_sockmap (TLS sockmap): (%s)\n",
> +				strerror(errno));
> +			return -1;
>  		}
>  	}
>  
> @@ -1281,10 +1279,11 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
>  out:
>  	/* Detatch and zero all the maps */
>  	bpf_prog_detach2(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS);
> -	bpf_prog_detach2(prog_fd[0], map_fd[0], BPF_SK_SKB_STREAM_PARSER);
> -	bpf_prog_detach2(prog_fd[1], map_fd[0], BPF_SK_SKB_STREAM_VERDICT);
> -	bpf_prog_detach2(prog_fd[0], map_fd[8], BPF_SK_SKB_STREAM_PARSER);
> -	bpf_prog_detach2(prog_fd[2], map_fd[8], BPF_SK_SKB_STREAM_VERDICT);
> +
> +	for (i = 0; i < ARRAY_SIZE(links); i++) {
> +		if (links[i])
> +			bpf_link__detach(links[i]);
> +	}
>  
>  	if (tx_prog_fd > 0)
>  		bpf_prog_detach2(tx_prog_fd, map_fd[1], BPF_SK_MSG_VERDICT);
> @@ -1836,6 +1835,7 @@ static int populate_progs(char *bpf_file)
>  	i = bpf_object__load(obj);
>  	i = 0;
>  	bpf_object__for_each_program(prog, obj) {
> +		progs[i] = prog;
>  		prog_fd[i] = bpf_program__fd(prog);
>  		i++;
>  	}
> @@ -1850,6 +1850,9 @@ static int populate_progs(char *bpf_file)
>  		}
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(links); i++)
> +		links[i] = NULL;
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 



