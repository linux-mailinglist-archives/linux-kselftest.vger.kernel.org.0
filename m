Return-Path: <linux-kselftest+bounces-48986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1325D21B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 00:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A8B4301C08B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2D333745;
	Wed, 14 Jan 2026 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKpGzxOk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3225DAEA;
	Wed, 14 Jan 2026 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432429; cv=none; b=BnvCX+c5WfZZSy56DAHbEUncPD8H7D4/37wjLpM6cox8ZNXXWQRAikcVda4v2h427Q94rnVwCBf0RaxOkC0MQCwU/Io7JoQxTKqHSFm6vs7miUofM3jYWeoijTHQb471ftg2ya/3nWF1bctRhS/o9i4RcGZ9V8PEVYK+3qUzwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432429; c=relaxed/simple;
	bh=nrrLtRfi4zqtezZNYT9fL1ylm1cmz713dBfa6hDFuXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpmFsgCuLEbiRzDvWbaP4URu9TDaIao1ly6QRr2KsDXoCU0GjPGUwrwefMA+GUnTRhSpzT3aFzphiPvxyf16nV+Jzk0jYfPA1rvEpAagiflFx4Ot3j2HQQmOjYqHpEK2HwjPm2DD0+o8rBPp4u3tCGOXy0owoiHvKAaojVEPISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKpGzxOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E8C4CEF7;
	Wed, 14 Jan 2026 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768432428;
	bh=nrrLtRfi4zqtezZNYT9fL1ylm1cmz713dBfa6hDFuXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKpGzxOk8KWC2Bg99tlvlER8RkaAbzrC7BUZ6ghMBlcgARgJ3YziDUcCKFRMe+2wq
	 6fwbf+kgkcSgYn1jsz+RYYEEUk7JRQBLEd2TQLV/GRsceOlCVINvuUSxq+QiO/zxEB
	 NGY+zXK9363DoqO1I+7pyMIPcjzPQ3YENmf4hDovKvjGA1Y5j8HIstuwBTa4lHcvID
	 OihkKLmLmElWhSNFezRTqc7PSqORjMKnruCX58c7+6j0koAHH19zf70ZDQDljJfytM
	 w9+tAAX3Hilz44NEYg3Rym5ff5zrhosJCtyoL9eNqvnlJ/ZTksE0a3kF/Qk2My+X1d
	 /2JuNc6ULzQ2g==
Date: Wed, 14 Jan 2026 15:13:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Message-ID: <20260114151346.734001ac@kernel.org>
In-Reply-To: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 17:29:14 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Please find the v2 AccECN packetdrill selftest patch series, which
> includes 58 test cases used to verify the functionality of
> Accurate ECN spec (RFC9768) under a variety of conditions.
> 
> The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
> of the branch: https://github.com/minuscat/packetdrill_accecn

Missing your own SoB on the patch, but also -- are these supposed to
pass without the kernel patches? Without going back to check Paolo's
message my understanding was that you'd repost this as patch 15 of 
the kernel series.

On the packetdrill side -- is PR #61 the code we need merged?
Doesn't seem like it. Could you please clean that part up and start
the review process?

