Return-Path: <linux-kselftest+bounces-43031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F3BD6538
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 23:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EF18A80B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3833296BC1;
	Mon, 13 Oct 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cMd67WoO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438A219E8;
	Mon, 13 Oct 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389832; cv=none; b=FtRGN+lZ5Kui57TBtAIwZFrPGnqARChX1GObBHa5oA+lzVoF+dtOFLQcBg358g0AjC7aTlbjkp7UhAclZSwtEQNVPiw2gdRGl6F6sf71ijAdrhfe6bKdKCN3ST6N+gvMfbnTwCfv9yxLUaqofRbcsjWlJNl3X7QXGvj3R3Xse14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389832; c=relaxed/simple;
	bh=QHrvRQIH47qXD6u+vvXuJD2fKTMeGYp+Cqv3jTGMrGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4TZPdl1bsG7KTXhDAhqUysQBaTOnLW5G9J85VYuUKOTlqko34TmfcSxUqk0xtAW9kLETIHTvg/6opYiG3ckGIyM7l34AB1ye8ukPpEpv3/s3121eQVmNXg2jWnGpXzjFzu8LQ1u5gu06iVE9onG1f5VlkT7tPt7Cstq6lIndj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cMd67WoO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d] ([IPv6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DL9bFB1473312
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 14:09:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DL9bFB1473312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760389780;
	bh=OzCgvPG4aCYIt5U2/uF5XWAxPeOEelq2YRV2TeCo8zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cMd67WoOzA4jU4tRxio15jlNW2gMHZRxCZExgtMI3hc6F1bR+FFsKY5zGygn7k4Ht
	 1jzcy6j8UKiFa4jjP8JG4Ukwnmr9yOlz+dgxvT0Z1Qc60vjnoLiye+3tZQBQ33a4ck
	 POM5nApdVKga/EVyRL79HJiBHLfa+Hobx5BtA7IrG1kqj+u/TEhFdQrUicdfBg6oia
	 wtIwnrOtj7NJhqoOeS4J+3SZq3L4Xy38DiBL5iXRQ11zCbdpPFpRSPqcljY0ZvD95d
	 Nnra0LThGgnrPnoBBmno0+2CHn+URmyBysN69/FI+IK6z4sK7RBrtSQ5jiyOJLJ2gI
	 WkYz9DUtkxygQ==
Message-ID: <cb5991f4-fc6b-43d9-a60b-f28b5eeda5d3@zytor.com>
Date: Mon, 13 Oct 2025 14:09:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan
 <shuah@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
 <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
 <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
 <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
 <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-13 13:32, Andy Lutomirski wrote:
> 
> The global timestamp would just be some field in the vvar area, which
> we have plenty of anyway.
> 
> But I agree, accelerating getcpu is pointless.  In any case, anything
> that historically thought it really really wanted accelerated getcpu
> can, and probably does, use rseq these days.
> 

Indeed. And with RDPID it is fast enough that the bulk of the cost is probably
in the vdso call.

	-hpa


