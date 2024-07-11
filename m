Return-Path: <linux-kselftest+bounces-13545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EC92E057
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AACB21021
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056112C54A;
	Thu, 11 Jul 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fvYtZloq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6B12D752;
	Thu, 11 Jul 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680781; cv=none; b=qA66rXNJGenEJxLv/pwZBUiStEH38OMMomQlrzG2OuDU1QrRA2r2pZhFPdBTISK4LPFZwEI34PQPLuHgutCr0BkTBWPo+Db87ThZcRzyYeE9VApP8cUvcWJ0/w/g3O9Dg4fZ3DBmyY3qSwM9uf4FrCCn0hYh0NLH/NyVKWB8fGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680781; c=relaxed/simple;
	bh=PSgWXlV9tZQ+QaMrzGIglX6scnKbFwJQ9iFd+WMyZ1g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CyeQKnsB2YQXPeb9lV64i+WeeBO3DQPVw5VbcfVV/o5qP6rZu4D796rDB+MW8sFPcKRBU35Bdk8sKXesAjmx7laRP8UxLeVdRI//po20ZKtXLjNfqwrd/sd/PPx372ks4jy9t+rhJLog2ND1ojPMN0XyEh8dOwtoVsuOyuX+1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fvYtZloq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720680778;
	bh=PSgWXlV9tZQ+QaMrzGIglX6scnKbFwJQ9iFd+WMyZ1g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fvYtZloqezaYbLA791HK6JPXGU46kph1GqG8MHVzEqqkHlNEOIfy4SwA9KDW1pZ0w
	 d0XhrI0B7qpo8cBbo5yVSAJi+pEPrnDS1rI0AERLZH0kxnaeKQ1IA78+EewQYM/p4v
	 uOsu/aOWR3TV7ayjeg4/KKYLpNkg1VChS4DZC4fZLIy7Wt75AiEMTJHYn9XrysDPBQ
	 5HNpjZlJSD5hRDgtGikIt+qDYoAj2mKxVG6dyTewtNA7W1/MZuApiTu3OWgYg5RoFU
	 rmDm6CzoWM694EfwTZ4LHEt/WUwdMm57ZIHurxSPJ1ZvaoHUR5ghO/3yhJWveNFd4N
	 bUWc4tNmG8SuQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FFEB3780627;
	Thu, 11 Jul 2024 06:52:53 +0000 (UTC)
Message-ID: <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
Date: Thu, 11 Jul 2024 11:52:50 +0500
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
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 9:16 PM, Shuah Khan wrote:
> On 7/10/24 03:37, Muhammad Usama Anjum wrote:
>> This patch brings just readability implements by using kselftests wrappers
>> instead of manual pass/fail test cases counting. It has been on mailing
>> list from several months now. Please can someone ack or nack?
>>
> 
> Okay. I think I responded to your other patches that are adding TAP
> to individual tests when kselftest wrapped does it for you based on
> return values.
The current test doesn't return any exit value (hence implicitly always 0
is returned). The return value in addition to some other changes is getting
fixed in this patch.

> 
> The reason I don't want to take this patch is if you run the test
> using the recommended method:
> 
> make -C tools/testing/selftests/vDSO/ run_tests you will get the
> TAP output because lib.mk runtests framework takes care of this.
This patch is required to correctly return the value so that runtests
fraework can correctly mark the result of the test.

> 
> or
> 
> make kselftest TARGETS=vDSO will do the same.
> 
> Please don't send TAP conversions for individual runs. You will
> start seeing duplicate TAP output which will make it unreadable.
> 
> Run the test using make -C or make kselftest TARGETS before
> investing time to concert to TAP. I am not going to take TAP
> conversions patches if make -C or make kselftest TARGETS
> shows TAP.
> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

