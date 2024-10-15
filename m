Return-Path: <linux-kselftest+bounces-19741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F499F117
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D77A1F21DD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AE1B393A;
	Tue, 15 Oct 2024 15:25:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410821B2181;
	Tue, 15 Oct 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005950; cv=none; b=HlbgbYMKFFiP3CwadIoajaBM+pKkHNGsPt2jdyVfoo6IHkfkzO46USq8bIgaya7zfjB/mNTPt8RgELlhL9K0O2dm4H4URz/3xHkF1TfDyAtth3Empr8IBZE1ujoLLnyPApUoGHNG4Vcri4OYj1uLruOPcFpL5TN+cZj13TShm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005950; c=relaxed/simple;
	bh=18FzEMnBgSIbTxs/2tPjdrl1WVdNoL/WjTV3lxGaRPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OssepQefgUg3L+2y00zzbm/+xqSqt6+8w2OIYXGt+WyC5EFDOQlTOScORk/OytRnC1d4Y6n7kkUgaNqWoI5OY7vIJXTA+vAMbxHRg0rXiS6MVsAjQr3BYGsjm5qNprEbICgfLHRE4vKzKu4JWj2DnPlzR7xtcmH6uEqJuUe7RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t0jQI-0007LE-9k; Tue, 15 Oct 2024 17:25:22 +0200
Date: Tue, 15 Oct 2024 17:25:22 +0200
From: Florian Westphal <fw@strlen.de>
To: Tyrone Wu <wudevelops@gmail.com>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
	riel@surriel.com, shakeel.butt@linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf v1 1/2] bpf: fix link info netfilter flags to
 populate defrag flag
Message-ID: <Zw6JYuga41DyoVjt@strlen.de>
References: <20241011193252.178997-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011193252.178997-1-wudevelops@gmail.com>

Tyrone Wu <wudevelops@gmail.com> wrote:
> This patch correctly populates the `bpf_link_info.netfilter.flags` field
> when user passes the `BPF_F_NETFILTER_IP_DEFRAG` flag.

Indeed, thanks for fixing this.
Patch and testcase look good, but one nit:

> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")

BPF_F_NETFILTER_IP_DEFRAG flag was added in
91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link"), that was a bit later than the initial support.

Other than that,
Acked-by: Florian Westphal <fw@strlen.de>


