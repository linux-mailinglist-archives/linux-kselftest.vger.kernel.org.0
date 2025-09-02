Return-Path: <linux-kselftest+bounces-40649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5EB40EE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1188316CBBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF82E88A6;
	Tue,  2 Sep 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfKm6oEW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD962E7F0E;
	Tue,  2 Sep 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846413; cv=none; b=m4i4t93Uhji0ND4CpJidmg7lTbxZMAegBgMGILhSZUacHAqG1IGVbsIhazSReISE7eH/LhTpWNn4ffHDaQGoGHX44XOGLfYQUBXP83/TzkYceyxegYVLdXOKw3kkt/EfffzmDuLQf3vWOAD+XoIq6ovnAMXF2wezaPqCMgR6+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846413; c=relaxed/simple;
	bh=IrPhSE9h61rfAhoaa4jcXqgfXSLJUuueyFXosJ5+D94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KD87sQA3ARMJHDd4WqZwHj7SBmJhX0iZ9+m98lbI8zzIUWf8gihXxRLgs9p/MWSz+HstLB9Pj6gAXZYSk10J4h6D0XO9Pfe++tz/SFi0iF20DP8oVFbEf01oYH2abrIlnt/Znv0RNzeZIE3zsaso+gCcAewd4lRYyMnpf5e7PZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfKm6oEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627A8C4CEED;
	Tue,  2 Sep 2025 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756846413;
	bh=IrPhSE9h61rfAhoaa4jcXqgfXSLJUuueyFXosJ5+D94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfKm6oEWOhoN1/6UMcvCf+L85870XH0oJODqeZDCtIXFINTBc+ULveIa/rbMqXfEy
	 1c0SYXiM9dzQWS1YKNgeLKnm12S00ctoNgikhFLmksvD70MWIzDvnsbqC33w9czQQa
	 lije3/wQ7eZZMJQxMXUTIAtDQEa5653r6Mvc7+nmLQIpp3QqZi/lXJrtsvCU8P/Lvu
	 aUw83nuR5ylMor7sXVaEifeU9bLPgS0nxc/C08/wVB2nONA/n0Yxi3W/x846h4F9Ng
	 ZnKH/3z8K/Ep/DJfdBw/wiu3XdoMHSRcy554ZGoW9msVLVEcCJWdn/zS04PGVID9LH
	 6H77i8f1y09XQ==
Date: Tue, 2 Sep 2025 13:53:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Eric Biggers
 <ebiggers@kernel.org>, Christoph Paasch <cpaasch@openai.com>, Gang Yan
 <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Message-ID: <20250902135331.5ae29d1b@kernel.org>
In-Reply-To: <83d76f61-e8ad-4c8d-b38b-d197cefe4088@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
	<d5397026-92eb-4a43-9534-954b43ab9305@kernel.org>
	<20250902120933.5dbd61cf@kernel.org>
	<83d76f61-e8ad-4c8d-b38b-d197cefe4088@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 21:25:33 +0200 (GMT+02:00) Matthieu Baerts wrote:
> >> I just noticed that NIPA reported some issues due to these 2 patches. In
> >> short, some packets (MPTCP ADD_ADDR notifications) can now be
> >> retransmitted quicker, but some tests check MIB counters and don't
> >> expect retransmissions. If the environment is a bit slow, it is possible
> >> to have more retransmissions. We should adapt the tests to avoid false
> >> positives.
> >>
> >> Is it possible to drop just these two patches? Or do you prefer to mark
> >> the whole series as "Changes requested"?  
> >
> > Your call, we can also apply as is. mptcp-join is ignored, anyway.  
> 
> I realised patch 3/6 is going to cause issues when running on older
> kernels, so we would need to revert it if we want to apply all patches.
> 
> But if you prefer a v2 for the whole series instead of applying 1,4-6,
> I can also do that :)

Alright, please send a v2, then. Sorry for the flip-flop.
-- 
pw-bot: cr

