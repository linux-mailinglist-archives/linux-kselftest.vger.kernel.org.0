Return-Path: <linux-kselftest+bounces-5366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B87861CC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B75DB239B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533D1448F3;
	Fri, 23 Feb 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojtNWE2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE512A16D;
	Fri, 23 Feb 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717379; cv=none; b=uTgsfnr9+p0ZFG6FGojDrO3PwGiI3yZSIFJDWsSjMmklnbfSyqCCBbGogSXfV//5JBJljbKBcWSnSdM85hRiKESsiu5xkKmdAJSIsupH90qhadLiIpbe71e2r/bQU/LwZkrlkucUItPtXXH/78Ppm/BjMK4y3x8hIY1wzqRNBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717379; c=relaxed/simple;
	bh=Ipxh6K6T10/ohVhxiV2SK9ec9fDPFVvmnOAmFP8wfZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbaPxTAZVzVq/FjCxijguysk489d2E+e0ecANFJ+edVEfIni3bi+lgGO/QhuH775QrowB2pU6P9OXdZv4V8usupED26huVq5lM8IlWNFR7NfkPEXKbW4CVPJyWNb/gBmW5BdFqbCykpflzkVpZLYW5Qpm5KcyRWVf5BIEboFHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojtNWE2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC6AC433F1;
	Fri, 23 Feb 2024 19:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717379;
	bh=Ipxh6K6T10/ohVhxiV2SK9ec9fDPFVvmnOAmFP8wfZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojtNWE2wdRFt+1j/swp6GIN84oNoqsmVHCqt8kAJcr1X0psbceKeigwliGHV/E+4v
	 t87KvjNjrMHBvCqnWHMdMNBXi81BcTJpLS7pHfMybYNDl17vsV7MSzaBijxnQf6m7n
	 GJ4oyk/gugH1jkxTOeaO+y/ncw9eOMFjN4Q09m90jnonyYOPlb7KtCISkvUnrzGUm7
	 SJKLpMcdbUlaavhb6A0JruxKOXUjroun5IJsVkDXm5cYMcOCoSNFoJX7E8DGUAgI8n
	 OTv2hVS0IXdDOOg6ujyzPvgo2uL61TaUezvNiOQxeY5Lt1O9wsmlMZADEyNmtHgTBO
	 0+nNvHTKTDaNA==
Date: Fri, 23 Feb 2024 20:42:51 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v3 00/16] sleepable bpf_timer (was: allow
 HID-BPF to do device IOs)
Message-ID: <jtbgxp72kov3m3nxmtrcyfj4k2vediypuykkfdpnlm2tviys7h@brzusbk6pyku>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <e95cebb8f6a7ede5d40b4becf58cb578a5c4cf58.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95cebb8f6a7ede5d40b4becf58cb578a5c4cf58.camel@gmail.com>

Hi,

On Feb 23 2024, Eduard Zingerman wrote:
> On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:
> > [Partly a RFC/formal submission: there are still FIXMEs in the code]
> > [Also using bpf-next as the base tree for HID changes as there will
> > be conflicting changes otherwise, so I'm personaly fine for the HID
> > commits to go through bpf-next]
> 
> [...]
> 
> Could you please also add verifier selftests, e.g. extend
> tools/testing/selftests/bpf/progs/timer.c       (bpf side)
> tools/testing/selftests/bpf/prog_tests/timer.c  (userspace side triggering
>                                                  bpf side)
> Negative tests could be added in
> tools/testing/selftests/bpf/progs/timer_failure.c
> 
> Please let me know if you need any help setting up local BPF test
> environment, I have a short writeup on how to set it up in chroot.

Thanks a lot for your review (and Alexei's). I was actually off today
and will be off next Monday too, but I'll work on those tests next week.

Cheers,
Benjamin

