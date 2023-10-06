Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B467BB128
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 07:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJFFSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 01:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFFSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 01:18:37 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB576CA
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 22:18:35 -0700 (PDT)
Message-ID: <1124e2ba-2856-41c7-713f-5a4b4ffd3ec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696569509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6FIhk3CVKDciV5afGmTwULasUwhSwoj3cfp90UAl38=;
        b=xpgC48eG7s8e5z7dO/gh8e7FX2WhT5alwGx3sV/dVLcWnOwpB3AkKzNELYQRJPhEljYX9N
        equgtyyLlb0gfvOSpGVgeNyGcasCkqIyQ0YnH/DS5WJNv+YgC5KQ0oYw0rfmrCv9/06CBX
        Q1FnBzvfWDEppcxQ8kDyqrWHYIntmnc=
Date:   Thu, 5 Oct 2023 22:18:21 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add
 pairs_redir_to_connected helper
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1696490003.git.geliang.tang@suse.com>
 <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/5/23 12:21 AM, Geliang Tang wrote:
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1336,32 +1336,22 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
>   	}
>   }
>   
> -static void unix_redir_to_connected(int sotype, int sock_mapfd,
> -			       int verd_mapfd, enum redir_mode mode)
> +static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> +				     int sock_mapfd, int verd_mapfd, enum redir_mode mode)
>   {
>   	const char *log_prefix = redir_mode_str(mode);
> -	int c0, c1, p0, p1;
>   	unsigned int pass;
>   	int err, n;
> -	int sfd[2];
>   	u32 key;
>   	char b;
>   
>   	zero_verdict_count(verd_mapfd);
>   
> -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> -		return;
> -	c0 = sfd[0], p0 = sfd[1];
> -
> -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> -		goto close0;
> -	c1 = sfd[0], p1 = sfd[1];
> -
> -	err = add_to_sockmap(sock_mapfd, p0, p1);
> +	err = add_to_sockmap(sock_mapfd, peer0, peer1);
>   	if (err)
>   		goto close;
>   
> -	n = write(c1, "a", 1);
> +	n = write(cli1, "a", 1);
>   	if (n < 0)
>   		FAIL_ERRNO("%s: write", log_prefix);
>   	if (n == 0)
> @@ -1376,16 +1366,34 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
>   	if (pass != 1)
>   		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>   
> -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
> +	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
>   	if (n < 0)
>   		FAIL_ERRNO("%s: recv_timeout", log_prefix);
>   	if (n == 0)
>   		FAIL("%s: incomplete recv", log_prefix);
>   
>   close:
> -	xclose(c1);
> -	xclose(p1);
> -close0:
> +	xclose(cli1);
> +	xclose(peer1);
> +}
> +
> +static void unix_redir_to_connected(int sotype, int sock_mapfd,
> +			       int verd_mapfd, enum redir_mode mode)
> +{
> +	int c0, c1, p0, p1;
> +	int sfd[2];
> +
> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> +		return;
> +	c0 = sfd[0], p0 = sfd[1];
> +
> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
> +		goto close;
> +	c1 = sfd[0], p1 = sfd[1];
> +
> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
> +
> +close:
>   	xclose(c0);
>   	xclose(p0);
>   }
> @@ -1661,51 +1669,19 @@ static int inet_socketpair(int family, int type, int *s, int *c)
>   static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
>   				   enum redir_mode mode)
>   {
> -	const char *log_prefix = redir_mode_str(mode);
>   	int c0, c1, p0, p1;
> -	unsigned int pass;
> -	int err, n;
> -	u32 key;
> -	char b;
> -
> -	zero_verdict_count(verd_mapfd);
> +	int err;
>   
>   	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
>   	if (err)
>   		return;
>   	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
>   	if (err)
> -		goto close_cli0;
> -
> -	err = add_to_sockmap(sock_mapfd, p0, p1);
> -	if (err)
> -		goto close_cli1;
> -
> -	n = write(c1, "a", 1);
> -	if (n < 0)
> -		FAIL_ERRNO("%s: write", log_prefix);
> -	if (n == 0)
> -		FAIL("%s: incomplete write", log_prefix);
> -	if (n < 1)
> -		goto close_cli1;
> -
> -	key = SK_PASS;
> -	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
> -	if (err)
> -		goto close_cli1;
> -	if (pass != 1)
> -		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> +		goto close;
>   
> -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0, IO_TIMEOUT_SEC);
> -	if (n < 0)
> -		FAIL_ERRNO("%s: recv_timeout", log_prefix);
> -	if (n == 0)
> -		FAIL("%s: incomplete recv", log_prefix);
> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
>   
> -close_cli1:
> -	xclose(c1);
> -	xclose(p1);
> -close_cli0:
> +close:
>   	xclose(c0);
>   	xclose(p0);

Patch 1 is applied. Thanks.

In patch 2, the xclose() here is confusing after this change. It is also 
inconsistent from how other tests in sockmap_listen.c is doing it. c0/p0 and 
c1/p1 are opened here but only c0/p0 is closed here and c1/p1 is closed in the 
pairs_redir_to_connected() above instead.



