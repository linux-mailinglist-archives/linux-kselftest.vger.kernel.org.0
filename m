Return-Path: <linux-kselftest+bounces-27523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B9A44A69
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B461166BA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460B19992E;
	Tue, 25 Feb 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfJVHpLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914EB175D48;
	Tue, 25 Feb 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508336; cv=none; b=EQe4ii4S92F/GF5B4UQN8y+bKHaGKMw75hZvJNlOupntFLBcfNqKameqz465vUnmldY3/707GeJQPxqb5Axx2qiDwtk6t27xhC6sqbZLt1FopkGeyZyUbxMKmMhvJ21wWh6yXzFF5yzfxbivn2Z6nMCOpF1rySU7yTW5cnX0knA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508336; c=relaxed/simple;
	bh=+JSp6BTA+na2BBn9CPIci4yO+hxoHfXFFz4+MWlE2/A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kq5/RWtior9GFqMe35b5KrNNrXgx5w1X/Ol1W27nFjH5yNsfArDytxFwFPiOFSGZFlK1oh54yY4gzxvfIGrDXnuYDSi7cl/N62peCQGU7j92ETob79hYYFQzMhmaMqJuADjnl6Rg42llqd0ZQnMAUVb2U4WpbQDrhX9XgsLWpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfJVHpLi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471eb0e3536so91225001cf.3;
        Tue, 25 Feb 2025 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508333; x=1741113133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63uJQvQe+hDvZXNHbI7QfseYYOBrcAOSlBnJOHPI2HY=;
        b=YfJVHpLiIdlSBezq5G9Q3qmG1j4YzWgiVymjZYQcB1FrU13OwkX6vBWT+jFL0myOff
         HB2EqaLhpfejh8CQxNYfrZZXY06nj/AjfGsayIZS992ZfCpU08862fux62bCs6Q9ALTx
         a96J5t5bxA/TCwLekG0iZ0FdJe9LlFf+m3xpp1tp3vXPf/du+DxvRAtx+akxi8kXrJye
         IE0SGOV99W26ErbaMUQ29vUiCmVXbm0QDJIx0TLuYSzJO08ztk6DiuVJpsOcAgoMHRST
         WICcDmvO1WRCA89n15Uu7vriHab82yETkqMlefQi1MhKiPamxRPP8oJ1GxCBp5v7FQmI
         uZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508333; x=1741113133;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=63uJQvQe+hDvZXNHbI7QfseYYOBrcAOSlBnJOHPI2HY=;
        b=qcAR2fVFh1XYpLf9yBtSGK+nNMHphgXCh5KpGe8SxIc7JQj9yiT003wUGfAl0dFO0f
         zSzvL+bahFgGMhQ4CeS/0NJrGzGRMq74s+Jo6lG/V8neTSCTMOaxs3boA92Bgqg6gbm3
         yOlklhZsp9d4a9zHBjb3AgVKmTJa5DkBy05pemTQympFZlCmhpaA4Af7aDBz4fLxkwlh
         new7hOjm0SVR1e0EHz4Tkt+tZf/w9qbe6/A7Jm2CiATL4CwVX8W2o8kuHxnxKTq4X938
         cN+mslyxPzt8PoTLYq3xblTpLXTXoB/1zPak7qTHHypKs8XGxmOXqmqPSeLtqoMEgJd1
         iVhg==
X-Forwarded-Encrypted: i=1; AJvYcCVhRaCo2flZ4LR/31REYa2Ssv7AiFaBZ/ltAIRRNhSrXwN1AaYoV1VvnTzrN6lLo6Q1fSc=@vger.kernel.org, AJvYcCX4XUBshHkeb6/qe08R52ZXW7SH5U6P6z4Q62aP7+7GpZ2H+erGMq54Gu2dbjZ9qKYheZ6S/O3YDJAa/9h7@vger.kernel.org, AJvYcCXVBhIDPl+jkuEZ4XVg+QfN1n0HP8NcmeTVs3+s4cqbQ9JftLSWLxmgSOvGxeD09vlA0DONfCEbLMdOezhv09ge@vger.kernel.org, AJvYcCXstwp1bqoas6E9Oo4L++f1nO5PBLVdEQP0FmwR0ss4aa1o92KVwIINsTlEuEpTKGk2qS9BUDoY@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtKVDLlQ0fK+ytVtbOshjoHOoIJvLbr0NT5+826BRzLhYe3U0
	WaLrx+rsFXp/XBiJf8fHOTPis4kkrNIApjueNW9umGtk1eL+5Pjk
