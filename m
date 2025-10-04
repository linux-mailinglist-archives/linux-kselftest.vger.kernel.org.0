Return-Path: <linux-kselftest+bounces-42768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C477BB9024
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A280189C62E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B9527FD6D;
	Sat,  4 Oct 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3WaAOJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EB27FD4B;
	Sat,  4 Oct 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596380; cv=none; b=t8GND6FpYn2vVN1YrePJvnS5xzVYnDRUeZ8Tkyn0t8MF+tQRRGx2kLXc2UUk7bTTZtLTSnps+eTdfzKWtetoZqmTJEk00zQv03zM/jlafjT1Md+m02iOw9RbiqbxdlBFfnQGZ9Ns8Mj53gX187UWZhkaQ1L+C19Bx92YncsYHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596380; c=relaxed/simple;
	bh=HEbhFwQzix9J/A1HjH0nCPblIv+aseE2jUlEGi85+cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1iKtsFZZsLw3/xAtOB//cGBkR2pzrnJ9OonHgMvbWcMDIG7Yq7UFb8TDNWtmCMtKSa8HCostZEBzahk3lJNQKyiYz4Eg777gf3rL88mZRCq9zysvzB3iZlmn944NSFvLWSpwausRKXTkVP7P/UzCR+V421ZeDovrvLNfy4DTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3WaAOJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFC1C4CEF1;
	Sat,  4 Oct 2025 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596379;
	bh=HEbhFwQzix9J/A1HjH0nCPblIv+aseE2jUlEGi85+cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3WaAOJCzyGQJ5PpA/25gkQcpaJEk3vE7/07fH/pBNBqV8SEpNiCcBvEeHVPNhL61
	 X+PnE0G6sfNs4w2TgkUL+/EOErgDWNfoVkXP/Qhplig2mWw6fLGlCYVfGvmu8XT0h1
	 dFGh5fOB/PopTiJB8E77U3Tv3v05dbNCvqktgoOOF8lRQEldm2e+923b1QiKRPc83l
	 XgcuZqDQtkxHK8OauD6KG6ZTl4AYEC+fXaqIYXXYNFEGQnB8WfZxVFyZZu+lUh3xX+
	 jHs4xkTFQ8YjCxn7Dr+5OWBVPja1rE+p9kQq2IZDxGTzLLpEB1K+Gsc8mdF78BZiDb
	 rOoh9QRLC9PYg==
Date: Sat, 4 Oct 2025 17:46:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 4/9] selftests: drv-net: xdp: rename netnl to ethnl
Message-ID: <20251004164615.GI3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-5-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:20PM -0700, Jakub Kicinski wrote:
> Test uses "netnl" for the ethtool family which is quite confusing
> (one would expect netdev family would use this name).
> 
> No functional changes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


