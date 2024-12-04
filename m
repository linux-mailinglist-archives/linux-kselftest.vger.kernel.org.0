Return-Path: <linux-kselftest+bounces-22812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BE9E328B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 05:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A27EB21D39
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54738385;
	Wed,  4 Dec 2024 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHJTdnRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77910F9;
	Wed,  4 Dec 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284927; cv=none; b=WV02z3Kpg0KI0u27ZGUprzSS2qExWVucWeiVf571TWn02wVXZsjibqgVNYRpRro0afxkZIiZg0kKyJZa4jdHs6IU2wsH2qWLWwnAOSTcdvuhEvtYHG4MKE+VDDMXxVsRhqNUn81cBV3vFPGUiOwI/MahhcAEMynOqI846Tcy5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284927; c=relaxed/simple;
	bh=XnVqyQ/RDtm7lOWqAE3EHHmylutiPD6YqZEE0BGz9a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmictIHJW153/38QoOqoi9XLADOP1Jy/HnbT6GD9MIKWFAPcynmQNJhwBjkbpViorLOb1+mpX5lYkVJ3h7Jx5UEAX16lemn3SpfhpkoUpN3S/bNGRSDsKdf1JRbzl+JR8zWX44Be4C22Zb3SHlFkvXHKNOQmj+rVlCm3xH7uYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHJTdnRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB14C4CED2;
	Wed,  4 Dec 2024 04:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284926;
	bh=XnVqyQ/RDtm7lOWqAE3EHHmylutiPD6YqZEE0BGz9a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QHJTdnRwOMsO83Qnh1GmOzuVSQpvufDgBR+4kcnLEm5C3iIpwrMdouLlVl5QbtmzM
	 IDjVgyjUk2XKiA3/zgFiY/cd0BOdhy83bB1lmJJIEfU7Nt2nuD7uSQuCM98b6vww9u
	 5pMhfnoONNcnBrFZF0ZanI/utqnva5HgzbKSsQ1Whgw1KGCP9qUVBe174YW4FbHOY7
	 Ima7Bm2TQViHGFV48ZK/Y5XgsmZTNdrP3+6g103MQmwAw4RF3171qOgz8csawldHv4
	 lU5iUlZ5nmC6ZsWWjgzpS5TB/N8vdxB2Fwrdsh0S468bD0so6mQFVUgpssEYzAyro5
	 36EbjkV+sFZcQ==
Date: Tue, 3 Dec 2024 20:02:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 0/6] tls: implement key updates for TLS1.3
Message-ID: <20241203200205.24396e28@kernel.org>
In-Reply-To: <Z08u9FoNOeEbWSM_@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
	<20241118194158.493e11ec@kernel.org>
	<Z08u9FoNOeEbWSM_@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 17:16:52 +0100 Sabrina Dubroca wrote:
> 2024-11-18, 19:41:58 -0800, Jakub Kicinski wrote:
> > On Thu, 14 Nov 2024 16:50:47 +0100 Sabrina Dubroca wrote:  
> > > This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
> > > [1]). A sender transmits a KeyUpdate message and then changes its TX
> > > key. The receiver should react by updating its RX key before
> > > processing the next message.  
> > 
> > Will review tomorrow/Wednesday but I haven't gotten to this in time 
> > for 6.13, sorry :(  
> 
> Is this still on your todo list, or do you want me to resend?
> No problem either way.

Sorry for the delay :( I had a nice plan to get this reviewed and
then corporate life did its thing.

I left a few comments, hopefully some of them make sense, if not
feel free to repost as non-RFC to avoid further delays.

