Return-Path: <linux-kselftest+bounces-13923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C4F937464
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 09:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A301F21395
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9552F70;
	Fri, 19 Jul 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qXn/z031"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4804F8BB;
	Fri, 19 Jul 2024 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374125; cv=none; b=JIH1LY9VuqEiTSZglhizauM1DWOYaz+6WQZdvbUYWyclxvir70rIB/TqmboYkBIUeNLfAMxI2QdtAwHK7FEgU0AfUOD5v5ZnOm0fRgwlHPpgtVTjwz6OYwYXneNW+H+YR6tKzTmK9TxufzxZl3kPpbA0LkdgXExwGbKLjritmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374125; c=relaxed/simple;
	bh=S4WTKeGm6vBbMkg0pWePfH7h9B2lnOnlmthjWkG3yoM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cw/+e5v4AQE/Ms6TZUnrXYJ8NmrUc68LfSe7Mh9TK2++q1GRloVvu7e5xjfLuV/Rt6TqL3fqFr6D89Z48jj4vNvg24qew8qBdFMv8leBhLdqRV+3ZPYBTxXXfXc0k3Rpzp1b0UimSlY4a1nb4VdaPq+qhg98+c13NE43lEul7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qXn/z031; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721374122;
	bh=S4WTKeGm6vBbMkg0pWePfH7h9B2lnOnlmthjWkG3yoM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qXn/z031gzC4pL1p3VwloFcGf7CklDwmm3qq6MOXYzarJluJSnYyswEcnN6xQzNcx
	 7uCVCYGk4XcFWGZ8gPLiiNJdY6alX/wpqAgF/ZjSoQUJRP/LnayLUfK5+3++D5baNH
	 zurj5wh2GbYPYs/9n6y7AGLN/d3Jhu0KBylXHNJzZOLywF3fd/fnw33IS5F1EiJ3e9
	 wEjz1ortIIG9ZDaaB6asiW+7rq3enyhhoLm7MrSpf/jOYCnlMAhv1Xm/YOAMlgVJyX
	 IWZ6vCERpy/ejnWfpsCbHF3rQp0pKr2JxSANkDS5rm3O5NR1C+RAor1NUsPsY2pBNb
	 TlVtfrrsm9I0g==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A7C537813E1;
	Fri, 19 Jul 2024 07:28:39 +0000 (UTC)
Message-ID: <7677dc6a-3162-4ca8-ab73-f5903ad820c9@collabora.com>
Date: Fri, 19 Jul 2024 12:28:36 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/4] selftests: x86: check_initial_reg_state: remove
 manual counting and increase maintainability
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240718113222.867116-1-usama.anjum@collabora.com>
 <20240718113222.867116-2-usama.anjum@collabora.com>
 <6a477f29-3425-434d-88a7-b3d619fef2b8@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6a477f29-3425-434d-88a7-b3d619fef2b8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/24 8:48 PM, Shuah Khan wrote:
> On 7/18/24 05:32, Muhammad Usama Anjum wrote:
>> Removes manual counting of pass and fail tests. This increases readability
>> of tests, but also improves maintainability of the tests. Print logs in
>> standard format (without [RUN], [OK] tags)
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - correct description of the patch
>>
>> Changes since v2:
>> - Update description of the patch and add before/after output
>>
>> Before:
>>    # selftests: x86: check_initial_reg_state_32
>>    # [OK]    All GPRs except SP are 0
>>    # [OK]    FLAGS is 0x202
>>    ok 5 selftests: x86: check_initial_reg_state_32
>>
>> After:
>>    # selftests: x86: check_initial_reg_state_32
>>    # TAP version 13
>>    # 1..2
>>    # ok 1 All GPRs except SP are 0
>>    # ok 2 FLAGS is 0x202
>>    # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>>    ok 5 selftests: x86: check_initial_reg_state_32
> 
> What's the output you see if you were run this as:
> 
> make ksefltest TARGETS=x86
> 
> How is this different from the output from the above command?
The above before and after output has been taken by executing this above
command. I've copy/pasted the snippets for this patch only.

> 
> Please provide the same information for your other patches in this
> series
All other patches have this information already.


> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

