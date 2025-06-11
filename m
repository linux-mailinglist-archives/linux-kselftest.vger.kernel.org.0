Return-Path: <linux-kselftest+bounces-34638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76308AD4A44
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5433D3A5EF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 05:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D58221702;
	Wed, 11 Jun 2025 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMXtuiZw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC62045B5;
	Wed, 11 Jun 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618529; cv=none; b=H2H2jIBjGyMmYPbglsAE+7lSHGkO3SHPvpfFfCHHCTEAwqIUcJd7y6u/1v9uLnqUgRwshn28qMy7JFUdoU3FolTMeX3ep+Ufxujwa3RWV0DdSSfrcnqB7aOASh4XBcGI8afbanu1GHMvY6+6f7VmKLEHA5A6Pt9ENvGMM0QFxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618529; c=relaxed/simple;
	bh=ayaMEU/Ch5YOHTkvvKRCj+w/PTv2ZLP+L7N+vECgU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DflK0Kj0zGdJNtfHGV941KhIsxIw2ERYf3cC0MDZWFap6HZcEpRQ68ZoVsXv/wFqJI/53Q+6ibTr8xHB453rhGwxEVim+zuvpBPccmlY5dhdcBb+A/yeMt7y6JP9qAidc3DoK42cavHlnNDyHEAtg0/ae2GKDy6mFrnRsq/QsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMXtuiZw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so15575505ad.3;
        Tue, 10 Jun 2025 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749618526; x=1750223326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwiLk2bUgnnXObqCMxhj7bAHaeNINQCjvFcpBiWLLv0=;
        b=mMXtuiZw4oF2yL2P6XJHBoU5TJhUr+zRYb5CoL3dIfsr2T0F/4HA8gmpOOWZN2lOID
         LHETHr7QaSAtA10ua2hleOS+6nQyWYl6pQw/kkuwlpcVDEQ2KwI5AinIWV+xXnB4FFwB
         awbIc7MvC7SD8tpJ0F2206dUGUzXKPsu19iln4Lz8qBfxY/IPYrSTMBddmlDZ215ppd4
         Gqblw5SJCkddR+39/KC4Ejls2sCuSgoh15hbTQkKomn1iXyH+mgmJ6zvv17IyJYeBMxy
         /ysPWKMXsEJ8OBYwieeA04xBoufiVvg4y2OOxt8N5ZZN4fUsJXSkoYrw/6cumGJGqKoF
         lidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618526; x=1750223326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwiLk2bUgnnXObqCMxhj7bAHaeNINQCjvFcpBiWLLv0=;
        b=S+vjMmFIGXkZ77eAgyOUStd8wMI9OIMS7z3/cu8yD+q1Wojy5HEIvDZ/wj/MR4j84v
         eLSFV7oCOU6Hg+3CFXJcLSQvI0WDEKxh/0vZSc+2EWOD8ezguXZaFfEDkdJxXTKg4yoH
         2szAskTQwMSkoCsII2yhLX89WjkQSQQEce11BisSoNiTl6H7VSSfMvETYJOSM+WdogWo
         PCGMXGfxI9Hm0LImS9s4CWfKDPmjPkCtX6xNQh40Psl8VgPcDqCEgmvtiNMaRbH5ycaQ
         4Mlz3QroQ4q1uxtWLPfWByr9hS5YJ+vH6TPXxTfxxuv3rydTnnyCD1iAvSB/uTOvIu62
         vIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2BwBcGebNjCquWNMIUTHmVwZmZefMZCcNJQALdJpf5BmGmswQZjcRaoXVlm6sEaWMoirraU+h5dV0ctw=@vger.kernel.org, AJvYcCVNWhPR7pBiPSH8je6uvYkiIMYyLt3LhFSkWni+HHsZKnxgKHpu1enjBBLDtV32PhSdocO3Iqanf+Xoo4b4TWhi@vger.kernel.org, AJvYcCXnwJBxsJkpZ/EKvU4VGP42J4xURj283GPU2ZLLBtsDGodh0PwsfdJPF5GCavF5Sh5WzqFTl/V8@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLP7MDgD+/IoWF9bSUw/Zx0FrI92xkiDGZytz7mjZ2JqeJO59
	W66DmffnszMSPwYeLsxxGuMj8P7K5OC7X3cDs1CUCxMtTwD4/Ud61MQz
