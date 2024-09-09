Return-Path: <linux-kselftest+bounces-17552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B2972461
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5018284DFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EF318C913;
	Mon,  9 Sep 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YXSkttQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2818C351;
	Mon,  9 Sep 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916690; cv=none; b=XvytmOCWtSciqo4YnMqwcOfwOod5607zLMngv1ox7DKc24ykLHeTRTxW73MiGg6D6/p/ybAErWb29jdHBctox5VqOApv0CD2wW+KwFKLWPN4IRr5KHylpPyLn/f+uHzO0am27ENcOaKe1FV07fS8iZ9s6HYDxXo1bdmZMS4NBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916690; c=relaxed/simple;
	bh=iZXEicXf2JMTARYTOOY+s6HNBfaRa9aGSN/7vqWjwDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0vT6K3PMjQdURjJlHDWDQLvupyMCl3RuHNn4MeQeKAIYhgSnq8xsxSxh//eOesKo9oE39eRC6zXPkGj8fLayXRlx9eeCBYiZHDuUieVy6GE0GpiGDWdbRyWHCxaG4DMaeVBJVZ4a8TTlG2bpaPcCZiDkY1Rqn7h38LqdkFjCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YXSkttQG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A32DC60005;
	Mon,  9 Sep 2024 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725916685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXH7SELfdOSStCN609S/Bql3tY3XiIjnrc2Xlvt1w2o=;
	b=YXSkttQGYgp/+sep7xbSgg7rzLebLQOddl9eY/m5cTXsKUu4rcwfY7QwOWlv9wht6umnzL
	07wrjt531H405o4Lszl5ytE+BwOCYDPh7z3R0nTlJYdBGa4XyvaBw7YNTQDylKV/NJk0/j
	YXtltBjyIHhmL1oUv2QhTBppfQDIVPqRiTyrh9MNm92wClJQgZtnteNr6ZanoeWCMcfMbO
	fPif8C/v1sXbg8yhgrGMn7nCIVde5YzssJpn7iVFnrUHuDyFsOeVMV1EqbG/3Cwk2CDTWs
	xlmnFkmxj1xXwCwYDQ8ED1Rx3rgXiboXc/84zeuybsie0lk3Y9N+zpsfxKxdNw==
Date: Mon, 9 Sep 2024 23:18:00 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Alexis =?UTF-8?B?TG90aG9yw6k=?= (eBPF Foundation)"
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: convert test_xdp_features.sh to
 test_progs
Message-ID: <20240909231800.72b6b328@fedora.home>
In-Reply-To: <20240909-convert_xdp_tests-v1-1-925be5fbee3c@bootlin.com>
References: <20240909-convert_xdp_tests-v1-1-925be5fbee3c@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexis,

On Mon, 09 Sep 2024 22:02:07 +0200
Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com> wrote:

> test_xdp_features.sh is a shell script allowing to test that xdp features
> advertised by an interface are indeed delivered. The test works by starti=
ng
> two instance of the same program, both attaching specific xdp programs to
> each side of a veth link, and then make those programs manage packets and
> collect stats to check whether tested XDP feature is indeed delivered or
> not. However this test is not integrated in test_progs framework and so c=
an
> not run automatically in CI.
>=20
> Rewrite test_xdp_features to integrate it in test_progs so it can run
> automatically in CI. The main changes brought by the rewrite are the
> following:
> - instead of running to separated processes (each one managing either the
>   tester veth or the DUT vet), run a single process
> - slightly change testing direction (v0 is the tester in local namespace,
>   v1 is the Device Under Test in remote namespace)
> - group all tests previously managed by test_xdp_features as subtests (one
>   per tested XDP feature). As a consequence, run only once some steps
>   instead of once per subtest (eg: starting/stopping the udp server). On
>   the contrary, make sure that each subtest properly cleans up its state
>   (ie detach xdp programs, reset test stats, etc)
> - since there is now a single process, get rid of the "control" tcp chann=
el
>   used to configure DUT. Configuring the DUT now only consists in switchi=
ng
>   to DUT network namespace and run the relevant commands
> - since there is no more control channel, get rid of TLVs, keep only the
>   CMD_ECHO packet type, and set it as a magic
> - simplify network setup: use only ipv6 instead of both ipv4 and ipv6,
>   force static neighbours instead of waiting for autoconfiguration, do not
>   force gro (fetch xdp features only once xdp programs are loaded instead)
>=20
> The existing XDP programs are reused, with some minor changes:
> - tester and dut stats maps are converted to global variables for easier
>   usage
> - programs do not use TLV struct anymore but the magic replacing the echo
>   command
> - avoid to accidentally make tests pass: drop packets instead of forwardi=
ng
>   them to userspace when they do not match the expected payload
>=20
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>

I'm far for having reviewed the whole patch, but I do have one comment
below :)

[...]

> +static void *run_dut_echo_thread(void *arg)
> +{
> +	struct test_data *t =3D (struct test_data *)arg;
> +	__u32 magic;
> +
> +	while (!t->quit_dut_echo_thread) {
> +		struct sockaddr_storage addr;
> +		socklen_t addrlen;
> +		size_t n;
> +
> +		n =3D recvfrom(t->echo_server_sock, &magic, sizeof(magic),
> +			     MSG_WAITALL, (struct sockaddr *)&addr, &addrlen);
> +		if (n !=3D sizeof(magic)) {
> +			usleep(LOOP_DELAY_US);
> +			continue;
> +		}
> +
> +		if (htonl(magic) !=3D CMD_ECHO)
> +			continue;

Shouldn't it be ntohl here ? The former code used the ntohs helper for
that command, and you're sending the magic in send_echo_msg with a
htonl() so I guess here you might want to convert the value back to
host endianness.

Thanks,

Maxime

