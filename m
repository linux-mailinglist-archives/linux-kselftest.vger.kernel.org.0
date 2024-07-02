Return-Path: <linux-kselftest+bounces-13053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BD923B5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17CF1C22229
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C53158855;
	Tue,  2 Jul 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PRDD5uQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8F1586FB;
	Tue,  2 Jul 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916109; cv=none; b=WpqU+9R11T/Yy4VYKVVzzT/ipCdqYQaX4MwDjOLZuO+/7c6NApSGD51iln/irOaJeoL2xFHKo5yu3f2lNU4YWqo9tDypqAbCLJ3fDJrdlZS8iF9dQLhfDACguKW6CEX+bLEMYiSc7V//FiFAzGYpKfy0h9XaraZHCiP67doG6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916109; c=relaxed/simple;
	bh=0vEVWm815vRahgR7eXbM6ytA1Xr9XMeyMXpjYvPA5e4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rOa9pgUHESh05M/sdeihP0nJCLkPPObM/SqAGI4fqzEwqkG59ArsYEgCUm87brl3fKwn+L7nn2ygI1Sa3m6G/9mPHiC+CGUPqnRg1I0/pPBtBvuELD+pGKGZ2/rX2aG+8fXFrALKQZKWEkLibUGeD5sqQaGjHhBu42DVwkmtCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PRDD5uQ+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719916106;
	bh=0vEVWm815vRahgR7eXbM6ytA1Xr9XMeyMXpjYvPA5e4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PRDD5uQ+lHISAdiXfxevaZUZPfjgiqI8/6PyIFXerbDnv8YtJakVCP9/q05kYYPo/
	 VmlspjDOwqAonfqLEuQSYJuRsDY2J3tXmSBzthtYeDdF7D1ZoRFnqOowO2cTsi1fDz
	 O8feqAEcH7ZbqyADWdgdbaA1pHVz8j2l/bg2boi24/3mHTGJqlrF6DN1iUo1CAFY07
	 EruPfo9FAW5HqksOdN543Fw75t9cUT+QRp2MGbUbxqU/ghlbOZhX3JvyPSfDmy25Rg
	 xfvEBB78ertsKCXQwf8dv0FpOadA2q3OuChhdTX3EwuejKUt+SSEpay03PoBjqNBjC
	 1tRsZet8GpOSQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 564FB378217E;
	Tue,  2 Jul 2024 10:28:15 +0000 (UTC)
Message-ID: <64f44840-823a-4b82-8187-c94c6e021c15@collabora.com>
Date: Tue, 2 Jul 2024 15:28:09 +0500
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
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <d9c56b70-6120-4de7-920b-9ece52905c00@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 1:06 AM, John Hubbard wrote:
> On 5/31/24 12:38 PM, John Hubbard wrote:
>> Hi,
>>
>> Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
>> discussed yesterday [1].
> 
> Hi Dave, Shuah,
> 
> Are either of you planning to take this series? I ask because I have a
> very slightly overlapping series that enhances the LLVM/clang checks,
> that I'm about to post. And I'm not sure if I should try to include
> a small fix that would apply to patch 5/7 here.
This series is important. Please accept it.

> 
> (This is not urgent, because it's merely a deferral of adding LLVM/clang
> support to these kselftests.)
> 
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

