Return-Path: <linux-kselftest+bounces-37834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D2B0DB84
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7BD3B0E76
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C92EA16D;
	Tue, 22 Jul 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMOpGh7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B942E8E0F;
	Tue, 22 Jul 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192196; cv=none; b=n3YYVsea7JBXTva787IlxGubv8VdbTGY2zHe+Tn9hR016mvpuaxWxkFuaY9ylmMcJO4S1FtJTJ1MQyADUmsdNIOkb/eWZF2jkS2uopzq9zSflvGfRJF0jhye/1R5Shqr1fZsvV5ZWedZTRmcb/EaeVr2SpI1xQ1lLZaD0i7czi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192196; c=relaxed/simple;
	bh=ddxKdBE3hjswK34PDNueVY4oEHoE9C/gkKBjP/BExc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFswv5FqmHIvV7vSa5Y/XrgeIReJah5tGxYVqHTxje2/MRomIDT3wFsTJCHvIvf86MAv2hwyKGzYRyTZcG8HrNbfKCEuwqUqPNzusjAKTAzzzAeLwo19zrsWLLFF+nTXjt6PpSa5TRLnOfC0C/A9r/mzpvGV7caOaK6cDwHcKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMOpGh7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0FFC4CEEB;
	Tue, 22 Jul 2025 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192195;
	bh=ddxKdBE3hjswK34PDNueVY4oEHoE9C/gkKBjP/BExc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMOpGh7gUzCgU2JCzvffqqe1ECUyFe7TpYQd0yQppiLNVO//kChktylStkjPmiP/f
	 1aBaPEd/ND+1BRyYdmLIBaB8wg8ucaHY8rUZSrYD7P6haCgjShC2ZDwNWu6lVP2K+e
	 2dP1eQR8baaOD6XYD5rou68iRXw8xUUzwlL4GZJ31WJqsDs+hkr8u5d8vwWPccygkU
	 +y7RoNN0cfKikiIhvsNaNv8PTcIevF4vImrL8r6csrPLbl1Q2aGvIx5SzHu+QED74N
	 RKPmx/7PR+j8gCinuwARDiA8l+PaXv5Fu+50fGJLz9X8SKK/Npv14R/xm+TJLRJOMA
	 wfiae2S6H+owg==
Date: Tue, 22 Jul 2025 06:49:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Nimrod Oren <noren@nvidia.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 tariqt@nvidia.com, thoiland@redhat.com
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250722064954.5b5b4a92@kernel.org>
In-Reply-To: <60729195-9c48-45fb-99c0-8965c95927df@nvidia.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
	<20250719083059.3209169-3-mohsin.bashr@gmail.com>
	<ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
	<20250721084046.5659971c@kernel.org>
	<eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
	<20250721133325.73e2f076@kernel.org>
	<60729195-9c48-45fb-99c0-8965c95927df@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 10:21:22 +0300 Gal Pressman wrote:
> This thread is more about pushing NIPA agenda than a technical discussion.

What is the "NIPA agenda"? Please explain, this is getting funny :D

