Return-Path: <linux-kselftest+bounces-24993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F3A1A24C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 11:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7002D3A54E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493A20E006;
	Thu, 23 Jan 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVMazZoB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710E20DD7F;
	Thu, 23 Jan 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629868; cv=none; b=FxC9fKl4FYn6BYssBSHc9aGmgyGKe80CZL4ER16R9J6H+Fx2XoCVRPGyIcghj9g4uEGQZ8Et+n9YBi7aLp1BBn3g153MY1/urYRArR6nqYYXQCgsbZ1Ft67UyiA4ucol8NeDz6TKFj2QTupnLGssBe8uKT90mdTkncQgiKcXc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629868; c=relaxed/simple;
	bh=f41UpFEOXRxZ5O0RV5KxYINmp7dFVbrFYnQ2EhExkXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmCblBxiulM3Pnvpm7hWDL4ndCbsIsbp/s3Wklnu55OaxgURiCUmW8HQ21VTMSUPyto9tNHVb3MSBneC2zbPQR3bYnha1Zhngc1GsWF5ckSs8bl0AtTklxOKsqmCkrJXRoooEmvaDn39t7kmq9KUYSVw3OdvLycRVzQVmovBX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVMazZoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B0C4CED3;
	Thu, 23 Jan 2025 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737629867;
	bh=f41UpFEOXRxZ5O0RV5KxYINmp7dFVbrFYnQ2EhExkXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVMazZoBktp6usukCFQEM4Dd35SAuIuWB3SB3/G6UkTrJ09U3xhw+5ZTF2aRLFkUK
	 vTjYuvTPX6+hVbC8TRUDOahgR5nqMkd4Ow0bg5tXqUYHwyGzSn+wUTTyzXRBtVXWlQ
	 oIeM+1r6qnqBJL5powgWqu++auL9k4+N5sYJcIh5j2KTIMIVWBQQrMYJo4zl28vojZ
	 FyUchGzbg4czA5BZ2bR8jbIbOzsSa67Cnxc9uLlmwgD/RPVShNFiLsWAT1MtBJarZl
	 6gu6Ac1GlQHE00JwUYo/qVAdocO65kMFwcVfV78mu+x5E1u8ddIUtwHeoMQaysRq15
	 OBmD/LbOF3dhA==
Date: Thu, 23 Jan 2025 10:57:43 +0000
From: Simon Horman <horms@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: Jason@zx2c4.com, shuah@kernel.org, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	jstultz@google.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
	chenlinxuan@uniontech.com
Subject: Re: [PATCH] wireguard: selftests: Cleanup CONFIG_UBSAN_SANITIZE_ALL
Message-ID: <20250123105743.GO395043@kernel.org>
References: <F0F29BE7BB89FAAF+20250123044923.161871-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0F29BE7BB89FAAF+20250123044923.161871-1-wangyuli@uniontech.com>

On Thu, Jan 23, 2025 at 12:49:23PM +0800, WangYuli wrote:
> Commit 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
> removed the CONFIG_UBSAN_SANITIZE_ALL configuration option.
> Eliminate invalid configurations to improve code readability.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

This looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

And I see you also posted an patch to remove the only other in-tree
references from Documentation/translations/zh_CN/dev-tools/ubsan.rst [1].

Thanks.

[1] https://lore.kernel.org/all/6F05157E5E157493+20250123043258.149643-1-wangyuli@uniontech.com/

