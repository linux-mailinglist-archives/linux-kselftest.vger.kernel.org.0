Return-Path: <linux-kselftest+bounces-11217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF78FBC60
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC962866C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962014B075;
	Tue,  4 Jun 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWmS+DUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99A14A4C1;
	Tue,  4 Jun 2024 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528505; cv=none; b=hX25/uSzHF6t8e86UQU26C6MNJGnuXYFmGMJ/ciDwQkEWqOEjMThOaEGYxVz1L66fREa9lShcxBBjcY0nGE34uCwvF9FtkyxWoNSljmSG7rpI+WsC1HM4aMQTKJIofaGVVp67HHguNAAn94vm+gJf5b+yEkIbE+SFq178eH/Fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528505; c=relaxed/simple;
	bh=rBXRLjTjf7FeWEaj103+1QiIcAcZElPeicvgHOve4kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdgYmgCz2FeFMIgyYTjnssemZ0XFy6czCfkcFMIR3R6cxRhHyy5XInESrhnu6cAV9IYNYNvUa8jnYnQwmyeZP/iTVKY7RMnddV2gCtZP60vXHMKwEnF9oto60eeujtUxf4LqNKiRCCgHjCf9cwuShVB+qwpsJNvo0Zw5fCg06D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWmS+DUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E244C2BBFC;
	Tue,  4 Jun 2024 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717528505;
	bh=rBXRLjTjf7FeWEaj103+1QiIcAcZElPeicvgHOve4kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWmS+DUDDL3wyUT5BjTWVZE4kRs7Dq7F0i4dM3ccvbBzopeX364EsuqPYp+mR99By
	 bp7aQZft4XA2v8L8JKHEXnYCjfYQqQoOHM7IvtW0bs8z33OazyzycQYj71+emXOy3o
	 vw/6474UYFEFnSdiFwmtcIdnGUEWSxG6pkE+pyXCtUV5VrRgBqQ0bBTwdJluJck+Gw
	 gMNzEe/vYRdBZJQCH1xYBLYuIo6q7w4qwCKHylyp35WabICQblbbJM8c7368SXNIkZ
	 KAfMnlCBuPN7RdZfScYr2BfqclkkuATUIahpFFcmt9lyTesrxaeMCdGlDBDL1lH7UC
	 6ZZaOeR3VzhYg==
Date: Tue, 4 Jun 2024 20:15:00 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Lukasz Majewski <lukma@denx.de>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: hsr: add missing config for CONFIG_BRIDGE
Message-ID: <20240604191500.GE791188@kernel.org>
References: <20240603093019.2125266-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603093019.2125266-1-liuhangbin@gmail.com>

On Mon, Jun 03, 2024 at 05:30:19PM +0800, Hangbin Liu wrote:
> hsr_redbox.sh test need to create bridge for testing. Add the missing
> config CONFIG_BRIDGE in config file.
> 
> Fixes: eafbf0574e05 ("test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Tested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>


