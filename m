Return-Path: <linux-kselftest+bounces-26851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D6A39DB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 14:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458FB1656E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9626FD88;
	Tue, 18 Feb 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4hpbTSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58B26FA44;
	Tue, 18 Feb 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885350; cv=none; b=uXz95558ODBy5MR1dGEjGLI453Y7yLFFilS22g6PRcwvC0XF7Q8QmZzDpSBZpcmtMtu4qGG5lqQfgefDCkyLgfmZ6diqpR9ZPYUd5YxCmns9a/s98WdkUvEQfhm6tq8C1CEdNqyV9yhbIUOSzEE3bNrEl1OP4bHtERQBVNdeWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885350; c=relaxed/simple;
	bh=D+giwnx2fldVt2NPCnwByiTTAhof1N0hesdxo6LjBJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQsQ2hI/fUD5LIOEdezEzyGf/nT6xaIcaraYh1xSL9OoYQk7fxno6bN827V4wGk7dwYCcmSMYNUkyc6TTzYtpG09fv8KxsHcbiFh0O01uIFckjrS1KyGgmOUpHfY8ijVupU3cUCmaj9N0Kdk3+msdXwURIi5QT1W4LFzos65t8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4hpbTSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD522C4CEE6;
	Tue, 18 Feb 2025 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885350;
	bh=D+giwnx2fldVt2NPCnwByiTTAhof1N0hesdxo6LjBJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4hpbTSPtTh3MMtyZt88Vf46BaWKT+sSyPtxQJOZqD89A4ZQO8FsNVncvcAR0Lhz5
	 /nFUVxvSTo1BXCTN23SgZDvUOE33B2Li0fZsPelUexQlviKxP/aM8oaeY5FcY/Y2FM
	 lf8s495WAAbSt7lBcgTW2XhIfbFQtbSyWMu9yveB1RQvJboxBzdfYNFArpytp079Cn
	 DP8Z1sJSYTZnrqRbuUn9DPsNn+HxZhx4abMPO+6QvN689nHDFsuS56VcmBVokRu55C
	 s/PMGVlT6YzQkJKAsNQ9l5+2ZEDWFnLSjwoVV2MQBw15SaHVzcZuP2+X6TFXOj2Qu8
	 GCs/vV5uSsDvg==
Date: Tue, 18 Feb 2025 13:29:05 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the various
 dec/hex number parsing digits lengths
Message-ID: <20250218132905.GV1615191@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
 <20250213110025.1436160-9-ps.report@gmx.net>
 <20250214201145.2f824428@kernel.org>
 <20250216091739.GW1615191@kernel.org>
 <20250217094740.76a25671@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217094740.76a25671@kernel.org>

On Mon, Feb 17, 2025 at 09:47:40AM -0800, Jakub Kicinski wrote:
> On Sun, 16 Feb 2025 09:17:39 +0000 Simon Horman wrote:
> > On Fri, Feb 14, 2025 at 08:11:45PM -0800, Jakub Kicinski wrote:
> > > On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:  
> > > > Use defines for the various dec/hex number parsing digits lengths
> > > > (hex32_arg/num_arg calls).  
> > > 
> > > I don't understand the value of this patch, TBH.
> > > 
> > > Example:
> > > 
> > > +#define HEX_2_DIGITS 2
> > > 
> > > -		len = hex32_arg(&user_buffer[i], 2, &tmp_value);
> > > +		len = hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);
> > > 
> > > The word hex is already there.
> > > There is still a two.
> > > I don't think the new define has any explanatory power?
> > > 
> > > Previous 7 patches look ready indeed.  
> > 
> > This one is on me. I felt the magic number 2 and so on
> > was unclear. But if you prefer the code as-is that is fine by me too.
> 
> I agree that it's a bit hard to guess what the call does and what 
> the arguments are. To me at least, the constants as named don't help. 
> We can get a third opinion, or if none is provided skip the patch for
> now?

Yes, I see your point.
No objections from me to skipping this patch.

