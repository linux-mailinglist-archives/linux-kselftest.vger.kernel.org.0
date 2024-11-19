Return-Path: <linux-kselftest+bounces-22230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D09D1EEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14A5B215BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F31482ED;
	Tue, 19 Nov 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6R6QCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88147146018;
	Tue, 19 Nov 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987720; cv=none; b=lphjcPmQZhRmFNIrawe8BiR7O9BBEG5IES3xcKmTVTH93TxEWwwgrNpHRarW/AdPzBUw1BABfWJBX8m+Sc3wlZYgwH/aqtclpg42GdYa3jziQKdhk6fvy9xlbBZ3aiiXWNspXWLjMTlRcj8Tpc/782KUa0zaSXTiFFGtLbqu1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987720; c=relaxed/simple;
	bh=tUmZ2tLUvnEM10fDgcFy2YKWDsB4QjAknVgTZyP7+QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBT7OUmKLDlGIKuXtLf19ISJN0FiDOadzcR/a15bjfnR8+Lz32//5w32wYPnzVSzgbuqXjMfgO4WodbR+Tq21TI0dsJdQ7CbckUJ+5kzF3BQCw0nqqeNMSv+5NZwCRaCDQ+dey9XxLSQu8KwTx77SFejcihQsK42BLLH0RWGkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6R6QCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EE1C4CECF;
	Tue, 19 Nov 2024 03:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731987720;
	bh=tUmZ2tLUvnEM10fDgcFy2YKWDsB4QjAknVgTZyP7+QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ld6R6QCLEVu3SEj76xYiOGLbbQWS3IHeoEZuYvfnzSz7XichiG3M9O5jqbbUZqeW9
	 1c9F/jpq7wbx5LI14X3R7I6x/1qGFenFgyikgBgG34aVPFqdpxMWVdu0zShz3zufsB
	 6xm4fWtoSOeFx5t+yO6whayCvxrWInhospWsVulwQeMuaGjygoBy8Phz3O7eKcv+2e
	 UMvCanBnQvhnOAwwVFMpGeyrVtjxa43pB8ss8VblC3fJve2vEH44iQR0s5lyBZcSF3
	 ZDOG1S83gJruZuaSuDiB/OZEeXEYkma/Bc5GcgpGhow2ongj2Q6R8Ht99gjmt14B+Q
	 E5CxSvhcmKEDA==
Date: Mon, 18 Nov 2024 19:41:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 0/6] tls: implement key updates for TLS1.3
Message-ID: <20241118194158.493e11ec@kernel.org>
In-Reply-To: <cover.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 16:50:47 +0100 Sabrina Dubroca wrote:
> This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
> [1]). A sender transmits a KeyUpdate message and then changes its TX
> key. The receiver should react by updating its RX key before
> processing the next message.

Will review tomorrow/Wednesday but I haven't gotten to this in time 
for 6.13, sorry :(
-- 
pw-bot: defer

