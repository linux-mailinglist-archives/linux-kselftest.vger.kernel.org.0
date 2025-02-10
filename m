Return-Path: <linux-kselftest+bounces-26190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CFA2F2DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC527A15DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022C2580F2;
	Mon, 10 Feb 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdCLOvbU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887C2580ED;
	Mon, 10 Feb 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203992; cv=none; b=eBFLh7QFGqFeTS1YDdyl0NTypHLduBpqRp7xBDJyW6kUL3geonhTlYlinESP7GA1+f0pJxwoH+QZz7/Tw2yrQZ97T9ES60u3ETxTluqGdPbswaOj/W3BjTARNidIBx8kywF7LGnyYjUKIKeJTwLOCZw1LVXTsDX05rlbUJ6FQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203992; c=relaxed/simple;
	bh=njbEBtO+APS2dMkxHHNmNtrDbBbgDkmpalI/rHwsvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKX+ZKr+AN+NVE8JHpYfuvpt42z5nd41YH6zmrZi5pOhffownPbqZMejyIWeyvs/L7L83Wxlg0lQUO45ViKoVIzXu/5WBp/6cH2TXn/VuU0Xvtib326+6A5tygVSjQAOYS3ps+Tx6jtWIj2pOpvS1ruEx4VD3ccn6iO3WTKSwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdCLOvbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C409C4CED1;
	Mon, 10 Feb 2025 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203992;
	bh=njbEBtO+APS2dMkxHHNmNtrDbBbgDkmpalI/rHwsvcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdCLOvbUtNEwcw1d37t8oNlBJYGK1xDgqHQa1h5j3RuxZjdMV55Rv1r2qLOSQ8dOZ
	 gFbBZx0jP2d8VOWqGGS0/8OG12JHJB/t2lJBJ2nBmmou0J4hmXS9Xbbv2OHkf87ShT
	 ssWQZWzqWbyCQqeo1T3X4gHP2QUYunEY/ANkuQkg7um/W8c4S+yyun9OOl2wjh/Va4
	 g/v5b8Qj6XNbY/oyIQY44BsI71JQDoSavD8jtCIgZZBklQTykOxmJLc84lqjDj7nd9
	 gwnzh6jtG2oIEcRiTZK6bbZaZKOGNLZErnQy29ImbyWdXCoo6+4DIp46+fyJgxnFc9
	 sbhbUDijofj8A==
Date: Mon, 10 Feb 2025 16:13:06 +0000
From: Simon Horman <horms@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v8 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
Message-ID: <20250210161306.GE554665@kernel.org>
References: <20250207110836.2407224-1-yuyanghuang@google.com>
 <20250207110836.2407224-2-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207110836.2407224-2-yuyanghuang@google.com>

On Fri, Feb 07, 2025 at 08:08:36PM +0900, Yuyang Huang wrote:
> This change introduces a new selftest case to verify the functionality
> of dumping IPv4 multicast addresses using the RTM_GETMULTICAST netlink
> message. The test utilizes the ynl library to interact with the
> netlink interface and validate that the kernel correctly reports the
> joined IPv4 multicast addresses.
> 
> To run the test, execute the following command:
> 
> $ vng -v --user root --cpus 16 -- \
>     make -C tools/testing/selftests TARGETS=net \
>     TEST_PROGS=rtnetlink.py TEST_GEN_PROGS="" run_tests
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
> 
> Changelog since v7:
> - Create a new RtnlAddrFamily to load rt_addr.yaml.
> 
> Changelog since v6:
> - Move `getmaddrs` definition to rt_addr.yaml.
> 
>  Documentation/netlink/specs/rt_addr.yaml      | 23 ++++++++++++++

Hi Yuyang Huang,

FWIIW I think that the YAML spec entry is distinct from, although a
dependency of, adding the test. I would put it in a separate patch.

>  tools/testing/selftests/net/Makefile          |  1 +
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +-
>  tools/testing/selftests/net/lib/py/ynl.py     |  4 +++
>  tools/testing/selftests/net/rtnetlink.py      | 30 +++++++++++++++++++
>  5 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/rtnetlink.py

...

