Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F57602E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGXXCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGXXCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 19:02:18 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFD10FA
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 16:02:17 -0700 (PDT)
Message-ID: <4c524936-989b-f679-d9ec-cf374c849c6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690239359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6YN2MhKnObTVNJlwXZBDVh2nU9Nss9o5bGaetiiYLk=;
        b=OCUfQwf35fGkg4l3oybIH0OevuT0Zex7S9aARt7wwkSawx/N3p+55TqfELamAc59XkvMjd
        d7IpN68fWVMFNKZi6ikR2rcdDcsxH8tPMrEqc0sDib+tNM+8LPPKLQfT+bVf5ujtSCOD0Y
        kqnZnwP9B6xmC1zwwimS+v7HKW0BxFw=
Date:   Mon, 24 Jul 2023 15:55:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 4/8] net: remove duplicate reuseport_lookup
 functions
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-4-7021b683cdae@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230720-so-reuseport-v6-4-7021b683cdae@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 8:30 AM, Lorenz Bauer wrote:
> @@ -452,7 +436,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>   				      daddr, hnum, dif, sdif);
>   		if (score > badness) {
>   			badness = score;
> -			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
> +
> +			if (sk->sk_state == TCP_ESTABLISHED) {
> +				result = sk;
> +				continue;
> +			}

Thanks for the cleanup. I also found moving the TCP_ESTABLISHED check here made 
the score logic easier to reason.
