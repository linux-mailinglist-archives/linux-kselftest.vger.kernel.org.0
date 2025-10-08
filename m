Return-Path: <linux-kselftest+bounces-42902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE01BC64DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9784065AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C062C0F7B;
	Wed,  8 Oct 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgHrqYTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40F20370B;
	Wed,  8 Oct 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948370; cv=none; b=d+9eXdMUpV4GoHxqg+NDrdBwf/z1JdgIiSXsW6MXMdIT+459448svCVFBb3Ito5lKt4vdyyoKyabkaIZBCsMDCHgwBkvidXQceZhxpjDoaMH5t+FKjIgkkbuWLF/dSRrwjUWEpuQPqxo/0WakCmNULhYwNLTiSIMCEV4bKojW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948370; c=relaxed/simple;
	bh=sTWPKF9alo+tvVGt9lUYHopgwmcpVLiijGjofW7+p8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI3ly+FfVg1Wlt/uGPe+lOk84BDSZ1LbWhRhDg4Fq26cr4RpNk6h2h6yNrdjrSO/EUDzqGZQPNWmrRVr/OjMzif675oB2OuzdoznQLxNT3ug1o0rQnE81N9bqhjxVNmMF0WUJ0OUkdbURVqYluTh7KrG7fQMJxBl4oCCV5+/ZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgHrqYTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E115EC4CEE7;
	Wed,  8 Oct 2025 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759948370;
	bh=sTWPKF9alo+tvVGt9lUYHopgwmcpVLiijGjofW7+p8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgHrqYTWruq2gYgNiUWZXVxjyqW0UNbYqrh1kSicJUgIauEApt5VGgztdcNqL0gix
	 zUS13Ee4+DbwdCKH1mwpvN5FQTnhOdmKnsdg7FBimtCN06BmffyAXcl54GtYhE7opS
	 lLlCIPTNuHezutgpR7NREuYuTA6zdRbuSFzWXV/RiVYQuxLk/q1VdV1IZ5L53/lVHR
	 GnSz+dRS8ebl3tYwGX9lfcbCk/18HGcAKci3L07jiUsh6CSbaBFi/zb3Tbxoo3CMRH
	 1AyEcYKiYYtLKHyqQhr5IExVwAAGfs/3Xq1Zdp01E4H2tj6ym/BpC7CsxYPD/g+y78
	 fgX/0fH5APJLA==
Date: Wed, 8 Oct 2025 19:32:45 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	shuah@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: drv-net: update remaining Python init
 files
Message-ID: <20251008183245.GS3060232@horms.kernel.org>
References: <20251008162503.1403966-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008162503.1403966-1-sdf@fomichev.me>

On Wed, Oct 08, 2025 at 09:25:03AM -0700, Stanislav Fomichev wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Convert remaining __init__ files similar to what we did in
> commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hi Stan,

Sorry to be the bearer of such news.
But your SoB line needs to go here as you posted the patch.

-- 
pw-bot: changes-requested

