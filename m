Return-Path: <linux-kselftest+bounces-19747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6999F23D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972CB1F23867
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4671DD0D8;
	Tue, 15 Oct 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxNMf1F2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F991B3949;
	Tue, 15 Oct 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008110; cv=none; b=Zs9EcCe6acCcfbnJhI97XDykhMh/isi5nXsNlw2zkfpFGBrDbz5zlYq2T+8KKAQGLt5MlhJJ2sOIsKYBXVGhBEV+qXtCQ0ahJKLXalZQxTA/lGRG6HklPXjhp206PnXrlG4wcr+j4sY3SDoXivIgSHl0vWk+XsEOGRwM5A1lLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008110; c=relaxed/simple;
	bh=/TepmO8XoWWeSS4iyG4ssEgu5Umu35Qomt7Z8VC5VhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9ukfw4cTeEk9XWnn3yukuOsu8GUSG3zD5K5uVbWe7dIwaSMtERe9eCK0ShJWXz3IjoEBN+bMx3MRK4cncVuqhrSdxbvLdevU0/3F+t7TCmSMJ0HEUZ+4SujAC0W4QARpkdOrg5KiyCbSBoTVSS8vkcCZy6PbpaG18r/RyojuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxNMf1F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D6AC4CEC6;
	Tue, 15 Oct 2024 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008110;
	bh=/TepmO8XoWWeSS4iyG4ssEgu5Umu35Qomt7Z8VC5VhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxNMf1F2Bz6spUKy3ynW4DnfoIPogTZO1Di02ybSsp3NWZweEy7l72WQ3M7sf+qLN
	 GQRF6u6OC1DllmQPzO+TyZB8uul4XVEk/chRn6u0Z1VBNmBG9zoGxXLXlul9p1Hgbs
	 GuIy2ccc3rQopDApQfKeRtPFb4HOJjEcYzbFLIP0lYPBPMeD8bCxx8dlXyXTx0+eet
	 y8vswW1u/Tb0EuLwdrOv1TUZaTx+MUjG41z+E57wwiYe1SnjATTWFmEb6RbjjQw1fy
	 VGzqv72vud0o4PalF+s8XhZUQvRP/6fMeJs0AB6VQfjyI+3F1UEgfNXlVjKUrfXXhU
	 LePb5hBSiSz/w==
Date: Tue, 15 Oct 2024 09:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@Oracle.com, edumazet@google.com,
 pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 akpm@linux-foundation.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v1 0/3] Threads support in proc connector
Message-ID: <20241015090148.72e83f7f@kernel.org>
In-Reply-To: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 10:06:14 -0700 Anjali Kulkarni wrote:
> However, for threads, when it does a pthread_exit(&exit_status) call, the
> kernel is not aware of the exit status with which pthread_exit is called.
> It is sent by child thread to the parent process, if it is waiting in
> pthread_join(). Hence, for a thread exiting abnormally, kernel cannot
> send notifications to any listening processes.

I really don't think this should be going via networking.
We can help review the netlink bits, if any, but otherwise we are far
outside of our comfort zone. 

IOW when you repost please drop the net-next designation and you'll
need to find someone else to merge these patches, or send a PR directly
to Linus himself during the merge window.
-- 
pw-bot: nap

