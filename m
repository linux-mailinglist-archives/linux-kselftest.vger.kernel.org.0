Return-Path: <linux-kselftest+bounces-27824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4C2A49080
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842FD189304D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 04:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BA1AAA1C;
	Fri, 28 Feb 2025 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GymhFrAS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8491157487
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718219; cv=none; b=INK9ZinTXjxHoX3abH8ELzkZ7b19jOBF74PL3rihVHtEKOBebqsc7/UP12gBpMofStqmHFDJfiE2JzP10rathbPeGAKWlqj/Sf2SWuN+SKuMIwPJSI/adPzMkLJC/UfjJAc98491i/sGUH5iZX2JHUXxqydiCSbEffTvLiNoWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718219; c=relaxed/simple;
	bh=vKRGBPVxFRzASCrgNUPfeminx0NxPnVIpYw7FilDZ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQJC8wJNCw343aQW3evEn3IeGTzV75awVOKqfUV4HfH5fYjV6AsyLLbWLw1ucddpwKOApcZeoFLOJD1rBauCzFBzUWaYe0xX/G0oDwUDIrPcJq1/qAJiCfU8aukxBzqPia+8vcEaKh62BKXIeotzvdH2Ch5nsF9ZazNKi+gIaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GymhFrAS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 12:49:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740718205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOL3Sxz/lRQTI2ovRj5bAO2y5w38NS5Crps3LkHhwlc=;
	b=GymhFrASED4qRmLM1tNiylCzCa2MouSeuTDdP6Fld3rWSibc38FZuG3uklpF5smxZWL0Hc
	ICsAb9HWA8yA5ux9tgdt4qqvjms54wwaEekwTTbwlhC218MfQXlBw1v6BA3XlO/5E4C5Rb
	hkDAQ8Px+/fEXaG4xiPleMG90mJfQRk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, 
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co, sgarzare@redhat.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mrpre@163.com, 
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: avoid using sk_socket
 after free
Message-ID: <4jsnhbf2sjzdwdg6i3nzdp7skpcdpuujxr2ggt5dcaqwufh3bf@urvrkhaulgsy>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-2-jiayuan.chen@linux.dev>
 <84f25c32-1aa6-42d6-a5b1-efce822bfcd6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f25c32-1aa6-42d6-a5b1-efce822bfcd6@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 03:04:26PM -0800, Martin KaFai Lau wrote:
> On 2/26/25 5:22 AM, Jiayuan Chen wrote:
> > Use RCU lock to protect sk_socket, preventing concurrent close and release
> > by another thread.
> > 
> > Because TCP/UDP are already within a relatively large critical section:
> > '''
> > ip_local_deliver_finish
> >    rcu_read_lock
> >    ip_protocol_deliver_rcu
> >        tcp_rcv/udp_rcv
> >    rcu_read_unlock
> > '''
> > 
> > Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
> > will not increase performance overhead.
> 
> Can it use a Fixes tag?
Thanks, Martin.
It seems that this issue has existed since sockmap supported unix.
I'll find the corresponding commit as the Fixes tag.

