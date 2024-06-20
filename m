Return-Path: <linux-kselftest+bounces-12377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C8E9115EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAEB21C06
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B91140E30;
	Thu, 20 Jun 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRaF9NUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D813E8AE;
	Thu, 20 Jun 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923997; cv=none; b=aIBKLt6nkivF83LR3KqdzdE8sSwkmJ10O4UZV14zJVvDg9Ff2ueGQJ5yn3v3xmZx7UY70kUBekyFdoALMfcTBrBlFWav6GVXJIbSah9WxAzWNhH/+UT47WyYwBdhL1hZ24PRlY2Xg3CZewK/SQOX6c6XbIkHB+jPYE1MCeI5ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923997; c=relaxed/simple;
	bh=hDSr4XMNw/8z3vhBbwyVdj5ipvE/omFz38Ap/eQ8Ewo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SaExg8MYNwbrtNS+SjToPObSprKy8M+obpjBJQqd47uapdqAZT46ooh7AFkhACwD2bhxAwMHyTIggjqWQCPTYGZGomssGe4Kqaj/P0roUXHnS1ZENjeuigUJYqtBDlB0rPonfX/Y7SVYPH7xuIjhrIeGdF/WOZRQ3eZ4zmbc9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRaF9NUy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923992; x=1750459992;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hDSr4XMNw/8z3vhBbwyVdj5ipvE/omFz38Ap/eQ8Ewo=;
  b=iRaF9NUyv7I7sR3O2pFX0ikZInmNAX7Q8qwabV/YZ5ZwbG0kUXOOhbbU
   gg2D74+22XYK9hLkt4pCuIER4J+ztuwa0HzD2jzrIb37SsYGNqpzQPZ/d
   4fxmxqnrSTaRL3/I83DEIad03svZ3OS+/EDWsASDhZ2miWDp1ZWqnO2HV
   pDEnA4B5L4B63HOp/lZVSyQDF+zf1QA3DJYDc2rSMZH0XLtjjVSzMfv8j
   13s9ZbYOygLTZ+GzsRnBvIZHJCvD2Z3GnovtvgUlJYYa2HM3MqQqVqJhf
   BZD1Y9IfROjpkXB9wMsUNEq8vr4rRS3kuOsrRZA2eSxbwD8eEEZlRVyRF
   w==;
X-CSE-ConnectionGUID: 3CCa9BFFR1yXSRtb/pHvwg==
X-CSE-MsgGUID: gm13UFmbQgmZQfWgXgGNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="26532636"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="26532636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:53:11 -0700
X-CSE-ConnectionGUID: R+PsCL3ESuSVpJWXVCMXDw==
X-CSE-MsgGUID: CvAYJ6PdQa2AwpCYXcSsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="79904515"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2024 15:53:11 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 1631A3003B6; Thu, 20 Jun 2024 15:53:11 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com,  linmiaohe@huawei.com,  jane.chu@oracle.com,
  osalvador@suse.de,  muchun.song@linux.dev,  akpm@linux-foundation.org,
  shuah@kernel.org,  corbet@lwn.net,  rientjes@google.com,
  duenwen@google.com,  fvdl@google.com,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Userspace controls soft-offline pages
In-Reply-To: <20240620184856.600717-1-jiaqiyan@google.com> (Jiaqi Yan's
	message of "Thu, 20 Jun 2024 18:48:52 +0000")
References: <20240620184856.600717-1-jiaqiyan@google.com>
Date: Thu, 20 Jun 2024 15:53:11 -0700
Message-ID: <87msnfusyw.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiaqi Yan <jiaqiyan@google.com> writes:

> Correctable memory errors are very common on servers with large
> amount of memory, and are corrected by ECC, but with two
> pain points to users:
> 1. Correction usually happens on the fly and adds latency overhead
> 2. Not-fully-proved theory states excessive correctable memory
>    errors can develop into uncorrectable memory error.

This patchkit is amusing (or maybe sad) because it basically tries to
reconstruct the original soft offline design using a user space daemon
instead of doing policy badly in the kernel.

You can still have it by enabling CONFIG_X86_MCELOG_LEGACY and
use http://www.mcelog.org or an equivalent daemon of your chosing
that listens to /dev/mcelog.

-Andi


