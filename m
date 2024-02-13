Return-Path: <linux-kselftest+bounces-4575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7D853A79
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F13E1C260EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5322111A6;
	Tue, 13 Feb 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4sXV3/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D211E49E
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850966; cv=none; b=U41wyHaXH79pm0+dZECLoiOlqQMJfLur+qMAA3d8S42Xu56Y0QqnIKwFfpK36HIIgrfM2zJC5pz619YPoKwJLlRRDPpXN1/uUd9B6Q1QWnn2AUtO+b/BZzsbKqjVnIdi2m4b/xVUI43x5kItyPPeX4nZPA47lhcMplILsIF9i9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850966; c=relaxed/simple;
	bh=ARuw3WCKo/Zg7qryCzkEB/KWZ5RJTNhOe722HTn37bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrQqmr3eskGr2IUbQBEmJP5TAaG2v2m31jyAjW9moBTOlklWdYR9D/vzfytoXVg37pBTH6nXPmGOFuLzNYZ8h7cXM6uGVqG23UMnr08l/0iADg/rybtGXyO5Cyo4fu+VLSoBdWP3ThxX8EsT5m6fqSAChke+yIwC+f/5m7Z8QkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4sXV3/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCAC433F1;
	Tue, 13 Feb 2024 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707850966;
	bh=ARuw3WCKo/Zg7qryCzkEB/KWZ5RJTNhOe722HTn37bI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4sXV3/HuwQqGsThxWXbPN+YZOZFeUVdLA0Hr9nIdPP/mwxjDBQSNOI4aNbYQfA0s
	 hd+6s3s6+pLDXNkYW8qK+nYPAIg0JgzoVYKYFHhEGFVfpoWBSiGF7cM/81sOzL6hOc
	 55ha86LKdzDTPDjRZ7jnLSZOngiEjqq24gLMp3zlrbIWxFLZiEqEi1Kbf9tdG4wEEG
	 PNu1QWZyxq9NyIS3fbzDa5sacWI8P073R0rUlnKR6B9O0W7IA7Q5D1011a0P82jUKS
	 JEsx9zF60BQWHB8eK2LnaRQS7JjW1UdDZE2kV9A+OdqoJHbm8mU98JSV/GApRbnol6
	 WDF/UyCVvrCEA==
Message-ID: <6a035dc4-92a6-4220-bde6-a0b5e532b8ed@kernel.org>
Date: Tue, 13 Feb 2024 12:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl selftests ready for inclusion
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 shuah <shuah@kernel.org>
References: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
 <c1c08466-2eba-4f54-a557-ffa6a0c3b4cd@intel.com>
From: Shuah <shuah@kernel.org>
In-Reply-To: <c1c08466-2eba-4f54-a557-ffa6a0c3b4cd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 13:10, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 1/22/2024 10:06 AM, Reinette Chatre wrote:
>> Could you please consider Ilpo's resctrl selftest enhancements [1]
>> for inclusion into kselftest's "next" branch in preparation for the
>> next merge window?
> 
> I just confirmed that, even though [1] is almost two months old, it does
> apply cleanly to kselftest's next branch (tested with HEAD of commit
> 6a71770442b5 ("selftests: livepatch: Test livepatching a heavily called
> syscall")).
> 
> Could you please consider [1] for inclusion into kselftest's "next"
> branch in preparation for the next merge window? It has reviews
> from the resctrl side.
> 
> Thank you very much.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/
> 

Sorry about this. I found this in my spam folder. I will pull
them in now. Thanks for the ping irc.

thanks,
-- Shuah

