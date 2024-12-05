Return-Path: <linux-kselftest+bounces-22860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E29E5355
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF861881DC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7231DDA20;
	Thu,  5 Dec 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VzRF0sfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERU7VtQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC31D89E9;
	Thu,  5 Dec 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396806; cv=none; b=ePKP5Ua/uxdsuDOynwkcgBexBKVpGv6+V3dF50t3mcoHyPuNxmeKq0I3AzTnFmddgjx4+utjGNAZWUYUgJzdCWNmNz53XaoVY70xAnBnM7NkQOeve44Qa3S9uNHP94BZE4RSksaFSRerl+ZhUW211iRGcLc3K6E+sYRFsXZOO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396806; c=relaxed/simple;
	bh=ktlFxxr9tgG6IXtx8PkYv3KGn8bo719VqDm2lM/J6pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7UGr6TNYjILrRpFmR+0LpE7jc38nPEBZvlo0pyXb4+W2WJII0XENgrVk15VejsWRSMVLrolfUSMVnGPjH94VYZZINdvocz1oivxUYT+XPRTAqK6zvu4K4vkTyQsBThAhqllGepMgF4QeNgK6LNN0j/DRNiHakBMiZ9dd6GZH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VzRF0sfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERU7VtQR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 55D22114023C;
	Thu,  5 Dec 2024 06:06:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Dec 2024 06:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733396801; x=
	1733483201; bh=SKHY22/a1FrbM5ccTkJMU55h4ZUMLTrDJL+VybDLaeM=; b=V
	zRF0sfdFuqDJGzSEUKPhuJDKjARPq2DAkExCVmT15DryJcnBmGab4Wu/8jVmRxwp
	5+kxcDDQ6GG3vMUVUttqcBPWYpo8tgPaVdvtDuYy+M3mf2Sb4UC8R9eJOid39AFS
	447AyrceVb3sVjagrG9Et/2OA94/efBrQu3XlOeC2d/O/RxkEXjBfdQyQ1EbjEW6
	I5fV/K7FBv6gljn2Us1GwWn/s8JkbdKJ+2aQXq/IslefE6C8wb7k65OYHeScJ0Kq
	TLB50jHiOGD0SkenlSSOTcaE8KRRtF+WvK636ad3ZrOp8mEcXH81BtgcS2VrSojh
	/R9nNorxwnFKlS7uYNNkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733396801; x=1733483201; bh=SKHY22/a1FrbM5ccTkJMU55h4ZUMLTrDJL+
	VybDLaeM=; b=ERU7VtQRZUKpmqhT9gqPsWq+x31oRdxpL8JCEmvmLt8MPj9Zg6/
	/a1qXaLLCqMJKD6gx9sXD51l2Yq2gk4gmkk5x8xc2nKmV1Yd6024eWyhVQqgYBaQ
	SbvJTHCXwx3KAiZh31YnpCwSpqOX9tAwN/TAZ+w0dU6DADOIchJIk9dU/UX+LZaB
	v0+sxR3BNoGx4d+UZEahyXRhCgiB+f9r0WVejd+FHWGQM1g5cF+7sQmhZtzIaF/G
	DMv37KpzOZjWPhGtTQPbd9PePNJuIThQkA7tyzMB5Ymt0HN4pFvYb3Jr6G1NkwGi
	O50OdOzCNFGlIt/ZwX5hM/LiKmOk3vGL1og==
X-ME-Sender: <xms:QIlRZ5QkKnm5_gh0uXTaauHUjomUblaoB7yeWZCcGKHXB7UB7Juzcg>
    <xme:QIlRZyynNMzFDtCTGcN20TX486acnIZRIGPNbrZU26xDMX6MH7SI8MSvTilBtRR3p
    OYBjhB1-OObhAQtJ-g>
X-ME-Received: <xmr:QIlRZ-0NjXwOJH-mQP5aScbcBlRXEYWOVrbGNn82tvSp4rnA_6g8QHtx6iKe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvhhfvgguohhrvghnkhhosehnohhvvghkrdhruhdprhgtph
    htthhopehfkhhrvghniigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhunhhi
    hihusegrmhgriihonhdrtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiioh
    hnrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QIlRZxBI8WMEUCi8kM9oLS1EJLL77XW1_88zzMuVIe-5EI0KNUYOPQ>
    <xmx:QIlRZyjTfd-Ln2Fjc5EXmB1BJ-44HgQlKxaTpSvIHZP4wt4ddF5Xsg>
    <xmx:QIlRZ1p0Dw47OJkGGrF2JitvXfMaPTcSAPTfMRQK1oEWEPC0FU3eTg>
    <xmx:QIlRZ9j3sqBTyCkDUEE5Gq4UqJbvaCBOGh6vIHzUFqAJS5HE1qALGg>
    <xmx:QYlRZ5RcDa5kEMyg7iVw7jMQURqY9WRbqPo0SrJnLR4X83uhe4ywEKFN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 06:06:40 -0500 (EST)
Date: Thu, 5 Dec 2024 12:06:37 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 4/6] docs: tls: document TLS1.3 key updates
Message-ID: <Z1GJPUUR-wllqX3w@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
 <6baaaaf467845c56d7ec47250aaa2138de948003.1731597571.git.sd@queasysnail.net>
 <20241203195129.25e07e53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203195129.25e07e53@kernel.org>

2024-12-03, 19:51:29 -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 16:50:51 +0100 Sabrina Dubroca wrote:
> > +To prevent attempting to decrypt incoming records using the wrong key,
> > +decryption will be paused when a KeyUpdate message is received by the
> > +kernel, until the new key has been provided using the TLS_RX socket
> > +option. Any read occurring after the KeyUpdate has been read and
> > +before the new key is provided will fail with EKEYEXPIRED. Poll()'ing
> > +the socket will also sleep until the new key is provided. There is no
> > +pausing on the transmit side.
> 
> Thanks for the doc update, very useful. I'm not a socket expert so dunno
> if suppressing POLLIN is the right thing to do.

Not an expert either. I picked that because there's no data to be
read, which is what POLLIN should mean.

man 2 poll:
       POLLIN There is data to read.

man 3 poll:
       POLLIN      Data other than high-priority data may be read
                   without blocking.

Based on this, reporting POLLIN seems wrong to me.

> But a nit on the
> phrasing - I'd say "poll() will not report any events from the socket
> until.." ? Could be just me but sleep is a second order effect.

Agree, thanks for the suggestion. Maybe actually "will not report read
events"? Other events are unaffected by a pending rekey.

-- 
Sabrina

