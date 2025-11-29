Return-Path: <linux-kselftest+bounces-46714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6DC934E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 01:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2730F346965
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5136D4FA;
	Sat, 29 Nov 2025 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpkkENlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54236D4EF;
	Sat, 29 Nov 2025 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764375095; cv=none; b=pyxSF5VPxi0Rws/n1oxEUJmnz9f05jp6Y+M54kMADRPcI63a6JDHzad2leTuewjv1P5CsEw9d0MHECDmXvnwMz/wdzQC50Xy/f+geaZUlo8Ahlf0xtPWcAGMRSUqSJvDaSeB2cJCilh/mIS0cgn5IE4xkbS7a/gSx/j+2Iroqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764375095; c=relaxed/simple;
	bh=OSasR8ewzfvwBSYQRlOYFDV1Y7zX4rRh1J9TNkUwMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQIjAKVGmMYhhsTWISXXenQh0CXNNrvxitJoWH03rmjBEvKFEv12vHm4rZ6oKdhMLf8JYPablZGPf7fVTR+KD+VR3a8FmYxP5frXPzrhrV4+NLu8ZxJnH+t4rhbPd0aCCvbnq8x5LvvUl5b+9ZAoiXnuX8xmO5FQD21TVZQjCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpkkENlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73699C4CEF1;
	Sat, 29 Nov 2025 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764375095;
	bh=OSasR8ewzfvwBSYQRlOYFDV1Y7zX4rRh1J9TNkUwMF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QpkkENlSn7n/LaPc7YHDE7+OcDwSLs9q9v01XH2WAwW1QFbywJbqa09+/N94wAdjg
	 h/YCqcY49zLzPU6GGKv5B8+uCI5nMJlqin79NK+XSG5LFGqhCAU+f//RSQudhEgV1S
	 qqvLOGdIUYDdox4j5cxkEhfn4WJYvSRDBrasdemYAtb/Lq8GzwYjxfjn+34AXwnwzI
	 pE5CeXwJk3P4j+V8zLNfJmf6WUMcgox8MZfgLcAhr30+s6Rb2jrtMuZknxub+skGqz
	 MaWWxcXT8To9BcJjmHFs+mlrUCZ6XjsdbRJjlXWFrZZwnDz9/1X7Czg9lrlSwnQL65
	 Zos11QYBKZ9dA==
Date: Fri, 28 Nov 2025 16:11:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Message-ID: <20251128161133.3397b20c@kernel.org>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2025 22:07:59 +0000 Andre Carvalho wrote:
> This patchset introduces target resume capability to netconsole allowing
> it to recover targets when underlying low-level interface comes back
> online.

config hiding a build failure somewhere:

drivers/net/netconsole.c: In function =E2=80=98send_msg_store=E2=80=99:
drivers/net/netconsole.c:1304:16: error: =E2=80=98struct netconsole_target=
=E2=80=99 has no member named =E2=80=98enabled=E2=80=99
 1304 |         if (!nt->enabled)
      |                ^~
--=20
pw-bot: cr

