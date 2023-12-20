Return-Path: <linux-kselftest+bounces-2256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F01819DDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E081C213D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644421353;
	Wed, 20 Dec 2023 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dGRzRcw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADB21356;
	Wed, 20 Dec 2023 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703071191;
	bh=EDVAfRSUjijE8JEEvCWvnAOsf/jfvm0GMLbOeNYZS8k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dGRzRcw5eIIthXXAz/qpuDO4piF/soZKJGMj7WczfNU+ofzh+f02ol2cT75tL8Qu8
	 vVgcfzdDHzMBPKuyXjpinHsRZYlz0fXT82twFk3eoQkBOanOm6oi65k0ySx60QC0+N
	 dXjcB14AFTCuKVyD8QuMK2gSRi2C3r9EGfIXCGaZLXTjKnH9rGzLNKBZON2N4TSe1h
	 9YGwyTzQiTS1yPoesvjuzjzJIBvuvxqxNwh22SvQDFu7uUHtmJFVy7ZIbH+mVQGtPz
	 beEmuYyRrGFqPUVAJGYzBl7ZoJ1EVQ12rUP7pl2ZkEnqqv8N9XwiaFtWptl3WDO6z0
	 ZXxFM9ifBh4Pw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F3ABE37814AA;
	Wed, 20 Dec 2023 11:19:46 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------lddoJYLd040RSbXBNiuMgwPt"
Message-ID: <bc365e13-f02d-4518-801a-a02e51f4f72e@collabora.com>
Date: Wed, 20 Dec 2023 16:19:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v14 10/12] selftests/landlock: Add network tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Dumazet <edumazet@google.com>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
 <20231026014751.414649-11-konstantin.meskhidze@huawei.com>
 <0584f91c-537c-4188-9e4f-04f192565667@collabora.com>
 <20231219.ig7ih7hof4Eu@digikod.net>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231219.ig7ih7hof4Eu@digikod.net>

This is a multi-part message in MIME format.
--------------lddoJYLd040RSbXBNiuMgwPt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/20/23 2:17 PM, Mickaël Salaün wrote:
> Hi Muhammad,
> 
> Thanks for the report.
> 
> On Tue, Dec 19, 2023 at 03:38:55PM +0500, Muhammad Usama Anjum wrote:
>> Hi Konstantin,
>>
>> There are some errors being reported in KernelCI:
>> https://linux.kernelci.org/test/plan/id/657ab2240c761c0bd1e134ee/
>>
>> The following sub-tests are failing:
>> landlock_net_test_protocol_no_sandbox_with_ipv6_tcp_bind_unspec
>> landlock_net_test_protocol_no_sandbox_with_ipv6_udp_bind_unspec
>> landlock_net_test_protocol_tcp_sandbox_with_ipv6_udp_bind_unspec
>>
>> From my initial investigation, I can see that these failures are coming
>> from just finding the wrong return error code (-97 instead of -22). It may
>> be test's issue or the kernel's, not sure yet.
> 
> I cannot reproduce these errors (with the same kernel commit), the
> Defconfig URL is broken. Could you please share the config used for
> tests?
I've also attached the config. I'm generated the config by following:
make defconfig && make kvm_guest.config
scripts/kconfig/merge_config.sh .config tools/testing/selftests/landlock/config

> 
> According to the failing tests, it looks like the network stack returns
> EAFNOSUPPORT instead of EINVAL, which should happen because addr_len <
> SIN6_LEN_RFC2133 (cf. inet6_bind_sk).  I then think that the issue comes
> from an inconsistent error priority with the prot->bind() call in
> inet6_bind_sk() that may return EAFNOSUPPORT when uaddr contains
> AF_UNSPEC. I didn't find such bind() implementations though.
> 
> Could you please validate this theory by removing this call in
> inet6_bind_sk() and run the tests again?
I'll have a look if I can find anything.

> 
> Eric, do you know where are such struct proto bind() implementations and
> why they may return EAFNOSUPPORT?
> 
> Regards,
>  Mickaël
> 
> 
>>
>> Thanks,
>> Usama
>>
>> On 10/26/23 6:47 AM, Konstantin Meskhidze wrote:
>>> Add 82 test suites to check edge cases related to bind() and connect()
>>> actions. They are defined with 6 fixtures and their variants:
>>>
>>> The "protocol" fixture is extended with 12 variants defined as a matrix
>>> of: sandboxed/not-sandboxed, IPv4/IPv6/unix network domain, and
>>> stream/datagram socket. 4 related tests suites are defined:
>>> * bind: Tests with non-landlocked/landlocked ipv4, ipv6 and unix sockets.
>>> * connect: Tests with non-landlocked/landlocked ipv4, ipv6 and unix
>>> sockets.
>>> * bind_unspec: Tests with non-landlocked/landlocked restrictions
>>> for bind action with AF_UNSPEC socket family.
>>> * connect_unspec: Tests with non-landlocked/landlocked restrictions
>>> for connect action with AF_UNSPEC socket family.
>>>
>>> The "ipv4" fixture is extended with 4 variants defined as a matrix
>>> of: sandboxed/not-sandboxed, IPv4/unix network domain, and
>>> stream/datagram socket. 1 related test suite is defined:
>>> * from_unix_to_inet: Tests to make sure unix sockets' actions are not
>>> restricted by Landlock rules applied to TCP ones.
>>>
>>> The "tcp_layers" fixture is extended with 8 variants defined as a matrix
>>> of: IPv4/IPv6 network domain, and different number of landlock rule layers.
>>> 2 related tests suites are defined:
>>> * ruleset_overlap.
>>> * ruleset_expand.
>>>
>>> In the "mini" fixture 4 tests suites are defined:
>>> * network_access_rights: Tests with legitimate access values.
>>> * unknown_access_rights: Tests with invalid attributes, out of access
>>>   range.
>>> * inval:
>>>   - unhandled allowed access.
>>>   - zero access value.
>>> * tcp_port_overflow: Tests with wrong port values more than U16_MAX.
>>>
>>> In the "ipv4_tcp" fixture supports IPv4 network domain, stream socket.
>>> 2 tests suites are defined:
>>> * port_endianness: Tests with big/little endian port formats.
>>> * with_fs: Tests with network bind() socket action within
>>> filesystem directory access test.
>>>
>>> The "port_specific" fixture is extended with 4 variants defined
>>> as a matrix of: sandboxed/not-sandboxed, IPv4/IPv6 network domain,
>>> and stream socket. 2 related tests suites are defined:
>>> * bind_connect_zero: Tests with port 0 value.
>>> * bind_connect_1023: Tests with port 1023 value.
>>>
>>> Test coverage for security/landlock is 94.5% of 932 lines according to
>>> gcc/gcov-9.
>>>
>>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>>> Co-developed-by: Mickaël Salaün <mic@digikod.net>
>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>> ---
>>>
>>> Changes since v13:
>>> * Refactors "port_specific" test fixture:
>>>     - Deletes useless if .. else.
>>>     - Deletes repeating bind to port 0.
>>>     - Deletes useless lines.
>>>     - Adds 2 file descriptors per socket.
>>>     - Updates get_binded helper.
>>>     - Split test suite to bind_connect_zero
>>>       and bind_connect_1023.
>>> * Adds CAP_NET_BIND_SERVICE to set_cap(); it helps
>>> in bind_connect_1023 test.
>>> * Moves with_net test from fs_test.c.
>>> * Renames with_net test to with_fs.
>>> * Refactors with_fs test by adding different
>>> rule types per one ruleset layer.
>>> * Minor fixes.
>>> * Refactors commit message.
>>>
>>> Changes since v12:
>>> * Renames port_zero to port_specific fixture.
>>> * Refactors port_specific test:
>>>     - Adds set_port() and get_binded_port() helpers.
>>>     - Adds checks for port 0, allowed by Landlock in this version.
>>>     - Adds checks for port 1023.
>>> * Refactors commit message.
>>>
>>> Changes since v11:
>>> * Adds ipv4.from_unix_to_tcp test suite to check that socket family is
>>>   the same between a socket and a sockaddr by trying to connect/bind on
>>>   a unix socket (stream or dgram) using an inet family.  Landlock should
>>>   not change the error code.  This found a bug (which needs to be fixed)
>>>   with the TCP restriction.
>>> * Revamps the inet.{bind,connect} tests into protocol.{bind,connect}:
>>>   - Merge bind_connect_unix_dgram_socket, bind_connect_unix_dgram_socket
>>>     and bind_connect_inval_addrlen into it: add a full test matrix of
>>>     IPv4/TCP, IPv6/TCP, IPv4/UDP, IPv6/UDP, unix/stream, unix/dgram, all
>>>     of them with or without sandboxing. This improve coverage and it
>>>     enables to check that a TCP restriction work as expected but doesn't
>>>     restrict other stream or datagram protocols. This also enables to
>>>     check consistency of the network stack with or without Landlock.
>>>     We now have 76 test suites for the network.
>>>   - Add full send/recv checks.
>>>   - Make a generic framework that will be ready for future
>>>     protocol supports.
>>> * Replaces most ASSERT with EXPECT according to the criticity of an
>>>   action: if we can get more meaningful information with following
>>>   checks.  For instance, failure to create a kernel object (e.g.
>>>   socket(), accept() or fork() call) is critical if it is used by
>>>   following checks. For Landlock ruleset building, the following checks
>>>   don't make sense if the sandbox is not complete.  However, it doesn't
>>>   make sense to continue a FIXTURE_SETUP() if any check failed.
>>> * Adds a new unspec fixture to replace inet.bind_afunspec with
>>>   unspec.bind and inet.connect_afunspec with unspec.connect, factoring
>>>   and simplifying code.
>>> * Replaces inet.bind_afunspec with protocol.bind_unspec, and
>>>   inet.connect_afunspec with protocol.connect_unspec.  Extend these
>>>   tests with the matrix of all "protocol" variants.  Don't test connect
>>>   with the same socket which is already binded/listening (I guess this
>>>   was an copy-paste error).  The protocol.bind_unspec tests found a bug
>>>   (which needs to be fixed).
>>> * Add* and use set_service() and setup_loopback() helpers to configure
>>>   network services.  Add and use and test_bind_and_connect() to factor
>>>   out a lot of checks.
>>> * Adds new types (protocol_variant, service_fixture) and update related
>>>   helpers to get more generic test code.
>>> * Replaces static (port) arrays with service_fixture variables.
>>> * Adds new helpers: {bind,connect}_variant_addrlen() and get_addrlen() to
>>>   cover all protocols with previous bind_connect_inval_addrlen tests.
>>>   Make them return -errno in case of error.
>>> * Switchs from a unix socket path address to an abstract one. This
>>>   enables to avoid file cleanup in test teardowns.
>>> * Closes all rulesets after enforcement.
>>> * Removes the duplicate "empty access" test.
>>> * Replaces inet.ruleset_overlay with tcp_layers.ruleset_overlap and
>>>   simplify test:
>>>   - Always run sandbox tests because test were always run sandboxed and
>>>     it doesn't give more guarantees to do it not sandboxed.
>>>   - Rewrite test with variant->num_layers to make it simpler and
>>>     configurable.
>>>   - Add another test layer to tcp_layers used for ruleset_overlap and
>>>     test without sandbox.
>>>   - Leverage test_bind_and_connect() and avoid using SO_REUSEADDR
>>>     because the socket was not listened to, and don't use the same
>>>     socket/FD for server and client.
>>>   - Replace inet.ruleset_expanding with tcp_layers.ruleset_expand.
>>> * Drops capabilities in all FIXTURE_SETUP().
>>> * Changes test ports to cover more ranges.
>>> * Adds "mini" tests:
>>>   - Replace the invalid ruleset attribute test from port.inval with
>>>     mini.unknow_access_rights.
>>>   - Simplify port.inval and move some code to other mini.* tests.
>>>   - Add new mini.network_access_rights test.
>>> * Rewrites inet.inval_port_format into mini.tcp_port_overflow:
>>>   - Remove useless is_sandbox checks.
>>>   - Extend tests with bind/connect checks.
>>>   - Interleave valid requests with invalid ones.
>>> * Adds two_srv.port_endianness test, extracted and extended from
>>>   inet.inval_port_format .
>>> * Adds Microsoft copyright.
>>> * Rename some variables to make them easier to read.
>>> * Constifies variables.
>>> * Adds minimal logs to help debug test failures.
>>> * Renames inet test to ipv4 and deletes is_sandboxed and prot vars from
>>>   FIXTURE_VARIANT.
>>> * Adds port_zero tests.
>>> * Renames all "net_service" to "net_port".
>>>
>>> Changes since v10:
>>> * Replaces FIXTURE_VARIANT() with struct _fixture_variant_ .
>>> * Changes tests names socket -> inet, standalone -> port.
>>> * Gets rid of some DEFINEs.
>>> * Changes names and groups tests' variables.
>>> * Changes create_socket_variant() helper name to socket_variant().
>>> * Refactors FIXTURE_SETUP(port) logic.
>>> * Changes TEST_F_FORK -> TEST_F since there no teardown.
>>> * Refactors some tests' logic.
>>> * Minor fixes.
>>> * Refactors commit message.
>>>
>>> Changes since v9:
>>> * Fixes mixing code declaration and code.
>>> * Refactors FIXTURE_TEARDOWN() with clang-format.
>>> * Replaces struct _fixture_variant_socket with
>>> FIXTURE_VARIANT(socket).
>>> * Deletes useless condition if (variant->is_sandboxed)
>>> in multiple locations.
>>> * Deletes zero_size argument in bind_variant() and
>>> connect_variant().
>>> * Adds tests for port values exceeding U16_MAX.
>>>
>>> Changes since v8:
>>> * Adds is_sandboxed const for FIXTURE_VARIANT(socket).
>>> * Refactors AF_UNSPEC tests.
>>> * Adds address length checking tests.
>>> * Convert ports in all tests to __be16.
>>> * Adds invalid port values tests.
>>> * Minor fixes.
>>>
>>> Changes since v7:
>>> * Squashes all selftest commits.
>>> * Adds fs test with network bind() socket action.
>>> * Minor fixes.
>>>
>>> ---
>>>  tools/testing/selftests/landlock/common.h   |    3 +
>>>  tools/testing/selftests/landlock/config     |    4 +
>>>  tools/testing/selftests/landlock/net_test.c | 1744 +++++++++++++++++++
>>>  3 files changed, 1751 insertions(+)
>>>  create mode 100644 tools/testing/selftests/landlock/net_test.c
>>>
>>> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
>>> index 0fd6c4cf5e6f..5b79758cae62 100644
>>> --- a/tools/testing/selftests/landlock/common.h
>>> +++ b/tools/testing/selftests/landlock/common.h
>>> @@ -112,10 +112,13 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>>>  	cap_t cap_p;
>>>  	/* Only these three capabilities are useful for the tests. */
>>>  	const cap_value_t caps[] = {
>>> +		/* clang-format off */
>>>  		CAP_DAC_OVERRIDE,
>>>  		CAP_MKNOD,
>>>  		CAP_SYS_ADMIN,
>>>  		CAP_SYS_CHROOT,
>>> +		CAP_NET_BIND_SERVICE,
>>> +		/* clang-format on */
>>>  	};
>>>
>>>  	cap_p = cap_get_proc();
>>> diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
>>> index 3dc9e438eab1..0086efaa7b68 100644
>>> --- a/tools/testing/selftests/landlock/config
>>> +++ b/tools/testing/selftests/landlock/config
>>> @@ -1,5 +1,9 @@
>>>  CONFIG_CGROUPS=y
>>>  CONFIG_CGROUP_SCHED=y
>>> +CONFIG_INET=y
>>> +CONFIG_IPV6=y
>>> +CONFIG_NET=y
>>> +CONFIG_NET_NS=y
>>>  CONFIG_OVERLAY_FS=y
>>>  CONFIG_PROC_FS=y
>>>  CONFIG_SECURITY=y
>>> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
>>> new file mode 100644
>>> index 000000000000..3c0a10f9811a
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/landlock/net_test.c
>>> @@ -0,0 +1,1744 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Landlock tests - Network
>>> + *
>>> + * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>>> + * Copyright © 2023 Microsoft Corporation
>>> + */
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <arpa/inet.h>
>>> +#include <errno.h>
>>> +#include <fcntl.h>
>>> +#include <linux/landlock.h>
>>> +#include <linux/in.h>
>>> +#include <sched.h>
>>> +#include <stdint.h>
>>> +#include <string.h>
>>> +#include <sys/prctl.h>
>>> +#include <sys/socket.h>
>>> +#include <sys/un.h>
>>> +
>>> +#include "common.h"
>>> +
>>> +const short sock_port_start = (1 << 10);
>>> +
>>> +static const char loopback_ipv4[] = "127.0.0.1";
>>> +static const char loopback_ipv6[] = "::1";
>>> +
>>> +/* Number pending connections queue to be hold. */
>>> +const short backlog = 10;
>>> +
>>> +enum sandbox_type {
>>> +	NO_SANDBOX,
>>> +	/* This may be used to test rules that allow *and* deny accesses. */
>>> +	TCP_SANDBOX,
>>> +};
>>> +
>>> +struct protocol_variant {
>>> +	int domain;
>>> +	int type;
>>> +};
>>> +
>>> +struct service_fixture {
>>> +	struct protocol_variant protocol;
>>> +	/* port is also stored in ipv4_addr.sin_port or ipv6_addr.sin6_port */
>>> +	unsigned short port;
>>> +	union {
>>> +		struct sockaddr_in ipv4_addr;
>>> +		struct sockaddr_in6 ipv6_addr;
>>> +		struct {
>>> +			struct sockaddr_un unix_addr;
>>> +			socklen_t unix_addr_len;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +static int set_service(struct service_fixture *const srv,
>>> +		       const struct protocol_variant prot,
>>> +		       const unsigned short index)
>>> +{
>>> +	memset(srv, 0, sizeof(*srv));
>>> +
>>> +	/*
>>> +	 * Copies all protocol properties in case of the variant only contains
>>> +	 * a subset of them.
>>> +	 */
>>> +	srv->protocol = prot;
>>> +
>>> +	/* Checks for port overflow. */
>>> +	if (index > 2)
>>> +		return 1;
>>> +	srv->port = sock_port_start << (2 * index);
>>> +
>>> +	switch (prot.domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		srv->ipv4_addr.sin_family = prot.domain;
>>> +		srv->ipv4_addr.sin_port = htons(srv->port);
>>> +		srv->ipv4_addr.sin_addr.s_addr = inet_addr(loopback_ipv4);
>>> +		return 0;
>>> +
>>> +	case AF_INET6:
>>> +		srv->ipv6_addr.sin6_family = prot.domain;
>>> +		srv->ipv6_addr.sin6_port = htons(srv->port);
>>> +		inet_pton(AF_INET6, loopback_ipv6, &srv->ipv6_addr.sin6_addr);
>>> +		return 0;
>>> +
>>> +	case AF_UNIX:
>>> +		srv->unix_addr.sun_family = prot.domain;
>>> +		sprintf(srv->unix_addr.sun_path,
>>> +			"_selftests-landlock-net-tid%d-index%d", gettid(),
>>> +			index);
>>> +		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
>>> +		srv->unix_addr.sun_path[0] = '\0';
>>> +		return 0;
>>> +	}
>>> +	return 1;
>>> +}
>>> +
>>> +static void setup_loopback(struct __test_metadata *const _metadata)
>>> +{
>>> +	set_cap(_metadata, CAP_SYS_ADMIN);
>>> +	ASSERT_EQ(0, unshare(CLONE_NEWNET));
>>> +	ASSERT_EQ(0, system("ip link set dev lo up"));
>>> +	clear_cap(_metadata, CAP_SYS_ADMIN);
>>> +}
>>> +
>>> +static bool is_restricted(const struct protocol_variant *const prot,
>>> +			  const enum sandbox_type sandbox)
>>> +{
>>> +	switch (prot->domain) {
>>> +	case AF_INET:
>>> +	case AF_INET6:
>>> +		switch (prot->type) {
>>> +		case SOCK_STREAM:
>>> +			return sandbox == TCP_SANDBOX;
>>> +		}
>>> +		break;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> +static int socket_variant(const struct service_fixture *const srv)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = socket(srv->protocol.domain, srv->protocol.type | SOCK_CLOEXEC,
>>> +		     0);
>>> +	if (ret < 0)
>>> +		return -errno;
>>> +	return ret;
>>> +}
>>> +
>>> +#ifndef SIN6_LEN_RFC2133
>>> +#define SIN6_LEN_RFC2133 24
>>> +#endif
>>> +
>>> +static socklen_t get_addrlen(const struct service_fixture *const srv,
>>> +			     const bool minimal)
>>> +{
>>> +	switch (srv->protocol.domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		return sizeof(srv->ipv4_addr);
>>> +
>>> +	case AF_INET6:
>>> +		if (minimal)
>>> +			return SIN6_LEN_RFC2133;
>>> +		return sizeof(srv->ipv6_addr);
>>> +
>>> +	case AF_UNIX:
>>> +		if (minimal)
>>> +			return sizeof(srv->unix_addr) -
>>> +			       sizeof(srv->unix_addr.sun_path);
>>> +		return srv->unix_addr_len;
>>> +
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +static void set_port(struct service_fixture *const srv, uint16_t port)
>>> +{
>>> +	switch (srv->protocol.domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		srv->ipv4_addr.sin_port = htons(port);
>>> +		return;
>>> +
>>> +	case AF_INET6:
>>> +		srv->ipv6_addr.sin6_port = htons(port);
>>> +		return;
>>> +
>>> +	default:
>>> +		return;
>>> +	}
>>> +}
>>> +
>>> +static uint16_t get_binded_port(int socket_fd,
>>> +				const struct protocol_variant *const prot)
>>> +{
>>> +	struct sockaddr_in ipv4_addr;
>>> +	struct sockaddr_in6 ipv6_addr;
>>> +	socklen_t ipv4_addr_len, ipv6_addr_len;
>>> +
>>> +	/* Gets binded port. */
>>> +	switch (prot->domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		ipv4_addr_len = sizeof(ipv4_addr);
>>> +		getsockname(socket_fd, &ipv4_addr, &ipv4_addr_len);
>>> +		return ntohs(ipv4_addr.sin_port);
>>> +
>>> +	case AF_INET6:
>>> +		ipv6_addr_len = sizeof(ipv6_addr);
>>> +		getsockname(socket_fd, &ipv6_addr, &ipv6_addr_len);
>>> +		return ntohs(ipv6_addr.sin6_port);
>>> +
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +static int bind_variant_addrlen(const int sock_fd,
>>> +				const struct service_fixture *const srv,
>>> +				const socklen_t addrlen)
>>> +{
>>> +	int ret;
>>> +
>>> +	switch (srv->protocol.domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		ret = bind(sock_fd, &srv->ipv4_addr, addrlen);
>>> +		break;
>>> +
>>> +	case AF_INET6:
>>> +		ret = bind(sock_fd, &srv->ipv6_addr, addrlen);
>>> +		break;
>>> +
>>> +	case AF_UNIX:
>>> +		ret = bind(sock_fd, &srv->unix_addr, addrlen);
>>> +		break;
>>> +
>>> +	default:
>>> +		errno = EAFNOSUPPORT;
>>> +		return -errno;
>>> +	}
>>> +
>>> +	if (ret < 0)
>>> +		return -errno;
>>> +	return ret;
>>> +}
>>> +
>>> +static int bind_variant(const int sock_fd,
>>> +			const struct service_fixture *const srv)
>>> +{
>>> +	return bind_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
>>> +}
>>> +
>>> +static int connect_variant_addrlen(const int sock_fd,
>>> +				   const struct service_fixture *const srv,
>>> +				   const socklen_t addrlen)
>>> +{
>>> +	int ret;
>>> +
>>> +	switch (srv->protocol.domain) {
>>> +	case AF_UNSPEC:
>>> +	case AF_INET:
>>> +		ret = connect(sock_fd, &srv->ipv4_addr, addrlen);
>>> +		break;
>>> +
>>> +	case AF_INET6:
>>> +		ret = connect(sock_fd, &srv->ipv6_addr, addrlen);
>>> +		break;
>>> +
>>> +	case AF_UNIX:
>>> +		ret = connect(sock_fd, &srv->unix_addr, addrlen);
>>> +		break;
>>> +
>>> +	default:
>>> +		errno = -EAFNOSUPPORT;
>>> +		return -errno;
>>> +	}
>>> +
>>> +	if (ret < 0)
>>> +		return -errno;
>>> +	return ret;
>>> +}
>>> +
>>> +static int connect_variant(const int sock_fd,
>>> +			   const struct service_fixture *const srv)
>>> +{
>>> +	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
>>> +}
>>> +
>>> +FIXTURE(protocol)
>>> +{
>>> +	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
>>> +};
>>> +
>>> +FIXTURE_VARIANT(protocol)
>>> +{
>>> +	const enum sandbox_type sandbox;
>>> +	const struct protocol_variant prot;
>>> +};
>>> +
>>> +FIXTURE_SETUP(protocol)
>>> +{
>>> +	const struct protocol_variant prot_unspec = {
>>> +		.domain = AF_UNSPEC,
>>> +		.type = SOCK_STREAM,
>>> +	};
>>> +
>>> +	disable_caps(_metadata);
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
>>> +	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
>>> +	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->unspec_any0, prot_unspec, 0));
>>> +	self->unspec_any0.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(protocol)
>>> +{
>>> +}
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_unix_stream) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_UNIX,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_unix_datagram) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_UNIX,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_stream) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_UNIX,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_UNIX,
>>> +		.type = SOCK_DGRAM,
>>> +	},
>>> +};
>>> +
>>> +static void test_bind_and_connect(struct __test_metadata *const _metadata,
>>> +				  const struct service_fixture *const srv,
>>> +				  const bool deny_bind, const bool deny_connect)
>>> +{
>>> +	char buf = '\0';
>>> +	int inval_fd, bind_fd, client_fd, status, ret;
>>> +	pid_t child;
>>> +
>>> +	/* Starts invalid addrlen tests with bind. */
>>> +	inval_fd = socket_variant(srv);
>>> +	ASSERT_LE(0, inval_fd)
>>> +	{
>>> +		TH_LOG("Failed to create socket: %s", strerror(errno));
>>> +	}
>>> +
>>> +	/* Tries to bind with zero as addrlen. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant_addrlen(inval_fd, srv, 0));
>>> +
>>> +	/* Tries to bind with too small addrlen. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant_addrlen(inval_fd, srv,
>>> +						get_addrlen(srv, true) - 1));
>>> +
>>> +	/* Tries to bind with minimal addrlen. */
>>> +	ret = bind_variant_addrlen(inval_fd, srv, get_addrlen(srv, true));
>>> +	if (deny_bind) {
>>> +		EXPECT_EQ(-EACCES, ret);
>>> +	} else {
>>> +		EXPECT_EQ(0, ret)
>>> +		{
>>> +			TH_LOG("Failed to bind to socket: %s", strerror(errno));
>>> +		}
>>> +	}
>>> +	EXPECT_EQ(0, close(inval_fd));
>>> +
>>> +	/* Starts invalid addrlen tests with connect. */
>>> +	inval_fd = socket_variant(srv);
>>> +	ASSERT_LE(0, inval_fd);
>>> +
>>> +	/* Tries to connect with zero as addrlen. */
>>> +	EXPECT_EQ(-EINVAL, connect_variant_addrlen(inval_fd, srv, 0));
>>> +
>>> +	/* Tries to connect with too small addrlen. */
>>> +	EXPECT_EQ(-EINVAL, connect_variant_addrlen(inval_fd, srv,
>>> +						   get_addrlen(srv, true) - 1));
>>> +
>>> +	/* Tries to connect with minimal addrlen. */
>>> +	ret = connect_variant_addrlen(inval_fd, srv, get_addrlen(srv, true));
>>> +	if (srv->protocol.domain == AF_UNIX) {
>>> +		EXPECT_EQ(-EINVAL, ret);
>>> +	} else if (deny_connect) {
>>> +		EXPECT_EQ(-EACCES, ret);
>>> +	} else if (srv->protocol.type == SOCK_STREAM) {
>>> +		/* No listening server, whatever the value of deny_bind. */
>>> +		EXPECT_EQ(-ECONNREFUSED, ret);
>>> +	} else {
>>> +		EXPECT_EQ(0, ret)
>>> +		{
>>> +			TH_LOG("Failed to connect to socket: %s",
>>> +			       strerror(errno));
>>> +		}
>>> +	}
>>> +	EXPECT_EQ(0, close(inval_fd));
>>> +
>>> +	/* Starts connection tests. */
>>> +	bind_fd = socket_variant(srv);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	ret = bind_variant(bind_fd, srv);
>>> +	if (deny_bind) {
>>> +		EXPECT_EQ(-EACCES, ret);
>>> +	} else {
>>> +		EXPECT_EQ(0, ret);
>>> +
>>> +		/* Creates a listening socket. */
>>> +		if (srv->protocol.type == SOCK_STREAM)
>>> +			EXPECT_EQ(0, listen(bind_fd, backlog));
>>> +	}
>>> +
>>> +	child = fork();
>>> +	ASSERT_LE(0, child);
>>> +	if (child == 0) {
>>> +		int connect_fd, ret;
>>> +
>>> +		/* Closes listening socket for the child. */
>>> +		EXPECT_EQ(0, close(bind_fd));
>>> +
>>> +		/* Starts connection tests. */
>>> +		connect_fd = socket_variant(srv);
>>> +		ASSERT_LE(0, connect_fd);
>>> +		ret = connect_variant(connect_fd, srv);
>>> +		if (deny_connect) {
>>> +			EXPECT_EQ(-EACCES, ret);
>>> +		} else if (deny_bind) {
>>> +			/* No listening server. */
>>> +			EXPECT_EQ(-ECONNREFUSED, ret);
>>> +		} else {
>>> +			EXPECT_EQ(0, ret);
>>> +			EXPECT_EQ(1, write(connect_fd, ".", 1));
>>> +		}
>>> +
>>> +		EXPECT_EQ(0, close(connect_fd));
>>> +		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>>> +		return;
>>> +	}
>>> +
>>> +	/* Accepts connection from the child. */
>>> +	client_fd = bind_fd;
>>> +	if (!deny_bind && !deny_connect) {
>>> +		if (srv->protocol.type == SOCK_STREAM) {
>>> +			client_fd = accept(bind_fd, NULL, 0);
>>> +			ASSERT_LE(0, client_fd);
>>> +		}
>>> +
>>> +		EXPECT_EQ(1, read(client_fd, &buf, 1));
>>> +		EXPECT_EQ('.', buf);
>>> +	}
>>> +
>>> +	EXPECT_EQ(child, waitpid(child, &status, 0));
>>> +	EXPECT_EQ(1, WIFEXITED(status));
>>> +	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
>>> +
>>> +	/* Closes connection, if any. */
>>> +	if (client_fd != bind_fd)
>>> +		EXPECT_LE(0, close(client_fd));
>>> +
>>> +	/* Closes listening socket. */
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +}
>>> +
>>> +TEST_F(protocol, bind)
>>> +{
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_connect_p1 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = self->srv1.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Allows connect and bind for the first port.  */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_p0, 0));
>>> +
>>> +		/* Allows connect and denies bind for the second port. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_connect_p1, 0));
>>> +
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	/* Binds a socket to the first port. */
>>> +	test_bind_and_connect(_metadata, &self->srv0, false, false);
>>> +
>>> +	/* Binds a socket to the second port. */
>>> +	test_bind_and_connect(_metadata, &self->srv1,
>>> +			      is_restricted(&variant->prot, variant->sandbox),
>>> +			      false);
>>> +
>>> +	/* Binds a socket to the third port. */
>>> +	test_bind_and_connect(_metadata, &self->srv2,
>>> +			      is_restricted(&variant->prot, variant->sandbox),
>>> +			      is_restricted(&variant->prot, variant->sandbox));
>>> +}
>>> +
>>> +TEST_F(protocol, connect)
>>> +{
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_bind_p1 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +			.port = self->srv1.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Allows connect and bind for the first port. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_p0, 0));
>>> +
>>> +		/* Allows bind and denies connect for the second port. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_p1, 0));
>>> +
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	test_bind_and_connect(_metadata, &self->srv0, false, false);
>>> +
>>> +	test_bind_and_connect(_metadata, &self->srv1, false,
>>> +			      is_restricted(&variant->prot, variant->sandbox));
>>> +
>>> +	test_bind_and_connect(_metadata, &self->srv2,
>>> +			      is_restricted(&variant->prot, variant->sandbox),
>>> +			      is_restricted(&variant->prot, variant->sandbox));
>>> +}
>>> +
>>> +TEST_F(protocol, bind_unspec)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_bind = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = self->srv0.port,
>>> +	};
>>> +	int bind_fd, ret;
>>> +
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const int ruleset_fd = landlock_create_ruleset(
>>> +			&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Allows bind. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	/* Allowed bind on AF_UNSPEC/INADDR_ANY. */
>>> +	ret = bind_variant(bind_fd, &self->unspec_any0);
>>> +	if (variant->prot.domain == AF_INET) {
>>> +		EXPECT_EQ(0, ret)
>>> +		{
>>> +			TH_LOG("Failed to bind to unspec/any socket: %s",
>>> +			       strerror(errno));
>>> +		}
>>> +	} else {
>>> +		EXPECT_EQ(-EINVAL, ret);
>>> +	}
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const int ruleset_fd = landlock_create_ruleset(
>>> +			&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Denies bind. */
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	/* Denied bind on AF_UNSPEC/INADDR_ANY. */
>>> +	ret = bind_variant(bind_fd, &self->unspec_any0);
>>> +	if (variant->prot.domain == AF_INET) {
>>> +		if (is_restricted(&variant->prot, variant->sandbox)) {
>>> +			EXPECT_EQ(-EACCES, ret);
>>> +		} else {
>>> +			EXPECT_EQ(0, ret);
>>> +		}
>>> +	} else {
>>> +		EXPECT_EQ(-EINVAL, ret);
>>> +	}
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +
>>> +	/* Checks bind with AF_UNSPEC and the loopback address. */
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +	ret = bind_variant(bind_fd, &self->unspec_srv0);
>>> +	if (variant->prot.domain == AF_INET) {
>>> +		EXPECT_EQ(-EAFNOSUPPORT, ret);
>>> +	} else {
>>> +		EXPECT_EQ(-EINVAL, ret)
>>> +		{
>>> +			TH_LOG("Wrong bind error: %s", strerror(errno));
>>> +		}
>>> +	}
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +}
>>> +
>>> +TEST_F(protocol, connect_unspec)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_connect = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		.port = self->srv0.port,
>>> +	};
>>> +	int bind_fd, client_fd, status;
>>> +	pid_t child;
>>> +
>>> +	/* Specific connection tests. */
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
>>> +	if (self->srv0.protocol.type == SOCK_STREAM)
>>> +		EXPECT_EQ(0, listen(bind_fd, backlog));
>>> +
>>> +	child = fork();
>>> +	ASSERT_LE(0, child);
>>> +	if (child == 0) {
>>> +		int connect_fd, ret;
>>> +
>>> +		/* Closes listening socket for the child. */
>>> +		EXPECT_EQ(0, close(bind_fd));
>>> +
>>> +		connect_fd = socket_variant(&self->srv0);
>>> +		ASSERT_LE(0, connect_fd);
>>> +		EXPECT_EQ(0, connect_variant(connect_fd, &self->srv0));
>>> +
>>> +		/* Tries to connect again, or set peer. */
>>> +		ret = connect_variant(connect_fd, &self->srv0);
>>> +		if (self->srv0.protocol.type == SOCK_STREAM) {
>>> +			EXPECT_EQ(-EISCONN, ret);
>>> +		} else {
>>> +			EXPECT_EQ(0, ret);
>>> +		}
>>> +
>>> +		if (variant->sandbox == TCP_SANDBOX) {
>>> +			const int ruleset_fd = landlock_create_ruleset(
>>> +				&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +			ASSERT_LE(0, ruleset_fd);
>>> +
>>> +			/* Allows connect. */
>>> +			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
>>> +						       LANDLOCK_RULE_NET_PORT,
>>> +						       &tcp_connect, 0));
>>> +			enforce_ruleset(_metadata, ruleset_fd);
>>> +			EXPECT_EQ(0, close(ruleset_fd));
>>> +		}
>>> +
>>> +		/* Disconnects already connected socket, or set peer. */
>>> +		ret = connect_variant(connect_fd, &self->unspec_any0);
>>> +		if (self->srv0.protocol.domain == AF_UNIX &&
>>> +		    self->srv0.protocol.type == SOCK_STREAM) {
>>> +			EXPECT_EQ(-EINVAL, ret);
>>> +		} else {
>>> +			EXPECT_EQ(0, ret);
>>> +		}
>>> +
>>> +		/* Tries to reconnect, or set peer. */
>>> +		ret = connect_variant(connect_fd, &self->srv0);
>>> +		if (self->srv0.protocol.domain == AF_UNIX &&
>>> +		    self->srv0.protocol.type == SOCK_STREAM) {
>>> +			EXPECT_EQ(-EISCONN, ret);
>>> +		} else {
>>> +			EXPECT_EQ(0, ret);
>>> +		}
>>> +
>>> +		if (variant->sandbox == TCP_SANDBOX) {
>>> +			const int ruleset_fd = landlock_create_ruleset(
>>> +				&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +			ASSERT_LE(0, ruleset_fd);
>>> +
>>> +			/* Denies connect. */
>>> +			enforce_ruleset(_metadata, ruleset_fd);
>>> +			EXPECT_EQ(0, close(ruleset_fd));
>>> +		}
>>> +
>>> +		ret = connect_variant(connect_fd, &self->unspec_any0);
>>> +		if (self->srv0.protocol.domain == AF_UNIX &&
>>> +		    self->srv0.protocol.type == SOCK_STREAM) {
>>> +			EXPECT_EQ(-EINVAL, ret);
>>> +		} else {
>>> +			/* Always allowed to disconnect. */
>>> +			EXPECT_EQ(0, ret);
>>> +		}
>>> +
>>> +		EXPECT_EQ(0, close(connect_fd));
>>> +		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>>> +		return;
>>> +	}
>>> +
>>> +	client_fd = bind_fd;
>>> +	if (self->srv0.protocol.type == SOCK_STREAM) {
>>> +		client_fd = accept(bind_fd, NULL, 0);
>>> +		ASSERT_LE(0, client_fd);
>>> +	}
>>> +
>>> +	EXPECT_EQ(child, waitpid(child, &status, 0));
>>> +	EXPECT_EQ(1, WIFEXITED(status));
>>> +	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
>>> +
>>> +	/* Closes connection, if any. */
>>> +	if (client_fd != bind_fd)
>>> +		EXPECT_LE(0, close(client_fd));
>>> +
>>> +	/* Closes listening socket. */
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +}
>>> +
>>> +FIXTURE(ipv4)
>>> +{
>>> +	struct service_fixture srv0, srv1;
>>> +};
>>> +
>>> +FIXTURE_VARIANT(ipv4)
>>> +{
>>> +	const enum sandbox_type sandbox;
>>> +	const int type;
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(ipv4, no_sandbox_with_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.type = SOCK_STREAM,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_tcp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.type = SOCK_STREAM,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(ipv4, no_sandbox_with_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.type = SOCK_DGRAM,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_udp) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.type = SOCK_DGRAM,
>>> +};
>>> +
>>> +FIXTURE_SETUP(ipv4)
>>> +{
>>> +	const struct protocol_variant prot = {
>>> +		.domain = AF_INET,
>>> +		.type = variant->type,
>>> +	};
>>> +
>>> +	disable_caps(_metadata);
>>> +
>>> +	set_service(&self->srv0, prot, 0);
>>> +	set_service(&self->srv1, prot, 1);
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(ipv4)
>>> +{
>>> +}
>>> +
>>> +TEST_F(ipv4, from_unix_to_inet)
>>> +{
>>> +	int unix_stream_fd, unix_dgram_fd;
>>> +
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		/* Denies connect and bind to check errno value. */
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Allows connect and bind for srv0.  */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_p0, 0));
>>> +
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	unix_stream_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>>> +	ASSERT_LE(0, unix_stream_fd);
>>> +
>>> +	unix_dgram_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
>>> +	ASSERT_LE(0, unix_dgram_fd);
>>> +
>>> +	/* Checks unix stream bind and connect for srv0. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_stream_fd, &self->srv0));
>>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_stream_fd, &self->srv0));
>>> +
>>> +	/* Checks unix stream bind and connect for srv1. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_stream_fd, &self->srv1))
>>> +	{
>>> +		TH_LOG("Wrong bind error: %s", strerror(errno));
>>> +	}
>>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_stream_fd, &self->srv1));
>>> +
>>> +	/* Checks unix datagram bind and connect for srv0. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_dgram_fd, &self->srv0));
>>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_dgram_fd, &self->srv0));
>>> +
>>> +	/* Checks unix datagram bind and connect for srv1. */
>>> +	EXPECT_EQ(-EINVAL, bind_variant(unix_dgram_fd, &self->srv1));
>>> +	EXPECT_EQ(-EINVAL, connect_variant(unix_dgram_fd, &self->srv1));
>>> +}
>>> +
>>> +FIXTURE(tcp_layers)
>>> +{
>>> +	struct service_fixture srv0, srv1;
>>> +};
>>> +
>>> +FIXTURE_VARIANT(tcp_layers)
>>> +{
>>> +	const size_t num_layers;
>>> +	const int domain;
>>> +};
>>> +
>>> +FIXTURE_SETUP(tcp_layers)
>>> +{
>>> +	const struct protocol_variant prot = {
>>> +		.domain = variant->domain,
>>> +		.type = SOCK_STREAM,
>>> +	};
>>> +
>>> +	disable_caps(_metadata);
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->srv0, prot, 0));
>>> +	ASSERT_EQ(0, set_service(&self->srv1, prot, 1));
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(tcp_layers)
>>> +{
>>> +}
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, no_sandbox_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET,
>>> +	.num_layers = 0,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, one_sandbox_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET,
>>> +	.num_layers = 1,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, two_sandboxes_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET,
>>> +	.num_layers = 2,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, three_sandboxes_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET,
>>> +	.num_layers = 3,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, no_sandbox_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET6,
>>> +	.num_layers = 0,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, one_sandbox_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET6,
>>> +	.num_layers = 1,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, two_sandboxes_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET6,
>>> +	.num_layers = 2,
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(tcp_layers, three_sandboxes_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.domain = AF_INET6,
>>> +	.num_layers = 3,
>>> +};
>>> +
>>> +TEST_F(tcp_layers, ruleset_overlap)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_bind = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = self->srv0.port,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_bind_connect = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		.port = self->srv0.port,
>>> +	};
>>> +
>>> +	if (variant->num_layers >= 1) {
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Allows bind. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind, 0));
>>> +		/* Also allows bind, but allows connect too. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	if (variant->num_layers >= 2) {
>>> +		int ruleset_fd;
>>> +
>>> +		/* Creates another ruleset layer. */
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Only allows bind. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	if (variant->num_layers >= 3) {
>>> +		int ruleset_fd;
>>> +
>>> +		/* Creates another ruleset layer. */
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Try to allow bind and connect. */
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	/*
>>> +	 * Forbids to connect to the socket because only one ruleset layer
>>> +	 * allows connect.
>>> +	 */
>>> +	test_bind_and_connect(_metadata, &self->srv0, false,
>>> +			      variant->num_layers >= 2);
>>> +}
>>> +
>>> +TEST_F(tcp_layers, ruleset_expand)
>>> +{
>>> +	if (variant->num_layers >= 1) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		};
>>> +		/* Allows bind for srv0. */
>>> +		const struct landlock_net_port_attr bind_srv0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &bind_srv0, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	if (variant->num_layers >= 2) {
>>> +		/* Expands network mask with connect action. */
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		};
>>> +		/* Allows bind for srv0 and connect to srv0. */
>>> +		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		/* Try to allow bind for srv1. */
>>> +		const struct landlock_net_port_attr tcp_bind_p1 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +			.port = self->srv1.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_p0, 0));
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_p1, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	if (variant->num_layers >= 3) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		};
>>> +		/* Allows connect to srv0, without bind rule. */
>>> +		const struct landlock_net_port_attr tcp_bind_p0 = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +			.port = self->srv0.port,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_p0, 0));
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	test_bind_and_connect(_metadata, &self->srv0, false,
>>> +			      variant->num_layers >= 3);
>>> +
>>> +	test_bind_and_connect(_metadata, &self->srv1, variant->num_layers >= 1,
>>> +			      variant->num_layers >= 2);
>>> +}
>>> +
>>> +/* clang-format off */
>>> +FIXTURE(mini) {};
>>> +/* clang-format on */
>>> +
>>> +FIXTURE_SETUP(mini)
>>> +{
>>> +	disable_caps(_metadata);
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(mini)
>>> +{
>>> +}
>>> +
>>> +/* clang-format off */
>>> +
>>> +#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_TCP
>>> +
>>> +#define ACCESS_ALL ( \
>>> +	LANDLOCK_ACCESS_NET_BIND_TCP | \
>>> +	LANDLOCK_ACCESS_NET_CONNECT_TCP)
>>> +
>>> +/* clang-format on */
>>> +
>>> +TEST_F(mini, network_access_rights)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = ACCESS_ALL,
>>> +	};
>>> +	struct landlock_net_port_attr net_port = {
>>> +		.port = sock_port_start,
>>> +	};
>>> +	int ruleset_fd;
>>> +	__u64 access;
>>> +
>>> +	ruleset_fd =
>>> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +
>>> +	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
>>> +		net_port.allowed_access = access;
>>> +		EXPECT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &net_port, 0))
>>> +		{
>>> +			TH_LOG("Failed to add rule with access 0x%llx: %s",
>>> +			       access, strerror(errno));
>>> +		}
>>> +	}
>>> +	EXPECT_EQ(0, close(ruleset_fd));
>>> +}
>>> +
>>> +/* Checks invalid attribute, out of landlock network access range. */
>>> +TEST_F(mini, unknown_access_rights)
>>> +{
>>> +	__u64 access_mask;
>>> +
>>> +	for (access_mask = 1ULL << 63; access_mask != ACCESS_LAST;
>>> +	     access_mask >>= 1) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = access_mask,
>>> +		};
>>> +
>>> +		EXPECT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
>>> +						      sizeof(ruleset_attr), 0));
>>> +		EXPECT_EQ(EINVAL, errno);
>>> +	}
>>> +}
>>> +
>>> +TEST_F(mini, inval)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_bind_connect = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		.port = sock_port_start,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_denied = {
>>> +		.allowed_access = 0,
>>> +		.port = sock_port_start,
>>> +	};
>>> +	const struct landlock_net_port_attr tcp_bind = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = sock_port_start,
>>> +	};
>>> +	int ruleset_fd;
>>> +
>>> +	ruleset_fd =
>>> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +
>>> +	/* Checks unhandled allowed_access. */
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&tcp_bind_connect, 0));
>>> +	EXPECT_EQ(EINVAL, errno);
>>> +
>>> +	/* Checks zero access value. */
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&tcp_denied, 0));
>>> +	EXPECT_EQ(ENOMSG, errno);
>>> +
>>> +	/* Adds with legitimate values. */
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &tcp_bind, 0));
>>> +}
>>> +
>>> +TEST_F(mini, tcp_port_overflow)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +	};
>>> +	const struct landlock_net_port_attr port_max_bind = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = UINT16_MAX,
>>> +	};
>>> +	const struct landlock_net_port_attr port_max_connect = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		.port = UINT16_MAX,
>>> +	};
>>> +	const struct landlock_net_port_attr port_overflow1 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = UINT16_MAX + 1,
>>> +	};
>>> +	const struct landlock_net_port_attr port_overflow2 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = UINT16_MAX + 2,
>>> +	};
>>> +	const struct landlock_net_port_attr port_overflow3 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = UINT32_MAX + 1UL,
>>> +	};
>>> +	const struct landlock_net_port_attr port_overflow4 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = UINT32_MAX + 2UL,
>>> +	};
>>> +	const struct protocol_variant ipv4_tcp = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	};
>>> +	struct service_fixture srv_denied, srv_max_allowed;
>>> +	int ruleset_fd;
>>> +
>>> +	ASSERT_EQ(0, set_service(&srv_denied, ipv4_tcp, 0));
>>> +
>>> +	/* Be careful to avoid port inconsistencies. */
>>> +	srv_max_allowed = srv_denied;
>>> +	srv_max_allowed.port = port_max_bind.port;
>>> +	srv_max_allowed.ipv4_addr.sin_port = htons(port_max_bind.port);
>>> +
>>> +	ruleset_fd =
>>> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &port_max_bind, 0));
>>> +
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&port_overflow1, 0));
>>> +	EXPECT_EQ(EINVAL, errno);
>>> +
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&port_overflow2, 0));
>>> +	EXPECT_EQ(EINVAL, errno);
>>> +
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&port_overflow3, 0));
>>> +	EXPECT_EQ(EINVAL, errno);
>>> +
>>> +	/* Interleaves with invalid rule additions. */
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &port_max_connect, 0));
>>> +
>>> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					&port_overflow4, 0));
>>> +	EXPECT_EQ(EINVAL, errno);
>>> +
>>> +	enforce_ruleset(_metadata, ruleset_fd);
>>> +
>>> +	test_bind_and_connect(_metadata, &srv_denied, true, true);
>>> +	test_bind_and_connect(_metadata, &srv_max_allowed, false, false);
>>> +}
>>> +
>>> +FIXTURE(ipv4_tcp)
>>> +{
>>> +	struct service_fixture srv0, srv1;
>>> +};
>>> +
>>> +FIXTURE_SETUP(ipv4_tcp)
>>> +{
>>> +	const struct protocol_variant ipv4_tcp = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	};
>>> +
>>> +	disable_caps(_metadata);
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->srv0, ipv4_tcp, 0));
>>> +	ASSERT_EQ(0, set_service(&self->srv1, ipv4_tcp, 1));
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(ipv4_tcp)
>>> +{
>>> +}
>>> +
>>> +TEST_F(ipv4_tcp, port_endianness)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr = {
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +	};
>>> +	const struct landlock_net_port_attr bind_host_endian_p0 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		/* Host port format. */
>>> +		.port = self->srv0.port,
>>> +	};
>>> +	const struct landlock_net_port_attr connect_big_endian_p0 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		/* Big endian port format. */
>>> +		.port = htons(self->srv0.port),
>>> +	};
>>> +	const struct landlock_net_port_attr bind_connect_host_endian_p1 = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +		/* Host port format. */
>>> +		.port = self->srv1.port,
>>> +	};
>>> +	const unsigned int one = 1;
>>> +	const char little_endian = *(const char *)&one;
>>> +	int ruleset_fd;
>>> +
>>> +	ruleset_fd =
>>> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &bind_host_endian_p0, 0));
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &connect_big_endian_p0, 0));
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &bind_connect_host_endian_p1, 0));
>>> +	enforce_ruleset(_metadata, ruleset_fd);
>>> +
>>> +	/* No restriction for big endinan CPU. */
>>> +	test_bind_and_connect(_metadata, &self->srv0, false, little_endian);
>>> +
>>> +	/* No restriction for any CPU. */
>>> +	test_bind_and_connect(_metadata, &self->srv1, false, false);
>>> +}
>>> +
>>> +TEST_F_FORK(ipv4_tcp, with_fs)
>>> +{
>>> +	const struct landlock_ruleset_attr ruleset_attr_fs_net = {
>>> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
>>> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +	};
>>> +	struct landlock_path_beneath_attr path_beneath = {
>>> +		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
>>> +		.parent_fd = -1,
>>> +	};
>>> +	struct landlock_net_port_attr tcp_bind = {
>>> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
>>> +		.port = sock_port_start,
>>> +	};
>>> +	int sockfd, ruleset_fd, dirfd, open_dir1, open_dir2;
>>> +	struct sockaddr_in addr4;
>>> +
>>> +	dirfd = open("/dev", O_PATH | O_DIRECTORY | O_CLOEXEC);
>>> +	ASSERT_LE(0, dirfd);
>>> +	path_beneath.parent_fd = dirfd;
>>> +
>>> +	addr4.sin_family = AF_INET;
>>> +	addr4.sin_port = htons(sock_port_start);
>>> +	addr4.sin_addr.s_addr = inet_addr(loopback_ipv4);
>>> +	memset(&addr4.sin_zero, '\0', 8);
>>> +
>>> +	/* Creates ruleset both for filesystem and network access. */
>>> +	ruleset_fd = landlock_create_ruleset(&ruleset_attr_fs_net,
>>> +					     sizeof(ruleset_attr_fs_net), 0);
>>> +	ASSERT_LE(0, ruleset_fd);
>>> +
>>> +	/* Adds a filesystem rule. */
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>>> +				       &path_beneath, 0));
>>> +	/* Adds a network rule. */
>>> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +				       &tcp_bind, 0));
>>> +
>>> +	enforce_ruleset(_metadata, ruleset_fd);
>>> +	ASSERT_EQ(0, close(ruleset_fd));
>>> +
>>> +	/* Tests on a directories with the network rule loaded. */
>>> +	open_dir1 = open("/dev", O_RDONLY);
>>> +	ASSERT_LE(0, open_dir1);
>>> +	ASSERT_EQ(0, close(open_dir1));
>>> +
>>> +	open_dir2 = open("/", O_RDONLY);
>>> +	/* Denied by Landlock. */
>>> +	ASSERT_EQ(-1, open_dir2);
>>> +	EXPECT_EQ(EACCES, errno);
>>> +
>>> +	sockfd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
>>> +	ASSERT_LE(0, sockfd);
>>> +	/* Binds a socket to port 1024. */
>>> +	ASSERT_EQ(0, bind(sockfd, &addr4, sizeof(addr4)));
>>> +
>>> +	/* Closes bounded socket. */
>>> +	ASSERT_EQ(0, close(sockfd));
>>> +}
>>> +
>>> +FIXTURE(port_specific)
>>> +{
>>> +	struct service_fixture srv0;
>>> +};
>>> +
>>> +FIXTURE_VARIANT(port_specific)
>>> +{
>>> +	const enum sandbox_type sandbox;
>>> +	const struct protocol_variant prot;
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv4) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.sandbox = NO_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +/* clang-format off */
>>> +FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv6) {
>>> +	/* clang-format on */
>>> +	.sandbox = TCP_SANDBOX,
>>> +	.prot = {
>>> +		.domain = AF_INET6,
>>> +		.type = SOCK_STREAM,
>>> +	},
>>> +};
>>> +
>>> +FIXTURE_SETUP(port_specific)
>>> +{
>>> +	disable_caps(_metadata);
>>> +
>>> +	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
>>> +
>>> +	setup_loopback(_metadata);
>>> +};
>>> +
>>> +FIXTURE_TEARDOWN(port_specific)
>>> +{
>>> +}
>>> +
>>> +TEST_F(port_specific, bind_connect_zero)
>>> +{
>>> +	int bind_fd, connect_fd, ret;
>>> +	uint16_t port;
>>> +
>>> +	/* Adds a rule layer with bind and connect actions. */
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP
>>> +		};
>>> +		const struct landlock_net_port_attr tcp_bind_connect_zero = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = 0,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		/* Checks zero port value on bind and connect actions. */
>>> +		EXPECT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_zero, 0));
>>> +
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	connect_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, connect_fd);
>>> +
>>> +	/* Sets address port to 0 for both protocol families. */
>>> +	set_port(&self->srv0, 0);
>>> +	/*
>>> +	 * Binds on port 0, which selects a random port within
>>> +	 * ip_local_port_range.
>>> +	 */
>>> +	ret = bind_variant(bind_fd, &self->srv0);
>>> +	EXPECT_EQ(0, ret);
>>> +
>>> +	EXPECT_EQ(0, listen(bind_fd, backlog));
>>> +
>>> +	/* Connects on port 0. */
>>> +	ret = connect_variant(connect_fd, &self->srv0);
>>> +	EXPECT_EQ(-ECONNREFUSED, ret);
>>> +
>>> +	/* Sets binded port for both protocol families. */
>>> +	port = get_binded_port(bind_fd, &variant->prot);
>>> +	EXPECT_NE(0, port);
>>> +	set_port(&self->srv0, port);
>>> +	/* Connects on the binded port. */
>>> +	ret = connect_variant(connect_fd, &self->srv0);
>>> +	if (is_restricted(&variant->prot, variant->sandbox)) {
>>> +		/* Denied by Landlock. */
>>> +		EXPECT_EQ(-EACCES, ret);
>>> +	} else {
>>> +		EXPECT_EQ(0, ret);
>>> +	}
>>> +
>>> +	EXPECT_EQ(0, close(connect_fd));
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +}
>>> +
>>> +TEST_F(port_specific, bind_connect_1023)
>>> +{
>>> +	int bind_fd, connect_fd, ret;
>>> +
>>> +	/* Adds a rule layer with bind and connect actions. */
>>> +	if (variant->sandbox == TCP_SANDBOX) {
>>> +		const struct landlock_ruleset_attr ruleset_attr = {
>>> +			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					      LANDLOCK_ACCESS_NET_CONNECT_TCP
>>> +		};
>>> +		/* A rule with port value less than 1024. */
>>> +		const struct landlock_net_port_attr tcp_bind_connect_low_range = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = 1023,
>>> +		};
>>> +		/* A rule with 1024 port. */
>>> +		const struct landlock_net_port_attr tcp_bind_connect = {
>>> +			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
>>> +					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
>>> +			.port = 1024,
>>> +		};
>>> +		int ruleset_fd;
>>> +
>>> +		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
>>> +						     sizeof(ruleset_attr), 0);
>>> +		ASSERT_LE(0, ruleset_fd);
>>> +
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect_low_range, 0));
>>> +		ASSERT_EQ(0,
>>> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>>> +					    &tcp_bind_connect, 0));
>>> +
>>> +		enforce_ruleset(_metadata, ruleset_fd);
>>> +		EXPECT_EQ(0, close(ruleset_fd));
>>> +	}
>>> +
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	connect_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, connect_fd);
>>> +
>>> +	/* Sets address port to 1023 for both protocol families. */
>>> +	set_port(&self->srv0, 1023);
>>> +	/* Binds on port 1023. */
>>> +	ret = bind_variant(bind_fd, &self->srv0);
>>> +	/* Denied by the system. */
>>> +	EXPECT_EQ(-EACCES, ret);
>>> +
>>> +	set_cap(_metadata, CAP_NET_BIND_SERVICE);
>>> +	/* Binds on port 1023. */
>>> +	ret = bind_variant(bind_fd, &self->srv0);
>>> +	EXPECT_EQ(0, ret);
>>> +	EXPECT_EQ(0, listen(bind_fd, backlog));
>>> +	clear_cap(_metadata, CAP_NET_BIND_SERVICE);
>>> +
>>> +	/* Connects on the binded port 1023. */
>>> +	ret = connect_variant(connect_fd, &self->srv0);
>>> +	EXPECT_EQ(0, ret);
>>> +
>>> +	EXPECT_EQ(0, close(connect_fd));
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +
>>> +	bind_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, bind_fd);
>>> +
>>> +	connect_fd = socket_variant(&self->srv0);
>>> +	ASSERT_LE(0, connect_fd);
>>> +
>>> +	/* Sets address port to 1024 for both protocol families. */
>>> +	set_port(&self->srv0, 1024);
>>> +	/* Binds on port 1024. */
>>> +	ret = bind_variant(bind_fd, &self->srv0);
>>> +	EXPECT_EQ(0, ret);
>>> +	EXPECT_EQ(0, listen(bind_fd, backlog));
>>> +	clear_cap(_metadata, CAP_NET_BIND_SERVICE);
>>> +
>>> +	/* Connects on the binded port 1024. */
>>> +	ret = connect_variant(connect_fd, &self->srv0);
>>> +	EXPECT_EQ(0, ret);
>>> +
>>> +	EXPECT_EQ(0, close(connect_fd));
>>> +	EXPECT_EQ(0, close(bind_fd));
>>> +}
>>> +
>>> +TEST_HARNESS_MAIN
>>> --
>>> 2.25.1
>>>
>>>
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum
>>

-- 
BR,
Muhammad Usama Anjum
--------------lddoJYLd040RSbXBNiuMgwPt
Content-Type: text/plain; charset=UTF-8; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4
L3g4NiA2LjcuMC1yYzUgS2VybmVsIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfQ0NfVkVSU0lP
Tl9URVhUPSJnY2MgKERlYmlhbiAxMy4yLjAtNSkgMTMuMi4wIgpDT05GSUdfQ0NfSVNfR0ND
PXkKQ09ORklHX0dDQ19WRVJTSU9OPTEzMDIwMApDT05GSUdfQ0xBTkdfVkVSU0lPTj0wCkNP
TkZJR19BU19JU19HTlU9eQpDT05GSUdfQVNfVkVSU0lPTj0yNDE1MApDT05GSUdfTERfSVNf
QkZEPXkKQ09ORklHX0xEX1ZFUlNJT049MjQxNTAKQ09ORklHX0xMRF9WRVJTSU9OPTAKQ09O
RklHX0NDX0NBTl9MSU5LPXkKQ09ORklHX0NDX0NBTl9MSU5LX1NUQVRJQz15CkNPTkZJR19D
Q19IQVNfQVNNX0dPVE9fT1VUUFVUPXkKQ09ORklHX0NDX0hBU19BU01fR09UT19USUVEX09V
VFBVVD15CkNPTkZJR19UT09MU19TVVBQT1JUX1JFTFI9eQpDT05GSUdfQ0NfSEFTX0FTTV9J
TkxJTkU9eQpDT05GSUdfQ0NfSEFTX05PX1BST0ZJTEVfRk5fQVRUUj15CkNPTkZJR19QQUhP
TEVfVkVSU0lPTj0xMjQKQ09ORklHX0lSUV9XT1JLPXkKQ09ORklHX0JVSUxEVElNRV9UQUJM
RV9TT1JUPXkKQ09ORklHX1RIUkVBRF9JTkZPX0lOX1RBU0s9eQoKIwojIEdlbmVyYWwgc2V0
dXAKIwpDT05GSUdfSU5JVF9FTlZfQVJHX0xJTUlUPTMyCiMgQ09ORklHX0NPTVBJTEVfVEVT
VCBpcyBub3Qgc2V0CkNPTkZJR19XRVJST1I9eQpDT05GSUdfTE9DQUxWRVJTSU9OPSIiCkNP
TkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJR19CVUlMRF9TQUxUPSIiCkNPTkZJR19I
QVZFX0tFUk5FTF9HWklQPXkKQ09ORklHX0hBVkVfS0VSTkVMX0JaSVAyPXkKQ09ORklHX0hB
VkVfS0VSTkVMX0xaTUE9eQpDT05GSUdfSEFWRV9LRVJORUxfWFo9eQpDT05GSUdfSEFWRV9L
RVJORUxfTFpPPXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaND15CkNPTkZJR19IQVZFX0tFUk5F
TF9aU1REPXkKQ09ORklHX0tFUk5FTF9HWklQPXkKIyBDT05GSUdfS0VSTkVMX0JaSVAyIGlz
IG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTUEgaXMgbm90IHNldAojIENPTkZJR19LRVJO
RUxfWFogaXMgbm90IHNldAojIENPTkZJR19LRVJORUxfTFpPIGlzIG5vdCBzZXQKIyBDT05G
SUdfS0VSTkVMX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9aU1REIGlzIG5vdCBz
ZXQKQ09ORklHX0RFRkFVTFRfSU5JVD0iIgpDT05GSUdfREVGQVVMVF9IT1NUTkFNRT0iKG5v
bmUpIgpDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNPTkZJR19T
WVNWSVBDX0NPTVBBVD15CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpDT05GSUdfUE9TSVhfTVFV
RVVFX1NZU0NUTD15CiMgQ09ORklHX1dBVENIX1FVRVVFIGlzIG5vdCBzZXQKQ09ORklHX0NS
T1NTX01FTU9SWV9BVFRBQ0g9eQojIENPTkZJR19VU0VMSUIgaXMgbm90IHNldApDT05GSUdf
QVVESVQ9eQpDT05GSUdfSEFWRV9BUkNIX0FVRElUU1lTQ0FMTD15CkNPTkZJR19BVURJVFNZ
U0NBTEw9eQoKIwojIElSUSBzdWJzeXN0ZW0KIwpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9
eQpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15CkNPTkZJR19HRU5FUklDX0lSUV9FRkZFQ1RJ
VkVfQUZGX01BU0s9eQpDT05GSUdfR0VORVJJQ19QRU5ESU5HX0lSUT15CkNPTkZJR19HRU5F
UklDX0lSUV9NSUdSQVRJT049eQpDT05GSUdfSEFSRElSUVNfU1dfUkVTRU5EPXkKQ09ORklH
X0lSUV9ET01BSU49eQpDT05GSUdfSVJRX0RPTUFJTl9ISUVSQVJDSFk9eQpDT05GSUdfR0VO
RVJJQ19NU0lfSVJRPXkKQ09ORklHX0lSUV9NU0lfSU9NTVU9eQpDT05GSUdfR0VORVJJQ19J
UlFfTUFUUklYX0FMTE9DQVRPUj15CkNPTkZJR19HRU5FUklDX0lSUV9SRVNFUlZBVElPTl9N
T0RFPXkKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFESU5HPXkKQ09ORklHX1NQQVJTRV9JUlE9
eQojIENPTkZJR19HRU5FUklDX0lSUV9ERUJVR0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJR
IHN1YnN5c3RlbQoKQ09ORklHX0NMT0NLU09VUkNFX1dBVENIRE9HPXkKQ09ORklHX0FSQ0hf
Q0xPQ0tTT1VSQ0VfSU5JVD15CkNPTkZJR19DTE9DS1NPVVJDRV9WQUxJREFURV9MQVNUX0NZ
Q0xFPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJR19HRU5FUklDX0NM
T0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09O
RklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfTUlOX0FESlVTVD15CkNPTkZJR19HRU5FUklDX0NN
T1NfVVBEQVRFPXkKQ09ORklHX0hBVkVfUE9TSVhfQ1BVX1RJTUVSU19UQVNLX1dPUks9eQpD
T05GSUdfUE9TSVhfQ1BVX1RJTUVSU19UQVNLX1dPUks9eQpDT05GSUdfQ09OVEVYVF9UUkFD
S0lORz15CkNPTkZJR19DT05URVhUX1RSQUNLSU5HX0lETEU9eQoKIwojIFRpbWVycyBzdWJz
eXN0ZW0KIwpDT05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haX0NPTU1PTj15CiMg
Q09ORklHX0haX1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX05PX0haX0lETEU9eQojIENP
TkZJR19OT19IWl9GVUxMIGlzIG5vdCBzZXQKQ09ORklHX05PX0haPXkKQ09ORklHX0hJR0hf
UkVTX1RJTUVSUz15CkNPTkZJR19DTE9DS1NPVVJDRV9XQVRDSERPR19NQVhfU0tFV19VUz0x
MjUKIyBlbmQgb2YgVGltZXJzIHN1YnN5c3RlbQoKQ09ORklHX0JQRj15CkNPTkZJR19IQVZF
X0VCUEZfSklUPXkKQ09ORklHX0FSQ0hfV0FOVF9ERUZBVUxUX0JQRl9KSVQ9eQoKIwojIEJQ
RiBzdWJzeXN0ZW0KIwojIENPTkZJR19CUEZfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JQRl9KSVQgaXMgbm90IHNldAojIGVuZCBvZiBCUEYgc3Vic3lzdGVtCgpDT05GSUdfUFJF
RU1QVF9CVUlMRD15CiMgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19Q
UkVFTVBUX1ZPTFVOVEFSWT15CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApDT05GSUdf
UFJFRU1QVF9DT1VOVD15CkNPTkZJR19QUkVFTVBUSU9OPXkKQ09ORklHX1BSRUVNUFRfRFlO
QU1JQz15CiMgQ09ORklHX1NDSEVEX0NPUkUgaXMgbm90IHNldAoKIwojIENQVS9UYXNrIHRp
bWUgYW5kIHN0YXRzIGFjY291bnRpbmcKIwpDT05GSUdfVElDS19DUFVfQUNDT1VOVElORz15
CiMgQ09ORklHX1ZJUlRfQ1BVX0FDQ09VTlRJTkdfR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVJRX1RJTUVfQUNDT1VOVElORyBpcyBub3Qgc2V0CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NU
PXkKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVF9WMyBpcyBub3Qgc2V0CkNPTkZJR19UQVNL
U1RBVFM9eQpDT05GSUdfVEFTS19ERUxBWV9BQ0NUPXkKQ09ORklHX1RBU0tfWEFDQ1Q9eQpD
T05GSUdfVEFTS19JT19BQ0NPVU5USU5HPXkKIyBDT05GSUdfUFNJIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQ1BVL1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNjb3VudGluZwoKQ09ORklHX0NQVV9J
U09MQVRJT049eQoKIwojIFJDVSBTdWJzeXN0ZW0KIwpDT05GSUdfVFJFRV9SQ1U9eQpDT05G
SUdfUFJFRU1QVF9SQ1U9eQojIENPTkZJR19SQ1VfRVhQRVJUIGlzIG5vdCBzZXQKQ09ORklH
X1RSRUVfU1JDVT15CkNPTkZJR19UQVNLU19SQ1VfR0VORVJJQz15CkNPTkZJR19UQVNLU19S
Q1U9eQpDT05GSUdfUkNVX1NUQUxMX0NPTU1PTj15CkNPTkZJR19SQ1VfTkVFRF9TRUdDQkxJ
U1Q9eQojIGVuZCBvZiBSQ1UgU3Vic3lzdGVtCgojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0lLSEVBREVSUyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZU
PTE4CkNPTkZJR19MT0dfQ1BVX01BWF9CVUZfU0hJRlQ9MTIKIyBDT05GSUdfUFJJTlRLX0lO
REVYIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfVU5TVEFCTEVfU0NIRURfQ0xPQ0s9eQoKIwoj
IFNjaGVkdWxlciBmZWF0dXJlcwojCiMgQ09ORklHX1VDTEFNUF9UQVNLIGlzIG5vdCBzZXQK
IyBlbmQgb2YgU2NoZWR1bGVyIGZlYXR1cmVzCgpDT05GSUdfQVJDSF9TVVBQT1JUU19OVU1B
X0JBTEFOQ0lORz15CkNPTkZJR19BUkNIX1dBTlRfQkFUQ0hFRF9VTk1BUF9UTEJfRkxVU0g9
eQpDT05GSUdfQ0NfSEFTX0lOVDEyOD15CkNPTkZJR19DQ19JTVBMSUNJVF9GQUxMVEhST1VH
SD0iLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD01IgpDT05GSUdfR0NDMTFfTk9fQVJSQVlfQk9V
TkRTPXkKQ09ORklHX0NDX05PX0FSUkFZX0JPVU5EUz15CkNPTkZJR19HQ0MxMV9OT19TVFJJ
TkdPUF9PVkVSRkxPVz15CkNPTkZJR19DQ19TVFJJTkdPUF9PVkVSRkxPVz15CkNPTkZJR19B
UkNIX1NVUFBPUlRTX0lOVDEyOD15CiMgQ09ORklHX05VTUFfQkFMQU5DSU5HIGlzIG5vdCBz
ZXQKQ09ORklHX0NHUk9VUFM9eQpDT05GSUdfUEFHRV9DT1VOVEVSPXkKIyBDT05GSUdfQ0dS
T1VQX0ZBVk9SX0RZTk1PRFMgaXMgbm90IHNldAojIENPTkZJR19NRU1DRyBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfQ0dST1VQPXkKQ09ORklHX0NHUk9VUF9TQ0hFRD15CkNPTkZJR19GQUlS
X0dST1VQX1NDSEVEPXkKIyBDT05GSUdfQ0ZTX0JBTkRXSURUSCBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUX0dST1VQX1NDSEVEIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX01NX0NJRD15CkNP
TkZJR19DR1JPVVBfUElEUz15CkNPTkZJR19DR1JPVVBfUkRNQT15CkNPTkZJR19DR1JPVVBf
RlJFRVpFUj15CkNPTkZJR19DR1JPVVBfSFVHRVRMQj15CkNPTkZJR19DUFVTRVRTPXkKQ09O
RklHX1BST0NfUElEX0NQVVNFVD15CkNPTkZJR19DR1JPVVBfREVWSUNFPXkKQ09ORklHX0NH
Uk9VUF9DUFVBQ0NUPXkKQ09ORklHX0NHUk9VUF9QRVJGPXkKQ09ORklHX0NHUk9VUF9NSVND
PXkKQ09ORklHX0NHUk9VUF9ERUJVRz15CkNPTkZJR19TT0NLX0NHUk9VUF9EQVRBPXkKQ09O
RklHX05BTUVTUEFDRVM9eQpDT05GSUdfVVRTX05TPXkKQ09ORklHX1RJTUVfTlM9eQpDT05G
SUdfSVBDX05TPXkKIyBDT05GSUdfVVNFUl9OUyBpcyBub3Qgc2V0CkNPTkZJR19QSURfTlM9
eQpDT05GSUdfTkVUX05TPXkKIyBDT05GSUdfQ0hFQ0tQT0lOVF9SRVNUT1JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NIRURfQVVUT0dST1VQIGlzIG5vdCBzZXQKQ09ORklHX1JFTEFZPXkK
Q09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKQ09O
RklHX1JEX0daSVA9eQpDT05GSUdfUkRfQlpJUDI9eQpDT05GSUdfUkRfTFpNQT15CkNPTkZJ
R19SRF9YWj15CkNPTkZJR19SRF9MWk89eQpDT05GSUdfUkRfTFo0PXkKQ09ORklHX1JEX1pT
VEQ9eQojIENPTkZJR19CT09UX0NPTkZJRyBpcyBub3Qgc2V0CkNPTkZJR19JTklUUkFNRlNf
UFJFU0VSVkVfTVRJTUU9eQpDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1BFUkZPUk1BTkNFPXkK
IyBDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfTERfT1JQ
SEFOX1dBUk49eQpDT05GSUdfTERfT1JQSEFOX1dBUk5fTEVWRUw9ImVycm9yIgpDT05GSUdf
U1lTQ1RMPXkKQ09ORklHX0hBVkVfVUlEMTY9eQpDT05GSUdfU1lTQ1RMX0VYQ0VQVElPTl9U
UkFDRT15CkNPTkZJR19IQVZFX1BDU1BLUl9QTEFURk9STT15CiMgQ09ORklHX0VYUEVSVCBp
cyBub3Qgc2V0CkNPTkZJR19VSUQxNj15CkNPTkZJR19NVUxUSVVTRVI9eQpDT05GSUdfU0dF
VE1BU0tfU1lTQ0FMTD15CkNPTkZJR19TWVNGU19TWVNDQUxMPXkKQ09ORklHX0ZIQU5ETEU9
eQpDT05GSUdfUE9TSVhfVElNRVJTPXkKQ09ORklHX1BSSU5USz15CkNPTkZJR19CVUc9eQpD
T05GSUdfRUxGX0NPUkU9eQpDT05GSUdfUENTUEtSX1BMQVRGT1JNPXkKQ09ORklHX0JBU0Vf
RlVMTD15CkNPTkZJR19GVVRFWD15CkNPTkZJR19GVVRFWF9QST15CkNPTkZJR19FUE9MTD15
CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1FUkZEPXkKQ09ORklHX0VWRU5URkQ9eQpD
T05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0lPX1VSSU5HPXkKQ09ORklHX0FE
VklTRV9TWVNDQUxMUz15CkNPTkZJR19NRU1CQVJSSUVSPXkKQ09ORklHX0tDTVA9eQpDT05G
SUdfUlNFUT15CkNPTkZJR19DQUNIRVNUQVRfU1lTQ0FMTD15CkNPTkZJR19LQUxMU1lNUz15
CiMgQ09ORklHX0tBTExTWU1TX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX0tBTExTWU1T
X0FMTD15CkNPTkZJR19LQUxMU1lNU19BQlNPTFVURV9QRVJDUFU9eQpDT05GSUdfS0FMTFNZ
TVNfQkFTRV9SRUxBVElWRT15CkNPTkZJR19BUkNIX0hBU19NRU1CQVJSSUVSX1NZTkNfQ09S
RT15CkNPTkZJR19IQVZFX1BFUkZfRVZFTlRTPXkKCiMKIyBLZXJuZWwgUGVyZm9ybWFuY2Ug
RXZlbnRzIEFuZCBDb3VudGVycwojCkNPTkZJR19QRVJGX0VWRU5UUz15CiMgQ09ORklHX0RF
QlVHX1BFUkZfVVNFX1ZNQUxMT0MgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgUGVyZm9y
bWFuY2UgRXZlbnRzIEFuZCBDb3VudGVycwoKQ09ORklHX1NZU1RFTV9EQVRBX1ZFUklGSUNB
VElPTj15CkNPTkZJR19QUk9GSUxJTkc9eQpDT05GSUdfVFJBQ0VQT0lOVFM9eQoKIwojIEtl
eGVjIGFuZCBjcmFzaCBmZWF0dXJlcwojCkNPTkZJR19DUkFTSF9DT1JFPXkKQ09ORklHX0tF
WEVDX0NPUkU9eQpDT05GSUdfS0VYRUM9eQojIENPTkZJR19LRVhFQ19GSUxFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0VYRUNfSlVNUCBpcyBub3Qgc2V0CkNPTkZJR19DUkFTSF9EVU1QPXkK
Q09ORklHX0NSQVNIX0hPVFBMVUc9eQpDT05GSUdfQ1JBU0hfTUFYX01FTU9SWV9SQU5HRVM9
ODE5MgojIGVuZCBvZiBLZXhlYyBhbmQgY3Jhc2ggZmVhdHVyZXMKIyBlbmQgb2YgR2VuZXJh
bCBzZXR1cAoKQ09ORklHXzY0QklUPXkKQ09ORklHX1g4Nl82ND15CkNPTkZJR19YODY9eQpD
T05GSUdfSU5TVFJVQ1RJT05fREVDT0RFUj15CkNPTkZJR19PVVRQVVRfRk9STUFUPSJlbGY2
NC14ODYtNjQiCkNPTkZJR19MT0NLREVQX1NVUFBPUlQ9eQpDT05GSUdfU1RBQ0tUUkFDRV9T
VVBQT1JUPXkKQ09ORklHX01NVT15CkNPTkZJR19BUkNIX01NQVBfUk5EX0JJVFNfTUlOPTI4
CkNPTkZJR19BUkNIX01NQVBfUk5EX0JJVFNfTUFYPTMyCkNPTkZJR19BUkNIX01NQVBfUk5E
X0NPTVBBVF9CSVRTX01JTj04CkNPTkZJR19BUkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTX01B
WD0xNgpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX0dFTkVSSUNfQlVHPXkKQ09O
RklHX0dFTkVSSUNfQlVHX1JFTEFUSVZFX1BPSU5URVJTPXkKQ09ORklHX0FSQ0hfTUFZX0hB
VkVfUENfRkRDPXkKQ09ORklHX0dFTkVSSUNfQ0FMSUJSQVRFX0RFTEFZPXkKQ09ORklHX0FS
Q0hfSEFTX0NQVV9SRUxBWD15CkNPTkZJR19BUkNIX0hJQkVSTkFUSU9OX1BPU1NJQkxFPXkK
Q09ORklHX0FSQ0hfU1VTUEVORF9QT1NTSUJMRT15CkNPTkZJR19BVURJVF9BUkNIPXkKQ09O
RklHX0hBVkVfSU5URUxfVFhUPXkKQ09ORklHX1g4Nl82NF9TTVA9eQpDT05GSUdfQVJDSF9T
VVBQT1JUU19VUFJPQkVTPXkKQ09ORklHX0ZJWF9FQVJMWUNPTl9NRU09eQpDT05GSUdfUEdU
QUJMRV9MRVZFTFM9NQpDT05GSUdfQ0NfSEFTX1NBTkVfU1RBQ0tQUk9URUNUT1I9eQoKIwoj
IFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19TTVA9eQojIENPTkZJR19Y
ODZfWDJBUElDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9NUFBBUlNFPXkKIyBDT05GSUdfR09M
REZJU0ggaXMgbm90IHNldAojIENPTkZJR19YODZfQ1BVX1JFU0NUUkwgaXMgbm90IHNldApD
T05GSUdfWDg2X0VYVEVOREVEX1BMQVRGT1JNPXkKIyBDT05GSUdfWDg2X1ZTTVAgaXMgbm90
IHNldAojIENPTkZJR19YODZfR09MREZJU0ggaXMgbm90IHNldAojIENPTkZJR19YODZfSU5U
RUxfTUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lOVEVMX0xQU1MgaXMgbm90IHNldAoj
IENPTkZJR19YODZfQU1EX1BMQVRGT1JNX0RFVklDRSBpcyBub3Qgc2V0CkNPTkZJR19JT1NG
X01CST15CiMgQ09ORklHX0lPU0ZfTUJJX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9T
VVBQT1JUU19NRU1PUllfRkFJTFVSRT15CkNPTkZJR19TQ0hFRF9PTUlUX0ZSQU1FX1BPSU5U
RVI9eQpDT05GSUdfSFlQRVJWSVNPUl9HVUVTVD15CkNPTkZJR19QQVJBVklSVD15CiMgQ09O
RklHX1BBUkFWSVJUX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSQVZJUlRfU1BJTkxP
Q0tTIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9IVl9DQUxMQkFDS19WRUNUT1I9eQojIENPTkZJ
R19YRU4gaXMgbm90IHNldApDT05GSUdfS1ZNX0dVRVNUPXkKQ09ORklHX0FSQ0hfQ1BVSURM
RV9IQUxUUE9MTD15CiMgQ09ORklHX1BWSCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUkFWSVJU
X1RJTUVfQUNDT1VOVElORyBpcyBub3Qgc2V0CkNPTkZJR19QQVJBVklSVF9DTE9DSz15CiMg
Q09ORklHX0pBSUxIT1VTRV9HVUVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUk5fR1VFU1Qg
aXMgbm90IHNldAojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NUFNDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUNPUkUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUT00gaXMgbm90
IHNldApDT05GSUdfR0VORVJJQ19DUFU9eQpDT05GSUdfWDg2X0lOVEVSTk9ERV9DQUNIRV9T
SElGVD02CkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NgpDT05GSUdfWDg2X1RTQz15CkNP
TkZJR19YODZfQ01QWENIRzY0PXkKQ09ORklHX1g4Nl9DTU9WPXkKQ09ORklHX1g4Nl9NSU5J
TVVNX0NQVV9GQU1JTFk9NjQKQ09ORklHX1g4Nl9ERUJVR0NUTE1TUj15CkNPTkZJR19JQTMy
X0ZFQVRfQ1RMPXkKQ09ORklHX1g4Nl9WTVhfRkVBVFVSRV9OQU1FUz15CkNPTkZJR19DUFVf
U1VQX0lOVEVMPXkKQ09ORklHX0NQVV9TVVBfQU1EPXkKQ09ORklHX0NQVV9TVVBfSFlHT049
eQpDT05GSUdfQ1BVX1NVUF9DRU5UQVVSPXkKQ09ORklHX0NQVV9TVVBfWkhBT1hJTj15CkNP
TkZJR19IUEVUX1RJTUVSPXkKQ09ORklHX0hQRVRfRU1VTEFURV9SVEM9eQpDT05GSUdfRE1J
PXkKIyBDT05GSUdfR0FSVF9JT01NVSBpcyBub3Qgc2V0CiMgQ09ORklHX01BWFNNUCBpcyBu
b3Qgc2V0CkNPTkZJR19OUl9DUFVTX1JBTkdFX0JFR0lOPTIKQ09ORklHX05SX0NQVVNfUkFO
R0VfRU5EPTUxMgpDT05GSUdfTlJfQ1BVU19ERUZBVUxUPTY0CkNPTkZJR19OUl9DUFVTPTY0
CkNPTkZJR19TQ0hFRF9DTFVTVEVSPXkKQ09ORklHX1NDSEVEX1NNVD15CkNPTkZJR19TQ0hF
RF9NQz15CkNPTkZJR19TQ0hFRF9NQ19QUklPPXkKQ09ORklHX1g4Nl9MT0NBTF9BUElDPXkK
Q09ORklHX1g4Nl9JT19BUElDPXkKQ09ORklHX1g4Nl9SRVJPVVRFX0ZPUl9CUk9LRU5fQk9P
VF9JUlFTPXkKQ09ORklHX1g4Nl9NQ0U9eQojIENPTkZJR19YODZfTUNFTE9HX0xFR0FDWSBp
cyBub3Qgc2V0CkNPTkZJR19YODZfTUNFX0lOVEVMPXkKQ09ORklHX1g4Nl9NQ0VfQU1EPXkK
Q09ORklHX1g4Nl9NQ0VfVEhSRVNIT0xEPXkKIyBDT05GSUdfWDg2X01DRV9JTkpFQ1QgaXMg
bm90IHNldAoKIwojIFBlcmZvcm1hbmNlIG1vbml0b3JpbmcKIwpDT05GSUdfUEVSRl9FVkVO
VFNfSU5URUxfVU5DT1JFPXkKQ09ORklHX1BFUkZfRVZFTlRTX0lOVEVMX1JBUEw9eQpDT05G
SUdfUEVSRl9FVkVOVFNfSU5URUxfQ1NUQVRFPXkKIyBDT05GSUdfUEVSRl9FVkVOVFNfQU1E
X1BPV0VSIGlzIG5vdCBzZXQKQ09ORklHX1BFUkZfRVZFTlRTX0FNRF9VTkNPUkU9eQojIENP
TkZJR19QRVJGX0VWRU5UU19BTURfQlJTIGlzIG5vdCBzZXQKIyBlbmQgb2YgUGVyZm9ybWFu
Y2UgbW9uaXRvcmluZwoKQ09ORklHX1g4Nl8xNkJJVD15CkNPTkZJR19YODZfRVNQRklYNjQ9
eQpDT05GSUdfWDg2X1ZTWVNDQUxMX0VNVUxBVElPTj15CkNPTkZJR19YODZfSU9QTF9JT1BF
Uk09eQpDT05GSUdfTUlDUk9DT0RFPXkKIyBDT05GSUdfTUlDUk9DT0RFX0xBVEVfTE9BRElO
RyBpcyBub3Qgc2V0CkNPTkZJR19YODZfTVNSPXkKQ09ORklHX1g4Nl9DUFVJRD15CkNPTkZJ
R19YODZfNUxFVkVMPXkKQ09ORklHX1g4Nl9ESVJFQ1RfR0JQQUdFUz15CiMgQ09ORklHX1g4
Nl9DUEFfU1RBVElTVElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9NRU1fRU5DUllQVCBp
cyBub3Qgc2V0CkNPTkZJR19OVU1BPXkKQ09ORklHX0FNRF9OVU1BPXkKQ09ORklHX1g4Nl82
NF9BQ1BJX05VTUE9eQojIENPTkZJR19OVU1BX0VNVSBpcyBub3Qgc2V0CkNPTkZJR19OT0RF
U19TSElGVD02CkNPTkZJR19BUkNIX1NQQVJTRU1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9T
UEFSU0VNRU1fREVGQVVMVD15CkNPTkZJR19BUkNIX1BST0NfS0NPUkVfVEVYVD15CkNPTkZJ
R19JTExFR0FMX1BPSU5URVJfVkFMVUU9MHhkZWFkMDAwMDAwMDAwMDAwCiMgQ09ORklHX1g4
Nl9QTUVNX0xFR0FDWSBpcyBub3Qgc2V0CkNPTkZJR19YODZfQ0hFQ0tfQklPU19DT1JSVVBU
SU9OPXkKQ09ORklHX1g4Nl9CT09UUEFSQU1fTUVNT1JZX0NPUlJVUFRJT05fQ0hFQ0s9eQpD
T05GSUdfTVRSUj15CiMgQ09ORklHX01UUlJfU0FOSVRJWkVSIGlzIG5vdCBzZXQKQ09ORklH
X1g4Nl9QQVQ9eQpDT05GSUdfQVJDSF9VU0VTX1BHX1VOQ0FDSEVEPXkKQ09ORklHX1g4Nl9V
TUlQPXkKQ09ORklHX0NDX0hBU19JQlQ9eQpDT05GSUdfWDg2X0NFVD15CkNPTkZJR19YODZf
S0VSTkVMX0lCVD15CkNPTkZJR19YODZfSU5URUxfTUVNT1JZX1BST1RFQ1RJT05fS0VZUz15
CkNPTkZJR19YODZfSU5URUxfVFNYX01PREVfT0ZGPXkKIyBDT05GSUdfWDg2X0lOVEVMX1RT
WF9NT0RFX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0lOVEVMX1RTWF9NT0RFX0FVVE8g
aXMgbm90IHNldAojIENPTkZJR19YODZfVVNFUl9TSEFET1dfU1RBQ0sgaXMgbm90IHNldApD
T05GSUdfRUZJPXkKQ09ORklHX0VGSV9TVFVCPXkKQ09ORklHX0VGSV9IQU5ET1ZFUl9QUk9U
T0NPTD15CkNPTkZJR19FRklfTUlYRUQ9eQojIENPTkZJR19FRklfRkFLRV9NRU1NQVAgaXMg
bm90IHNldApDT05GSUdfRUZJX1JVTlRJTUVfTUFQPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfSFpfMjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMzAwIGlzIG5v
dCBzZXQKQ09ORklHX0haXzEwMDA9eQpDT05GSUdfSFo9MTAwMApDT05GSUdfU0NIRURfSFJU
SUNLPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUM9eQpDT05GSUdfQVJDSF9TVVBQT1JU
U19LRVhFQ19GSUxFPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfUFVSR0FUT1JZPXkK
Q09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfU0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNf
S0VYRUNfU0lHX0ZPUkNFPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfQlpJTUFHRV9W
RVJJRllfU0lHPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfS0VYRUNfSlVNUD15CkNPTkZJR19B
UkNIX1NVUFBPUlRTX0NSQVNIX0RVTVA9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19DUkFTSF9I
T1RQTFVHPXkKQ09ORklHX0FSQ0hfSEFTX0dFTkVSSUNfQ1JBU0hLRVJORUxfUkVTRVJWQVRJ
T049eQpDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgxMDAwMDAwCkNPTkZJR19SRUxPQ0FUQUJM
RT15CkNPTkZJR19SQU5ET01JWkVfQkFTRT15CkNPTkZJR19YODZfTkVFRF9SRUxPQ1M9eQpD
T05GSUdfUEhZU0lDQUxfQUxJR049MHgyMDAwMDAKQ09ORklHX0RZTkFNSUNfTUVNT1JZX0xB
WU9VVD15CkNPTkZJR19SQU5ET01JWkVfTUVNT1JZPXkKQ09ORklHX1JBTkRPTUlaRV9NRU1P
UllfUEhZU0lDQUxfUEFERElORz0weDAKIyBDT05GSUdfQUREUkVTU19NQVNLSU5HIGlzIG5v
dCBzZXQKQ09ORklHX0hPVFBMVUdfQ1BVPXkKIyBDT05GSUdfQ09NUEFUX1ZEU08gaXMgbm90
IHNldApDT05GSUdfTEVHQUNZX1ZTWVNDQUxMX1hPTkxZPXkKIyBDT05GSUdfTEVHQUNZX1ZT
WVNDQUxMX05PTkUgaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX0JPT0wgaXMgbm90IHNl
dApDT05GSUdfTU9ESUZZX0xEVF9TWVNDQUxMPXkKIyBDT05GSUdfU1RSSUNUX1NJR0FMVFNU
QUNLX1NJWkUgaXMgbm90IHNldApDT05GSUdfSEFWRV9MSVZFUEFUQ0g9eQojIGVuZCBvZiBQ
cm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMKCkNPTkZJR19DQ19IQVNfTkFNRURfQVM9eQpD
T05GSUdfVVNFX1g4Nl9TRUdfU1VQUE9SVD15CkNPTkZJR19DQ19IQVNfU0xTPXkKQ09ORklH
X0NDX0hBU19SRVRVUk5fVEhVTks9eQpDT05GSUdfQ0NfSEFTX0VOVFJZX1BBRERJTkc9eQpD
T05GSUdfRlVOQ1RJT05fUEFERElOR19DRkk9MTEKQ09ORklHX0ZVTkNUSU9OX1BBRERJTkdf
QllURVM9MTYKQ09ORklHX0NBTExfUEFERElORz15CkNPTkZJR19IQVZFX0NBTExfVEhVTktT
PXkKQ09ORklHX0NBTExfVEhVTktTPXkKQ09ORklHX1BSRUZJWF9TWU1CT0xTPXkKQ09ORklH
X1NQRUNVTEFUSU9OX01JVElHQVRJT05TPXkKQ09ORklHX1BBR0VfVEFCTEVfSVNPTEFUSU9O
PXkKQ09ORklHX1JFVFBPTElORT15CkNPTkZJR19SRVRIVU5LPXkKQ09ORklHX0NQVV9VTlJF
VF9FTlRSWT15CkNPTkZJR19DQUxMX0RFUFRIX1RSQUNLSU5HPXkKIyBDT05GSUdfQ0FMTF9U
SFVOS1NfREVCVUcgaXMgbm90IHNldApDT05GSUdfQ1BVX0lCUEJfRU5UUlk9eQpDT05GSUdf
Q1BVX0lCUlNfRU5UUlk9eQpDT05GSUdfQ1BVX1NSU089eQojIENPTkZJR19TTFMgaXMgbm90
IHNldAojIENPTkZJR19HRFNfRk9SQ0VfTUlUSUdBVElPTiBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX0hBU19BRERfUEFHRVM9eQoKIwojIFBvd2VyIG1hbmFnZW1lbnQgYW5kIEFDUEkgb3B0
aW9ucwojCkNPTkZJR19BUkNIX0hJQkVSTkFUSU9OX0hFQURFUj15CkNPTkZJR19TVVNQRU5E
PXkKQ09ORklHX1NVU1BFTkRfRlJFRVpFUj15CkNPTkZJR19ISUJFUk5BVEVfQ0FMTEJBQ0tT
PXkKQ09ORklHX0hJQkVSTkFUSU9OPXkKQ09ORklHX0hJQkVSTkFUSU9OX1NOQVBTSE9UX0RF
Vj15CkNPTkZJR19QTV9TVERfUEFSVElUSU9OPSIiCkNPTkZJR19QTV9TTEVFUD15CkNPTkZJ
R19QTV9TTEVFUF9TTVA9eQojIENPTkZJR19QTV9BVVRPU0xFRVAgaXMgbm90IHNldAojIENP
TkZJR19QTV9VU0VSU1BBQ0VfQVVUT1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1fV0FL
RUxPQ0tTIGlzIG5vdCBzZXQKQ09ORklHX1BNPXkKQ09ORklHX1BNX0RFQlVHPXkKIyBDT05G
SUdfUE1fQURWQU5DRURfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19QTV9URVNUX1NVU1BF
TkQgaXMgbm90IHNldApDT05GSUdfUE1fU0xFRVBfREVCVUc9eQpDT05GSUdfUE1fVFJBQ0U9
eQpDT05GSUdfUE1fVFJBQ0VfUlRDPXkKIyBDT05GSUdfV1FfUE9XRVJfRUZGSUNJRU5UX0RF
RkFVTFQgaXMgbm90IHNldAojIENPTkZJR19FTkVSR1lfTU9ERUwgaXMgbm90IHNldApDT05G
SUdfQVJDSF9TVVBQT1JUU19BQ1BJPXkKQ09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9MRUdB
Q1lfVEFCTEVTX0xPT0tVUD15CkNPTkZJR19BUkNIX01JR0hUX0hBVkVfQUNQSV9QREM9eQpD
T05GSUdfQUNQSV9TWVNURU1fUE9XRVJfU1RBVEVTX1NVUFBPUlQ9eQpDT05GSUdfQUNQSV9U
SEVSTUFMX0xJQj15CiMgQ09ORklHX0FDUElfREVCVUdHRVIgaXMgbm90IHNldApDT05GSUdf
QUNQSV9TUENSX1RBQkxFPXkKIyBDT05GSUdfQUNQSV9GUERUIGlzIG5vdCBzZXQKQ09ORklH
X0FDUElfTFBJVD15CkNPTkZJR19BQ1BJX1NMRUVQPXkKQ09ORklHX0FDUElfUkVWX09WRVJS
SURFX1BPU1NJQkxFPXkKIyBDT05GSUdfQUNQSV9FQ19ERUJVR0ZTIGlzIG5vdCBzZXQKQ09O
RklHX0FDUElfQUM9eQpDT05GSUdfQUNQSV9CQVRURVJZPXkKQ09ORklHX0FDUElfQlVUVE9O
PXkKQ09ORklHX0FDUElfVklERU89eQpDT05GSUdfQUNQSV9GQU49eQojIENPTkZJR19BQ1BJ
X1RBRCBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0RPQ0s9eQpDT05GSUdfQUNQSV9DUFVfRlJF
UV9QU1M9eQpDT05GSUdfQUNQSV9QUk9DRVNTT1JfQ1NUQVRFPXkKQ09ORklHX0FDUElfUFJP
Q0VTU09SX0lETEU9eQpDT05GSUdfQUNQSV9DUFBDX0xJQj15CkNPTkZJR19BQ1BJX1BST0NF
U1NPUj15CkNPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVPXkKIyBDT05GSUdfQUNQSV9QUk9DRVNT
T1JfQUdHUkVHQVRPUiBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX1RIRVJNQUw9eQpDT05GSUdf
QVJDSF9IQVNfQUNQSV9UQUJMRV9VUEdSQURFPXkKQ09ORklHX0FDUElfVEFCTEVfVVBHUkFE
RT15CiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1BDSV9T
TE9UIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfQ09OVEFJTkVSPXkKQ09ORklHX0FDUElfSE9U
UExVR19JT0FQSUM9eQojIENPTkZJR19BQ1BJX1NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FD
UElfSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9DVVNUT01fTUVUSE9EIGlzIG5vdCBz
ZXQKQ09ORklHX0FDUElfQkdSVD15CiMgQ09ORklHX0FDUElfTkZJVCBpcyBub3Qgc2V0CkNP
TkZJR19BQ1BJX05VTUE9eQojIENPTkZJR19BQ1BJX0hNQVQgaXMgbm90IHNldApDT05GSUdf
SEFWRV9BQ1BJX0FQRUk9eQpDT05GSUdfSEFWRV9BQ1BJX0FQRUlfTk1JPXkKIyBDT05GSUdf
QUNQSV9BUEVJIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9EUFRGIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUNQSV9DT05GSUdGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfUEZSVVQgaXMg
bm90IHNldApDT05GSUdfQUNQSV9QQ0M9eQojIENPTkZJR19BQ1BJX0ZGSCBpcyBub3Qgc2V0
CiMgQ09ORklHX1BNSUNfT1BSRUdJT04gaXMgbm90IHNldApDT05GSUdfQUNQSV9QUk1UPXkK
Q09ORklHX1g4Nl9QTV9USU1FUj15CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKQ09O
RklHX0NQVV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9BVFRSX1NFVD15CkNPTkZJR19D
UFVfRlJFUV9HT1ZfQ09NTU9OPXkKIyBDT05GSUdfQ1BVX0ZSRVFfU1RBVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKQ09O
RklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1VTRVJTUEFDRT15CiMgQ09ORklHX0NQVV9GUkVR
X0RFRkFVTFRfR09WX1NDSEVEVVRJTCBpcyBub3Qgc2V0CkNPTkZJR19DUFVfRlJFUV9HT1Zf
UEVSRk9STUFOQ0U9eQojIENPTkZJR19DUFVfRlJFUV9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBz
ZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9VU0VSU1BBQ0U9eQpDT05GSUdfQ1BVX0ZSRVFfR09W
X09OREVNQU5EPXkKIyBDT05GSUdfQ1BVX0ZSRVFfR09WX0NPTlNFUlZBVElWRSBpcyBub3Qg
c2V0CkNPTkZJR19DUFVfRlJFUV9HT1ZfU0NIRURVVElMPXkKCiMKIyBDUFUgZnJlcXVlbmN5
IHNjYWxpbmcgZHJpdmVycwojCkNPTkZJR19YODZfSU5URUxfUFNUQVRFPXkKIyBDT05GSUdf
WDg2X1BDQ19DUFVGUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0FNRF9QU1RBVEUgaXMg
bm90IHNldAojIENPTkZJR19YODZfQU1EX1BTVEFURV9VVCBpcyBub3Qgc2V0CkNPTkZJR19Y
ODZfQUNQSV9DUFVGUkVRPXkKQ09ORklHX1g4Nl9BQ1BJX0NQVUZSRVFfQ1BCPXkKIyBDT05G
SUdfWDg2X1BPV0VSTk9XX0s4IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0FNRF9GUkVRX1NF
TlNJVElWSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1NQRUVEU1RFUF9DRU5UUklOTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9QNF9DTE9DS01PRCBpcyBub3Qgc2V0CgojCiMgc2hh
cmVkIG9wdGlvbnMKIwojIGVuZCBvZiBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKCiMKIyBDUFUg
SWRsZQojCkNPTkZJR19DUFVfSURMRT15CiMgQ09ORklHX0NQVV9JRExFX0dPVl9MQURERVIg
aXMgbm90IHNldApDT05GSUdfQ1BVX0lETEVfR09WX01FTlU9eQojIENPTkZJR19DUFVfSURM
RV9HT1ZfVEVPIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9JRExFX0dPVl9IQUxUUE9MTD15CkNP
TkZJR19IQUxUUE9MTF9DUFVJRExFPXkKIyBlbmQgb2YgQ1BVIElkbGUKCiMgQ09ORklHX0lO
VEVMX0lETEUgaXMgbm90IHNldAojIGVuZCBvZiBQb3dlciBtYW5hZ2VtZW50IGFuZCBBQ1BJ
IG9wdGlvbnMKCiMKIyBCdXMgb3B0aW9ucyAoUENJIGV0Yy4pCiMKQ09ORklHX1BDSV9ESVJF
Q1Q9eQpDT05GSUdfUENJX01NQ09ORklHPXkKQ09ORklHX01NQ09ORl9GQU0xMEg9eQpDT05G
SUdfSVNBX0RNQV9BUEk9eQpDT05GSUdfQU1EX05CPXkKIyBlbmQgb2YgQnVzIG9wdGlvbnMg
KFBDSSBldGMuKQoKIwojIEJpbmFyeSBFbXVsYXRpb25zCiMKQ09ORklHX0lBMzJfRU1VTEFU
SU9OPXkKIyBDT05GSUdfSUEzMl9FTVVMQVRJT05fREVGQVVMVF9ESVNBQkxFRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1g4Nl9YMzJfQUJJIGlzIG5vdCBzZXQKQ09ORklHX0NPTVBBVF8zMj15
CkNPTkZJR19DT01QQVQ9eQpDT05GSUdfQ09NUEFUX0ZPUl9VNjRfQUxJR05NRU5UPXkKIyBl
bmQgb2YgQmluYXJ5IEVtdWxhdGlvbnMKCkNPTkZJR19IQVZFX0tWTT15CkNPTkZJR19WSVJU
VUFMSVpBVElPTj15CiMgQ09ORklHX0tWTSBpcyBub3Qgc2V0CkNPTkZJR19BU19BVlg1MTI9
eQpDT05GSUdfQVNfU0hBMV9OST15CkNPTkZJR19BU19TSEEyNTZfTkk9eQpDT05GSUdfQVNf
VFBBVVNFPXkKQ09ORklHX0FTX0dGTkk9eQpDT05GSUdfQVNfV1JVU1M9eQoKIwojIEdlbmVy
YWwgYXJjaGl0ZWN0dXJlLWRlcGVuZGVudCBvcHRpb25zCiMKQ09ORklHX0hPVFBMVUdfU01U
PXkKQ09ORklHX0hPVFBMVUdfQ09SRV9TWU5DPXkKQ09ORklHX0hPVFBMVUdfQ09SRV9TWU5D
X0RFQUQ9eQpDT05GSUdfSE9UUExVR19DT1JFX1NZTkNfRlVMTD15CkNPTkZJR19IT1RQTFVH
X1NQTElUX1NUQVJUVVA9eQpDT05GSUdfSE9UUExVR19QQVJBTExFTD15CkNPTkZJR19HRU5F
UklDX0VOVFJZPXkKQ09ORklHX0tQUk9CRVM9eQpDT05GSUdfSlVNUF9MQUJFTD15CiMgQ09O
RklHX1NUQVRJQ19LRVlTX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBVElDX0NB
TExfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfT1BUUFJPQkVTPXkKQ09ORklHX1VQUk9C
RVM9eQpDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNPTkZJR19B
UkNIX1VTRV9CVUlMVElOX0JTV0FQPXkKQ09ORklHX0tSRVRQUk9CRVM9eQpDT05GSUdfS1JF
VFBST0JFX09OX1JFVEhPT0s9eQpDT05GSUdfSEFWRV9JT1JFTUFQX1BST1Q9eQpDT05GSUdf
SEFWRV9LUFJPQkVTPXkKQ09ORklHX0hBVkVfS1JFVFBST0JFUz15CkNPTkZJR19IQVZFX09Q
VFBST0JFUz15CkNPTkZJR19IQVZFX0tQUk9CRVNfT05fRlRSQUNFPXkKQ09ORklHX0FSQ0hf
Q09SUkVDVF9TVEFDS1RSQUNFX09OX0tSRVRQUk9CRT15CkNPTkZJR19IQVZFX0ZVTkNUSU9O
X0VSUk9SX0lOSkVDVElPTj15CkNPTkZJR19IQVZFX05NST15CkNPTkZJR19UUkFDRV9JUlFG
TEFHU19TVVBQT1JUPXkKQ09ORklHX1RSQUNFX0lSUUZMQUdTX05NSV9TVVBQT1JUPXkKQ09O
RklHX0hBVkVfQVJDSF9UUkFDRUhPT0s9eQpDT05GSUdfSEFWRV9ETUFfQ09OVElHVU9VUz15
CkNPTkZJR19HRU5FUklDX1NNUF9JRExFX1RIUkVBRD15CkNPTkZJR19BUkNIX0hBU19GT1JU
SUZZX1NPVVJDRT15CkNPTkZJR19BUkNIX0hBU19TRVRfTUVNT1JZPXkKQ09ORklHX0FSQ0hf
SEFTX1NFVF9ESVJFQ1RfTUFQPXkKQ09ORklHX0FSQ0hfSEFTX0NQVV9GSU5BTElaRV9JTklU
PXkKQ09ORklHX0hBVkVfQVJDSF9USFJFQURfU1RSVUNUX1dISVRFTElTVD15CkNPTkZJR19B
UkNIX1dBTlRTX0RZTkFNSUNfVEFTS19TVFJVQ1Q9eQpDT05GSUdfQVJDSF9XQU5UU19OT19J
TlNUUj15CkNPTkZJR19IQVZFX0FTTV9NT0RWRVJTSU9OUz15CkNPTkZJR19IQVZFX1JFR1Nf
QU5EX1NUQUNLX0FDQ0VTU19BUEk9eQpDT05GSUdfSEFWRV9SU0VRPXkKQ09ORklHX0hBVkVf
UlVTVD15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX0FSR19BQ0NFU1NfQVBJPXkKQ09ORklHX0hB
VkVfSFdfQlJFQUtQT0lOVD15CkNPTkZJR19IQVZFX01JWEVEX0JSRUFLUE9JTlRTX1JFR1M9
eQpDT05GSUdfSEFWRV9VU0VSX1JFVFVSTl9OT1RJRklFUj15CkNPTkZJR19IQVZFX1BFUkZf
RVZFTlRTX05NST15CkNPTkZJR19IQVZFX0hBUkRMT0NLVVBfREVURUNUT1JfUEVSRj15CkNP
TkZJR19IQVZFX1BFUkZfUkVHUz15CkNPTkZJR19IQVZFX1BFUkZfVVNFUl9TVEFDS19EVU1Q
PXkKQ09ORklHX0hBVkVfQVJDSF9KVU1QX0xBQkVMPXkKQ09ORklHX0hBVkVfQVJDSF9KVU1Q
X0xBQkVMX1JFTEFUSVZFPXkKQ09ORklHX01NVV9HQVRIRVJfVEFCTEVfRlJFRT15CkNPTkZJ
R19NTVVfR0FUSEVSX1JDVV9UQUJMRV9GUkVFPXkKQ09ORklHX01NVV9HQVRIRVJfTUVSR0Vf
Vk1BUz15CkNPTkZJR19NTVVfTEFaWV9UTEJfUkVGQ09VTlQ9eQpDT05GSUdfQVJDSF9IQVZF
X05NSV9TQUZFX0NNUFhDSEc9eQpDT05GSUdfQVJDSF9IQVNfTk1JX1NBRkVfVEhJU19DUFVf
T1BTPXkKQ09ORklHX0hBVkVfQUxJR05FRF9TVFJVQ1RfUEFHRT15CkNPTkZJR19IQVZFX0NN
UFhDSEdfTE9DQUw9eQpDT05GSUdfSEFWRV9DTVBYQ0hHX0RPVUJMRT15CkNPTkZJR19BUkNI
X1dBTlRfQ09NUEFUX0lQQ19QQVJTRV9WRVJTSU9OPXkKQ09ORklHX0FSQ0hfV0FOVF9PTERf
Q09NUEFUX0lQQz15CkNPTkZJR19IQVZFX0FSQ0hfU0VDQ09NUD15CkNPTkZJR19IQVZFX0FS
Q0hfU0VDQ09NUF9GSUxURVI9eQpDT05GSUdfU0VDQ09NUD15CkNPTkZJR19TRUNDT01QX0ZJ
TFRFUj15CiMgQ09ORklHX1NFQ0NPTVBfQ0FDSEVfREVCVUcgaXMgbm90IHNldApDT05GSUdf
SEFWRV9BUkNIX1NUQUNLTEVBSz15CkNPTkZJR19IQVZFX1NUQUNLUFJPVEVDVE9SPXkKQ09O
RklHX1NUQUNLUFJPVEVDVE9SPXkKQ09ORklHX1NUQUNLUFJPVEVDVE9SX1NUUk9ORz15CkNP
TkZJR19BUkNIX1NVUFBPUlRTX0xUT19DTEFORz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0xU
T19DTEFOR19USElOPXkKQ09ORklHX0xUT19OT05FPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNf
Q0ZJX0NMQU5HPXkKQ09ORklHX0hBVkVfQVJDSF9XSVRISU5fU1RBQ0tfRlJBTUVTPXkKQ09O
RklHX0hBVkVfQ09OVEVYVF9UUkFDS0lOR19VU0VSPXkKQ09ORklHX0hBVkVfQ09OVEVYVF9U
UkFDS0lOR19VU0VSX09GRlNUQUNLPXkKQ09ORklHX0hBVkVfVklSVF9DUFVfQUNDT1VOVElO
R19HRU49eQpDT05GSUdfSEFWRV9JUlFfVElNRV9BQ0NPVU5USU5HPXkKQ09ORklHX0hBVkVf
TU9WRV9QVUQ9eQpDT05GSUdfSEFWRV9NT1ZFX1BNRD15CkNPTkZJR19IQVZFX0FSQ0hfVFJB
TlNQQVJFTlRfSFVHRVBBR0U9eQpDT05GSUdfSEFWRV9BUkNIX1RSQU5TUEFSRU5UX0hVR0VQ
QUdFX1BVRD15CkNPTkZJR19IQVZFX0FSQ0hfSFVHRV9WTUFQPXkKQ09ORklHX0hBVkVfQVJD
SF9IVUdFX1ZNQUxMT0M9eQpDT05GSUdfQVJDSF9XQU5UX0hVR0VfUE1EX1NIQVJFPXkKQ09O
RklHX0hBVkVfQVJDSF9TT0ZUX0RJUlRZPXkKQ09ORklHX0hBVkVfTU9EX0FSQ0hfU1BFQ0lG
SUM9eQpDT05GSUdfTU9EVUxFU19VU0VfRUxGX1JFTEE9eQpDT05GSUdfSEFWRV9JUlFfRVhJ
VF9PTl9JUlFfU1RBQ0s9eQpDT05GSUdfSEFWRV9TT0ZUSVJRX09OX09XTl9TVEFDSz15CkNP
TkZJR19TT0ZUSVJRX09OX09XTl9TVEFDSz15CkNPTkZJR19BUkNIX0hBU19FTEZfUkFORE9N
SVpFPXkKQ09ORklHX0hBVkVfQVJDSF9NTUFQX1JORF9CSVRTPXkKQ09ORklHX0hBVkVfRVhJ
VF9USFJFQUQ9eQpDT05GSUdfQVJDSF9NTUFQX1JORF9CSVRTPTI4CkNPTkZJR19IQVZFX0FS
Q0hfTU1BUF9STkRfQ09NUEFUX0JJVFM9eQpDT05GSUdfQVJDSF9NTUFQX1JORF9DT01QQVRf
QklUUz04CkNPTkZJR19IQVZFX0FSQ0hfQ09NUEFUX01NQVBfQkFTRVM9eQpDT05GSUdfUEFH
RV9TSVpFX0xFU1NfVEhBTl82NEtCPXkKQ09ORklHX1BBR0VfU0laRV9MRVNTX1RIQU5fMjU2
S0I9eQpDT05GSUdfSEFWRV9PQkpUT09MPXkKQ09ORklHX0hBVkVfSlVNUF9MQUJFTF9IQUNL
PXkKQ09ORklHX0hBVkVfTk9JTlNUUl9IQUNLPXkKQ09ORklHX0hBVkVfTk9JTlNUUl9WQUxJ
REFUSU9OPXkKQ09ORklHX0hBVkVfVUFDQ0VTU19WQUxJREFUSU9OPXkKQ09ORklHX0hBVkVf
U1RBQ0tfVkFMSURBVElPTj15CkNPTkZJR19IQVZFX1JFTElBQkxFX1NUQUNLVFJBQ0U9eQpD
T05GSUdfT0xEX1NJR1NVU1BFTkQzPXkKQ09ORklHX0NPTVBBVF9PTERfU0lHQUNUSU9OPXkK
Q09ORklHX0NPTVBBVF8zMkJJVF9USU1FPXkKQ09ORklHX0hBVkVfQVJDSF9WTUFQX1NUQUNL
PXkKQ09ORklHX1ZNQVBfU1RBQ0s9eQpDT05GSUdfSEFWRV9BUkNIX1JBTkRPTUlaRV9LU1RB
Q0tfT0ZGU0VUPXkKQ09ORklHX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUPXkKIyBDT05GSUdf
UkFORE9NSVpFX0tTVEFDS19PRkZTRVRfREVGQVVMVCBpcyBub3Qgc2V0CkNPTkZJR19BUkNI
X0hBU19TVFJJQ1RfS0VSTkVMX1JXWD15CkNPTkZJR19TVFJJQ1RfS0VSTkVMX1JXWD15CkNP
TkZJR19BUkNIX0hBU19TVFJJQ1RfTU9EVUxFX1JXWD15CkNPTkZJR19TVFJJQ1RfTU9EVUxF
X1JXWD15CkNPTkZJR19IQVZFX0FSQ0hfUFJFTDMyX1JFTE9DQVRJT05TPXkKQ09ORklHX0FS
Q0hfVVNFX01FTVJFTUFQX1BST1Q9eQojIENPTkZJR19MT0NLX0VWRU5UX0NPVU5UUyBpcyBu
b3Qgc2V0CkNPTkZJR19BUkNIX0hBU19NRU1fRU5DUllQVD15CkNPTkZJR19IQVZFX1NUQVRJ
Q19DQUxMPXkKQ09ORklHX0hBVkVfU1RBVElDX0NBTExfSU5MSU5FPXkKQ09ORklHX0hBVkVf
UFJFRU1QVF9EWU5BTUlDPXkKQ09ORklHX0hBVkVfUFJFRU1QVF9EWU5BTUlDX0NBTEw9eQpD
T05GSUdfQVJDSF9XQU5UX0xEX09SUEhBTl9XQVJOPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNf
REVCVUdfUEFHRUFMTE9DPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfUEFHRV9UQUJMRV9DSEVD
Sz15CkNPTkZJR19BUkNIX0hBU19FTEZDT1JFX0NPTVBBVD15CkNPTkZJR19BUkNIX0hBU19Q
QVJBTk9JRF9MMURfRkxVU0g9eQpDT05GSUdfRFlOQU1JQ19TSUdGUkFNRT15CkNPTkZJR19B
UkNIX0hBU19OT05MRUFGX1BNRF9ZT1VORz15CgojCiMgR0NPVi1iYXNlZCBrZXJuZWwgcHJv
ZmlsaW5nCiMKIyBDT05GSUdfR0NPVl9LRVJORUwgaXMgbm90IHNldApDT05GSUdfQVJDSF9I
QVNfR0NPVl9QUk9GSUxFX0FMTD15CiMgZW5kIG9mIEdDT1YtYmFzZWQga2VybmVsIHByb2Zp
bGluZwoKQ09ORklHX0hBVkVfR0NDX1BMVUdJTlM9eQpDT05GSUdfRlVOQ1RJT05fQUxJR05N
RU5UXzRCPXkKQ09ORklHX0ZVTkNUSU9OX0FMSUdOTUVOVF8xNkI9eQpDT05GSUdfRlVOQ1RJ
T05fQUxJR05NRU5UPTE2CiMgZW5kIG9mIEdlbmVyYWwgYXJjaGl0ZWN0dXJlLWRlcGVuZGVu
dCBvcHRpb25zCgpDT05GSUdfUlRfTVVURVhFUz15CkNPTkZJR19CQVNFX1NNQUxMPTAKQ09O
RklHX01PRFVMRVM9eQojIENPTkZJR19NT0RVTEVfREVCVUcgaXMgbm90IHNldAojIENPTkZJ
R19NT0RVTEVfRk9SQ0VfTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkK
Q09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQ9eQojIENPTkZJR19NT0RVTEVfVU5MT0FEX1RB
SU5UX1RSQUNLSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVkVSU0lPTlMgaXMgbm90IHNl
dAojIENPTkZJR19NT0RVTEVfU1JDVkVSU0lPTl9BTEwgaXMgbm90IHNldAojIENPTkZJR19N
T0RVTEVfU0lHIGlzIG5vdCBzZXQKQ09ORklHX01PRFVMRV9DT01QUkVTU19OT05FPXkKIyBD
T05GSUdfTU9EVUxFX0NPTVBSRVNTX0daSVAgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVf
Q09NUFJFU1NfWFogaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQ09NUFJFU1NfWlNURCBp
cyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9BTExPV19NSVNTSU5HX05BTUVTUEFDRV9JTVBP
UlRTIGlzIG5vdCBzZXQKQ09ORklHX01PRFBST0JFX1BBVEg9Ii9zYmluL21vZHByb2JlIgpD
T05GSUdfTU9EVUxFU19UUkVFX0xPT0tVUD15CkNPTkZJR19CTE9DSz15CkNPTkZJR19CTE9D
S19MRUdBQ1lfQVVUT0xPQUQ9eQpDT05GSUdfQkxLX1JRX0FMTE9DX1RJTUU9eQpDT05GSUdf
QkxLX0RFVl9CU0dfQ09NTU9OPXkKIyBDT05GSUdfQkxLX0RFVl9CU0dMSUIgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVW
X1dSSVRFX01PVU5URUQ9eQojIENPTkZJR19CTEtfREVWX1pPTkVEIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9USFJPVFRMSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX1dCVCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfQ0dST1VQX0lPTEFURU5DWT15CkNPTkZJR19CTEtfQ0dS
T1VQX0lPQ09TVD15CkNPTkZJR19CTEtfQ0dST1VQX0lPUFJJTz15CkNPTkZJR19CTEtfREVC
VUdfRlM9eQojIENPTkZJR19CTEtfU0VEX09QQUwgaXMgbm90IHNldAojIENPTkZJR19CTEtf
SU5MSU5FX0VOQ1JZUFRJT04gaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCiMg
Q09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJU
SVRJT049eQpDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgZW5kIG9mIFBhcnRpdGlvbiBUeXBl
cwoKQ09ORklHX0JMS19NUV9QQ0k9eQpDT05GSUdfQkxLX01RX1ZJUlRJTz15CkNPTkZJR19C
TEtfUE09eQpDT05GSUdfQkxPQ0tfSE9MREVSX0RFUFJFQ0FURUQ9eQpDT05GSUdfQkxLX01R
X1NUQUNLSU5HPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX01RX0lPU0NIRURfREVB
RExJTkU9eQpDT05GSUdfTVFfSU9TQ0hFRF9LWUJFUj15CiMgQ09ORklHX0lPU0NIRURfQkZR
IGlzIG5vdCBzZXQKIyBlbmQgb2YgSU8gU2NoZWR1bGVycwoKQ09ORklHX0FTTjE9eQpDT05G
SUdfVU5JTkxJTkVfU1BJTl9VTkxPQ0s9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19BVE9NSUNf
Uk1XPXkKQ09ORklHX01VVEVYX1NQSU5fT05fT1dORVI9eQpDT05GSUdfUldTRU1fU1BJTl9P
Tl9PV05FUj15CkNPTkZJR19MT0NLX1NQSU5fT05fT1dORVI9eQpDT05GSUdfQVJDSF9VU0Vf
UVVFVUVEX1NQSU5MT0NLUz15CkNPTkZJR19RVUVVRURfU1BJTkxPQ0tTPXkKQ09ORklHX0FS
Q0hfVVNFX1FVRVVFRF9SV0xPQ0tTPXkKQ09ORklHX1FVRVVFRF9SV0xPQ0tTPXkKQ09ORklH
X0FSQ0hfSEFTX05PTl9PVkVSTEFQUElOR19BRERSRVNTX1NQQUNFPXkKQ09ORklHX0FSQ0hf
SEFTX1NZTkNfQ09SRV9CRUZPUkVfVVNFUk1PREU9eQpDT05GSUdfQVJDSF9IQVNfU1lTQ0FM
TF9XUkFQUEVSPXkKQ09ORklHX0ZSRUVaRVI9eQoKIwojIEV4ZWN1dGFibGUgZmlsZSBmb3Jt
YXRzCiMKQ09ORklHX0JJTkZNVF9FTEY9eQpDT05GSUdfQ09NUEFUX0JJTkZNVF9FTEY9eQpD
T05GSUdfRUxGQ09SRT15CkNPTkZJR19DT1JFX0RVTVBfREVGQVVMVF9FTEZfSEVBREVSUz15
CkNPTkZJR19CSU5GTVRfU0NSSVBUPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkKQ09ORklHX0NP
UkVEVU1QPXkKIyBlbmQgb2YgRXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKCiMKIyBNZW1vcnkg
TWFuYWdlbWVudCBvcHRpb25zCiMKQ09ORklHX1NXQVA9eQojIENPTkZJR19aU1dBUCBpcyBu
b3Qgc2V0CgojCiMgU2xhYiBhbGxvY2F0b3Igb3B0aW9ucwojCkNPTkZJR19TTFVCPXkKQ09O
RklHX1NMQUJfTUVSR0VfREVGQVVMVD15CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9N
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQl9GUkVFTElTVF9IQVJERU5FRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NMVUJfU1RBVFMgaXMgbm90IHNldApDT05GSUdfU0xVQl9DUFVfUEFSVElB
TD15CiMgQ09ORklHX1JBTkRPTV9LTUFMTE9DX0NBQ0hFUyBpcyBub3Qgc2V0CiMgZW5kIG9m
IFNsYWIgYWxsb2NhdG9yIG9wdGlvbnMKCiMgQ09ORklHX1NIVUZGTEVfUEFHRV9BTExPQ0FU
T1IgaXMgbm90IHNldAojIENPTkZJR19DT01QQVRfQlJLIGlzIG5vdCBzZXQKQ09ORklHX1NQ
QVJTRU1FTT15CkNPTkZJR19TUEFSU0VNRU1fRVhUUkVNRT15CkNPTkZJR19TUEFSU0VNRU1f
Vk1FTU1BUF9FTkFCTEU9eQpDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVA9eQpDT05GSUdfQVJD
SF9XQU5UX09QVElNSVpFX0RBWF9WTUVNTUFQPXkKQ09ORklHX0FSQ0hfV0FOVF9PUFRJTUla
RV9IVUdFVExCX1ZNRU1NQVA9eQpDT05GSUdfSEFWRV9GQVNUX0dVUD15CkNPTkZJR19FWENM
VVNJVkVfU1lTVEVNX1JBTT15CkNPTkZJR19BUkNIX0VOQUJMRV9NRU1PUllfSE9UUExVRz15
CiMgQ09ORklHX01FTU9SWV9IT1RQTFVHIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfTUhQX01F
TU1BUF9PTl9NRU1PUllfRU5BQkxFPXkKQ09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKQ09O
RklHX0FSQ0hfRU5BQkxFX1NQTElUX1BNRF9QVExPQ0s9eQpDT05GSUdfQ09NUEFDVElPTj15
CkNPTkZJR19DT01QQUNUX1VORVZJQ1RBQkxFX0RFRkFVTFQ9MQojIENPTkZJR19QQUdFX1JF
UE9SVElORyBpcyBub3Qgc2V0CkNPTkZJR19NSUdSQVRJT049eQpDT05GSUdfQVJDSF9FTkFC
TEVfSFVHRVBBR0VfTUlHUkFUSU9OPXkKQ09ORklHX1BDUF9CQVRDSF9TQ0FMRV9NQVg9NQpD
T05GSUdfUEhZU19BRERSX1RfNjRCSVQ9eQpDT05GSUdfTU1VX05PVElGSUVSPXkKIyBDT05G
SUdfS1NNIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfTU1BUF9NSU5fQUREUj00MDk2CkNP
TkZJR19BUkNIX1NVUFBPUlRTX01FTU9SWV9GQUlMVVJFPXkKIyBDT05GSUdfTUVNT1JZX0ZB
SUxVUkUgaXMgbm90IHNldApDT05GSUdfQVJDSF9XQU5UX0dFTkVSQUxfSFVHRVRMQj15CkNP
TkZJR19BUkNIX1dBTlRTX1RIUF9TV0FQPXkKIyBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBB
R0UgaXMgbm90IHNldApDT05GSUdfTkVFRF9QRVJfQ1BVX0VNQkVEX0ZJUlNUX0NIVU5LPXkK
Q09ORklHX05FRURfUEVSX0NQVV9QQUdFX0ZJUlNUX0NIVU5LPXkKQ09ORklHX1VTRV9QRVJD
UFVfTlVNQV9OT0RFX0lEPXkKQ09ORklHX0hBVkVfU0VUVVBfUEVSX0NQVV9BUkVBPXkKIyBD
T05GSUdfQ01BIGlzIG5vdCBzZXQKQ09ORklHX0dFTkVSSUNfRUFSTFlfSU9SRU1BUD15CiMg
Q09ORklHX0RFRkVSUkVEX1NUUlVDVF9QQUdFX0lOSVQgaXMgbm90IHNldAojIENPTkZJR19J
RExFX1BBR0VfVFJBQ0tJTkcgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfQ0FDSEVfTElO
RV9TSVpFPXkKQ09ORklHX0FSQ0hfSEFTX0NVUlJFTlRfU1RBQ0tfUE9JTlRFUj15CkNPTkZJ
R19BUkNIX0hBU19QVEVfREVWTUFQPXkKQ09ORklHX1pPTkVfRE1BPXkKQ09ORklHX1pPTkVf
RE1BMzI9eQpDT05GSUdfVk1BUF9QRk49eQpDT05GSUdfQVJDSF9VU0VTX0hJR0hfVk1BX0ZM
QUdTPXkKQ09ORklHX0FSQ0hfSEFTX1BLRVlTPXkKQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJT
PXkKIyBDT05GSUdfUEVSQ1BVX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfR1VQX1RFU1Qg
aXMgbm90IHNldAojIENPTkZJR19ETUFQT09MX1RFU1QgaXMgbm90IHNldApDT05GSUdfQVJD
SF9IQVNfUFRFX1NQRUNJQUw9eQpDT05GSUdfTUVNRkRfQ1JFQVRFPXkKQ09ORklHX1NFQ1JF
VE1FTT15CiMgQ09ORklHX0FOT05fVk1BX05BTUUgaXMgbm90IHNldAojIENPTkZJR19VU0VS
RkFVTFRGRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xSVV9HRU4gaXMgbm90IHNldApDT05GSUdf
QVJDSF9TVVBQT1JUU19QRVJfVk1BX0xPQ0s9eQpDT05GSUdfUEVSX1ZNQV9MT0NLPXkKQ09O
RklHX0xPQ0tfTU1fQU5EX0ZJTkRfVk1BPXkKCiMKIyBEYXRhIEFjY2VzcyBNb25pdG9yaW5n
CiMKIyBDT05GSUdfREFNT04gaXMgbm90IHNldAojIGVuZCBvZiBEYXRhIEFjY2VzcyBNb25p
dG9yaW5nCiMgZW5kIG9mIE1lbW9yeSBNYW5hZ2VtZW50IG9wdGlvbnMKCkNPTkZJR19ORVQ9
eQpDT05GSUdfTkVUX0lOR1JFU1M9eQpDT05GSUdfTkVUX0VHUkVTUz15CkNPTkZJR19ORVRf
WEdSRVNTPXkKQ09ORklHX1NLQl9FWFRFTlNJT05TPXkKCiMKIyBOZXR3b3JraW5nIG9wdGlv
bnMKIwpDT05GSUdfUEFDS0VUPXkKIyBDT05GSUdfUEFDS0VUX0RJQUcgaXMgbm90IHNldApD
T05GSUdfVU5JWD15CkNPTkZJR19VTklYX1NDTT15CkNPTkZJR19BRl9VTklYX09PQj15CiMg
Q09ORklHX1VOSVhfRElBRyBpcyBub3Qgc2V0CiMgQ09ORklHX1RMUyBpcyBub3Qgc2V0CkNP
TkZJR19YRlJNPXkKQ09ORklHX1hGUk1fQUxHTz15CkNPTkZJR19YRlJNX1VTRVI9eQojIENP
TkZJR19YRlJNX1VTRVJfQ09NUEFUIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9JTlRFUkZB
Q0UgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NVQl9QT0xJQ1kgaXMgbm90IHNldAojIENP
TkZJR19YRlJNX01JR1JBVEUgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NUQVRJU1RJQ1Mg
aXMgbm90IHNldApDT05GSUdfWEZSTV9BSD15CkNPTkZJR19YRlJNX0VTUD15CiMgQ09ORklH
X05FVF9LRVkgaXMgbm90IHNldApDT05GSUdfTkVUX0hBTkRTSEFLRT15CkNPTkZJR19JTkVU
PXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CkNPTkZJR19JUF9BRFZBTkNFRF9ST1VURVI9eQoj
IENPTkZJR19JUF9GSUJfVFJJRV9TVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19JUF9NVUxUSVBM
RV9UQUJMRVM9eQpDT05GSUdfSVBfUk9VVEVfTVVMVElQQVRIPXkKQ09ORklHX0lQX1JPVVRF
X1ZFUkJPU0U9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQX1BOUF9ESENQPXkKQ09ORklH
X0lQX1BOUF9CT09UUD15CkNPTkZJR19JUF9QTlBfUkFSUD15CiMgQ09ORklHX05FVF9JUElQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFX0RFTVVYIGlzIG5vdCBzZXQKQ09ORklH
X05FVF9JUF9UVU5ORUw9eQpDT05GSUdfSVBfTVJPVVRFX0NPTU1PTj15CkNPTkZJR19JUF9N
Uk9VVEU9eQojIENPTkZJR19JUF9NUk9VVEVfTVVMVElQTEVfVEFCTEVTIGlzIG5vdCBzZXQK
Q09ORklHX0lQX1BJTVNNX1YxPXkKQ09ORklHX0lQX1BJTVNNX1YyPXkKQ09ORklHX1NZTl9D
T09LSUVTPXkKIyBDT05GSUdfTkVUX0lQVlRJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZP
VSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GT1VfSVBfVFVOTkVMUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKQ09ORklHX0lORVRfVEFCTEVfUEVS
VFVSQl9PUkRFUj0xNgpDT05GSUdfSU5FVF9UVU5ORUw9eQojIENPTkZJR19JTkVUX0RJQUcg
aXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQURWQU5DRUQ9eQojIENPTkZJR19UQ1BfQ09O
R19CSUMgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQojIENPTkZJR19UQ1Bf
Q09OR19XRVNUV09PRCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0hUQ1AgaXMgbm90
IHNldAojIENPTkZJR19UQ1BfQ09OR19IU1RDUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9D
T05HX0hZQkxBIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfVkVHQVMgaXMgbm90IHNl
dAojIENPTkZJR19UQ1BfQ09OR19OViBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX1ND
QUxBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfTFAgaXMgbm90IHNldAojIENP
TkZJR19UQ1BfQ09OR19WRU5PIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfWUVBSCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0lMTElOT0lTIGlzIG5vdCBzZXQKIyBDT05G
SUdfVENQX0NPTkdfRENUQ1AgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19DREcgaXMg
bm90IHNldAojIENPTkZJR19UQ1BfQ09OR19CQlIgaXMgbm90IHNldApDT05GSUdfREVGQVVM
VF9DVUJJQz15CiMgQ09ORklHX0RFRkFVTFRfUkVOTyBpcyBub3Qgc2V0CkNPTkZJR19ERUZB
VUxUX1RDUF9DT05HPSJjdWJpYyIKQ09ORklHX1RDUF9TSUdQT09MPXkKIyBDT05GSUdfVENQ
X0FPIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9NRDVTSUc9eQpDT05GSUdfSVBWNj15CiMgQ09O
RklHX0lQVjZfUk9VVEVSX1BSRUYgaXMgbm90IHNldAojIENPTkZJR19JUFY2X09QVElNSVNU
SUNfREFEIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ2X0FIPXkKQ09ORklHX0lORVQ2X0VTUD15
CiMgQ09ORklHX0lORVQ2X0VTUF9PRkZMT0FEIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZf
RVNQSU5UQ1AgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9JUENPTVAgaXMgbm90IHNldAoj
IENPTkZJR19JUFY2X01JUDYgaXMgbm90IHNldAojIENPTkZJR19JUFY2X0lMQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lQVjZfVlRJIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfU0lUPXkKIyBD
T05GSUdfSVBWNl9TSVRfNlJEIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfTkRJU0NfTk9ERVRZ
UEU9eQojIENPTkZJR19JUFY2X1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfTVVM
VElQTEVfVEFCTEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNl9NUk9VVEUgaXMgbm90IHNl
dAojIENPTkZJR19JUFY2X1NFRzZfTFdUVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JUFY2
X1NFRzZfSE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfUlBMX0xXVFVOTkVMIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBWNl9JT0FNNl9MV1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19O
RVRMQUJFTD15CiMgQ09ORklHX01QVENQIGlzIG5vdCBzZXQKQ09ORklHX05FVFdPUktfU0VD
TUFSSz15CkNPTkZJR19ORVRfUFRQX0NMQVNTSUZZPXkKIyBDT05GSUdfTkVUV09SS19QSFlf
VElNRVNUQU1QSU5HIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUj15CiMgQ09ORklHX05F
VEZJTFRFUl9BRFZBTkNFRCBpcyBub3Qgc2V0CgojCiMgQ29yZSBOZXRmaWx0ZXIgQ29uZmln
dXJhdGlvbgojCkNPTkZJR19ORVRGSUxURVJfSU5HUkVTUz15CkNPTkZJR19ORVRGSUxURVJf
RUdSRVNTPXkKQ09ORklHX05FVEZJTFRFUl9TS0lQX0VHUkVTUz15CkNPTkZJR19ORVRGSUxU
RVJfTkVUTElOSz15CkNPTkZJR19ORVRGSUxURVJfTkVUTElOS19MT0c9eQpDT05GSUdfTkZf
Q09OTlRSQUNLPXkKQ09ORklHX05GX0xPR19TWVNMT0c9bQpDT05GSUdfTkZfQ09OTlRSQUNL
X1NFQ01BUks9eQojIENPTkZJR19ORl9DT05OVFJBQ0tfUFJPQ0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkZfQ09OTlRSQUNLX0xBQkVMUyBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJB
Q0tfRlRQPXkKQ09ORklHX05GX0NPTk5UUkFDS19JUkM9eQojIENPTkZJR19ORl9DT05OVFJB
Q0tfTkVUQklPU19OUyBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0tfU0lQPXkKQ09O
RklHX05GX0NUX05FVExJTks9eQojIENPTkZJR19ORVRGSUxURVJfTkVUTElOS19HTFVFX0NU
IGlzIG5vdCBzZXQKQ09ORklHX05GX05BVD15CkNPTkZJR19ORl9OQVRfRlRQPXkKQ09ORklH
X05GX05BVF9JUkM9eQpDT05GSUdfTkZfTkFUX1NJUD15CkNPTkZJR19ORl9OQVRfTUFTUVVF
UkFERT15CiMgQ09ORklHX05GX1RBQkxFUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJf
WFRBQkxFUz15CiMgQ09ORklHX05FVEZJTFRFUl9YVEFCTEVTX0NPTVBBVCBpcyBub3Qgc2V0
CgojCiMgWHRhYmxlcyBjb21iaW5lZCBtb2R1bGVzCiMKQ09ORklHX05FVEZJTFRFUl9YVF9N
QVJLPW0KCiMKIyBYdGFibGVzIHRhcmdldHMKIwpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdF
VF9DT05OU0VDTUFSSz15CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX0xPRz1tCkNPTkZJ
R19ORVRGSUxURVJfWFRfTkFUPW0KIyBDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9ORVRN
QVAgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9ORkxPRz15CiMgQ09O
RklHX05FVEZJTFRFUl9YVF9UQVJHRVRfUkVESVJFQ1QgaXMgbm90IHNldApDT05GSUdfTkVU
RklMVEVSX1hUX1RBUkdFVF9NQVNRVUVSQURFPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJH
RVRfU0VDTUFSSz15CkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1RDUE1TUz15CgojCiMg
WHRhYmxlcyBtYXRjaGVzCiMKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9BRERSVFlQRT1t
CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTlRSQUNLPXkKQ09ORklHX05FVEZJTFRF
Ul9YVF9NQVRDSF9QT0xJQ1k9eQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NUQVRFPXkK
IyBlbmQgb2YgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgoKIyBDT05GSUdfSVBfU0VU
IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNldAoKIwojIElQOiBOZXRmaWx0
ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORl9ERUZSQUdfSVBWND15CiMgQ09ORklHX05G
X1NPQ0tFVF9JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfVFBST1hZX0lQVjQgaXMgbm90
IHNldAojIENPTkZJR19ORl9EVVBfSVBWNCBpcyBub3Qgc2V0CkNPTkZJR19ORl9MT0dfQVJQ
PW0KQ09ORklHX05GX0xPR19JUFY0PW0KQ09ORklHX05GX1JFSkVDVF9JUFY0PXkKQ09ORklH
X0lQX05GX0lQVEFCTEVTPXkKQ09ORklHX0lQX05GX0ZJTFRFUj15CkNPTkZJR19JUF9ORl9U
QVJHRVRfUkVKRUNUPXkKQ09ORklHX0lQX05GX05BVD1tCkNPTkZJR19JUF9ORl9UQVJHRVRf
TUFTUVVFUkFERT1tCkNPTkZJR19JUF9ORl9NQU5HTEU9eQojIENPTkZJR19JUF9ORl9SQVcg
aXMgbm90IHNldAojIGVuZCBvZiBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KCiMKIyBJ
UHY2OiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCiMgQ09ORklHX05GX1NPQ0tFVF9JUFY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfVFBST1hZX0lQVjYgaXMgbm90IHNldAojIENPTkZJ
R19ORl9EVVBfSVBWNiBpcyBub3Qgc2V0CkNPTkZJR19ORl9SRUpFQ1RfSVBWNj15CkNPTkZJ
R19ORl9MT0dfSVBWNj1tCkNPTkZJR19JUDZfTkZfSVBUQUJMRVM9eQpDT05GSUdfSVA2X05G
X01BVENIX0lQVjZIRUFERVI9eQpDT05GSUdfSVA2X05GX0ZJTFRFUj15CkNPTkZJR19JUDZf
TkZfVEFSR0VUX1JFSkVDVD15CkNPTkZJR19JUDZfTkZfTUFOR0xFPXkKIyBDT05GSUdfSVA2
X05GX1JBVyBpcyBub3Qgc2V0CiMgZW5kIG9mIElQdjY6IE5ldGZpbHRlciBDb25maWd1cmF0
aW9uCgpDT05GSUdfTkZfREVGUkFHX0lQVjY9eQojIENPTkZJR19ORl9DT05OVFJBQ0tfQlJJ
REdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQlBGSUxURVIgaXMgbm90IHNldAojIENPTkZJR19J
UF9EQ0NQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JEUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RJUEMgaXMgbm90IHNldAojIENPTkZJR19BVE0g
aXMgbm90IHNldAojIENPTkZJR19MMlRQIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAy
MVEgaXMgbm90IHNldAojIENPTkZJR19MTEMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsg
aXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBCIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEhPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfNkxPV1BBTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lFRUU4MDIxNTQgaXMgbm90IHNldApDT05GSUdfTkVUX1NDSEVE
PXkKCiMKIyBRdWV1ZWluZy9TY2hlZHVsaW5nCiMKIyBDT05GSUdfTkVUX1NDSF9IVEIgaXMg
bm90IHNldAojIENPTkZJR19ORVRfU0NIX0hGU0MgaXMgbm90IHNldAojIENPTkZJR19ORVRf
U0NIX1BSSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX01VTFRJUSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9TQ0hfUkVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9TRkIg
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1NGUSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9TQ0hfVEVRTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfVEJGIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1NDSF9DQlMgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0VURiBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfVEFQUklPIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9HUkVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9ORVRFTSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9TQ0hfRFJSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9N
UVBSSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1NLQlBSSU8gaXMgbm90IHNldAoj
IENPTkZJR19ORVRfU0NIX0NIT0tFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9RRlEg
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0NPREVMIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9GUV9DT0RFTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfQ0FLRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X0hIRiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUElFIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1NDSF9JTkdSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9QTFVHIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9FVFMgaXMgbm90IHNldAojIENPTkZJR19ORVRf
U0NIX0RFRkFVTFQgaXMgbm90IHNldAoKIwojIENsYXNzaWZpY2F0aW9uCiMKQ09ORklHX05F
VF9DTFM9eQojIENPTkZJR19ORVRfQ0xTX0JBU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0NMU19ST1VURTQgaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX0ZXIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0NMU19VMzIgaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX0ZMT1cg
aXMgbm90IHNldApDT05GSUdfTkVUX0NMU19DR1JPVVA9eQojIENPTkZJR19ORVRfQ0xTX0JQ
RiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxPV0VSIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0NMU19NQVRDSEFMTCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfRU1BVENIPXkKQ09O
RklHX05FVF9FTUFUQ0hfU1RBQ0s9MzIKIyBDT05GSUdfTkVUX0VNQVRDSF9DTVAgaXMgbm90
IHNldAojIENPTkZJR19ORVRfRU1BVENIX05CWVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0VNQVRDSF9VMzIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRU1BVENIX01FVEEgaXMgbm90
IHNldAojIENPTkZJR19ORVRfRU1BVENIX1RFWFQgaXMgbm90IHNldAojIENPTkZJR19ORVRf
RU1BVENIX0lQVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfQ0xTX0FDVD15CiMgQ09ORklHX05F
VF9BQ1RfUE9MSUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9HQUNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0FDVF9NSVJSRUQgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNU
X1NBTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfSVBUIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0FDVF9OQVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfQUNUX1BFRElUIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9TSU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0FDVF9TS0JFRElUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9DU1VNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0FDVF9NUExTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9W
TEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0FDVF9CUEYgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfQUNUX1NLQk1PRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9BQ1RfSUZFIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX0FDVF9UVU5ORUxfS0VZIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0FDVF9HQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1RDX1NLQl9FWFQgaXMgbm90
IHNldApDT05GSUdfTkVUX1NDSF9GSUZPPXkKIyBDT05GSUdfRENCIGlzIG5vdCBzZXQKQ09O
RklHX0ROU19SRVNPTFZFUj15CiMgQ09ORklHX0JBVE1BTl9BRFYgaXMgbm90IHNldAojIENP
TkZJR19PUEVOVlNXSVRDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZTT0NLRVRTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUTElOS19ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBMUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9OU0ggaXMgbm90IHNldAojIENPTkZJR19IU1IgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU1dJVENIREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0wz
X01BU1RFUl9ERVYgaXMgbm90IHNldAojIENPTkZJR19RUlRSIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX05DU0kgaXMgbm90IHNldApDT05GSUdfUENQVV9ERVZfUkVGQ05UPXkKQ09ORklH
X01BWF9TS0JfRlJBR1M9MTcKQ09ORklHX1JQUz15CkNPTkZJR19SRlNfQUNDRUw9eQpDT05G
SUdfU09DS19SWF9RVUVVRV9NQVBQSU5HPXkKQ09ORklHX1hQUz15CkNPTkZJR19DR1JPVVBf
TkVUX1BSSU89eQpDT05GSUdfQ0dST1VQX05FVF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9C
VVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKQ09ORklHX05FVF9GTE9XX0xJTUlUPXkKCiMKIyBO
ZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0RST1BfTU9OSVRPUiBpcyBub3Qgc2V0CiMgZW5kIG9mIE5ldHdvcmsgdGVzdGlu
ZwojIGVuZCBvZiBOZXR3b3JraW5nIG9wdGlvbnMKCiMgQ09ORklHX0hBTVJBRElPIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAoj
IENPTkZJR19BRl9SWFJQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FGX0tDTSBpcyBub3Qgc2V0
CiMgQ09ORklHX01DVFAgaXMgbm90IHNldApDT05GSUdfRklCX1JVTEVTPXkKQ09ORklHX1dJ
UkVMRVNTPXkKQ09ORklHX0NGRzgwMjExPXkKIyBDT05GSUdfTkw4MDIxMV9URVNUTU9ERSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NGRzgwMjExX0RFVkVMT1BFUl9XQVJOSU5HUyBpcyBub3Qg
c2V0CkNPTkZJR19DRkc4MDIxMV9SRVFVSVJFX1NJR05FRF9SRUdEQj15CkNPTkZJR19DRkc4
MDIxMV9VU0VfS0VSTkVMX1JFR0RCX0tFWVM9eQpDT05GSUdfQ0ZHODAyMTFfREVGQVVMVF9Q
Uz15CiMgQ09ORklHX0NGRzgwMjExX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfQ0ZHODAy
MTFfQ1JEQV9TVVBQT1JUPXkKIyBDT05GSUdfQ0ZHODAyMTFfV0VYVCBpcyBub3Qgc2V0CkNP
TkZJR19NQUM4MDIxMT15CkNPTkZJR19NQUM4MDIxMV9IQVNfUkM9eQpDT05GSUdfTUFDODAy
MTFfUkNfTUlOU1RSRUw9eQpDT05GSUdfTUFDODAyMTFfUkNfREVGQVVMVF9NSU5TVFJFTD15
CkNPTkZJR19NQUM4MDIxMV9SQ19ERUZBVUxUPSJtaW5zdHJlbF9odCIKIyBDT05GSUdfTUFD
ODAyMTFfTUVTSCBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9MRURTPXkKIyBDT05GSUdf
TUFDODAyMTFfTUVTU0FHRV9UUkFDSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTFf
REVCVUdfTUVOVSBpcyBub3Qgc2V0CkNPTkZJR19NQUM4MDIxMV9TVEFfSEFTSF9NQVhfU0la
RT0wCkNPTkZJR19SRktJTEw9eQpDT05GSUdfUkZLSUxMX0xFRFM9eQpDT05GSUdfUkZLSUxM
X0lOUFVUPXkKQ09ORklHX05FVF85UD15CkNPTkZJR19ORVRfOVBfRkQ9eQpDT05GSUdfTkVU
XzlQX1ZJUlRJTz15CiMgQ09ORklHX05FVF85UF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklH
X0NBSUYgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0xJQiBpcyBub3Qgc2V0CiMgQ09ORklH
X05GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTQU1QTEUgaXMgbm90IHNldAojIENPTkZJR19O
RVRfSUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfTFdUVU5ORUwgaXMgbm90IHNldApDT05GSUdf
RFNUX0NBQ0hFPXkKQ09ORklHX0dST19DRUxMUz15CkNPTkZJR19ORVRfU0VMRlRFU1RTPXkK
Q09ORklHX0ZBSUxPVkVSPXkKQ09ORklHX0VUSFRPT0xfTkVUTElOSz15CgojCiMgRGV2aWNl
IERyaXZlcnMKIwpDT05GSUdfSEFWRV9FSVNBPXkKIyBDT05GSUdfRUlTQSBpcyBub3Qgc2V0
CkNPTkZJR19IQVZFX1BDST15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJTlM9eQpD
T05GSUdfUENJRVBPUlRCVVM9eQojIENPTkZJR19IT1RQTFVHX1BDSV9QQ0lFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUENJRUFFUiBpcyBub3Qgc2V0CkNPTkZJR19QQ0lFQVNQTT15CkNPTkZJ
R19QQ0lFQVNQTV9ERUZBVUxUPXkKIyBDT05GSUdfUENJRUFTUE1fUE9XRVJTQVZFIGlzIG5v
dCBzZXQKIyBDT05GSUdfUENJRUFTUE1fUE9XRVJfU1VQRVJTQVZFIGlzIG5vdCBzZXQKIyBD
T05GSUdfUENJRUFTUE1fUEVSRk9STUFOQ0UgaXMgbm90IHNldApDT05GSUdfUENJRV9QTUU9
eQojIENPTkZJR19QQ0lFX1BUTSBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfTVNJPXkKQ09ORklH
X1BDSV9RVUlSS1M9eQojIENPTkZJR19QQ0lfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19Q
Q0lfU1RVQiBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfQVRTPXkKQ09ORklHX1BDSV9MT0NLTEVT
U19DT05GSUc9eQojIENPTkZJR19QQ0lfSU9WIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9QUkk9
eQpDT05GSUdfUENJX1BBU0lEPXkKQ09ORklHX1BDSV9MQUJFTD15CkNPTkZJR19WR0FfQVJC
PXkKQ09ORklHX1ZHQV9BUkJfTUFYX0dQVVM9MTYKQ09ORklHX0hPVFBMVUdfUENJPXkKIyBD
T05GSUdfSE9UUExVR19QQ0lfQUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hPVFBMVUdfUENJ
X0NQQ0kgaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSV9TSFBDIGlzIG5vdCBzZXQK
CiMKIyBQQ0kgY29udHJvbGxlciBkcml2ZXJzCiMKIyBDT05GSUdfVk1EIGlzIG5vdCBzZXQK
CiMKIyBDYWRlbmNlLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKIwojIGVuZCBvZiBDYWRlbmNl
LWJhc2VkIFBDSWUgY29udHJvbGxlcnMKCiMKIyBEZXNpZ25XYXJlLWJhc2VkIFBDSWUgY29u
dHJvbGxlcnMKIwojIENPTkZJR19QQ0lfTUVTT04gaXMgbm90IHNldAojIENPTkZJR19QQ0lF
X0RXX1BMQVRfSE9TVCBpcyBub3Qgc2V0CiMgZW5kIG9mIERlc2lnbldhcmUtYmFzZWQgUENJ
ZSBjb250cm9sbGVycwoKIwojIE1vYml2ZWlsLWJhc2VkIFBDSWUgY29udHJvbGxlcnMKIwoj
IGVuZCBvZiBNb2JpdmVpbC1iYXNlZCBQQ0llIGNvbnRyb2xsZXJzCiMgZW5kIG9mIFBDSSBj
b250cm9sbGVyIGRyaXZlcnMKCiMKIyBQQ0kgRW5kcG9pbnQKIwojIENPTkZJR19QQ0lfRU5E
UE9JTlQgaXMgbm90IHNldAojIGVuZCBvZiBQQ0kgRW5kcG9pbnQKCiMKIyBQQ0kgc3dpdGNo
IGNvbnRyb2xsZXIgZHJpdmVycwojCiMgQ09ORklHX1BDSV9TV19TV0lUQ0hURUMgaXMgbm90
IHNldAojIGVuZCBvZiBQQ0kgc3dpdGNoIGNvbnRyb2xsZXIgZHJpdmVycwoKIyBDT05GSUdf
Q1hMX0JVUyBpcyBub3Qgc2V0CkNPTkZJR19QQ0NBUkQ9eQpDT05GSUdfUENNQ0lBPXkKQ09O
RklHX1BDTUNJQV9MT0FEX0NJUz15CkNPTkZJR19DQVJEQlVTPXkKCiMKIyBQQy1jYXJkIGJy
aWRnZXMKIwpDT05GSUdfWUVOVEE9eQpDT05GSUdfWUVOVEFfTzI9eQpDT05GSUdfWUVOVEFf
UklDT0g9eQpDT05GSUdfWUVOVEFfVEk9eQpDT05GSUdfWUVOVEFfRU5FX1RVTkU9eQpDT05G
SUdfWUVOVEFfVE9TSElCQT15CiMgQ09ORklHX1BENjcyOSBpcyBub3Qgc2V0CiMgQ09ORklH
X0k4MjA5MiBpcyBub3Qgc2V0CkNPTkZJR19QQ0NBUkRfTk9OU1RBVElDPXkKIyBDT05GSUdf
UkFQSURJTyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJ
R19BVVhJTElBUllfQlVTPXkKIyBDT05GSUdfVUVWRU5UX0hFTFBFUiBpcyBub3Qgc2V0CkNP
TkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CiMgQ09ORklHX0RFVlRN
UEZTX1NBRkUgaXMgbm90IHNldApDT05GSUdfU1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5U
X0ZJUk1XQVJFX0JVSUxEPXkKCiMKIyBGaXJtd2FyZSBsb2FkZXIKIwpDT05GSUdfRldfTE9B
REVSPXkKQ09ORklHX0VYVFJBX0ZJUk1XQVJFPSIiCiMgQ09ORklHX0ZXX0xPQURFUl9VU0VS
X0hFTFBFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZXX0xPQURFUl9DT01QUkVTUyBpcyBub3Qg
c2V0CkNPTkZJR19GV19DQUNIRT15CiMgQ09ORklHX0ZXX1VQTE9BRCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEZpcm13YXJlIGxvYWRlcgoKQ09ORklHX0FMTE9XX0RFVl9DT1JFRFVNUD15CiMg
Q09ORklHX0RFQlVHX0RSSVZFUiBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19ERVZSRVM9eQoj
IENPTkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX0FTWU5DX0RSSVZFUl9QUk9CRSBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklDX0NQVV9E
RVZJQ0VTPXkKQ09ORklHX0dFTkVSSUNfQ1BVX0FVVE9QUk9CRT15CkNPTkZJR19HRU5FUklD
X0NQVV9WVUxORVJBQklMSVRJRVM9eQpDT05GSUdfUkVHTUFQPXkKQ09ORklHX0RNQV9TSEFS
RURfQlVGRkVSPXkKIyBDT05GSUdfRE1BX0ZFTkNFX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfRldfREVWTElOS19TWU5DX1NUQVRFX1RJTUVPVVQgaXMgbm90IHNldAojIGVuZCBvZiBH
ZW5lcmljIERyaXZlciBPcHRpb25zCgojCiMgQnVzIGRldmljZXMKIwojIENPTkZJR19NSElf
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUhJX0JVU19FUCBpcyBub3Qgc2V0CiMgZW5kIG9m
IEJ1cyBkZXZpY2VzCgojCiMgQ2FjaGUgRHJpdmVycwojCiMgZW5kIG9mIENhY2hlIERyaXZl
cnMKCkNPTkZJR19DT05ORUNUT1I9eQpDT05GSUdfUFJPQ19FVkVOVFM9eQoKIwojIEZpcm13
YXJlIERyaXZlcnMKIwoKIwojIEFSTSBTeXN0ZW0gQ29udHJvbCBhbmQgTWFuYWdlbWVudCBJ
bnRlcmZhY2UgUHJvdG9jb2wKIwojIGVuZCBvZiBBUk0gU3lzdGVtIENvbnRyb2wgYW5kIE1h
bmFnZW1lbnQgSW50ZXJmYWNlIFByb3RvY29sCgojIENPTkZJR19FREQgaXMgbm90IHNldApD
T05GSUdfRklSTVdBUkVfTUVNTUFQPXkKQ09ORklHX0RNSUlEPXkKIyBDT05GSUdfRE1JX1NZ
U0ZTIGlzIG5vdCBzZXQKQ09ORklHX0RNSV9TQ0FOX01BQ0hJTkVfTk9OX0VGSV9GQUxMQkFD
Sz15CiMgQ09ORklHX0lTQ1NJX0lCRlQgaXMgbm90IHNldAojIENPTkZJR19GV19DRkdfU1lT
RlMgaXMgbm90IHNldAojIENPTkZJR19TWVNGQl9TSU1QTEVGQiBpcyBub3Qgc2V0CiMgQ09O
RklHX0dPT0dMRV9GSVJNV0FSRSBpcyBub3Qgc2V0CgojCiMgRUZJIChFeHRlbnNpYmxlIEZp
cm13YXJlIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19FRklfRVNSVD15CkNPTkZJR19F
RklfRFhFX01FTV9BVFRSSUJVVEVTPXkKQ09ORklHX0VGSV9SVU5USU1FX1dSQVBQRVJTPXkK
IyBDT05GSUdfRUZJX0JPT1RMT0FERVJfQ09OVFJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX0VG
SV9DQVBTVUxFX0xPQURFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VGSV9URVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVBQTEVfUFJPUEVSVElFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFU0VU
X0FUVEFDS19NSVRJR0FUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1JDSTJfVEFCTEUg
aXMgbm90IHNldAojIENPTkZJR19FRklfRElTQUJMRV9QQ0lfRE1BIGlzIG5vdCBzZXQKQ09O
RklHX0VGSV9FQVJMWUNPTj15CkNPTkZJR19FRklfQ1VTVE9NX1NTRFRfT1ZFUkxBWVM9eQoj
IENPTkZJR19FRklfRElTQUJMRV9SVU5USU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX0NP
Q09fU0VDUkVUIGlzIG5vdCBzZXQKIyBlbmQgb2YgRUZJIChFeHRlbnNpYmxlIEZpcm13YXJl
IEludGVyZmFjZSkgU3VwcG9ydAoKIwojIFF1YWxjb21tIGZpcm13YXJlIGRyaXZlcnMKIwoj
IGVuZCBvZiBRdWFsY29tbSBmaXJtd2FyZSBkcml2ZXJzCgojCiMgVGVncmEgZmlybXdhcmUg
ZHJpdmVyCiMKIyBlbmQgb2YgVGVncmEgZmlybXdhcmUgZHJpdmVyCiMgZW5kIG9mIEZpcm13
YXJlIERyaXZlcnMKCiMgQ09ORklHX0dOU1MgaXMgbm90IHNldAojIENPTkZJR19NVEQgaXMg
bm90IHNldAojIENPTkZJR19PRiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX01JR0hUX0hBVkVf
UENfUEFSUE9SVD15CiMgQ09ORklHX1BBUlBPUlQgaXMgbm90IHNldApDT05GSUdfUE5QPXkK
Q09ORklHX1BOUF9ERUJVR19NRVNTQUdFUz15CgojCiMgUHJvdG9jb2xzCiMKQ09ORklHX1BO
UEFDUEk9eQpDT05GSUdfQkxLX0RFVj15CiMgQ09ORklHX0JMS19ERVZfTlVMTF9CTEsgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBzZXQKQ09ORklHX0NEUk9NPXkK
IyBDT05GSUdfQkxLX0RFVl9QQ0lFU1NEX01USVAzMlhYIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfTE9PUD15CkNPTkZJR19CTEtfREVWX0xPT1BfTUlOX0NPVU5UPTgKIyBDT05GSUdf
QkxLX0RFVl9EUkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENE
VkQgaXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldApDT05GSUdf
VklSVElPX0JMSz15CiMgQ09ORklHX0JMS19ERVZfUkJEIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9VQkxLIGlzIG5vdCBzZXQKCiMKIyBOVk1FIFN1cHBvcnQKIwojIENPTkZJR19C
TEtfREVWX05WTUUgaXMgbm90IHNldAojIENPTkZJR19OVk1FX0ZDIGlzIG5vdCBzZXQKIyBD
T05GSUdfTlZNRV9UQ1AgaXMgbm90IHNldAojIGVuZCBvZiBOVk1FIFN1cHBvcnQKCiMKIyBN
aXNjIGRldmljZXMKIwojIENPTkZJR19BRDUyNVhfRFBPVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RVTU1ZX0lSUSBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9BU00gaXMgbm90IHNldAojIENP
TkZJR19QSEFOVE9NIGlzIG5vdCBzZXQKIyBDT05GSUdfVElGTV9DT1JFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSUNTOTMyUzQwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0VOQ0xPU1VSRV9TRVJW
SUNFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQX0lMTyBpcyBub3Qgc2V0CiMgQ09ORklHX0FQ
RFM5ODAyQUxTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNMMjkwMDMgaXMgbm90IHNldAojIENP
TkZJR19JU0wyOTAyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVFNMMjU1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQkgxNzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BUERTOTkwWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hNQzYzNTIgaXMgbm90IHNldAoj
IENPTkZJR19EUzE2ODIgaXMgbm90IHNldAojIENPTkZJR19TUkFNIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFdfWERBVEFfUENJRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9FTkRQT0lOVF9U
RVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1NERkVDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlNNIGlzIG5vdCBzZXQKIyBDT05GSUdfQzJQT1JUIGlzIG5vdCBzZXQKCiMKIyBFRVBS
T00gc3VwcG9ydAojCiMgQ09ORklHX0VFUFJPTV9BVDI0IGlzIG5vdCBzZXQKIyBDT05GSUdf
RUVQUk9NX01BWDY4NzUgaXMgbm90IHNldAojIENPTkZJR19FRVBST01fOTNDWDYgaXMgbm90
IHNldAojIENPTkZJR19FRVBST01fSURUXzg5SFBFU1ggaXMgbm90IHNldAojIENPTkZJR19F
RVBST01fRUUxMDA0IGlzIG5vdCBzZXQKIyBlbmQgb2YgRUVQUk9NIHN1cHBvcnQKCiMgQ09O
RklHX0NCNzEwX0NPUkUgaXMgbm90IHNldAoKIwojIFRleGFzIEluc3RydW1lbnRzIHNoYXJl
ZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCiMKIyBlbmQgb2YgVGV4YXMgSW5zdHJ1bWVu
dHMgc2hhcmVkIHRyYW5zcG9ydCBsaW5lIGRpc2NpcGxpbmUKCiMgQ09ORklHX1NFTlNPUlNf
TElTM19JMkMgaXMgbm90IHNldAojIENPTkZJR19BTFRFUkFfU1RBUEwgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFTF9NRUkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9NRUlfTUUgaXMg
bm90IHNldAojIENPTkZJR19JTlRFTF9NRUlfVFhFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5U
RUxfTUVJX0hEQ1AgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9NRUlfUFhQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URUxfTUVJX0dTQ19QUk9YWSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZN
V0FSRV9WTUNJIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VOV1FFIGlzIG5vdCBzZXQKIyBDT05G
SUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTV9WSyBpcyBub3Qgc2V0CiMgQ09ORklH
X01JU0NfQUxDT1JfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1BDSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01JU0NfUlRTWF9VU0IgaXMgbm90IHNldAojIENPTkZJR19VQUND
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1BWUEFOSUMgaXMgbm90IHNldAojIGVuZCBvZiBNaXNj
IGRldmljZXMKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0lfTU9EPXkK
IyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0NPTU1PTj15CkNP
TkZJR19TQ1NJPXkKQ09ORklHX1NDU0lfRE1BPXkKQ09ORklHX1NDU0lfUFJPQ19GUz15Cgoj
CiMgU0NTSSBzdXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxL
X0RFVl9TRD15CiMgQ09ORklHX0NIUl9ERVZfU1QgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9TUj15CkNPTkZJR19DSFJfREVWX1NHPXkKQ09ORklHX0JMS19ERVZfQlNHPXkKIyBDT05G
SUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNldApDT05GSUdfU0NTSV9DT05TVEFOVFM9eQojIENP
TkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMg
aXMgbm90IHNldAoKIwojIFNDU0kgVHJhbnNwb3J0cwojCkNPTkZJR19TQ1NJX1NQSV9BVFRS
Uz15CiMgQ09ORklHX1NDU0lfRkNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lT
Q1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVNfQVRUUlMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NS
UF9BVFRSUyBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kgVHJhbnNwb3J0cwoKQ09ORklHX1ND
U0lfTE9XTEVWRUw9eQojIENPTkZJR19JU0NTSV9UQ1AgaXMgbm90IHNldAojIENPTkZJR19J
U0NTSV9CT09UX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9DWEdCM19JU0NTSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1hHQjRfSVNDU0kgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0JOWDJfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19CRTJJU0NTSSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9IUFNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185WFhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV8zV19TQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3OVhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9NVlNBUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVZVTUkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0FEVkFOU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BUkNNU1IgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0VTQVMyUiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dF
TiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09O
RklHX01FR0FSQUlEX1NBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBUM1NBUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfTVBUMlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
TVBJM01SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TTUFSVFBRSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfSFBUSU9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9CVVNMT0dJQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTVlSQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
TVlSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNV0FSRV9QVlNDU0kgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX1NOSUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNWDMxOTFEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9GRE9NQUlOX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfSVNDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1NURVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUz
QzhYWF8yIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfQU01M0M5NzQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1dENzE5WCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BNQ1JBSUQg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BNODAwMSBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJ
X1ZJUlRJTz15CiMgQ09ORklHX1NDU0lfTE9XTEVWRUxfUENNQ0lBIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9ESCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kgZGV2aWNlIHN1cHBvcnQK
CkNPTkZJR19BVEE9eQpDT05GSUdfU0FUQV9IT1NUPXkKQ09ORklHX1BBVEFfVElNSU5HUz15
CkNPTkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNPTkZJR19BVEFfRk9SQ0U9eQpDT05GSUdf
QVRBX0FDUEk9eQojIENPTkZJR19TQVRBX1pQT0REIGlzIG5vdCBzZXQKQ09ORklHX1NBVEFf
UE1QPXkKCiMKIyBDb250cm9sbGVycyB3aXRoIG5vbi1TRkYgbmF0aXZlIGludGVyZmFjZQoj
CkNPTkZJR19TQVRBX0FIQ0k9eQpDT05GSUdfU0FUQV9NT0JJTEVfTFBNX1BPTElDWT0wCiMg
Q09ORklHX1NBVEFfQUhDSV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0FIQ0lfRFdD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9JTklDMTYyWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfQUNBUkRfQUhDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lMMjQgaXMgbm90
IHNldApDT05GSUdfQVRBX1NGRj15CgojCiMgU0ZGIGNvbnRyb2xsZXJzIHdpdGggY3VzdG9t
IERNQSBpbnRlcmZhY2UKIwojIENPTkZJR19QRENfQURNQSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfUVNUT1IgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NYNCBpcyBub3Qgc2V0CkNP
TkZJR19BVEFfQk1ETUE9eQoKIwojIFNBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1ETUEK
IwpDT05GSUdfQVRBX1BJSVg9eQojIENPTkZJR19TQVRBX0RXQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NBVEFfTVYgaXMgbm90IHNldAojIENPTkZJR19TQVRBX05WIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9QUk9NSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSUwgaXMgbm90
IHNldAojIENPTkZJR19TQVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU1ZXIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9VTEkgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1ZJ
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVklURVNTRSBpcyBub3Qgc2V0CgojCiMgUEFU
QSBTRkYgY29udHJvbGxlcnMgd2l0aCBCTURNQQojCiMgQ09ORklHX1BBVEFfQUxJIGlzIG5v
dCBzZXQKQ09ORklHX1BBVEFfQU1EPXkKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BVFA4NjdY
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX0NZUFJFU1MgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0VGQVIgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUMzdYIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDJOIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9IUFQzWDMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfSVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9KTUlDUk9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9ORVRDRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9OUzg3NDE1IGlzIG5vdCBzZXQKQ09ORklHX1BBVEFfT0xEUElJWD15
CiMgQ09ORklHX1BBVEFfT1BUSURNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDMjAy
N1ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1BEQ19PTEQgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX1JBRElTWVMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1JEQyBpcyBub3Qgc2V0
CkNPTkZJR19QQVRBX1NDSD15CiMgQ09ORklHX1BBVEFfU0VSVkVSV09SS1MgaXMgbm90IHNl
dAojIENPTkZJR19QQVRBX1NJTDY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0lTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9UUklGTEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9WSUEgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX1dJTkJPTkQgaXMgbm90IHNldAoKIwojIFBJTy1vbmx5IFNGRiBjb250cm9s
bGVycwojCiMgQ09ORklHX1BBVEFfQ01ENjQwX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
VEFfTVBJSVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX05TODc0MTAgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX09QVEkgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1BDTUNJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfUloxMDAwIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIGZh
bGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwojIENPTkZJR19QQVRBX0FDUEkgaXMgbm90IHNl
dAojIENPTkZJR19BVEFfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTEVHQUNZ
IGlzIG5vdCBzZXQKQ09ORklHX01EPXkKQ09ORklHX0JMS19ERVZfTUQ9eQpDT05GSUdfTURf
QVVUT0RFVEVDVD15CkNPTkZJR19NRF9CSVRNQVBfRklMRT15CiMgQ09ORklHX01EX0xJTkVB
UiBpcyBub3Qgc2V0CiMgQ09ORklHX01EX1JBSUQwIGlzIG5vdCBzZXQKIyBDT05GSUdfTURf
UkFJRDEgaXMgbm90IHNldAojIENPTkZJR19NRF9SQUlEMTAgaXMgbm90IHNldAojIENPTkZJ
R19NRF9SQUlENDU2IGlzIG5vdCBzZXQKIyBDT05GSUdfTURfTVVMVElQQVRIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTURfRkFVTFRZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNBQ0hFIGlzIG5v
dCBzZXQKQ09ORklHX0JMS19ERVZfRE1fQlVJTFRJTj15CkNPTkZJR19CTEtfREVWX0RNPXkK
IyBDT05GSUdfRE1fREVCVUcgaXMgbm90IHNldAojIENPTkZJR19ETV9VTlNUUklQRUQgaXMg
bm90IHNldAojIENPTkZJR19ETV9DUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1NOQVBT
SE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fVEhJTl9QUk9WSVNJT05JTkcgaXMgbm90IHNl
dAojIENPTkZJR19ETV9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1dSSVRFQ0FDSEUg
aXMgbm90IHNldAojIENPTkZJR19ETV9FQlMgaXMgbm90IHNldAojIENPTkZJR19ETV9FUkEg
aXMgbm90IHNldAojIENPTkZJR19ETV9DTE9ORSBpcyBub3Qgc2V0CkNPTkZJR19ETV9NSVJS
T1I9eQojIENPTkZJR19ETV9MT0dfVVNFUlNQQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1f
UkFJRCBpcyBub3Qgc2V0CkNPTkZJR19ETV9aRVJPPXkKIyBDT05GSUdfRE1fTVVMVElQQVRI
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fREVMQVkgaXMgbm90IHNldAojIENPTkZJR19ETV9E
VVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fSU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
X1VFVkVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0ZMQUtFWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0RNX1ZFUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1NXSVRDSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNX0xPR19XUklURVMgaXMgbm90IHNldAojIENPTkZJR19ETV9JTlRFR1JJ
VFkgaXMgbm90IHNldAojIENPTkZJR19ETV9BVURJVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RB
UkdFVF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJ
RUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKIyBDT05GSUdfRklSRVdJUkUgaXMgbm90
IHNldAojIENPTkZJR19GSVJFV0lSRV9OT1NZIGlzIG5vdCBzZXQKIyBlbmQgb2YgSUVFRSAx
Mzk0IChGaXJlV2lyZSkgc3VwcG9ydAoKQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTPXkKQ09O
RklHX01BQ19FTVVNT1VTRUJUTj15CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX01JST15
CkNPTkZJR19ORVRfQ09SRT15CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJ
R19EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX1dJUkVHVUFSRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9URUFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDVkxBTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYTEFOIGlzIG5vdCBzZXQK
IyBDT05GSUdfR0VORVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFSRVVEUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0dUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FNVCBpcyBub3Qgc2V0CiMgQ09O
RklHX01BQ1NFQyBpcyBub3Qgc2V0CkNPTkZJR19ORVRDT05TT0xFPXkKIyBDT05GSUdfTkVU
Q09OU09MRV9FWFRFTkRFRF9MT0cgaXMgbm90IHNldApDT05GSUdfTkVUUE9MTD15CkNPTkZJ
R19ORVRfUE9MTF9DT05UUk9MTEVSPXkKIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQKIyBDT05G
SUdfVFVOX1ZORVRfQ1JPU1NfTEUgaXMgbm90IHNldAojIENPTkZJR19WRVRIIGlzIG5vdCBz
ZXQKQ09ORklHX1ZJUlRJT19ORVQ9eQojIENPTkZJR19OTE1PTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0FSQ05FVCBpcyBub3Qgc2V0CkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19ORVRfVkVO
RE9SXzNDT009eQojIENPTkZJR19QQ01DSUFfM0M1NzQgaXMgbm90IHNldAojIENPTkZJR19Q
Q01DSUFfM0M1ODkgaXMgbm90IHNldAojIENPTkZJR19WT1JURVggaXMgbm90IHNldAojIENP
TkZJR19UWVBIT09OIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfQURBUFRFQz15CiMg
Q09ORklHX0FEQVBURUNfU1RBUkZJUkUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9B
R0VSRT15CiMgQ09ORklHX0VUMTMxWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FM
QUNSSVRFQ0g9eQojIENPTkZJR19TTElDT1NTIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5E
T1JfQUxURU9OPXkKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxURVJB
X1RTRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FNQVpPTj15CiMgQ09ORklHX0VO
QV9FVEhFUk5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0FNRD15CiMgQ09ORklH
X0FNRDgxMTFfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfUENORVQzMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1BDTUNJQV9OTUNMQU4gaXMgbm90IHNldAojIENPTkZJR19BTURfWEdCRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BEU19DT1JFIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1Jf
QVFVQU5USUE9eQojIENPTkZJR19BUVRJT04gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9BUkM9eQpDT05GSUdfTkVUX1ZFTkRPUl9BU0lYPXkKQ09ORklHX05FVF9WRU5ET1JfQVRI
RVJPUz15CiMgQ09ORklHX0FUTDIgaXMgbm90IHNldAojIENPTkZJR19BVEwxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVRMMUUgaXMgbm90IHNldAojIENPTkZJR19BVEwxQyBpcyBub3Qgc2V0
CiMgQ09ORklHX0FMWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NYX0VDQVQgaXMgbm90IHNldApD
T05GSUdfTkVUX1ZFTkRPUl9CUk9BRENPTT15CiMgQ09ORklHX0I0NCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JDTUdFTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfQk5YMiBpcyBub3Qgc2V0CiMg
Q09ORklHX0NOSUMgaXMgbm90IHNldApDT05GSUdfVElHT04zPXkKQ09ORklHX1RJR09OM19I
V01PTj15CiMgQ09ORklHX0JOWDJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNUE9SVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JOWFQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9D
QURFTkNFPXkKQ09ORklHX05FVF9WRU5ET1JfQ0FWSVVNPXkKIyBDT05GSUdfVEhVTkRFUl9O
SUNfUEYgaXMgbm90IHNldAojIENPTkZJR19USFVOREVSX05JQ19WRiBpcyBub3Qgc2V0CiMg
Q09ORklHX1RIVU5ERVJfTklDX0JHWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RIVU5ERVJfTklD
X1JHWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NBVklVTV9QVFAgaXMgbm90IHNldAojIENPTkZJ
R19MSVFVSURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJUVVJRElPX1ZGIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9WRU5ET1JfQ0hFTFNJTz15CiMgQ09ORklHX0NIRUxTSU9fVDEgaXMgbm90
IHNldAojIENPTkZJR19DSEVMU0lPX1QzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hFTFNJT19U
NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIRUxTSU9fVDRWRiBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX0NJU0NPPXkKIyBDT05GSUdfRU5JQyBpcyBub3Qgc2V0CkNPTkZJR19ORVRf
VkVORE9SX0NPUlRJTkE9eQpDT05GSUdfTkVUX1ZFTkRPUl9EQVZJQ09NPXkKIyBDT05GSUdf
RE5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0RFQz15CkNPTkZJR19ORVRfVFVM
SVA9eQojIENPTkZJR19ERTIxMDRYIGlzIG5vdCBzZXQKIyBDT05GSUdfVFVMSVAgaXMgbm90
IHNldAojIENPTkZJR19XSU5CT05EXzg0MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNOTEwMiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VMSTUyNlggaXMgbm90IHNldAojIENPTkZJR19QQ01DSUFf
WElSQ09NIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRExJTks9eQojIENPTkZJR19E
TDJLIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOREFOQ0UgaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9FTVVMRVg9eQojIENPTkZJR19CRTJORVQgaXMgbm90IHNldApDT05GSUdfTkVU
X1ZFTkRPUl9FTkdMRURFUj15CiMgQ09ORklHX1RTTkVQIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9WRU5ET1JfRVpDSElQPXkKQ09ORklHX05FVF9WRU5ET1JfRlVKSVRTVT15CiMgQ09ORklH
X1BDTUNJQV9GTVZKMThYIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRlVOR0lCTEU9
eQojIENPTkZJR19GVU5fRVRIIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfR09PR0xF
PXkKIyBDT05GSUdfR1ZFIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfSFVBV0VJPXkK
IyBDT05GSUdfSElOSUMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9JODI1WFg9eQpD
T05GSUdfTkVUX1ZFTkRPUl9JTlRFTD15CkNPTkZJR19FMTAwPXkKQ09ORklHX0UxMDAwPXkK
Q09ORklHX0UxMDAwRT15CkNPTkZJR19FMTAwMEVfSFdUUz15CiMgQ09ORklHX0lHQiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lHQlZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSVhHQkUgaXMgbm90
IHNldAojIENPTkZJR19JWEdCRVZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTQwRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0k0MEVWRiBpcyBub3Qgc2V0CiMgQ09ORklHX0lDRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZNMTBLIGlzIG5vdCBzZXQKIyBDT05GSUdfSUdDIGlzIG5vdCBzZXQKIyBD
T05GSUdfSURQRiBpcyBub3Qgc2V0CiMgQ09ORklHX0pNRSBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX0xJVEVYPXkKQ09ORklHX05FVF9WRU5ET1JfTUFSVkVMTD15CiMgQ09ORklH
X01WTURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NLR0UgaXMgbm90IHNldApDT05GSUdfU0tZ
Mj15CiMgQ09ORklHX1NLWTJfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19PQ1RFT05fRVAg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9NRUxMQU5PWD15CiMgQ09ORklHX01MWDRf
RU4gaXMgbm90IHNldAojIENPTkZJR19NTFg1X0NPUkUgaXMgbm90IHNldAojIENPTkZJR19N
TFhTV19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUxYRlcgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9NSUNSRUw9eQojIENPTkZJR19LUzg4NDIgaXMgbm90IHNldAojIENPTkZJ
R19LUzg4NTFfTUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfS1NaODg0WF9QQ0kgaXMgbm90IHNl
dApDT05GSUdfTkVUX1ZFTkRPUl9NSUNST0NISVA9eQojIENPTkZJR19MQU43NDNYIGlzIG5v
dCBzZXQKIyBDT05GSUdfVkNBUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX01JQ1JP
U0VNST15CkNPTkZJR19ORVRfVkVORE9SX01JQ1JPU09GVD15CkNPTkZJR19ORVRfVkVORE9S
X01ZUkk9eQojIENPTkZJR19NWVJJMTBHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZFQUxOWCBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX05JPXkKIyBDT05GSUdfTklfWEdFX01BTkFH
RU1FTlRfRU5FVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX05BVFNFTUk9eQojIENP
TkZJR19OQVRTRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX05FVEVSSU9OPXkKIyBDT05GSUdfUzJJTyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX05FVFJPTk9NRT15CiMgQ09ORklHX05GUCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SXzgzOTA9eQojIENPTkZJR19QQ01DSUFfQVhORVQgaXMgbm90IHNl
dAojIENPTkZJR19ORTJLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9QQ05FVCBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX05WSURJQT15CkNPTkZJR19GT1JDRURFVEg9
eQpDT05GSUdfTkVUX1ZFTkRPUl9PS0k9eQojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SX1BBQ0tFVF9FTkdJTkVTPXkKIyBDT05GSUdfSEFNQUNISSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9S
X1BFTlNBTkRPPXkKIyBDT05GSUdfSU9OSUMgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9RTE9HSUM9eQojIENPTkZJR19RTEEzWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfUUxDTklD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUWEVOX05JQyBpcyBub3Qgc2V0CiMgQ09ORklHX1FF
RCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0JST0NBREU9eQojIENPTkZJR19CTkEg
aXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9RVUFMQ09NTT15CiMgQ09ORklHX1FDT01f
RU1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JNTkVUIGlzIG5vdCBzZXQKQ09ORklHX05FVF9W
RU5ET1JfUkRDPXkKIyBDT05GSUdfUjYwNDAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9SRUFMVEVLPXkKIyBDT05GSUdfODEzOUNQIGlzIG5vdCBzZXQKQ09ORklHXzgxMzlUT089
eQpDT05GSUdfODEzOVRPT19QSU89eQojIENPTkZJR184MTM5VE9PX1RVTkVfVFdJU1RFUiBp
cyBub3Qgc2V0CiMgQ09ORklHXzgxMzlUT09fODEyOSBpcyBub3Qgc2V0CiMgQ09ORklHXzgx
MzlfT0xEX1JYX1JFU0VUIGlzIG5vdCBzZXQKQ09ORklHX1I4MTY5PXkKQ09ORklHX05FVF9W
RU5ET1JfUkVORVNBUz15CkNPTkZJR19ORVRfVkVORE9SX1JPQ0tFUj15CkNPTkZJR19ORVRf
VkVORE9SX1NBTVNVTkc9eQojIENPTkZJR19TWEdCRV9FVEggaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9TRUVRPXkKQ09ORklHX05FVF9WRU5ET1JfU0lMQU49eQojIENPTkZJR19T
QzkyMDMxIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU0lTPXkKIyBDT05GSUdfU0lT
OTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0lTMTkwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9W
RU5ET1JfU09MQVJGTEFSRT15CiMgQ09ORklHX1NGQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NG
Q19GQUxDT04gaXMgbm90IHNldAojIENPTkZJR19TRkNfU0lFTkEgaXMgbm90IHNldApDT05G
SUdfTkVUX1ZFTkRPUl9TTVNDPXkKIyBDT05GSUdfUENNQ0lBX1NNQzkxQzkyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NNU0M5MTFYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU01TQzk0MjAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9T
T0NJT05FWFQ9eQpDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JPPXkKIyBDT05GSUdfU1RNTUFD
X0VUSCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1NVTj15CiMgQ09ORklHX0hBUFBZ
TUVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NB
U1NJTkkgaXMgbm90IHNldAojIENPTkZJR19OSVUgaXMgbm90IHNldApDT05GSUdfTkVUX1ZF
TkRPUl9TWU5PUFNZUz15CiMgQ09ORklHX0RXQ19YTEdNQUMgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9URUhVVEk9eQojIENPTkZJR19URUhVVEkgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9UST15CiMgQ09ORklHX1RJX0NQU1dfUEhZX1NFTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RMQU4gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9WRVJURVhDT009eQpD
T05GSUdfTkVUX1ZFTkRPUl9WSUE9eQojIENPTkZJR19WSUFfUkhJTkUgaXMgbm90IHNldAoj
IENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9XQU5H
WFVOPXkKIyBDT05GSUdfTkdCRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1dJWk5F
VD15CiMgQ09ORklHX1dJWk5FVF9XNTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJWk5FVF9X
NTMwMCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJTElOWD15CiMgQ09ORklHX1hJ
TElOWF9FTUFDTElURSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9MTF9URU1BQyBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1hJUkNPTT15CiMgQ09ORklHX1BDTUNJQV9YSVJD
MlBTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJUFBJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NCMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19QSFlM
SUI9eQpDT05GSUdfU1dQSFk9eQojIENPTkZJR19MRURfVFJJR0dFUl9QSFkgaXMgbm90IHNl
dApDT05GSUdfRklYRURfUEhZPXkKCiMKIyBNSUkgUEhZIGRldmljZSBkcml2ZXJzCiMKIyBD
T05GSUdfQU1EX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0FESU5fUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfQURJTjExMDBfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQVFVQU5USUFfUEhZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVg4ODc5NkJfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
QlJPQURDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNNTQxNDBfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkNNN1hYWF9QSFkgaXMgbm90IHNldAojIENPTkZJR19CQ004NDg4MV9Q
SFkgaXMgbm90IHNldAojIENPTkZJR19CQ004N1hYX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NJQ0FEQV9QSFkgaXMgbm90IHNldAojIENPTkZJR19DT1JUSU5BX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RBVklDT01fUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNQTFVTX1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0xYVF9QSFkgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9Y
V0FZX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0xTSV9FVDEwMTFDX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX01BUlZFTExfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF8xMEdf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF84OFEyWFhYX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX01BUlZFTExfODhYMjIyMl9QSFkgaXMgbm90IHNldAojIENPTkZJR19NQVhM
SU5FQVJfR1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01FRElBVEVLX0dFX1BIWSBpcyBub3Qg
c2V0CiMgQ09ORklHX01JQ1JFTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19NSUNST0NISVBf
VDFTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01JQ1JPQ0hJUF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19NSUNST0NISVBfVDFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9TRU1J
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVE9SQ09NTV9QSFkgaXMgbm90IHNldAojIENP
TkZJR19OQVRJT05BTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19OWFBfQ0JUWF9QSFkgaXMg
bm90IHNldAojIENPTkZJR19OWFBfQzQ1X1RKQTExWFhfUEhZIGlzIG5vdCBzZXQKIyBDT05G
SUdfTlhQX1RKQTExWFhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkNOMjYwMDBfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfUVNFTUlfUEhZIGlzIG5vdCBzZXQKQ09ORklHX1JFQUxURUtf
UEhZPXkKIyBDT05GSUdfUkVORVNBU19QSFkgaXMgbm90IHNldAojIENPTkZJR19ST0NLQ0hJ
UF9QSFkgaXMgbm90IHNldAojIENPTkZJR19TTVNDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NURTEwWFAgaXMgbm90IHNldAojIENPTkZJR19URVJBTkVUSUNTX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RQODM4MjJfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfRFA4M1RDODExX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0RQODM4NDhfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFA4Mzg2N19QSFkgaXMgbm90IHNldAojIENPTkZJR19EUDgzODY5X1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RQODNURDUxMF9QSFkgaXMgbm90IHNldAojIENPTkZJR19WSVRFU1NFX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9HTUlJMlJHTUlJIGlzIG5vdCBzZXQKIyBD
T05GSUdfUFNFX0NPTlRST0xMRVIgaXMgbm90IHNldApDT05GSUdfTURJT19ERVZJQ0U9eQpD
T05GSUdfTURJT19CVVM9eQpDT05GSUdfRldOT0RFX01ESU89eQpDT05GSUdfQUNQSV9NRElP
PXkKQ09ORklHX01ESU9fREVWUkVTPXkKIyBDT05GSUdfTURJT19CSVRCQU5HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTURJT19CQ01fVU5JTUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfTURJT19N
VlVTQiBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9fVEhVTkRFUiBpcyBub3Qgc2V0CgojCiMg
TURJTyBNdWx0aXBsZXhlcnMKIwoKIwojIFBDUyBkZXZpY2UgZHJpdmVycwojCiMgZW5kIG9m
IFBDUyBkZXZpY2UgZHJpdmVycwoKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0xJUCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfTkVUX0RSSVZFUlM9eQojIENPTkZJR19VU0Jf
Q0FUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQVdFVEggaXMgbm90IHNldAojIENPTkZJ
R19VU0JfUEVHQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SVEw4MTUwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1JUTDgxNTIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEFONzhY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSFNPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lQSEVUSCBpcyBub3Qgc2V0CkNPTkZJ
R19XTEFOPXkKQ09ORklHX1dMQU5fVkVORE9SX0FETVRFSz15CiMgQ09ORklHX0FETTgyMTEg
aXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQVRIPXkKIyBDT05GSUdfQVRIX0RFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRINUsgaXMgbm90IHNldAojIENPTkZJR19BVEg1S19Q
Q0kgaXMgbm90IHNldAojIENPTkZJR19BVEg5SyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDlL
X0hUQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NBUkw5MTcwIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVRINktMIGlzIG5vdCBzZXQKIyBDT05GSUdfQVI1NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdf
V0lMNjIxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUSDEwSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1dDTjM2WFggaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQVRNRUw9eQojIENPTkZJ
R19BVDc2QzUwWF9VU0IgaXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfQlJPQURDT009
eQojIENPTkZJR19CNDMgaXMgbm90IHNldAojIENPTkZJR19CNDNMRUdBQ1kgaXMgbm90IHNl
dAojIENPTkZJR19CUkNNU01BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0JSQ01GTUFDIGlzIG5v
dCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX0lOVEVMPXkKIyBDT05GSUdfSVBXMjEwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQVzIyMDAgaXMgbm90IHNldAojIENPTkZJR19JV0w0OTY1IGlz
IG5vdCBzZXQKIyBDT05GSUdfSVdMMzk0NSBpcyBub3Qgc2V0CiMgQ09ORklHX0lXTFdJRkkg
aXMgbm90IHNldApDT05GSUdfV0xBTl9WRU5ET1JfSU5URVJTSUw9eQojIENPTkZJR19QNTRf
Q09NTU9OIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX01BUlZFTEw9eQojIENPTkZJ
R19MSUJFUlRBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkVSVEFTX1RISU5GSVJNIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVdJRklFWCBpcyBub3Qgc2V0CiMgQ09ORklHX01XTDhLIGlzIG5v
dCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX01FRElBVEVLPXkKIyBDT05GSUdfTVQ3NjAxVSBp
cyBub3Qgc2V0CiMgQ09ORklHX01UNzZ4MFUgaXMgbm90IHNldAojIENPTkZJR19NVDc2eDBF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3NngyRSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzZ4
MlUgaXMgbm90IHNldAojIENPTkZJR19NVDc2MDNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3
NjE1RSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzY2M1UgaXMgbm90IHNldAojIENPTkZJR19N
VDc5MTVFIGlzIG5vdCBzZXQKIyBDT05GSUdfTVQ3OTIxRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01UNzkyMVUgaXMgbm90IHNldAojIENPTkZJR19NVDc5OTZFIGlzIG5vdCBzZXQKIyBDT05G
SUdfTVQ3OTI1RSBpcyBub3Qgc2V0CiMgQ09ORklHX01UNzkyNVUgaXMgbm90IHNldApDT05G
SUdfV0xBTl9WRU5ET1JfTUlDUk9DSElQPXkKQ09ORklHX1dMQU5fVkVORE9SX1BVUkVMSUZJ
PXkKIyBDT05GSUdfUExGWExDIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1JBTElO
Sz15CiMgQ09ORklHX1JUMlgwMCBpcyBub3Qgc2V0CkNPTkZJR19XTEFOX1ZFTkRPUl9SRUFM
VEVLPXkKIyBDT05GSUdfUlRMODE4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUTDgxODcgaXMg
bm90IHNldApDT05GSUdfUlRMX0NBUkRTPXkKIyBDT05GSUdfUlRMODE5MkNFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRMODE5MlNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE5MkRFIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRMODcyM0FFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODcy
M0JFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE4OEVFIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRMODE5MkVFIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODgyMUFFIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRMODE5MkNVIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMOFhYWFUgaXMgbm90IHNl
dAojIENPTkZJR19SVFc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUVzg5IGlzIG5vdCBzZXQK
Q09ORklHX1dMQU5fVkVORE9SX1JTST15CiMgQ09ORklHX1JTSV85MVggaXMgbm90IHNldApD
T05GSUdfV0xBTl9WRU5ET1JfU0lMQUJTPXkKQ09ORklHX1dMQU5fVkVORE9SX1NUPXkKIyBD
T05GSUdfQ1cxMjAwIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1RJPXkKIyBDT05G
SUdfV0wxMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfV0wxMlhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfV0wxOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xDT1JFIGlzIG5vdCBzZXQKQ09ORklH
X1dMQU5fVkVORE9SX1pZREFTPXkKIyBDT05GSUdfWkQxMjExUlcgaXMgbm90IHNldApDT05G
SUdfV0xBTl9WRU5ET1JfUVVBTlRFTk5BPXkKIyBDT05GSUdfUVRORk1BQ19QQ0lFIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUFDODAyMTFfSFdTSU0gaXMgbm90IHNldAojIENPTkZJR19WSVJU
X1dJRkkgaXMgbm90IHNldAojIENPTkZJR19XQU4gaXMgbm90IHNldAoKIwojIFdpcmVsZXNz
IFdBTgojCiMgQ09ORklHX1dXQU4gaXMgbm90IHNldAojIGVuZCBvZiBXaXJlbGVzcyBXQU4K
CiMgQ09ORklHX1ZNWE5FVDMgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX0VTIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUREVWU0lNIGlzIG5vdCBzZXQKQ09ORklHX05FVF9GQUlMT1ZF
Uj15CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0
CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0xFRFM9eQpDT05GSUdfSU5QVVRfRkZf
TUVNTEVTUz15CkNPTkZJR19JTlBVVF9TUEFSU0VLTUFQPXkKIyBDT05GSUdfSU5QVVRfTUFU
UklYS01BUCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9WSVZBTERJRk1BUD15CgojCiMgVXNl
cmxhbmQgaW50ZXJmYWNlcwojCiMgQ09ORklHX0lOUFVUX01PVVNFREVWIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX0VWREVWPXkK
IyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IERldmljZSBEcml2
ZXJzCiMKQ09ORklHX0lOUFVUX0tFWUJPQVJEPXkKIyBDT05GSUdfS0VZQk9BUkRfQURQNTU4
OCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODkgaXMgbm90IHNldApDT05G
SUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9RVDEwNTAgaXMgbm90IHNl
dAojIENPTkZJR19LRVlCT0FSRF9RVDEwNzAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FS
RF9RVDIxNjAgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ETElOS19ESVI2ODUgaXMg
bm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
WUJPQVJEX1RDQTY0MTYgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9UQ0E4NDE4IGlz
IG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTE04MzIzIGlzIG5vdCBzZXQKIyBDT05GSUdf
S0VZQk9BUkRfTE04MzMzIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTUFYNzM1OSBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01DUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
WUJPQVJEX01QUjEyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX09QRU5DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX1NUT1dBV0FZIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfU1VOS0JE
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfVE0yX1RPVUNIS0VZIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZQk9BUkRfWFRLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9D
WVBSRVNTX1NGIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01PVVNFPXkKQ09ORklHX01PVVNF
X1BTMj15CkNPTkZJR19NT1VTRV9QUzJfQUxQUz15CkNPTkZJR19NT1VTRV9QUzJfQllEPXkK
Q09ORklHX01PVVNFX1BTMl9MT0dJUFMyUFA9eQpDT05GSUdfTU9VU0VfUFMyX1NZTkFQVElD
Uz15CkNPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNTX1NNQlVTPXkKQ09ORklHX01PVVNFX1BT
Ml9DWVBSRVNTPXkKQ09ORklHX01PVVNFX1BTMl9MSUZFQk9PSz15CkNPTkZJR19NT1VTRV9Q
UzJfVFJBQ0tQT0lOVD15CiMgQ09ORklHX01PVVNFX1BTMl9FTEFOVEVDSCBpcyBub3Qgc2V0
CiMgQ09ORklHX01PVVNFX1BTMl9TRU5URUxJQyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNF
X1BTMl9UT1VDSEtJVCBpcyBub3Qgc2V0CkNPTkZJR19NT1VTRV9QUzJfRk9DQUxURUNIPXkK
IyBDT05GSUdfTU9VU0VfUFMyX1ZNTU9VU0UgaXMgbm90IHNldApDT05GSUdfTU9VU0VfUFMy
X1NNQlVTPXkKIyBDT05GSUdfTU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9V
U0VfQVBQTEVUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0JDTTU5NzQgaXMgbm90
IHNldAojIENPTkZJR19NT1VTRV9DWUFQQSBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0VM
QU5fSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMg
Q09ORklHX01PVVNFX1NZTkFQVElDU19JMkMgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9T
WU5BUFRJQ1NfVVNCIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX0pPWVNUSUNLPXkKIyBDT05G
SUdfSk9ZU1RJQ0tfQU5BTE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQTNEIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQURJIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9Z
U1RJQ0tfQ09CUkEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HRjJLIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1JJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X0dSSVBfTVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HVUlMTEVNT1QgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19JTlRFUkFDVCBpcyBub3Qgc2V0CiMgQ09ORklHX0pP
WVNUSUNLX1NJREVXSU5ERVIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19UTURDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFIGlzIG5vdCBzZXQKIyBDT05GSUdf
Sk9ZU1RJQ0tfV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX01BR0VMTEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VPUkIgaXMgbm90IHNldAojIENP
TkZJR19KT1lTVElDS19TUEFDRUJBTEwgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19T
VElOR0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfVFdJREpPWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0pPWVNUSUNLX1pIRU5IVUEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19BUzUwMTEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19KT1lEVU1QIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfWFBBRCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNL
X1BYUkMgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19RV0lJQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0pPWVNUSUNLX0ZTSUE2QiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NF
TlNFSEFUIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX1RBQkxFVD15CiMgQ09ORklHX1RBQkxF
VF9VU0JfQUNFQ0FEIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVUX1VTQl9BSVBURUsgaXMg
bm90IHNldAojIENPTkZJR19UQUJMRVRfVVNCX0hBTldBTkcgaXMgbm90IHNldAojIENPTkZJ
R19UQUJMRVRfVVNCX0tCVEFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVUX1VTQl9QRUdB
U1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFCTEVUX1NFUklBTF9XQUNPTTQgaXMgbm90IHNl
dApDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU49eQojIENPTkZJR19UT1VDSFNDUkVFTl9BRDc4
NzkgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9BVE1FTF9NWFQgaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9CVTIxMDEzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9V
Q0hTQ1JFRU5fQlUyMTAyOSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NISVBP
TkVfSUNOODUwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZOENUTUExNDAg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9DWVRUU1BfQ09SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPVUNIU0NSRUVOX0NZVFRTUDRfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPVUNIU0NSRUVOX0NZVFRTUDUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9E
WU5BUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fSEFNUFNISVJFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRUVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
VUNIU0NSRUVOX0VHQUxBWF9TRVJJQUwgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVF
Tl9FWEMzMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fRlVKSVRTVSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hJREVFUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RPVUNIU0NSRUVOX0hZQ09OX0hZNDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX0hZTklUUk9OX0NTVFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0lM
STIxMFggaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JTElURUsgaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9TNlNZNzYxIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9V
Q0hTQ1JFRU5fR1VOWkUgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9FS1RGMjEy
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VMQU4gaXMgbm90IHNldAojIENP
TkZJR19UT1VDSFNDUkVFTl9FTE8gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9X
QUNPTV9XODAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1dBQ09NX0kyQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01BWDExODAxIGlzIG5vdCBzZXQKIyBD
T05GSUdfVE9VQ0hTQ1JFRU5fTUNTNTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NS
RUVOX01NUzExNCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX01FTEZBU19NSVA0
IGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fTVRPVUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfVE9VQ0hTQ1JFRU5fTk9WQVRFS19OVlRfVFMgaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9JTUFHSVMgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9JTkVY
SU8gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QRU5NT1VOVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1RPVUNIU0NSRUVOX0VEVF9GVDVYMDYgaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9UT1VDSFJJR0hUIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5f
VE9VQ0hXSU4gaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9QSVhDSVIgaXMgbm90
IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9XRFQ4N1hYX0kyQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1RPVUNIU0NSRUVOX1VTQl9DT01QT1NJVEUgaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9UT1VDSElUMjEzIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFND
X1NFUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fVFNDMjAwNCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1RTQzIwMDcgaXMgbm90IHNldAojIENPTkZJR19U
T1VDSFNDUkVFTl9TSUxFQUQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9TVDEy
MzIgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9TVE1GVFMgaXMgbm90IHNldAoj
IENPTkZJR19UT1VDSFNDUkVFTl9TWDg2NTQgaXMgbm90IHNldAojIENPTkZJR19UT1VDSFND
UkVFTl9UUFM2NTA3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX1pFVDYyMjMg
aXMgbm90IHNldAojIENPTkZJR19UT1VDSFNDUkVFTl9ST0hNX0JVMjEwMjMgaXMgbm90IHNl
dAojIENPTkZJR19UT1VDSFNDUkVFTl9JUVM1WFggaXMgbm90IHNldAojIENPTkZJR19UT1VD
SFNDUkVFTl9JUVM3MjExIGlzIG5vdCBzZXQKIyBDT05GSUdfVE9VQ0hTQ1JFRU5fWklOSVRJ
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RPVUNIU0NSRUVOX0hJTUFYX0hYODMxMTJCIGlzIG5v
dCBzZXQKQ09ORklHX0lOUFVUX01JU0M9eQojIENPTkZJR19JTlBVVF9BRDcxNFggaXMgbm90
IHNldAojIENPTkZJR19JTlBVVF9CTUExNTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9F
M1gwX0JVVFRPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1BDU1BLUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX01NQTg0NTAgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BUEFO
RUwgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BVExBU19CVE5TIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfQVRJX1JFTU9URTIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9LRVlT
UEFOX1JFTU9URSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0tYVEo5IGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfUE9XRVJNQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfWUVB
TElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0NNMTA5IGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfVUlOUFVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUENGODU3NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RBNzI4MF9IQVBUSUNTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfQURYTDM0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lNU19QQ1UgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9JUVMyNjlBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfSVFTNjI2QSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0lRUzcyMjIgaXMgbm90IHNl
dAojIENPTkZJR19JTlBVVF9DTUEzMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSURF
QVBBRF9TTElERUJBUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2NjVfSEFQVElD
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0RSVjI2NjdfSEFQVElDUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1JNSTRfQ09SRSBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRz
CiMKQ09ORklHX1NFUklPPXkKQ09ORklHX0FSQ0hfTUlHSFRfSEFWRV9QQ19TRVJJTz15CkNP
TkZJR19TRVJJT19JODA0Mj15CkNPTkZJR19TRVJJT19TRVJQT1JUPXkKIyBDT05GSUdfU0VS
SU9fQ1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNl
dApDT05GSUdfU0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VSSU9fQUxURVJBX1BTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BT
Mk1VTFQgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUkNfUFMyIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNFUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlQgaXMgbm90IHNldAoj
IGVuZCBvZiBIYXJkd2FyZSBJL08gcG9ydHMKIyBlbmQgb2YgSW5wdXQgZGV2aWNlIHN1cHBv
cnQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNlcwojCkNPTkZJR19UVFk9eQpDT05GSUdfVlQ9eQpD
T05GSUdfQ09OU09MRV9UUkFOU0xBVElPTlM9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJ
R19WVF9DT05TT0xFX1NMRUVQPXkKQ09ORklHX0hXX0NPTlNPTEU9eQojIENPTkZJR19WVF9I
V19DT05TT0xFX0JJTkRJTkcgaXMgbm90IHNldApDT05GSUdfVU5JWDk4X1BUWVM9eQojIENP
TkZJR19MRUdBQ1lfUFRZUyBpcyBub3Qgc2V0CkNPTkZJR19MRUdBQ1lfVElPQ1NUST15CkNP
TkZJR19MRElTQ19BVVRPTE9BRD15CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VS
SUFMX0VBUkxZQ09OPXkKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84MjUw
X0RFUFJFQ0FURURfT1BUSU9OUz15CkNPTkZJR19TRVJJQUxfODI1MF9QTlA9eQojIENPTkZJ
R19TRVJJQUxfODI1MF8xNjU1MEFfVkFSSUFOVFMgaXMgbm90IHNldAojIENPTkZJR19TRVJJ
QUxfODI1MF9GSU5URUsgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15
CkNPTkZJR19TRVJJQUxfODI1MF9ETUE9eQpDT05GSUdfU0VSSUFMXzgyNTBfUENJTElCPXkK
Q09ORklHX1NFUklBTF84MjUwX1BDST15CkNPTkZJR19TRVJJQUxfODI1MF9FWEFSPXkKIyBD
T05GSUdfU0VSSUFMXzgyNTBfQ1MgaXMgbm90IHNldApDT05GSUdfU0VSSUFMXzgyNTBfTlJf
VUFSVFM9MzIKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVfVUFSVFM9NApDT05GSUdfU0VS
SUFMXzgyNTBfRVhURU5ERUQ9eQpDT05GSUdfU0VSSUFMXzgyNTBfTUFOWV9QT1JUUz15CiMg
Q09ORklHX1NFUklBTF84MjUwX1BDSTFYWFhYIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84
MjUwX1NIQVJFX0lSUT15CkNPTkZJR19TRVJJQUxfODI1MF9ERVRFQ1RfSVJRPXkKQ09ORklH
X1NFUklBTF84MjUwX1JTQT15CkNPTkZJR19TRVJJQUxfODI1MF9EV0xJQj15CiMgQ09ORklH
X1NFUklBTF84MjUwX0RXIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUlQyODhY
IGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX0xQU1M9eQpDT05GSUdfU0VSSUFMXzgy
NTBfTUlEPXkKQ09ORklHX1NFUklBTF84MjUwX1BFUklDT009eQoKIwojIE5vbi04MjUwIHNl
cmlhbCBwb3J0IHN1cHBvcnQKIwojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNl
dApDT05GSUdfU0VSSUFMX0NPUkU9eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CiMg
Q09ORklHX1NFUklBTF9KU00gaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfTEFOVElRIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1NDQ05YUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
UklBTF9TQzE2SVM3WFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJBX0pUQUdV
QVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FMVEVSQV9VQVJUIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VSSUFMX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9SUDIgaXMg
bm90IHNldAojIENPTkZJR19TRVJJQUxfRlNMX0xQVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFUklBTF9GU0xfTElORkxFWFVBUlQgaXMgbm90IHNldAojIGVuZCBvZiBTZXJpYWwgZHJp
dmVycwoKQ09ORklHX1NFUklBTF9OT05TVEFOREFSRD15CiMgQ09ORklHX01PWEFfSU5URUxM
SU8gaXMgbm90IHNldAojIENPTkZJR19NT1hBX1NNQVJUSU8gaXMgbm90IHNldAojIENPTkZJ
R19OX0hETEMgaXMgbm90IHNldAojIENPTkZJR19JUFdJUkVMRVNTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTl9HU00gaXMgbm90IHNldAojIENPTkZJR19OT1pPTUkgaXMgbm90IHNldAojIENP
TkZJR19OVUxMX1RUWSBpcyBub3Qgc2V0CkNPTkZJR19IVkNfRFJJVkVSPXkKIyBDT05GSUdf
U0VSSUFMX0RFVl9CVVMgaXMgbm90IHNldApDT05GSUdfVklSVElPX0NPTlNPTEU9eQojIENP
TkZJR19JUE1JX0hBTkRMRVIgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NPXkKIyBDT05G
SUdfSFdfUkFORE9NX1RJTUVSSU9NRU0gaXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET01f
SU5URUwgaXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET01fQU1EIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFdfUkFORE9NX0JBNDMxIGlzIG5vdCBzZXQKQ09ORklHX0hXX1JBTkRPTV9WSUE9
eQojIENPTkZJR19IV19SQU5ET01fVklSVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFO
RE9NX1hJUEhFUkEgaXMgbm90IHNldAojIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CiMg
Q09ORklHX01XQVZFIGlzIG5vdCBzZXQKQ09ORklHX0RFVk1FTT15CkNPTkZJR19OVlJBTT15
CkNPTkZJR19ERVZQT1JUPXkKQ09ORklHX0hQRVQ9eQojIENPTkZJR19IUEVUX01NQVAgaXMg
bm90IHNldAojIENPTkZJR19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldAojIENPTkZJR19U
Q0dfVFBNIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVMQ0xPQ0sgaXMgbm90IHNldAojIENPTkZJ
R19YSUxMWUJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTExZVVNCIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQ2hhcmFjdGVyIGRldmljZXMKCiMKIyBJMkMgc3VwcG9ydAojCkNPTkZJR19JMkM9
eQpDT05GSUdfQUNQSV9JMkNfT1BSRUdJT049eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CkNP
TkZJR19JMkNfQ09NUEFUPXkKIyBDT05GSUdfSTJDX0NIQVJERVYgaXMgbm90IHNldAojIENP
TkZJR19JMkNfTVVYIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19IRUxQRVJfQVVUTz15CkNPTkZJ
R19JMkNfU01CVVM9eQpDT05GSUdfSTJDX0FMR09CSVQ9eQoKIwojIEkyQyBIYXJkd2FyZSBC
dXMgc3VwcG9ydAojCgojCiMgUEMgU01CdXMgaG9zdCBjb250cm9sbGVyIGRyaXZlcnMKIwoj
IENPTkZJR19JMkNfQUxJMTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNTYzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19JMkNf
QU1ENzU2IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDgxMTEgaXMgbm90IHNldAojIENP
TkZJR19JMkNfQU1EX01QMiBpcyBub3Qgc2V0CkNPTkZJR19JMkNfSTgwMT15CiMgQ09ORklH
X0kyQ19JU0NIIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0lTTVQgaXMgbm90IHNldAojIENP
TkZJR19JMkNfUElJWDQgaXMgbm90IHNldAojIENPTkZJR19JMkNfTkZPUkNFMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19OVklESUFfR1BVIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJ
UzU1OTUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTNjMwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1NJUzk2WCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUEgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKCiMKIyBBQ1BJIGRyaXZlcnMKIwojIENP
TkZJR19JMkNfU0NNSSBpcyBub3Qgc2V0CgojCiMgSTJDIHN5c3RlbSBidXMgZHJpdmVycyAo
bW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXApCiMKIyBDT05GSUdfSTJDX0RFU0lH
TldBUkVfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX09DT1JFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lNVEVD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1hJTElOWCBpcyBub3Qgc2V0CgojCiMgRXh0ZXJu
YWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19ESU9MQU5fVTJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0NQMjYxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19QQ0kxWFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ST0JPVEZVWlpfT1NJRiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19U
SU5ZX1VTQiBpcyBub3Qgc2V0CgojCiMgT3RoZXIgSTJDL1NNQnVzIGJ1cyBkcml2ZXJzCiMK
IyBDT05GSUdfSTJDX01MWENQTEQgaXMgbm90IHNldAojIENPTkZJR19JMkNfVklSVElPIGlz
IG5vdCBzZXQKIyBlbmQgb2YgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CgojIENPTkZJR19J
MkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TTEFWRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08g
aXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKIyBlbmQgb2Yg
STJDIHN1cHBvcnQKCiMgQ09ORklHX0kzQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NQTUkgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNl
dApDT05GSUdfUFBTPXkKIyBDT05GSUdfUFBTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQUFMg
Y2xpZW50cyBzdXBwb3J0CiMKIyBDT05GSUdfUFBTX0NMSUVOVF9LVElNRVIgaXMgbm90IHNl
dAojIENPTkZJR19QUFNfQ0xJRU5UX0xESVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBTX0NM
SUVOVF9HUElPIGlzIG5vdCBzZXQKCiMKIyBQUFMgZ2VuZXJhdG9ycyBzdXBwb3J0CiMKCiMK
IyBQVFAgY2xvY2sgc3VwcG9ydAojCkNPTkZJR19QVFBfMTU4OF9DTE9DSz15CkNPTkZJR19Q
VFBfMTU4OF9DTE9DS19PUFRJT05BTD15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQgTkVUV09S
S19QSFlfVElNRVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3MuCiMKQ09O
RklHX1BUUF8xNTg4X0NMT0NLX0tWTT15CiMgQ09ORklHX1BUUF8xNTg4X0NMT0NLX0lEVDgy
UDMzIGlzIG5vdCBzZXQKIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0tfSURUQ00gaXMgbm90IHNl
dAojIENPTkZJR19QVFBfMTU4OF9DTE9DS19NT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfUFRQ
XzE1ODhfQ0xPQ0tfVk1XIGlzIG5vdCBzZXQKIyBlbmQgb2YgUFRQIGNsb2NrIHN1cHBvcnQK
CiMgQ09ORklHX1BJTkNUUkwgaXMgbm90IHNldAojIENPTkZJR19HUElPTElCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVzEgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNFVCBpcyBub3Qg
c2V0CkNPTkZJR19QT1dFUl9TVVBQTFk9eQojIENPTkZJR19QT1dFUl9TVVBQTFlfREVCVUcg
aXMgbm90IHNldApDT05GSUdfUE9XRVJfU1VQUExZX0hXTU9OPXkKIyBDT05GSUdfSVA1WFhY
X1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9QT1dFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0NIQVJHRVJfQURQNTA2MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfQ1cyMDE1
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODAgaXMgbm90IHNldAojIENPTkZJ
R19CQVRURVJZX0RTMjc4MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfRFMyNzgyIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9TQU1TVU5HX1NESSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JBVFRFUllfU0JTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9TQlMgaXMgbm90
IHNldAojIENPTkZJR19CQVRURVJZX0JRMjdYWFggaXMgbm90IHNldAojIENPTkZJR19CQVRU
RVJZX01BWDE3MDQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg4OTAzIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9MUDg3MjcgaXMgbm90IHNldAojIENPTkZJR19DSEFS
R0VSX0xUQzQxNjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQVg3Nzk3NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfQlEyNDE1WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
VFRFUllfR0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR09MREZJ
U0ggaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NIQVJHRVJfQkQ5OTk1NCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfVUczMTA1
IGlzIG5vdCBzZXQKIyBDT05GSUdfRlVFTF9HQVVHRV9NTTgwMTMgaXMgbm90IHNldApDT05G
SUdfSFdNT049eQojIENPTkZJR19IV01PTl9ERUJVR19DSElQIGlzIG5vdCBzZXQKCiMKIyBO
YXRpdmUgZHJpdmVycwojCiMgQ09ORklHX1NFTlNPUlNfQUJJVFVHVVJVIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19BQklUVUdVUlUzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BRDc0MTQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FENzQxOCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QURNMTAyNSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QURNMTAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTE3NyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQURNOTI0MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QURUNzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQxMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QURUNzQ3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURUNzQ3NSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQUhUMTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FR
VUFDT01QVVRFUl9ENU5FWFQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTMzcwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BU0M3NjIxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19BWElfRkFOX0NPTlRST0wgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0s4
VEVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSzEwVEVNUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfRkFNMTVIX1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BUFBMRVNNQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNCMTAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19BVFhQMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
Q09SU0FJUl9DUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JTQUlSX1BTVSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFJJVkVURU1QIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19EUzYyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRFMxNjIxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ERUxMX1NNTSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfSTVLX0FNQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0Y3NTM3NVMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlRTVEVVVEFURVMgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0dJR0FCWVRFX1dBVEVSRk9SQ0UgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00gaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0c3NjBBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19HNzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ISUg2MTMwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19IUzMwMDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0k1NTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JFVEVNUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSkM0
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUE9XRVJaIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19QT1dSMTIyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFH
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTFRDMjk0N19JMkMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzI5OTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzI5OTEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0xUQzQxNTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzQyMTUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyMjIgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0xUQzQyNDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzQyNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNjEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01BWDEyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFY
MTYwNjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2MTkgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01BWDE2NjggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01B
WDE5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3MzAgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01BWDMxNzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFYMzE4Mjcg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MjAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX01BWDY2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2Mzkg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2NDIgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX01BWDY2NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2OTcg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDMxNzkwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19NQzM0VlI1MDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01DUDMw
MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNjU0IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19UUFMyMzg2MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTVI3NTIw
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE02MyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfTE03MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TE03OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTE04MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTE05MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTE05MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTIz
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05NTI0MSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTE05NTI0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzM2
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzQyNyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfTkNUNjY4MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTkNUNjc3NV9JMkMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX05DVDc4MDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05D
VDc5MDQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05QQ003WFggaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX05aWFRfS1JBS0VOMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfTlpYVF9TTUFSVDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX09DQ19QOF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX09YUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfUENGODU5MSBpcyBub3Qgc2V0CiMgQ09ORklHX1BNQlVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TQlRTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0JSTUkg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NIVDIxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19TSFQzeCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUNHggaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1NIVEMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ETUUxNzM3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19FTUMxNDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19FTUMyMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMyMzA1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19FTUM2VzIwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N00xOTIgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX1NNU0M0N0IzOTcgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1NDSDU2MjcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NDSDU2MzYg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1NUVFM3NTEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FEQzEyOEQ4MTggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEUzc4
MjggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FNQzY4MjEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0lOQTIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMlhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEyMzggaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0lOQTMyMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1RDNzQgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX1RITUM1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfVE1QMTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDMgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1RNUDEwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfVE1QNDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0MjEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1RNUDQ2NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
VE1QNTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WSUFfQ1BVVEVNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfVklBNjg2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfVlQxMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WVDgyMzEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1c4Mzc3M0cgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1c4Mzc4MUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MUQgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1c4Mzc5MkQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1c4Mzc5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzk1IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1c4M0w3ODZORyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNjI3SEYgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0VIRiBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfWEdFTkUgaXMgbm90IHNldAoKIwojIEFDUEkgZHJpdmVycwojCiMgQ09ORklHX1NF
TlNPUlNfQUNQSV9QT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVRLMDExMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNVU19XTUkgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FTVVNfRUMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0hQX1dNSSBp
cyBub3Qgc2V0CkNPTkZJR19USEVSTUFMPXkKIyBDT05GSUdfVEhFUk1BTF9ORVRMSU5LIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNTIGlzIG5vdCBzZXQKQ09ORklH
X1RIRVJNQUxfRU1FUkdFTkNZX1BPV0VST0ZGX0RFTEFZX01TPTAKQ09ORklHX1RIRVJNQUxf
SFdNT049eQpDT05GSUdfVEhFUk1BTF9XUklUQUJMRV9UUklQUz15CkNPTkZJR19USEVSTUFM
X0RFRkFVTFRfR09WX1NURVBfV0lTRT15CiMgQ09ORklHX1RIRVJNQUxfREVGQVVMVF9HT1Zf
RkFJUl9TSEFSRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfREVGQVVMVF9HT1ZfVVNF
Ul9TUEFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfR09WX0ZBSVJfU0hBUkUgaXMg
bm90IHNldApDT05GSUdfVEhFUk1BTF9HT1ZfU1RFUF9XSVNFPXkKIyBDT05GSUdfVEhFUk1B
TF9HT1ZfQkFOR19CQU5HIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUxfR09WX1VTRVJfU1BB
Q0U9eQojIENPTkZJR19USEVSTUFMX0VNVUxBVElPTiBpcyBub3Qgc2V0CgojCiMgSW50ZWwg
dGhlcm1hbCBkcml2ZXJzCiMKIyBDT05GSUdfSU5URUxfUE9XRVJDTEFNUCBpcyBub3Qgc2V0
CkNPTkZJR19YODZfVEhFUk1BTF9WRUNUT1I9eQpDT05GSUdfSU5URUxfVENDPXkKQ09ORklH
X1g4Nl9QS0dfVEVNUF9USEVSTUFMPW0KIyBDT05GSUdfSU5URUxfU09DX0RUU19USEVSTUFM
IGlzIG5vdCBzZXQKCiMKIyBBQ1BJIElOVDM0MFggdGhlcm1hbCBkcml2ZXJzCiMKIyBDT05G
SUdfSU5UMzQwWF9USEVSTUFMIGlzIG5vdCBzZXQKIyBlbmQgb2YgQUNQSSBJTlQzNDBYIHRo
ZXJtYWwgZHJpdmVycwoKIyBDT05GSUdfSU5URUxfUENIX1RIRVJNQUwgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFTF9UQ0NfQ09PTElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0hG
SV9USEVSTUFMIGlzIG5vdCBzZXQKIyBlbmQgb2YgSW50ZWwgdGhlcm1hbCBkcml2ZXJzCgpD
T05GSUdfV0FUQ0hET0c9eQojIENPTkZJR19XQVRDSERPR19DT1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfV0FUQ0hET0dfTk9XQVlPVVQgaXMgbm90IHNldApDT05GSUdfV0FUQ0hET0dfSEFO
RExFX0JPT1RfRU5BQkxFRD15CkNPTkZJR19XQVRDSERPR19PUEVOX1RJTUVPVVQ9MAojIENP
TkZJR19XQVRDSERPR19TWVNGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENIRE9HX0hSVElN
RVJfUFJFVElNRU9VVCBpcyBub3Qgc2V0CgojCiMgV2F0Y2hkb2cgUHJldGltZW91dCBHb3Zl
cm5vcnMKIwoKIwojIFdhdGNoZG9nIERldmljZSBEcml2ZXJzCiMKIyBDT05GSUdfU09GVF9X
QVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1dEQVRfV0RUIGlzIG5vdCBzZXQKIyBDT05G
SUdfWElMSU5YX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfWklJUkFWRV9XQVRDSERP
RyBpcyBub3Qgc2V0CiMgQ09ORklHX0NBREVOQ0VfV0FUQ0hET0cgaXMgbm90IHNldAojIENP
TkZJR19EV19XQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX01BWDYzWFhfV0FUQ0hET0cg
aXMgbm90IHNldAojIENPTkZJR19BQ1FVSVJFX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FE
VkFOVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19BRFZBTlRFQ0hfRUNfV0RUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUxJTTE1MzVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxJTTcx
MDFfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfRUJDX0MzODRfV0RUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRVhBUl9XRFQgaXMgbm90IHNldAojIENPTkZJR19GNzE4MDhFX1dEVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NQNTEwMF9UQ08gaXMgbm90IHNldAojIENPTkZJR19TQkNfRklUUEMy
X1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfRVVST1RFQ0hfV0RUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSUI3MDBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNQVNSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV0FGRVJfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSTYzMDBFU0JfV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfSUU2WFhfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVRD
T19XRFQgaXMgbm90IHNldAojIENPTkZJR19JVDg3MTJGX1dEVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lUODdfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBfV0FUQ0hET0cgaXMgbm90IHNl
dAojIENPTkZJR19TQzEyMDBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEM4NzQxM19XRFQg
aXMgbm90IHNldAojIENPTkZJR19OVl9UQ08gaXMgbm90IHNldAojIENPTkZJR182MFhYX1dE
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVTVfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU01T
Q19TQ0gzMTFYX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NNU0MzN0I3ODdfV0RUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVFFNWDg2X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJQV9XRFQg
aXMgbm90IHNldAojIENPTkZJR19XODM2MjdIRl9XRFQgaXMgbm90IHNldAojIENPTkZJR19X
ODM4NzdGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4Mzk3N0ZfV0RUIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUFDSFpfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0JDX0VQWF9DM19XQVRD
SERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX05JOTAzWF9XRFQgaXMgbm90IHNldAojIENPTkZJ
R19OSUM3MDE4X1dEVCBpcyBub3Qgc2V0CgojCiMgUENJLWJhc2VkIFdhdGNoZG9nIENhcmRz
CiMKIyBDT05GSUdfUENJUENXQVRDSERPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1dEVFBDSSBp
cyBub3Qgc2V0CgojCiMgVVNCLWJhc2VkIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfVVNC
UENXQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9TU0lCTEU9eQojIENPTkZJR19T
U0IgaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJMRT15CiMgQ09ORklHX0JDTUEgaXMg
bm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19N
RkRfQVMzNzExIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNUFJPIGlzIG5vdCBzZXQKIyBD
T05GSUdfUE1JQ19BRFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JDTTU5MFhYIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX0JEOTU3MU1XViBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9BWFAyMFhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0NTNDJMNDNfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX01BREVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BNSUNfREE5
MDNYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTA1Ml9JMkMgaXMgbm90IHNldAojIENP
TkZJR19NRkRfREE5MDU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTA2MiBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9EQTkwNjMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MTUw
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RMTjIgaXMgbm90IHNldAojIENPTkZJR19NRkRf
TUMxM1hYWF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTVAyNjI5IGlzIG5vdCBzZXQK
IyBDT05GSUdfTFBDX0lDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19TQ0ggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfSU5URUxfTFBTU19BQ1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0lOVEVMX0xQU1NfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lOVEVMX1BNQ19CWFQg
aXMgbm90IHNldAojIENPTkZJR19NRkRfSVFTNjJYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0pBTlpfQ01PRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBMRCBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDUg
aXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUFYMTQ1NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc1NDEgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc4
NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkwNyBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9NQVg4OTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTcgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTUFYODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NVDYzNjAg
aXMgbm90IHNldAojIENPTkZJR19NRkRfTVQ2MzcwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X01UNjM5NyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NRU5GMjFCTUMgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfVklQRVJCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SRVRVIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1BDRjUwNjMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1NZNzYzNkEgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkRDMzIxWCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9SVDQ4MzEgaXMgbm90IHNldAojIENPTkZJR19NRkRfUlQ1MDMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1JUNTEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVU
NTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NJNDc2WF9DT1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NLWTgxNDUyIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1NZU0NPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9USV9B
TTMzNVhfVFNDQURDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0xQMzk0MyBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9MUDg3ODggaXMgbm90IHNldAojIENPTkZJR19NRkRfVElfTE1VIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1BBTE1BUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzYx
MDVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJR19N
RkRfVFBTNjUwODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjUwOTAgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfVElfTFA4NzNYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1
ODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9UUFM2NTk0X0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDQwMzBfQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDYwNDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9MTTM1MzMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfVFFNWDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1ZYODU1
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1dNODQwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1dNODM1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRf
V004OTk0IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FUQzI2MFhfSTJDIGlzIG5vdCBzZXQK
IyBlbmQgb2YgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwoKIyBDT05GSUdfUkVHVUxB
VE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNfQ09SRSBpcyBub3Qgc2V0CgojCiMgQ0VDIHN1
cHBvcnQKIwojIENPTkZJR19NRURJQV9DRUNfU1VQUE9SVCBpcyBub3Qgc2V0CiMgZW5kIG9m
IENFQyBzdXBwb3J0CgojIENPTkZJR19NRURJQV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBH
cmFwaGljcyBzdXBwb3J0CiMKQ09ORklHX0FQRVJUVVJFX0hFTFBFUlM9eQpDT05GSUdfVklE
RU9fQ01ETElORT15CkNPTkZJR19WSURFT19OT01PREVTRVQ9eQojIENPTkZJR19BVVhESVNQ
TEFZIGlzIG5vdCBzZXQKQ09ORklHX0FHUD15CkNPTkZJR19BR1BfQU1ENjQ9eQpDT05GSUdf
QUdQX0lOVEVMPXkKIyBDT05GSUdfQUdQX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9W
SUEgaXMgbm90IHNldApDT05GSUdfSU5URUxfR1RUPXkKIyBDT05GSUdfVkdBX1NXSVRDSEVS
T08gaXMgbm90IHNldApDT05GSUdfRFJNPXkKQ09ORklHX0RSTV9NSVBJX0RTST15CiMgQ09O
RklHX0RSTV9ERUJVR19NTSBpcyBub3Qgc2V0CkNPTkZJR19EUk1fS01TX0hFTFBFUj15CiMg
Q09ORklHX0RSTV9GQkRFVl9FTVVMQVRJT04gaXMgbm90IHNldAojIENPTkZJR19EUk1fTE9B
RF9FRElEX0ZJUk1XQVJFIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9ESVNQTEFZX0hFTFBFUj15
CkNPTkZJR19EUk1fRElTUExBWV9EUF9IRUxQRVI9eQpDT05GSUdfRFJNX0RJU1BMQVlfSERD
UF9IRUxQRVI9eQpDT05GSUdfRFJNX0RJU1BMQVlfSERNSV9IRUxQRVI9eQojIENPTkZJR19E
Uk1fRFBfQVVYX0NIQVJERVYgaXMgbm90IHNldAojIENPTkZJR19EUk1fRFBfQ0VDIGlzIG5v
dCBzZXQKQ09ORklHX0RSTV9UVE09eQpDT05GSUdfRFJNX0JVRERZPXkKQ09ORklHX0RSTV9H
RU1fU0hNRU1fSEVMUEVSPXkKCiMKIyBJMkMgZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKIwoj
IENPTkZJR19EUk1fSTJDX0NINzAwNiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNfU0lM
MTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0kyQ19OWFBfVERBOTk4WCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9JMkNfTlhQX1REQTk5NTAgaXMgbm90IHNldAojIGVuZCBvZiBJMkMg
ZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKCiMKIyBBUk0gZGV2aWNlcwojCiMgZW5kIG9mIEFS
TSBkZXZpY2VzCgojIENPTkZJR19EUk1fUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X0FNREdQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9OT1VWRUFVIGlzIG5vdCBzZXQKQ09O
RklHX0RSTV9JOTE1PXkKQ09ORklHX0RSTV9JOTE1X0ZPUkNFX1BST0JFPSIiCkNPTkZJR19E
Uk1fSTkxNV9DQVBUVVJFX0VSUk9SPXkKQ09ORklHX0RSTV9JOTE1X0NPTVBSRVNTX0VSUk9S
PXkKQ09ORklHX0RSTV9JOTE1X1VTRVJQVFI9eQpDT05GSUdfRFJNX0k5MTVfUkVRVUVTVF9U
SU1FT1VUPTIwMDAwCkNPTkZJR19EUk1fSTkxNV9GRU5DRV9USU1FT1VUPTEwMDAwCkNPTkZJ
R19EUk1fSTkxNV9VU0VSRkFVTFRfQVVUT1NVU1BFTkQ9MjUwCkNPTkZJR19EUk1fSTkxNV9I
RUFSVEJFQVRfSU5URVJWQUw9MjUwMApDT05GSUdfRFJNX0k5MTVfUFJFRU1QVF9USU1FT1VU
PTY0MApDT05GSUdfRFJNX0k5MTVfUFJFRU1QVF9USU1FT1VUX0NPTVBVVEU9NzUwMApDT05G
SUdfRFJNX0k5MTVfTUFYX1JFUVVFU1RfQlVTWVdBSVQ9ODAwMApDT05GSUdfRFJNX0k5MTVf
U1RPUF9USU1FT1VUPTEwMApDT05GSUdfRFJNX0k5MTVfVElNRVNMSUNFX0RVUkFUSU9OPTEK
IyBDT05GSUdfRFJNX1ZHRU0gaXMgbm90IHNldAojIENPTkZJR19EUk1fVktNUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9WTVdHRlggaXMgbm90IHNldAojIENPTkZJR19EUk1fR01BNTAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1VETCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9B
U1QgaXMgbm90IHNldAojIENPTkZJR19EUk1fTUdBRzIwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9RWEwgaXMgbm90IHNldApDT05GSUdfRFJNX1ZJUlRJT19HUFU9eQpDT05GSUdfRFJN
X1ZJUlRJT19HUFVfS01TPXkKQ09ORklHX0RSTV9QQU5FTD15CgojCiMgRGlzcGxheSBQYW5l
bHMKIwojIENPTkZJR19EUk1fUEFORUxfUkFTUEJFUlJZUElfVE9VQ0hTQ1JFRU4gaXMgbm90
IHNldAojIGVuZCBvZiBEaXNwbGF5IFBhbmVscwoKQ09ORklHX0RSTV9CUklER0U9eQpDT05G
SUdfRFJNX1BBTkVMX0JSSURHRT15CgojCiMgRGlzcGxheSBJbnRlcmZhY2UgQnJpZGdlcwoj
CiMgQ09ORklHX0RSTV9BTkFMT0dJWF9BTlg3OFhYIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGlz
cGxheSBJbnRlcmZhY2UgQnJpZGdlcwoKIyBDT05GSUdfRFJNX0VUTkFWSVYgaXMgbm90IHNl
dAojIENPTkZJR19EUk1fQk9DSFMgaXMgbm90IHNldAojIENPTkZJR19EUk1fQ0lSUlVTX1FF
TVUgaXMgbm90IHNldAojIENPTkZJR19EUk1fR00xMlUzMjAgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fU0lNUExFRFJNIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1ZCT1hWSURFTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9HVUQgaXMgbm90IHNldAojIENPTkZJR19EUk1fU1NEMTMw
WCBpcyBub3Qgc2V0CkNPTkZJR19EUk1fUEFORUxfT1JJRU5UQVRJT05fUVVJUktTPXkKCiMK
IyBGcmFtZSBidWZmZXIgRGV2aWNlcwojCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBlbmQg
b2YgRnJhbWUgYnVmZmVyIERldmljZXMKCiMKIyBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNlIHN1
cHBvcnQKIwojIENPTkZJR19MQ0RfQ0xBU1NfREVWSUNFIGlzIG5vdCBzZXQKQ09ORklHX0JB
Q0tMSUdIVF9DTEFTU19ERVZJQ0U9eQojIENPTkZJR19CQUNLTElHSFRfS1RaODg2NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUFBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JB
Q0tMSUdIVF9RQ09NX1dMRUQgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfU0FIQVJB
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0FEUDg4NjAgaXMgbm90IHNldAojIENP
TkZJR19CQUNLTElHSFRfQURQODg3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9M
TTM2MzkgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTFY1MjA3TFAgaXMgbm90IHNl
dAojIENPTkZJR19CQUNLTElHSFRfQkQ2MTA3IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJ
R0hUX0FSQ1hDTk4gaXMgbm90IHNldAojIGVuZCBvZiBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNl
IHN1cHBvcnQKCkNPTkZJR19IRE1JPXkKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1
cHBvcnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfRFVNTVlfQ09OU09MRT15CkNP
TkZJR19EVU1NWV9DT05TT0xFX0NPTFVNTlM9ODAKQ09ORklHX0RVTU1ZX0NPTlNPTEVfUk9X
Uz0yNQojIGVuZCBvZiBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIyBlbmQgb2Yg
R3JhcGhpY3Mgc3VwcG9ydAoKIyBDT05GSUdfRFJNX0FDQ0VMIGlzIG5vdCBzZXQKQ09ORklH
X1NPVU5EPXkKQ09ORklHX1NORD15CkNPTkZJR19TTkRfVElNRVI9eQpDT05GSUdfU05EX1BD
TT15CkNPTkZJR19TTkRfSFdERVA9eQpDT05GSUdfU05EX1NFUV9ERVZJQ0U9eQpDT05GSUdf
U05EX0pBQ0s9eQpDT05GSUdfU05EX0pBQ0tfSU5QVVRfREVWPXkKIyBDT05GSUdfU05EX09T
U0VNVUwgaXMgbm90IHNldApDT05GSUdfU05EX1BDTV9USU1FUj15CkNPTkZJR19TTkRfSFJU
SU1FUj15CiMgQ09ORklHX1NORF9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0CkNPTkZJR19T
TkRfU1VQUE9SVF9PTERfQVBJPXkKQ09ORklHX1NORF9QUk9DX0ZTPXkKQ09ORklHX1NORF9W
RVJCT1NFX1BST0NGUz15CiMgQ09ORklHX1NORF9WRVJCT1NFX1BSSU5USyBpcyBub3Qgc2V0
CkNPTkZJR19TTkRfQ1RMX0ZBU1RfTE9PS1VQPXkKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0NUTF9JTlBVVF9WQUxJREFUSU9OIGlzIG5vdCBzZXQKQ09O
RklHX1NORF9WTUFTVEVSPXkKQ09ORklHX1NORF9ETUFfU0dCVUY9eQpDT05GSUdfU05EX1NF
UVVFTkNFUj15CkNPTkZJR19TTkRfU0VRX0RVTU1ZPXkKQ09ORklHX1NORF9TRVFfSFJUSU1F
Ul9ERUZBVUxUPXkKIyBDT05GSUdfU05EX1NFUV9VTVAgaXMgbm90IHNldApDT05GSUdfU05E
X0RSSVZFUlM9eQojIENPTkZJR19TTkRfUENTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9E
VU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9QQ01URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJUk1JREkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfTVRQQVYgaXMgbm90IHNldAojIENPTkZJR19TTkRfU0VSSUFMX1Ux
NjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NUFU0MDEgaXMgbm90IHNldApDT05GSUdf
U05EX1BDST15CiMgQ09ORklHX1NORF9BRDE4ODkgaXMgbm90IHNldAojIENPTkZJR19TTkRf
QUxTMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMUzQwMDAgaXMgbm90IHNldAojIENP
TkZJR19TTkRfQUxJNTQ1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BU0lIUEkgaXMgbm90
IHNldAojIENPTkZJR19TTkRfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlY
UF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MTAgaXMgbm90IHNldAojIENP
TkZJR19TTkRfQVU4ODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgzMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9BVzIgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVpUMzMyOCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9CVDg3WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9D
QTAxMDYgaXMgbm90IHNldAojIENPTkZJR19TTkRfQ01JUENJIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX09YWUdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQyODEgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQ1M0NlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NUWEZJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0RBUkxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRf
R0lOQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0xBWUxBMjAgaXMgbm90IHNldAojIENP
TkZJR19TTkRfREFSTEEyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9HSU5BMjQgaXMgbm90
IHNldAojIENPTkZJR19TTkRfTEFZTEEyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NT05B
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9F
Q0hPM0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0lORElHT0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0RKIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9J
TkRJR09ESlggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9FTVUxMEsxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMxMzcwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzEgaXMgbm90IHNldAojIENPTkZJR19TTkRf
RVMxOTM4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTk2OCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9GTTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0hEU1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MTIgaXMg
bm90IHNldAojIENPTkZJR19TTkRfSUNFMTcyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9J
TlRFTDhYMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYME0gaXMgbm90IHNldAoj
IENPTkZJR19TTkRfS09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfTE9MQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9MWDY0NjRFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9N
QUVTVFJPMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NSVhBUlQgaXMgbm90IHNldAojIENP
TkZJR19TTkRfTk0yNTYgaXMgbm90IHNldAojIENPTkZJR19TTkRfUENYSFIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfUklQVElERSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUUzMiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9STUU5NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9S
TUU5NjUyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NFNlggaXMgbm90IHNldAojIENPTkZJ
R19TTkRfU09OSUNWSUJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9UUklERU5UIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1ZJQTgyWFggaXMgbm90IHNldAojIENPTkZJR19TTkRfVklB
ODJYWF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSVJUVU9TTyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9WWDIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9ZTUZQQ0kgaXMg
bm90IHNldAoKIwojIEhELUF1ZGlvCiMKQ09ORklHX1NORF9IREE9eQpDT05GSUdfU05EX0hE
QV9JTlRFTD15CkNPTkZJR19TTkRfSERBX0hXREVQPXkKIyBDT05GSUdfU05EX0hEQV9SRUNP
TkZJRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfSU5QVVRfQkVFUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9IREFfUEFUQ0hfTE9BREVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19B
TkFMT0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1NJR01BVEVMIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19WSUEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfSERBX0NPREVDX0hETUkgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NJ
UlJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ1M4NDA5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DT05FWEFOVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9IREFfQ09ERUNfQ0EwMTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RF
Q19DQTAxMzIgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX0NNRURJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfU0kzMDU0IGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0hEQV9HRU5FUklDIGlzIG5vdCBzZXQKQ09ORklHX1NORF9IREFfUE9XRVJfU0FW
RV9ERUZBVUxUPTAKIyBDT05GSUdfU05EX0hEQV9JTlRFTF9IRE1JX1NJTEVOVF9TVFJFQU0g
aXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NUTF9ERVZfSUQgaXMgbm90IHNldAojIGVu
ZCBvZiBIRC1BdWRpbwoKQ09ORklHX1NORF9IREFfQ09SRT15CkNPTkZJR19TTkRfSERBX0NP
TVBPTkVOVD15CkNPTkZJR19TTkRfSERBX0k5MTU9eQpDT05GSUdfU05EX0hEQV9QUkVBTExP
Q19TSVpFPTAKQ09ORklHX1NORF9JTlRFTF9OSExUPXkKQ09ORklHX1NORF9JTlRFTF9EU1Bf
Q09ORklHPXkKQ09ORklHX1NORF9JTlRFTF9TT1VORFdJUkVfQUNQST15CkNPTkZJR19TTkRf
VVNCPXkKIyBDT05GSUdfU05EX1VTQl9BVURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9V
U0JfVUExMDEgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1VTWDJZIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1VTQl9DQUlBUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9VU0JfVVMx
MjJMIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1VTQl82RklSRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9VU0JfSElGQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0JDRDIwMDAgaXMg
bm90IHNldAojIENPTkZJR19TTkRfVVNCX1BPRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9V
U0JfUE9ESEQgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX1RPTkVQT1JUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1VTQl9WQVJJQVggaXMgbm90IHNldApDT05GSUdfU05EX1BDTUNJ
QT15CiMgQ09ORklHX1NORF9WWFBPQ0tFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9QREFV
RElPQ0YgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09DIGlzIG5vdCBzZXQKQ09ORklHX1NO
RF9YODY9eQojIENPTkZJR19IRE1JX0xQRV9BVURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9WSVJUSU8gaXMgbm90IHNldApDT05GSUdfSElEX1NVUFBPUlQ9eQpDT05GSUdfSElEPXkK
IyBDT05GSUdfSElEX0JBVFRFUllfU1RSRU5HVEggaXMgbm90IHNldApDT05GSUdfSElEUkFX
PXkKIyBDT05GSUdfVUhJRCBpcyBub3Qgc2V0CkNPTkZJR19ISURfR0VORVJJQz15CgojCiMg
U3BlY2lhbCBISUQgZHJpdmVycwojCkNPTkZJR19ISURfQTRURUNIPXkKIyBDT05GSUdfSElE
X0FDQ1VUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BQ1JVWCBpcyBub3Qgc2V0CkNP
TkZJR19ISURfQVBQTEU9eQojIENPTkZJR19ISURfQVBQTEVJUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FVUkVBTCBpcyBub3Qgc2V0
CkNPTkZJR19ISURfQkVMS0lOPXkKIyBDT05GSUdfSElEX0JFVE9QX0ZGIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX0JJR0JFTl9GRiBpcyBub3Qgc2V0CkNPTkZJR19ISURfQ0hFUlJZPXkK
Q09ORklHX0hJRF9DSElDT05ZPXkKIyBDT05GSUdfSElEX0NPUlNBSVIgaXMgbm90IHNldAoj
IENPTkZJR19ISURfQ09VR0FSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01BQ0FMTFkgaXMg
bm90IHNldAojIENPTkZJR19ISURfUFJPRElLRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X0NNRURJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DUkVBVElWRV9TQjA1NDAgaXMgbm90
IHNldApDT05GSUdfSElEX0NZUFJFU1M9eQojIENPTkZJR19ISURfRFJBR09OUklTRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9FTVNfRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfRUxB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FTEVDT00gaXMgbm90IHNldAojIENPTkZJR19I
SURfRUxPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VWSVNJT04gaXMgbm90IHNldApDT05G
SUdfSElEX0VaS0VZPXkKIyBDT05GSUdfSElEX0ZUMjYwIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX0dFTUJJUkQgaXMgbm90IHNldAojIENPTkZJR19ISURfR0ZSTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9HTE9SSU9VUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9IT0xURUsgaXMg
bm90IHNldAojIENPTkZJR19ISURfR09PR0xFX1NUQURJQV9GRiBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9WSVZBTERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dUNjgzUiBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9LRVlUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LWUUg
aXMgbm90IHNldAojIENPTkZJR19ISURfVUNMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9XQUxUT1AgaXMgbm90IHNldAojIENPTkZJR19ISURfVklFV1NPTklDIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1ZSQzIgaXMgbm90IHNldAojIENPTkZJR19ISURfWElBT01JIGlzIG5v
dCBzZXQKQ09ORklHX0hJRF9HWVJBVElPTj15CiMgQ09ORklHX0hJRF9JQ0FERSBpcyBub3Qg
c2V0CkNPTkZJR19ISURfSVRFPXkKIyBDT05GSUdfSElEX0pBQlJBIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1RXSU5IQU4gaXMgbm90IHNldApDT05GSUdfSElEX0tFTlNJTkdUT049eQoj
IENPTkZJR19ISURfTENQT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MRUQgaXMgbm90
IHNldAojIENPTkZJR19ISURfTEVOT1ZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0xFVFNL
RVRDSCBpcyBub3Qgc2V0CkNPTkZJR19ISURfTE9HSVRFQ0g9eQojIENPTkZJR19ISURfTE9H
SVRFQ0hfREogaXMgbm90IHNldAojIENPTkZJR19ISURfTE9HSVRFQ0hfSElEUFAgaXMgbm90
IHNldApDT05GSUdfTE9HSVRFQ0hfRkY9eQojIENPTkZJR19MT0dJUlVNQkxFUEFEMl9GRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0xPR0lHOTQwX0ZGIGlzIG5vdCBzZXQKQ09ORklHX0xPR0lX
SEVFTFNfRkY9eQojIENPTkZJR19ISURfTUFHSUNNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9NQUxUUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01BWUZMQVNIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX01FR0FXT1JMRF9GRiBpcyBub3Qgc2V0CkNPTkZJR19ISURfUkVE
UkFHT049eQpDT05GSUdfSElEX01JQ1JPU09GVD15CkNPTkZJR19ISURfTU9OVEVSRVk9eQoj
IENPTkZJR19ISURfTVVMVElUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OSU5URU5E
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OVEkgaXMgbm90IHNldApDT05GSUdfSElEX05U
UklHPXkKIyBDT05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9QQU5USEVS
TE9SRD15CkNPTkZJR19QQU5USEVSTE9SRF9GRj15CiMgQ09ORklHX0hJRF9QRU5NT1VOVCBp
cyBub3Qgc2V0CkNPTkZJR19ISURfUEVUQUxZTlg9eQojIENPTkZJR19ISURfUElDT0xDRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QTEFOVFJPTklDUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJRF9QWFJDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JBWkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1BSSU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRVRST0RFIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX1JPQ0NBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TQUlU
RUsgaXMgbm90IHNldApDT05GSUdfSElEX1NBTVNVTkc9eQojIENPTkZJR19ISURfU0VNSVRF
SyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TSUdNQU1JQ1JPIGlzIG5vdCBzZXQKQ09ORklH
X0hJRF9TT05ZPXkKIyBDT05GSUdfU09OWV9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9T
UEVFRExJTksgaXMgbm90IHNldAojIENPTkZJR19ISURfU1RFQU0gaXMgbm90IHNldAojIENP
TkZJR19ISURfU1RFRUxTRVJJRVMgaXMgbm90IHNldApDT05GSUdfSElEX1NVTlBMVVM9eQoj
IENPTkZJR19ISURfUk1JIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0dSRUVOQVNJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9TTUFSVEpPWVBMVVMgaXMgbm90IHNldAojIENPTkZJR19I
SURfVElWTyBpcyBub3Qgc2V0CkNPTkZJR19ISURfVE9QU0VFRD15CiMgQ09ORklHX0hJRF9U
T1BSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USElOR00gaXMgbm90IHNldAojIENPTkZJ
R19ISURfVEhSVVNUTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1VEUkFXX1BTMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9VMkZaRVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dJSU1PVEUgaXMgbm90IHNldAojIENP
TkZJR19ISURfWElOTU8gaXMgbm90IHNldAojIENPTkZJR19ISURfWkVST1BMVVMgaXMgbm90
IHNldAojIENPTkZJR19ISURfWllEQUNST04gaXMgbm90IHNldAojIENPTkZJR19ISURfU0VO
U09SX0hVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BTFBTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX01DUDIyMjEgaXMgbm90IHNldAojIGVuZCBvZiBTcGVjaWFsIEhJRCBkcml2ZXJz
CgojCiMgSElELUJQRiBzdXBwb3J0CiMKIyBlbmQgb2YgSElELUJQRiBzdXBwb3J0CgojCiMg
VVNCIEhJRCBzdXBwb3J0CiMKQ09ORklHX1VTQl9ISUQ9eQpDT05GSUdfSElEX1BJRD15CkNP
TkZJR19VU0JfSElEREVWPXkKIyBlbmQgb2YgVVNCIEhJRCBzdXBwb3J0CgpDT05GSUdfSTJD
X0hJRD15CiMgQ09ORklHX0kyQ19ISURfQUNQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19I
SURfT0YgaXMgbm90IHNldAoKIwojIEludGVsIElTSCBISUQgc3VwcG9ydAojCiMgQ09ORklH
X0lOVEVMX0lTSF9ISUQgaXMgbm90IHNldAojIGVuZCBvZiBJbnRlbCBJU0ggSElEIHN1cHBv
cnQKCiMKIyBBTUQgU0ZIIEhJRCBTdXBwb3J0CiMKIyBDT05GSUdfQU1EX1NGSF9ISUQgaXMg
bm90IHNldAojIGVuZCBvZiBBTUQgU0ZIIEhJRCBTdXBwb3J0CgpDT05GSUdfVVNCX09IQ0lf
TElUVExFX0VORElBTj15CkNPTkZJR19VU0JfU1VQUE9SVD15CkNPTkZJR19VU0JfQ09NTU9O
PXkKIyBDT05GSUdfVVNCX0xFRF9UUklHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1VMUElf
QlVTIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9eQpDT05GSUdfVVNCPXkK
Q09ORklHX1VTQl9QQ0k9eQpDT05GSUdfVVNCX1BDSV9BTUQ9eQpDT05GSUdfVVNCX0FOTk9V
TkNFX05FV19ERVZJQ0VTPXkKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09O
RklHX1VTQl9ERUZBVUxUX1BFUlNJU1Q9eQojIENPTkZJR19VU0JfRkVXX0lOSVRfUkVUUklF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9PVEcgaXMgbm90IHNldAojIENPTkZJR19VU0JfT1RHX1BST0RVQ1RMSVNU
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFRFNfVFJJR0dFUl9VU0JQT1JUIGlzIG5vdCBz
ZXQKQ09ORklHX1VTQl9BVVRPU1VTUEVORF9ERUxBWT0yCkNPTkZJR19VU0JfTU9OPXkKCiMK
IyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwojIENPTkZJR19VU0JfQzY3WDAwX0hD
RCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfWEhDSV9IQ0Q9eQojIENPTkZJR19VU0JfWEhDSV9E
QkdDQVAgaXMgbm90IHNldApDT05GSUdfVVNCX1hIQ0lfUENJPXkKIyBDT05GSUdfVVNCX1hI
Q0lfUENJX1JFTkVTQVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfWEhDSV9QTEFURk9STSBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9ST09U
X0hVQl9UVCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9UVF9ORVdTQ0hFRD15CkNPTkZJ
R19VU0JfRUhDSV9QQ0k9eQojIENPTkZJR19VU0JfRUhDSV9GU0wgaXMgbm90IHNldAojIENP
TkZJR19VU0JfRUhDSV9IQ0RfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19VU0JfT1hV
MjEwSFBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlzIG5vdCBz
ZXQKQ09ORklHX1VTQl9PSENJX0hDRD15CkNPTkZJR19VU0JfT0hDSV9IQ0RfUENJPXkKIyBD
T05GSUdfVVNCX09IQ0lfSENEX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VSENJ
X0hDRD15CiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
UjhBNjY1OTdfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hDRF9URVNUX01PREUgaXMg
bm90IHNldAoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCiMgQ09ORklHX1VTQl9B
Q00gaXMgbm90IHNldApDT05GSUdfVVNCX1BSSU5URVI9eQojIENPTkZJR19VU0JfV0RNIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1RNQyBpcyBub3Qgc2V0CgojCiMgTk9URTogVVNCX1NU
T1JBR0UgZGVwZW5kcyBvbiBTQ1NJIGJ1dCBCTEtfREVWX1NEIG1heQojCgojCiMgYWxzbyBi
ZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBIZWxwIGZvciBtb3JlIGluZm8KIwpDT05GSUdf
VVNCX1NUT1JBR0U9eQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9TVE9SQUdFX1JFQUxURUsgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RP
UkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRlJFRUNPTSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVE9SQUdFX1VTQkFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0Vf
U0REUjA5IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9BTEFVREEgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9PTkVU
T1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0tBUk1BIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfQ1lQUkVTU19BVEFDQiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TVE9SQUdFX0VORV9VQjYyNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUFTIGlz
IG5vdCBzZXQKCiMKIyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQklQX0NPUkUgaXMgbm90IHNldAoKIwojIFVTQiBkdWFsLW1vZGUgY29udHJvbGxlciBk
cml2ZXJzCiMKIyBDT05GSUdfVVNCX0NETlNfU1VQUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9NVVNCX0hEUkMgaXMgbm90IHNldAojIENPTkZJR19VU0JfRFdDMyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9EV0MyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NISVBJREVBIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDE3NjAgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0
IGRyaXZlcnMKIwojIENPTkZJR19VU0JfU0VSSUFMIGlzIG5vdCBzZXQKCiMKIyBVU0IgTWlz
Y2VsbGFuZW91cyBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0VNSTYyIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0VNSTI2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FEVVRVWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVZTRUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVHT1RP
V0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9DWVBSRVNTX0NZN0M2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVRIRVJNIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0lETU9VU0UgaXMgbm90IHNldAojIENPTkZJR19VU0JfQVBQ
TEVESVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTEVfTUZJX0ZBU1RDSEFSR0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfTEpDQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TSVNV
U0JWR0EgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfVFJBTkNFVklCUkFUT1IgaXMgbm90IHNldAojIENPTkZJR19VU0JfSU9XQVJSSU9SIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfRUhT
RVRfVEVTVF9GSVhUVVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTSUdIVEZXIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1lVUkVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VaVVNC
X0ZYMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IVUJfVVNCMjUxWEIgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfSFNJQ19VU0IzNTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hTSUNf
VVNCNDYwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSU5LX0xBWUVSX1RFU1QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfQ0hBT1NLRVkgaXMgbm90IHNldAoKIwojIFVTQiBQaHlzaWNh
bCBMYXllciBkcml2ZXJzCiMKIyBDT05GSUdfTk9QX1VTQl9YQ0VJViBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9JU1AxMzAxIGlzIG5vdCBzZXQKIyBlbmQgb2YgVVNCIFBoeXNpY2FsIExh
eWVyIGRyaXZlcnMKCiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90IHNldAojIENPTkZJR19U
WVBFQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ST0xFX1NXSVRDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX01NQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUZTSENEIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldApDT05GSUdfTkVXX0xFRFM9eQpDT05GSUdf
TEVEU19DTEFTUz15CiMgQ09ORklHX0xFRFNfQ0xBU1NfRkxBU0ggaXMgbm90IHNldAojIENP
TkZJR19MRURTX0NMQVNTX01VTFRJQ09MT1IgaXMgbm90IHNldAojIENPTkZJR19MRURTX0JS
SUdIVE5FU1NfSFdfQ0hBTkdFRCBpcyBub3Qgc2V0CgojCiMgTEVEIGRyaXZlcnMKIwojIENP
TkZJR19MRURTX0FQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQVcyMDBYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfTE0zNTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM1
MzIgaXMgbm90IHNldAojIENPTkZJR19MRURTX0xNMzY0MiBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfUENBOTUzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFAzOTQ0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTEVEU19QQ0E5NTVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19QQ0E5
NjNYIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19QQ0E5OTVYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19CRDI2MDZNVlYgaXMgbm90IHNldAojIENPTkZJR19MRURTX0JEMjgwMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfSU5URUxfU1M0MjAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19UQ0E2NTA3IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UTEM1OTFYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfTE0zNTV4IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19JUzMx
RkwzMTlYIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJpdmVyIGZvciBibGluaygxKSBVU0IgUkdC
IExFRCBpcyB1bmRlciBTcGVjaWFsIEhJRCBkcml2ZXJzIChISURfVEhJTkdNKQojCiMgQ09O
RklHX0xFRFNfQkxJTktNIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19NTFhDUExEIGlzIG5v
dCBzZXQKIyBDT05GSUdfTEVEU19NTFhSRUcgaXMgbm90IHNldAojIENPTkZJR19MRURTX1VT
RVIgaXMgbm90IHNldAojIENPTkZJR19MRURTX05JQzc4QlggaXMgbm90IHNldAoKIwojIEZs
YXNoIGFuZCBUb3JjaCBMRUQgZHJpdmVycwojCgojCiMgUkdCIExFRCBkcml2ZXJzCiMKCiMK
IyBMRUQgVHJpZ2dlcnMKIwpDT05GSUdfTEVEU19UUklHR0VSUz15CiMgQ09ORklHX0xFRFNf
VFJJR0dFUl9USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9PTkVTSE9U
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX0RJU0sgaXMgbm90IHNldAojIENP
TkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19U
UklHR0VSX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9DUFUg
aXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQUNUSVZJVFkgaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1RSSUdHRVJfREVGQVVMVF9PTiBpcyBub3Qgc2V0CgojCiMgaXB0YWJs
ZXMgdHJpZ2dlciBpcyB1bmRlciBOZXRmaWx0ZXIgY29uZmlnIChMRUQgdGFyZ2V0KQojCiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9UUkFOU0lFTlQgaXMgbm90IHNldAojIENPTkZJR19MRURT
X1RSSUdHRVJfQ0FNRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1BBTklD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX05FVERFViBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9QQVRURVJOIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19U
UklHR0VSX0FVRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX1RUWSBpcyBu
b3Qgc2V0CgojCiMgU2ltcGxlIExFRCBkcml2ZXJzCiMKIyBDT05GSUdfQUNDRVNTSUJJTElU
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0lORklOSUJBTkQgaXMgbm90IHNldApDT05GSUdfRURB
Q19BVE9NSUNfU0NSVUI9eQpDT05GSUdfRURBQ19TVVBQT1JUPXkKQ09ORklHX1JUQ19MSUI9
eQpDT05GSUdfUlRDX01DMTQ2ODE4X0xJQj15CkNPTkZJR19SVENfQ0xBU1M9eQojIENPTkZJ
R19SVENfSENUT1NZUyBpcyBub3Qgc2V0CkNPTkZJR19SVENfU1lTVE9IQz15CkNPTkZJR19S
VENfU1lTVE9IQ19ERVZJQ0U9InJ0YzAiCiMgQ09ORklHX1JUQ19ERUJVRyBpcyBub3Qgc2V0
CkNPTkZJR19SVENfTlZNRU09eQoKIwojIFJUQyBpbnRlcmZhY2VzCiMKQ09ORklHX1JUQ19J
TlRGX1NZU0ZTPXkKQ09ORklHX1JUQ19JTlRGX1BST0M9eQpDT05GSUdfUlRDX0lOVEZfREVW
PXkKIyBDT05GSUdfUlRDX0lOVEZfREVWX1VJRV9FTVVMIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9URVNUIGlzIG5vdCBzZXQKCiMKIyBJMkMgUlRDIGRyaXZlcnMKIwojIENPTkZJ
R19SVENfRFJWX0FCQjVaRVMzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9BQkVPWjkg
aXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0FCWDgwWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfRFMxMzA3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEzNzQgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTY3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfTUFYNjkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlM1QzM3MiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwOCBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfSVNMMTIwMjIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1gxMjA1IGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9QQ0Y4NTA2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODUzNjMgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1NjMgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX1BDRjg1ODMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000MVQ4MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQlEzMksgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX1MzNTM5MEEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0ZNMzEzMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9SWDg1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9S
VjMwMjggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAzMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfUlY4ODAzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TRDMw
NzggaXMgbm90IHNldAoKIwojIFNQSSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfSTJDX0FO
RF9TUEk9eQoKIwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RS
Vl9EUzMyMzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjIxMjcgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX1JWMzAyOUMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9SWDYxMTAgaXMgbm90IHNldAoKIwojIFBsYXRmb3JtIFJUQyBkcml2ZXJzCiMKQ09ORklH
X1JUQ19EUlZfQ01PUz15CiMgQ09ORklHX1JUQ19EUlZfRFMxMjg2IGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTU1
MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjg1X0ZBTUlMWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9E
UzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1NUSzE3VEE4IGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000
OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDU5IGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SUDVD
MDEgaXMgbm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19E
UlZfRlRSVEMwMTAgaXMgbm90IHNldAoKIwojIEhJRCBTZW5zb3IgUlRDIGRyaXZlcnMKIwoj
IENPTkZJR19SVENfRFJWX0dPTERGSVNIIGlzIG5vdCBzZXQKQ09ORklHX0RNQURFVklDRVM9
eQojIENPTkZJR19ETUFERVZJQ0VTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBETUEgRGV2aWNl
cwojCkNPTkZJR19ETUFfRU5HSU5FPXkKQ09ORklHX0RNQV9WSVJUVUFMX0NIQU5ORUxTPXkK
Q09ORklHX0RNQV9BQ1BJPXkKIyBDT05GSUdfQUxURVJBX01TR0RNQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOVEVMX0lETUE2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0lEWEQgaXMg
bm90IHNldAojIENPTkZJR19JTlRFTF9JRFhEX0NPTVBBVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOVEVMX0lPQVRETUEgaXMgbm90IHNldAojIENPTkZJR19QTFhfRE1BIGlzIG5vdCBzZXQK
IyBDT05GSUdfWElMSU5YX0RNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJTElOWF9YRE1BIGlz
IG5vdCBzZXQKIyBDT05GSUdfQU1EX1BURE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9I
SURNQV9NR01UIGlzIG5vdCBzZXQKIyBDT05GSUdfUUNPTV9ISURNQSBpcyBub3Qgc2V0CkNP
TkZJR19EV19ETUFDX0NPUkU9eQojIENPTkZJR19EV19ETUFDIGlzIG5vdCBzZXQKIyBDT05G
SUdfRFdfRE1BQ19QQ0kgaXMgbm90IHNldAojIENPTkZJR19EV19FRE1BIGlzIG5vdCBzZXQK
Q09ORklHX0hTVV9ETUE9eQojIENPTkZJR19TRl9QRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5URUxfTERNQSBpcyBub3Qgc2V0CgojCiMgRE1BIENsaWVudHMKIwojIENPTkZJR19BU1lO
Q19UWF9ETUEgaXMgbm90IHNldAojIENPTkZJR19ETUFURVNUIGlzIG5vdCBzZXQKCiMKIyBE
TUFCVUYgb3B0aW9ucwojCkNPTkZJR19TWU5DX0ZJTEU9eQojIENPTkZJR19TV19TWU5DIGlz
IG5vdCBzZXQKIyBDT05GSUdfVURNQUJVRiBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJVRl9N
T1ZFX05PVElGWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQUJVRl9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNQUJVRl9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZf
SEVBUFMgaXMgbm90IHNldAojIENPTkZJR19ETUFCVUZfU1lTRlNfU1RBVFMgaXMgbm90IHNl
dAojIGVuZCBvZiBETUFCVUYgb3B0aW9ucwoKIyBDT05GSUdfVUlPIGlzIG5vdCBzZXQKIyBD
T05GSUdfVkZJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRfRFJJVkVSUyBpcyBub3Qgc2V0
CkNPTkZJR19WSVJUSU9fQU5DSE9SPXkKQ09ORklHX1ZJUlRJTz15CkNPTkZJR19WSVJUSU9f
UENJX0xJQj15CkNPTkZJR19WSVJUSU9fUENJX0xJQl9MRUdBQ1k9eQpDT05GSUdfVklSVElP
X01FTlU9eQpDT05GSUdfVklSVElPX1BDST15CkNPTkZJR19WSVJUSU9fUENJX0xFR0FDWT15
CiMgQ09ORklHX1ZJUlRJT19CQUxMT09OIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJT19JTlBV
VD15CiMgQ09ORklHX1ZJUlRJT19NTUlPIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJT19ETUFf
U0hBUkVEX0JVRkZFUj15CiMgQ09ORklHX1ZEUEEgaXMgbm90IHNldApDT05GSUdfVkhPU1Rf
TUVOVT15CiMgQ09ORklHX1ZIT1NUX05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX0NS
T1NTX0VORElBTl9MRUdBQ1kgaXMgbm90IHNldAoKIwojIE1pY3Jvc29mdCBIeXBlci1WIGd1
ZXN0IHN1cHBvcnQKIwojIENPTkZJR19IWVBFUlYgaXMgbm90IHNldAojIGVuZCBvZiBNaWNy
b3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0CgojIENPTkZJR19HUkVZQlVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ09NRURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBR0lORyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NIUk9NRV9QTEFURk9STVMgaXMgbm90IHNldAojIENPTkZJR19NRUxM
QU5PWF9QTEFURk9STSBpcyBub3Qgc2V0CkNPTkZJR19TVVJGQUNFX1BMQVRGT1JNUz15CiMg
Q09ORklHX1NVUkZBQ0VfM19QT1dFUl9PUFJFR0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NV
UkZBQ0VfR1BFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VSRkFDRV9QUk8zX0JVVFRPTiBpcyBu
b3Qgc2V0CkNPTkZJR19YODZfUExBVEZPUk1fREVWSUNFUz15CkNPTkZJR19BQ1BJX1dNST15
CkNPTkZJR19XTUlfQk1PRj15CiMgQ09ORklHX0hVQVdFSV9XTUkgaXMgbm90IHNldAojIENP
TkZJR19NWE1fV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZJRElBX1dNSV9FQ19CQUNLTElH
SFQgaXMgbm90IHNldAojIENPTkZJR19YSUFPTUlfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdf
R0lHQUJZVEVfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfWU9HQUJPT0sgaXMgbm90IHNldAoj
IENPTkZJR19BQ0VSSERGIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNFUl9XSVJFTEVTUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FDRVJfV01JIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EX1BNRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0FNRF9QTUMgaXMgbm90IHNldAojIENPTkZJR19BTURfSFNN
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRF9XQlJGIGlzIG5vdCBzZXQKIyBDT05GSUdfQURW
X1NXQlVUVE9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTEVfR01VWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FTVVNfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfQVNVU19XSVJFTEVTUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0FTVVNfV01JIGlzIG5vdCBzZXQKQ09ORklHX0VFRVBDX0xB
UFRPUD15CiMgQ09ORklHX1g4Nl9QTEFURk9STV9EUklWRVJTX0RFTEwgaXMgbm90IHNldAoj
IENPTkZJR19BTUlMT19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19GVUpJVFNVX0xBUFRP
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVSklUU1VfVEFCTEVUIGlzIG5vdCBzZXQKIyBDT05G
SUdfR1BEX1BPQ0tFVF9GQU4gaXMgbm90IHNldAojIENPTkZJR19YODZfUExBVEZPUk1fRFJJ
VkVSU19IUCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJUkVMRVNTX0hPVEtFWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0lCTV9SVEwgaXMgbm90IHNldAojIENPTkZJR19JREVBUEFEX0xBUFRPUCBp
cyBub3Qgc2V0CiMgQ09ORklHX0xFTk9WT19ZTUMgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0hEQVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhJTktQQURfQUNQSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1RISU5LUEFEX0xNSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX0FUT01J
U1AyX1BNIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfSUZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5URUxfU0FSX0lOVDEwOTIgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9QTUNfQ09S
RSBpcyBub3Qgc2V0CgojCiMgSW50ZWwgU3BlZWQgU2VsZWN0IFRlY2hub2xvZ3kgaW50ZXJm
YWNlIHN1cHBvcnQKIwojIENPTkZJR19JTlRFTF9TUEVFRF9TRUxFQ1RfSU5URVJGQUNFIGlz
IG5vdCBzZXQKIyBlbmQgb2YgSW50ZWwgU3BlZWQgU2VsZWN0IFRlY2hub2xvZ3kgaW50ZXJm
YWNlIHN1cHBvcnQKCiMgQ09ORklHX0lOVEVMX1dNSV9TQkxfRldfVVBEQVRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URUxfV01JX1RIVU5ERVJCT0xUIGlzIG5vdCBzZXQKCiMKIyBJbnRl
bCBVbmNvcmUgRnJlcXVlbmN5IENvbnRyb2wKIwojIENPTkZJR19JTlRFTF9VTkNPUkVfRlJF
UV9DT05UUk9MIGlzIG5vdCBzZXQKIyBlbmQgb2YgSW50ZWwgVW5jb3JlIEZyZXF1ZW5jeSBD
b250cm9sCgojIENPTkZJR19JTlRFTF9ISURfRVZFTlQgaXMgbm90IHNldAojIENPTkZJR19J
TlRFTF9WQlROIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfT0FLVFJBSUwgaXMgbm90IHNl
dAojIENPTkZJR19JTlRFTF9QVU5JVF9JUEMgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9S
U1QgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9TTUFSVENPTk5FQ1QgaXMgbm90IHNldAoj
IENPTkZJR19JTlRFTF9UVVJCT19NQVhfMyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVMX1ZT
RUMgaXMgbm90IHNldAojIENPTkZJR19NU0lfRUMgaXMgbm90IHNldAojIENPTkZJR19NU0lf
TEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfTVNJX1dNSSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBTVNVTkdfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNU1VOR19RMTAgaXMgbm90
IHNldAojIENPTkZJR19UT1NISUJBX0JUX1JGS0lMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RP
U0hJQkFfSEFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RPU0hJQkFfV01JIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNQSV9DTVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NUEFMX0xBUFRPUCBp
cyBub3Qgc2V0CiMgQ09ORklHX0xHX0xBUFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBTkFT
T05JQ19MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19TT05ZX0xBUFRPUCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZU1RFTTc2X0FDUEkgaXMgbm90IHNldAojIENPTkZJR19UT1BTVEFSX0xB
UFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX01MWF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOU1BVUl9QTEFURk9STV9QUk9GSUxFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxf
SVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URUxfU0NVX1BDSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOVEVMX1NDVV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJRU1FTlNfU0lN
QVRJQ19JUEMgaXMgbm90IHNldAojIENPTkZJR19XSU5NQVRFX0ZNMDdfS0VZUyBpcyBub3Qg
c2V0CkNPTkZJR19QMlNCPXkKIyBDT05GSUdfQ09NTU9OX0NMSyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hXU1BJTkxPQ0sgaXMgbm90IHNldAoKIwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMK
Q09ORklHX0NMS0VWVF9JODI1Mz15CkNPTkZJR19JODI1M19MT0NLPXkKQ09ORklHX0NMS0JM
RF9JODI1Mz15CiMgZW5kIG9mIENsb2NrIFNvdXJjZSBkcml2ZXJzCgpDT05GSUdfTUFJTEJP
WD15CkNPTkZJR19QQ0M9eQojIENPTkZJR19BTFRFUkFfTUJPWCBpcyBub3Qgc2V0CkNPTkZJ
R19JT01NVV9JT1ZBPXkKQ09ORklHX0lPTU1VX0FQST15CkNPTkZJR19JT01NVV9TVVBQT1JU
PXkKCiMKIyBHZW5lcmljIElPTU1VIFBhZ2V0YWJsZSBTdXBwb3J0CiMKQ09ORklHX0lPTU1V
X0lPX1BHVEFCTEU9eQojIGVuZCBvZiBHZW5lcmljIElPTU1VIFBhZ2V0YWJsZSBTdXBwb3J0
CgojIENPTkZJR19JT01NVV9ERUJVR0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfREVG
QVVMVF9ETUFfU1RSSUNUIGlzIG5vdCBzZXQKQ09ORklHX0lPTU1VX0RFRkFVTFRfRE1BX0xB
Wlk9eQojIENPTkZJR19JT01NVV9ERUZBVUxUX1BBU1NUSFJPVUdIIGlzIG5vdCBzZXQKQ09O
RklHX0lPTU1VX0RNQT15CkNPTkZJR19BTURfSU9NTVU9eQpDT05GSUdfRE1BUl9UQUJMRT15
CkNPTkZJR19JTlRFTF9JT01NVT15CiMgQ09ORklHX0lOVEVMX0lPTU1VX1NWTSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOVEVMX0lPTU1VX0RFRkFVTFRfT04gaXMgbm90IHNldApDT05GSUdf
SU5URUxfSU9NTVVfRkxPUFBZX1dBPXkKQ09ORklHX0lOVEVMX0lPTU1VX1NDQUxBQkxFX01P
REVfREVGQVVMVF9PTj15CkNPTkZJR19JTlRFTF9JT01NVV9QRVJGX0VWRU5UUz15CiMgQ09O
RklHX0lPTU1VRkQgaXMgbm90IHNldAojIENPTkZJR19JUlFfUkVNQVAgaXMgbm90IHNldAoj
IENPTkZJR19WSVJUSU9fSU9NTVUgaXMgbm90IHNldAoKIwojIFJlbW90ZXByb2MgZHJpdmVy
cwojCiMgQ09ORklHX1JFTU9URVBST0MgaXMgbm90IHNldAojIGVuZCBvZiBSZW1vdGVwcm9j
IGRyaXZlcnMKCiMKIyBScG1zZyBkcml2ZXJzCiMKIyBDT05GSUdfUlBNU0dfUUNPTV9HTElO
S19SUE0gaXMgbm90IHNldAojIENPTkZJR19SUE1TR19WSVJUSU8gaXMgbm90IHNldAojIGVu
ZCBvZiBScG1zZyBkcml2ZXJzCgojIENPTkZJR19TT1VORFdJUkUgaXMgbm90IHNldAoKIwoj
IFNPQyAoU3lzdGVtIE9uIENoaXApIHNwZWNpZmljIERyaXZlcnMKIwoKIwojIEFtbG9naWMg
U29DIGRyaXZlcnMKIwojIGVuZCBvZiBBbWxvZ2ljIFNvQyBkcml2ZXJzCgojCiMgQnJvYWRj
b20gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBCcm9hZGNvbSBTb0MgZHJpdmVycwoKIwojIE5Y
UC9GcmVlc2NhbGUgUW9ySVEgU29DIGRyaXZlcnMKIwojIGVuZCBvZiBOWFAvRnJlZXNjYWxl
IFFvcklRIFNvQyBkcml2ZXJzCgojCiMgZnVqaXRzdSBTb0MgZHJpdmVycwojCiMgZW5kIG9m
IGZ1aml0c3UgU29DIGRyaXZlcnMKCiMKIyBpLk1YIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2Yg
aS5NWCBTb0MgZHJpdmVycwoKIwojIEVuYWJsZSBMaXRlWCBTb0MgQnVpbGRlciBzcGVjaWZp
YyBkcml2ZXJzCiMKIyBlbmQgb2YgRW5hYmxlIExpdGVYIFNvQyBCdWlsZGVyIHNwZWNpZmlj
IGRyaXZlcnMKCiMgQ09ORklHX1dQQ000NTBfU09DIGlzIG5vdCBzZXQKCiMKIyBRdWFsY29t
bSBTb0MgZHJpdmVycwojCiMgZW5kIG9mIFF1YWxjb21tIFNvQyBkcml2ZXJzCgojIENPTkZJ
R19TT0NfVEkgaXMgbm90IHNldAoKIwojIFhpbGlueCBTb0MgZHJpdmVycwojCiMgZW5kIG9m
IFhpbGlueCBTb0MgZHJpdmVycwojIGVuZCBvZiBTT0MgKFN5c3RlbSBPbiBDaGlwKSBzcGVj
aWZpYyBEcml2ZXJzCgojCiMgUE0gRG9tYWlucwojCgojCiMgQW1sb2dpYyBQTSBEb21haW5z
CiMKIyBlbmQgb2YgQW1sb2dpYyBQTSBEb21haW5zCgojCiMgQnJvYWRjb20gUE0gRG9tYWlu
cwojCiMgZW5kIG9mIEJyb2FkY29tIFBNIERvbWFpbnMKCiMKIyBpLk1YIFBNIERvbWFpbnMK
IwojIGVuZCBvZiBpLk1YIFBNIERvbWFpbnMKCiMKIyBRdWFsY29tbSBQTSBEb21haW5zCiMK
IyBlbmQgb2YgUXVhbGNvbW0gUE0gRG9tYWlucwojIGVuZCBvZiBQTSBEb21haW5zCgojIENP
TkZJR19QTV9ERVZGUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUQ09OIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUVNT1JZIGlzIG5vdCBzZXQKIyBDT05GSUdfSUlPIGlzIG5vdCBzZXQKIyBD
T05GSUdfTlRCIGlzIG5vdCBzZXQKIyBDT05GSUdfUFdNIGlzIG5vdCBzZXQKCiMKIyBJUlEg
Y2hpcCBzdXBwb3J0CiMKIyBlbmQgb2YgSVJRIGNoaXAgc3VwcG9ydAoKIyBDT05GSUdfSVBB
Q0tfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09OVFJPTExFUiBpcyBub3Qgc2V0
CgojCiMgUEhZIFN1YnN5c3RlbQojCiMgQ09ORklHX0dFTkVSSUNfUEhZIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0xHTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19QSFlfQ0FOX1RSQU5T
Q0VJVkVSIGlzIG5vdCBzZXQKCiMKIyBQSFkgZHJpdmVycyBmb3IgQnJvYWRjb20gcGxhdGZv
cm1zCiMKIyBDT05GSUdfQkNNX0tPTkFfVVNCMl9QSFkgaXMgbm90IHNldAojIGVuZCBvZiBQ
SFkgZHJpdmVycyBmb3IgQnJvYWRjb20gcGxhdGZvcm1zCgojIENPTkZJR19QSFlfUFhBXzI4
Tk1fSFNJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9QWEFfMjhOTV9VU0IyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEhZX0lOVEVMX0xHTV9FTU1DIGlzIG5vdCBzZXQKIyBlbmQgb2YgUEhZ
IFN1YnN5c3RlbQoKIyBDT05GSUdfUE9XRVJDQVAgaXMgbm90IHNldAojIENPTkZJR19NQ0Ig
aXMgbm90IHNldAoKIwojIFBlcmZvcm1hbmNlIG1vbml0b3Igc3VwcG9ydAojCiMgQ09ORklH
X0RXQ19QQ0lFX1BNVSBpcyBub3Qgc2V0CiMgZW5kIG9mIFBlcmZvcm1hbmNlIG1vbml0b3Ig
c3VwcG9ydAoKIyBDT05GSUdfUkFTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCNCBpcyBub3Qg
c2V0CgojCiMgQW5kcm9pZAojCiMgQ09ORklHX0FORFJPSURfQklOREVSX0lQQyBpcyBub3Qg
c2V0CiMgZW5kIG9mIEFuZHJvaWQKCiMgQ09ORklHX0xJQk5WRElNTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0RBWCBpcyBub3Qgc2V0CkNPTkZJR19OVk1FTT15CkNPTkZJR19OVk1FTV9TWVNG
Uz15CiMgQ09ORklHX05WTUVNX0xBWU9VVFMgaXMgbm90IHNldAojIENPTkZJR19OVk1FTV9S
TUVNIGlzIG5vdCBzZXQKCiMKIyBIVyB0cmFjaW5nIHN1cHBvcnQKIwojIENPTkZJR19TVE0g
aXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CiMgZW5kIG9mIEhXIHRy
YWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NJT1ggaXMgbm90IHNldAojIENPTkZJR19TTElNQlVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5URVJDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09V
TlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1BFQ0kgaXMgbm90IHNldAojIENPTkZJR19IVEUg
aXMgbm90IHNldAojIGVuZCBvZiBEZXZpY2UgRHJpdmVycwoKIwojIEZpbGUgc3lzdGVtcwoj
CkNPTkZJR19EQ0FDSEVfV09SRF9BQ0NFU1M9eQojIENPTkZJR19WQUxJREFURV9GU19QQVJT
RVIgaXMgbm90IHNldApDT05GSUdfRlNfSU9NQVA9eQpDT05GSUdfQlVGRkVSX0hFQUQ9eQpD
T05GSUdfTEVHQUNZX0RJUkVDVF9JTz15CiMgQ09ORklHX0VYVDJfRlMgaXMgbm90IHNldAoj
IENPTkZJR19FWFQzX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0VYVDRfRlM9eQpDT05GSUdfRVhU
NF9VU0VfRk9SX0VYVDI9eQpDT05GSUdfRVhUNF9GU19QT1NJWF9BQ0w9eQpDT05GSUdfRVhU
NF9GU19TRUNVUklUWT15CiMgQ09ORklHX0VYVDRfREVCVUcgaXMgbm90IHNldApDT05GSUdf
SkJEMj15CiMgQ09ORklHX0pCRDJfREVCVUcgaXMgbm90IHNldApDT05GSUdfRlNfTUJDQUNI
RT15CiMgQ09ORklHX1JFSVNFUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZTMl9GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTklMRlMy
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JD
QUNIRUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFBP
UlRGUz15CiMgQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUyBpcyBub3Qgc2V0CkNPTkZJR19G
SUxFX0xPQ0tJTkc9eQojIENPTkZJR19GU19FTkNSWVBUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfRlNfVkVSSVRZIGlzIG5vdCBzZXQKQ09ORklHX0ZTTk9USUZZPXkKQ09ORklHX0ROT1RJ
Rlk9eQpDT05GSUdfSU5PVElGWV9VU0VSPXkKIyBDT05GSUdfRkFOT1RJRlkgaXMgbm90IHNl
dApDT05GSUdfUVVPVEE9eQpDT05GSUdfUVVPVEFfTkVUTElOS19JTlRFUkZBQ0U9eQojIENP
TkZJR19RVU9UQV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19RVU9UQV9UUkVFPXkKIyBDT05G
SUdfUUZNVF9WMSBpcyBub3Qgc2V0CkNPTkZJR19RRk1UX1YyPXkKQ09ORklHX1FVT1RBQ1RM
PXkKQ09ORklHX0FVVE9GU19GUz15CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldApDT05G
SUdfT1ZFUkxBWV9GUz15CiMgQ09ORklHX09WRVJMQVlfRlNfUkVESVJFQ1RfRElSIGlzIG5v
dCBzZXQKQ09ORklHX09WRVJMQVlfRlNfUkVESVJFQ1RfQUxXQVlTX0ZPTExPVz15CiMgQ09O
RklHX09WRVJMQVlfRlNfSU5ERVggaXMgbm90IHNldAojIENPTkZJR19PVkVSTEFZX0ZTX1hJ
Tk9fQVVUTyBpcyBub3Qgc2V0CiMgQ09ORklHX09WRVJMQVlfRlNfTUVUQUNPUFkgaXMgbm90
IHNldAojIENPTkZJR19PVkVSTEFZX0ZTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBDYWNoZXMK
IwpDT05GSUdfTkVURlNfU1VQUE9SVD15CiMgQ09ORklHX05FVEZTX1NUQVRTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRlNDQUNIRSBpcyBub3Qgc2V0CiMgZW5kIG9mIENhY2hlcwoKIwojIENE
LVJPTS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJ
RVQ9eQpDT05GSUdfWklTT0ZTPXkKIyBDT05GSUdfVURGX0ZTIGlzIG5vdCBzZXQKIyBlbmQg
b2YgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwoKIwojIERPUy9GQVQvRVhGQVQvTlQgRmlsZXN5
c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKQ09ORklHX01TRE9TX0ZTPXkKQ09ORklHX1ZGQVRf
RlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9NDM3CkNPTkZJR19GQVRfREVGQVVM
VF9JT0NIQVJTRVQ9Imlzbzg4NTktMSIKIyBDT05GSUdfRkFUX0RFRkFVTFRfVVRGOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VYRkFUX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRGU19GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05URlMzX0ZTIGlzIG5vdCBzZXQKIyBlbmQgb2YgRE9TL0ZB
VC9FWEZBVC9OVCBGaWxlc3lzdGVtcwoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJ
R19QUk9DX0ZTPXkKQ09ORklHX1BST0NfS0NPUkU9eQpDT05GSUdfUFJPQ19WTUNPUkU9eQoj
IENPTkZJR19QUk9DX1ZNQ09SRV9ERVZJQ0VfRFVNUCBpcyBub3Qgc2V0CkNPTkZJR19QUk9D
X1NZU0NUTD15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CiMgQ09ORklHX1BST0NfQ0hJ
TERSRU4gaXMgbm90IHNldApDT05GSUdfUFJPQ19QSURfQVJDSF9TVEFUVVM9eQpDT05GSUdf
S0VSTkZTPXkKQ09ORklHX1NZU0ZTPXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX1RNUEZTX1BP
U0lYX0FDTD15CkNPTkZJR19UTVBGU19YQVRUUj15CiMgQ09ORklHX1RNUEZTX0lOT0RFNjQg
aXMgbm90IHNldAojIENPTkZJR19UTVBGU19RVU9UQSBpcyBub3Qgc2V0CkNPTkZJR19IVUdF
VExCRlM9eQojIENPTkZJR19IVUdFVExCX1BBR0VfT1BUSU1JWkVfVk1FTU1BUF9ERUZBVUxU
X09OIGlzIG5vdCBzZXQKQ09ORklHX0hVR0VUTEJfUEFHRT15CkNPTkZJR19IVUdFVExCX1BB
R0VfT1BUSU1JWkVfVk1FTU1BUD15CkNPTkZJR19BUkNIX0hBU19HSUdBTlRJQ19QQUdFPXkK
IyBDT05GSUdfQ09ORklHRlNfRlMgaXMgbm90IHNldApDT05GSUdfRUZJVkFSX0ZTPW0KIyBl
bmQgb2YgUHNldWRvIGZpbGVzeXN0ZW1zCgpDT05GSUdfTUlTQ19GSUxFU1lTVEVNUz15CiMg
Q09ORklHX09SQU5HRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQURGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FGRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19FQ1JZUFRfRlMgaXMg
bm90IHNldAojIENPTkZJR19IRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IRlNQTFVTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkVGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JGU19G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQU1G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NRVUFTSEZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
T01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAojIENPTkZJ
R19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg2RlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BTVE9SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19FUk9GU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNU
RU1TPXkKQ09ORklHX05GU19GUz15CkNPTkZJR19ORlNfVjI9eQpDT05GSUdfTkZTX1YzPXkK
Q09ORklHX05GU19WM19BQ0w9eQpDT05GSUdfTkZTX1Y0PXkKIyBDT05GSUdfTkZTX1NXQVAg
aXMgbm90IHNldAojIENPTkZJR19ORlNfVjRfMSBpcyBub3Qgc2V0CkNPTkZJR19ST09UX05G
Uz15CiMgQ09ORklHX05GU19VU0VfTEVHQUNZX0ROUyBpcyBub3Qgc2V0CkNPTkZJR19ORlNf
VVNFX0tFUk5FTF9ETlM9eQpDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NVUFBPUlQ9eQojIENP
TkZJR19ORlNEIGlzIG5vdCBzZXQKQ09ORklHX0dSQUNFX1BFUklPRD15CkNPTkZJR19MT0NL
RD15CkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19ORlNfQUNMX1NVUFBPUlQ9eQpDT05GSUdf
TkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9eQpDT05GSUdfU1VOUlBDX0dTUz15CkNPTkZJ
R19SUENTRUNfR1NTX0tSQjU9eQojIENPTkZJR19TVU5SUENfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19DRVBIX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NNQl9TRVJWRVIgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHXzlQX0ZTPXkKIyBDT05GSUdf
OVBfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfOVBfRlNfU0VDVVJJVFkgaXMg
bm90IHNldApDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJ1dGY4IgpDT05GSUdf
TkxTX0NPREVQQUdFXzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzg1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9eQpDT05GSUdfTkxTX0lT
Tzg4NTlfMT15CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19O
TFNfSVNPODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNP
ODg1OV82IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8x
MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0lTTzg4NTlfMTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9SIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
Uk9NQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NFTFRJQyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19NQUNfQ0VOVEVVUk8gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NS
T0FUSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DWVJJTExJQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19NQUNfR0FFTElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19H
UkVFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSUNFTEFORCBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19NQUNfSU5VSVQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1JPTUFO
SUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19UVVJLSVNIIGlzIG5vdCBzZXQKQ09O
RklHX05MU19VVEY4PXkKIyBDT05GSUdfVU5JQ09ERSBpcyBub3Qgc2V0CkNPTkZJR19JT19X
UT15CiMgZW5kIG9mIEZpbGUgc3lzdGVtcwoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05G
SUdfS0VZUz15CiMgQ09ORklHX0tFWVNfUkVRVUVTVF9DQUNIRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BFUlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNldAojIENPTkZJR19UUlVTVEVEX0tF
WVMgaXMgbm90IHNldAojIENPTkZJR19FTkNSWVBURURfS0VZUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0tFWV9ESF9PUEVSQVRJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfRE1F
U0dfUkVTVFJJQ1QgaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFk9eQojIENPTkZJR19TRUNV
UklUWUZTIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQojIENPTkZJR19T
RUNVUklUWV9ORVRXT1JLX1hGUk0gaXMgbm90IHNldApDT05GSUdfU0VDVVJJVFlfUEFUSD15
CiMgQ09ORklHX0lOVEVMX1RYVCBpcyBub3Qgc2V0CkNPTkZJR19MU01fTU1BUF9NSU5fQURE
Uj02NTUzNgojIENPTkZJR19IQVJERU5FRF9VU0VSQ09QWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZPUlRJRllfU09VUkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBVElDX1VTRVJNT0RFSEVM
UEVSIGlzIG5vdCBzZXQKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVg9eQpDT05GSUdfU0VDVVJJ
VFlfU0VMSU5VWF9CT09UUEFSQU09eQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9ERVZFTE9Q
PXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfQVZDX1NUQVRTPXkKQ09ORklHX1NFQ1VSSVRZ
X1NFTElOVVhfU0lEVEFCX0hBU0hfQklUUz05CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX1NJ
RDJTVFJfQ0FDSEVfU0laRT0yNTYKIyBDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9ERUJVRyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1NNQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VDVVJJVFlfVE9NT1lPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfQVBQQVJNT1Ig
aXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9MT0FEUElOIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VDVVJJVFlfWUFNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1NBRkVTRVRJ
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0xPQ0tET1dOX0xTTSBpcyBub3Qgc2V0
CkNPTkZJR19TRUNVUklUWV9MQU5ETE9DSz15CkNPTkZJR19JTlRFR1JJVFk9eQojIENPTkZJ
R19JTlRFR1JJVFlfU0lHTkFUVVJFIGlzIG5vdCBzZXQKQ09ORklHX0lOVEVHUklUWV9BVURJ
VD15CiMgQ09ORklHX0lNQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lNQV9TRUNVUkVfQU5EX09S
X1RSVVNURURfQk9PVCBpcyBub3Qgc2V0CiMgQ09ORklHX0VWTSBpcyBub3Qgc2V0CkNPTkZJ
R19ERUZBVUxUX1NFQ1VSSVRZX1NFTElOVVg9eQojIENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZ
X0RBQyBpcyBub3Qgc2V0CkNPTkZJR19MU009ImxhbmRsb2NrLGxvY2tkb3duLHlhbWEsbG9h
ZHBpbixzYWZlc2V0aWQsc2VsaW51eCxzbWFjayx0b21veW8sYXBwYXJtb3IsYnBmIgoKIwoj
IEtlcm5lbCBoYXJkZW5pbmcgb3B0aW9ucwojCgojCiMgTWVtb3J5IGluaXRpYWxpemF0aW9u
CiMKQ09ORklHX0NDX0hBU19BVVRPX1ZBUl9JTklUX1BBVFRFUk49eQpDT05GSUdfQ0NfSEFT
X0FVVE9fVkFSX0lOSVRfWkVST19CQVJFPXkKQ09ORklHX0NDX0hBU19BVVRPX1ZBUl9JTklU
X1pFUk89eQojIENPTkZJR19JTklUX1NUQUNLX05PTkUgaXMgbm90IHNldAojIENPTkZJR19J
TklUX1NUQUNLX0FMTF9QQVRURVJOIGlzIG5vdCBzZXQKQ09ORklHX0lOSVRfU1RBQ0tfQUxM
X1pFUk89eQojIENPTkZJR19JTklUX09OX0FMTE9DX0RFRkFVTFRfT04gaXMgbm90IHNldAoj
IENPTkZJR19JTklUX09OX0ZSRUVfREVGQVVMVF9PTiBpcyBub3Qgc2V0CkNPTkZJR19DQ19I
QVNfWkVST19DQUxMX1VTRURfUkVHUz15CiMgQ09ORklHX1pFUk9fQ0FMTF9VU0VEX1JFR1Mg
aXMgbm90IHNldAojIGVuZCBvZiBNZW1vcnkgaW5pdGlhbGl6YXRpb24KCiMKIyBIYXJkZW5p
bmcgb2Yga2VybmVsIGRhdGEgc3RydWN0dXJlcwojCiMgQ09ORklHX0xJU1RfSEFSREVORUQg
aXMgbm90IHNldAojIENPTkZJR19CVUdfT05fREFUQV9DT1JSVVBUSU9OIGlzIG5vdCBzZXQK
IyBlbmQgb2YgSGFyZGVuaW5nIG9mIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMKCkNPTkZJR19S
QU5EU1RSVUNUX05PTkU9eQojIGVuZCBvZiBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIyBl
bmQgb2YgU2VjdXJpdHkgb3B0aW9ucwoKQ09ORklHX0NSWVBUTz15CgojCiMgQ3J5cHRvIGNv
cmUgb3IgaGVscGVyCiMKQ09ORklHX0NSWVBUT19BTEdBUEk9eQpDT05GSUdfQ1JZUFRPX0FM
R0FQSTI9eQpDT05GSUdfQ1JZUFRPX0FFQUQ9eQpDT05GSUdfQ1JZUFRPX0FFQUQyPXkKQ09O
RklHX0NSWVBUT19TSUcyPXkKQ09ORklHX0NSWVBUT19TS0NJUEhFUj15CkNPTkZJR19DUllQ
VE9fU0tDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19IQVNIPXkKQ09ORklHX0NSWVBUT19IQVNI
Mj15CkNPTkZJR19DUllQVE9fUk5HPXkKQ09ORklHX0NSWVBUT19STkcyPXkKQ09ORklHX0NS
WVBUT19STkdfREVGQVVMVD15CkNPTkZJR19DUllQVE9fQUtDSVBIRVIyPXkKQ09ORklHX0NS
WVBUT19BS0NJUEhFUj15CkNPTkZJR19DUllQVE9fS1BQMj15CkNPTkZJR19DUllQVE9fQUNP
TVAyPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSMj15
CiMgQ09ORklHX0NSWVBUT19VU0VSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VS
X0RJU0FCTEVfVEVTVFM9eQpDT05GSUdfQ1JZUFRPX05VTEw9eQpDT05GSUdfQ1JZUFRPX05V
TEwyPXkKIyBDT05GSUdfQ1JZUFRPX1BDUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19DUllQVEQgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FVVEhFTkM9eQojIENPTkZJR19D
UllQVE9fVEVTVCBpcyBub3Qgc2V0CiMgZW5kIG9mIENyeXB0byBjb3JlIG9yIGhlbHBlcgoK
IwojIFB1YmxpYy1rZXkgY3J5cHRvZ3JhcGh5CiMKQ09ORklHX0NSWVBUT19SU0E9eQojIENP
TkZJR19DUllQVE9fREggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRUNESCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19FQ0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19F
Q1JEU0EgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU00yIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0NVUlZFMjU1MTkgaXMgbm90IHNldAojIGVuZCBvZiBQdWJsaWMta2V5IGNy
eXB0b2dyYXBoeQoKIwojIEJsb2NrIGNpcGhlcnMKIwpDT05GSUdfQ1JZUFRPX0FFUz15CiMg
Q09ORklHX0NSWVBUT19BRVNfVEkgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJJQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19CTE9XRklTSCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19DQU1FTExJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19ERVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU000X0dF
TkVSSUMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIEJsb2NrIGNpcGhlcnMKCiMKIyBMZW5ndGgtcHJlc2VydmluZyBjaXBoZXJzIGFu
ZCBtb2RlcwojCiMgQ09ORklHX0NSWVBUT19BRElBTlRVTSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19DSEFDSEEyMCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fQ0JDPXkKQ09ORklH
X0NSWVBUT19DVFI9eQojIENPTkZJR19DUllQVE9fQ1RTIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19FQ0I9eQojIENPTkZJR19DUllQVE9fSENUUjIgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fS0VZV1JBUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MUlcgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fUENCQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19YVFMg
aXMgbm90IHNldAojIGVuZCBvZiBMZW5ndGgtcHJlc2VydmluZyBjaXBoZXJzIGFuZCBtb2Rl
cwoKIwojIEFFQUQgKGF1dGhlbnRpY2F0ZWQgZW5jcnlwdGlvbiB3aXRoIGFzc29jaWF0ZWQg
ZGF0YSkgY2lwaGVycwojCiMgQ09ORklHX0NSWVBUT19BRUdJUzEyOCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DSEFDSEEyMFBPTFkxMzA1IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBU
T19DQ009eQpDT05GSUdfQ1JZUFRPX0dDTT15CkNPTkZJR19DUllQVE9fR0VOSVY9eQpDT05G
SUdfQ1JZUFRPX1NFUUlWPXkKQ09ORklHX0NSWVBUT19FQ0hBSU5JVj15CiMgQ09ORklHX0NS
WVBUT19FU1NJViBpcyBub3Qgc2V0CiMgZW5kIG9mIEFFQUQgKGF1dGhlbnRpY2F0ZWQgZW5j
cnlwdGlvbiB3aXRoIGFzc29jaWF0ZWQgZGF0YSkgY2lwaGVycwoKIwojIEhhc2hlcywgZGln
ZXN0cywgYW5kIE1BQ3MKIwojIENPTkZJR19DUllQVE9fQkxBS0UyQiBpcyBub3Qgc2V0CkNP
TkZJR19DUllQVE9fQ01BQz15CkNPTkZJR19DUllQVE9fR0hBU0g9eQpDT05GSUdfQ1JZUFRP
X0hNQUM9eQojIENPTkZJR19DUllQVE9fTUQ0IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19N
RDU9eQojIENPTkZJR19DUllQVE9fTUlDSEFFTF9NSUMgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fUE9MWTEzMDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUk1EMTYwIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTEgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX1NI
QTI1Nj15CkNPTkZJR19DUllQVE9fU0hBNTEyPXkKQ09ORklHX0NSWVBUT19TSEEzPXkKIyBD
T05GSUdfQ1JZUFRPX1NNM19HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NU
UkVFQk9HIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1ZNQUMgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fV1A1MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWENCQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19YWEhBU0ggaXMgbm90IHNldAojIGVuZCBvZiBIYXNo
ZXMsIGRpZ2VzdHMsIGFuZCBNQUNzCgojCiMgQ1JDcyAoY3ljbGljIHJlZHVuZGFuY3kgY2hl
Y2tzKQojCkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKIyBDT05GSUdfQ1JZUFRPX0NSQzMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSQ1QxMERJRiBpcyBub3Qgc2V0CiMgZW5kIG9m
IENSQ3MgKGN5Y2xpYyByZWR1bmRhbmN5IGNoZWNrcykKCiMKIyBDb21wcmVzc2lvbgojCiMg
Q09ORklHX0NSWVBUT19ERUZMQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT184NDIgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fTFo0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaNEhDIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1pTVEQgaXMgbm90IHNldAojIGVuZCBvZiBDb21wcmVzc2lvbgoKIwoj
IFJhbmRvbSBudW1iZXIgZ2VuZXJhdGlvbgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5H
IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19EUkJHX01FTlU9eQpDT05GSUdfQ1JZUFRPX0RS
QkdfSE1BQz15CiMgQ09ORklHX0NSWVBUT19EUkJHX0hBU0ggaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fRFJCR19DVFIgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkc9eQpDT05G
SUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFk9eQpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlf
TUVNT1JZX0JMT0NLUz02NApDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfTUVNT1JZX0JM
T0NLU0laRT0zMgpDT05GSUdfQ1JZUFRPX0pJVFRFUkVOVFJPUFlfT1NSPTEKIyBlbmQgb2Yg
UmFuZG9tIG51bWJlciBnZW5lcmF0aW9uCgojCiMgVXNlcnNwYWNlIGludGVyZmFjZQojCiMg
Q09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1VTRVJfQVBJX1NLQ0lQSEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJ
X1JORyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9BRUFEIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgVXNlcnNwYWNlIGludGVyZmFjZQoKQ09ORklHX0NSWVBUT19IQVNIX0lO
Rk89eQoKIwojIEFjY2VsZXJhdGVkIENyeXB0b2dyYXBoaWMgQWxnb3JpdGhtcyBmb3IgQ1BV
ICh4ODYpCiMKIyBDT05GSUdfQ1JZUFRPX0NVUlZFMjU1MTlfWDg2IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0FFU19OSV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19C
TE9XRklTSF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUFfWDg2
XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBX0FFU05JX0FWWF9YODZf
NjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUFfQUVTTklfQVZYMl9YODZf
NjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDVfQVZYX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNl9BVlhfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFUzNfRURFX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19T
RVJQRU5UX1NTRTJfWDg2XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlRf
QVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UX0FWWDJfWDg2
XzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NNNF9BRVNOSV9BVlhfWDg2XzY0IGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NNNF9BRVNOSV9BVlgyX1g4Nl82NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19UV09GSVNIX1g4Nl82NF8zV0FZIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1RXT0ZJU0hfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUklBX0FF
U05JX0FWWF9YODZfNjQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJJQV9BRVNOSV9B
VlgyX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BUklBX0dGTklfQVZYNTEy
X1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DSEFDSEEyMF9YODZfNjQgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fQUVHSVMxMjhfQUVTTklfU1NFMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19OSFBPTFkxMzA1X1NTRTIgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fTkhQT0xZMTMwNV9BVlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0JMQUtF
MlNfWDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BPTFlWQUxfQ0xNVUxfTkkgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fUE9MWTEzMDVfWDg2XzY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1NIQTFfU1NTRTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hB
MjU2X1NTU0UzIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTUxMl9TU1NFMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TTTNfQVZYX1g4Nl82NCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19HSEFTSF9DTE1VTF9OSV9JTlRFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19DUkMzMkNfSU5URUwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1JDMzJfUENM
TVVMIGlzIG5vdCBzZXQKIyBlbmQgb2YgQWNjZWxlcmF0ZWQgQ3J5cHRvZ3JhcGhpYyBBbGdv
cml0aG1zIGZvciBDUFUgKHg4NikKCkNPTkZJR19DUllQVE9fSFc9eQojIENPTkZJR19DUllQ
VE9fREVWX1BBRExPQ0sgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX0FUTUVMX0VD
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQVRNRUxfU0hBMjA0QSBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19ERVZfQ0NQIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X0RFVl9OSVRST1hfQ05ONTVYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZfUUFU
X0RIODk1eENDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzNYWFggaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DNjJYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX0RFVl9RQVRfNFhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19ERVZf
UUFUX0RIODk1eENDVkYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX1FBVF9DM1hY
WFZGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9RQVRfQzYyWFZGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9WSVJUSU8gaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fREVWX1NBRkVYQ0VMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0RFVl9BTUxPR0lD
X0dYTCBpcyBub3Qgc2V0CkNPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFPXkKQ09ORklHX0FT
WU1NRVRSSUNfUFVCTElDX0tFWV9TVUJUWVBFPXkKQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVf
UEFSU0VSPXkKIyBDT05GSUdfUEtDUzhfUFJJVkFURV9LRVlfUEFSU0VSIGlzIG5vdCBzZXQK
Q09ORklHX1BLQ1M3X01FU1NBR0VfUEFSU0VSPXkKIyBDT05GSUdfUEtDUzdfVEVTVF9LRVkg
aXMgbm90IHNldAojIENPTkZJR19TSUdORURfUEVfRklMRV9WRVJJRklDQVRJT04gaXMgbm90
IHNldAojIENPTkZJR19GSVBTX1NJR05BVFVSRV9TRUxGVEVTVCBpcyBub3Qgc2V0CgojCiMg
Q2VydGlmaWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcKIwpDT05GSUdfU1lTVEVNX1RS
VVNURURfS0VZUklORz15CkNPTkZJR19TWVNURU1fVFJVU1RFRF9LRVlTPSIiCiMgQ09ORklH
X1NZU1RFTV9FWFRSQV9DRVJUSUZJQ0FURSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ09OREFS
WV9UUlVTVEVEX0tFWVJJTkcgaXMgbm90IHNldAojIENPTkZJR19TWVNURU1fQkxBQ0tMSVNU
X0tFWVJJTkcgaXMgbm90IHNldAojIGVuZCBvZiBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVy
ZSBjaGVja2luZwoKQ09ORklHX0JJTkFSWV9QUklOVEY9eQoKIwojIExpYnJhcnkgcm91dGlu
ZXMKIwojIENPTkZJR19QQUNLSU5HIGlzIG5vdCBzZXQKQ09ORklHX0JJVFJFVkVSU0U9eQpD
T05GSUdfR0VORVJJQ19TVFJOQ1BZX0ZST01fVVNFUj15CkNPTkZJR19HRU5FUklDX1NUUk5M
RU5fVVNFUj15CkNPTkZJR19HRU5FUklDX05FVF9VVElMUz15CiMgQ09ORklHX0NPUkRJQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1BSSU1FX05VTUJFUlMgaXMgbm90IHNldApDT05GSUdfUkFU
SU9OQUw9eQpDT05GSUdfR0VORVJJQ19QQ0lfSU9NQVA9eQpDT05GSUdfR0VORVJJQ19JT01B
UD15CkNPTkZJR19BUkNIX1VTRV9DTVBYQ0hHX0xPQ0tSRUY9eQpDT05GSUdfQVJDSF9IQVNf
RkFTVF9NVUxUSVBMSUVSPXkKQ09ORklHX0FSQ0hfVVNFX1NZTV9BTk5PVEFUSU9OUz15Cgoj
CiMgQ3J5cHRvIGxpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQ1JZUFRPX0xJQl9VVElMUz15
CkNPTkZJR19DUllQVE9fTElCX0FFUz15CkNPTkZJR19DUllQVE9fTElCX0FSQzQ9eQpDT05G
SUdfQ1JZUFRPX0xJQl9HRjEyOE1VTD15CkNPTkZJR19DUllQVE9fTElCX0JMQUtFMlNfR0VO
RVJJQz15CiMgQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX0xJQl9DVVJWRTI1NTE5IGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19MSUJfUE9M
WTEzMDVfUlNJWkU9MTEKIyBDT05GSUdfQ1JZUFRPX0xJQl9QT0xZMTMwNSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBMjBQT0xZMTMwNSBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fTElCX1NIQTE9eQpDT05GSUdfQ1JZUFRPX0xJQl9TSEEyNTY9eQojIGVuZCBv
ZiBDcnlwdG8gbGlicmFyeSByb3V0aW5lcwoKQ09ORklHX0NSQ19DQ0lUVD15CkNPTkZJR19D
UkMxNj15CiMgQ09ORklHX0NSQ19UMTBESUYgaXMgbm90IHNldAojIENPTkZJR19DUkM2NF9S
T0NLU09GVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVfVCBpcyBub3Qgc2V0CkNPTkZJ
R19DUkMzMj15CiMgQ09ORklHX0NSQzMyX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX0NS
QzMyX1NMSUNFQlk4PXkKIyBDT05GSUdfQ1JDMzJfU0xJQ0VCWTQgaXMgbm90IHNldAojIENP
TkZJR19DUkMzMl9TQVJXQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfQklUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JDNjQgaXMgbm90IHNldAojIENPTkZJR19DUkM0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JDNyBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkNSQzMyQyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSQzggaXMgbm90IHNldApDT05GSUdfWFhIQVNIPXkKIyBDT05GSUdf
UkFORE9NMzJfU0VMRlRFU1QgaXMgbm90IHNldApDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09O
RklHX1pMSUJfREVGTEFURT15CkNPTkZJR19MWk9fQ09NUFJFU1M9eQpDT05GSUdfTFpPX0RF
Q09NUFJFU1M9eQpDT05GSUdfTFo0X0RFQ09NUFJFU1M9eQpDT05GSUdfWlNURF9DT01NT049
eQpDT05GSUdfWlNURF9ERUNPTVBSRVNTPXkKQ09ORklHX1haX0RFQz15CkNPTkZJR19YWl9E
RUNfWDg2PXkKQ09ORklHX1haX0RFQ19QT1dFUlBDPXkKQ09ORklHX1haX0RFQ19BUk09eQpD
T05GSUdfWFpfREVDX0FSTVRIVU1CPXkKQ09ORklHX1haX0RFQ19TUEFSQz15CiMgQ09ORklH
X1haX0RFQ19NSUNST0xaTUEgaXMgbm90IHNldApDT05GSUdfWFpfREVDX0JDSj15CiMgQ09O
RklHX1haX0RFQ19URVNUIGlzIG5vdCBzZXQKQ09ORklHX0RFQ09NUFJFU1NfR1pJUD15CkNP
TkZJR19ERUNPTVBSRVNTX0JaSVAyPXkKQ09ORklHX0RFQ09NUFJFU1NfTFpNQT15CkNPTkZJ
R19ERUNPTVBSRVNTX1haPXkKQ09ORklHX0RFQ09NUFJFU1NfTFpPPXkKQ09ORklHX0RFQ09N
UFJFU1NfTFo0PXkKQ09ORklHX0RFQ09NUFJFU1NfWlNURD15CkNPTkZJR19HRU5FUklDX0FM
TE9DQVRPUj15CkNPTkZJR19JTlRFUlZBTF9UUkVFPXkKQ09ORklHX1hBUlJBWV9NVUxUST15
CkNPTkZJR19BU1NPQ0lBVElWRV9BUlJBWT15CkNPTkZJR19IQVNfSU9NRU09eQpDT05GSUdf
SEFTX0lPUE9SVD15CkNPTkZJR19IQVNfSU9QT1JUX01BUD15CkNPTkZJR19IQVNfRE1BPXkK
Q09ORklHX0RNQV9PUFM9eQpDT05GSUdfTkVFRF9TR19ETUFfRkxBR1M9eQpDT05GSUdfTkVF
RF9TR19ETUFfTEVOR1RIPXkKQ09ORklHX05FRURfRE1BX01BUF9TVEFURT15CkNPTkZJR19B
UkNIX0RNQV9BRERSX1RfNjRCSVQ9eQpDT05GSUdfU1dJT1RMQj15CiMgQ09ORklHX1NXSU9U
TEJfRFlOQU1JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQV9BUElfREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19ETUFfTUFQX0JFTkNITUFSSyBpcyBub3Qgc2V0CkNPTkZJR19TR0xfQUxM
T0M9eQpDT05GSUdfQ0hFQ0tfU0lHTkFUVVJFPXkKQ09ORklHX0NQVV9STUFQPXkKQ09ORklH
X0RRTD15CkNPTkZJR19HTE9CPXkKIyBDT05GSUdfR0xPQl9TRUxGVEVTVCBpcyBub3Qgc2V0
CkNPTkZJR19OTEFUVFI9eQpDT05GSUdfQ0xaX1RBQj15CiMgQ09ORklHX0lSUV9QT0xMIGlz
IG5vdCBzZXQKQ09ORklHX01QSUxJQj15CkNPTkZJR19ESU1MSUI9eQpDT05GSUdfT0lEX1JF
R0lTVFJZPXkKQ09ORklHX1VDUzJfU1RSSU5HPXkKQ09ORklHX0hBVkVfR0VORVJJQ19WRFNP
PXkKQ09ORklHX0dFTkVSSUNfR0VUVElNRU9GREFZPXkKQ09ORklHX0dFTkVSSUNfVkRTT19U
SU1FX05TPXkKQ09ORklHX0ZPTlRfU1VQUE9SVD15CkNPTkZJR19GT05UXzh4MTY9eQpDT05G
SUdfRk9OVF9BVVRPU0VMRUNUPXkKQ09ORklHX1NHX1BPT0w9eQpDT05GSUdfQVJDSF9IQVNf
UE1FTV9BUEk9eQpDT05GSUdfQVJDSF9IQVNfQ1BVX0NBQ0hFX0lOVkFMSURBVEVfTUVNUkVH
SU9OPXkKQ09ORklHX0FSQ0hfSEFTX1VBQ0NFU1NfRkxVU0hDQUNIRT15CkNPTkZJR19BUkNI
X0hBU19DT1BZX01DPXkKQ09ORklHX0FSQ0hfU1RBQ0tXQUxLPXkKQ09ORklHX1NUQUNLREVQ
T1Q9eQpDT05GSUdfU1RBQ0tERVBPVF9NQVhfRlJBTUVTPTY0CkNPTkZJR19TQklUTUFQPXkK
IyBDT05GSUdfTFdRX1RFU1QgaXMgbm90IHNldAojIGVuZCBvZiBMaWJyYXJ5IHJvdXRpbmVz
CgpDT05GSUdfRklSTVdBUkVfVEFCTEU9eQoKIwojIEtlcm5lbCBoYWNraW5nCiMKCiMKIyBw
cmludGsgYW5kIGRtZXNnIG9wdGlvbnMKIwpDT05GSUdfUFJJTlRLX1RJTUU9eQojIENPTkZJ
R19QUklOVEtfQ0FMTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBQ0tUUkFDRV9CVUlMRF9J
RCBpcyBub3Qgc2V0CkNPTkZJR19DT05TT0xFX0xPR0xFVkVMX0RFRkFVTFQ9NwpDT05GSUdf
Q09OU09MRV9MT0dMRVZFTF9RVUlFVD00CkNPTkZJR19NRVNTQUdFX0xPR0xFVkVMX0RFRkFV
TFQ9NAojIENPTkZJR19CT09UX1BSSU5US19ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RZ
TkFNSUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19EWU5BTUlDX0RFQlVHX0NPUkUgaXMg
bm90IHNldApDT05GSUdfU1lNQk9MSUNfRVJSTkFNRT15CkNPTkZJR19ERUJVR19CVUdWRVJC
T1NFPXkKIyBlbmQgb2YgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCgpDT05GSUdfREVCVUdf
S0VSTkVMPXkKQ09ORklHX0RFQlVHX01JU0M9eQoKIwojIENvbXBpbGUtdGltZSBjaGVja3Mg
YW5kIGNvbXBpbGVyIG9wdGlvbnMKIwpDT05GSUdfQVNfSEFTX05PTl9DT05TVF9MRUIxMjg9
eQpDT05GSUdfREVCVUdfSU5GT19OT05FPXkKIyBDT05GSUdfREVCVUdfSU5GT19EV0FSRl9U
T09MQ0hBSU5fREVGQVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY0
IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfSU5GT19EV0FSRjUgaXMgbm90IHNldApDT05G
SUdfRlJBTUVfV0FSTj0yMDQ4CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVBREFCTEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfSEVBREVSU19JTlNU
QUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSCBpcyBub3Qg
c2V0CkNPTkZJR19TRUNUSU9OX01JU01BVENIX1dBUk5fT05MWT15CkNPTkZJR19PQkpUT09M
PXkKQ09ORklHX05PSU5TVFJfVkFMSURBVElPTj15CiMgQ09ORklHX0RFQlVHX0ZPUkNFX1dF
QUtfUEVSX0NQVSBpcyBub3Qgc2V0CiMgZW5kIG9mIENvbXBpbGUtdGltZSBjaGVja3MgYW5k
IGNvbXBpbGVyIG9wdGlvbnMKCiMKIyBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1
bWVudHMKIwpDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05GSUdfTUFHSUNfU1lTUlFfREVGQVVM
VF9FTkFCTEU9MHgxCkNPTkZJR19NQUdJQ19TWVNSUV9TRVJJQUw9eQpDT05GSUdfTUFHSUNf
U1lTUlFfU0VSSUFMX1NFUVVFTkNFPSIiCkNPTkZJR19ERUJVR19GUz15CkNPTkZJR19ERUJV
R19GU19BTExPV19BTEw9eQojIENPTkZJR19ERUJVR19GU19ESVNBTExPV19NT1VOVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX0ZTX0FMTE9XX05PTkUgaXMgbm90IHNldApDT05GSUdf
SEFWRV9BUkNIX0tHREI9eQojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hf
SEFTX1VCU0FOX1NBTklUSVpFX0FMTD15CiMgQ09ORklHX1VCU0FOIGlzIG5vdCBzZXQKQ09O
RklHX0hBVkVfQVJDSF9LQ1NBTj15CkNPTkZJR19IQVZFX0tDU0FOX0NPTVBJTEVSPXkKIyBD
T05GSUdfS0NTQU4gaXMgbm90IHNldAojIGVuZCBvZiBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dp
bmcgSW5zdHJ1bWVudHMKCiMKIyBOZXR3b3JraW5nIERlYnVnZ2luZwojCiMgQ09ORklHX05F
VF9ERVZfUkVGQ05UX1RSQUNLRVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfTlNfUkVGQ05U
X1RSQUNLRVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19ORVQgaXMgbm90IHNldAojIGVu
ZCBvZiBOZXR3b3JraW5nIERlYnVnZ2luZwoKIwojIE1lbW9yeSBEZWJ1Z2dpbmcKIwojIENP
TkZJR19QQUdFX0VYVEVOU0lPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1BBR0VBTExP
QyBpcyBub3Qgc2V0CkNPTkZJR19TTFVCX0RFQlVHPXkKIyBDT05GSUdfU0xVQl9ERUJVR19P
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBR0VfT1dORVIgaXMgbm90IHNldAojIENPTkZJR19Q
QUdFX1RBQkxFX0NIRUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFHRV9QT0lTT05JTkcgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19QQUdFX1JFRiBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX1JPREFUQV9URVNUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX0RFQlVHX1dYPXkK
Q09ORklHX0RFQlVHX1dYPXkKQ09ORklHX0dFTkVSSUNfUFREVU1QPXkKQ09ORklHX1BURFVN
UF9DT1JFPXkKIyBDT05GSUdfUFREVU1QX0RFQlVHRlMgaXMgbm90IHNldApDT05GSUdfSEFW
RV9ERUJVR19LTUVNTEVBSz15CiMgQ09ORklHX0RFQlVHX0tNRU1MRUFLIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEVSX1ZNQV9MT0NLX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
T0JKRUNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NIUklOS0VSX0RFQlVHIGlzIG5vdCBzZXQK
Q09ORklHX0RFQlVHX1NUQUNLX1VTQUdFPXkKIyBDT05GSUdfU0NIRURfU1RBQ0tfRU5EX0NI
RUNLIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX0RFQlVHX1ZNX1BHVEFCTEU9eQojIENP
TkZJR19ERUJVR19WTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZNX1BHVEFCTEUgaXMg
bm90IHNldApDT05GSUdfQVJDSF9IQVNfREVCVUdfVklSVFVBTD15CiMgQ09ORklHX0RFQlVH
X1ZJUlRVQUwgaXMgbm90IHNldApDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQ9eQojIENPTkZJ
R19ERUJVR19QRVJfQ1BVX01BUFMgaXMgbm90IHNldApDT05GSUdfQVJDSF9TVVBQT1JUU19L
TUFQX0xPQ0FMX0ZPUkNFX01BUD15CiMgQ09ORklHX0RFQlVHX0tNQVBfTE9DQUxfRk9SQ0Vf
TUFQIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LQVNBTj15CkNPTkZJR19IQVZFX0FS
Q0hfS0FTQU5fVk1BTExPQz15CkNPTkZJR19DQ19IQVNfS0FTQU5fR0VORVJJQz15CkNPTkZJ
R19DQ19IQVNfV09SS0lOR19OT1NBTklUSVpFX0FERFJFU1M9eQojIENPTkZJR19LQVNBTiBp
cyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfS0ZFTkNFPXkKIyBDT05GSUdfS0ZFTkNFIGlz
IG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LTVNBTj15CiMgZW5kIG9mIE1lbW9yeSBEZWJ1
Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1NISVJRIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBPb3Bz
LCBMb2NrdXBzIGFuZCBIYW5ncwojCiMgQ09ORklHX1BBTklDX09OX09PUFMgaXMgbm90IHNl
dApDT05GSUdfUEFOSUNfT05fT09QU19WQUxVRT0wCkNPTkZJR19QQU5JQ19USU1FT1VUPTAK
IyBDT05GSUdfU09GVExPQ0tVUF9ERVRFQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0hB
UkRMT0NLVVBfREVURUNUT1JfQlVERFk9eQojIENPTkZJR19IQVJETE9DS1VQX0RFVEVDVE9S
IGlzIG5vdCBzZXQKQ09ORklHX0hBUkRMT0NLVVBfQ0hFQ0tfVElNRVNUQU1QPXkKIyBDT05G
SUdfREVURUNUX0hVTkdfVEFTSyBpcyBub3Qgc2V0CiMgQ09ORklHX1dRX1dBVENIRE9HIGlz
IG5vdCBzZXQKIyBDT05GSUdfV1FfQ1BVX0lOVEVOU0lWRV9SRVBPUlQgaXMgbm90IHNldAoj
IENPTkZJR19URVNUX0xPQ0tVUCBpcyBub3Qgc2V0CiMgZW5kIG9mIERlYnVnIE9vcHMsIExv
Y2t1cHMgYW5kIEhhbmdzCgojCiMgU2NoZWR1bGVyIERlYnVnZ2luZwojCiMgQ09ORklHX1ND
SEVEX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX0lORk89eQpDT05GSUdfU0NIRURT
VEFUUz15CiMgZW5kIG9mIFNjaGVkdWxlciBEZWJ1Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1RJ
TUVLRUVQSU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUFJFRU1QVCBpcyBub3Qgc2V0
CgojCiMgTG9jayBEZWJ1Z2dpbmcgKHNwaW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQojCkNP
TkZJR19MT0NLX0RFQlVHR0lOR19TVVBQT1JUPXkKIyBDT05GSUdfUFJPVkVfTE9DS0lORyBp
cyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfU1RBVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X1JUX01VVEVYRVMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DSyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX01VVEVYRVMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19X
V19NVVRFWF9TTE9XUEFUSCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JXU0VNUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tfQUxMT0MgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19BVE9NSUNfU0xFRVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MT0NLSU5HX0FQ
SV9TRUxGVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1RPUlRVUkVfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dXX01VVEVYX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NGX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NTRF9MT0NLX1dBSVRfREVC
VUcgaXMgbm90IHNldAojIGVuZCBvZiBMb2NrIERlYnVnZ2luZyAoc3BpbmxvY2tzLCBtdXRl
eGVzLCBldGMuLi4pCgojIENPTkZJR19OTUlfQ0hFQ0tfQ1BVIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfSVJRRkxBR1MgaXMgbm90IHNldApDT05GSUdfU1RBQ0tUUkFDRT15CiMgQ09O
RklHX1dBUk5fQUxMX1VOU0VFREVEX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X0tPQkpFQ1QgaXMgbm90IHNldAoKIwojIERlYnVnIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMK
IwojIENPTkZJR19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUExJU1Qg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X05PVElGSUVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX01BUExFX1RSRUUgaXMgbm90
IHNldAojIGVuZCBvZiBEZWJ1ZyBrZXJuZWwgZGF0YSBzdHJ1Y3R1cmVzCgojIENPTkZJR19E
RUJVR19DUkVERU5USUFMUyBpcyBub3Qgc2V0CgojCiMgUkNVIERlYnVnZ2luZwojCiMgQ09O
RklHX1JDVV9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVfVEVT
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9SRUZfU0NBTEVfVEVTVCBpcyBub3Qgc2V0CkNP
TkZJR19SQ1VfQ1BVX1NUQUxMX1RJTUVPVVQ9MjEKQ09ORklHX1JDVV9FWFBfQ1BVX1NUQUxM
X1RJTUVPVVQ9MAojIENPTkZJR19SQ1VfQ1BVX1NUQUxMX0NQVVRJTUUgaXMgbm90IHNldApD
T05GSUdfUkNVX1RSQUNFPXkKIyBDT05GSUdfUkNVX0VRU19ERUJVRyBpcyBub3Qgc2V0CiMg
ZW5kIG9mIFJDVSBEZWJ1Z2dpbmcKCiMgQ09ORklHX0RFQlVHX1dRX0ZPUkNFX1JSX0NQVSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NQVV9IT1RQTFVHX1NUQVRFX0NPTlRST0wgaXMgbm90IHNl
dAojIENPTkZJR19MQVRFTkNZVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQ0dST1VQ
X1JFRiBpcyBub3Qgc2V0CkNPTkZJR19VU0VSX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJ
R19OT1BfVFJBQ0VSPXkKQ09ORklHX0hBVkVfUkVUSE9PSz15CkNPTkZJR19SRVRIT09LPXkK
Q09ORklHX0hBVkVfRlVOQ1RJT05fVFJBQ0VSPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJB
Q0U9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX1JFR1M9eQpDT05GSUdfSEFW
RV9EWU5BTUlDX0ZUUkFDRV9XSVRIX0RJUkVDVF9DQUxMUz15CkNPTkZJR19IQVZFX0RZTkFN
SUNfRlRSQUNFX1dJVEhfQVJHUz15CkNPTkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFX05PX1BB
VENIQUJMRT15CkNPTkZJR19IQVZFX0ZUUkFDRV9NQ09VTlRfUkVDT1JEPXkKQ09ORklHX0hB
VkVfU1lTQ0FMTF9UUkFDRVBPSU5UUz15CkNPTkZJR19IQVZFX0ZFTlRSWT15CkNPTkZJR19I
QVZFX09CSlRPT0xfTUNPVU5UPXkKQ09ORklHX0hBVkVfT0JKVE9PTF9OT1BfTUNPVU5UPXkK
Q09ORklHX0hBVkVfQ19SRUNPUkRNQ09VTlQ9eQpDT05GSUdfSEFWRV9CVUlMRFRJTUVfTUNP
VU5UX1NPUlQ9eQpDT05GSUdfVFJBQ0VfQ0xPQ0s9eQpDT05GSUdfUklOR19CVUZGRVI9eQpD
T05GSUdfRVZFTlRfVFJBQ0lORz15CkNPTkZJR19DT05URVhUX1NXSVRDSF9UUkFDRVI9eQpD
T05GSUdfVFJBQ0lORz15CkNPTkZJR19HRU5FUklDX1RSQUNFUj15CkNPTkZJR19UUkFDSU5H
X1NVUFBPUlQ9eQpDT05GSUdfRlRSQUNFPXkKIyBDT05GSUdfQk9PVFRJTUVfVFJBQ0lORyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZVTkNUSU9OX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NUQUNLX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSUVNPRkZfVFJBQ0VSIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFJFRU1QVF9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19TQ0hF
RF9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19IV0xBVF9UUkFDRVIgaXMgbm90IHNldAoj
IENPTkZJR19PU05PSVNFX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RJTUVSTEFUX1RS
QUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01NSU9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZUUkFDRV9TWVNDQUxMUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNFUl9TTkFQU0hPVCBp
cyBub3Qgc2V0CkNPTkZJR19CUkFOQ0hfUFJPRklMRV9OT05FPXkKIyBDT05GSUdfUFJPRklM
RV9BTk5PVEFURURfQlJBTkNIRVMgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxFX0FMTF9C
UkFOQ0hFUyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lPX1RSQUNFPXkKQ09ORklHX0tQ
Uk9CRV9FVkVOVFM9eQpDT05GSUdfVVBST0JFX0VWRU5UUz15CkNPTkZJR19EWU5BTUlDX0VW
RU5UUz15CkNPTkZJR19QUk9CRV9FVkVOVFM9eQojIENPTkZJR19TWU5USF9FVkVOVFMgaXMg
bm90IHNldAojIENPTkZJR19VU0VSX0VWRU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJU1Rf
VFJJR0dFUlMgaXMgbm90IHNldAojIENPTkZJR19UUkFDRV9FVkVOVF9JTkpFQ1QgaXMgbm90
IHNldAojIENPTkZJR19UUkFDRVBPSU5UX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JJTkdfQlVGRkVSX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNFX0VWQUxf
TUFQX0ZJTEUgaXMgbm90IHNldAojIENPTkZJR19GVFJBQ0VfU1RBUlRVUF9URVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfUklOR19CVUZGRVJfU1RBUlRVUF9URVNUIGlzIG5vdCBzZXQKIyBD
T05GSUdfUklOR19CVUZGRVJfVkFMSURBVEVfVElNRV9ERUxUQVMgaXMgbm90IHNldAojIENP
TkZJR19QUkVFTVBUSVJRX0RFTEFZX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19LUFJPQkVf
RVZFTlRfR0VOX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SViBpcyBub3Qgc2V0CkNPTkZJ
R19QUk9WSURFX09IQ0kxMzk0X0RNQV9JTklUPXkKIyBDT05GSUdfU0FNUExFUyBpcyBub3Qg
c2V0CkNPTkZJR19IQVZFX1NBTVBMRV9GVFJBQ0VfRElSRUNUPXkKQ09ORklHX0hBVkVfU0FN
UExFX0ZUUkFDRV9ESVJFQ1RfTVVMVEk9eQpDT05GSUdfQVJDSF9IQVNfREVWTUVNX0lTX0FM
TE9XRUQ9eQpDT05GSUdfU1RSSUNUX0RFVk1FTT15CiMgQ09ORklHX0lPX1NUUklDVF9ERVZN
RU0gaXMgbm90IHNldAoKIwojIHg4NiBEZWJ1Z2dpbmcKIwpDT05GSUdfRUFSTFlfUFJJTlRL
X1VTQj15CkNPTkZJR19YODZfVkVSQk9TRV9CT09UVVA9eQpDT05GSUdfRUFSTFlfUFJJTlRL
PXkKQ09ORklHX0VBUkxZX1BSSU5US19EQkdQPXkKIyBDT05GSUdfRUFSTFlfUFJJTlRLX1VT
Ql9YREJDIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1BHVF9EVU1QIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfVExCRkxVU0ggaXMgbm90IHNldApDT05GSUdfSEFWRV9NTUlPVFJBQ0Vf
U1VQUE9SVD15CiMgQ09ORklHX1g4Nl9ERUNPREVSX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09O
RklHX0lPX0RFTEFZXzBYODA9eQojIENPTkZJR19JT19ERUxBWV8wWEVEIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU9fREVMQVlfVURFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9fREVMQVlf
Tk9ORSBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19CT09UX1BBUkFNUz15CiMgQ09ORklHX0NQ
QV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19FTlRSWT15CiMgQ09ORklHX0RFQlVH
X05NSV9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19YODZfREVCVUdfRlBVPXkKIyBDT05G
SUdfUFVOSVRfQVRPTV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19VTldJTkRFUl9PUkM9eQoj
IENPTkZJR19VTldJTkRFUl9GUkFNRV9QT0lOVEVSIGlzIG5vdCBzZXQKIyBlbmQgb2YgeDg2
IERlYnVnZ2luZwoKIwojIEtlcm5lbCBUZXN0aW5nIGFuZCBDb3ZlcmFnZQojCiMgQ09ORklH
X0tVTklUIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9USUZJRVJfRVJST1JfSU5KRUNUSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfRlVOQ1RJT05fRVJST1JfSU5KRUNUSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX0tD
T1Y9eQpDT05GSUdfQ0NfSEFTX1NBTkNPVl9UUkFDRV9QQz15CiMgQ09ORklHX0tDT1YgaXMg
bm90IHNldApDT05GSUdfUlVOVElNRV9URVNUSU5HX01FTlU9eQojIENPTkZJR19URVNUX0RI
UlkgaXMgbm90IHNldAojIENPTkZJR19MS0RUTSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1Rf
TUlOX0hFQVAgaXMgbm90IHNldAojIENPTkZJR19URVNUX0RJVjY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfUkVG
X1RSQUNLRVIgaXMgbm90IHNldAojIENPTkZJR19SQlRSRUVfVEVTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JFRURfU09MT01PTl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJWQUxf
VFJFRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEVSQ1BVX1RFU1QgaXMgbm90IHNldAoj
IENPTkZJR19BVE9NSUM2NF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfSEVY
RFVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUUklOR19TRUxGVEVTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1RFU1RfU1RSSU5HX0hFTFBFUlMgaXMgbm90IHNldAojIENPTkZJR19URVNUX0tT
VFJUT1ggaXMgbm90IHNldAojIENPTkZJR19URVNUX1BSSU5URiBpcyBub3Qgc2V0CiMgQ09O
RklHX1RFU1RfU0NBTkYgaXMgbm90IHNldAojIENPTkZJR19URVNUX0JJVE1BUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFU1RfVVVJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfWEFSUkFZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9NQVBMRV9UUkVFIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEVTVF9SSEFTSFRBQkxFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9JREEgaXMgbm90
IHNldAojIENPTkZJR19URVNUX0xLTSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQklUT1BT
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9WTUFMTE9DIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9VU0VSX0NPUFkgaXMgbm90IHNldAojIENPTkZJR19URVNUX0JQRiBpcyBub3Qgc2V0
CiMgQ09ORklHX1RFU1RfQkxBQ0tIT0xFX0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJTkRf
QklUX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfRklSTVdBUkUgaXMgbm90
IHNldAojIENPTkZJR19URVNUX1NZU0NUTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfVURF
TEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9TVEFUSUNfS0VZUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1RFU1RfS01PRCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfTUVNQ0FUX1AgaXMg
bm90IHNldAojIENPTkZJR19URVNUX01FTUlOSVQgaXMgbm90IHNldAojIENPTkZJR19URVNU
X0ZSRUVfUEFHRVMgaXMgbm90IHNldAojIENPTkZJR19URVNUX0ZQVSBpcyBub3Qgc2V0CiMg
Q09ORklHX1RFU1RfQ0xPQ0tTT1VSQ0VfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19U
RVNUX09CSlBPT0wgaXMgbm90IHNldApDT05GSUdfQVJDSF9VU0VfTUVNVEVTVD15CiMgQ09O
RklHX01FTVRFU1QgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgVGVzdGluZyBhbmQgQ292
ZXJhZ2UKCiMKIyBSdXN0IGhhY2tpbmcKIwojIGVuZCBvZiBSdXN0IGhhY2tpbmcKIyBlbmQg
b2YgS2VybmVsIGhhY2tpbmcK

--------------lddoJYLd040RSbXBNiuMgwPt--

