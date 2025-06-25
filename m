Return-Path: <linux-kselftest+bounces-35801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF15AE9070
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 23:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298406A2173
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA224A049;
	Wed, 25 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwuqaO0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD81FDA92;
	Wed, 25 Jun 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888098; cv=none; b=GVh/VnDonpyPzweauAQTfR8qPy+USQbHoAQwz0qNvVr71SOpKwQdBe3TH21P5VP1MhZxjKAziJGA3nze9Yd1DnesmfQ9f8MNMZn5q6sra+SRh0mfEMYIR+gJ7+reZoPFtvoc0y5P86kFedy7+qLQsAtc9m6caincJhuHLAhP76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888098; c=relaxed/simple;
	bh=um6BUp8ZIraMQ5ILhZnXpFvINYZdgysmyLL8eE8Q24A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rcyvh+TS6SvYzuvHbXnyIvN58Q56IlyablMYaqu8u6rhpDxR/W+moIK4OiLCWCQuuNU2TNuSPkypMALDBEXvfCJCNUZ4w+6nlmPhkp2VSoXRkgTCNvUs+yvME28V0uXW6phjuTeJQ1JRHw3BfL3AIE2NkO5dASnvZuxuByK/jBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwuqaO0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608ABC4CEEA;
	Wed, 25 Jun 2025 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888097;
	bh=um6BUp8ZIraMQ5ILhZnXpFvINYZdgysmyLL8eE8Q24A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pwuqaO0i/iOTC31zQ/BIndshaB7Z9mB5QJ1ZHR6jsbFkXojnFVfENuwAGogWNanq/
	 2BtcV/HZutAKdjNMBQRGi5vxR3gnBQ2vSQiQD6/Xf0jyI2G4+HbFxNri36e3WfVgMs
	 9S10vGf8BZSy3inbwtmddjmYJkETWCogZLwPZGKTx6U93Tlzqvngp8umiYmCvh6TN1
	 HltKmwD22lLpsLWFz+7zDC7lMTU0RgcMNMK35hYVYU3RovsFGmMi8OLJD8uyg/+ESk
	 rGw8Qvg6l0Nell2M4MPSGbjj1qoJYC41r2Ipkrg6H6Bjma8DL32KkPOlgY3n4WRQJU
	 azr+DIT1NpYZg==
Date: Wed, 25 Jun 2025 14:48:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 2/4] selftests: drv-net: Improve bpftrace
 utility error handling
Message-ID: <20250625144816.5cbc9298@kernel.org>
In-Reply-To: <20250625-netpoll_test-v2-2-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
	<20250625-netpoll_test-v2-2-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 04:39:47 -0700 Breno Leitao wrote:
>      cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
> +    if cmd_obj.ret != 0:
> +        raise Exception("Warning: bpftrace command returned a non-zero exit code.")

cmd should already raise CmdExitFailure, unless fail=False / fail=None
is specified.

