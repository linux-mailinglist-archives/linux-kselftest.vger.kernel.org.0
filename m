Return-Path: <linux-kselftest+bounces-27639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B2A46A23
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2431816D404
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022E235BF5;
	Wed, 26 Feb 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCCeaNyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37018235BF1;
	Wed, 26 Feb 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595794; cv=none; b=o4eNAMalblra/rSdmsoblHCq27pyI3C/lwktm9VREvvF9fNjMqKIeo2d43bw9uBd9LutapJpgl3I4zu/8U8EQM4hbAzeuH3Pfzvf9l64pd6St1FO8yEEnuaewAHmHr39kMviugCu5wkwsVROYmnctR1+ca/hD1zBs4z+AQVhbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595794; c=relaxed/simple;
	bh=Ba4soV8/sXJENjDlLInMDsIGvLpp7Zt4UelFxb7q/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmOLSnKldodr6UEInkdzS9pPCCBC2nzVrSRbK7lqGEMwJxaA/NhewESdMujoXAqL4kZ+itptBVwKdQ59O5p2Dfz9xlAz8/qOwAURFQBt/h/wp1GUV8vhAxBS2TenmTOAjbdcYQzfS2/ZPTjGxDDexgmFO2YUE+u8Ng4Xe0SnDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCCeaNyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B170C4CEE7;
	Wed, 26 Feb 2025 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595793;
	bh=Ba4soV8/sXJENjDlLInMDsIGvLpp7Zt4UelFxb7q/Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCCeaNyuNK+h7Cth2eplXSmYW6qjs5sXEzt3x6uNYAOPdp8BquRFA7IwqSNT2Ru8o
	 nc0IVjh2htJR1XeulUeQD+Gr5MCFBUjrRyWvJ63U4lSim6Ko4XLFqIuKyWiCWmVwVo
	 1UL8in++7IYa7x3lab57xDN7druDL6bq24e8RUDF5zmzh1XobGBmZprkPCS65Uj1V9
	 6D2Vo7SlBmzOHfih+t4sbP/b6T1+LFZgqPC/0GRZq3X+wA+Q7XY7Zp1BU2cunNppDf
	 XLMd5A0BEVns5NUfaCmibOwzrojVi01+OjUcI+bnWbSG+IxsWIyAxjJ7JGZ7uaJn7T
	 Eh6TTiUbDueLw==
Date: Wed, 26 Feb 2025 08:49:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] selftests/sched_ext: Add NUMA-aware
 scheduler test
Message-ID: <Z79iUHunOU8PcUNV@slm.duckdns.org>
References: <20250226065057.151976-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226065057.151976-1-arighi@nvidia.com>

On Wed, Feb 26, 2025 at 07:50:57AM +0100, Andrea Righi wrote:
> Add a selftest to validate the behavior of the NUMA-aware scheduler
> functionalities, including idle CPU selection within nodes, per-node
> DSQs and CPU to node mapping.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

