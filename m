Return-Path: <linux-kselftest+bounces-32864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902ABAB3CF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F206C3ADC54
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B224678B;
	Mon, 12 May 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI+Yh7CY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172E1AAE08;
	Mon, 12 May 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065888; cv=none; b=ESEmdjcPoMmG3kFvyL9OC9KmLwU/QsqgKRLp5o4EbVb9eiVhtCCV4Bu7XfyCqDgwx+ibwUld3q/uVm9vXggBjIQQGEyGfaJ5g7xguxIl2HjhWfizj0cLVI41EeQ+lpLjHUbFILW2nAOIgkTnrpuJhxDncyn42LIsxLe33jpUTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065888; c=relaxed/simple;
	bh=YNJLuBUch0gQZHGpZ8TsSdIDtl8EnAKsPqt3r1Jj5pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyVttX21E2SK/8cRMa3jp1Avmbsu+9wJUPB7IGoBidgBtqw1qyAcNnjM+4JeD/17xgzXJJoy5SU1ydBhh8EPZ8ehMvLWSLU7O8hF+4j3GeRujLsfbL8drFT16q4fAfcDzaS3gnx3ftGv+Xt7bNzVMP695W5nR/lI4Ep3oqJZ/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI+Yh7CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4087BC4CEE7;
	Mon, 12 May 2025 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747065887;
	bh=YNJLuBUch0gQZHGpZ8TsSdIDtl8EnAKsPqt3r1Jj5pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kI+Yh7CYaMW6VxZkaGYPNMZKeCzt3pXVoD1sldfEVr/+oEimShg0ldPVXVaxJHCOi
	 1G19j5o/IPOB/dL/NJkuhway/j2Sac9Fujj93MFxrK8SKUmKTOIQS6ZF45+07O5/Sn
	 UbCTgKn2d6U7/mcQvbGbPvT+xY+ng2yB2yC1xc6NPBy8MwF6b1VhmPr8pftBXFQS9j
	 d8vCe+VrSnTyfJ7sCQsiA51vVGTaUXhYo+qZyYvPNg8/KCkdfM7yppxr07E4lmltNF
	 ldLV47Aa2j5yn7h7QuHBq6tf/w/FVzSfHdXiN4f8YZ0gj5lTHRwxGMuCYOHKry2e1U
	 NViCzLNLIZjUA==
Date: Mon, 12 May 2025 17:04:42 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCHv2 net-next 2/6] selftests: net: remove redundant
 rp_filter configuration
Message-ID: <20250512160442.GP3339421@horms.kernel.org>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
 <20250508081910.84216-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508081910.84216-3-liuhangbin@gmail.com>

On Thu, May 08, 2025 at 08:19:06AM +0000, Hangbin Liu wrote:
> The following tests use setup_ns to create a network namespace, which
> will disables rp_filter immediately after namespace creation. Therefore,
> it is no longer necessary to disable rp_filter again within these individual
> tests.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


