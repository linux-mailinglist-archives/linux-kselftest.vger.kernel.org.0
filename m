Return-Path: <linux-kselftest+bounces-46173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A3C771C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 64A312C17A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C16244694;
	Fri, 21 Nov 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBa4+W/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821B21578D;
	Fri, 21 Nov 2025 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694234; cv=none; b=BgeT9Bgf77tyRLgNG4aWby+t7oioWKnGdzCxzNuX9EZecteOut9MN1NCYSRXa+ojsqwZMHy2556iL5reWlsSGsbWg6izEmzQWfXqSQo4PAQ7J2AFpZxMo4tZKx7wThMro4VfLsdahR0aadVTFs45gk3k4JPLhPn+y8lUPTL+F+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694234; c=relaxed/simple;
	bh=WEjTR9BmAKQiJ3tfB4Qnx2N/WVk4LVRDE0lbPpzpF6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbfCSgnFM0bdli+yNG63b5HA/Rtc2hKNXFQieLKTlGpRz7YshROd7uca9fT3ZIKkM0tOKdQc/C/fFSfVBvVztvfHYwKXK2u8+l+yxr9m8qG1kebD4xjgvWTT1TmAniOu6mG5WNw++kUn1Ug5Zwcuu1Fc3euAnU8hNUlihY70LN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBa4+W/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B1C4CEF1;
	Fri, 21 Nov 2025 03:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763694233;
	bh=WEjTR9BmAKQiJ3tfB4Qnx2N/WVk4LVRDE0lbPpzpF6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBa4+W/Mo07GqzFi2W3CIbNkUyht/WlSuWszBXD3fZCX6oRvybC/GEhBSXdLJVyGn
	 xLBai6gSc/sYZuY+azVfb6UOT71aABTPxv1s3MA5t10i5ruzol5BKkw1IgPP+V1Kvs
	 pISC9TuDPFD8bJWD4NtVuDFA7mVQt+fvayNC1J9xQ0yd/fSKwbCZ+w4bcSD+niqi6S
	 3DA6SOtbhgVufcnC6lqFFm79rcKiOuotA9xIaepR0jp71BMGsqR/FlPZPC2QXxmcFt
	 hX4xY4yqRx3EIMQzKlh3E+ijpvymn9PfEKCz/qYEPzLYo5wKOHOhGtG8h6J2MN8cCH
	 HbOIk8UNEKong==
Date: Thu, 20 Nov 2025 19:03:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] selftests: drv-net: Add
 devlink_rate_tc_bw.py to TEST_PROGS
Message-ID: <20251120190352.45f72431@kernel.org>
In-Reply-To: <20251120095859.2951339-2-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
	<20251120095859.2951339-2-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 11:58:54 +0200 Carolina Jubran wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 8133d1a0051c..2f53eaa929b7 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -23,6 +23,7 @@ TEST_PROGS = \
>  	rss_input_xfrm.py \
>  	tso.py \
>  	xsk_reconfig.py \
> +	devlink_rate_tc_bw.py \
>  	#

These need to be added in the right spot, we wanted them sorted.
Otherwise everyone tries to add at the end and there's a lot of
easily avoidable conflicts.

