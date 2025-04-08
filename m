Return-Path: <linux-kselftest+bounces-30350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6682AA7FEC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC83BD510
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB789268C72;
	Tue,  8 Apr 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="QNXQ0E3K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC1268FD7;
	Tue,  8 Apr 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110512; cv=none; b=EHMQgL1haWroQJG7V8voozwvFl4XoBOWuFOW/1qIROUYYX3O100TXsNw+53r5QoixLWlwQdV9Gf21vHmp6cPRotYtBJyFsGD0gfrL+ihuEHObXjfcH+Np9gV+72cCT/B3T42bwvSpGTyDIMJmfip6sKtZ5o6k5ZXgZQRAUi8HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110512; c=relaxed/simple;
	bh=PrvUacSZYBTgmAKINwjiJz/eRWsO4sadGD2zYbVXWtE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0Ml29UvugL+QaGyWOSk/Nuw5llYtlrv5Wa8irdl/PQyr5XJfp77kq8wXeuU3IxWnAHrm0Bghr5gZ09/KISdQIbRzA2rPTKNMLJ6RakgYT6Wpbv+x0rfmBsIrnbKP5kEfCJD11bawYtxCYI28olmq42atAIYosFvowxspFKza4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=QNXQ0E3K; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Iia0kfPBUQvS+5Z+gyHC8leiNmcwWDWI9SmtMPwlMLU=; b=QNXQ0E3KZhGYZpSEi7Vp2+VFBH
	AZRmRUlgotcH7pD7JGQG+xZHUrwfHQxfb+3JQkOt5CQr4QMBRTg4IiFK9+JsYe1ni9Y6ZfmLAD2Ls
	DGf5HbKBU0nmIbfvNIv9ldgNKXUeYOE0pCS4Ml9nAxQJF7x6TwSTExb5Sb4nepdAeJqQCVKRXQ9FW
	h2tVJvq6eo/skMkmt4rqpUcUnWTjd3rulLSAJLw308ZSxuyg84tqV9ZSVwEfMWl6X7wk9MsET78fi
	AbkrHuob8Is6vvbjHhi58Nd5w/fRz6Y71C7UHf1ELDClQfD9SfTnnJjqu3Bi41GDzRgpBqyw4Oo8a
	EhfVQshQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1u26oa-000000005gr-03JS;
	Tue, 08 Apr 2025 13:08:24 +0200
Date: Tue, 8 Apr 2025 13:08:23 +0200
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 net-next 1/2] wireguard: selftests: convert iptables to
 nft
Message-ID: <Z_UDpyCvF_5kPdU7@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408081652.1330-1-liuhangbin@gmail.com>
 <20250408081652.1330-2-liuhangbin@gmail.com>
 <Z_Tul3J4zLoNAkaF@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Tul3J4zLoNAkaF@orbyte.nwl.cc>

On Tue, Apr 08, 2025 at 11:38:31AM +0200, Phil Sutter wrote:
> On Tue, Apr 08, 2025 at 08:16:51AM +0000, Hangbin Liu wrote:
> > Convert the selftest to nft as it is the replacement for iptables, which
> > is used by default in most releases.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> What are the changes since v5, please?

Ah, nevermind - I missed the cover letter somehow.

Sorry for the noise!

