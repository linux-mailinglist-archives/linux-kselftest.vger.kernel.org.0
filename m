Return-Path: <linux-kselftest+bounces-45150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF89C41F8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 00:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE613BE9B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F44314B6B;
	Fri,  7 Nov 2025 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mIiN5q75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AE314B95
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558574; cv=none; b=Gset3NxHAgJmbYW+RyXCkuMS5eA27+6Udyb/ssIqizQ+3LIu2yZ2hI1XimFk/idk7sZ2cM7eonDYuUg0tY1ZH17IlBFJdimKzIuZUB9AWqfAwzcQp+285gnjsyTjCKvq4r7EvvxiYBljrYEA25GzVJEn7aBeumygJw5SPCDsTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558574; c=relaxed/simple;
	bh=0lY64VJ/ffa3/Z9Qv1liUMSAYVI0NdChWyMUC9rTTxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH2vhlWAe3O5f25ltt/jwo3LpiYLGh05fEAaSD1q42MVU7CaE86ni2yoJvARWUifU+K8KOz7AUgL9kjvNKDJ2uaZPhANZh0KrQhhK1NScWRk+rlwUTHyJP/qY5DUtYCvmAxYLdRvUHGxkTNDvyblrXEqcpVbn+sS7Ih6qBMpgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mIiN5q75; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762558560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qQGWs6LpN4unSynWVZhzKi98tWARU4nt/0dAsCAu7Q=;
	b=mIiN5q75lCcf4two/6jp3fr1UONOvcNFCZELHORZjTZkHsbOJO9x9ckTDX0TcH1xMG5rhV
	QkiPWcQQN3A01vmtyJlDXfZfzuXQEcmdyLTiQ4ZPqy2Hx8ncAy0QNM8yZvrVetu+BsV5zo
	4n2Gew0vzxo30idUCWKmG8Dbk1su/Sg=
Date: Fri, 7 Nov 2025 15:35:55 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org,
 rppt@kernel.org, tj@kernel.org
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com>
 <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> On Fri, Nov 7, 2025 at 7:00 AM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>>> Hi, Pasha
>>>
>>> In our previous discussion, we talked about counting the number of times
>>> the kernel is rebooted via kexec. At that time, you suggested adding a
>>> variable in debugfs to keep track of this count.
>>> However, since debugfs is now optional, where would be an appropriate
>>> place to store this variable?
>> It is an optional config and can still be enabled if the live update
>> reboot number value needs to be accessed through debugfs. However,
>> given that debugfs does not guarantee a stable interface, tooling
>> should not be built to require these interfaces.
>>
>> In the WIP LUO [1] I have, I pr_info() the live update number during
>> boot and also store it in the incoming LUO FDT tree, which can also be
>> accessed through this optional debugfs interface.
>>
>> The pr_info message appears like this during boot:
>> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>>
>> Pasha
> Forgot to add link to WIP LUOv5:
> [1] https://github.com/soleen/linux/tree/luo/v5rc04


Thanks a lot. I’ve carefully read this commit: 
https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83f0ff08fa.

To be honest, I’d like to run some tests with who/luo, including the 
selftest for kho/luo. Could you please share the steps with me?

If the testing steps have already been documented somewhere, could you 
please share the link?

Best Regards,

Yanjun.Zhu


