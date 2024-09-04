Return-Path: <linux-kselftest+bounces-17081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2C96AD2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6579D285D90
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1E623;
	Wed,  4 Sep 2024 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrfTCg3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E9173;
	Wed,  4 Sep 2024 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408791; cv=none; b=G2vQEvw/wMh65jkiWYARniPCKBP6XKfT6hcZFqaksFuQqvWAo9dagPGfaQxeZTCcM6E1aEE4LCrpob0zr6a2HWqEDq2RuNUlNSVbrg4smR9T/rm8r98X6xtV3hzokJ58vsd60bDL0W7jTLyeRiTvrXcHwrV1gHi72WRJAK9aBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408791; c=relaxed/simple;
	bh=wzv2dlQImwfQPmX0iww6hLaABYJFLVMq1mXi9LVbT5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGg641Y9dYZ8nD+a6D7txZ5Nwh7yGbNYJw29tTVSLVo4VN/L0BP/xr7IiIXn+cMYwemXZ9S/vNGBSAr1HdlUvGc4707iTNvIKC7rW6d5OTkGyMorBI0Ysxb0+SEGueoK4rgXkJ030P774WVjo/iilOmOXGYckvjIxbyrMGlgKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrfTCg3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4775AC4CEC4;
	Wed,  4 Sep 2024 00:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725408790;
	bh=wzv2dlQImwfQPmX0iww6hLaABYJFLVMq1mXi9LVbT5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrfTCg3VuHkdwmTbCafk5E0qNb8a/8MXXAlbp2TomWkXedUEV9kH20DgZVDlod9fo
	 Q8+EbyyLfCsycwcBGImlPnOzJs17g6MNYvh/s4llvx97ptPOqw4Z6a1ILQj8AOR5tJ
	 Qn4kbcufNXScFbQpb3wrONeAhBzuP2vKvLXo7YF4SJWLH2OmfGaQs8P5HPrtp88Dan
	 yr0MMj3IHCFajUqJZR2Nl+BdHGrCELy9al2ivA05o4LhmJvdxxbWbumNXUzLPdWlN1
	 JNYeiuNkWr9Ois0FPRtu4XlnU40sOSd4kX7Rufb9tu4oowUzYn87Og0xYWaSrUBK2m
	 JYmRgdGiyYN8w==
Date: Tue, 3 Sep 2024 17:13:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] sefltests: mptcp: connect: remote time in
 TAP output
Message-ID: <20240903171309.1e032d49@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-ksft-subtest-time-v1-2-f1ed499a11b1@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
	<20240902-net-next-mptcp-ksft-subtest-time-v1-2-f1ed499a11b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Sep 2024 13:13:05 +0200 Matthieu Baerts (NGI0) wrote:
> Subject: [PATCH net-next 2/3] sefltests: mptcp: connect: remote time in TAP output

nit: typo in the subject
-- 
pw-bot: cr

