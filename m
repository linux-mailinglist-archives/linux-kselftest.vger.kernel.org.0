Return-Path: <linux-kselftest+bounces-40118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511A2B38ED9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889051B225CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51930F944;
	Wed, 27 Aug 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GEd+fyH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1752D738E;
	Wed, 27 Aug 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335376; cv=none; b=oE+qYJJFX3QOh0vvUOdbCpnmg8HnNm/5ut0GIpTQMMPGv0HUzevcXhJ7Q+6wm/91kOfuFuhttXWAw+N/BbiBUMedDdvXMWeq5cc3hSbAVMn0qsgJccvkSEGO3Am4GLvgRSAMDDoVmy28CwJHL8D7r4LYmEDBHnV6gpJKwOTWOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335376; c=relaxed/simple;
	bh=/B1SgrrSnevWQV+pRhc+dhHUQzjFT6VYqbFyFZ1N5h0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U5WmdRZ+t0MilhkwV1TOOe55Z3h62+/kSMYpXHEWwUxg9VEqjymdk2DTFsLHaYetVWwlO6zr8Gf+4bi5o5kGV0KQ+kWzVO29I0rFi2S4reAYQLmBsep0dhJsWd17/kCwT40CDY1IESao4ExDDujth/AQOeFIhIuZM+TxrG0xVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GEd+fyH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FBDC4CEEB;
	Wed, 27 Aug 2025 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756335376;
	bh=/B1SgrrSnevWQV+pRhc+dhHUQzjFT6VYqbFyFZ1N5h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEd+fyH5w0msgOlZWZRibXLjDWfZ0ZYTK/NT/kU2wYtVfsnCceTM2RAIKY6n0oLsj
	 egh1/x/q+VlvGdpvQF2arxmtPry6aRneHjRuaAcy1YClkPgUC1Oke49AfQL1PdO0um
	 qdQnuZ7ukbcD25QY0ILI/T23Kiw1Z11Uo63vaVq4=
Date: Wed, 27 Aug 2025 15:56:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: shuah@kernel.org, mic@digikod.net, gnoack@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ming.lei@redhat.com, skhan@linuxfoundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] selftests: Centralize kselftest headers to avoid
 relative includes
Message-Id: <20250827155614.9e441c45c0612730bcdedcaf@linux-foundation.org>
In-Reply-To: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 20:17:31 +0530 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com> wrote:

> This series centralize the handling of kselftest.h and
> kselftest_harness.h includes in selftests, replacing relative
> paths with a non-relative approach using shared -I path.
> 
> Patch-1 updates the build files (Makefile and lib.mk) and 
> include CFLAGS in sync/Makefile to resolve not found error
> Patch-2 applies bulk source change
> (Patch 2 is large but it is replaced automatically)

Cool, thanks.  I think this is nicer.

>  280 files changed, 286 insertions(+), 280 deletions(-)

lol, it's lucky that I so enjoy fixing rejects.

