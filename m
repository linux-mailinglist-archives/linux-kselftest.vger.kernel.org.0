Return-Path: <linux-kselftest+bounces-23966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA7A033C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 01:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513B1883C5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAC1372;
	Tue,  7 Jan 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwn50yGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C76A31;
	Tue,  7 Jan 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208415; cv=none; b=vBYYaBr/Cb1QZnrmHwEMsprU2rZLEYlxw44tcxWIyNBNbAixNlruR1DLvxPTFBAzWcL/R6IrW24Xjrb1uhDR5zFFQkmbw+lmZ3NmmmuyFTuS5MSUU+mQOh9YB0S95gUik5gkEkFofkFIz2ap2f2K9pqkorOVM5vuJo7prbFtp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208415; c=relaxed/simple;
	bh=I4Yoo47bRGcKoqhoUKi/FMAlUTxnX0nquhi0qSZakJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqJ6NUCzHuyR0p2rUmuSRPx74vyQKu6HUqu5+5Z+EeI9Sc4y7WdeQRPoiKzANny3xm/aWsdEUpjh8N00rhumgF6dsUE+7uHMB2Hn6Qo6BiMF1eNzmPSV7mdNn5dg9nS1dqvCUavVy3J0lf1PABhWg5/fFlMQ4JPBrJou0D+A4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwn50yGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EFFC4CED2;
	Tue,  7 Jan 2025 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736208415;
	bh=I4Yoo47bRGcKoqhoUKi/FMAlUTxnX0nquhi0qSZakJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jwn50yGxrWhl9m4d/1QP9UY4zODilNkVvdDU81a8anC+CPqukrFCVKB6ybmlgriVB
	 czXVQcoB+MQO1CviyP9rX3NS3t8fqyYV+XTQao+VWiNAoMVIurBG4D5lgBEIrdFODK
	 dUPmDLYANyRv6GDcW/IIyoMdcyeTvDQcFBvHQG1fjU5fnxBJZuLy6h1ca5oMu4Jgfv
	 bdsGs5zz0h+A7ts4NJn1iIOr9iQ5w93/omllkwdilLhzs1BHbUujjswH9np3WeZDHN
	 QFDrbU+Q2qKW7fuc6JEALupJwyBT9EwhrBhGngAWvNk/NqTCKZYK6lxD0i2eoDboey
	 YIIshyiMH3QMw==
Date: Mon, 6 Jan 2025 16:06:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/4] netconsole: selftest: Split the helpers
 from the selftest
Message-ID: <20250106160653.2fcdb192@kernel.org>
In-Reply-To: <20250103-netcons_overflow_test-v2-2-a49f9be64c21@debian.org>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
	<20250103-netcons_overflow_test-v2-2-a49f9be64c21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Jan 2025 04:57:50 -0800 Breno Leitao wrote:
> Split helper functions from the netconsole basic test into a separate
> library file to enable reuse across different netconsole tests. This
> change only moves the existing helper functions to lib/sh/lib_netcons.sh
> while preserving the same test functionality.
> 
> The helpers provide common functions for:
> - Setting up network namespaces and interfaces
> - Managing netconsole dynamic targets
> - Setting user data
> - Handling test dependencies
> - Cleanup operations
> 
> Do not make any change in the code, other than the mechanical
> separation.

You have to update the Makefile, we don't wildcard all files under
drivers/net/lib, the lib support in ksft is not great :(

$ make -C tools/testing/selftests/ \
	TARGETS="drivers/net drivers/net/hw" \
	install INSTALL_PATH=/tmp/ksft-net-drv
[... noise ...]
$ find /tmp/ksft-net-drv/ -iname '*netcons*'
/tmp/ksft-net-drv/drivers/net/netcons_basic.sh
/tmp/ksft-net-drv/drivers/net/netcons_overflow.sh

.. your new lib file won't get installed.
-- 
pw-bot: cr

