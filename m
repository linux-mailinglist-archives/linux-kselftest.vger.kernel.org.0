Return-Path: <linux-kselftest+bounces-45934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED0C6C1F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 437194E63DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 00:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB9F1E8342;
	Wed, 19 Nov 2025 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDdBozhg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847611E260C;
	Wed, 19 Nov 2025 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511933; cv=none; b=Ib4JC5VOaDuBSrZ/BRHZwIHJUpXIuyJXJLxTtp0d99N65UZBVOKCrVbgzAeXoNHiRUdlr1/EBOnty13ffEIqu20CCwqSSl0ziFiQxHblzLdcvyxGo6+ndvpFe8tmgI94AKsZpqhoDz54OiSbNZGwN06vJJnCo76oIOnhk5JlYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511933; c=relaxed/simple;
	bh=nQYrm2QMpRbMJOocdPca2/ND4HC4iXn1kQOqopiF0FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKLRBd14AG6cjYEXaEKMVoTFwwzg6QtqdD8SlI+wEzVQIMiINJXJm/11bSm2l0umItfO/fSZkTs+M2rj2ADmwzwKzpCAjFjcXkA+XV8JxUoHNtn0fJKC7hGBn2wQjlJ4jPJjdlfQBP0+2iN+rfbuB8MAWpjCcBejR3T0RXWgD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDdBozhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E981AC116D0;
	Wed, 19 Nov 2025 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763511931;
	bh=nQYrm2QMpRbMJOocdPca2/ND4HC4iXn1kQOqopiF0FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDdBozhgVQIwGbM7OlY9Ay9iENzGHsGFsSNjZ5r6LYvaUZ08d5CpFLm5it7sa6AH2
	 rF8ghSLY0VHPDwT9QNJ5GDo+KE+Qbk60sFJLQUwldy3CNNkUQWwlwWsJ861Do58G08
	 Nq40TAmywaMoC6KLPoUUyRSea1WfxUmpnDDpcKREoOshp6XfZpqb7Vq4op8YKlmwpn
	 Io1Q/VeFopyXgWH+1QDrYp5WsJqcnfKJ/rPBXZEHSzIvJTxoSYmpr+vvyDaJrHMARM
	 fEDaMCzscy6YXMaWGV7beR7X1ZHjvb7e+l2thx1zEiwwVoCfDLYj72VquZpwc5R7Uq
	 9KjjhBfxicfyA==
Date: Tue, 18 Nov 2025 16:25:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, krakauer@google.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com, matttbe@kernel.org
Subject: Re: [PATCH net-next v2 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Message-ID: <20251118162528.4a3f3169@kernel.org>
In-Reply-To: <willemdebruijn.kernel.27c628e67e858@gmail.com>
References: <20251118215126.2225826-1-kuba@kernel.org>
	<willemdebruijn.kernel.27c628e67e858@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 17:31:50 -0500 Willem de Bruijn wrote:
> For the series:
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks! FWIW did some more digging just now, with the indirection table
read from the device and disabling symmetric hash for the test (mlx5
defaults to having it enabled) - the Toeplitz test passes on all 
the NICs I have access to (with the caveat that I'm not able to test
IPv4). I'll look closer at the GRO tomorrow.

