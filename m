Return-Path: <linux-kselftest+bounces-28699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA518A5BA5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E65167881
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF02222CE;
	Tue, 11 Mar 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QQmUUnGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4B1EA7FD;
	Tue, 11 Mar 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680175; cv=none; b=s/bUKdnPYWfeKIIXqKpC5N6MUIAL0l0/Tq0W8e0F9iUzD04uRlldvnsvihaEb3zSFFPglUh53OcN7aQc8KSVlIIzqRvamzwKEnv0cf3r28IDtdBHt9o8dt3bGHk9sInAVyhuVmUfhpwNXKJaDzjT4086rKtorGFYkeOXb8oofbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680175; c=relaxed/simple;
	bh=LSjdvaAkpe0Pmc07F6X/Q7yeIReLFdX+62wcHomTM84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8gUWWmAwCq7mFgIFFfAwR0fBjVEIQSHLlzPFhxP1oauwk9VpIPucz1QEDNZ1krOoA7NMzmnjMmN1KcQ5gUw5tFXq52XSkNQWzg4+r4UBdRZJnT/6JTOMXCwPOqurkkNXGzHn706hhsIBJBqNNp+k8HvLWSM4LXhIwX9U2KPow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QQmUUnGw; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741680174; x=1773216174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dUt3LEoSvOjSrsb26MD+fECZCawYRKXBOLzP/h4uqJU=;
  b=QQmUUnGwVpUki+9/ShMCMX7HSkiV460YicdjobNiT7gUL+CzV94T9MJ2
   dm5aUUXt0w+MPe24AyI7x8UVG1groxn2hEoG9M32VGq5j1uisTDWQTNe8
   Ysq7qLsOpM4exJTYbUoKoXwAwtu9NUbM2VD4YCe7PUxG3ZSaGs7ADXBx8
   w=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="473988847"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:22259]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id 316f76c8-51bd-48b1-bb20-93ea36c10044; Tue, 11 Mar 2025 08:02:45 +0000 (UTC)
X-Farcaster-Flow-ID: 316f76c8-51bd-48b1-bb20-93ea36c10044
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 08:02:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 08:02:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aleksandr.mikhalitsyn@canonical.com>
CC: <arnd@arndb.de>, <bluca@debian.org>, <brauner@kernel.org>,
	<cgroups@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<hannes@cmpxchg.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <mkoutny@suse.com>,
	<mzxreary@0pointer.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <tj@kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next 4/4] tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID
Date: Tue, 11 Mar 2025 01:02:32 -0700
Message-ID: <20250311080233.11136-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun,  9 Mar 2025 14:28:15 +0100
> +static void client(FIXTURE_DATA(so_peercgroupid) *self,
> +		   const FIXTURE_VARIANT(so_peercgroupid) *variant)
> +{
> +	int cfd, err;
> +	socklen_t len;
> +	uint64_t peer_cgroup_id = 0, test_cgroup1_id = 0, test_cgroup2_id = 0;
> +	char state;
> +
> +	cfd = socket(AF_UNIX, variant->type, 0);
> +	if (cfd < 0) {
> +		log_err("socket");
> +		child_die();
> +	}
> +
> +	if (variant->type == SOCK_DGRAM) {
> +		fill_sockaddr(self->client_addr, variant->abstract);
> +
> +		if (bind(cfd, (struct sockaddr *)&self->client_addr->listen_addr, self->client_addr->addrlen)) {
> +			log_err("bind");
> +			child_die();
> +		}
> +	}
> +
> +	/* negative testcase: no peer for socket yet */
> +	len = sizeof(peer_cgroup_id);
> +	err = getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len);
> +	if (!err || (errno != ENODATA)) {
> +		log_err("getsockopt must fail with errno == ENODATA when socket has no peer");
> +		child_die();
> +	}
> +
> +	if (connect(cfd, (struct sockaddr *)&self->server_addr.listen_addr,
> +		    self->server_addr.addrlen) != 0) {
> +		log_err("connect");
> +		child_die();
> +	}
> +
> +	state = 'R';
> +	write(self->sync_sk[1], &state, sizeof(state));

nit: This looks unnecessary ?


