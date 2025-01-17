Return-Path: <linux-kselftest+bounces-24735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62249A1523C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 15:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E1167E5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C519E96A;
	Fri, 17 Jan 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyowb9Uh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DD18A6A7;
	Fri, 17 Jan 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125605; cv=none; b=it2O5qXwZ6/W5tq6QuNElDrPE88n/OjUIO+dvUST0MWJADgUFEbbw14BLiX52mWE37ATPSGz2qD2udguwR0d9SvWQ3hU8sIrtjwmpBZqIKx1YnE6nrvGt4aj1uudnadzw58lPZKO+nMn6+OkJkvc0r/3JuVLcvXdvnkiN6auLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125605; c=relaxed/simple;
	bh=WikLHt6WuE9RBpcStaRT/Uib5k6t8b6gpZU6j1qxo+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqAmVHinM/0guo7ryNEorTlwuyYUIw0eHLBJwkeOwdAIXNzWRZlQ/fApwJb5ZWTLJdVhfC3oU2lekVCS2Ic8qfQa2pbCsQY7lrZpUPjZqkv7tPIaNddWIBeajjLfGkfAxLeooDINhxdRvl3VUsE2GPIyUNKcUtctJtSYhObJ1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyowb9Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DCAC4CEDD;
	Fri, 17 Jan 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737125604;
	bh=WikLHt6WuE9RBpcStaRT/Uib5k6t8b6gpZU6j1qxo+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pyowb9UhD1tnoauSadhvUmo/43lm4YTfSucpYVEleglYrTRU7c6W/dEOvGDf2h23c
	 2qORrXzqAzfVmORZNFsHROV5SwLHdxarE8HL5tvpWZXIJ+jTPclv6tcMta9D4mKYyM
	 8Jm54BPvd5ehI/s5MvPqWGYBeDKU41SgPtvdktErJ7SCPFCvrAKiAXCYSelPOCGLVI
	 0RxflqaDwV/2ZhJG1o+2TrHmlzk9a2nNsUonaAC3I4oBda8iLuRDfM1kD4kD7uL9Ao
	 Uizblnka6Br0O7yFQwrFPnqIhSjVkwaTXSBdyC5upusbxhWi5g+ckV4tq+Jnd3dtSL
	 vi09Umo7nr/rA==
Date: Fri, 17 Jan 2025 06:53:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time
 accuracy on slow machines
Message-ID: <20250117065323.42daa2f9@kernel.org>
In-Reply-To: <87ed114mbw.fsf@nvidia.com>
References: <20250116020105.931338-1-kuba@kernel.org>
	<87ed114mbw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 13:49:23 +0100 Petr Machata wrote:
> This logging and xfail handling duplicates lib.sh. Would a patch like
> below be OK with you? The gist of it is to just use check_err, log_test
> and xfail_on_slow from lib.sh to achieve what the test open-codes.

Hm, maybe? I'm not going to say no if you send a patch, but IMHO
if we were to change the output I think we should make it ktap.

