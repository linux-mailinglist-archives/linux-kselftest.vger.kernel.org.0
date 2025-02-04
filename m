Return-Path: <linux-kselftest+bounces-25686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101FAA274A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DB162FE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5992139C7;
	Tue,  4 Feb 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fufBaa9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B572135B6;
	Tue,  4 Feb 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680253; cv=none; b=uLWE9zDOIxstajt62RsFjb9DN4HSv7Yhc2twaNjUBq4sfYxnXeMT5bo1WO8RFSnfdUo6/r/uaexZZNerknoNmFRvWm+MhpOnNQ8wTm5GH6mVUWAzg0sS20GmNb5ub6sulGvsI9dIRObSHEMrpAkkESrfFlli3M38pw8Rt+GwmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680253; c=relaxed/simple;
	bh=HjgJuqRBAsCpl5rgKcK8HEQk0hBearQ1YuiXJmiRW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT+YwCJb9860ck/8mw6QzUxSsWJqspuo3113/dKaBiuEBpm2R3ELRk6eU3eSQuFjApg6IbR2obLHzuCBV7zQeRE7qkpiaYaM05PAceGtMQUUEixZb27MnQqYsdnkor3s/x0wcLlP/4Vg6J6hEVw1947j/1X8Z2t4bdaxPDpZrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fufBaa9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F8CC4CEDF;
	Tue,  4 Feb 2025 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680253;
	bh=HjgJuqRBAsCpl5rgKcK8HEQk0hBearQ1YuiXJmiRW2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fufBaa9wSo5aQCu83LSk0GRPucGI0ysKECiyyNOyMXsaVi3CzuApLYEPjr32mDbiq
	 SnRqqcnPobWetOe9++PTjF7Vpiy79Ue9CFgUxbVOs3DAO0Es0U6ArcoSZRzdGV1lzN
	 zvsp9xesH+PH8bEtl/hgIz2B715/xpPqEfoRGaVh0C4wBohDTKzzeF/JuthVb6m1xo
	 kuvGxpPbjViCnSVt3iRxSREYt5MVdcrefcYR8s1LtkVWEJ0vg65w6gwnjnfGlSll1L
	 Cf2KFrdDOpLGK067b6c0c9zHzC5K5XDXIC/oqihP8+XYzwvl+vYZZsyoaFjWLWCU2d
	 bZ1Xy+5mCVGIw==
Date: Tue, 4 Feb 2025 14:44:07 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 04/10] net: pktgen: fix 'rate 0' error
 handling (return -EINVAL)
Message-ID: <20250204144407.GH234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-5-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-5-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:55PM +0100, Peter Seiderer wrote:
> Given an invalid 'rate' command e.g. 'rate 0' the return value is '1',
> leading to the following misleading output:
> 
> - the good case
> 
> 	$ echo "rate 100" > /proc/net/pktgen/lo\@0
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: OK: rate=100
> 
> - the bad case (before the patch)
> 
> 	$ echo "rate 0" > /proc/net/pktgen/lo\@0"
> 	-bash: echo: write error: Invalid argument
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: No such parameter "ate"
> 
> - with patch applied
> 
> 	$ echo "rate 0" > /proc/net/pktgen/lo\@0
> 	-bash: echo: write error: Invalid argument
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: Idle
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


