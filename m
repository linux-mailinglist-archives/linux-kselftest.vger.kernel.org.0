Return-Path: <linux-kselftest+bounces-29977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D0A77832
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52A11888A2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316651EFFAD;
	Tue,  1 Apr 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTg8V93q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B86353;
	Tue,  1 Apr 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501234; cv=none; b=lCEOOcz7B9BNn5jpYaWHURTAGT+ig2ACkarM0n1CyKiK+zTRqy8zYbQFQ0/GkaXCgvoUC/qPBYGT0RtHWhmmQKWMbA6O2Xe9VRQLwRU1j/0LqUtxrITL1ksDM6bX6VCro4ZwJY+8mOxs8hr6W1pEDdNE8+5BBn/nDhgSr1yt5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501234; c=relaxed/simple;
	bh=pNJSx7stitvlj+MVlOZuxm5MEm22zAx6cBa1EKu6KSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPzaP/ETCYr3xbi+B/EeHgIt6g2PffokuSI2LVKA1KFbBgMd3zLMUk6BmtAwVvoG5OjHKIlQLRPs/BYvC6py1zwTMQ2DhMVZBYTpLV4xO73XANhAk1tlYhZJqinbvPafTOLCKZOMZzZSWN+G1XAa+Iauj3gW44iHrAY6d5fNzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTg8V93q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145AAC4CEE8;
	Tue,  1 Apr 2025 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501233;
	bh=pNJSx7stitvlj+MVlOZuxm5MEm22zAx6cBa1EKu6KSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTg8V93qeICEvYlTNmyigOatpr4XPdsibdeXlH+hFOugaJmiCIw+krruSbG8kGedQ
	 9Xk82/EMq/si6GGASaSc2Wo0RMRIEY+jbCskeXBrHjQ9O+ivlwiLD0wqei2B2XNLYr
	 3V+pEqNrR9Mry2sz04gMpy44VCibaHYB0ymX5EIPTnBl2g7+FgTXugHZoShNKWZqr4
	 LSB9FSuv0unp6vL570Gc8ToD0uT6HIPDNbmn7Sd8vvm1IuCvhV0LGpj2hcxyLuONnt
	 wgMcxMnW0fyETDrE1JMWk32++61Pk7RHwwwEuhJNMW6/xoKtehLDUaXuVIXtXfq9hm
	 0bvpFcFBKCt6w==
Date: Tue, 1 Apr 2025 10:53:49 +0100
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: tc-testing: fix nat regex matching
Message-ID: <20250401095349.GC214849@horms.kernel.org>
References: <20250331195618.535992-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331195618.535992-1-pctammela@mojatatu.com>

On Mon, Mar 31, 2025 at 04:56:18PM -0300, Pedro Tammela wrote:
> In iproute 6.14, the nat ip mask logic was fixed to remove a undefined
> behaviour. So now instead of reporting '0.0.0.0/32' on x86 and potentially
> '0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.
> 

Hi Pedro,

As a fix for 'net' usually a Fixes tag would go here.
But perhaps that isn't appropriate in this case for some reason?

> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

I am assuming that you are referring to this fix:

- [PATCH iproute2-next] tc: nat: Fix mask calculation
  https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/

If so, it might be nice to include a reference to it in the commit message.

And also, if so, this change looks good to me:

Reviewed-by: Simon Horman <horms@kernel.org>

