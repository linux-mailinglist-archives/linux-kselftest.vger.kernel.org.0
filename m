Return-Path: <linux-kselftest+bounces-43744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B6BFAB2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 09:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10AE750513D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C82FD688;
	Wed, 22 Oct 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FQ13WPxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB92F49FC;
	Wed, 22 Oct 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119573; cv=none; b=si/l97WHMocUAr2t9hxguq2Ate5fTQgJVbVQxXPyeIbF7vukRBhsIw09NYQZf3G0B0qSLSrPtul64vBMhy32VvHibw1WvxjrkBHPerC3dYVjip89DkwQ2JHNQXvmBdpGMQsAn8aKbv2noCNkb5TPSyPg9STmD1aw3zU0kG41wO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119573; c=relaxed/simple;
	bh=GcN59CL59Hb546MT9i5iNs0rE519oILeaBfI8MTdPFU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=dCy3j4GM4Dsv6A3NUIcpf1UjFe3y6KNqJfKGb3dL90nl0M9rfVMILYX8up1aq9TJE1v5nE7xeqegQXJFHisU62JWjgVTc19UMhBgChx3rU8vpK5Z8htpoPPf3Fcb2e6tW6PSMguq55opW+2MeBfBvtos7qodokaQFvqJ609LJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FQ13WPxJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 01C344E41268;
	Wed, 22 Oct 2025 07:52:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDFE1606DC;
	Wed, 22 Oct 2025 07:52:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BFC4102F2357;
	Wed, 22 Oct 2025 09:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761119567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hJYwKBxck5Wtpg7ekhOWJc7QhbkECsKZ8eYTmKQzNv0=;
	b=FQ13WPxJrVYSD7h+6qU7BIpzfaBVujNngCM8qAlXHRgmndsPqLp+PTLC7gm8l4lURD+Dps
	Eh/7/56mY/rLwUSvNU3hBjBy/n4dXKRjiJfABowNN+Uahy3uV5MrFD5q7PIYfcw4oZESlZ
	+4nLA+5CvdUCM8gIK2AhnTFXLwWuMoVUfL0JNXjpoRst/sF+Ca1wlr2jurR/CNlGp8qP6J
	YCxNxbvoDQwl5F4YW9rsCQaP+T5PSyboMJxUUtInUhIwAxVpDvMEj/0AKWo23dlrgqdVH9
	RdLJn2g41a32asrMf7XarSY/SVQA5/RJf3IOheCun1tRMjs1TX+SQBaWAygOmw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 09:52:41 +0200
Message-Id: <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
Cc: <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
 <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com>
In-Reply-To: <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Oct 22, 2025 at 9:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundation) =
wrote:
> The test_tc_tunnel.sh script checks that a large variety of tunneling
> mechanisms handled by the kernel can be handled as well by eBPF
> programs. While this test shares similarities with test_tunnel.c (which
> is already integrated in test_progs), those are testing slightly
> different things:
> - test_tunnel.c creates a tunnel interface, and then get and set tunnel
>   keys in packet metadata, from BPF programs.
> - test_tc_tunnels.sh manually parses/crafts packets content
>
> Bring the tests covered by test_tc_tunnel.sh into the test_progs
> framework, by creating a dedicated test_tc_tunnel.sh. This new test
> defines a "generic" runner which, for each test configuration:
> - will configure the relevant veth pair, each of those isolated in a
>   dedicated namespace
> - will check that traffic will fail if there is only an encapsulating
>   program attached to one veth egress
> - will check that traffic succeed if we enable some decapsulation module
>   on kernel side
> - will check that traffic still succeeds if we replace the kernel
>   decapsulation with some eBPF ingress decapsulation.
>
> Example of the new test execution:
>
>   # ./test_progs -a tc_tunnel
>   #447/1   tc_tunnel/ipip_none:OK
>   #447/2   tc_tunnel/ipip6_none:OK
>   #447/3   tc_tunnel/ip6tnl_none:OK
>   #447/4   tc_tunnel/sit_none:OK
>   #447/5   tc_tunnel/vxlan_eth:OK
>   #447/6   tc_tunnel/ip6vxlan_eth:OK
>   #447/7   tc_tunnel/gre_none:OK
>   #447/8   tc_tunnel/gre_eth:OK
>   #447/9   tc_tunnel/gre_mpls:OK
>   #447/10  tc_tunnel/ip6gre_none:OK
>   #447/11  tc_tunnel/ip6gre_eth:OK
>   #447/12  tc_tunnel/ip6gre_mpls:OK
>   #447/13  tc_tunnel/udp_none:OK
>   #447/14  tc_tunnel/udp_eth:OK
>   #447/15  tc_tunnel/udp_mpls:OK
>   #447/16  tc_tunnel/ip6udp_none:OK
>   #447/17  tc_tunnel/ip6udp_eth:OK
>   #447/18  tc_tunnel/ip6udp_mpls:OK
>   #447     tc_tunnel:OK
>   Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>

