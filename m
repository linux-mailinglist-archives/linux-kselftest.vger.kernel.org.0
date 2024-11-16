Return-Path: <linux-kselftest+bounces-22135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763C9CFCBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 06:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10E91F2228B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 05:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E118FDBC;
	Sat, 16 Nov 2024 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6cBmwID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3B2FB2;
	Sat, 16 Nov 2024 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731733365; cv=none; b=ETDCWBFfBO9/y7i9J0SeobIyeqbVZk0fiU1Sjw6bk5XvSL6SMTDy7cNHY/jj015cZ5ve4JEWDCFsUmPJpuuriVlEqQhLq2iin914GMaLtG46mywtS2cX1c8+S/8FqC7bJqYWPWR7OYn/HQ1vBDXmp7ZWYPXZo61qQ/MaTM2NAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731733365; c=relaxed/simple;
	bh=/5BFlscptPNtSujPBdU+7WIWbwy16Lh1D5uiAhp7OHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV33g4LWU8/d0Dg/UOT4YgkZAGpOp5mr3SMGIfKqRonXvGQnCkLXMJ6eOspqYC44aY96PzW5IUUCwqG0R2FoCje235cHb3X1WWwYBqymkXYl1s87RIwdTqHlPuEf7KAA2O/JIBA0RpKtpryZV81xEKQQg9LKbl5srtwN075vNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6cBmwID; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7206304f93aso260561b3a.0;
        Fri, 15 Nov 2024 21:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731733364; x=1732338164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Al2Fv5O+3DHuButDDwBDr/yMow4Wua+CLhtsdNpXD4k=;
        b=O6cBmwIDqFAKDVWcOdfjildSjKMbRyReHpkcVZw9kdjreYPq/1tqX0VR8+glH0MBEX
         DqRwUoXCudFt8+Tr7sLsInn5IkBM7wVAww0Y7UztwQMtjuAI6+bgObl63ZVWrsue5HED
         gYEsroRYa0x1t/CrVs8FKe3DKZ5KHSWbIfZQ8cNCaaMBLgS6vug+N23m6tGPUhZUIko/
         GJXf+VJiGCGZ1DTNv4fwJJgtxKzbMi3YwT1It/NVknQbeRBCc7o5ieCTBbpY6wnYSNd6
         0clAQ7snSNYHmdttUPOXuaEOkPacVNLRpt85Py3ZP8l1E2Oh45xYzxlJiVLln3TRwy+O
         y+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731733364; x=1732338164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al2Fv5O+3DHuButDDwBDr/yMow4Wua+CLhtsdNpXD4k=;
        b=Q1cdyrifz0/5vzHpgEaaGF6lAMrVD9UTJCE3wFUybZZU9dE+dTXmCEO0zRJMKwXnv5
         pM2lLsc02TMfruJrqFK86S0G6kp0h3Zp+Cqp/qaARTv4aOfv1zPChjPSBMiDwihII5Yb
         PL77whFL2E/NrZlfyffE9LJGmEMFHFVdPSwklfAuNrdwD1B7/ynqYDJffPILS6qjh9GG
         oR7pyhDRuYh2ItF4U+daFODkueZ0Wh6owaUJH+Eh372TQacVnMoIHxcHJMlQxmKimHDj
         hyH+GfVkf49WvXdXnKoUkDGqhzktCmVzDi7TAtETFAuAFECcOo/OqpHqqUBmtoIL0cMo
         +9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUFYNZyFH7sIpKETV5HYrmTT7hvrXtqiJVOrR4BEanIzVRT/PLu12kQ1myTKGr9ClUjwZmqLWaPd+j6b6g=@vger.kernel.org, AJvYcCVcHeZKtFBOi24nGk8LkK2xzvww/1WIHSL6wF424Ph5e2qHppBLVtJgkffxSEjTuhpAJuw22oRk@vger.kernel.org, AJvYcCVdqeQ4SXjUvEt3LFTpcp4aXz4ZwdWVqOYAqVizEAxhhxLe1LqM7/p8j9uSiNIPKprM/ZhoeiOMysSmJ0574el7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05vl1kzBuWWvKcXHPEzYnvE/QeZ//qv8bRhSe02yFlZVRxXsF
	CUBC9U6Mft1mrN0AEOtFJ+zIv9TcXPsPtna5x0ZET8IGRdAXIoQnSfraiP3X
X-Google-Smtp-Source: AGHT+IEnO27UZrQ5wsGrVcrctH9PWQnt52pfrgIDphtZTd0pLpaLdSDw3VPq57AJBDsOnC27+WU8MA==
X-Received: by 2002:a05:6a00:3c96:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-72476f7d406mr7437628b3a.19.1731733363577;
        Fri, 15 Nov 2024 21:02:43 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:1128:c4a9:977c:8412? ([2409:8a55:301b:e120:1128:c4a9:977c:8412])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477203a4bsm2238498b3a.192.2024.11.15.21.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 21:02:43 -0800 (PST)
Message-ID: <cc9c8bd7-1eb8-46ca-958d-50fb501a36b5@gmail.com>
Date: Sat, 16 Nov 2024 13:02:38 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mm: page_frag: fix a compile error when kernel
 is not compiled
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: linyunsheng@huawei.com, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Linux-MM <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241116042314.100400-1-yunshenglin0825@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20241116042314.100400-1-yunshenglin0825@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seemed that somehow I missed to add the netdev ML:(

On 11/16/2024 12:23 PM, Yunsheng Lin wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
> 
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Alexander Duyck <alexanderduyck@fb.com>
> CC: Linux-MM <linux-mm@kvack.org>
> Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
> Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Yunsheng Lin <yunshenglin0825@gmail.com>
> ---
> Mote, page_frag test module is only in the net-next tree for now,
> so target the net-next tree.
> ---
>   tools/testing/selftests/mm/Makefile           | 18 ++++++++++++++++++
>   tools/testing/selftests/mm/page_frag/Makefile |  2 +-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index acec529baaca..04e04733fc8a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -36,7 +36,16 @@ MAKEFLAGS += --no-builtin-rules
>   CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>   LDLIBS = -lrt -lpthread -lm
>   
> +KDIR ?= /lib/modules/$(shell uname -r)/build
> +ifneq (,$(wildcard $(KDIR)/Module.symvers))
> +ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
>   TEST_GEN_MODS_DIR := page_frag
> +else
> +PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
> +endif
> +else
> +PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
> +endif
>   
>   TEST_GEN_FILES = cow
>   TEST_GEN_FILES += compaction_test
> @@ -214,3 +223,12 @@ warn_missing_liburing:
>   	echo "Warning: missing liburing support. Some tests will be skipped." ; \
>   	echo
>   endif
> +
> +ifneq ($(PAGE_FRAG_WARNING),)
> +all: warn_missing_page_frag
> +
> +warn_missing_page_frag:
> +	@echo ; \
> +	echo "Warning: $(PAGE_FRAG_WARNING). page_frag test will be skipped." ; \
> +	echo
> +endif
> diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
> index 58dda74d50a3..8c8bb39ffa28 100644
> --- a/tools/testing/selftests/mm/page_frag/Makefile
> +++ b/tools/testing/selftests/mm/page_frag/Makefile
> @@ -1,5 +1,5 @@
>   PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> -KDIR ?= $(abspath $(PAGE_FRAG_TEST_DIR)/../../../../..)
> +KDIR ?= /lib/modules/$(shell uname -r)/build
>   
>   ifeq ($(V),1)
>   Q =


