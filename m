Return-Path: <linux-kselftest+bounces-3505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F234A83B6CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6942860D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81DECC;
	Thu, 25 Jan 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXom1+Jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22F1369;
	Thu, 25 Jan 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147149; cv=none; b=YWimmu1Ce8smdRC8icX9YQZT5uToJYWtgKRvxNXEULT8eepmhL2TJSdk0W/vPbz062Xwb95flLpvhceBv0/bo2mjRv5tNeOq2ByvjNnx4eQCM5zEh9BMCZ8xpPt4+KfZTj0pIA2jJWyd8XU+aTA5RFzD06EykQXIWCB5dNJGPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147149; c=relaxed/simple;
	bh=AHVxcRAPR6j6IDs89kAwDqotYq3t/0Kc95kcISPXyck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqlZgTag4TXUuM9GyCwm6CoQI+vjXnAsWyi8FxFQ5XDj/Z7H3hD2nD3TRaUudRpec7V1y4rml6A+MTMZyazlbNeDDZLpWYe4DZ8XjntWwmLLyNk1m90q0XCCraLSg/VslJcCTWKxW9dZIz619wcSc2a5TvWD8tyzBuAXVfOzYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXom1+Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9192FC433F1;
	Thu, 25 Jan 2024 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706147149;
	bh=AHVxcRAPR6j6IDs89kAwDqotYq3t/0Kc95kcISPXyck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oXom1+Jyy95p+9ZapmImf9CsVaPyt5ZfVCADIqTGwbhUHmNpXnJrpXjm6wwrZRFn2
	 RxFLVojakgH7We3m+d7qL1ZOSj5Qgbn5x/yMjJH7rjx/t5gTiF+bQafltjxm0k2A2g
	 GzvESYT2MK7cb5e4ZJXj3dZLXQNYr8CMsFTGM2lnvahncYiIJAQ163LP5fIYlR60My
	 v3nLd26TREm+SO+WpV5unGsdlX0+hPqcwbCwmf5h0p9T5BksNmOVT1kLdcMEcP6Psa
	 VLgqTaPGEd6HJBbdpm4lodn/SmcAwzupKy/P1/cv519tGNs7W8lJiaZyC09KAQMJoo
	 i4lAYa6Pd1JVg==
Date: Wed, 24 Jan 2024 17:45:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Lucas Karpinski <lkarpins@redhat.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/3] selftests: net: a few fixes
Message-ID: <20240124174547.3325d7bb@kernel.org>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 22:33:19 +0100 Paolo Abeni wrote:
> This series address self-tests failures for udp gro-related tests.
> 
> The first patch addresses the main problem I observe locally - the XDP
> program required by such tests, xdp_dummy, is currently build in the
> ebpf self-tests directory, not available if/when the user targets net
> only. Arguably is more a refactor than a fix, but still targeting net
> to hopefully 
> 
> The second patch fixes the integration of such tests with the build
> system.
> 
> Patch 3/3 fixes sporadic failures due to races.
> 
> Tested with:
> 
> make -C tools/testing/selftests/ TARGETS=net install
> ./tools/testing/selftests/kselftest_install/run_kselftest.sh \
> 	-t "net:udpgro_bench.sh net:udpgro.sh net:udpgro_fwd.sh \
> 	    net:udpgro_frglist.sh net:veth.sh"
> 
> no failures.

This series got into net-next-2024-01-25--00-00, looking at the outputs
it turns out that the iproute2 was crashing somewhere in libbpf :(
I rebuilt latest iproute2 without libbpf support. It loads xdp_dummy.o
just fine, so hopefully that's good enough for now, we'll see for sure
in about 3 hours :)

