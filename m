Return-Path: <linux-kselftest+bounces-13648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46692F62F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873841C22BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507CE13D8B4;
	Fri, 12 Jul 2024 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rxRS5naC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD761422AF;
	Fri, 12 Jul 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769339; cv=none; b=FQlN4U/odcMwy3kYO0fyFGyvlcTkQ0Ae4Un/DY2eW7U95N2QJX9dda06kXwlphNkAiUOm1f7If4jQboWVXG16xA050f9MQZAULPTqVBaRKalVnl/J7GH8LofXR5K3qQ4021hV3DTv+BtYNRGqwwOKj8ogJhMp+g4BFDTj6EC0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769339; c=relaxed/simple;
	bh=tV2mmDK3KAW+lXwFxRwEDGe9QXWiyvrv2yC/DvWQ3Us=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BGTux8hCW4J7bqH30IDTmSajYrMdhCSonBHixzkXOMj7hzpMSWBUujNG+8c32fFPxnJFj+1rg2onp5PHojrj0QLdeqG6czxK8uUgPOyoGt7eaUPz/pKE0whC3A6c3Q299nslscSi7QwtSfGc6tfpgxs0k74yPm3g6wFB5lu1rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rxRS5naC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720769335;
	bh=tV2mmDK3KAW+lXwFxRwEDGe9QXWiyvrv2yC/DvWQ3Us=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rxRS5naCevYotfqd66DoZjKyyYf2RAJj1Z33ZXk2XEhjqXyxb9JX0CTcGU6uh/PZ2
	 JoHaLiOs7cY1ycq1JZaKkeAgfCNkcC5fodw2VRJXQYOWjWPi3P/JSwAekSN7Lt+xtf
	 dNmm15xKLw7bv5O9Qv8r4dvXFxpmoMO1clfNJB1vBD18jTMqssZ/FOwINuSng2zIiv
	 MEWNAU7sFnm8nt0NloHo1VuTNfcn1ddYeKXuZs1KyvXJKRx0N7keqNi52P7wZu+7gb
	 odvUOjv5Lw1AB6nn23sLuWfmDCptHvcrkOQHFwJpwX0c9PjIh3xLkLg+tq6uBRQchl
	 YnmiZOJRFNJqA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2DE1037821F8;
	Fri, 12 Jul 2024 07:28:52 +0000 (UTC)
Message-ID: <e4d909d3-0021-455f-a2a7-e6546ebf6ffc@collabora.com>
Date: Fri, 12 Jul 2024 12:28:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: Shuah Khan <skhan@linuxfoundation.org>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
 <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
 <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
 <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
 <390d33da-1676-4b01-a7d5-8b5c2cc6a3a9@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <390d33da-1676-4b01-a7d5-8b5c2cc6a3a9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 9:39 PM, Shuah Khan wrote:
> On 7/11/24 00:52, Muhammad Usama Anjum wrote:
>> On 7/10/24 9:16 PM, Shuah Khan wrote:
>>> On 7/10/24 03:37, Muhammad Usama Anjum wrote:
>>>> This patch brings just readability implements by using kselftests wrappers
>>>> instead of manual pass/fail test cases counting. It has been on mailing
>>>> list from several months now. Please can someone ack or nack?
>>>>
>>>
>>> Okay. I think I responded to your other patches that are adding TAP
>>> to individual tests when kselftest wrapped does it for you based on
>>> return values.
>> The current test doesn't return any exit value (hence implicitly always 0
>> is returned). The return value in addition to some other changes is getting
>> fixed in this patch.
> 
> Yes. Fixing the return the problems. Please send patches to do that
> and I will take them.
I'll send today.

> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum

