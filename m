Return-Path: <linux-kselftest+bounces-13235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE19289AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DDB1C20363
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCA14F9E0;
	Fri,  5 Jul 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCZlwsTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C314AD2B;
	Fri,  5 Jul 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186134; cv=none; b=k1hsveAmtyyY18+xrMKiQ/oIeGDwKkO/R8ccjK6HXFNrxGLpM+iw9VbRsOF4QDoiS5LAmH8JyfyKB/DfGXwE3dzvVxJHUFxkhxm/unXuMaHBHADGfNvmY/Y3lGu3sBeMS5FMHKaYgdKGpxhAgW8y6i24r5mwqSzrRHP8w4DnGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186134; c=relaxed/simple;
	bh=jt7f+2jmTHEmIKfo0UmDvt8VtgDT12rAndwW8ol4AmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXf54KxhCHPDEQ1S6rAE+kQiEhocWKXoiSnDBcdqNGI+aql0fQzbqU5UrBx8mI0USrE0MLg7dEPdIZhF4eJ4nx5cVZVZCAYOlBehLAZ25Z5Dgaz/Ad16JWFuKnxjQgi+uAS/90MAq+/LDJBw3QIDNikTsI3/x7/tiGlOO+A/Xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCZlwsTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1278C116B1;
	Fri,  5 Jul 2024 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720186133;
	bh=jt7f+2jmTHEmIKfo0UmDvt8VtgDT12rAndwW8ol4AmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCZlwsTqn32bGdE5Vd5t8ZaMOodTg+L130TkoXAmV4EaQ0AeLQN7yBcOWVbJ+W2Z0
	 OovMF+EygBrpSwOewtdlqpUIstxsP7wcl0mTdSTqzJo3dJBLSMeKFprvyiFaF8Zj3Z
	 KSxjtsVj4mcgM8mrn5QbznjmmtKpORYKTEWUV9HC7pts75elGyHZb2HmPtigVPWewE
	 bcQiDrQS/QED8Aj+AKFOw4M0LTLRd+D+SBvpaysUGdkKUlO3lI2pNnl+QJQ+v4r/fd
	 Slzg1JiwC3rB+CPJErSmoqRUswwsobzGxqdS7WpxCCaXGYPS7VKCTX+f8uw8HiiebO
	 IQMfi25lw1Q4w==
Date: Fri, 5 Jul 2024 06:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some
 flakes in the CI environment
Message-ID: <20240705062851.36694176@kernel.org>
In-Reply-To: <20240702132830.213384-1-aconole@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 09:28:27 -0400 Aaron Conole wrote:
> These patches aim to make using the openvswitch testsuite more reliable.
> These should address the major sources of flakiness in the openvswitch
> test suite allowing the CI infrastructure to exercise the openvswitch
> module for patch series.  There should be no change for users who simply
> run the tests (except that patch 3/3 does make some of the debugging a bit
> easier by making some output more verbose).

Hi Aaron!

The results look solid on normal builds now, but with a debug kernel
the test is failing consistently:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=openvswitch-sh

