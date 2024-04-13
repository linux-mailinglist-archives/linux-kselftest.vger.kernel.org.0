Return-Path: <linux-kselftest+bounces-7909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF318A3E92
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 23:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A81F21652
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291253E3B;
	Sat, 13 Apr 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIb9Tt7P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657A23BE;
	Sat, 13 Apr 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042323; cv=none; b=Mlr4u4SFiAJ4fEhu4ApZo+ekzpnyKad5YzZ7R+4e5frJDFmxc4ao69M5nN10LFUv8Xs5nXWTGDzGayAhU5iAxLH+mYE2lnCCE+BO5blfkN0vfaDiWLIdQKMHpDnLdhk88WPnCDJCuJB3/HbRaIyDXps/qtfaEWlwb2IcbI7hJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042323; c=relaxed/simple;
	bh=jc5CSx3FODBAU6cziQpzfYX2MMDX+QOobH4WDFqX0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5Qau5AG2LNNSnhZDwl1xMCN8mzJnca5hL7Q/pLY79p5iZnOEh4xYHrbsZi4ddNtk4n8xFoE1wPwUwTNXw6l+Sn1Fk+TuF+FOX520FnDbJPlBTOPdK2Y9lRqs9ogdtzkDepdSaCXLrJNVWa6qdWH4yjyv5iBP8bxmgUPOQvcIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIb9Tt7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34287C113CD;
	Sat, 13 Apr 2024 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713042322;
	bh=jc5CSx3FODBAU6cziQpzfYX2MMDX+QOobH4WDFqX0T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIb9Tt7Phfd4Iz9XgRpCVE38Nh21WoCCnu/AQyEsSeKxiIV62iy7eT2v7Obp+C7LW
	 6kGX8OisPCtTeUZ2KkKkiopz/rJz0VkThgjQJxuWA8gNOFz+61xGpXw8lChsvzqXNX
	 8Bv+T4Ij+ZskhVWZSmYuhH21NMSa2/L3nqxwO4uoEWpXz+x4NRUjybawaVPye+XhWH
	 pImrCYNA6hEmMGwBp0cVHF68nG9iGFk1UL0SzSFd+y2bUvBUV36/I7nrjb7/LBIiBm
	 uPSb6Y3FRcHf8P0ZHqFSTZjthf7zF5w+NtdpckI5cCaJzOwUAvrI+tecZykBcUC8cQ
	 iu5rhvO1P8X6A==
From: Miguel Ojeda <ojeda@kernel.org>
To: davidgow@google.com
Cc: brendan.higgins@linux.dev,
	dan.carpenter@linaro.org,
	keescook@chromium.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux@roeck-us.net,
	lkft@linaro.org,
	mic@digikod.net,
	naresh.kamboju@linaro.org,
	rmoar@google.com,
	skhan@linuxfoundation.org,
	will@kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] kunit: Fix race condition in try-catch completion
Date: Sat, 13 Apr 2024 23:04:10 +0200
Message-ID: <20240413210411.441424-1-ojeda@kernel.org>
In-Reply-To: <20240412025903.489470-1-davidgow@google.com>
References: <20240412025903.489470-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Apr 11, 2024 at 10:59 PM David Gow <davidgow@google.com> wrote:
>
> KUnit's try-catch infrastructure now uses vfork_done, which is always
> set to a valid completion when a kthread is created, but which is set to
> NULL once the thread terminates. This creates a race condition, where
> the kthread exits before we can wait on it.
>
> Keep a copy of vfork_done, which is taken before we wake_up_process()
> and so valid, and wait on that instead.
>
> Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240410102710.35911-1-naresh.kamboju@linaro.org/
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: David Gow <davidgow@google.com>

I noticed it with the Rust tests too, and indeed this fixed it:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

