Return-Path: <linux-kselftest+bounces-11787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A1905A6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF692847ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF2F183063;
	Wed, 12 Jun 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWUF0D7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155316E895;
	Wed, 12 Jun 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215833; cv=none; b=WPrZ7wkWwzbKnTc0ORFVCElEiBwQcs54bK2pK3HYezLHQqhdxSz8LjvBFYHhJ79XRmA8gj3AWiWNgDuC+n6XV57rUyHShKxJ17Xnc7W/LerwbXFmkMFs2iCvkf9Ywm/khxW/tYHWrqOgviEJhDRtLpQsPFIOLcGGHoGIo1P7c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215833; c=relaxed/simple;
	bh=zxGx4UHWoFeslODIvuI4YPtEigCLjSm31dy2cb55Oz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4WKtG1kg0Gc9Q2LcQ0Z1xIzyHOihsI5lZtYZnjfOgHQQW04/HcdG/bE3IAA3UoxBZ5/P2ruELUGdffvubs9WehZOHIgsM9eczE3SoMza1Ny+eIdGGMSF4VFjLHU57wWCAo0fotAdtMJacxwAKtH+k0uHDmZjFpXp4dU0RByN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWUF0D7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72475C32786;
	Wed, 12 Jun 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718215831;
	bh=zxGx4UHWoFeslODIvuI4YPtEigCLjSm31dy2cb55Oz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWUF0D7IRN5Vo2R7IFWkPtDTNF++1BL+Rgac5joXi+V6G+etTmFy8BLu+h6L7ExVi
	 So01cJN5cilVjQ+l2BOZRbCDzBz4l0jx/528FVGADA91iX16nEcQqhk7C+I3XC2HK7
	 h8YY+rz3VaV27PABMQPe+XFO0A3f09JiU6xuOpIhAcnYGpceK3myDMpXIhk8UsbUdW
	 44QYK4zDYozKR6bdgJ0AuhU4boMkic+TRxvaa7l46+NcC0mz6N2MBj6oFYUg2r+kni
	 oNTBDRvYmIZCWXND1t6CZDNcgogj3r8+3POtzOg865W7XV0bEc8neCi90WXcaEyIdz
	 QYprE511ev6Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58136C43618;
	Wed, 12 Jun 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/12] bpf: Support dumping kfunc prototypes from
 BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171821583135.29771.8486292481897939634.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 18:10:31 +0000
References: <cover.1718207789.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, fsverity@lists.linux.dev, andrii@kernel.org,
 jolsa@kernel.org, linux-kbuild@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com,
 acme@kernel.org, eddyz87@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Jun 2024 09:58:24 -0600 you wrote:
> This patchset enables both detecting as well as dumping compilable
> prototypes for kfuncs.
> 
> The first commit instructs pahole to DECL_TAG kfuncs when available.
> This requires v1.27 which was released on 6/11/24. With it, users will
> be able to look at BTF inside vmlinux (or modules) and check if the
> kfunc they want is available.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/12] kbuild: bpf: Tell pahole to DECL_TAG kfuncs
    https://git.kernel.org/bpf/bpf-next/c/ebb79e96f1ea
  - [bpf-next,v5,02/12] bpf: selftests: Fix bpf_iter_task_vma_new() prototype
    https://git.kernel.org/bpf/bpf-next/c/718135f5bd24
  - [bpf-next,v5,03/12] bpf: selftests: Fix fentry test kfunc prototypes
    https://git.kernel.org/bpf/bpf-next/c/dff96e4f5078
  - [bpf-next,v5,04/12] bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
    https://git.kernel.org/bpf/bpf-next/c/89f0b1abac49
  - [bpf-next,v5,05/12] bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
    https://git.kernel.org/bpf/bpf-next/c/ac42f636dc11
  - [bpf-next,v5,06/12] bpf: Make bpf_session_cookie() kfunc return long *
    https://git.kernel.org/bpf/bpf-next/c/2b8dd87332cd
  - [bpf-next,v5,07/12] bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
    https://git.kernel.org/bpf/bpf-next/c/0ce089cbdc6a
  - [bpf-next,v5,08/12] bpf: verifier: Relax caller requirements for kfunc projection type args
    https://git.kernel.org/bpf/bpf-next/c/ec209ad86324
  - [bpf-next,v5,09/12] bpf: treewide: Align kfunc signatures to prog point-of-view
    https://git.kernel.org/bpf/bpf-next/c/cce4c40b9606
  - [bpf-next,v5,10/12] bpf: selftests: nf: Opt out of using generated kfunc prototypes
    https://git.kernel.org/bpf/bpf-next/c/f709124dd72f
  - [bpf-next,v5,11/12] bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
    https://git.kernel.org/bpf/bpf-next/c/c567cba34585
  - [bpf-next,v5,12/12] bpftool: Support dumping kfunc prototypes from BTF
    https://git.kernel.org/bpf/bpf-next/c/770abbb5a25a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



