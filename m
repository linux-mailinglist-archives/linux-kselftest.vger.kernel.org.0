Return-Path: <linux-kselftest+bounces-39345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A40B2D13F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 03:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D5A165680
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044119E967;
	Wed, 20 Aug 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AilW9h5q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369B2C859;
	Wed, 20 Aug 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652498; cv=none; b=L2bcXa6ZunsGlX5ygXN1lANAQm49DD9nIqkvM2/M+99ow0kFzX7ns4eaMahwEjyd6i/PwVH3qMQc0XQGH3/zYbzD+BHFszZAIBqDxT1KEjhdUG0GAdb3uZygdetvbmBliaeb8SNlGHDorwCjwYu9Nn1XQC86mAsq1xkZYCwHb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652498; c=relaxed/simple;
	bh=5t/TWMyyEg5e/pboal9kLFg0WvKE3DQCddeRi+XJlLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7a6LeeOG7yFry48Gbyb+h1HRedsuBZC4DKEiHe4gtWSC3rZHgtQW1jmRVWJbgMaHblFgScoNAG4ITXgScn1L0nCivUNAcShPDVefBXPfIVFfQRhNfpDqJU1lQddIC9F4aUZQOqCLVkN8EPUz8SN2B7B+Atxm+VKMvi5E2/i59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AilW9h5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAD0C4CEF1;
	Wed, 20 Aug 2025 01:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652497;
	bh=5t/TWMyyEg5e/pboal9kLFg0WvKE3DQCddeRi+XJlLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AilW9h5qV17dgD929wDVEGquXXr4gc5mXzoKUiAbbaTmPfPbl3JQtZWpzMJdjFkOn
	 frm8SOoOi8iEmlLyGOOtDgYBz2HOXfUuRusOjjtb1V4+k+YltAbm4ATm2f7mv+JnLi
	 C9WHNnWe2srLmncEk2gFTkHSNKZ17KoiDzcKz9meT7fCSDfEYNDOPZs+cRSzE/yMC6
	 1j0blJ6ayfhsukDi4LisutAuMjYX9MJb7Jjw40ugtCOzaG2Ppbu80sP08FFePlEe0o
	 +UWw53njNaBhukZ76liPpNCPMKjFrN9Wi212Cw2hlf68neuK+qaBgKV6cpLLjlNK0G
	 TiF9/e4WenUFQ==
Date: Tue, 19 Aug 2025 15:14:56 -1000
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
Message-ID: <aKUhkIdCEsIqmvvV@slm.duckdns.org>
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
 <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>

Hello,

On Wed, Aug 20, 2025 at 12:31:01AM +0100, Djalal Harouni wrote:
...
> Approach 1:
> First RFC months ago was something like that "bpf_task_freeze_cgroup" [1],
> can make it bpf_cgroup_freeze() as a proper kfunc, so resurrect approach 1?

Thanks for reminding me. I often feel like my memory is a ring buffer which
lasts a few weeks at most.

> Internally it used an ugly path to workaround kernfs active reference since
> we don't hold a kernfs_open_file coming from userspace
> kernfs->write path.
> 
> I can improve it, but let's discuss please approach (2) since you
> suggested it ;-)
> 
> Approach 2:
> Per the old suggestions from you and Alexei [2] [3] you wanted something
> like:
> 
>   s32 bpf_kernfs_knob_write(struct kernfs_node *dir,
>                             const char *knob, char *buf);
> 
> I didn't make it generic for kernfs, since don't know yet about sysfs use
> cases and named it "bpf_cgroup_write_interface" to focus on cgroup base
> interfaces.
> Doing something that generic now including sysfs without a proper valid use
> cases seems a bit too much. Also we have some cgroup kfunc to acquire and
> release that integrate well, so I kept it focused.
> 
> Alexei suggested to refactor the cgroup_base_file[] [4][5] to take
> "kernfs_node" as argument instead of "kernfs_open_file", which will open
> other possibilities for BPF.
> 
> However, instead of going full change on cgroup_base_files[], I added a
> minimalist: cgroup_kn_cftype kn_cfts[] that for now hold only
> "cgroup.freeze".

I think there's some misunderstanding here. IIUC, Alexei didn't want to
expose direct file interface because none of the necessary abstractions are
available and the effort becomes too big and wide. However, I don't think
the suggestion to use @kn as the path designator (or @cgroup for that
matter) means that we want to pipe that all the way down to each op that's
to be written to. That'd be rather pointless - why add generic interface if
each needs a dedicated backend anyway? Can't you make kernfs to create
open_file from kn and follow the usual write path?

Thanks.

-- 
tejun

