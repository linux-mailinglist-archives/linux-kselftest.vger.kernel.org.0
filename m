Return-Path: <linux-kselftest+bounces-13163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFD926F1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A6FB221BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC81A01B6;
	Thu,  4 Jul 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LvHqv8So"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374611369A7;
	Thu,  4 Jul 2024 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072122; cv=none; b=fC6AryFC+L2Wa+abkNabZOmQ9i/H0QwM0/IbwPo4x6rEY5KpeFDxYL9u7mCe6/FxH7CL1F/af6yL0lLLGREIpdSduF/W8t+GGrFOD3WoY31Wqarr8DqImaAFBbafiqxWjwNQbB4wkthDB2sQcUeK1ZZXMn7Jk7yt/pKrmZnKtnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072122; c=relaxed/simple;
	bh=ETiXUSdUNkqvQTr20H04++pbgV0yc6V3cMGeLljFAMQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iAzZqN8awDneY465JLWcm6Rjf97MkebDY/306VbC6yhejbcpvbmq5ZGm7MxzREnuS5KVXLQtdgxsMuir93f4p5IXWiUnm42gmKYnqtnDInpliia0dpUFYnrhrfV+kdU9Es6HdgdDFKDEQKwgvKn/B8Mpz0/MxTEzxGTXGN2Wj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LvHqv8So; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720072116;
	bh=ETiXUSdUNkqvQTr20H04++pbgV0yc6V3cMGeLljFAMQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LvHqv8Soe2AuBhrefypzX0dF1O+rTLisyr/8nFP3yLod5Q0JBHrL+r5mWk5ofkZt1
	 NxLGSuKN4MAN2A4oowKzJavH/ZGK+P9ZoloOY+j6kR4jCJyw7XVi6+fU1tBpcb3W4d
	 EhJ0Y+YeFcgTa2fnCPuNNv85VNfVD7gzBk0QjYaoYCW3+Q0JOyXMKyWwo8eQP2SgnQ
	 uP38iND5C4P2FwzlFxrNz98QyLsj2w7Uai4+kwRVwyOFV+9SvRHlh9IA6crP2Koaeb
	 xwrwZ6BT07wgQw2kuBfzZybr1noJy3q/x+LbnY3gIWdhsMCsD/3Ckoflmw9OAxv9SK
	 +IBm8zIotzOeQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DEDFE37810CD;
	Thu,  4 Jul 2024 05:48:31 +0000 (UTC)
Message-ID: <cd08a86a-8ce0-4ca3-946f-b33ae5a2f133@collabora.com>
Date: Thu, 4 Jul 2024 10:48:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
 <d9c56b70-6120-4de7-920b-9ece52905c00@nvidia.com>
 <64f44840-823a-4b82-8187-c94c6e021c15@collabora.com>
 <17675d27-6a9c-4f1d-a771-4830393465d3@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <17675d27-6a9c-4f1d-a771-4830393465d3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/24 8:08 AM, John Hubbard wrote:
> On 7/2/24 3:28 AM, Muhammad Usama Anjum wrote:
>> On 6/29/24 1:06 AM, John Hubbard wrote:
>>> On 5/31/24 12:38 PM, John Hubbard wrote:
>>>> Hi,
>>>>
>>>> Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
>>>> discussed yesterday [1].
>>>
>>> Hi Dave, Shuah,
>>>
>>> Are either of you planning to take this series? I ask because I have a
>>> very slightly overlapping series that enhances the LLVM/clang checks,
>>> that I'm about to post. And I'm not sure if I should try to include
>>> a small fix that would apply to patch 5/7 here.
>> This series is important. Please accept it.
>>
> 
> Hi Muhammad,
> 
> May I add your acked by to the series? I can use that as a weak excuse to
> resend this, rebased onto the latest, and keep trying to get attention on
> it.
Yeah, sure. I've reviewed the patches. But haven't found time to send the
tags to patches individually.

> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

