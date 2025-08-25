Return-Path: <linux-kselftest+bounces-39877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B07B34A9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF15B16F753
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A59022E004;
	Mon, 25 Aug 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMDFxZLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44D273F9;
	Mon, 25 Aug 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147732; cv=none; b=htgK7ZYBTp7IqpagTNNgMUhsBdV6mztmv1LjAxJnTQSetjS0Ixv3sb9k/7lfgdY9E1r5pQkdBqAGj3ggox5FNaFazxpcFP6OTmyY7/rHapvINwiiYnURb9IMPRSNqbxZYTUsQ9L2FZGKWQXlRfbH7KXdZ3HNIqXr2eDfjoREo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147732; c=relaxed/simple;
	bh=v08zx3D26Sp+X33A1zp2Q53wg3vBvAQH+zN59dmrcAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNVmy2c40uuOcnYm6xv4FySosE/u3GgrASQSIRydTi6SF8Djt0nWe54gSKuUXiuBoO1R9+Ohn2PHW31nzlyp6Ql2hqvkY5b1gskaYL+bbTcD4Q/Jp6qaOOrYSN00CYcPCrmH3aPU8aaEXUwsen9YrmTtxw0Y4qPGkDau/NPscvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMDFxZLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8827C4CEED;
	Mon, 25 Aug 2025 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756147732;
	bh=v08zx3D26Sp+X33A1zp2Q53wg3vBvAQH+zN59dmrcAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMDFxZLF0Om8aJ6hZWmJAmqg71U1P1gaGpmbgwq4vy7rdEvsRPexNAUDC73Lo/ZOm
	 AUqvsZp3Gpg8ldgBOMu/K0Z/djHMuT6JEWC4KmfGH3dK6INQKPdieEXl5KgKULafIx
	 eoYgHiWNMVdiaMM88G0DMJJFI8I4QQP+bmE79vTECR02Tq0y27iHnEMKJe7fDoESfm
	 lmEfsl3pQPwESqyQeflQ92jFa5rYK0s7X9ecw4hBAnE+G6WjiGlxG9XLN5IF06GmtH
	 DOGFhSQHC8rGrkhfkQNWW1umknDcO7m2d5EYMk0ibUQUzCHY7WPIAzbE6da3R+AieM
	 nywUhKG8a7QrA==
Date: Mon, 25 Aug 2025 08:48:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, tixxdz@opendz.org
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
Message-ID: <aKywEsqVAHdgasZw@slm.duckdns.org>
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
 <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
 <aKUhkIdCEsIqmvvV@slm.duckdns.org>
 <efa7d1ed-9cfc-4e32-936c-a2f7827da1c9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa7d1ed-9cfc-4e32-936c-a2f7827da1c9@gmail.com>

Hello,

On Fri, Aug 22, 2025 at 07:16:15PM +0100, Djalal Harouni wrote:
...
> I do realize taking the same usual path with write is the obvious thing,
> but we don't have the corresponding open context, and faking it seems
> more trouble than calling directly cgroup backends...
> 
> Allow me please to do it again directly on cgroup_base_file[] assuming
> it was Alexei suggestion and see how it looks.

I'm probably missing something but what prevents you from getting a dentry
from kernfs_node and then calling vfs_open() on it and then do vfs_write()
on the returned file?

If there are some fundamental reasons that we can't do something like that,
let's go back to the simple approach where we just have bpf helpers for
freezing and unfreezing cgroups outside of fs interface.

> Also Tejun, could you please point me to extra cgroup or kernfs tests
> you run? much appreciated!

I'm afraid there isn't much outside what's in the selftest directory.

Thanks.

-- 
tejun

