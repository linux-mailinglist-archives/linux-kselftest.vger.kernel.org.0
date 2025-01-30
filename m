Return-Path: <linux-kselftest+bounces-25419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9258A22BC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84CF3A9027
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE0F1BD01E;
	Thu, 30 Jan 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF7QXE2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D33987;
	Thu, 30 Jan 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233504; cv=none; b=OU52y4+vDtwhABUsMLh2+EXvF/EQICAzK/IY1hp2qyKnAwMK+VaD0RnDf0q5p4LIFoD0Eg93ldMIbptAOIYsJGSNFNwNC7AJTU7neYEStjchPpQIpxyBgJvwJsqCO6QRkQ/C2bt20/zv7glH5cmF9W/h50aK8rE/kM5L4v3tkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233504; c=relaxed/simple;
	bh=P+BfBdIwj1fdcuWBJfI2NcHmHdE9JFGw4yo5WcWi0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6819fKKhAx7uw+9ymt4hO4LVLX25A0vLk6qxvYWiwLopLEY8eq9iS91HRoQDz1gZRhci0R6ci3qdmPEoDfJLHOEcogubeGAf1raE8IwO2PJgMGcOcezp5KLQhpGHBhBGu+T28X7v/U3EttiMljYpJMvvOy8oF164Isz5QZQKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF7QXE2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB601C4CED2;
	Thu, 30 Jan 2025 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233503;
	bh=P+BfBdIwj1fdcuWBJfI2NcHmHdE9JFGw4yo5WcWi0t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qF7QXE2QvWGCQaHGPO9rRaTOj4oggUB80WOFks58MkP2XGiR7ml5oYsb+GDqWPeBX
	 4lwjMsb8PgtC5woa++08vQaO7LOHBDVkop8rfbxVHB/WTOPK5J3Y/Uqp0Nc2LtqJUe
	 Kkr0MRceVuaBZUrJmQtwEZDWgXdSYBe86l4dDmKG/Y1IT0WEXgJd4IodoBvg/705//
	 Bqsd4i8kxyR8N/BiDpOuIPEjRVTxrkq0fHi4aFDUOioepkoxBbTwo+UxQxkzwN+XyU
	 ci0/GjPIXYw4/3VVZ7GnJyrbrotJJtslthHoKZVcThCxS9msSOFvWzK8g2iqsX7of1
	 KZCgj+Qb7mXiA==
Date: Thu, 30 Jan 2025 10:38:18 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 5/8] netconsole: Include sysdata in
 extradata entry count
Message-ID: <20250130103818.GI113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-5-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-5-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:44AM -0800, Breno Leitao wrote:
> Modify count_extradata_entries() to include sysdata fields when
> calculating the total number of extradata entries. This change ensures
> that the sysdata feature, specifically the CPU number field, is
> correctly counted against the MAX_EXTRADATA_ITEMS limit.
> 
> The modification adds a simple check for the CPU_NR flag in the
> sysdata_fields, incrementing the entry count accordingly.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


