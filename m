Return-Path: <linux-kselftest+bounces-3817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4856843A0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B04287225
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08B83CD9;
	Wed, 31 Jan 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb21Wz4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5083CC7;
	Wed, 31 Jan 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691136; cv=none; b=cpEz0BfzsqAwK4h5IE0mo9R1JpO/Ve2XfYtTkMXsrR4+pGaFDZoi/5XLoFilmjgs4DxjW2ljWa0m+RDof0ZFEzt/fmF2tmcV97TVjysGac2fY0HplGjVAI5mXtmuhEumGwQlHw87BJRSpXipwFAnFuibQOxj3ICldr5A9I2G9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691136; c=relaxed/simple;
	bh=clMrHZU2GF53Tpacy8wD/x0nw0/Nk2XPk7uDScTtH9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFg+WvpQRvJ82gveWaSOzXRUKgWdUJVCIHm61ukfsE9L/AWwjD7At/crrNfkDkh0qfCI9ha0wokkSc/r8LC8S1OmSf+eHAu0a+vm9854ttwOA8TUcrpz6xGPJkNv8AKz/3HTpFTETCUJwjidajA9sXhLjT5ixaai3GA5sUJEBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb21Wz4m; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706691134; x=1738227134;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=clMrHZU2GF53Tpacy8wD/x0nw0/Nk2XPk7uDScTtH9A=;
  b=hb21Wz4mPMjKa3RSd5H2jS9/Kfuodsp7O9LDXEyfSNhjPhqGnCpEeqy4
   a9b4faeL3z6uAceBMMfQ7r2mmxzqwAOo+cnXy8DQ2uIYr8YoNKGPP996y
   l6QVUtYrJmr4IoESTJBd/KrtMYd/AmhQKKhXt8fk+NHJYNMyJZd9dmgFj
   ArutH2c+GpZOskFiF0/SsMsbhtABstgwX/gNtd6EBC5t65svI+ITF1BU9
   jbhmkaPGUjl8BFO2PyhyYqfX3NnzUmtiN79Uwtm8v1jKAv1WCGgFdckkl
   KJfTbFi8d+RtV/H8sVq3zn4ucGLnqzBtQiHbGuGQJO8+9eZg/WmiSs75B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467779456"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="467779456"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858742290"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858742290"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2024 00:52:11 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id DA7793051D4; Wed, 31 Jan 2024 00:52:11 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Corbet <corbet@lwn.net>,  Shuah
 Khan <shuah@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  wine-devel@winehq.org,  =?utf-8?Q?Andr=C3=A9?=
 Almeida
 <andrealmeid@igalia.com>,  Wolfram Sang <wsa@kernel.org>,  Arkadiusz Hiler
 <ahiler@codeweavers.com>,  Peter Zijlstra <peterz@infradead.org>,  Andy
 Lutomirski <luto@kernel.org>,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 19/29] selftests: ntsync: Add some tests for
 NTSYNC_IOC_WAIT_ANY.
In-Reply-To: <20240131021356.10322-20-zfigura@codeweavers.com> (Elizabeth
	Figura's message of "Tue, 30 Jan 2024 20:13:46 -0600")
References: <20240131021356.10322-1-zfigura@codeweavers.com>
	<20240131021356.10322-20-zfigura@codeweavers.com>
Date: Wed, 31 Jan 2024 00:52:11 -0800
Message-ID: <878r45khqc.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elizabeth Figura <zfigura@codeweavers.com> writes:

> +TEST(test_wait_any)
> +{
> +	struct ntsync_mutex_args mutex_args = {0};
> +	struct ntsync_wait_args wait_args = {0};
> +	struct ntsync_sem_args sem_args = {0};
> +	__u32 owner, index, count;
> +	struct timespec timeout;
> +	int objs[2], fd, ret;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &timeout);
> +
> +	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
> +	ASSERT_LE(0, fd);
> +
> +	sem_args.count = 2;
> +	sem_args.max = 3;
> +	sem_args.sem = 0xdeadbeef;
> +	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_NE(0xdeadbeef, sem_args.sem);
> +
> +	mutex_args.owner = 0;
> +	mutex_args.count = 0;
> +	mutex_args.mutex = 0xdeadbeef;
> +	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_NE(0xdeadbeef, mutex_args.mutex);

It seems your tests are missing test cases for exceeding any limits,
especially overflow/underflow cases. Since these are the most likely
for any security problems it would be good to have extra coverage here.
The fuzzers will hopefully hit it too.

Also some stress testing with multiple threads would be useful.

-Andi


