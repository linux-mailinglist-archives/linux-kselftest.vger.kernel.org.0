Return-Path: <linux-kselftest+bounces-43473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D037BEC287
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FD419A5F06
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF94A1A;
	Sat, 18 Oct 2025 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7dIm0Ta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516DEAE7
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746705; cv=none; b=KEI/SU1tt+iy8de/t7fbApxHifBNZX0zgDr3g0V1DYrAxE/ffJ5JMKHO3Ik5WwHsVgcApjsMNuC2NGljcSzLsNEOkieGMdiwEBXntd7j7q7E/MsKy5xMupBQ/rmSSkIPJpnqfaqa+5A164Z84PhhsS/9BV5fNC7OwiGPDUCi9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746705; c=relaxed/simple;
	bh=CGw9xWYqOW+o68UETTfD6QUmQVMrMtp51mAo/MmhcUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy23S8qz3oPEenfHsk0xYI6dnpJG1pBVdBxnBwy8pRkOdvOOZlCLq+kPalwVRVOcTOSNLCb1RKyxmLLUj1Dl8LGGJY5saEAqo+qGgN5Js92NJHwkrSbemDMv3ZOCOCyqntrAfnSfe/mDBdBLxE19pLs4k1Yae+7y8u8v5QrGU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7dIm0Ta; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2477894b-3325-4bc2-9d3c-a066b3cbb8f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760746689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRAptiG2pEbnyn+aHlYXZkW59iPRAHiYEpRTGXEyySU=;
	b=p7dIm0TawqAQ+AJWSjD9OnsTwPM458XRuu9MIXZR+wLIbsaGGGThweH5015Z6Qy4edv+3t
	lvz5Q+O5PW/T7GrutvM+p7S4xL63KhRramMI5UCWqiIEqmm+gN8+OX4ApSvda7tt4js4XI
	QR0cbW1OB2Vl4w2YmP7MAnP8h1ZR5Ro=
Date: Fri, 17 Oct 2025 17:18:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: integrate test_tc_tunnel.sh
 tests into test_progs
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
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
 <20251017-tc_tunnel-v1-4-2d86808d86b2@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251017-tc_tunnel-v1-4-2d86808d86b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/25 7:29 AM, Alexis Lothoré (eBPF Foundation) wrote:
> The test_tc_tunnel.sh script checks that a large variety of tunneling
> mechanisms handled by the kernel can be handled as well by eBPF
> programs. While this test shares similarities with test_tunnel.c (which
> is already integrated in test_progs), those are testing slightly
> different things:
> - test_tunnel.c creates a tunnel interface, and then get and set tunnel
>    keys in packet metadata, from BPF programs.
> - test_tc_tunnels.sh manually parses/crafts packets content
> 
> Bring the tests covered by test_tc_tunnel.sh into the test_progs
> framework, by creating a dedicated test_tc_tunnel.sh. This new test
> defines a "generic" runner which, for each test configuration:
> - will bring the relevant veth pair, each of those isolated in a
>    dedicated namespace
> - will check that traffic will fail if there is only an encapsulating
>    program attached to one veth egress
> - will check that traffic succeed if we enable some decapsulation module
>    on kernel side
> - will check that traffic still succeeds if we replace the kernel
>    decapsulation with some eBPF ingress decapsulation.
> 
> Example of the new test execution:
> 
>    # ./test_progs -a tc_tunnel
>    #447/1   tc_tunnel/ipip_none:OK
>    #447/2   tc_tunnel/ipip6_none:OK
>    #447/3   tc_tunnel/ip6tnl_none:OK
>    #447/4   tc_tunnel/sit_none:OK
>    #447/5   tc_tunnel/vxlan_eth:OK
>    #447/6   tc_tunnel/ip6vxlan_eth:OK
>    #447/7   tc_tunnel/gre_none:OK
>    #447/8   tc_tunnel/gre_eth:OK
>    #447/9   tc_tunnel/gre_mpls:OK
>    #447/10  tc_tunnel/ip6gre_none:OK
>    #447/11  tc_tunnel/ip6gre_eth:OK
>    #447/12  tc_tunnel/ip6gre_mpls:OK
>    #447/13  tc_tunnel/udp_none:OK
>    #447/14  tc_tunnel/udp_eth:OK
>    #447/15  tc_tunnel/udp_mpls:OK
>    #447/16  tc_tunnel/ip6udp_none:OK
>    #447/17  tc_tunnel/ip6udp_eth:OK
>    #447/18  tc_tunnel/ip6udp_mpls:OK
>    #447     tc_tunnel:OK
>    Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

Thanks for working on this!

One high level comment is to minimize switching netns to make the test 
easier to follow.

Some ideas...

