Return-Path: <linux-kselftest+bounces-17079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54996ACE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CE0B233AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB71A4E84;
	Tue,  3 Sep 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7868TaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A9126BFD;
	Tue,  3 Sep 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406237; cv=none; b=fDN0BWlE7YkuO7V153BVZqFWGZxiZCBz4j9225kG2PeYVW4Aq74BjWxNMmc7RoognVHG9v3II3s4xQPigLvpmVALw2+mw8dQDSOl3VBPMZzoYaErNxGZ8SGnWUIq2SDzAzcdWiZxA5o/AJChR4oIYTZ17sSk45i5YsO02LICxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406237; c=relaxed/simple;
	bh=FrqTil4fBuG9VhW7S6egVUGfJDEoHu0+jMNoBN6alS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCocZGSC4dn4G1kw8W21cuMI54A4/O4Nmb2aemk2hhvDezbCHBuZ04uVzYfH/UZlhFHuh9bQO3v89ZB/GIabveDoTwXWgQSh6N/q9z0gGr8kGQQksowrGLLQRTnxb8qlUJIw8hlCUBwnDg+n18syejyWu57L/m1QZyk9wYqwDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7868TaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FABBC4CEC4;
	Tue,  3 Sep 2024 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725406237;
	bh=FrqTil4fBuG9VhW7S6egVUGfJDEoHu0+jMNoBN6alS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d7868TaGpZq0QiELnEM8y4j4JGyYHdE1dUi0FWItnXGJHGUJGhMSZGcaFQHK8e5x8
	 k1J/wyQdt8Ftp3EKmPTFW8qk7lzhqn0S8jM/eChDyQdLcAskaQnvxz5/FsVK3sBHN6
	 hz+rwBIRWxrp5NhkY3/6/emEEUoL25fqT+GCzOHbuwsQLLkvz9YeFgef9DiLOnBNhA
	 Zn++t1fKSY8rTV5i5VaaMVKE5o0K8MMTSbIVQ4pnYzMCCSZPsmzla1Oa6bQ5bNflPQ
	 L5sfaW26ZTDp1EqQAw3nePdXMsX1uCwsKSn3HXf08Y0WulE5RInvJA2LnWPq1MZlJq
	 +4NUdcGMI5elA==
Date: Tue, 3 Sep 2024 16:30:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Message-ID: <20240903163035.30639d62@kernel.org>
In-Reply-To: <20240903162217.07c366c9@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
	<20240903162217.07c366c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 16:22:17 -0700 Jakub Kicinski wrote:
> (None, '4', ' -', 'mptcp[...] MPTCP', ' # ', 'time=6173ms')
> (None, '4', ' -', 'mptcp[...] TC', None, 'P   # time=6173ms')

Sorry I fumbled copy/pasting the results, ignore the exact time values
in the last group, but the mis-parsing stands.

