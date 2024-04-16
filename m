Return-Path: <linux-kselftest+bounces-8092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC48A636F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959781C209C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0EF3BBEA;
	Tue, 16 Apr 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vwK1gDNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C237152
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247655; cv=none; b=CNey96Vihu54GEU9KDJfBQC89cRDQ6IWdmi4WvYO88Z0aejiwETC1QPGI4HXVpRQB6KH5/NXNEYHLdjT08QdVEXzq2p8VlFcLKlJtRhVzdhkp7C7UOlDb4vTwN7ZL7Gei0owhaQf/HlRgROtteROMSXyFuixWS3b9aMAcU45TKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247655; c=relaxed/simple;
	bh=Itih821s4Pz6EeuBtxCyww/EuZLn3dR4lQszUSsSx8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj+CFj1jA3P5NdUr5jfELgPi7Bs2r8RJyQy+rJb/3jxsS9Kp2eU6B0MJxWeVvMVmmGWLYHPo0Wjiuvfs+PrO8Ym/U89v6COB41j1T+NtVoloTTIYBRlyLLyF70L/B9sRMrTAKWo/JLRaLu3TM5Tx/B4XXhkYmX2X6fGdIbRMVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vwK1gDNU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce275c37-d45e-451a-985e-e60f8a45ca77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713247651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDQZtCQlsQAIfw4f4Zwq1DM+OHXN7Y67mnFGrJ4ftZA=;
	b=vwK1gDNU2MWjIW7qtapuyzJ2csPghaAScWFTQfMth7dHoes5T73KjNHhU8cbySSNr35Mgo
	UF/MuPBJIsoJLZ4AXt/RylJmqsKxdQ4dwyAW/K26E+sGRKI3TWH2D89XivKq53ahwEwR5d
	pYeqWamvSfUWMprCOMaZcR4mjT8bsy4=
Date: Mon, 15 Apr 2024 23:07:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-5-jrife@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240412165230.2009746-5-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/24 9:52 AM, Jordan Rife wrote:
> This patch lays the groundwork for testing IPv4 and IPv6 sockaddr hooks
> and their interaction with both socket syscalls and kernel functions
> (e.g. kernel_connect, kernel_bind, etc.) and moves the test cases from
> the old-style bpf/test_sock_addr.c self test into the sock_addr
> prog_test.

Thanks for moving the existing sock_addr test to the test_progs.

> +static int ping_once(int ipv, const char *addr)
> +{
> +	const char *ping_cmd_prefix = "ping -";
> +
> +	if (!SYS_NOFAIL("type ping%d >/dev/null 2>&1", ipv))
> +		ping_cmd_prefix = "ping";
> +
> +	return SYS_NOFAIL("%s%d -q -c 1 -W 1 %s >/dev/null 2>&1",
> +			  ping_cmd_prefix, ipv, addr);
> +}
> +
> +static int setup_test_env(void)
> +{
> +	SYS(err, "ip link add dev %s1 type veth peer name %s2", TEST_IF_PREFIX,
> +	    TEST_IF_PREFIX);

I would like to take this chance to simplify the setup.

Does it need a veth pair? The %s2 interface is not used.

Can it be done in lo alone?

Also, all this setup (and test) has to be done in a new netns. Anything blocking 
the kfunc in patch 2 using the current task netns instead of the init_net?


> +	SYS(err, "ip link set %s1 up", TEST_IF_PREFIX);
> +	SYS(err, "ip link set %s2 up", TEST_IF_PREFIX);
> +	SYS(err, "ip -4 addr add %s/8 dev %s1", TEST_IPV4, TEST_IF_PREFIX);
> +	SYS(err, "ip -6 addr add %s/128 dev %s1", TEST_IPV6, TEST_IF_PREFIX);

Add nodad to the "ip -6 addr add...". just in case it may add unnecessary delay.

> +
> +	int i;
> +
> +	for (i = 0; i < 5; i++) {
> +		if (!ping_once(4, TEST_IPV4) && !ping_once(6, TEST_IPV6))

This interface/address ping should not be needed. Other tests under prog_tests/ 
don't need this interface/address ping also.

> +			return 0;
> +	}
> +
> +	ASSERT_FAIL("Timed out waiting for test IP to become available.");
> +err:
> +	return -1;
> +}
> +
> +static void cleanup_test_env(void)
> +{
> +	SYS_NOFAIL("ip link del %s1 2>/dev/null", TEST_IF_PREFIX);
> +	SYS_NOFAIL("ip link del %s2 2>/dev/null", TEST_IF_PREFIX);

Using lo will make this easier. Regardless, the link should go away with the netns.

> +}
> +
>   void test_sock_addr(void)
>   {
>   	int cgroup_fd = -1;
>   	void *skel;
>   
> +	if (!ASSERT_OK(setup_test_env(), "setup_test_env"))

This will probably have to be called after the test__join_cgroup() if it also 
creates a new netns.

pw-bot: cr

> +		goto cleanup;
> +
>   	cgroup_fd = test__join_cgroup("/sock_addr");
>   	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>   		goto cleanup;
> @@ -609,4 +755,5 @@ void test_sock_addr(void)
>   cleanup:
>   	if (cgroup_fd >= 0)
>   		close(cgroup_fd);
> +	cleanup_test_env();
>   }


