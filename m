Return-Path: <linux-kselftest+bounces-40612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C6B408EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857673A6FFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C131DDB8;
	Tue,  2 Sep 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPLQz3P3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7431AF1B;
	Tue,  2 Sep 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826881; cv=none; b=GhuQUYVeRc90s4s5CvFrDBBZGVuW8JX+jCaJvXZ+OqGQFjXkkwhOtnIvsf/DIQXUgOcpA8JmVfopY32TxkqySNuZbRyYtrppHkadSwEqt6P8gpfqiLE+dcEnJJ9k9OEaFL/pySaIHhZ/Zv4cm8MnHDcbp5kt4oHNPlHXTPublMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826881; c=relaxed/simple;
	bh=S7hnzQ0PtbZ9rTW5771aHjmbKan3a69yJi9prryR1tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJqcYEitFbsXIHsjYMnjNFlu5C/pp8Y17tFdYlPq/dLezTQb2Ti3JBUMOdbJbAY7e+1sEPn6f1XRXouOa7gGNs0qd69mG6ccpTchQAjgnG4DbdqiWAK8fW6yUj911x9anlbgnDk0nMcb/hqltzw70Ts5lj9uOuatB/4mxNfADW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPLQz3P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DC9C4CEED;
	Tue,  2 Sep 2025 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756826881;
	bh=S7hnzQ0PtbZ9rTW5771aHjmbKan3a69yJi9prryR1tI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LPLQz3P3qieVbwZwTj8BGQki1fdivcB+D0zRVJBqgWGq6prvqIzb8vIOIguuvCZpW
	 XdB595Zs28YDMY7ZujItXSoS3iya2kOxq0zJ6lKoTmsjxy4HX6c941Vhj/luA0427w
	 JYtQJh8tJNkCUA7cbSSwECe17iIKCxeUmUi4S9xzHuEM6RTqzZTSuBcKPrJ7sUfIqY
	 BE0jpuW/uSX/XHqTKmqZ6YsIvBKaSZ7R8M2xgi4Xuof6Q6lC3za8SSsdYgf8r2YNpV
	 pUv7E6VMuCOS6ZrcN7XMeE4KzDaJKBMIXBdigJvyuM/Ncj5yJwFCQetPlFfibmcn09
	 s/D11b3T4KRcA==
Date: Tue, 2 Sep 2025 08:27:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Eric Biggers
 <ebiggers@kernel.org>, Christoph Paasch <cpaasch@openai.com>, Gang Yan
 <yangang@kylinos.cn>, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Message-ID: <20250902082759.1e7813b8@kernel.org>
In-Reply-To: <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
	<20250902072600.2a9be439@kernel.org>
	<834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
> It is unclear why a second scan is needed and only the second one caught
> something. Was it the same with the strange issues you mentioned in
> driver tests? Do you think I should re-add the second scan + cat?

Not sure, cc: Catalin, from experience it seems like second scan often
surfaces issues the first scan missed.

> When looking at the modifications of this series, it is unclear what
> could cause that.

Yes, I don't think it's related to the series. For one thing the series
a couple of before the first report.

