Return-Path: <linux-kselftest+bounces-40644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7EB40D57
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2223B0064
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D52E424F;
	Tue,  2 Sep 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2WUiAWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E927EC80;
	Tue,  2 Sep 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839027; cv=none; b=unp9YTfHBCO90LbSUBcaW/iaxikxV1P2dIPgrC/vBoFGfd8jtihxX+tsF5uWnDBvc8bP5+R9oNpZe9W3Z6nlfWt1fUF8R/wCFcD5oQ9I51BswbFsQL9BAoVPnadVwBKvgefJYYWJsSfghnL9rx5ysE0SsGXAnju1DsdQZsYJPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839027; c=relaxed/simple;
	bh=3f1QlWQggQFlWHsbX6W+fm41fKE8JQ+mTvYxr1R3j/o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=P8VZ8w4Zr/rVK+MF/RGZ2EFM78jjCJDnoXFUba6hjVlhSi9Xzse5MfN+jx4XUekn6lzl7yfslpVqpdSnUBtcxnCpdCWz8YvPc4IUGOaBX8/I1vpkHM3vnuQZ+2FcIQT45h6jTVDxMxeJjUyi1erLq/0plp51h/LktAeDDQuhI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2WUiAWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E1AC4CEED;
	Tue,  2 Sep 2025 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839026;
	bh=3f1QlWQggQFlWHsbX6W+fm41fKE8JQ+mTvYxr1R3j/o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=W2WUiAWC6ZYJkUKJTOqFW4ab6h/q1xSGEMW8iGGKsXYva7sw0A4o/XNsDiuT7HqDK
	 XYRoF+LiDkAuaXU3Rs0GImCm6zzlJvRDnUHHtXQtNFHtx4qb6G132fBh5D3V24XdEb
	 KI6da4hyNmUuo+QqBwBLQcoJcc/T2a8ujPX0dKnXPmJvwMgYmMe7zP7+9+eSP6RWES
	 2gWESOeZp745gOx4qI+fVA//BIGhqFqnNuNDF1n1Sez3lxruA1GVs96kQQM+tXDnXx
	 tcylUEw8nAsrKkdRezdS8JJP7ZkxtHQwwzZWoDcFwXLx3wtGTa1ZPUM8eIVXWGk86m
	 0fkpSXcfTcNwA==
Date: Tue, 2 Sep 2025 20:50:19 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Christoph Paasch <cpaasch@openai.com>, Gang Yan <yangang@kylinos.cn>
Message-ID: <d4205818-e283-4862-946d-4e51bf180158@kernel.org>
In-Reply-To: <aLc2hyFAH9kxlNEg@arm.com>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org> <20250902072600.2a9be439@kernel.org> <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org> <20250902082759.1e7813b8@kernel.org> <aLc2hyFAH9kxlNEg@arm.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <d4205818-e283-4862-946d-4e51bf180158@kernel.org>

Hi Catalin,

2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:

> On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
>> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
>>> It is unclear why a second scan is needed and only the second one caught
>>> something. Was it the same with the strange issues you mentioned in
>>> driver tests? Do you think I should re-add the second scan + cat?
>>
>> Not sure, cc: Catalin, from experience it seems like second scan often
>> surfaces issues the first scan missed.
>
> It's some of the kmemleak heuristics to reduce false positives. It does
> a checksum of the object during scanning and only reports a leak if the
> checksum is the same in two consecutive scans.

Thank you for the explanation!

Does that mean a scan should be triggered at the end of the tests,
then wait 5 second for the grace period, then trigger another scan
and check the results?

Or wait 5 seconds, then trigger two consecutive scans?

Cheers,
Matt

