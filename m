Return-Path: <linux-kselftest+bounces-17660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0744B9745F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E6F1C21C2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34701ABECD;
	Tue, 10 Sep 2024 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnlUwQ8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7321A3BAF;
	Tue, 10 Sep 2024 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007202; cv=none; b=T5vTe8YHfSL3ACq3Kbxr0uXS724c0+9O+09p8F61xYk+LXvW40OCu/rxcQi2rYNoxNCAv6VIXYESifb1Exn6A5ahX4T3NqsGNJBQVNg0RSt5VrKtuBKuLI20dNXZmjYjAyB6+TVafAhxHDfKBmAcl+H+bforD9aWtDYXgCX9T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007202; c=relaxed/simple;
	bh=fTvBXgicfoVLabb8nKOx8XPzF9s0hugcbfUf+rseM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXGRIaX91mSNSBRO0a8jwyIPdkqg68ndupMv/vkrwnq7hNk/Cga7IFRFfAi2TFe9qrFDAU3UT33arvb+HCrVmz4azo3VRC4oXm0sJrgqcVe37DBMmxPgY/r51wJuI1dDSJaJO+E4HdFkHq1XaS0hklY5f2QeYZa95mTGVb9dzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnlUwQ8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7795AC4CEC3;
	Tue, 10 Sep 2024 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726007202;
	bh=fTvBXgicfoVLabb8nKOx8XPzF9s0hugcbfUf+rseM6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FnlUwQ8F0ywxno+NduRCY38QAmg/LRb17Icf9sj29SGZtjiSSvYJkejKmFxH9WCgL
	 MgcYnjyduiu+zrVEFgTQep8MrATglgJuBoYv29jPd08CopomZyIxO4qaKlp4f6CrP3
	 6KHTNGyA6kyYrDtPht4Rz54RmIAMTzeGImO4boNu1gRSgLb9ya6AgjzVVDkjJgBlhd
	 WOBqSysLV7XRYwM3Wzzynew3BFrUusJHY46EaSh9swB2lNYT+RFyLJmkLBaNuPp7XC
	 xbH99Gg7feOa3b017uY+UNB/OurRC9336Au8sP14EK+kq5H8w1R9AlDB0YLtEH9ri4
	 bMuNw2A0vTBEw==
Date: Tue, 10 Sep 2024 15:26:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2 0/2] selftests/net: add packetdrill
Message-ID: <20240910152640.429920be@kernel.org>
In-Reply-To: <66e085c5c2627_c43f1294df@willemb.c.googlers.com.notmuch>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
	<20240909102156.28ac12ba@kernel.org>
	<66e085c5c2627_c43f1294df@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 13:45:41 -0400 Willem de Bruijn wrote:
> Which literally just inserting uname -n into the two invocations,
> right?

Yes, AFAIU.

> I can send that. And then also add some CONFIGs we discussed:

SG!

> And in the same series another two packetdrill testsuites, around 20
> tests, say.

SG!

