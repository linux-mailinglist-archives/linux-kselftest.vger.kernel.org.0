Return-Path: <linux-kselftest+bounces-22896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0E9E624C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 01:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D19281CED
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046318E1A;
	Fri,  6 Dec 2024 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSCccqaB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440ED193;
	Fri,  6 Dec 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445247; cv=none; b=nODr+mMd/6Du0zJhpqu9baYkXmq8HpGUfMzF3raIx+CYplCYN8eA51V5L7legpS89B5Kz4r1LzENgYl3CjEWofm18ITGA5nrD+pnxoXsmtS2JvxvvoBFdCwJ3p2dOrY86hwIxrUV+uE73JzSc9bcHf9VLNtdEkY8Y45+JNHIBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445247; c=relaxed/simple;
	bh=kr1FMof798SrzcQlvdEMriycPTvV7mrgGb7dlzWf91c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH+JYshAIF8x3cedLgv+bcdQVjhXN+dU3sX8D4mfeLJ/W4VcDO0oldl0uDIccyua0WkgO8aDCmtIz+0Ab5xotFeFMTn2LIKX+zj/f5Lzjnm5eT3AIqPEZFWQOyiWNF8l470D0odg09hJb209l1oLOGSEh/eu8VnMtlRTt5/UxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSCccqaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B82CC4CED1;
	Fri,  6 Dec 2024 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733445246;
	bh=kr1FMof798SrzcQlvdEMriycPTvV7mrgGb7dlzWf91c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSCccqaB5H/Jw2EkSZUDAASQwSCyZLw/GQl+uYM+Ma5Fo4MoYgN+0lUbLLOwOLk11
	 QUvp5ibjbQT2PYEMNqbu8tHD/Km8nolBjhyUly9PWjWWxs5cZmj91q/r0idT56q0C2
	 BZe463HcXfH4cn342dMZVCRahZccXLZWTIm2dTnNYAFicAlNKq3Nbt7SAcMAeEHyMt
	 IJ322/B8M+1/acIySVocbL+O61x0ImlFJ6UtLLJS3/BKan+o87Iu4T8fjnFtMJTLiV
	 Iw0e10ZNcCLLum3iegl97OQnEVoo6j9cwIqOWRM0cMMRdTAtVvFta96xDIfMh4VrUT
	 4/zvHmseqjH+w==
Date: Thu, 5 Dec 2024 16:34:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 4/6] docs: tls: document TLS1.3 key updates
Message-ID: <20241205163405.49649d7a@kernel.org>
In-Reply-To: <Z1GJPUUR-wllqX3w@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
	<6baaaaf467845c56d7ec47250aaa2138de948003.1731597571.git.sd@queasysnail.net>
	<20241203195129.25e07e53@kernel.org>
	<Z1GJPUUR-wllqX3w@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 12:06:37 +0100 Sabrina Dubroca wrote:
> > But a nit on the
> > phrasing - I'd say "poll() will not report any events from the socket
> > until.." ? Could be just me but sleep is a second order effect.  
> 
> Agree, thanks for the suggestion. Maybe actually "will not report read
> events"? Other events are unaffected by a pending rekey.

Good point, SG!

