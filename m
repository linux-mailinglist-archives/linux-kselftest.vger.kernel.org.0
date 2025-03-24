Return-Path: <linux-kselftest+bounces-29650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6911A6E0BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59553165D25
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73C263C84;
	Mon, 24 Mar 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqm7vVEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2E25E461;
	Mon, 24 Mar 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836751; cv=none; b=oOwjxGHzZ44SjJCE1R5hLSK4Gj1L8A89R6WpwJ6gJH/nNLwXXh6OnuK1+JUcYy0dbPxiFxrHZlUBjblDr18YpR6klwnDcCRHRgSdPqcoT8bh2j+GDjlph/imf83WKkSDBT++yD6kP5RUGHmi0kIdm5QS57hSn7hdFi2nPkQamcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836751; c=relaxed/simple;
	bh=Dy/UCvaE4gBf65zlOMTd6hN0vb+l2MNhetesfySCf74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J54SZy0a2Yq6niaByeSYWsTTsK2dwN3fuOn3AYGWQXcfJiusj70UoEjo+yd9qDEELwOrRHdzCljb14Fg7FPfBSZX1UzkQzPOwwTxPKKl0DT50B4rIJmnehtovpV1xzLJkuIpiXuQVQzMGA0L0Nyx4IR13n1tvV+eEeMMBsiHKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqm7vVEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB055C4CEDD;
	Mon, 24 Mar 2025 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742836751;
	bh=Dy/UCvaE4gBf65zlOMTd6hN0vb+l2MNhetesfySCf74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tqm7vVEp4E/UMIS2BIyUTJu3D7t+kfCT53NPdW76vDc/CWboJbFm/ZYlcHMu8FE2V
	 VzRGF3aMX8WlSOFfUzYz+ODxoFSbbWNskdKJHnhpkytM/cL3n/lhRFuV24PtZBa4Gz
	 FBBCw58pqkhDTunixxv1Cm3q7cvUr7sx/D32vIU2NoHHlIcwy8qSVGYukbay7zUCzd
	 dphA3sIXY0MaFOup4XxvcrowswXVs1/kS6P0CmLs50zjwQGbdl9i03c6cFO5fbYWTa
	 Ct//wBOwhUwiGT8izWtYnDb4LtNdTnhjxXy6JcuighP5X894ziS/Npdac30X6Kd+U5
	 n6XjBSju0bRWA==
Date: Mon, 24 Mar 2025 10:19:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Shuah Khan
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next] selftests: drv-net: rss_input_xfrm: Check test
 prerequisites before running
Message-ID: <20250324101903.05e5ceeb@kernel.org>
In-Reply-To: <20250317123149.364565-1-gal@nvidia.com>
References: <20250317123149.364565-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 14:31:49 +0200 Gal Pressman wrote:
> +    try:
> +        cmd("hash socat", host=cfg.remote)
> +    except CmdExitFailure:
> +        raise KsftSkipEx("socat not installed on remote")

I'm not familiar with "hash", would using

	cfg.require_cmd("socat", remote=True)

work? IOW we do have a helper for this sort of checking.

