Return-Path: <linux-kselftest+bounces-15991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83395ACB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71921F22933
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694905C8FC;
	Thu, 22 Aug 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="TNsMlWzS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCE59147;
	Thu, 22 Aug 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302188; cv=pass; b=IBTnftzuZuf2ZrupBeJtWnJRe3TSZ+5+Qb55smNekrZqO7sOVxmmd5+fMrtNpNNRl6CqMqcVNIixCSZF14hkqv7nEaT8dZZ5VqeHOk+91/Ya/TN5WwslmIFOmjPTE20L952YGAR9kyO7akgpxJBNIjgbn7qbhV2QgDfXzD18eWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302188; c=relaxed/simple;
	bh=Q/BPZ07ShpNvni1OesYU5KqHjGauFpXv9ZJyl0a9Q/M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YOkngWvQXfifTVPFvNrr3ZIDxv/c7aTkcEU0oIIn/wcPK/5Cpae56MCKqJCZM4LIW1XHmg7b6hYkI+oYlQBDOcla6bRdKunnqFw5oMNxfaY5EWulw1KBM4M9jgSRfzdQROSC9B6rH5CweSGHrRR7TXZRHcxIUFsv6LYWab9ZXLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=TNsMlWzS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724302180; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DscMHIgXirTKVFlhCb6fyMavLiwVi+oIcIzIRw8/ZGn1EVdeeesVyBs5GXDbix7Mko9AVigWK1NWywZt+THAwGPS1bfFhwhk9UQfWCuErKWn51OQepzvVLPn2r7HoaPtUbWFkbd20pJ8g4GOtQnBYtzNe2/jL530BxoAvesTsEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724302180; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4kCUIy3GQgR8I1P6kz5p1DNBE5aF/4lgxAnmki/drsY=; 
	b=nSEETEgp88G23q14nZ/5sjUdmGSsOiUivbGncHE/68unRngD36ruKqywXEs/MVi1pZxrCdkW9XpDkascXePnmalFNsxD3KURJiB5CsDIPa97eUnOaqAxlqTR73tVlJySwgcExy8sAuuRwSW+grU7hkMyazTT4qPqkEyV9w0iA8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724302180;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4kCUIy3GQgR8I1P6kz5p1DNBE5aF/4lgxAnmki/drsY=;
	b=TNsMlWzSncZK1WYfYTBLRaAa/E1TIFjUeJ1Bp0/fBSLJKmEYV18QnZyVoK5Hwos+
	BbfKwAPUAytMZC/bljRe67ioDUVSwf5gQ0wSfbTbaLg0jK2RloCvTg/yzluSW11vXN1
	XABgVZ/yH6TJ32zJuiRN7Bf1SMwQ8y/KQpsf3IeU=
Received: by mx.zohomail.com with SMTPS id 1724302178786144.2840152683093;
	Wed, 21 Aug 2024 21:49:38 -0700 (PDT)
Message-ID: <b6372b9e-f93d-4243-9acd-64b60a6dc779@collabora.com>
Date: Thu, 22 Aug 2024 09:49:31 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [RFC PATCH 3/3] kselftest: Provide __cpuid_count() stub on
 non-x86 archs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
 <20240813104515.19152-4-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240813104515.19152-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/13/24 3:45 PM, Ilpo Järvinen wrote:
> Building resctrl selftest fails on ARM because it uses __cpuid_count()
> that fails the build with error:
> 
>   CC       resctrl_tests
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> In function 'arch_supports_noncont_cat',
>     inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>        \
>       |         ^~~~~~~
> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>   301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>        \
>       |         ^~~~~~~
> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>   303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> 
> The resctrl selftest would run that code only on Intel CPUs but
> as is, the code cannot be build at all.
> 
> Provide an empty stub for __cpuid_count() if it is not supported
> to allow build to succeed.
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest.h | 6 ++++++
>  tools/testing/selftests/lib.mk      | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index b8967b6e29d5..71593add1b39 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -70,10 +70,16 @@
>   * have __cpuid_count().
>   */
>  #ifndef __cpuid_count
> +#ifdef HAVE_CPUID
>  #define __cpuid_count(level, count, a, b, c, d)				\
>  	__asm__ __volatile__ ("cpuid\n\t"				\
>  			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>  			      : "0" (level), "2" (count))
> +#else
> +#define __cpuid_count(level, count, a, b, c, d)	do {			\
> +	(void)a; (void)b; (void)c; (void)d;				\
> +} while (0)
> +#endif
>  #endif
>  
>  /* define kselftest exit codes */
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index d6edcfcb5be8..236db9b24037 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>  # Build with _GNU_SOURCE by default
>  CFLAGS += -D_GNU_SOURCE=
>  
> +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> +CFLAGS += -DHAVE_CPUID=
> +endif
> +
>  # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>  # make USERCFLAGS=-Werror USERLDFLAGS=-static
>  CFLAGS += $(USERCFLAGS)

-- 
BR,
Muhammad Usama Anjum


