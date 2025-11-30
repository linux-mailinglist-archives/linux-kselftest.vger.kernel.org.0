Return-Path: <linux-kselftest+bounces-46763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7EC95170
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74EEC4E02ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653ED280A5B;
	Sun, 30 Nov 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjjdvIK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A427F724;
	Sun, 30 Nov 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516753; cv=none; b=WwRlYJKkBMx31wwrIPDj2Y+xHyHwYcr9QPTmz+SiKvLf1t3lBORm+W5UjVBbDalYfkQio6cnJb/HmC1e8tdw8NpTa5KH2OFjdJY7yssGdKcHEevHVqllnutC0zx+qDH9A7WsPJWjXI4Vh8wNRW6Gpxu09uxmKfwTBadaFSEjNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516753; c=relaxed/simple;
	bh=9SvF9uWPRIYcLvM5S/gX325tT8UE0BVSDIN4NlPatds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQm8Dl+5FfF3n0o/1E5ut2YSnd3K+z9nMUxn62CtAIIroRGZqvc8was/3or/nmIHaYKsA0AEM7sU2ZDZi3wEa6OYOMYPnkLrtH7hzixCLTpuVp5Y3MmqTu+S2ZY+wplWLuPnOQUU/JPm5o8ib5UxKTdNYm/TaTNESdPGDENF4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjjdvIK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE1C4CEF8;
	Sun, 30 Nov 2025 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516752;
	bh=9SvF9uWPRIYcLvM5S/gX325tT8UE0BVSDIN4NlPatds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjjdvIK+JPqFKzmwCqrG4khzmHKPKRTdL2FbQYNLHkSFciY5qzmfgZJqm/CtxeiM6
	 WIxL2+lM2AcTg8CqLNjDCUa2FrN5pNFYpIzA2yDdGSNbPp5791MKerjWS+nlXw6nS/
	 YvwKToqwrm4ZOEL0Jg//9wNOEpd1XqYByigUpVWcnvGMWp8iS7VMuH0SpZr39JZ1Ll
	 erZU3Rp9EP8W6aQZdN1od0D8+wUjkcOeO380Hd+GQ4oNDME4AAO0BaX6+jIVxyuEI1
	 sf+x39oKi5nx/egTNRlFsE0XhiradjRS8z5IIPt+Xsy2e4Hk89BHHgsZLOJElqEof5
	 5n4v+x9stxbPQ==
Date: Sun, 30 Nov 2025 15:32:27 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/4] selftests/netconsole: Switch to configfs
 send_msg interface
Message-ID: <aSxji6IZ4Arb8pQi@horms.kernel.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251128-netconsole_send_msg-v1-3-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netconsole_send_msg-v1-3-8cca4bbce9bc@debian.org>

On Fri, Nov 28, 2025 at 06:20:48AM -0800, Breno Leitao wrote:
> Update the netcons_sysdata test to use the configfs send_msg
> attribute for message injection instead of /dev/kmsg. This
> validates the new direct message sending functionality that
> bypasses the kernel's printk infrastructure.
> 
> Only move this test to the new mechanism, given the traditional printk()
> flow continues to be default path, and the one that should be mostly
> tested.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


