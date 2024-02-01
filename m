Return-Path: <linux-kselftest+bounces-3908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C5844DEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8128F1C26670
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9C1FB5;
	Thu,  1 Feb 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFTQZnQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36AD23DB;
	Thu,  1 Feb 2024 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747796; cv=none; b=ZcVyqilc9uvq7mWtwNFZH8gI04rp/QVVR3SXMXhVLdssuyc2BHwPcNvdgw3eO25ET+hJnJoZ2SIYZpK684C448i6C1o0mtxdT81u+mqO46fLOMmsQf1rUqpKf+5sXMPUxInxOti9Vkfj8quhbwAeqqPHXer9kfm6QX7E1MwgnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747796; c=relaxed/simple;
	bh=rIVBZ0YpKKKh/UQafWWF5fY8LlCJ4PxbdsL0vpFL1/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=matfMH7VmGnVjrPucOsUxy0TO/896BbDwmGM4vYh90hRYWRVzP6r6JxrPoYsFkktmcYs9TBbE6uetULE7jJNA7GzwlssLDmdM6wnrHaGU5+Wz8LAV6Czy6uBeySovktwyNn10yHIOQcUv5Rlgc6FaZmqO8XoXzIxZ6iwYG+Ddeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFTQZnQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B08C433C7;
	Thu,  1 Feb 2024 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747795;
	bh=rIVBZ0YpKKKh/UQafWWF5fY8LlCJ4PxbdsL0vpFL1/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FFTQZnQvLkBkFBrETXyP3QUSU10eHP0og8ee60GJo5L/b4qIiQoSrAHoPpPDSlfnY
	 cSeawZIEB/2Dlnw4dOv2QAYtszhgGe+VX/Q1491rcOAipm71cLnxbRzlyDfnUcEbn5
	 rFugDw2umvOgSppUZuimbg7fU2apoJBugQCkHTklpW6/YjtdQVObVkl4kLRz+a316y
	 Pf9dZ+6h65csjHfbLZ9yq1IGO/TRC6fQfb8xIxrIvKpennzzoV44/MGb0mMKe4TLC4
	 kYiEiaTmu7NHr62zWd0p+7bIBsvgDOULKUJD8NoM6XylHGyao+UWQaO2qwW4w1ZPYe
	 aAikeVhqmHVXg==
Date: Wed, 31 Jan 2024 16:36:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Message-ID: <20240131163630.31309ee0@kernel.org>
In-Reply-To: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 03:51:51 +0000 Dmitry Safonov wrote:
> Two typo fixes, noticed by Mohammad's review.
> And a fix for an issue that got uncovered.

I can confirm that all tests pass now :)
Thank you!

