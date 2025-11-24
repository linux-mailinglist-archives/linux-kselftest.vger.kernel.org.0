Return-Path: <linux-kselftest+bounces-46371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31CC7FBA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 457F74E4824
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC62F8BC3;
	Mon, 24 Nov 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wW1hsokD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45B2F7ACD;
	Mon, 24 Nov 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977872; cv=none; b=WscH4HNO5if1IVa8xeXy8eqInbNz6zUji+P1+z0yDZoh8Zvmp1m7i+5Ou5kvpY0TB+m3nf9J8MDmYwoWn/VkN659MMI/sq+yuU92Xowkd/Zp1LWcIWy49os2NZaaLp5iXvj0dCs2mjpxqXQ8Ms1t8mNmUwN83m7N7HCm2rRTu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977872; c=relaxed/simple;
	bh=NZ+7tknR21V70HDPTm01qpPJ23c08Ay51HjV3P3sMbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7wgjgJLSpNv7mrLNXLgWkn6ELG2rp7+Cvddy2uQ+Bctice2MkMpZtbd26pE/kgchGFM5y1tl8R9tvVS7RXXWg3VHSZ8e/AvS3zlcd134/oCN+GZh/OxXK6dsk9PLBbs8L8w/Lcf9J7v8nQ7mKAx2gTw5wZIKEJJQahqxl4rvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wW1hsokD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IUs2wVOGoiPONAnS6u5hGOVuNC2QoyJsJJgysopWtVU=; b=wW1hsokDdF/zjPcL9PyNwNQrEJ
	Iqs9af22j2VUTazYPEPIkr1bcVv/2wsRQMWOUXE3iVEqThUrYD+Vm97Ovm47i2YjpWJ/JxP+XXCPx
	qF08O6xIzmcElH5j+d8PEcpPqVtRdeOAiC98W31vi2fMoY7UBPMmwtwhjh7RsAA/j3QpqXp+Qfpuh
	gthRL5wBJgyXeUaoBUsiA/CWJCES/Is0HFVmazX0RQ6JIAVVXTYa77rAReaVywcMLj2puQvzjq0bH
	4O/2hiSsHypMlCIULbodf2IOCVQv1BQl+2/T3tvs8ZVGGQjIZDFvasP04fhmGFwJhcRgSskTs/vrW
	MpQb+rvQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNTDs-002Uv0-2l; Mon, 24 Nov 2025 09:51:04 +0000
Date: Mon, 24 Nov 2025 01:50:59 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/5] netconsole: convert 'enabled' flag to
 enum for clearer state management
Message-ID: <pxmcpstqh52djqjzupe4teg5xeq5agj5ddpwa36nnlszvqk2ld@fkdjwjyfzwdo>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
 <20251121-netcons-retrigger-v6-2-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-retrigger-v6-2-9c03f5a2bd6f@gmail.com>
X-Debian-User: leitao

On Fri, Nov 21, 2025 at 12:49:01PM +0000, Andre Carvalho wrote:
> This patch refactors the netconsole driver's target enabled state from a
> simple boolean to an explicit enum (`target_state`).
> 
> This allow the states to be expanded to a new state in the upcoming
> change.
> 
> Co-developed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

