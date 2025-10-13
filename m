Return-Path: <linux-kselftest+bounces-43029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E8BD5FE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F84073C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F61DF252;
	Mon, 13 Oct 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OIcplRen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B057155322;
	Mon, 13 Oct 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384732; cv=none; b=Jq906uWRlV1kYCTZMLp9whEtTSPKSRV5RAWzvvy7Y91piPv9gugTXYIVUHq2m6825QoklcbCTk+IujbcCC7mwnGcwoaQ4gZfKoRd6jQ6RqU0ViJufb/NwKTCNwuPFnEqk5GPDIfooRIEYVZ0eZEy6hZwoGbx8M6Dg8UsRLwaUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384732; c=relaxed/simple;
	bh=MY+YRUQKLtJYZJyEq96fgMk0w7vwxMzr5S0vyCUFB6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0OcLAPG7lrlnfw6TFJWqNv4JE0CMFCH1dXwmiVzNmvRFQKpCycCYJNxneeEJRU37itw6Elz/DRirdbmc1i2Qunwv9ViP6b3XaEw4/V+fS3N+O+641T1cxJw1eWqD6GCwFYLeUG9Bz+8u4EaNm79nG1i504TmujJ1G9BNuLzbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OIcplRen; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d] ([IPv6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DJiSUF1442566
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 12:44:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DJiSUF1442566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760384682;
	bh=1aJOeaPPB1LUMhLyvXF0SOu3n0ovMqgDmMOTUIZYXXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OIcplRenwsuEFxrQG/i7vbTNL5ee01maFltEu/9+zMjTrqySBAieZqr/Jnicpqoey
	 b2HHI6yIRprdPUAGYIWjF/kEanvHHWXiC6nPSVA5IqK35TSVZ+7IrLFGmq98r1j8DZ
	 V5aeeP4aUdWPcHl9xR2EvzbOu0Jiq4U5iHSVyec1uPZV1rwgNuPSY0NPtjes+43aIl
	 K+H3VHnCes599MCCY8JoDUtC3q84PpJfE6CcvcH+f08aBA9dJ3t2a/zXK+rcx8az32
	 UvQcHsa4qPbKZ9DC6gaWyDpFxKVkpNfFVN7H2GKOXZ8fif9gO0qQ83SQs1WuiyNyu6
	 EQ1aEfan++sog==
Message-ID: <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
Date: Mon, 13 Oct 2025 12:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
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
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-13 10:14, Andy Lutomirski wrote:
> 
> I don't actually remember whether the kernel ever used this.  It's
> possible that there are ancient kernels where passing a wild, non-null
> pointer would blow up.  But it's certainly safe to pass null, and it's
> certainly safe for the kernel to ignore the parameter.
> 

One could imagine an architecture which would have to execute an actual system
call wanting to use this, but on x86 it is pointless -- even the LSL trick is
much faster than a system call, and once you account for whatever hassle you
would have to deal with do make the cache make sense (probably having a global
generation number and/or a timestamp to expire it) it well and truly makes no
sense.

	-hpa


