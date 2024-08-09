Return-Path: <linux-kselftest+bounces-15060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1B94CBDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6631BB20BC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D017623A;
	Fri,  9 Aug 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="JzEsI228"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010FC8D1;
	Fri,  9 Aug 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190773; cv=pass; b=V8TLWs+rsg9XKS7V5LL02ip6BAKcncDMdX7vxYNuyD6S90YZGYSwubBD3eAAs/z9LRgI1eAtjUyzdnp6yCZT5FXcQeigvpR0ckNVkBTT8Xp51DwILnyzwNA95likmmHaBwnbLOZ9CWo8z2T0Q1ZcDXkJcH7pg5ODOnGY41/kZ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190773; c=relaxed/simple;
	bh=Cl9Dewi2Rq6zcHumdBriW/ismSmPNEXUrJwFR0TJw6M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mNR2FPriSDTUUIrantqpdO6b1E5eVMXlAmvndEH3rpP4OWPDqqNLBPi9Zty02SlQ5178smE7gmMUxnnU19IAmOKLeDSBKQ2fGK0350ZFc2xYCOX1/smNMq8wVdMNGKySEaqXIpAKhDx7KHm9rmuGxjjZRGZTKse08D37gocxbow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=JzEsI228; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723190748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VlXtCAvDnV2VIVqxe/V8j6kVAHrGofQSuKDkUUnFmbX3QvndtkB2sJtpjMPLDbbN/kakDWCgm5G+xlWe40bIK/1Bk9Kp0Lo/xSGv94X21quU5LOJ877t//9K+t1kWCuA+vQJXntnLYFVLgnluyn5hfph0hLQCXH3HMSrRjuL3SA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723190748; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6MyEdyt6ey7wA9ddBiHtScRZUQGHpxzx9hd6e/N8ulk=; 
	b=eYUe9AsPe4SWctNi/pIlYr3ltQ/0IbT8xN6Jryh8fI12IXA5Vl3AbXBpxBK5vEDafxrnQvSnbCU8UaHoMbN5arPdxgSM7KHEewdNwYbfimSr4YcAbq5wFtr3eTLubVv6zY/gTcqy2RXDeifjDrFmijM8/yvxqB47tw9z5eoqP2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723190748;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6MyEdyt6ey7wA9ddBiHtScRZUQGHpxzx9hd6e/N8ulk=;
	b=JzEsI228OODI9Cj4siY5Pz79/EMI4OzM7XrkT55dwqX4L6L2fre3q8w1USL9p2tU
	4+tsp4co4JKS2MDu379udw5Efk9DuIC+9B5JkIpCKgdBXIqgSPO7Biv/7gWJf2q/TMg
	RfZaMxuJjSa9xp+MLIC3KbPfSzLPg1TH2HF0uPtg=
Received: by mx.zohomail.com with SMTPS id 1723190745513476.6928946853733;
	Fri, 9 Aug 2024 01:05:45 -0700 (PDT)
Message-ID: <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
Date: Fri, 9 Aug 2024 13:05:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
> 
>> This test doesn't have support for other architectures. Altough resctrl
>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
>> only x86 for AMD and Intel are supported by the test.
> 
> One does not follow from the other. arch_supports_noncont_cat() is only 
> small part of the tests so saying "This test" based on a small subset of 
> all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be 
> added and arch_supports_noncont_cat() adapted accordingly.
I'm not familiar with resctrl and the architectural part of it. Feel
free to fix it and ignore this patch.

If more things are missing than just adjusting
arch_supports_noncont_cat(), the test should be turned off until proper
support is added to the test.

> 
>> We get build
>> errors when built for ARM and ARM64.
> 
> As this seems the real reason, please quote any errors when you use them 
> as justification so it can be reviewed if the reasoning is sound or not.

  CC       resctrl_tests
In file included from resctrl.h:24,
                 from cat_test.c:11:
In function 'arch_supports_noncont_cat',
    inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
       \
      |         ^~~~~~~
cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
  301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~
../kselftest.h:74:9: error: impossible constraint in 'asm'
   74 |         __asm__ __volatile__ ("cpuid\n\t"
       \
      |         ^~~~~~~
cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
  303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
      |                 ^~~~~~~~~~~~~


-- 
BR,
Muhammad Usama Anjum


