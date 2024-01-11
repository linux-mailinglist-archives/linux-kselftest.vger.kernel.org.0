Return-Path: <linux-kselftest+bounces-2864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D7582B3A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7483F28C5CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75F51C26;
	Thu, 11 Jan 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="C00PceO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99E50256
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9rfT3DXCzMqg4J;
	Thu, 11 Jan 2024 17:06:09 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9rfS5TXFzMpnPq;
	Thu, 11 Jan 2024 18:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704992769;
	bh=CdZUhqEL7svMMrUJY9jftLzMS4Q7hSQStmanF07Q0tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C00PceO7t8u42aro/+NUTCIvBumZPfEs0m1+vuN+zihn/JyNXAKQV5Uhe69xXehUJ
	 E+4kFeF1sr+Dlr9LFv93uHg4tIIjzDnuK5JRehMW5c/C3VTQ8pxkxzArdlW53uZY2t
	 v+aflDjFyPBd9qTmsJHKSyvixN9ChzyJPwDBy4Wo=
Date: Thu, 11 Jan 2024 18:06:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: Re: [PATCH v14 10/12] selftests/landlock: Add network tests
Message-ID: <20240111.pah8ip0Ahv0f@digikod.net>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
 <20231026014751.414649-11-konstantin.meskhidze@huawei.com>
 <0584f91c-537c-4188-9e4f-04f192565667@collabora.com>
 <20231219.ig7ih7hof4Eu@digikod.net>
 <bc365e13-f02d-4518-801a-a02e51f4f72e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc365e13-f02d-4518-801a-a02e51f4f72e@collabora.com>
X-Infomaniak-Routing: alpha

Thanks for the report and the test Muhammad, the fix is now merged:
https://git.kernel.org/torvalds/c/bbf5a1d0e5d0fb3bdf90205aa872636122692a50

See https://lore.kernel.org/all/20240103163415.304358-1-mic@digikod.net/

On Wed, Dec 20, 2023 at 04:19:44PM +0500, Muhammad Usama Anjum wrote:
> On 12/20/23 2:17 PM, Mickaël Salaün wrote:
> > Hi Muhammad,
> > 
> > Thanks for the report.
> > 
> > On Tue, Dec 19, 2023 at 03:38:55PM +0500, Muhammad Usama Anjum wrote:
> >> Hi Konstantin,
> >>
> >> There are some errors being reported in KernelCI:
> >> https://linux.kernelci.org/test/plan/id/657ab2240c761c0bd1e134ee/
> >>
> >> The following sub-tests are failing:
> >> landlock_net_test_protocol_no_sandbox_with_ipv6_tcp_bind_unspec
> >> landlock_net_test_protocol_no_sandbox_with_ipv6_udp_bind_unspec
> >> landlock_net_test_protocol_tcp_sandbox_with_ipv6_udp_bind_unspec
> >>
> >> From my initial investigation, I can see that these failures are coming
> >> from just finding the wrong return error code (-97 instead of -22). It may
> >> be test's issue or the kernel's, not sure yet.
> > 
> > I cannot reproduce these errors (with the same kernel commit), the
> > Defconfig URL is broken. Could you please share the config used for
> > tests?
> I've also attached the config. I'm generated the config by following:
> make defconfig && make kvm_guest.config
> scripts/kconfig/merge_config.sh .config tools/testing/selftests/landlock/config
> 
> > 
> > According to the failing tests, it looks like the network stack returns
> > EAFNOSUPPORT instead of EINVAL, which should happen because addr_len <
> > SIN6_LEN_RFC2133 (cf. inet6_bind_sk).  I then think that the issue comes
> > from an inconsistent error priority with the prot->bind() call in
> > inet6_bind_sk() that may return EAFNOSUPPORT when uaddr contains
> > AF_UNSPEC. I didn't find such bind() implementations though.
> > 
> > Could you please validate this theory by removing this call in
> > inet6_bind_sk() and run the tests again?
> I'll have a look if I can find anything.
> 
> > 
> > Eric, do you know where are such struct proto bind() implementations and
> > why they may return EAFNOSUPPORT?
> > 
> > Regards,
> >  Mickaël
> > 
> > 
> >>
> >> Thanks,
> >> Usama
> >>
> >> On 10/26/23 6:47 AM, Konstantin Meskhidze wrote:
> >>> Add 82 test suites to check edge cases related to bind() and connect()
> >>> actions. They are defined with 6 fixtures and their variants:
> >>>
> >>> The "protocol" fixture is extended with 12 variants defined as a matrix
> >>> of: sandboxed/not-sandboxed, IPv4/IPv6/unix network domain, and
> >>> stream/datagram socket. 4 related tests suites are defined:
> >>> * bind: Tests with non-landlocked/landlocked ipv4, ipv6 and unix sockets.
> >>> * connect: Tests with non-landlocked/landlocked ipv4, ipv6 and unix
> >>> sockets.
> >>> * bind_unspec: Tests with non-landlocked/landlocked restrictions
> >>> for bind action with AF_UNSPEC socket family.
> >>> * connect_unspec: Tests with non-landlocked/landlocked restrictions
> >>> for connect action with AF_UNSPEC socket family.
> >>>
> >>> The "ipv4" fixture is extended with 4 variants defined as a matrix
> >>> of: sandboxed/not-sandboxed, IPv4/unix network domain, and
> >>> stream/datagram socket. 1 related test suite is defined:
> >>> * from_unix_to_inet: Tests to make sure unix sockets' actions are not
> >>> restricted by Landlock rules applied to TCP ones.
> >>>
> >>> The "tcp_layers" fixture is extended with 8 variants defined as a matrix
> >>> of: IPv4/IPv6 network domain, and different number of landlock rule layers.
> >>> 2 related tests suites are defined:
> >>> * ruleset_overlap.
> >>> * ruleset_expand.
> >>>
> >>> In the "mini" fixture 4 tests suites are defined:
> >>> * network_access_rights: Tests with legitimate access values.
> >>> * unknown_access_rights: Tests with invalid attributes, out of access
> >>>   range.
> >>> * inval:
> >>>   - unhandled allowed access.
> >>>   - zero access value.
> >>> * tcp_port_overflow: Tests with wrong port values more than U16_MAX.
> >>>
> >>> In the "ipv4_tcp" fixture supports IPv4 network domain, stream socket.
> >>> 2 tests suites are defined:
> >>> * port_endianness: Tests with big/little endian port formats.
> >>> * with_fs: Tests with network bind() socket action within
> >>> filesystem directory access test.
> >>>
> >>> The "port_specific" fixture is extended with 4 variants defined
> >>> as a matrix of: sandboxed/not-sandboxed, IPv4/IPv6 network domain,
> >>> and stream socket. 2 related tests suites are defined:
> >>> * bind_connect_zero: Tests with port 0 value.
> >>> * bind_connect_1023: Tests with port 1023 value.
> >>>
> >>> Test coverage for security/landlock is 94.5% of 932 lines according to
> >>> gcc/gcov-9.
> >>>
> >>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> >>> Co-developed-by: Mickaël Salaün <mic@digikod.net>
> >>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> >>> ---