X-Gm-Gg: ASbGncvqDikgpCSWoo2Es2DL9uJv3dueaDxM53dBpn0R5YoT7k08fSATeDpxNjpK4C2
	AHZWU6zNTmQx86F362xGntK1Ywx1+1fMdAifZNH7owcEK/PFpWker7N+sIRxnw6iFvagVbtfCzQ
	RPdFJhkcFdSBv+XOUrKZiSs6/cwLnjCLu2NjqUSrEMPKFPn9MfsCvxWxwgF5I3ONFkZADNo/HE+
	jQEfrfTaEuEFDQJf6omotwsMHLinzyWSnhh3bGXjGfKEdttTD3EAN26FstlAFIlRwgHdiGeRS9H
	7/rkKzwuYoppFDNnrjw+CrVAMCbmZDSv2ERw4BDX47001WTkMMhgypDYacjkPK8=
X-Google-Smtp-Source: AGHT+IGFM8Xvo2UN55UsTBkO320mepaStb5pz10Jir+u7mWjTOBuxTEy2kBpib0AZ9LWVKswMmg+FQ==
X-Received: by 2002:a17:902:f548:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23641a8ab3cmr19101185ad.6.1749618525494;
        Tue, 10 Jun 2025 22:08:45 -0700 (PDT)
Received: from gmail.com ([98.97.39.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b21393d7sm447552a91.37.2025.06.10.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:08:45 -0700 (PDT)
Date: Tue, 10 Jun 2025 22:08:33 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <isolodrai@meta.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test to cover ktls
 with bpf_msg_pop_data
Message-ID: <20250611050833.lhyymoung6rpo5zo@gmail.com>
References: <20250609020910.397930-1-jiayuan.chen@linux.dev>
 <20250609020910.397930-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609020910.397930-3-jiayuan.chen@linux.dev>

On 2025-06-09 10:08:53, Jiayuan Chen wrote:
> The selftest can reproduce an issue where using bpf_msg_pop_data() in
> ktls causes errors on the receiving end.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>  .../selftests/bpf/prog_tests/sockmap_ktls.c   | 91 +++++++++++++++++++
>  .../selftests/bpf/progs/test_sockmap_ktls.c   |  4 +
>  2 files changed, 95 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> index b6c471da5c28..b87e7f39e15a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> @@ -314,6 +314,95 @@ static void test_sockmap_ktls_tx_no_buf(int family, int sotype, bool push)
>  	test_sockmap_ktls__destroy(skel);
>  }
>  
> +static void test_sockmap_ktls_tx_pop(int family, int sotype)
> +{
> +	char msg[37] = "0123456789abcdefghijklmnopqrstuvwxyz\0";
> +	int c = 0, p = 0, one = 1, sent, recvd;
> +	struct test_sockmap_ktls *skel;
> +	int prog_fd, map_fd;
> +	char rcv[50] = {0};
> +	int err;
> +	int i, m, r;
> +
> +	skel = test_sockmap_ktls__open_and_load();
> +	if (!ASSERT_TRUE(skel, "open ktls skel"))
> +		return;
> +
> +	err = create_pair(family, sotype, &c, &p);
> +	if (!ASSERT_OK(err, "create_pair()"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
> +	map_fd = bpf_map__fd(skel->maps.sock_map);
> +
> +	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
> +		goto out;
> +
> +	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
> +		goto out;
> +
> +	err = init_ktls_pairs(c, p);
> +	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
> +		goto out;
> +
> +	struct {
> +		int	pop_start;
> +		int	pop_len;
> +	} pop_policy[] = {
> +		/* trim the start */
> +		{0, 2},
> +		{0, 10},
> +		{1, 2},
> +		{1, 10},
> +		/* trim the end */
> +		{35, 2},
> +		/* New entries should be added before this line */
> +		{-1, -1},
> +	};
> +
> +	i = 0;
> +	while (pop_policy[i].pop_start >= 0) {
> +		skel->bss->pop_start = pop_policy[i].pop_start;
> +		skel->bss->pop_end =  pop_policy[i].pop_len;
> +
> +		sent = send(c, msg, sizeof(msg), 0);
> +		if (!ASSERT_EQ(sent, sizeof(msg), "send(msg)"))
> +			goto out;

Its possible this could actually not send 38B (sent < 38), but then again
it is only 38B so I guess it should never fail? Anyways we have this
case in a few places already I think and its not tripping CI so lets go
for it.

Thanks,
John

> +
> +		recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
> +		if (!ASSERT_EQ(recvd, sizeof(msg) - pop_policy[i].pop_len, "pop len mismatch"))
> +			goto out;

