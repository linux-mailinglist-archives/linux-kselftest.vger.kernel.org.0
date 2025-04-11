Return-Path: <linux-kselftest+bounces-30607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17304A860B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21A94656F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A61F3BAA;
	Fri, 11 Apr 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pcj7niJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5E45948;
	Fri, 11 Apr 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382027; cv=none; b=e4qKsjNrfkVzLH4KQ9NF4tg8WVp3Uu/YpwQyHstnw8LBU7Yh4K21DEyVlTpINCk6Jfhv8ni+xjtOOPq6LZz/59eKVNTG7jfMVHfKnUepWfEv2GEhwUEpUwYZhT5l+eMp5Vw2HP2OPSfGHBk216gg6iRrEcQAcuXZ2PhuFCjURpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382027; c=relaxed/simple;
	bh=oVuRtuSjG5JGh6JU+d825kCCzZGN6r/zZRQW1ttQVdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5yBdJvx9lqhlPBxaHiYEkQhjpl09ijG3IKaeMf9jknfta8NWuSZgHgB1crxHlfr78F0fVQJBoQz9b1KCPLZb+qreU4Oj/vhC5BcJqGhNSUCpQB1UjNIlSh1lcaB8EmbWfxV7iuP1uZHqsDdJOZSmh3DLMRSeIaUTDl/PT3Se30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pcj7niJK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ItP1aVb1e+h9azvx3WYwQtH0ZEUzn4mgScjro0lkdMU=;
	b=pcj7niJKjKWu9W5yhl0cVbt1ENSSl//cUrActJg0c539Uvm/1E21WWyHnVFheF
	ItMczQoOy6DKtOl6/D74wxp0xrsBUnjnYAeuIDgvoCd911ec6jh2LDPCPF5EpODu
	vI1htwPdi7cQYHE2+2M6S3+bwdMwe7gAbPWqFmMpnWheM=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHg23NJ_lnU8isFg--.61454S2;
	Fri, 11 Apr 2025 22:31:44 +0800 (CST)
Date: Fri, 11 Apr 2025 22:31:41 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add selftest for
 sockmap/hashmap redirection
Message-ID: <ghhz3pi3oh3rylyd5t6gfa3x7m35q4ei5liwytmcbfit4r4pit@4al5vrpx7exl>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
 <20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
X-CM-TRANSID:_____wCHg23NJ_lnU8isFg--.61454S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF43Ar45KrWUWF1DCrW8Xrb_yoW8Xr45pa
	40gFZ7GFWSq3W5XryYqws2grZrZw1FvrWDX343GrW3Jw1q9r9rWrn5GFWYyr4fAFnxCr17
	XFn5CF47K3s29F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiNV9UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiOhwsp2f5JzcV7gAAsY

On Fri, Apr 11, 2025 at 01:32:41PM +0200, Michal Luczaj wrote:
> +static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,
> +				 int sd_in, int sd_out, int sd_recv,
> +				 struct maps *maps, int status)
> +{
> +	unsigned int drop, pass;
> +	char *send_buf = "ab";
> +	char recv_buf = '\0';
> +	ssize_t n, len = 1;
> +	/* Zero out the verdict map */
> +	if (xbpf_map_update_elem(maps->verd, &u32(SK_DROP), &u32(0), BPF_ANY) ||
> +	    xbpf_map_update_elem(maps->verd, &u32(SK_PASS), &u32(0), BPF_ANY))
> +		return;
> +
> +	if (xbpf_map_update_elem(maps->in, &u32(0), &u64(sd_in), BPF_NOEXIST))
> +		return;
> +
> +	if (xbpf_map_update_elem(maps->out, &u32(0), &u64(sd_out), BPF_NOEXIST))
> +		goto del_in;
> +
> +	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
> +	if (send_flags & MSG_OOB)
> +		len++;
> +	n = send(sd_send, send_buf, len, send_flags);
> +	if (n >= 0 && n < len)
> +		FAIL("incomplete send");
> +	if (n < 0) {
> +		/* sk_msg redirect combo not supported? */
> +		if (status & SUPPORTED || errno != EACCES)
> +			FAIL_ERRNO("send");
> +		goto out;
> +	}
> +
> +	if (!(status & SUPPORTED)) {
> +		handle_unsupported(sd_send, sd_peer, sd_in, sd_out, sd_recv,
> +				   maps->verd, status);
> +		goto out;
> +	}
> +
> +	errno = 0;
> +	n = recv_timeout(sd_recv, &recv_buf, 1, 0, IO_TIMEOUT_SEC);
> +	if (n != 1) {
> +		FAIL_ERRNO("recv_timeout()");
> +		goto out;
> +	}
I prefer multiple send and receive operations, or implementing a loop at
the outer level.

Thanks.


