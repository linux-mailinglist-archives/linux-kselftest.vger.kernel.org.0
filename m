Return-Path: <linux-kselftest+bounces-36573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F209EAF94C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155915A7D10
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E6306DDF;
	Fri,  4 Jul 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taidsbd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A62D77E6;
	Fri,  4 Jul 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637244; cv=none; b=Zc8ESG+ZtjN7RjhqWJe+gqP2o3mVj3LWenn7lpspJ5Yzqm9C+LCT2342xit9uayvyh2yM78hAd9ttf1oQN7HfmwiXXcKOiVMPjbS/EQ0sdEbapNnm5ud+8kQ2X2cxJqLWakBQoEdIB3dxZp4PMjQQ+8k+vQnOtgDkQnNql+xMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637244; c=relaxed/simple;
	bh=xh6lBvQ6t329lvL2r/jICUobgbrQHlN2VH86iXJeGLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtsfF5/6rV9KPQ90ikpEfVGE7i6gE6zzAVKVCgcQ+9Dmey3C32tvrMbtipL6Iunly0876EPqL8fttB+VFBIrgNDne0XDyvkXxXeNQ8VVjF6ZvO653Cd4GdFHdfGANMGzNfB3ThSY23c502pwPwM5qIbpJdx5IGryAnN5y8C79cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taidsbd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C0C4CEE3;
	Fri,  4 Jul 2025 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637244;
	bh=xh6lBvQ6t329lvL2r/jICUobgbrQHlN2VH86iXJeGLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taidsbd+VQjQf2uiZ3XDOg0wKnkTTvcYSV/BWjh299Pxn9qGAD6QPE/dIESYhaR1Y
	 y2JuIQZgOc51QLWJCLVbHPHQidmNRJgI5QP9Av8yR6BxDXWwV2LsnSFebu6Rmu46zD
	 pvhY5MswmUv6vboC1xXZbSL16VkcELtoVRWASVv//IjRweJgPHcTbTU5rDE/OtRYcG
	 42QjneMe+vAJYtOpa9TkaESKBQ/Bk5F12gqpURlMXinGZvxLxVRjg2XmnoHP9RVGC4
	 LEqZLSfxWHPVY98094rZMa1V94ym6e122AlPsV56ozDc7LtFzmSCOilb5ZmiTNJdab
	 PQgtFRiZyZ5Cg==
Date: Fri, 4 Jul 2025 14:53:59 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/7] netpoll: factor out IPv4 header setup
 into push_ipv4() helper
Message-ID: <20250704135359.GR41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-4-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-4-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:36AM -0700, Breno Leitao wrote:
> Move IPv4 header construction from netpoll_send_udp() into a new
> static helper function push_ipv4(). This completes the refactoring
> started with IPv6 header handling, creating symmetric helper functions
> for both IP versions.
> 
> Changes include:
> 1. Extracting IPv4 header setup logic into push_ipv4()
> 2. Replacing inline IPv4 code with helper call
> 3. Moving eth assignment after helper calls for consistency
> 
> The refactoring reduces code duplication and improves maintainability
> by isolating IP version-specific logic.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


