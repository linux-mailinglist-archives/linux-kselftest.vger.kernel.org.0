Return-Path: <linux-kselftest+bounces-47723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CBCCEECB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03FA43019351
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3C2EC0B2;
	Fri, 19 Dec 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpE0mTgP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77892E613A;
	Fri, 19 Dec 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131998; cv=none; b=ZqDiu1YL7b/shFJ7CWMqUv0ZMjCa6YN17Cjans1z2KeZF5ODZOPahzjQm7CsnTtIfeYYmdJ2k2wn2vZnC9VBIYdftRSs2/8J3GneLWBeh1LJJNvb969VJfkYwybFaXEkr2PIqDRY/GxV1XOGrUNe6LNLncXTuDfvd0qYlDqbRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131998; c=relaxed/simple;
	bh=r0gi6Pa7RYkDOmLxwP7sAf14xxMtRN2sCVwGszpsTD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sv5aNjHXIPmVCsc9/kWOAikp0AepMyHX2x+hLywCupHFsEhEmZxCsZG4hj5R8JIvhOq9oNLgxD7ddi0Sn21KS6MFCaOaMxb0oxZk46gq5ip57IJirWPmeKnRmtQ2A2ozLNcKLC5/hTdUhh1o5QyscTv2jB9lLKAw6jV449mlV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpE0mTgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054CCC4CEF1;
	Fri, 19 Dec 2025 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131997;
	bh=r0gi6Pa7RYkDOmLxwP7sAf14xxMtRN2sCVwGszpsTD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tpE0mTgPIT9GZb7i4tCzc+1kWFUUpEt3N8OCk8gahe8sUIZU+QM5VKaOKMnGm2HF7
	 LE/93tXVAbbpEfMRCO0TA5nXQSDsvo+kGraLsLIeHAqpCQlvysfBn716wUVfKqjO4X
	 VqKFhvtW0qFFn8sgJQjYrzL8IDZWQJ+mvYYRgGz0/UXcYHwV38MIeAx3hbgUvd3cD0
	 yJuls34RHzicXsTGUSjz2orXhjV/biH+Nf5ualKn0NY0nt/cx0NSFzYWgM29o+PfuG
	 UnDHj8988x5clcZ/qiKVhVZZlGMAcbfNq+L3bnWfkn+pUL5L1iWBR5SB1SgnwjOnGS
	 JB+jew0Fkl5Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BEA0380AA50;
	Fri, 19 Dec 2025 08:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/15] Consolidate iommu page table implementations
 (AMD)
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613180577.3684357.2034328332423326144.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:05 +0000
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, alex@ghiti.fr, anup@brainfault.org,
 aou@eecs.berkeley.edu, corbet@lwn.net, iommu@lists.linux.dev,
 joro@8bytes.org, justinstitt@google.com, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com, shuah@kernel.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, aik@amd.com,
 alejandro.j.jimenez@oracle.com, jgowans@amazon.com, kevin.tian@intel.com,
 michael.roth@amd.com, pasha.tatashin@soleen.com, patches@lists.linux.dev,
 skhawaja@google.com, vasant.hegde@amd.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Tue,  4 Nov 2025 14:29:58 -0400 you wrote:
> [Joerg, can you put this and vtd in linux-next please. The vtd series is still
> good at v3 thanks]
> 
> Currently each of the iommu page table formats duplicates all of the logic
> to maintain the page table and perform map/unmap/etc operations. There are
> several different versions of the algorithms between all the different
> formats. The io-pgtable system provides an interface to help isolate the
> page table code from the iommu driver, but doesn't provide tools to
> implement the common algorithms.
> 
> [...]

Here is the summary with links:
  - [v8,01/15] genpt: Generic Page Table base API
    https://git.kernel.org/riscv/c/7c5b184db714
  - [v8,02/15] genpt: Add Documentation/ files
    https://git.kernel.org/riscv/c/ab0b572847ac
  - [v8,03/15] iommupt: Add the basic structure of the iommu implementation
    https://git.kernel.org/riscv/c/cdb39d918579
  - [v8,04/15] iommupt: Add the AMD IOMMU v1 page table format
    https://git.kernel.org/riscv/c/879ced2bab1b
  - [v8,05/15] iommupt: Add iova_to_phys op
    https://git.kernel.org/riscv/c/9d4c274cd7d5
  - [v8,06/15] iommupt: Add unmap_pages op
    https://git.kernel.org/riscv/c/7c53f4238aa8
  - [v8,07/15] iommupt: Add map_pages op
    https://git.kernel.org/riscv/c/dcd6a011a8d5
  - [v8,08/15] iommupt: Add read_and_clear_dirty op
    https://git.kernel.org/riscv/c/4a00f9434891
  - [v8,09/15] iommupt: Add a kunit test for Generic Page Table
    https://git.kernel.org/riscv/c/1dd4187f53c3
  - [v8,10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
    https://git.kernel.org/riscv/c/e5359dcc617a
  - [v8,11/15] iommufd: Change the selftest to use iommupt instead of xarray
    https://git.kernel.org/riscv/c/e93d5945ed5b
  - [v8,12/15] iommupt: Add the x86 64 bit page table format
    https://git.kernel.org/riscv/c/aef5de756ea8
  - [v8,13/15] iommu/amd: Use the generic iommu page table
    (no matching commit)
  - [v8,14/15] iommu/amd: Remove AMD io_pgtable support
    https://git.kernel.org/riscv/c/2fdf6db436e3
  - [v8,15/15] iommupt: Add a kunit test for the IOMMU implementation
    https://git.kernel.org/riscv/c/bc5233c0904e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



