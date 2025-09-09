Return-Path: <linux-kselftest+bounces-41060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47591B505CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015F5561CFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045863019AF;
	Tue,  9 Sep 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYicwdvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103D3009F7;
	Tue,  9 Sep 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444610; cv=none; b=pZmFyp1pWMUX68UeyefVkKQnNpttK2FWJazZXnF8p5ZB3bgN1qUpN3FpL6ETo+KUgtLNYIJbpmWurjxvsym9dCUoTPzHlE2Z/0W94wv+2JCnQecfxkPgfZWijbMa5vUWEsX8UqDWgr5hj8wejFhg1Ct/OtbzPTCjSRFh7dVCo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444610; c=relaxed/simple;
	bh=iQ2hGEIaFfNxNx3BhJMnrqdW4TZqrof8lMc5P3dIvXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUom5EtfvgVzMDhCXJ9ZPaNIxE2Y6c8M/M+531tTHy5IGeStaMagFQ4AxWnSLEA+W6hgwE59f3pUVW0ERRSKSpJDovFYGs2gpLdaYvWZvtgyzgzIpZTJu+qmtf5J2erBPrs8eS+hy5GzafppNLZOgDI+cKskBxlcKxxBdrrN1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYicwdvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4089C4CEF4;
	Tue,  9 Sep 2025 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757444610;
	bh=iQ2hGEIaFfNxNx3BhJMnrqdW4TZqrof8lMc5P3dIvXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYicwdvOmjWT1Dq6UAJeXBSgJ4KfbqCpNC5tMrV0G0JnCHKUnYLD6mytrDTZYigFo
	 uJnodv7UqXfrHLM+NhKk3qrg72hH0morH0BJa0NifP/yLE1avYHJ1znVwil2fug2RL
	 h6zo3VI+on5W5891blflhISF98niUWJ4dPEDM9UJ2orO3gv1rodLea9kznEbeI1Yew
	 uhWC0k2rdlBBDgc6769JCQiyaJ0Mg2e3g9R754PYEfIrDJd8CKSOJJ3rtUN5oXX5rc
	 55hCYGuhYlC63fWKQUo3SVyCFQ8IK4lJHtL2TBjhFGFZjTYsi5qqvE6cDWZRbszoSC
	 5WUOfF4u6JfDQ==
Date: Tue, 9 Sep 2025 20:03:24 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] doc: mptcp: net.mptcp.pm_type is deprecated
Message-ID: <20250909190324.GE20205@horms.kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
 <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-2-5f2168a66079@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-2-5f2168a66079@kernel.org>

On Mon, Sep 08, 2025 at 11:27:28PM +0200, Matthieu Baerts (NGI0) wrote:
> The net.mptcp.pm_type sysctl knob has been deprecated in v6.15,
> net.mptcp.path_manager should be used instead.
> 
> Adapt the section about path managers to suggest using the new sysctl
> knob instead of the deprecated one.
> 
> Fixes: 595c26d122d1 ("mptcp: sysctl: set path manager by name")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


