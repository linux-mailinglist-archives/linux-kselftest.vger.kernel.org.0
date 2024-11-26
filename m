Return-Path: <linux-kselftest+bounces-22532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7B9D95CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3B028278D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92831C4A3D;
	Tue, 26 Nov 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ElvY6eo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BA17C7B1;
	Tue, 26 Nov 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618116; cv=none; b=e+Xld6uDLUnRlZxrcfJPr3gjnkYQBbtn+jFCPCia+bC+/QkR4AgfxPdX+sNNocYOnoGaxLkKktspYxb4MEck3NF0nhnH72ffETEiyJFAQ0oj3nmT2uMzGAl0y9VRAiGpk5kFiexETFER9tMsPrTRfr2ucNp67i1hX9TfilCMnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618116; c=relaxed/simple;
	bh=mmtifSkXCE0nIHcLovLkAbr451ooGAcMKjPzUMz2Zb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIZvi0+YL4Z+9DmSD13yL1Lqs0fe4JKiTR2t9NbETD8gji7NDgvHcslRc7m0MmKjcqAW7n3/N/SaUTm6PALLQIqjXJHTh0dk8jkxwN6GehZXCQHkI3dWJo6YL4k/J4+zLq/tubhhRdPtLZxAuojB1d5CxEtWXcJB01RLGYi+ipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ElvY6eo7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC25860008;
	Tue, 26 Nov 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732618106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uj0hjKNVZ5WhdcuX3o25jt+6C9njYEGIHvtxfenXwKI=;
	b=ElvY6eo7+wCofZ0mLvIN4mi2zac6+ZLe53Wo6DyxyU2xLy7iWerlEJ0Z8Ik76CnrqImWtf
	vQFLft9JowpPeM6ipy+hzK+Phuc04AM8dCu+GPWecw3MxoZSRh5qkkSdbQLqTWmc5TPfyW
	f1NhImg8tvIuYj/1Q2kz5mMuQp8hd+I7oAB7yHABhWqTOHD4Hl91esIml3fDSAC4iHTYkF
	pmnTLCEUqHOIsVT3yY6wiZc7bpevHg6STMD5K/ty+NUH8lVHfzBZmOawdmce45SD2gJbC+
	Tt6hzCHldRJYWkRhtTS+uN7jU9Dy5ao/RfZB6T9xWoKZPIoo5OrImMYffx4htA==
Message-ID: <51d5d018-55be-48cf-9e8e-c36c0f1be766@bootlin.com>
Date: Tue, 26 Nov 2024 11:48:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: migrate
 test_flow_dissector.sh to test_progs
To: patchwork-bot+netdevbpf@kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <173257263300.4052918.4072302246034568900.git-patchwork-notify@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <173257263300.4052918.4072302246034568900.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 11/25/24 23:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

It may have slipped through when I mentioned the issue a few months ago, but for
the record, I am not able to receive the automated mail answer when a series on
which I am the author is merged (ie: I get the final mail thanks to ML
subscription, not because I am in the recipient list). The target address looks
broken:

"Alexis Lothoré
<alexis.lothore@bootlin.com>"@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org

I am not sure if the issue is in patchwork or in an automation on top of it, but
I don't remember having observed such issue with other mailing lists. Feel free
to let me know if I should forward the issue elsewhere.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

