Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD46E99CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjDTQoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjDTQoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 12:44:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84722D63
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 09:44:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d14-20020a25e60e000000b00b8f65697946so2613631ybh.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682009046; x=1684601046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aN5kIYCwJL2CZYy1S3bvKBdFTHMoNN9xXJdxBEhpVo=;
        b=CfP5RCyb2FxQzHtIbNy5nMATQFrgEZ2D0GYosBsJfiQxsczvbbHt4N9BBwxB/XlSuJ
         E4rNfqVpKFaUpYQAtkm5yxA5Ro0dCqncKvKhvcAOR+OuzLx/sHULzBIRqJM9c79P8nAm
         fYEzlf2Oq23/HjVMVSkDfF0bawrv9N4neGPTo7U16UvkCYoVokPIEDg0HC6osFPwm9eA
         Kt4rUfdUVrGtdAvmOnRi3xo95l1D5Cro+EQM/MCpOMJl0eQPKAwkGEz0mT6SE/SfTNz6
         rUbrs7o+wLl8Rb7xA4owDiMHH7aez8SyYhpdCFhMJgXEz/Dy9vKU4RT6+9G0Ayvd7UlU
         GQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009046; x=1684601046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aN5kIYCwJL2CZYy1S3bvKBdFTHMoNN9xXJdxBEhpVo=;
        b=QWJ9XdLT38wmPKddH5EfO/Dldi/8Q/9rhevPxIzaLaWV5+dJ+PtX/3huST7zdX4HUN
         2gcDuVB+KQxeGzNXBYlkPXcJ+rfrs/ynvKPMVtrrcpokZJRj5UaFd3qRXxkuunlfipLx
         pgghX7Rblxe5ppRAMuOynVWAy2EL4EYr/7pK31sw/eIqQHTHcQn35djMb8b7TXz+ijl1
         moMQr4QwOGlif12STDJuv4ZPMbRWyi9UC1JNuxD2YoJXnw8cYAJ6/qRnJFRpwopn1kpC
         cQHrLMG2uGWkI4x5xptbUVd9fLk/j/HbGINgIuX8WnJnljG2A7BSdY3OogPmGyRndzh9
         jAig==
X-Gm-Message-State: AAQBX9dfHnoH4IImfNebjpOK9Kq4HJwyWw5B62f7+zer6CoH+JXoC3L8
        Jk9F952CinhHWYnhc9g1Px4aKO4=
X-Google-Smtp-Source: AKy350Z4+sbJBTS394mP9+eI9w9dLdM9HEAp7q/dA3mEFHFGbr2liHryKU/PGVQt4P2wx3LCcI7lTkc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:ec08:0:b0:54f:a60c:12eb with SMTP id
 q8-20020a0dec08000000b0054fa60c12ebmr991348ywn.1.1682009045991; Thu, 20 Apr
 2023 09:44:05 -0700 (PDT)
Date:   Thu, 20 Apr 2023 09:44:04 -0700
In-Reply-To: <20230420145041.508434-5-gilad9366@gmail.com>
Mime-Version: 1.0
References: <20230420145041.508434-1-gilad9366@gmail.com> <20230420145041.508434-5-gilad9366@gmail.com>
Message-ID: <ZEFr1M0PDziB2c9g@google.com>
Subject: Re: [PATCH bpf,v2 4/4] selftests/bpf: Add tc_socket_lookup tests
From:   Stanislav Fomichev <sdf@google.com>
To:     Gilad Sever <gilad9366@gmail.com>
Cc:     dsahern@kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, hawk@kernel.org, joe@wand.net.nz,
        eyal.birger@gmail.com, shmulik.ladkani@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/20, Gilad Sever wrote:
> Verify that socket lookup via TC with all BPF APIs is VRF aware.
> 
> Signed-off-by: Gilad Sever <gilad9366@gmail.com>
> ---
> v2: Fix build by initializing vars with -1
> ---
>  .../bpf/prog_tests/tc_socket_lookup.c         | 341 ++++++++++++++++++
>  .../selftests/bpf/progs/tc_socket_lookup.c    |  73 ++++
>  2 files changed, 414 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_socket_lookup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tc_socket_lookup.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_socket_lookup.c b/tools/testing/selftests/bpf/prog_tests/tc_socket_lookup.c
> new file mode 100644
> index 000000000000..5dcaf0ea3f8c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_socket_lookup.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +/*
> + * Topology:
> + * ---------
> + *     NS1 namespace         |   NS2 namespace
> + *			     |
> + *     +--------------+      |   +--------------+
> + *     |    veth01    |----------|    veth10    |
> + *     | 172.16.1.100 |      |   | 172.16.1.200 |
> + *     |     bpf      |      |   +--------------+
> + *     +--------------+      |
> + *      server(UDP/TCP)      |
> + *  +-------------------+    |
> + *  |        vrf1       |    |
> + *  |  +--------------+ |    |   +--------------+
> + *  |  |    veth02    |----------|    veth20    |
> + *  |  | 172.16.2.100 | |    |   | 172.16.2.200 |
> + *  |  |     bpf      | |    |   +--------------+
> + *  |  +--------------+ |    |
> + *  |   server(UDP/TCP) |    |
> + *  +-------------------+    |
> + *
> + * Test flow
> + * -----------
> + *  The tests verifies that socket lookup via TC is VRF aware:
> + *  1) Creates two veth pairs between NS1 and NS2:
> + *     a) veth01 <-> veth10 outside the VRF
> + *     b) veth02 <-> veth20 in the VRF
> + *  2) Attaches to veth01 and veth02 a program that calls:
> + *     a) bpf_skc_lookup_tcp() with TCP and tcp_skc is true
> + *     b) bpf_sk_lookup_tcp() with TCP and tcp_skc is false
> + *     c) bpf_sk_lookup_udp() with UDP
> + *     The program stores the lookup result in bss->lookup_status.
> + *  3) Creates a socket TCP/UDP server in/outside the VRF.
> + *  4) The test expects lookup_status to be:
> + *     a) 0 from device in VRF to server outside VRF
> + *     b) 0 from device outside VRF to server in VRF
> + *     c) 1 from device in VRF to server in VRF
> + *     d) 1 from device outside VRF to server outside VRF
> + */
> +
> +#include <net/if.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "tc_socket_lookup.skel.h"
> +
> +#define NS1 "tc_socket_lookup_1"
> +#define NS2 "tc_socket_lookup_2"
> +
> +#define IP4_ADDR_VETH01 "172.16.1.100"
> +#define IP4_ADDR_VETH10 "172.16.1.200"
> +#define IP4_ADDR_VETH02 "172.16.2.100"
> +#define IP4_ADDR_VETH20 "172.16.2.200"
> +
> +#define NON_VRF_PORT 5000
> +#define IN_VRF_PORT 5001
> +
> +#define IO_TIMEOUT_SEC	3
> +
> +#define SYS(fmt, ...)						\
> +	({							\
> +		char cmd[1024];					\
> +		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
> +		if (!ASSERT_OK(system(cmd), cmd))		\
> +			goto fail;				\
> +	})
> +
> +#define SYS_NOFAIL(fmt, ...)					\
> +	({							\
> +		char cmd[1024];					\
> +		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
> +		system(cmd);					\
> +	})

[..]

> +static int make_socket(int sotype, const char *ip, int port,
> +		       struct sockaddr_storage *addr)
> +{
> +	struct timeval timeo = { .tv_sec = IO_TIMEOUT_SEC };
> +	int err, fd;
> +
> +	err = make_sockaddr(AF_INET, ip, port, addr, NULL);
> +	if (!ASSERT_OK(err, "make_address"))
> +		return -1;
> +
> +	fd = socket(AF_INET, sotype, 0);
> +	if (!ASSERT_OK(fd < 0, "socket"))
> +		return -1;
> +
> +	err = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
> +	if (!ASSERT_OK(err, "setsockopt(SO_SNDTIMEO)"))
> +		goto fail;
> +
> +	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
> +	if (!ASSERT_OK(err, "setsockopt(SO_RCVTIMEO)"))
> +		goto fail;
> +
> +	return fd;
> +fail:
> +	close(fd);
> +	return -1;
> +}
> +
> +static int make_server(int sotype, const char *ip, int port, const char *ifname)
> +{
> +	struct sockaddr_storage addr = {};
> +	const int one = 1;
> +	int err, fd = -1;
> +
> +	fd = make_socket(sotype, ip, port, &addr);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (sotype == SOCK_STREAM) {
> +		err = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
> +				 sizeof(one));
> +		if (!ASSERT_OK(err, "setsockopt(SO_REUSEADDR)"))
> +			goto fail;
> +	}
> +
> +	if (ifname) {
> +		err = setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE,
> +				 ifname, strlen(ifname) + 1);
> +		if (!ASSERT_OK(err, "setsockopt(SO_BINDTODEVICE)"))
> +			goto fail;
> +	}
> +
> +	err = bind(fd, (void *)&addr, sizeof(struct sockaddr_in));
> +	if (!ASSERT_OK(err, "bind"))
> +		goto fail;
> +
> +	if (sotype == SOCK_STREAM) {
> +		err = listen(fd, SOMAXCONN);
> +		if (!ASSERT_OK(err, "listen"))
> +			goto fail;
> +	}
> +
> +	return fd;
> +fail:
> +	close(fd);
> +	return -1;
> +}

Any reason you're not using start_server from network_helpers.h?