X-Gm-Gg: ASbGncvF0zL0rSetsYl9uo49K/vg35G0CRntLvhOKN1/t1zz73O706EbNvU/aitj5JY
	oGhYGUgKIsn1GAZdKxVhi7QEdF15kLW7qm1S2q3toNrDAKw4nGuVjtz3gPC3wxgcDFDemxUidYy
	2ktlFBMuAUE1eiOwGe1ordOgie8CVbRsYeeKIVJKOEW1nEuhy0X5PD6AC4E3hciHu3JQL3NSbjL
	/cizg9cjPSeiWnkYzHDT02l4Ls/+CoUgHtZ8ztE8qCAjYMi1ybkWHzsDBFPM4lvcasbRhI0y2E2
	TxXn3pP6xV083gIq5p3ML+PTJC3Wo7mMUkoZJ98TmvmRdYRimlwvRW+9a1cKYlpjECt7azXcxiT
	rEW4=
X-Google-Smtp-Source: AGHT+IFOGSvEuwSnTShQdt/q/uu3dYjsGyDVUzX9dnU5cHlvFmJRwpR5EL3MvD9rt5HIn6GEz+geOw==
X-Received: by 2002:a05:622a:148c:b0:472:afc:411d with SMTP id d75a77b69052e-4737725cce3mr68473281cf.41.1740508333258;
        Tue, 25 Feb 2025 10:32:13 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e23719sm13251511cf.45.2025.02.25.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:32:12 -0800 (PST)
Date: Tue, 25 Feb 2025 13:32:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67be0cac4d366_25ccfc294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: refactor
 xdp_context_functional test and bpf program
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> The existing XDP metadata test works by creating a veth pair and
> attaching XDP & TC programs that drop the packet when the condition of
> the test isn't fulfilled. The test then pings through the veth pair and
> succeeds when the ping comes through.
> 
> While this test works great for a veth pair, it is hard to replicate for
> tap devices to test the XDP metadata support of them. A similar test for
> the tun driver would either involve logic to reply to the ping request,
> or would have to capture the packet to check if it was dropped or not.
> 
> To make the testing of other drivers easier while still maximizing code
> reuse, this commit refactors the existing xdp_context_functional test to
> use a test_result map. Instead of conditionally passing or dropping the
> packet, the TC program is changed to copy the received metadata into the
> value of that single-entry array map. Tests can then verify that the map
> value matches the expectation.
> 
> This testing logic is easy to adapt to other network drivers as the only
> remaining requirement is that there is some way to send a custom
> Ethernet packet through it that triggers the XDP & TC programs.
> 
> The payload of the Ethernet packet is used as the test data that is
> expected to be passed as metadata from the XDP to the TC program and
> written to the map. It has a fixed size of 32 bytes which is a
> reasonalbe size that should be supported by both drivers. Additional
> packet headers are not necessary for the test and were therefore skipped
> to keep the testing code short.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

> -	SYS(close, "ip addr add " RX_ADDR "/24 dev " RX_NAME);

Why remove the Rx and Tx addresses?

> +	/* By default, Linux sends IPv6 multicast listener reports which
> +	 * interfere with this test. Set the IFF_NOARP flag to ensure
> +	 * silence on the interface.
> +	 */
> +	SYS(close, "ip link set dev " RX_NAME " arp off");
>  	SYS(close, "ip link set dev " RX_NAME " up");
>  
>  	skel = test_xdp_meta__open_and_load();
> @@ -154,21 +215,12 @@ void test_xdp_context_functional(void)
>  	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
>  		goto close;
>  
> -	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
> -	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
> -		goto close;
> -
> -	tc_opts.prog_fd = bpf_program__fd(tc_prog);
> +	tc_opts.prog_fd = bpf_program__fd(skel->progs.ing_cls);

