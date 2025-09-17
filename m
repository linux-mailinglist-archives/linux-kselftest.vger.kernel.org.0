Return-Path: <linux-kselftest+bounces-41665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB9BB7C80B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30631C02CC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6E30648A;
	Wed, 17 Sep 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmPXBIFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8482D879A;
	Wed, 17 Sep 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101804; cv=none; b=QwPCNFd6PrHSBG0OwBAC+hrZPHkTaJvniavlxMMGV7iYodKvI8prU6NwaVjHqM9WLGATrvztFrkg0xJl8x84IEr+d+asTrsER2Kbpp+L0S6sUQv+RHZ8FgLJ7I9gqXSY2pUKCPsDffjzJupHKT+y3LNYKlt+YA4ZMiUl8lsf/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101804; c=relaxed/simple;
	bh=QLdlnlcjQJDSShKFehRIBvrbqDaszWPw9SR8nYKnIgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tg+2uOjaehbYrx9q+GUURBx+a/HtQwZZ7dFI/zsEKKhaPuSlN1xKEQvD0zr6a3IvaUnHFn8xLi/K6gCaBLV70gWkw8QS2ip5fimZrwq3r9zEkW7d86SXUTjM2fW5216mpjP3pNollgV7Cz2lbSQ6xI2PkWBJbQ9yApLEK3pqm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmPXBIFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C6C4CEF0;
	Wed, 17 Sep 2025 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101803;
	bh=QLdlnlcjQJDSShKFehRIBvrbqDaszWPw9SR8nYKnIgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gmPXBIFXtxTXG60+VNMfSptT6HxEQppKiRNb+t6KbwbEKVZjlxFgBFsef33+NkEEb
	 aifyb4aF6YKH45jgzqTy2Q0rhqHzd0XNLUu7a1xPBf9s/QkD7xT6wD+ddv/3uPfUy9
	 Wq6oH/2QDUTLD2JOtOqfoPlF5jo8TN0jmJW8d5vKTAGPXnhgYohJrwXWCFcqfancMt
	 Uwdpa0ab/vpIXTc1aJvfR9apn36zFbw59rBH8FPNuTpr13eIQZRVJJexDZjLoumn4z
	 Y38TQD8t0LvIQPiMYjjtoXE8Hq3wEFxgsIcJOknhma8XGqN9hMJx62G/oxWpKvys9q
	 QwNPGOQfv62hw==
Date: Wed, 17 Sep 2025 11:36:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/hid: update vmtest.sh for virtme-ng
In-Reply-To: <20250821-virtme-ng-v1-1-0e6359872bf3@kernel.org>
Message-ID: <n275so33-9n77-7os8-16s6-qs227r8q5s5o@xreary.bet>
References: <20250821-virtme-ng-v1-1-0e6359872bf3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Aug 2025, Benjamin Tissoires wrote:

> This commit is a rewrite almost from scratch of vmtest.sh.
> 
> By relying on virtme-ng, we get rid of boot2container, reducing the
> total bootup time (and network requirements). That means that we are
> relying on the programs being installed on the host, but that shouldn't
> be an issue. The generation of the kconfig is also now handled by
> virtme-ng, so that's one less thing to worry.
> 
> I used tools/testing/selftests/vsock/vmtest.sh as a base and modified it
> to look mostly like my previous script:
> - removed the custom ssh handling
> - make use of vng for compiling, which allows to bring remote
>   compilation (and potentially remote compilation on a remote container)
> - change the verbosity logic by having 2 levels:
>   - first one shows the tests outputs
>   - second level also shows the VM logs
> - instead of only running the compiled kernel when it is built, if we
>   are in the kernel tree, use the kernel artifacts there (and complain
>   if they are not built)
> - adapted the tests list to match the HID subsystem tests
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> I have switched my workflow to make use of virtme-ng for a few months.
> Now it's time to automate the manual commands I've been running in
> vmtest.sh.
> ---
>  tools/testing/selftests/hid/vmtest.sh | 668 +++++++++++++++++++++-------------
>  1 file changed, 423 insertions(+), 245 deletions(-)

Applied to hid.git#for-6.18/selftests, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs


