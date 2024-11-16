Return-Path: <linux-kselftest+bounces-22136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1149CFCC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 06:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C751F222E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4318FDD5;
	Sat, 16 Nov 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE6jmuhq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422182F43;
	Sat, 16 Nov 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731733726; cv=none; b=e3OlaM8sayKpwRCXtO/V2RBPpYA0B+LeuJhRoO03t9CPSB5wVw2MNYQV8MC4mI9G81nfSRkFIkNxLufznIFLXD1dpHDqh0wgN1ymZakYFDERb05n6CedbfSYDwyxRR8LVaM/p77Edrq4WJ8MrxjUrbCjf81lhHMrVBFu097WY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731733726; c=relaxed/simple;
	bh=g/1U3wQtyt+HgnIiqQQXrbuyXhcHop86Ik357Z8bds4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJO9pMgH0iz3LFx9TG28rVFxvMvw/HQjygD86AnjY7woY2bDEhxvat9cetaVRZdhIJdR1IjmgTexvbV040hdF4XSKtR7L9LuLQw/bcUi4bsbcHKrzzaWzkb1G1+l7NH6XXkE5PVrmiltysogkz0dE/9Pmf/XR0W5hRwPQ8fsCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE6jmuhq; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1023688a12.3;
        Fri, 15 Nov 2024 21:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731733724; x=1732338524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/eKoaMUC29/TD3G+glT9g4BNUXv4nM1ESsdOPo9vKY=;
        b=iE6jmuhq2pHHM2l+oHd/3GSziQEzoGf8hZ4liPnzMhMz83t51z8eItfWu6Olf52HMB
         e24gd1rZbDeXat4Q0fv9S1bk/ov7zJuz7DF/SIEXONAsVosohusYmoG/wgE2Ur8l3/h/
         KO7HS5vHHUzSHaAVcdQ1qEj8Q8HC4i7233WTpYdPadSS32p/ao5kUp91X6SJ37kxh2r8
         oRmUy1QJW9nGIvY3Wd+7OXLPifGM3dHSJt0Ts9F2yEeRF/2F9dgUPKoiZVsreitnlqa3
         tD9L5RZ849i69P83kXwpqe8LPRUt3+SwJ6d1xJAqXa0us3BtK3kJaX0kSI7/F1/lWalX
         Va4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731733724; x=1732338524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/eKoaMUC29/TD3G+glT9g4BNUXv4nM1ESsdOPo9vKY=;
        b=JTD77m41KcdqYxi31kc80sQEgi2LLjc57udy91DyuH9PI5Gol4CU41gMaxu2zHwcr3
         +yCes47zXW055sk2oWTp1/wq7Rt8dteFZzQ5z8CrGEzrsdAf/kfIuXDhPvLjqP+cjNqL
         UzcCcZQ5jCMIfZKC3mq2FD8T17YOL/z5i0q6iywtWyBww4MRKmFKw/YXTTv4Xk2/M52L
         vpl8s4G+QjPJ8uHO0aLuYVPZFwJRge02B4BOFgCF0WckCtpSlNH7uZIbDH42Dl6Jsuea
         Xbi1PVHC85NrMzuJIS46bFWT6XDfvOUCyJYEGH54gG4yFPUyw9eX97y0htyzEEFxwznW
         OIrg==
X-Forwarded-Encrypted: i=1; AJvYcCVe54lGUq4suk2XuZLKnIq40u9MdrYnkYnvwA1BWgRcGBLs8bX2i1RN+CVed8RswPETwPJQMapR0g//vGm1pNYd@vger.kernel.org, AJvYcCWYjVO9ZSgnb5SldVKmj9dLFHH/W7N/odQHTvpkZaWUtksSxqkQB/GU+G4tx0W4xEe9WPL8HQ/3RQT10kY=@vger.kernel.org, AJvYcCWnVjOL72t4ZeyE4G6M+wxPorqImgMyBLueZLnNuk0CxBhoz9WdFJq5jlPk6wbKwbzWks+qv/n6@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSRZIOzYqA6CFFTtQw2cCvQQwY1/pfoLzt6nabn0sHNeIfIMX
	btos5eCLxzYHTbUfe3u1WQ+2HNqHckEVsWwIIR/XgjL/xs5ZJBis
X-Google-Smtp-Source: AGHT+IF9sDLT6sF6cr2frs6PJLzlXYic7LrmoXj4m7sMftAG1KAMYVLjm0FuF4SBNXq3UJ4sA1eynQ==
X-Received: by 2002:a17:90a:d2c5:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2ea3d2ea188mr802560a91.15.1731733724391;
        Fri, 15 Nov 2024 21:08:44 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:1128:c4a9:977c:8412? ([2409:8a55:301b:e120:1128:c4a9:977c:8412])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c677sm4066513a91.36.2024.11.15.21.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 21:08:43 -0800 (PST)
Message-ID: <05ec2aed-df1a-4282-9286-2194756c5ef3@gmail.com>
Date: Sat, 16 Nov 2024 13:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 1/7] mm: page_frag: add a test module for
 page_frag
To: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Aishwarya.TCV@arm.com
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-2-linyunsheng@huawei.com>
 <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
 <a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
 <ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
 <20241115143433.05a3671e@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20241115143433.05a3671e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/2024 6:34 AM, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 14:12:09 +0000 Mark Brown wrote:
>>> As above, I am not sure if there is some elegant way to avoid the above error
>>> in the selftest core, one possible way to avoid the above error is to skip
>>> compiling like below as tools/testing/selftests/mm/test_page_frag.sh already
>>> skip the testing for page_frag if the test module is not compiled:
>>
>> Since the tests currently don't build the test systems are by and by
>> large not getting as far as trying to run anything, the entire mm suite
>> is just getting skipped.
> 
> Yunsheng, please try to resolve this ASAP, or just send a revert
> removing the selftest for now. We can't ship net-next to Linus breaking
> other subsystem's selftests, and merge window will likely open next
> week.

Sure, Let me try to fix first, the revert can be used as last resort.

A possible fix is sent in [1], but somehow I missed to add the netdev
ML for that:(

1. 
https://lore.kernel.org/lkml/20241116042314.100400-1-yunshenglin0825@gmail.com/

> 


