Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32807B5422
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjJBNfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjJBNfn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 09:35:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574AF94;
        Mon,  2 Oct 2023 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Wy2Of61rUlzyI+pFa8Y/le0aXi5o8IldPty6dTsaa88=; b=n3XPwRh+pYFIp991kmLC7/C1cI
        TeDjSZLzDPYHkM+ZXHmgDwrprHHUJUfJhEer4FglhsjsYxHkIfy1lYvB5zCO0QZUJ4nNrQxd28L+a
        4frLs0TvlO9BBFeA3fo+6JIrDvR3DLhrZ6DflN3vUZeWrHsm9ekBkzE2Ip0DYfUUVmkfhg6xMQ1Tn
        ajz0khZ2jLQwsR5VdoNaAIURpBWgedR9MpsiJ+p+KJJBvS2lOAqGXo92FB4MpLKO+bfBPtE82//Ut
        RZ+2h8N+uEEIhVarIQS2zt1cLmHf0v7LuiKpEXCCcG8t8jONy0mnrQiIYfbfGr0agbXwa58SGPUab
        d0rL4mkw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qnJ57-000PO7-05; Mon, 02 Oct 2023 15:35:29 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qnJ56-000Auu-Fc; Mon, 02 Oct 2023 15:35:28 +0200
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add pair_redir_to_connected
 helper
To:     Geliang Tang <geliang.tang@suse.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1695892503.git.geliang.tang@suse.com>
 <1bc897b2603ebccabfa2a870977bde236714ded5.1695892503.git.geliang.tang@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a1a06dab-f0d5-b7c1-aaf5-dc8a033da06d@iogearbox.net>
Date:   Mon, 2 Oct 2023 15:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1bc897b2603ebccabfa2a870977bde236714ded5.1695892503.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27049/Mon Oct  2 09:37:00 2023)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/23 11:20 AM, Geliang Tang wrote:
> Extract duplicate code from these four functions
> 
>   unix_redir_to_connected()
>   udp_redir_to_connected()
>   inet_unix_redir_to_connected()
>   unix_inet_redir_to_connected()
> 
> to create a new helper pair_redir_to_connected(). Create the different
> socketpair in these four functions, then pass the socketpair infos to
> the new common helper to do the connections.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   .../selftests/bpf/prog_tests/sockmap_listen.c | 149 ++++--------------
>   1 file changed, 30 insertions(+), 119 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 8df8cbb447f1..fbdf7eb23c1b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1336,27 +1336,17 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
>   	}
>   }
>   
> -static void unix_redir_to_connected(int sotype, int sock_mapfd,
> -			       int verd_mapfd, enum redir_mode mode)
> +static void pair_redir_to_connected(int c0, int p0, int c1, int p1,
> +		int sock_mapfd, int verd_mapfd, enum redir_mode mode)

just nit: indent, and could we find sth more descriptive than {c,p}0 and {c,p}1?

otherwise, lgtm.

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
