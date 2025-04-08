Return-Path: <linux-kselftest+bounces-30346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E423A7FB1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3F171B95
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694821CC47;
	Tue,  8 Apr 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="kibcLGqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9F20CCD8;
	Tue,  8 Apr 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106843; cv=none; b=oefPUwfRJ3/sfKpfPtKJXB5CEGK3ItvDhLOLRdGieqWFe7/dRQRSymI83pgtLGMTPkJaDQbTEXgetM0pShDWvYniKmy/i18huRIgqShs8+tQ5TVrmO6+kfl1kzM7hDf/hbZVXLz1Mv82nrVG2CAU9wAWLmcn9A1C95I7ahb3mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106843; c=relaxed/simple;
	bh=vE/Zb+oP9y5h+JfKlg7ltUJ3Lry2+3F+J6F5DTz/WDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Vd7mC/nxv9OhiNdK0o/SNoqRZ/9XYAATznRzYBx5PzuBSSVFmIGNf8sBZF3AtiR00VA5anD0dMPnCjsFkYSVIcTLGtLb059o9CJe665+Y4P3Em+TMTgTICP4orBP2bnPzRFaMf8C0GT2XexanJ81FQGJQK/hyOxMu1mX1KurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=kibcLGqS; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rwcIEfW9pJzdJoVCY6Sgo1trCmLuEW39Q/YDwIuECgI=; b=kibcLGqS4fCDjtX3aCt1TKqQaf
	3XAbVshHzHEUwJhHCVoqRkeoF5CH4PXIe+SY/sEe0TWH4sItMiMeOOwY8WMtXW4GxT4eNo+rIfYVn
	NUPniy4Jx8oAFGDDJIf6/pavA5lkrMPLuNPOp24yYWVeat0nC17Ev1L6kOUih12S6eO/uSVTl16P9
	yjDPmpBW4to8fKaUOqRLhPbPm8uEF4azPTbOevG7+ebKX/SsTqGWIDgo6xMkKOYujrDS5osOivw1i
	XOmkpI4TU2lNq/o5/m8IRxC/Hoheb6aN9SeiHAtyDMuoD5XGWnhW4xq3GR9awG7ng5lepYPmyV0bZ
	rt5m/0eg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1u25Pb-000000003jC-3mSr;
	Tue, 08 Apr 2025 11:38:31 +0200
Date: Tue, 8 Apr 2025 11:38:31 +0200
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 net-next 1/2] wireguard: selftests: convert iptables to
 nft
Message-ID: <Z_Tul3J4zLoNAkaF@orbyte.nwl.cc>
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
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408081652.1330-2-liuhangbin@gmail.com>

Hi,

On Tue, Apr 08, 2025 at 08:16:51AM +0000, Hangbin Liu wrote:
> Convert the selftest to nft as it is the replacement for iptables, which
> is used by default in most releases.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

What are the changes since v5, please?

Thanks, Phil

