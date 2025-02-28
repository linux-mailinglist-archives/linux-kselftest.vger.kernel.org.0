Return-Path: <linux-kselftest+bounces-27825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E4A49083
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D975E16FBEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 04:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384ED1ADC90;
	Fri, 28 Feb 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eKYmVEq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F621AAA1C
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718280; cv=none; b=P3Xd+nTD5YSCR3emO9fH7kFCZnvqTTJQRU/S/gYaDKOhomAWAcWKQgggQkrrlRXKa1gIvFWjZcXZ2gbgYvWcOMBMka2i7CCBoJqbHmNQG0L9w0INAUxsx5P/YW16o0TUEFjBNELXAjKMR2tn4V/XnAG8OiB4nmU5ZyFrDp70X0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718280; c=relaxed/simple;
	bh=8wEC3sYDvg/ub3MII5hZZLZWi6vLSVcgw4lWHZLZvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUhlU01Qd4YrK7BPqglpDUJnbJp10C4yWx/c5hM+qc/JdEiUDHkajhhwhwyQEu3egtzubMrNqiJEXauKMoQwKKyzWeZ05af+JEdQ1pP4ilMVxt3Tp3CRXuo3PyOiJeVvvEeSZebBHYDfO9yTtIbZpTgutNP6hNsRlIgHQJpBpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eKYmVEq0; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 12:51:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740718276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94l47F8q324/JvAzdYU8Pjz5XDHyxNq8wYlgc1f69W8=;
	b=eKYmVEq071Zwja6pD6XKmT7Qv1ggbAtNS2XueJi41Re8DbFcALpLh28tV/ad+Rx2HKZQ1n
	9jE73ZAQwkr1GQkZVrSMHcfDFy1VmZoi6Z/9lO96R+pmQxnFimN67+uVuW2XtIpdCoPKDX
	P8+mbLKaYioQl/apXTkDIlZlTUH8sFc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, 
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co, 
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mrpre@163.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add socketpair to
 create_pair to support unix socket
Message-ID: <tyq6qbwxvsiow5kdem5rgg5pxgvvzfreqlyfac25lqsvep4ytn@tmncdaawn6ul>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-3-jiayuan.chen@linux.dev>
 <Z8DCZO8n39avsvnF@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DCZO8n39avsvnF@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 11:52:04AM -0800, Cong Wang wrote:
> On Wed, Feb 26, 2025 at 09:22:41PM +0800, Jiayuan Chen wrote:
> > Current wrapper function create_pair() is used to create a pair of
> > connected links and returns two fds, but it does not support unix sockets.
> > 
> > Here we introduce socketpair() into create_pair(), which supports creating
> > a pair of unix sockets, since the semantics of the two are the same.
> 
> Since it is only for UDS and only has effectively 1 line of code, how
> about just calling socketpair(AF_UNIX) in your patch 3/3?
> 
> Thanks!
Thanks, Cong, I'll expand selftest to cover TCP and UDP, looks like I
missed doing those.