This refactor seems irrelevant to the goal of this patch? Same below.
>  	ret = bpf_tc_attach(&tc_hook, &tc_opts);
>  	if (!ASSERT_OK(ret, "bpf_tc_attach"))
>  		goto close;
>  
> -	xdp_prog = bpf_object__find_program_by_name(skel->obj, "ing_xdp");
> -	if (!ASSERT_OK_PTR(xdp_prog, "open ing_xdp prog"))
> -		goto close;
> -
> -	ret = bpf_xdp_attach(rx_ifindex,
> -			     bpf_program__fd(xdp_prog),
> +	ret = bpf_xdp_attach(rx_ifindex, bpf_program__fd(skel->progs.ing_xdp),
>  			     0, NULL);
>  	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
>  		goto close;
> @@ -179,9 +231,18 @@ void test_xdp_context_functional(void)
>  	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
>  		goto close;
>  
> -	SYS(close, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
> +	SYS(close, "ip link set dev " TX_NAME " arp off");
>  	SYS(close, "ip link set dev " TX_NAME " up");

>  SEC("tc")
>  int ing_cls(struct __sk_buff *ctx)
>  {
> -	__u8 *data, *data_meta, *data_end;
> -	__u32 diff = 0;
> +	void *data_meta = (void *)(unsigned long)ctx->data_meta;
> +	void *data = (void *)(unsigned long)ctx->data;
>  
> -	data_meta = ctx_ptr(ctx, data_meta);
> -	data_end  = ctx_ptr(ctx, data_end);
> -	data      = ctx_ptr(ctx, data);

Similarly: why these changes?

In general, please minimize your patch to the core purpose. Avoid
including "cleanups" or other such refactors. Or justify the choice
explicitly in the commit message.

> -
> -	if (data + ETH_ALEN > data_end ||
> -	    data_meta + round_up(ETH_ALEN, 4) > data)
> +	if (data_meta + META_SIZE > data)
>  		return TC_ACT_SHOT;
>  
> -	diff |= ((__u32 *)data_meta)[0] ^ ((__u32 *)data)[0];
> -	diff |= ((__u16 *)data_meta)[2] ^ ((__u16 *)data)[2];
> +	int key = 0;
> +
> +	bpf_map_update_elem(&test_result, &key, data_meta, BPF_ANY);
>  
> -	return diff ? TC_ACT_SHOT : TC_ACT_OK;
> +	return TC_ACT_SHOT;
>  }
>  
>  SEC("xdp")
>  int ing_xdp(struct xdp_md *ctx)
>  {
> -	__u8 *data, *data_meta, *data_end;
> -	int ret;
> -
> -	ret = bpf_xdp_adjust_meta(ctx, -round_up(ETH_ALEN, 4));
> +	int ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
>  	if (ret < 0)
>  		return XDP_DROP;
>  
> -	data_meta = ctx_ptr(ctx, data_meta);
> -	data_end  = ctx_ptr(ctx, data_end);
> -	data      = ctx_ptr(ctx, data);
> +	void *data_meta = (void *)(unsigned long)ctx->data_meta;
> +	void *data = (void *)(unsigned long)ctx->data;
> +	void *data_end = (void *)(unsigned long)ctx->data_end;
>  
> -	if (data + ETH_ALEN > data_end ||
> -	    data_meta + round_up(ETH_ALEN, 4) > data)
> +	void *payload = data + sizeof(struct ethhdr);
> +
> +	if (data_meta + META_SIZE > data || payload + META_SIZE > data_end)
>  		return XDP_DROP;
>  
> -	__builtin_memcpy(data_meta, data, ETH_ALEN);
> +	__builtin_memcpy(data_meta, payload, META_SIZE);
> +
>  	return XDP_PASS;
>  }
>  
> -- 
> 2.43.0
> 



