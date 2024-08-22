Return-Path: <linux-kselftest+bounces-15992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E880D95ACB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E7428328E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0F3D38E;
	Thu, 22 Aug 2024 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="kMFUpMoH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F41CF8B;
	Thu, 22 Aug 2024 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302316; cv=pass; b=VRT+YLMdosgKPP8Aqa+fi4klf4AJ70OcDfbVLiZ0lWValR2nsSpPyEKHyjhRLGlWwTOdHH2w3rmqlfWGvGf+pidsZ2FaSr1xkOB1TZvrdHv17r1o7HX0Ng6UYe6hrbNTr3wpkt10A3mQpYjhHfq9XvTufNbWK6C0fe+0WEZy6GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302316; c=relaxed/simple;
	bh=Stem07tYyUB0BQpkQQvsdutEJvtGXnqZz6gCMaOursQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UzRez8eepRld+ZjHkEXcalK9o4rn/MkLbROEq5O+YtCDEMAdj6eZ+YwXMhgN+VU6xCK7/eMzL/pOKZi3C1JWxQ6PEUOuym1k1Q0ccKkK0gzkIhiADB/qHByln+LQ6qe0TK00EbZrJzdgGshSGKIvTakSgvbxRQ3j/zAm6CgbZj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=kMFUpMoH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724302306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WZrnXu6U+ep7j4CSrk6HJoUl0B+c5WG66a+VmXQDsS4D65W46+fXUBoZ59Sw3prsaIqhkdQdSCctulF9hgp0PajjEjwjiFw0yAEX1qH52cbGpOHTMzusXbadtqn3yOa8e/2lMrFdNXcERIybFbBlpNxYdQ2UMPp3dMnYnq9NKME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724302306; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s7VU0tblb3rf9Mkxu9MP2ZUxDfBkXmLJIhSS1yHmcHU=; 
	b=mUne7u6XMIoze7HGT1FiXm1Dv45wbgDV2uVJ12zl6O2uPb2X8/oWYUbuQX1CIyAPmePFKY43Xa+eN3K5JWKi+hbgzN4xEITc9fa6QqFwpKNJQhjtRy/kvcjFRcVoF8N2LK0TEUB/HkBg49G/1rQxNU12/JEZqjvwO13qEEj6Ke4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724302306;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=s7VU0tblb3rf9Mkxu9MP2ZUxDfBkXmLJIhSS1yHmcHU=;
	b=kMFUpMoHDpeQBGJ6UqfPKQsvts5h5HtZxDCyMGMk4WIa+f4kpptdhjDXynEwkd49
	r5cbpeloL+tX1bONHoQrAJDUz9bfn/RbZtCNFre8rBfVnUg5maGBHFatAHkH6ZLjuAc
	w9dwt/gboqTaQCU/Kwznzpv6gy0cG6MKuvN65+OA=
Received: by mx.zohomail.com with SMTPS id 1724302305217268.7647890521497;
	Wed, 21 Aug 2024 21:51:45 -0700 (PDT)
Message-ID: <7f4d4d41-e59d-4574-99e7-4dba69929954@collabora.com>
Date: Thu, 22 Aug 2024 09:51:37 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 0/3] selftests: Fix cpuid / vendor checking build issues
To: Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
 <88575c79-b6be-42d2-b863-d57f83f8c99c@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <88575c79-b6be-42d2-b863-d57f83f8c99c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/21/24 11:30 AM, Shuah Khan wrote:
> On 8/13/24 04:45, Ilpo Järvinen wrote:
>> First, generalize resctrl selftest non-contiguous CAT check to not
>> assume non-AMD vendor implies Intel. Second, improve kselftest common
>> parts and resctrl selftest such that the use of __cpuid_count() does
>> not lead into a build failure (happens at least on ARM).
>>
>> The last patch might still require some work on which symbol the
>> conditional in kselftest.h is implemented. I could not find any
>> pre-existing one that could be used. Perhaps somebody who's more
>> familiar with the kselftest build system has a better suggestion on
>> which symbol the logic should be based at?
>>
>> Ilpo Järvinen (3):
>>    selftests/resctrl: Generalize non-contiguous CAT check
>>    selftests/resctrl: Always initialize ecx to avoid build warnings
>>    [RFC] kselftest: Provide __cpuid_count() stub on non-x86 archs
>>
>>   tools/testing/selftests/kselftest.h        |  6 +++++
>>   tools/testing/selftests/lib.mk             |  4 ++++
>>   tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
>>   3 files changed, 27 insertions(+), 11 deletions(-)
>>
> 
> These changes look good to me. Can you send the RFC patch without the
> RFC tag
> for me to pull in? I don't apply RFC patches.
> 
> Usama, does this fix the problem you are seeing?
Yeah, build errors are resolved.

> 
> Hi Reinette - do these look okay to you? Can you give me an ack if they do?
> 
> thanks,
> -- Shuah
> 
-- 
BR,
Muhammad Usama Anjum


