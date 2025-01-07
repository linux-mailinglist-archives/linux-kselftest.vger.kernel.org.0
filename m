Return-Path: <linux-kselftest+bounces-24007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D7A04758
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC521663C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1291F131B;
	Tue,  7 Jan 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqr7HTS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417811E25EB;
	Tue,  7 Jan 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269060; cv=none; b=QdCqvsutHk2RkYX+UQ1l1L7kkXuR5Qr3EA2XrIPgQ+pbwOIq8XP7tW01f/ZHFORfJPjAeqzeiabF35sF+Bz2rKh06N0CsJQqIC6PWDWGiHLsWBxrV6n2wAcTi1OWKa9OaLd3Odq9RadFu3dFRy7qsTXLZGMC2f0pPrbGhMC+oKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269060; c=relaxed/simple;
	bh=hhFxzSEC2Ok7atqU62+knC3ruF0vLMw09uceakv0GRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHciIEmX4pBu+2TZx9zTojL9HU+0hegCSrnLdWn34swwIFMhf7tVCCBzeoT9pFuDBFkHXAVKLYa3Y36xFA+U17I0J8euXbkStU56zoA2ZkIelx8HWbZbbq8Ojw7vdLtCkMl7YRGGM8IkCGSIUlFcz/NqaHv7P4HRssxTkevatO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqr7HTS9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216401de828so219721575ad.3;
        Tue, 07 Jan 2025 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736269057; x=1736873857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb1pOcXu31lYFeGfpMgDjeg52e6mYQb5OHgfqtIS2po=;
        b=Kqr7HTS95s8Rr6acd6bIucvT6Ugs17c+Ty787MkyU0BtaZrtMA7o5BH+K+soAe/sii
         j594D2J5y3nucKO36KyPZYaQbaXVOCMZwxzotZ5xFwJ+1J1vI8MHX1aX5YVQsH0t4vp+
         y0xzBzHPKlfKQQZIxShhHmME7Z+YiOH9vRjdnoKQ7wweMqfftWiew1ewWpAb8kiHC3Fk
         N3YLxbKRELq5unHWBqtX/7zAp9wRHt6AJkaVH9RlvEV0L3rNshOc0WokAqr+kxqseeRX
         HdQdn2eccKBrXcuBh9v9xWT6SbBnsocXc5i5XpQESwgO8a3ZBIfXpCOTkDwuW6tWqD7H
         EyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269057; x=1736873857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb1pOcXu31lYFeGfpMgDjeg52e6mYQb5OHgfqtIS2po=;
        b=lo2J4sAX/jjzeCnfpdUVlRqpQeX6EJy80Jz5jkByljza3pLk1oYyg6s9Bbv+AF68wc
         X4elT3Nbr/jvXXepVICIZh+CVT46/RoNm2UzybdOC8cfUtt/7VW6tnB3r5KTqo1Pq9aR
         o+2i+OPbQTJddZGiYH8zMOD6CaIwmzeTFesvraZLPIYpkLjjPJAq6PJPiE3Yz4lqMl68
         r5NX0LuvvSELK65uFX250yUGyZiajBGX3JkOaJrVykW6wpiu0J54w6gMIRIRcnUxRpl6
         KtX+MhjfvmwD6vB1m+xD0yjFCEOBA+GlJzNBtxoXMCMILpWQghVSXt0uKsCTbpG0gujR
         L8uw==
X-Forwarded-Encrypted: i=1; AJvYcCUShqV7IohYLNYGLzEHoLYvltjeY8wUV+sK8FRi11UKXjRLSNMMXwYZjbz/1cPR3uXcwaypiKJv@vger.kernel.org, AJvYcCX4rcD3ZNpZGhw2dcwoV/57I9i+7dgrKOeREHPYoNXgK8ksp3W4utT1RjW/ToGsFAPr/FhI+FtME+AFmrHM@vger.kernel.org, AJvYcCX8XU+0J2f3vgQf8r0M4JL7868CC4gr9NAOOWzvMb9ZsM1naD2PAY9Y0z/f3L61uaKapta12JfLefaE0YhZ09k6@vger.kernel.org, AJvYcCXQ4uTOZ3jIYvWPT5/EdLPJBhW3+n1c4+HjT+Y/ZvQDLxwjAFyNJbTpETv3Y2X13Lhkr/YhGkOowDfJ@vger.kernel.org, AJvYcCXpyw8Bz/pNJx/t3yvVc4Vlbm+CWvmki+bQbaH1wjntnWWJq3zpXkEPgcWaIq+ByWE6RFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXVHQO2Fy18TS1cLNZbZqdiGtHoKhzijN5M5Xg4WUjnBUrmzG
	ezSenUVASghzotynqQGl7GYQreY04XmXy0sMajjVuU84VqV9YBQ=
X-Gm-Gg: ASbGncs8qqAeBaw5aWA2EVKXliBQ0F4iBhBKSRkIS/Yn6S+nmxI0MkId3mkyau1HLXz
	l9fwk5xjxSGsTI7pGR5b+Bkhy8cd662Xmv1ExdwcTDtnjC3j0j5rCCt5sOGJPH9pxoZ0G5tBugM
	s9ix09Niwvhn6f87hfI1A3SSYkbIaE9hORhq/W1m1pqalx52aYvaKaO9fd21sR72Fa1bXRxjVYM
	05zZ2N1KJy3JLoJayViUcUrJ7xsYtf0CLloD9J0svtcjXTJhsbC+VzY
