Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAF760430
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 02:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGYAms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYAmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 20:42:47 -0400
X-Greylist: delayed 6384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 17:42:27 PDT
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FE410F8
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 17:42:26 -0700 (PDT)
Message-ID: <f314091e-fa6b-3113-c64b-6e38bed907d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690245744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seCqV6BWYTRweQc+AwxxhsUnFm8NXFPG4GUfPxlgY2c=;
        b=eeofTMWLLXFLtfmcLeWYsFDGHNXaR8Kpv609KurPpRVFs0JCFsZP94Sn7Wpvs5ZXi50aQk
        Sdz7Be/TlsJQg22Hw29T5BF+CjR6WoP9pzP1T9ep5NEgtD8nWhAsT3vw1KoB/AicwK3Q0a
        EqLpQu9hbrwN1tyxtUGtUk9hS1iVWXM=
Date:   Mon, 24 Jul 2023 17:42:15 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 8/8] selftests/bpf: Test that SO_REUSEPORT can
 be used with sk_assign helper
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>,
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
 <20230720-so-reuseport-v6-8-7021b683cdae@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230720-so-reuseport-v6-8-7021b683cdae@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 8:30 AM, Lorenz Bauer wrote:
> +static int echo_test_udp(int fd_sv)
> +{
> +	struct sockaddr_storage addr = {};
> +	socklen_t len = sizeof(addr);
> +	char buff[1] = {};
> +	int fd_cl = -1, ret;
> +
> +	fd_cl = connect_to_fd(fd_sv, 100);
> +	ASSERT_GT(fd_cl, 0, "create_client");
> +	ASSERT_EQ(getsockname(fd_cl, (void *)&addr, &len), 0, "getsockname");
> +
> +	ASSERT_EQ(send(fd_cl, buff, sizeof(buff), 0), 1, "send_client");
> +
> +	ret = recv(fd_sv, buff, sizeof(buff), 0);
> +	if (ret < 0)

I think this needs a close(fd_cl).

> +		return errno;

