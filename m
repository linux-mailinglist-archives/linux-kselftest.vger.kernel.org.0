Return-Path: <linux-kselftest+bounces-48268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DFECF6558
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB63308BA05
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5533161A3;
	Tue,  6 Jan 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlEurMI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100927A92E;
	Tue,  6 Jan 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663385; cv=none; b=buMYOeIuET2Z7Cc4Ef8X3Ss5ZLk99us4fHkZWl02+mbZN3Awk/d7Kx7OEH1nnJXMv2cIZeaMpX5QXM6V9Y6nh+mVOhzu1h9MF9eFxd2FNc+6MPZ7sE/2Dw9TGYLSN1H9LOcla7Z+HvgzzR42nBODgBMyRZvuv59cFk2u4rBrqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663385; c=relaxed/simple;
	bh=jJr7cc9WVoF1H33a8799T7JNXpyr/aDpbtPkaU9M88s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW01NUZv7XSvoeoYgGiRq0JeHj7BzZbhDqH0gKJ6EHL1nq8nxd6h/khIYHNhYU2fPOOqADKSnWJRPlJnuthtlcM6Ep8oaR65K3KYXi2kbP7Sa+BonD1pnPRkf95ETg1HKNQAbGlWMr3S7pdI5d9J7o6ll7H5ttD839r0Crb5trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlEurMI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DC5C116D0;
	Tue,  6 Jan 2026 01:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663385;
	bh=jJr7cc9WVoF1H33a8799T7JNXpyr/aDpbtPkaU9M88s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mlEurMI/Qs/01sfLhKQ6KUiyKU6684jXXGqsB2A7WUlUrEltzK3C6l4w9mXsaIZXm
	 +cBsugITxcoS6vi8Q0+V9Pd+0h3mOvn7M4w5O7z5sBOgtlWxG+fvjqDQMGwh1wOP0Q
	 A32I1F7Sf1lTbCoZZtOHxRYFWQT3BMMtpGojRky1ksFQHm3gm4sJFOzCm1aOREsVnz
	 /bboUSn7nkyraG4MmYYc0lpOQMa0TXMRMGOIsMn0wnvUqywhwFGnDeedliYvsdjg1y
	 Papxp4qaz/TZZO1VDwKZmGRCyDgmMXog8vMy9kmC5g9ykHttavvDwzJ9Z0wuOrK/M4
	 ERqZlT3xktAyg==
Date: Mon, 5 Jan 2026 17:36:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/8] selftest: Extend tun/virtio coverage
 for GSO over UDP tunnel
Message-ID: <20260105173624.43fe986b@kernel.org>
In-Reply-To: <cover.1767580224.git.xudu@redhat.com>
References: <cover.1767580224.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 11:44:35 +0800 Xu Du wrote:
> v2 -> v3:
>  - Re-send the patch series becasue Patchwork don't update them

Not sure what this means, but:
 1 - please do not repost patches sooner than 24h after previous
     posting, per
     https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

 2 - the patches do not apply to net-next:

Applying: selftest: tun: Format tun.c existing code
Applying: selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
Applying: selftest: tun: Refactor tun_delete to use tuntap_helpers
Applying: selftest: tap: Refactor tap test to use tuntap_helpers
Using index info to reconstruct a base tree...
M	tools/testing/selftests/net/tap.c
Falling back to patching base and 3-way merge...
Auto-merging tools/testing/selftests/net/tap.c
CONFLICT (content): Merge conflict in tools/testing/selftests/net/tap.c
Recorded preimage for 'tools/testing/selftests/net/tap.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0004 selftest: tap: Refactor tap test to use tuntap_helpers