X-Google-Smtp-Source: AGHT+IFlhKI33ii68VDZqo5j2PH+n5VdBpF5kgNaO5PfE/xaemL0ooS2ho/W9ZBFXWggOucM2FsUEA==
X-Received: by 2002:a17:903:182:b0:216:1eb9:4a48 with SMTP id d9443c01a7336-219e6f289a0mr710448725ad.56.1736269056620;
        Tue, 07 Jan 2025 08:57:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d0asm314014085ad.53.2025.01.07.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:57:36 -0800 (PST)
Date: Tue, 7 Jan 2025 08:57:35 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Add Launch Time request
 to xdp_hw_metadata
Message-ID: <Z31c_3j9MEP7Z3bd@mini-arch>
References: <20250106135638.9719-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106135638.9719-1-yoong.siang.song@intel.com>

On 01/06, Song Yoong Siang wrote:
> Add Launch Time hw offload request to xdp_hw_metadata. User can configure
> the delta of launch time to HW RX-time by using "-l" argument. The default
> delta is 100,000,000 nanosecond.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 6f7b15d6c6ed..795c1d14e02d 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -13,6 +13,7 @@
>   * - UDP 9091 packets trigger TX reply
>   * - TX HW timestamp is requested and reported back upon completion
>   * - TX checksum is requested
> + * - TX launch time HW offload is requested for transmission
>   */
>  
>  #include <test_progs.h>
> @@ -64,6 +65,8 @@ int rxq;
>  bool skip_tx;
>  __u64 last_hw_rx_timestamp;
>  __u64 last_xdp_rx_timestamp;
> +__u64 last_launch_time;
> +__u64 launch_time_delta_to_hw_rx_timestamp = 100000000; /* 0.1 second */
>  
>  void test__fail(void) { /* for network_helpers.c */ }
>  
> @@ -298,6 +301,8 @@ static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
>  	if (meta->completion.tx_timestamp) {
>  		__u64 ref_tstamp = gettime(clock_id);
>  
> +		print_tstamp_delta("HW Launch-time", "HW TX-complete-time",
> +				   last_launch_time, meta->completion.tx_timestamp);
>  		print_tstamp_delta("HW TX-complete-time", "User TX-complete-time",
>  				   meta->completion.tx_timestamp, ref_tstamp);
>  		print_tstamp_delta("XDP RX-time", "User TX-complete-time",
> @@ -395,6 +400,14 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
>  	       xsk, ntohs(udph->check), ntohs(want_csum),
>  	       meta->request.csum_start, meta->request.csum_offset);
>  
> +	/* Set the value of launch time */
> +	meta->flags |= XDP_TXMD_FLAGS_LAUNCH_TIME;
> +	meta->request.launch_time = last_hw_rx_timestamp +
> +				    launch_time_delta_to_hw_rx_timestamp;
> +	last_launch_time = meta->request.launch_time;
> +	print_tstamp_delta("HW RX-time", "HW Launch-time", last_hw_rx_timestamp,
> +			   meta->request.launch_time);
> +
>  	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
>  	tx_desc->options |= XDP_TX_METADATA;
>  	tx_desc->len = len;
> @@ -402,10 +415,14 @@ static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
>  	xsk_ring_prod__submit(&xsk->tx, 1);
>  }
>  
> +#define SLEEP_PER_ITERATION_IN_US 10
> +#define SLEEP_PER_ITERATION_IN_NS (SLEEP_PER_ITERATION_IN_US * 1000)
> +#define MAX_ITERATION(x) (((x) / SLEEP_PER_ITERATION_IN_NS) + 500)
>  static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
>  {
>  	const struct xdp_desc *rx_desc;
>  	struct pollfd fds[rxq + 1];
> +	int max_iterations;
>  	__u64 comp_addr;
>  	__u64 addr;
>  	__u32 idx = 0;
> @@ -418,6 +435,9 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  		fds[i].revents = 0;
>  	}
>  
> +	/* Calculate max iterations to wait for transmit completion */
> +	max_iterations = MAX_ITERATION(launch_time_delta_to_hw_rx_timestamp);
> +
>  	fds[rxq].fd = server_fd;
>  	fds[rxq].events = POLLIN;
>  	fds[rxq].revents = 0;
> @@ -477,10 +497,10 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  					if (ret)
>  						printf("kick_tx ret=%d\n", ret);
>  

[..]

> -					for (int j = 0; j < 500; j++) {
> +					for (int j = 0; j < max_iterations; j++) {
>  						if (complete_tx(xsk, clock_id))
>  							break;
> -						usleep(10);
> +						usleep(SLEEP_PER_ITERATION_IN_US);

nit: instead of doing MAX_ITERATION/max_iterations, can we simplify this
to the following?

static u64 now(void)
{
	clock_gettime(...);
	return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
}

/* wait 5 seconds + cover launch time */
deadline = now() + 5 * NSEC_PER_SEC + launch_time_delta_to_hw_rx_timestamp;
while (true) {
	if (complete_tx())
		break;
	if (now() >= deadline)
		break;
	usleep(10);
}

It is a bit more readable than converting time to wait to the
iterations..