> +
> +	read(self->sync_sk[1], &test_cgroup1_id, sizeof(uint64_t));
> +	read(self->sync_sk[1], &test_cgroup2_id, sizeof(uint64_t));
> +
> +	len = sizeof(peer_cgroup_id);
> +	if (getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len)) {
> +		log_err("Failed to get SO_PEERCGROUPID");
> +		child_die();
> +	}
> +
> +	/*
> +	 * There is a difference between connection-oriented sockets
> +	 * and connectionless ones from the perspective of SO_PEERCGROUPID.
> +	 *
> +	 * sk->sk_cgrp_data is getting filled when we allocate struct sock (see call to cgroup_sk_alloc()).
> +	 * For DGRAM socket, self->server socket is our peer and by the time when we allocate it,
> +	 * parent process sits in a test_cgroup1. Then it changes cgroup to test_cgroup2, but it does not
> +	 * affect anything.
> +	 * For STREAM/SEQPACKET socket, self->server is not our peer, but that one we get from accept()
> +	 * syscall. And by the time when we call accept(), parent process sits in test_cgroup2.
> +	 *
> +	 * Let's ensure that it works like that and if it get changed then we should detect it
> +	 * as it's a clear UAPI change.
> +	 */
> +	if (variant->type == SOCK_DGRAM) {
> +		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup1_id */
> +		if (peer_cgroup_id != test_cgroup1_id) {
> +			log_err("peer_cgroup_id != test_cgroup1_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup1_id);
> +			child_die();
> +		}
> +	} else {
> +		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup2_id */
> +		if (peer_cgroup_id != test_cgroup2_id) {
> +			log_err("peer_cgroup_id != test_cgroup2_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup2_id);
> +			child_die();
> +		}
> +	}
> +}
> +
> +TEST_F(so_peercgroupid, test)
> +{
> +	uint64_t test_cgroup1_id, test_cgroup2_id;
> +	int err;
> +	int pfd;
> +	char state;
> +	int child_status = 0;
> +
> +	if (cg_find_unified_root(self->cgroup_root, sizeof(self->cgroup_root), NULL))
> +		ksft_exit_skip("cgroup v2 isn't mounted\n");
> +
> +	self->test_cgroup1 = cg_name(self->cgroup_root, "so_peercgroupid_cg1");
> +	ASSERT_NE(NULL, self->test_cgroup1);
> +
> +	self->test_cgroup2 = cg_name(self->cgroup_root, "so_peercgroupid_cg2");
> +	ASSERT_NE(NULL, self->test_cgroup2);
> +
> +	err = cg_create(self->test_cgroup1);
> +	ASSERT_EQ(0, err);
> +
> +	err = cg_create(self->test_cgroup2);
> +	ASSERT_EQ(0, err);
> +
> +	test_cgroup1_id = cg_get_id(self->test_cgroup1);
> +	ASSERT_LT(0, test_cgroup1_id);
> +
> +	test_cgroup2_id = cg_get_id(self->test_cgroup2);
> +	ASSERT_LT(0, test_cgroup2_id);
> +
> +	/* enter test_cgroup1 before allocating a socket */
> +	err = cg_enter_current(self->test_cgroup1);
> +	ASSERT_EQ(0, err);
> +
> +	self->server = socket(AF_UNIX, variant->type, 0);
> +	ASSERT_NE(-1, self->server);
> +
> +	/* enter test_cgroup2 after allocating a socket */
> +	err = cg_enter_current(self->test_cgroup2);
> +	ASSERT_EQ(0, err);
> +
> +	fill_sockaddr(&self->server_addr, variant->abstract);
> +
> +	err = bind(self->server, (struct sockaddr *)&self->server_addr.listen_addr, self->server_addr.addrlen);
> +	ASSERT_EQ(0, err);
> +
> +	if (variant->type != SOCK_DGRAM) {
> +		err = listen(self->server, 1);
> +		ASSERT_EQ(0, err);
> +	}
> +
> +	err = socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, self->sync_sk);
> +	EXPECT_EQ(err, 0);
> +
> +	self->client_pid = fork();
> +	ASSERT_NE(-1, self->client_pid);
> +	if (self->client_pid == 0) {
> +		close(self->server);
> +		close(self->sync_sk[0]);
> +		client(self, variant);
> +		exit(0);
> +	}
> +	close(self->sync_sk[1]);
> +
> +	if (variant->type != SOCK_DGRAM) {
> +		pfd = accept(self->server, NULL, NULL);
> +		ASSERT_NE(-1, pfd);

nit: close(self->server) here ?

It's close()d anyway when the process exits.


> +	} else {
> +		pfd = self->server;
> +	}
> +
> +	/* wait until the child arrives at checkpoint */
> +	read(self->sync_sk[0], &state, sizeof(state));
> +	ASSERT_EQ(state, 'R');

The client will wait two write()s without this synchronisation.


> +
> +	write(self->sync_sk[0], &test_cgroup1_id, sizeof(uint64_t));
> +	write(self->sync_sk[0], &test_cgroup2_id, sizeof(uint64_t));
> +
> +	close(pfd);
> +	waitpid(self->client_pid, &child_status, 0);
> +	ASSERT_EQ(0, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
> +}
> +
> +TEST_HARNESS_MAIN

