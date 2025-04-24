Return-Path: <linux-kselftest+bounces-31474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1BA99CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AC1940DB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CD03FF1;
	Thu, 24 Apr 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGkRZzXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436A17F7;
	Thu, 24 Apr 2025 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454348; cv=none; b=N1TVnD8nmhjpC3Z/xIzp3pwocqZIH9YhbLLzO/1GMMjpNz0fKKcwajXzuBwDfUDHfdnJ//wFYPpRCMo9zj7QhdRXV4HeaWxkkN1Kze6T1k+64wyIxMBDO8TmOO6bJNTSfara9bAAEGAfPSf6MLVovJIf3zqb3fsWBWueNcoauyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454348; c=relaxed/simple;
	bh=nqx9oEZK27AYuefLV5zlfdxshKo+A8vLCpMYfJ5Zc60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVmvMIVJdF0M9Ys6IwhNftCzplk6fHWMuAu6PsIN04jut6DepJHUIKfEfsQtqrehPMaHYvErJhDgiwp7gRACd1pjgQYS3dqvw5jvA/vsssIN9+CBHmVcJBymi8DMg/6mI/J3xiBAmwpqWydsFU0gT6IGavRvgpZNNO7UPUws30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGkRZzXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341F8C4CEE2;
	Thu, 24 Apr 2025 00:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745454347;
	bh=nqx9oEZK27AYuefLV5zlfdxshKo+A8vLCpMYfJ5Zc60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGkRZzXTbODmiVhaKrWca5k/M9UOuCrumIQridy4Bl86b52FR4bOLKE6q0k5KIwde
	 jb9KcPBbpCLCcgtxHWsK/cNtcmTjPJPQZHcELFFsQSfUeuuFjCWgxlfHQINmqs2ni4
	 +xIwSV870IpGyvxQwueTRqZnLHSa+8loOJ8buZOMheW8j5vkX7MdcExCP5KqfoPcvo
	 hAmLDQD8uW+Yxyq7nTXscur8h6ulBplo3/ZBijKji6uBByiAUkBJCoICBiQsVmm9av
	 nIa8HKbHj36YnuLJn5hFOOU5KzuFOQEiK8apJNlGUHDDlqRvJVWoc+I9EcG9zDDSNa
	 3tybLROGUAZow==
Date: Wed, 23 Apr 2025 17:25:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, shaw.leon@gmail.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open
 list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] selftests: drv-net: Test that NAPI ID
 is non-zero
Message-ID: <20250423172546.32d2da09@kernel.org>
In-Reply-To: <aAmAbcbLMl6IBwpd@LQ3V64L9R2>
References: <20250418013719.12094-1-jdamato@fastly.com>
	<20250418013719.12094-4-jdamato@fastly.com>
	<20250423161612.3dc2923e@kernel.org>
	<aAmAbcbLMl6IBwpd@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:06:05 -0700 Joe Damato wrote:
> # Exception| Traceback (most recent call last):
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> # Exception|     case(*args)
> # Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/napi_id.py", line 13, in test_napi_id
> # Exception|     with bkg(listen_cmd, ksft_wait=3) as server:
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 130, in __exit__
> # Exception|     return self.process(terminate=self.terminate, fail=self.check_fail)
> # Exception|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/utils.py", line 78, in process
> # Exception|     os.write(self.ksft_term_fd, b"1")
> # Exception| BrokenPipeError: [Errno 32] Broken pipe

Thanks for testing! Makes sense, I don't think it's worth complicating
the Python side to handle the "ready but no wait" case if it doesnt
work as is.

> LMK how you'd like me to proceed ?
> 
> I'm thinking:
>   - Leave ksft_wait()
>   - macro guard
>   - don't deploy helper to remote machine

SG!

