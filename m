Return-Path: <linux-kselftest+bounces-24916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D9A18DF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605ED3A9B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2A21018A;
	Wed, 22 Jan 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FKkCOGRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D71F7569;
	Wed, 22 Jan 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536312; cv=none; b=Tg+WcoW1U8hpwlGJUcqFMxzYlg1R2avqZcW/xBHOZu8s6VVqzvqFS0Wkr3F+yi54iS5LoKrs7J6sA+6jM8jywCJ3Ea+ZTHsu4LF41MJyEFmDuGqGdQjn1u+gzaspgNsstYLchwkCytMTyL5EtT1TGUtxinxkUR5c6spaxGXz/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536312; c=relaxed/simple;
	bh=siYRE1nFcu9/Tpmus2K/lGpGkfvZ4aZvpuRcNTB8f5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npRitBn8cg1iRrmYtUpDlSC0lHc7l2RKtG2scPrWtjSDMJp6K7pSFcWbdZLaM8nk27qhweTNVjYXaFcGSx87M+tzO21Jh5Z7cnkvawhTsutuaDdZuPR5WS3rQbw1d8gaWhqRP7DcH5CttrXOba8UXqK9PWCWlHbtyu2zqknUwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FKkCOGRs; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fdH99S8aSABLTDlS78RW75OrnD7RF2jsBZ3DmY1uhSo=;
	b=FKkCOGRs601uN/TOJ1AlyVi3CR2MM295h5qC83D1Sto6LVKghpUW8kVg91xZFH
	nDRlWK+DrpitF05vRUygyceYoTsLiShNX5C6z5JNzR5UBhwWgGf1sBX1N7UqzV1v
	kz0GJXF09Q9dQ9T6IM4nZeiOTC0ouaqFzT4PjQXbVTR6M=
Received: from iZ0xi1olgj2q723wq4k6skZ (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD314ZmspBnkxRVHw--.35771S2;
	Wed, 22 Jan 2025 16:55:12 +0800 (CST)
Date: Wed, 22 Jan 2025 16:55:01 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	martin.lau@linux.dev, ast@kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	song@kernel.org, andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, 
	daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org, corbet@lwn.net, 
	eddyz87@gmail.com, cong.wang@bytedance.com, shuah@kernel.org, mykolal@fb.com, 
	jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 2/5] bpf: fix wrong copied_seq calculation
Message-ID: <cwd4ezi6lnvbdiqtzwvfzayzvziu7xibobmdgqirbhuhlgzdv6@vsbxhyqa44ko>
References: <20250121050707.55523-1-mrpre@163.com>
 <20250121050707.55523-3-mrpre@163.com>
 <875xm8i729.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xm8i729.fsf@cloudflare.com>
X-CM-TRANSID:_____wD314ZmspBnkxRVHw--.35771S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw48CrW8ZrWfWF1UAF47Arb_yoW8JFWDpF
	ykAayrWFnrtFyxAw1DJ3y2gF1Fq3yftay5Xrn5Way2vw42krna9rWkKa4fAFWkGFWrZr4j
	vw4UXrW2qan8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnNVgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwHcp2eQsMso1gAAsH

On Tue, Jan 21, 2025 at 03:18:38PM +0100, Jakub Sitnicki wrote:
> On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > the update logic for 'sk->copied_seq' was moved to
> > tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> >
> > It works for a single stream_verdict scenario, as it also modified
> > 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> > to remove updating 'sk->copied_seq'.
> >
> > However, for programs where both stream_parser and stream_verdict are
> > active(strparser purpose), tcp_read_sock() was used instead of
> 
> Nit: missing space, "active (strparser purpose)"
>             ^
> 
> > tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> 
> Nit: missing period, "… (sk_data_ready->strp_data_ready->tcp_read_sock)."
>                                                                        ^
> 
> > tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> 
> Nit: grammar "still updates"
>                           ^
> Please run commit descriptions through a language tool or an LLM, if
> possible. This makes reviewing easier.
> 
Thanks Jakub, I'll review all commit messages and code comments, and also
use LLLM for grammar checks.


