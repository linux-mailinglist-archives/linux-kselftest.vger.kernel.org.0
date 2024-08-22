Return-Path: <linux-kselftest+bounces-15989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0C95ACAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EB71F228AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBF49647;
	Thu, 22 Aug 2024 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="g0Smvaf6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70C47F5B;
	Thu, 22 Aug 2024 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302162; cv=pass; b=c1hMKvpVfDt/hRC3EcdSACZKQGnx/YMWhhRy87wJrfl6m2zjzRIRFVtLuB79vqtI3R0b45DJD3p6zu2vy/NjWf2PRlUWOWzPXBuyFh0oZpyFxATJlyYhPPBM4iI6VTLMh5WNZygMd4pidPsnq+Z4XNXys8hyEcGYhhW/WyZyG2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302162; c=relaxed/simple;
	bh=oeBN1jqK2cMmzpMxCBniguIIsdXH74DijuRkffPQyRc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u/s1Idg6rOKmEmsxng6bCa4msLw4vnHmbWf4Vo6ChrMqhMCYgVziLBC90p2lOvgxBvfdaf8n9i4x11yxq6rHJ5n1n6wvxYihZUhPw799CIiaS5L5Ly8Z47b3Pkr67r/37ZJ4U7ubnQXAxLkqMRtbT+YekAX79abwUz2utBk7M04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=g0Smvaf6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724302154; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DzGHfoqBA5wDLXaoWHYfGZ8PKvEEI3G4o0nHWPjvYyo2S8bNcYx1SQc7iAGedtP6pWEkV8q9SvjUairtxFVF9Usskem8XhNBuhIu3jlMwFfWKu3wjIJhb3nanE0MPhA/+OXjWaMN7EcdIVbfyIh4dXlYIyKQubKJrR5OR9R6Y+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724302154; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lwtbOKF2q8p0VA6LLrYxhId9VlfL4TO4kmr3T9QPhAg=; 
	b=bkL5ciLcJauEfh1Xq3sXa/9j3J5SRT+rgayztwTYzNp7+ylfzvWJp95yIaGTuNn54vIofb30zo0y1QXrF05tGNeVvRrRe9fmmzHoMLT7lL1WhbFXHEaulWyZgQwuo/YXl7HZuDDZ6I0JqZMkTpA5r+54gYjuny4fVmSNEUDvbHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724302154;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lwtbOKF2q8p0VA6LLrYxhId9VlfL4TO4kmr3T9QPhAg=;
	b=g0Smvaf6wRhJMdbIr5AR/Jh16+wxPrtLVJfdgU492muw4FbEHUSevUyT0g6ChL2J
	ilvEsrZitc7+3RT6PJBSd91t2NMqK5ZJ9r1QDbZgKrH5VC/sOBXSxoSpN9NpmIxZUxq
	fZw656EHUZsCT1Y7l4yh+M8PP83n9JNTr/sZbfuo=
Received: by mx.zohomail.com with SMTPS id 1724302153290975.5327739258892;
	Wed, 21 Aug 2024 21:49:13 -0700 (PDT)
Message-ID: <b3f1c35f-093a-4038-9ae9-540bfb58feef@collabora.com>
Date: Thu, 22 Aug 2024 09:49:05 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 2/3] selftests/resctrl: Always initialize ecx to avoid
 build warnings
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
 <20240813104515.19152-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240813104515.19152-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/13/24 3:45 PM, Ilpo Järvinen wrote:
> To avoid warnings when __cpuid_count() is an empty stub, always
> initialize ecx because it is used in the return statement.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 51a1cb6aac34..9882c5d19408 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -290,7 +290,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>  {
> -	unsigned int eax, ebx, ecx, edx;
> +	unsigned int eax, ebx, ecx = 0, edx;
>  
>  	switch (get_vendor()) {
>  	case ARCH_AMD:

-- 
BR,
Muhammad Usama Anjum


