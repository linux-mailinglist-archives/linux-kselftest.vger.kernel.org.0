Return-Path: <linux-kselftest+bounces-12953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CF91C936
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AC828757A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0F81729;
	Fri, 28 Jun 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MWV6RuhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C97B3F3;
	Fri, 28 Jun 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614319; cv=none; b=n1x/MXiFjrIVa2rOcmacaL5BgS0LANV4TtdK/vuvqgdtK0IQ07HnU42fpjAvRhSsW+N5gyPrI/3T/needZbGq9p+9gehnGTLOPjJSlE/BbZWyE3QgBtNunfEHVCNl7fsJnqOX0MavJYUo4qAylXjysyrQmpmc6a4RFTRW3Q140U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614319; c=relaxed/simple;
	bh=iKhzXq5JAa4rnm6W+0jIhIrVPDSej6AO7EJ7vWE19mY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PK97o4t6F7LNYgZqdxFlX3I3x14zogv70/UVtecIN75K/kuQD8YlfUdKt2A+11JJI6xxoLCiKo0tOhgZN/qCVLC2smyMaVLBmNY85TKsWJDXeyg5ZnjYWHYW838WF1pbaJq/UYHYWllgqwTzYuJOF2Ny3/AfCcMCIXULC2HjUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MWV6RuhZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BaALS8gPF7XBWlriyHr8hek8u4Itk7JbvtgTcprjFzM=; b=MWV6RuhZQuzfGy0rDzTGEfeYyJ
	Pu/BPy6MB2lBFNp6BXB4zgZnygABXoL9oZEKRNVzC3pOG07/xf2YDbHoi+2pafCYl/KWao+ziEjch
	32mq2i6wIaqz/u5vRo+nEeAwnFviUoPuJB81Nu402QkdTNkLMcPAN3ssRQZNsIQm6kxudv1MqdtpY
	W076G8CrtWSkh/tU3QdRLrtNPewe/hjSXS7LU1XKvv5wK/XdcQZiMO9OE3zSVqHUalhw/a2lcNs2X
	tn18MDmrQKD2dIXKwsZ+/7Rkxl+4m5ZJ/YmIgAJPMz9hixE4nfu/pZ6kC7LkxlBV6AH4nUME1L/iL
	4pXTnlCA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNKEb-0002Pl-66; Sat, 29 Jun 2024 00:38:25 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNKEZ-000CLP-39;
	Sat, 29 Jun 2024 00:38:24 +0200
Subject: Re: [PATCH bpf-next v5 6/9] selftests/bpf: Use start_server_str in
 sk_lookup
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
 <244b5ac86c177f9f9c38304e07a1e3cc0d9bb92d.1719293738.git.tanggeliang@kylinos.cn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5c03ff1b-f500-27a0-b8d0-7223b84dbe71@iogearbox.net>
Date: Sat, 29 Jun 2024 00:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <244b5ac86c177f9f9c38304e07a1e3cc0d9bb92d.1719293738.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/25/24 7:42 AM, Geliang Tang wrote:
[...]
> +static int make_server(int sotype, const char *ip, int port,
> +		       struct bpf_program *reuseport_prog)
> +{
> +	struct cb_opts cb_opts = {
> +		.family = is_ipv6(ip) ? AF_INET6 : AF_INET,
> +		.sotype = sotype,
> +		.reuseport = reuseport_prog,
> +	};
> +	struct network_helper_opts opts = {
> +		.backlog	= SOMAXCONN,
> +		.post_socket_cb = setsockopts,
> +		.cb_opts	= &cb_opts,
> +	};
> +	int err, fd = -1;

nit: fd doesn't need init given you call start_server_str right away

> +	fd = start_server_str(cb_opts.family, sotype, ip, port, &opts);
> +	if (CHECK(fd < 0, "start_server_addr", "failed\n"))


if (!ASSERT_GE(fd, 0, "start_server_str"))

> +		return -1;
>   
>   	/* Late attach reuseport prog so we can have one init path */
>   	if (reuseport_prog) {
> 

Rest of the series LGTM.

Thanks,
Daniel

