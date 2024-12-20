Return-Path: <linux-kselftest+bounces-23648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE129F8E9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18667188ED81
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9641AA1F4;
	Fri, 20 Dec 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OOm3UNH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF61A0BED;
	Fri, 20 Dec 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685756; cv=none; b=cgqdmq2JrgdsNeyehNcmHYBLmyGOu/UxOaFDc3jWE5lS4egpOixWrL2BwaABHiKaZ9OoWgOO0V2AJU5TOAwJLdIcphMfir/95Wa9VafyD//6l4RpjAzkZ9qU7BOk0jeLs4N7L+RlxYmp+c706LUy/ODZpKGPbOySU0eHW0dvrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685756; c=relaxed/simple;
	bh=Xb7KT61jJgZO2Tg0EvUGSo0SO7JHi3VFIJn/QKeIgXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcoG3Bu1VpgbLB+WPsNFWRN974OhPHZpwXncVOoGkJJB82eJjAN2/M4SACQWcIP+PRALo6eCIcGbb/TSvw5Pi4iOwsJbfLGor25IkJka7bTz4b6ri99VvsGWsCfnWhWYM+W/5g9A+jrygKd+rXL6WFCFUVxr2+YVD7OgMbOt3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OOm3UNH9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N8rdmGGLvK0LXtWYUxQUyuK9ddF4H5fIrx2FjLjKJ9M=; b=OOm3UNH9ea3TGSkPD1tyQxS3Ft
	d65wOst1zG6TT95O2hBA8yJkdTILbA1ypscoHZfo4E++Idmb/6O1dl8vt/mLNvwBsMQYIu4vpeixw
	bEayBCjrxz5pfEUHm8NquhdyKv/EhUOzxaFtjc+mdeD3RqZeUEDUEgXB3tWOWI0tloqI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOZ0M-001vwF-D8; Fri, 20 Dec 2024 10:09:06 +0100
Date: Fri, 20 Dec 2024 10:09:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
	petrm@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: assume stats refresh is 0
 if no ethtool -c support
Message-ID: <e933e67f-66f2-422b-b00e-09ae788ed51d@lunn.ch>
References: <20241220003116.1458863-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220003116.1458863-1-kuba@kernel.org>

On Thu, Dec 19, 2024 at 04:31:16PM -0800, Jakub Kicinski wrote:
> Tests using HW stats wait for them to stabilize, using data from
> ethtool -c as the delay. Not all drivers implement ethtool -c
> so handle the errors gracefully.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/lib/py/env.py | 9 +++++++--
>  tools/testing/selftests/net/lib/py/utils.py       | 6 ++++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 1ea9bb695e94..fea343f209ea 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -5,7 +5,7 @@ import time
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
>  from lib.py import ksft_setup
> -from lib.py import cmd, ethtool, ip
> +from lib.py import cmd, ethtool, ip, CmdExitFailure
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
>  
> @@ -234,7 +234,12 @@ from .remote import Remote
>          Good drivers will tell us via ethtool what their sync period is.
>          """
>          if self._stats_settle_time is None:
> -            data = ethtool("-c " + self.ifname, json=True)[0]
> +            data = {}
> +            try:
> +                data = ethtool("-c " + self.ifname, json=True)[0]
> +            except CmdExitFailure as e:
> +                if "Operation not supported" not in e.cmd.stderr:
> +                    raise

How important is this time to the test itself? If it is not available,
can the test just default to 50ms and keep going? I would of thought
we find more issues by running the test too slowly, than not running
it at all, unless having the wrong timer makes it more flaky.

	Andrew