A note about test duration:
the overall test duration, in my setup (x86 qemu-based setup, running on
x86), is around 13s. Reviews on similar series ([1]) shows that such a
duration is not really desirable for CI integration. I checked how to
reduce it, and it appears that most of it is due to the fact that for each
subtest, we verify that if we insert bpf encapsulation (egress) program,
and nothing on server side, we properly fail to connect client to server.
This test then relies on timeout connection,  and I already reduced it as
much as possible, but I guess going below the current value (500ms) will
just start to make the whole test flaky.

I took this "check connection failure" from the original script, and kind
of like it for its capacity to detect false negatives, but should I
eventually get rid of it ?

Thanks,

Alexis

[1] https://lore.kernel.org/bpf/CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31Q=
xR3mPDkw@mail.gmail.com/
> ---
> Changes in v2:
> - use new tc_prog_attach helper
> - reduce the number of NS switches (most of the operations are now done
>   in client NS)
> - fix comment style
> - user ARRAY_SIZE instead of manual computation
> ---
>  .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 660 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  38 +-
>  2 files changed, 679 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/to=
ols/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> new file mode 100644
> index 000000000000..bf60ffcfee85
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +/*
> + * End-to-end eBPF tunnel test suite
> + *   The file tests BPF network tunnels implementation. For each tunnel
> + *   type, the test validates that:
> + *   - basic communication can first be established between the two veth=
s
> + *   - when adding a BPF-based encapsulation on client egress, it now fa=
ils
> + *   to communicate with the server
> + *   - when adding a kernel-based decapsulation on server ingress, clien=
t
> + *   can now connect
> + *   - when replacing the kernel-based decapsulation with a BPF-based on=
e,
> + *   the client can still connect
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <bpf/libbpf.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "test_tc_tunnel.skel.h"
> +
> +#define SERVER_NS	"tc-tunnel-server-ns"
> +#define CLIENT_NS	"tc-tunnel-client-ns"
> +#define MAC_ADDR_VETH1	"00:11:22:33:44:55"
> +#define IP4_ADDR_VETH1	"192.168.1.1"
> +#define IP6_ADDR_VETH1	"fd::1"
> +#define MAC_ADDR_VETH2	"66:77:88:99:AA:BB"
> +#define IP4_ADDR_VETH2	"192.168.1.2"
> +#define IP6_ADDR_VETH2	"fd::2"
> +
> +#define TEST_NAME_MAX_LEN	64
> +#define PROG_NAME_MAX_LEN	64
> +#define TUNNEL_ARGS_MAX_LEN	128
> +#define BUFFER_LEN		2000
> +#define DEFAULT_TEST_DATA_SIZE	100
> +#define GSO_TEST_DATA_SIZE	BUFFER_LEN
> +
> +#define TIMEOUT_MS			1000
> +#define TEST_PORT			8000
> +#define UDP_PORT			5555
> +#define MPLS_UDP_PORT			6635
> +#define FOU_MPLS_PROTO			137
> +#define VXLAN_ID			1
> +#define VXLAN_PORT			8472
> +#define MPLS_TABLE_ENTRIES_COUNT	65536
> +
> +static char tx_buffer[BUFFER_LEN], rx_buffer[BUFFER_LEN];
> +
> +struct subtest_cfg {
> +	char *ebpf_tun_type;
> +	char *iproute_tun_type;
> +	char *mac_tun_type;
> +	int ipproto;
> +	void (*extra_decap_mod_args_cb)(struct subtest_cfg *cfg, char *dst);
> +	bool tunnel_need_veth_mac;
> +	bool configure_fou_rx_port;
> +	char *tmode;
> +	bool expect_kern_decap_failure;
> +	bool configure_mpls;
> +	bool test_gso;
> +	char *tunnel_client_addr;
> +	char *tunnel_server_addr;
> +	char name[TEST_NAME_MAX_LEN];
> +	char *server_addr;
> +	int client_egress_prog_fd;
> +	int server_ingress_prog_fd;
> +	char extra_decap_mod_args[TUNNEL_ARGS_MAX_LEN];
> +	int *server_fd;
> +};
> +
> +struct connection {
> +	int client_fd;
> +	int server_fd;
> +};
> +
> +static int build_subtest_name(struct subtest_cfg *cfg, char *dst, size_t=
 size)
> +{
> +	int ret;
> +
> +	ret =3D snprintf(dst, size, "%s_%s", cfg->ebpf_tun_type,
> +		       cfg->mac_tun_type);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int set_subtest_progs(struct subtest_cfg *cfg, struct test_tc_tun=
nel *skel)
> +{
> +	char prog_name[PROG_NAME_MAX_LEN];
> +	struct bpf_program *prog;
> +	int ret;
> +
> +	ret =3D snprintf(prog_name, PROG_NAME_MAX_LEN, "__encap_");
> +	if (ret < 0)
> +		return ret;
> +	ret =3D build_subtest_name(cfg, prog_name + ret, PROG_NAME_MAX_LEN - re=
t);
> +	if (ret < 0)
> +		return ret;
> +	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!prog)
> +		return -1;
> +
> +	cfg->client_egress_prog_fd =3D bpf_program__fd(prog);
> +	cfg->server_ingress_prog_fd =3D bpf_program__fd(skel->progs.decap_f);
> +	return 0;
> +}
> +
> +static void set_subtest_addresses(struct subtest_cfg *cfg)
> +{
> +	if (cfg->ipproto =3D=3D 6)
> +		cfg->server_addr =3D IP6_ADDR_VETH2;
> +	else
> +		cfg->server_addr =3D IP4_ADDR_VETH2;
> +
> +	/* Some specific tunnel types need specific addressing, it then
> +	 * has been already set in the configuration table. Otherwise,
> +	 * deduce the relevant addressing from the ipproto
> +	 */
> +	if (cfg->tunnel_client_addr && cfg->tunnel_server_addr)
> +		return;
> +
> +	if (cfg->ipproto =3D=3D 6) {
> +		cfg->tunnel_client_addr =3D IP6_ADDR_VETH1;
> +		cfg->tunnel_server_addr =3D IP6_ADDR_VETH2;
> +	} else {
> +		cfg->tunnel_client_addr =3D IP4_ADDR_VETH1;
> +		cfg->tunnel_server_addr =3D IP4_ADDR_VETH2;
> +	}
> +}
> +
> +static int run_server(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken =3D open_netns(SERVER_NS);
> +	int family =3D cfg->ipproto =3D=3D 6 ? AF_INET6 : AF_INET;
> +
> +	cfg->server_fd =3D start_reuseport_server(family, SOCK_STREAM,
> +						cfg->server_addr, TEST_PORT,
> +						TIMEOUT_MS, 1);
> +	close_netns(nstoken);
> +	if (!ASSERT_NEQ(cfg->server_fd, NULL, "start server"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void stop_server(struct subtest_cfg *cfg)
> +{
> +	close(*cfg->server_fd);
> +	cfg->server_fd =3D NULL;
> +}
> +
> +static int check_server_rx_data(struct subtest_cfg *cfg,
> +				struct connection *conn, int len)
> +{
> +	int err;
> +
> +	memset(rx_buffer, 0, BUFFER_LEN);
> +	err =3D recv(conn->server_fd, rx_buffer, len, 0);
> +	if (!ASSERT_EQ(err, len, "check rx data len"))
> +		return 1;
> +	if (!ASSERT_MEMEQ(tx_buffer, rx_buffer, len, "check received data"))
> +		return 1;
> +	return 0;
> +}
> +
> +static struct connection *connect_client_to_server(struct subtest_cfg *c=
fg)
> +{
> +	struct network_helper_opts opts =3D {.timeout_ms =3D 500};
> +	int family =3D cfg->ipproto =3D=3D 6 ? AF_INET6 : AF_INET;
> +	struct connection *conn =3D NULL;
> +	int client_fd, server_fd;
> +
> +	client_fd =3D connect_to_addr_str(family, SOCK_STREAM, cfg->server_addr=
,
> +					TEST_PORT, &opts);
> +
> +	if (client_fd < 0)
> +		return NULL;
> +
> +	server_fd =3D accept(*cfg->server_fd, NULL, NULL);
> +	if (server_fd < 0)
> +		return NULL;
> +
> +	conn =3D malloc(sizeof(struct connection));
> +	if (conn) {
> +		conn->server_fd =3D server_fd;
> +		conn->client_fd =3D client_fd;
> +	}
> +
> +	return conn;
> +}
> +
> +static void disconnect_client_from_server(struct subtest_cfg *cfg,
> +					  struct connection *conn)
> +{
> +	close(conn->server_fd);
> +	close(conn->client_fd);
> +	free(conn);
> +}
> +
> +static int send_and_test_data(struct subtest_cfg *cfg, bool must_succeed=
)
> +{
> +	struct connection *conn;
> +	int err, res =3D -1;
> +
> +	conn =3D connect_client_to_server(cfg);
> +	if (!must_succeed && !ASSERT_EQ(conn, NULL, "connection that must fail"=
))
> +		goto end;
> +	else if (!must_succeed)
> +		return 0;
> +
> +	if (!ASSERT_NEQ(conn, NULL, "connection that must succeed"))
> +		return 1;
> +
> +	err =3D send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
> +	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from client"))
> +		goto end;
> +	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
> +		goto end;
> +
> +	if (!cfg->test_gso) {
> +		res =3D 0;
> +		goto end;
> +	}
> +
> +	err =3D send(conn->client_fd, tx_buffer, GSO_TEST_DATA_SIZE, 0);
> +	if (!ASSERT_EQ(err, GSO_TEST_DATA_SIZE, "send (large) data from client"=
))
> +		goto end;
> +	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
> +		goto end;
> +
> +	res =3D 0;
> +end:
> +	disconnect_client_from_server(cfg, conn);
> +	return res;
> +}
> +
> +static void vxlan_decap_mod_args_cb(struct subtest_cfg *cfg, char *dst)
> +{
> +	snprintf(dst, TUNNEL_ARGS_MAX_LEN, "id %d dstport %d udp6zerocsumrx",
> +		 VXLAN_ID, VXLAN_PORT);
> +}
> +
> +static void udp_decap_mod_args_cb(struct subtest_cfg *cfg, char *dst)
> +{
> +	bool is_mpls =3D !strcmp(cfg->mac_tun_type, "mpls");
> +
> +	snprintf(dst, TUNNEL_ARGS_MAX_LEN,
> +		 "encap fou encap-sport auto encap-dport %d",
> +		 is_mpls ? MPLS_UDP_PORT : UDP_PORT);
> +}
> +
> +static int configure_fou_rx_port(struct subtest_cfg *cfg, bool add)
> +{
> +	bool is_mpls =3D strcmp(cfg->mac_tun_type, "mpls") =3D=3D 0;
> +	int fou_proto;
> +
> +	if (is_mpls)
> +		fou_proto =3D FOU_MPLS_PROTO;
> +	else
> +		fou_proto =3D cfg->ipproto =3D=3D 6 ? 41 : 4;
> +
> +	SYS(fail, "ip fou %s port %d ipproto %d%s", add ? "add" : "del",
> +	    is_mpls ? MPLS_UDP_PORT : UDP_PORT, fou_proto,
> +	    cfg->ipproto =3D=3D 6 ? " -6" : "");
> +
> +	return 0;
> +fail:
> +	return 1;
> +}
> +
> +static int add_fou_rx_port(struct subtest_cfg *cfg)
> +{
> +	return configure_fou_rx_port(cfg, true);
> +}
> +
> +static int del_fou_rx_port(struct subtest_cfg *cfg)
> +{
> +	return configure_fou_rx_port(cfg, false);
> +}
> +
> +static int update_tunnel_intf_addr(struct subtest_cfg *cfg)
> +{
> +	SYS(fail, "ip link set dev testtun0 address " MAC_ADDR_VETH2);
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +static int configure_kernel_for_mpls(struct subtest_cfg *cfg)
> +{
> +	SYS(fail, "sysctl -qw net.mpls.platform_labels=3D%d",
> +	    MPLS_TABLE_ENTRIES_COUNT);
> +	SYS(fail, "ip -f mpls route add 1000 dev lo");
> +	SYS(fail, "ip link set lo up");
> +	SYS(fail, "sysctl -qw net.mpls.conf.testtun0.input=3D1");
> +	SYS(fail, "sysctl -qw net.ipv4.conf.lo.rp_filter=3D0");
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +static int configure_encapsulation(struct subtest_cfg *cfg)
> +{
> +	int ret;
> +
> +	ret =3D tc_prog_attach("veth1", -1, cfg->client_egress_prog_fd);
> +
> +	return ret;
> +}
> +
> +static int configure_kernel_decapsulation(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken =3D open_netns(SERVER_NS);
> +
> +	if (cfg->configure_fou_rx_port &&
> +	    !ASSERT_OK(add_fou_rx_port(cfg), "configure FOU RX port"))
> +		goto fail;
> +	SYS(fail, "ip link add name testtun0 type %s %s remote %s local %s %s",
> +	    cfg->iproute_tun_type, cfg->tmode ? cfg->tmode : "",
> +	    cfg->tunnel_client_addr, cfg->tunnel_server_addr,
> +	    cfg->extra_decap_mod_args);
> +	if (cfg->tunnel_need_veth_mac &&
> +	    !ASSERT_OK(update_tunnel_intf_addr(cfg), "update testtun0 mac"))
> +		goto fail;
> +	if (cfg->configure_mpls &&
> +	    (!ASSERT_OK(configure_kernel_for_mpls(cfg),
> +			"configure MPLS decap")))
> +		goto fail;
> +	SYS(fail, "sysctl -qw net.ipv4.conf.all.rp_filter=3D0");
> +	SYS(fail, "sysctl -qw net.ipv4.conf.testtun0.rp_filter=3D0");
> +	SYS(fail, "ip link set dev testtun0 up");
> +	close_netns(nstoken);
> +	return 0;
> +fail:
> +	close_netns(nstoken);
> +	return -1;
> +}
> +
> +static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken =3D open_netns(SERVER_NS);
> +
> +	SYS(fail, "ip link del testtun0");
> +	if (!ASSERT_OK(tc_prog_attach("veth2", cfg->server_ingress_prog_fd, -1)=
,
> +		       "attach_program"))
> +		goto fail;
> +	close_netns(nstoken);
> +	return 0;
> +fail:
> +	close_netns(nstoken);
> +	return -1;
> +}
> +
> +static void run_test(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken =3D open_netns(CLIENT_NS);
> +
> +	if (!ASSERT_OK(run_server(cfg), "run server"))
> +		goto fail;
> +
> +	/* Basic communication must work */
> +	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any enca=
p"))
> +		goto fail;
> +
> +	/* Attach encapsulation program to client, communication must fail */
> +	if (!ASSERT_OK(configure_encapsulation(cfg), "configure encapsulation")=
)
> +		return;
> +	if (!ASSERT_OK(send_and_test_data(cfg, false), "connect with encap prog=
 only"))
> +		goto fail;
> +
> +	/* Insert kernel decap module, connection must succeed */
> +	if (!ASSERT_OK(configure_kernel_decapsulation(cfg), "configure kernel d=
ecapsulation"))
> +		goto fail;
> +	if (!ASSERT_OK(send_and_test_data(cfg, !cfg->expect_kern_decap_failure)=
,
> +		       "connect with encap prog and kern decap"))
> +		goto fail;
> +
> +	/* Replace kernel module with BPF decap, test must pass */
> +	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decap=
sulation"))
> +		goto fail;
> +	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap =
progs");
> +
> +fail:
> +	stop_server(cfg);
> +	close_netns(nstoken);
> +}
> +
> +static int setup(void)
> +{
> +	struct nstoken *nstoken =3D NULL;
> +	int fd, err;
> +
> +	fd =3D open("/dev/urandom", O_RDONLY);
> +	if (!ASSERT_OK_FD(fd, "open urandom"))
> +		goto fail;
> +	err =3D read(fd, tx_buffer, BUFFER_LEN);
> +	close(fd);
> +
> +	if (!ASSERT_EQ(err, BUFFER_LEN, "read random bytes"))
> +		goto fail;
> +
> +	/* Configure the testing network */
> +	if (!ASSERT_OK(make_netns(CLIENT_NS), "create client ns") ||
> +	    !ASSERT_OK(make_netns(SERVER_NS), "create server ns"))
> +		goto fail;
> +
> +	nstoken =3D open_netns(CLIENT_NS);
> +	SYS(fail, "ip link add %s type veth peer name %s",
> +	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
> +	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
> +	SYS(fail, "ethtool -K veth1 tso off");
> +	SYS(fail, "ip link set veth1 up");
> +	close_netns(nstoken);
> +	nstoken =3D open_netns(SERVER_NS);
> +	SYS(fail, "ip link set veth2 up");
> +	close_netns(nstoken);
> +
> +	return 0;
> +fail:
> +	close_netns(nstoken);
> +	return 1;
> +}
> +
> +static int subtest_setup(struct test_tc_tunnel *skel, struct subtest_cfg=
 *cfg)
> +{
> +	struct nstoken *nstoken;
> +
> +	set_subtest_addresses(cfg);
> +	if (!ASSERT_OK(set_subtest_progs(cfg, skel),
> +		       "find subtest progs"))
> +		return -1;
> +	if (cfg->extra_decap_mod_args_cb)
> +		cfg->extra_decap_mod_args_cb(cfg, cfg->extra_decap_mod_args);
> +
> +	nstoken =3D open_netns(CLIENT_NS);
> +	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
> +	SYS(fail, "ip -4 route flush table main");
> +	SYS(fail, "ip -4 route add " IP4_ADDR_VETH2 " mtu 1450 dev veth1");
> +	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH1 "/64 dev veth1 nodad");
> +	SYS(fail, "ip -6 route flush table main");
> +	SYS(fail, "ip -6 route add " IP6_ADDR_VETH2 " mtu 1430 dev veth1");
> +	close_netns(nstoken);
> +
> +	nstoken =3D open_netns(SERVER_NS);
> +	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
> +	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH2 "/64 dev veth2 nodad");
> +	close_netns(nstoken);
> +
> +	return 0;
> +fail:
> +	close_netns(nstoken);
> +	return -1;
> +}
> +
> +static void subtest_cleanup(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken;
> +
> +	nstoken =3D open_netns(CLIENT_NS);
> +	SYS_NOFAIL("tc qdisc delete dev veth1 parent ffff:fff1");
> +	SYS_NOFAIL("ip a flush veth1");
> +	close_netns(nstoken);
> +	nstoken =3D open_netns(SERVER_NS);
> +	SYS_NOFAIL("ip link del testtun0");
> +	SYS_NOFAIL("tc qdisc delete dev veth2 parent ffff:fff1");
> +	SYS_NOFAIL("ip a flush veth2");
> +	if (cfg->configure_mpls)
> +		SYS_NOFAIL("ip -f mpls route del 1000 dev lo");
> +	if (cfg->configure_fou_rx_port)
> +		del_fou_rx_port(cfg);
> +
> +	close_netns(nstoken);
> +}
> +
> +static void cleanup(void)
> +{
> +	remove_netns(CLIENT_NS);
> +	remove_netns(SERVER_NS);
> +}
> +
> +static struct subtest_cfg subtests_cfg[] =3D {
> +	{
> +		.ebpf_tun_type =3D "ipip",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "ipip",
> +		.ipproto =3D 4,
> +	},
> +	{
> +		.ebpf_tun_type =3D "ipip6",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "ip6tnl",
> +		.ipproto =3D 4,
> +		.tunnel_client_addr =3D IP6_ADDR_VETH1,
> +		.tunnel_server_addr =3D IP6_ADDR_VETH2,
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6tnl",
> +		.iproute_tun_type =3D "ip6tnl",
> +		.mac_tun_type =3D "none",
> +		.ipproto =3D 6,
> +	},
> +	{
> +		.mac_tun_type =3D "none",
> +		.ebpf_tun_type =3D "sit",
> +		.iproute_tun_type =3D "sit",
> +		.ipproto =3D 6,
> +		.tunnel_client_addr =3D IP4_ADDR_VETH1,
> +		.tunnel_server_addr =3D IP4_ADDR_VETH2,
> +	},
> +	{
> +		.ebpf_tun_type =3D "vxlan",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "vxlan",
> +		.ipproto =3D 4,
> +		.extra_decap_mod_args_cb =3D vxlan_decap_mod_args_cb,
> +		.tunnel_need_veth_mac =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6vxlan",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "vxlan",
> +		.ipproto =3D 6,
> +		.extra_decap_mod_args_cb =3D vxlan_decap_mod_args_cb,
> +		.tunnel_need_veth_mac =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "gre",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "gre",
> +		.ipproto =3D 4,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "gre",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "gretap",
> +		.ipproto =3D 4,
> +		.tunnel_need_veth_mac =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "gre",
> +		.mac_tun_type =3D "mpls",
> +		.iproute_tun_type =3D "gre",
> +		.ipproto =3D 4,
> +		.configure_mpls =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6gre",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "ip6gre",
> +		.ipproto =3D 6,
> +		.test_gso =3D true,
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6gre",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "ip6gretap",
> +		.ipproto =3D 6,
> +		.tunnel_need_veth_mac =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6gre",
> +		.mac_tun_type =3D "mpls",
> +		.iproute_tun_type =3D "ip6gre",
> +		.ipproto =3D 6,
> +		.configure_mpls =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "udp",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "ipip",
> +		.ipproto =3D 4,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "udp",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "ipip",
> +		.ipproto =3D 4,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.expect_kern_decap_failure =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "udp",
> +		.mac_tun_type =3D "mpls",
> +		.iproute_tun_type =3D "ipip",
> +		.ipproto =3D 4,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.tmode =3D "mode any ttl 255",
> +		.configure_mpls =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6udp",
> +		.mac_tun_type =3D "none",
> +		.iproute_tun_type =3D "ip6tnl",
> +		.ipproto =3D 6,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6udp",
> +		.mac_tun_type =3D "eth",
> +		.iproute_tun_type =3D "ip6tnl",
> +		.ipproto =3D 6,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.expect_kern_decap_failure =3D true,
> +		.test_gso =3D true
> +	},
> +	{
> +		.ebpf_tun_type =3D "ip6udp",
> +		.mac_tun_type =3D "mpls",
> +		.iproute_tun_type =3D "ip6tnl",
> +		.ipproto =3D 6,
> +		.extra_decap_mod_args_cb =3D udp_decap_mod_args_cb,
> +		.configure_fou_rx_port =3D true,
> +		.tmode =3D "mode any ttl 255",
> +		.expect_kern_decap_failure =3D true,
> +		.test_gso =3D true
> +	},
> +};
> +
> +void test_tc_tunnel(void)
> +{
> +	struct test_tc_tunnel *skel;
> +	struct subtest_cfg *cfg;
> +	int i, ret;
> +
> +	skel =3D test_tc_tunnel__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open and load"))
> +		return;
> +
> +	if (!ASSERT_OK(setup(), "global setup"))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(subtests_cfg); i++) {
> +		cfg =3D &subtests_cfg[i];
> +		ret =3D build_subtest_name(cfg, cfg->name, TEST_NAME_MAX_LEN);
> +		if (ret < 0 || !test__start_subtest(cfg->name))
> +			continue;
> +		subtest_setup(skel, cfg);
> +		run_test(cfg);
> +		subtest_cleanup(cfg);
> +	}
> +	cleanup();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> index b509e4c99648..7330c61b5730 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -418,7 +418,7 @@ static __always_inline int encap_ipv6(struct __sk_buf=
f *skb, __u8 encap_proto,
>  	return __encap_ipv6(skb, encap_proto, l2_proto, 0);
>  }
> =20
> -SEC("encap_ipip_none")
> +SEC("tc")
>  int __encap_ipip_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -427,7 +427,7 @@ int __encap_ipip_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_gre_none")
> +SEC("tc")
>  int __encap_gre_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -436,7 +436,7 @@ int __encap_gre_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_gre_mpls")
> +SEC("tc")
>  int __encap_gre_mpls(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -445,7 +445,7 @@ int __encap_gre_mpls(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_gre_eth")
> +SEC("tc")
>  int __encap_gre_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -454,7 +454,7 @@ int __encap_gre_eth(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_udp_none")
> +SEC("tc")
>  int __encap_udp_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -463,7 +463,7 @@ int __encap_udp_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_udp_mpls")
> +SEC("tc")
>  int __encap_udp_mpls(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -472,7 +472,7 @@ int __encap_udp_mpls(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_udp_eth")
> +SEC("tc")
>  int __encap_udp_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -481,7 +481,7 @@ int __encap_udp_eth(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_vxlan_eth")
> +SEC("tc")
>  int __encap_vxlan_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -492,7 +492,7 @@ int __encap_vxlan_eth(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_sit_none")
> +SEC("tc")
>  int __encap_sit_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -501,7 +501,7 @@ int __encap_sit_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6tnl_none")
> +SEC("tc")
>  int __encap_ip6tnl_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -510,7 +510,7 @@ int __encap_ip6tnl_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ipip6_none")
> +SEC("tc")
>  int __encap_ipip6_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IP))
> @@ -519,7 +519,7 @@ int __encap_ipip6_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6gre_none")
> +SEC("tc")
>  int __encap_ip6gre_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -528,7 +528,7 @@ int __encap_ip6gre_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6gre_mpls")
> +SEC("tc")
>  int __encap_ip6gre_mpls(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -537,7 +537,7 @@ int __encap_ip6gre_mpls(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6gre_eth")
> +SEC("tc")
>  int __encap_ip6gre_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -546,7 +546,7 @@ int __encap_ip6gre_eth(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6udp_none")
> +SEC("tc")
>  int __encap_ip6udp_none(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -555,7 +555,7 @@ int __encap_ip6udp_none(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6udp_mpls")
> +SEC("tc")
>  int __encap_ip6udp_mpls(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -564,7 +564,7 @@ int __encap_ip6udp_mpls(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6udp_eth")
> +SEC("tc")
>  int __encap_ip6udp_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -573,7 +573,7 @@ int __encap_ip6udp_eth(struct __sk_buff *skb)
>  		return TC_ACT_OK;
>  }
> =20
> -SEC("encap_ip6vxlan_eth")
> +SEC("tc")
>  int __encap_ip6vxlan_eth(struct __sk_buff *skb)
>  {
>  	if (skb->protocol =3D=3D __bpf_constant_htons(ETH_P_IPV6))
> @@ -680,7 +680,7 @@ static int decap_ipv6(struct __sk_buff *skb)
>  			      iph_outer.nexthdr);
>  }
> =20
> -SEC("decap")
> +SEC("tc")
>  int decap_f(struct __sk_buff *skb)
>  {
>  	switch (skb->protocol) {




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