> +static void stop_server(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken = open_netns(SERVER_NS);
> +
> +	close(*cfg->server_fd);
> +	cfg->server_fd = NULL;
> +	close_netns(nstoken);
> +}
> +
> +static int check_server_rx_data(struct subtest_cfg *cfg,
> +				struct connection *conn, int len)
> +{
> +	struct nstoken *nstoken = open_netns(SERVER_NS);
> +	int err;
> +
> +	memset(rx_buffer, 0, BUFFER_LEN);
> +	err = recv(conn->server_fd, rx_buffer, len, 0);
> +	close_netns(nstoken);
> +	if (!ASSERT_EQ(err, len, "check rx data len"))
> +		return 1;
> +	if (!ASSERT_MEMEQ(tx_buffer, rx_buffer, len, "check received data"))
> +		return 1;
> +	return 0;
> +}
> +
> +static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
> +{
> +	struct network_helper_opts opts = {.timeout_ms = 500};
> +	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
> +	struct nstoken *nstoken = open_netns(CLIENT_NS);
> +	struct connection *conn = NULL;
> +	int client_fd, server_fd;
> +
> +	client_fd = connect_to_addr_str(family, SOCK_STREAM, cfg->server_addr,
> +					TEST_PORT, &opts);
> +	close_netns(nstoken);
> +
> +	if (client_fd < 0)
> +		return NULL;
> +
> +	nstoken = open_netns(SERVER_NS);

Understood that the server is in another netns but I don't think it 
needs to switch back to SERVER_NS to use its fd like accept(server_fd). 
It can be done in client_ns. Please check.

The same for the above check_server_rx_data and stop_server.
  > +	server_fd = accept(*cfg->server_fd, NULL, NULL);
> +	close_netns(nstoken);
> +	if (server_fd < 0)
> +		return NULL;
> +
> +	conn = malloc(sizeof(struct connection));
> +	if (conn) {
> +		conn->server_fd = server_fd;
> +		conn->client_fd = client_fd;
> +	}
> +
> +	return conn;
> +}
> +
> +static void disconnect_client_from_server(struct subtest_cfg *cfg,
> +					  struct connection *conn)
> +{
> +	struct nstoken *nstoken;
> +
> +	nstoken = open_netns(SERVER_NS);

same here.

> +	close(conn->server_fd);
> +	close_netns(nstoken);
> +	nstoken = open_netns(CLIENT_NS);

and here.

> +	close(conn->client_fd);
> +	close_netns(nstoken);
> +	free(conn);
> +}
> +
> +static int send_and_test_data(struct subtest_cfg *cfg, bool must_succeed)

See if this whole function can work in client_ns alone or may be the 
caller run_test() can stay with the CLIENT_NS instead of...

> +{
> +	struct nstoken *nstoken = NULL;
> +	struct connection *conn;
> +	int err, res = -1;
> +
> +	conn = connect_client_to_server(cfg);
> +	if (!must_succeed && !ASSERT_EQ(conn, NULL, "connection that must fail"))
> +		goto end;
> +	else if (!must_succeed)
> +		return 0;
> +
> +	if (!ASSERT_NEQ(conn, NULL, "connection that must succeed"))
> +		return 1;
> +
> +	nstoken = open_netns(CLIENT_NS);

switching here...

> +	err = send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
> +	close_netns(nstoken);
> +	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from client"))
> +		goto end;
> +	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
> +		goto end;
> +
> +	if (!cfg->test_gso) {
> +		res = 0;
> +		goto end;
> +	}
> +
> +	nstoken = open_netns(CLIENT_NS);

and here.
> +static void run_test(struct subtest_cfg *cfg)
> +{

See if it can open_netns(CLIENT_NS) once at the beginning.

> +	if (!ASSERT_OK(run_server(cfg), "run server"))

The run_server and configure_* can open/close SERVER_NS when needed. 
open_netns should have saved the previous netns (i.e. CLIENT_NS) such 
that it knows which one to restore during close_netns(). I don't think I 
have tried that though but should work. Please check.

> +		goto fail;
> +
> +	// Basic communication must work

Consistent comment style. Stay with /* */

> +	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
> +		goto fail;
> +
> +	// Attach encapsulation program to client, communication must fail
> +	if (!ASSERT_OK(configure_encapsulation(cfg), "configure encapsulation"))
> +		return;
> +	if (!ASSERT_OK(send_and_test_data(cfg, false), "connect with encap prog only"))
> +		goto fail;
> +
> +	/* Insert kernel decap module, connection must succeed */
> +	if (!ASSERT_OK(configure_kernel_decapsulation(cfg), "configure kernel decapsulation"))
> +		goto fail;
> +	if (!ASSERT_OK(send_and_test_data(cfg, !cfg->expect_kern_decap_failure),
> +		       "connect with encap prog and kern decap"))
> +		goto fail;
> +
> +	// Replace kernel module with BPF decap, test must pass
> +	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
> +		goto fail;
> +	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
> +
> +fail:
> +	stop_server(cfg);
> +}

>struct subtest_cfg subtests_cfg[] = {
static

> +int subtests_count = sizeof(subtests_cfg)/sizeof(struct subtest_cfg);

ARRAY_SIZE(subtests_cfg)

pw-bot: cr


