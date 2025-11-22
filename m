Return-Path: <linux-kselftest+bounces-46296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B74FCC7C177
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 365A135E3EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7301547E7;
	Sat, 22 Nov 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6vJJnty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DF635;
	Sat, 22 Nov 2025 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775126; cv=none; b=c9JR5Ag4fbTlaZFWwy13kIDd6TzfNBn9Wo48bsIeVGZiEvrrlYxTwh0mgEXEfDmq60+bwrib55JPG7DH20f3Sa+GZLAfuPiLalqnTpq3aG+RWEBkqJSuAec4a7OvUKNXv0ffdprtu99kmMSaMd4ojjoFsGvgIFJQgV/12wNrxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775126; c=relaxed/simple;
	bh=9jja5RBFI/62fBBaW7kkTvtGSP8TFmPwFFbYq5vcbsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Vjo4bJrpyRC8tASzi7QAlRA3GtSCyCFn22y955EGzrrIWEeFAiy44cI3bLSORLpSx38y7/Kdfik0lElFVvSxeZGwp+dyRTgaGN/s0awSAuQI692iEAV/GtbErl4s/mRm9R1ysxu6xq3/F++ThsDex9mk7NdOGJMA5s93+Y1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6vJJnty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FAC4CEF1;
	Sat, 22 Nov 2025 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775125;
	bh=9jja5RBFI/62fBBaW7kkTvtGSP8TFmPwFFbYq5vcbsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6vJJntyLRWWONB2oFm83bMQNdBVXMOvYiNZc09d6fomP6wTE/WurGSj/5Dtk4f5+
	 Hb6USRXoLX6bN9Ha9m/yJmzLiluA4uLiEkz3cQ42HS/zweatgHRkx1h0qoQajAuonL
	 N1A6b9U46ZNCIRkWOpR9iWD9yazNDD0tvmUNZJS0qEEQJU3hS/6oG/FRX308LMpkN2
	 NldpP5p/BdlVurzNNulTN9m2GDxQSh/a4vjZtykoveNls5F2Kg8dFfMvC9a6IM0oWD
	 tCYH3Aj2y1UUBm+jPXNt1CHwIDdUtsxMg/yVUbkcsbPAg7cPqfQMkfVdfJqOc0/h4T
	 zLXP6Rtt4qdFA==
Date: Fri, 21 Nov 2025 17:32:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, petrm@nvidia.com, dw@davidwei.uk, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] selftests: hw-net: toeplitz: read
 indirection table from the device
Message-ID: <20251121173203.7bc1a3f4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.224bdf2fac125@gmail.com>
References: <20251121040259.3647749-1-kuba@kernel.org>
	<20251121040259.3647749-5-kuba@kernel.org>
	<willemdebruijn.kernel.224bdf2fac125@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 18:12:16 -0500 Willem de Bruijn wrote:
> > +	if (rsp->_count.indir > RSS_MAX_INDIR)
> > +		error(1, 0, "RSS indirection table too large (%u > %u)",
> > +		      rsp->_count.indir, RSS_MAX_INDIR);
> > +
> > +	/* If indir table not available we'll fallback to simple modulo math */
> > +	if (rsp->_count.indir) {
> > +		memcpy(rss_indir_tbl, rsp->indir,
> > +		       rsp->_count.indir * sizeof(rss_indir_tbl[0]));  
> 
> It can be assumed that rsp->indir elements are sizeof(rss_indir_tbl[0])?
> 
> Is there a way to have the test verify element size. I'm not that
> familiar with YNL.

I suspect the reaction may be because drivers often use a smaller type.
But at the uAPI level the indirection table has always been represented
as an array of u32 (I mean the ioctl). And in the core we also always
deal with u32s. The Netlink type is not allowed to change either 
(it's a "C array" not individual attributes so members must be known
size).

LMK if you want me to add an assert or rework this. We could technically
keep the rsp struct around and use it directly?

Not fully convinced it's worth a respin, but LMK.. :)

