Return-Path: <linux-kselftest+bounces-20590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7779AF57F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 00:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF8282BB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1421859F;
	Thu, 24 Oct 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QA7Kp6AH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B1022B641
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809384; cv=none; b=gJhvpDgLMygi5pP0oNNcylM+KnW2zZ68z5CkffawElm/+qkey1hpLC+Lh+J530JzNCidZpw5gaxeA0liVZWCxQFbZheho6Xng0gu/f3VJQ2DTYnGpEpxrPvOC34PkJ3wdSQkW4yhiNhhhiUHoL9SOL8U7U3qc955//ZkIqo6Zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809384; c=relaxed/simple;
	bh=vjY9PQ/fSOGrXYcy+DPjFpgaY4oqGzpSqS2jZzjAeew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phBUM2v7bEwONszmKiRSq0Gm6rdR4/md5t7oXlR/tV+O6F2RhalNKgj2EUH1g+5uJydRLSAcKsz9nGAmAs+LUuby27gDkHCOH8yLVivzE/8Ew7onFV16tr2pQYCl/EmkIjQmDlrkwNEz3W9sj5oWwyud2X0JzZB9JZqNYEwsxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QA7Kp6AH; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so59124039f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729809381; x=1730414181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fajw6Yb5oBtjoaGy3t+Nls7OPnROoeYaSLrgcGe/cBo=;
        b=QA7Kp6AHFo8UodwyqDwi2H394nHu7L96A6OiVVQ97bVTCrJpUOx+VBuXuFZbSu7HON
         M6T9xuFHDVn0yQe/aMvi/wrSyFuBJx8C1Pv64sSRP/m2kqVbyugxoJmAqYX/4HMNAvKm
         WcpkrgwOHWel5b9RxMRtqd18i5BuTSHDfkUhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729809381; x=1730414181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fajw6Yb5oBtjoaGy3t+Nls7OPnROoeYaSLrgcGe/cBo=;
        b=wA/y7HDXJ+TZspIXWSFu3iLJ0UdbpFjCqdYNKNv55Jbu32CEyOTXFStkTh0AcMB3O6
         GJOjl8e1uw5qOgEDA6cXvZNhS8BerBvZSD5IUeoY+aYgVkWKUPBb/YGVy6LNPC7iCe8b
         Yf37GGpcVRRsx0elnKHDoH08dw9TzgemT6fwQ8fx9EAffXFnnZ/FP/1gUXNrpRhDFApT
         lX6pjoOz8D6y4fYsXrKZrjZHP6XvD/K3y8+ju8bi3YiF7PoPJlSkE/wfAr1iR7uHDh+9
         285S9ZT4rtlHQ7xSm9OSSSYcA6gcOv3YduJccnereD4Ma0lKmOxhH1LnmW8jaBU/18vi
         DZIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAA1tgrjL8vGMPJks0+RDMtmDaRIJtnn6AaLuw6WGTew8oB0R1myF4+q3pQCjeCM8Qplvk/yzY/SQNrROyoyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb7ll2jNNWuRkmE6sYpVKbw4n+OtuYAPBisrzelU2ltXMrtUj
	Y2C/+dO77IXEwUaAMfI9djMklXJD2NyxREvmtTDYLUP0iB/S/h5Txt1JFNej1wA=
X-Google-Smtp-Source: AGHT+IFppNs58S49k+9JdMjDH86ZkENL8o/9rLiiXFrc5zDNo/r7xxieU79q8mCZV9qW0hGhg6EekA==
X-Received: by 2002:a05:6602:60ca:b0:835:4cb5:4fa7 with SMTP id ca18e2360f4ac-83b041817c7mr358279339f.12.1729809380790;
        Thu, 24 Oct 2024 15:36:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ae6b2261dsm210989039f.54.2024.10.24.15.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 15:36:20 -0700 (PDT)
Message-ID: <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
Date: Thu, 24 Oct 2024 16:36:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org, tony.luck@intel.com, peternewman@google.com,
 babu.moger@amd.com, ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 15:18, Reinette Chatre wrote:
> Changes since V3:
> - V3: https://lore.kernel.org/all/cover.1729218182.git.reinette.chatre@intel.com/
> - Rebased on HEAD 2a027d6bb660 of kselftest/next.
> - Fix empty string parsing issues pointed out by Ilpo.
> - Add Reviewed-by tags.
> - Please see individual patches for detailed changes.
> 
> Changes since V2:
> - V2: https://lore.kernel.org/all/cover.1726164080.git.reinette.chatre@intel.com/
> - Add fix to protect against buffer overflow when parsing text from sysfs files.
> - Add cleanup patch to address use of magic constants as pointed out by
>    Ilpo.
> - Add Reviewed-by tags where received, except for "selftests/resctrl: Use cache
>    size to determine "fill_buf" buffer size" that changed too much since
>    receiving the Reviewed-by tag.
> - Please see individual patches for detailed changes.
> 
> Changes since V1:
> - V1: https://lore.kernel.org/cover.1724970211.git.reinette.chatre@intel.com/
> - V2 contains the same general solutions to stated problem as V1 but these
>    are now preceded by more fixes (patches 1 to 5) and improved robustness
>    (patches 6 to 9) to existing tests before the series gets back
>    to solving the original problem with more confidence in patches 10 to 13.
> - The posibility of making "memflush = false" for CMT test was discussed
>    during V1. Modifying this setting does not have a significant impact on the
>    observed results that are already well within acceptable range and this
>    version thus keeps original default. If performance was a goal it may
>    be possible to do further experimentation where "memflush = false" could
>    eliminate the need for the sleep(1) within the test wrapper, but
>    improving the performance is not a goal of this work.
> - (New) Support what seems to be unintended ability for user space to provide
>    parameters to "fill_buf" by making the parsing robust and only support
>    changing parameters that are supported to be changed. Drop support for
>    "write" operation since it has never been measured.
> - (New) Improve wraparound handling. (Ilpo)
> - (New) A couple of new fixes addressing issues discovered during development.
> - (Change from V1) To support fill_buf parameters provided by user space as
>    well as test specific fill_buf parameters struct fill_buf_param is no longer
>    just a member of struct resctrl_val_param, instead there could be at most
>    two instances of struct fill_buf_param, the immutable parameters provided
>    by user space and the parameters used by individual tests. (Ilpo)
> - Please see individual patches for detailed changes.
> 
> V1 cover:
> 
> The resctrl selftests for Memory Bandwidth Allocation (MBA) and Memory
> Bandwidth Monitoring (MBM) are failing on some (for example [1]) Emerald
> Rapids systems. The test failures result from the following two
> properties of these systems:
> 1) Emerald Rapids systems can have up to 320MB L3 cache. The resctrl
>     MBA and MBM selftests measure memory traffic for which a hardcoded
>     250MB buffer has been sufficient so far. On platforms with L3 cache
>     larger than the buffer, the buffer fits in the L3 cache and thus
>     no/very little memory traffic is generated during the "memory
>     bandwidth" tests.
> 2) Some platform features, for example RAS features or memory
>     performance features that generate memory traffic may drive accesses
>     that are counted differently by performance counters and MBM
>     respectively, for instance generating "overhead" traffic which is not
>     counted against any specific RMID. Until now these counting
>     differences have always been "in the noise". On Emerald Rapids
>     systems the maximum MBA throttling (10% memory bandwidth)
>     throttles memory bandwidth to where memory accesses by these other
>     platform features push the memory bandwidth difference between
>     memory controller performance counters and resctrl (MBM) beyond the
>     tests' hardcoded tolerance.
> 
> Make the tests more robust against platform variations:
> 1) Let the buffer used by memory bandwidth tests be guided by the size
>     of the L3 cache.
> 2) Larger buffers require longer initialization time before the buffer can
>     be used to measurement. Rework the tests to ensure that buffer
>     initialization is complete before measurements start.
> 3) Do not compare performance counters and MBM measurements at low
>     bandwidth. The value of "low" is hardcoded to 750MiB based on
>     measurements on Emerald Rapids, Sapphire Rapids, and Ice Lake
>     systems. This limit is not applicable to AMD systems since it
>     only applies to the MBA and MBM tests that are isolated to Intel.
> 
> [1]
> https://ark.intel.com/content/www/us/en/ark/products/237261/intel-xeon-platinum-8592-processor-320m-cache-1-9-ghz.html
> 
> Reinette Chatre (15):
>    selftests/resctrl: Make functions only used in same file static
>    selftests/resctrl: Print accurate buffer size as part of MBM results
>    selftests/resctrl: Fix memory overflow due to unhandled wraparound
>    selftests/resctrl: Protect against array overrun during iMC config
>      parsing
>    selftests/resctrl: Protect against array overflow when reading strings
>    selftests/resctrl: Make wraparound handling obvious
>    selftests/resctrl: Remove "once" parameter required to be false
>    selftests/resctrl: Only support measured read operation
>    selftests/resctrl: Remove unused measurement code
>    selftests/resctrl: Make benchmark parameter passing robust
>    selftests/resctrl: Ensure measurements skip initialization of default
>      benchmark
>    selftests/resctrl: Use cache size to determine "fill_buf" buffer size
>    selftests/resctrl: Do not compare performance counters and resctrl at
>      low bandwidth
>    selftests/resctrl: Keep results from first test run
>    selftests/resctrl: Replace magic constants used as array size
> 
>   tools/testing/selftests/resctrl/cmt_test.c    |  37 +-
>   tools/testing/selftests/resctrl/fill_buf.c    |  45 +-
>   tools/testing/selftests/resctrl/mba_test.c    |  54 ++-
>   tools/testing/selftests/resctrl/mbm_test.c    |  37 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  79 +++-
>   .../testing/selftests/resctrl/resctrl_tests.c |  95 +++-
>   tools/testing/selftests/resctrl/resctrl_val.c | 447 +++++-------------
>   tools/testing/selftests/resctrl/resctrlfs.c   |  19 +-
>   8 files changed, 354 insertions(+), 459 deletions(-)
> 
> 
> base-commit: 2a027d6bb66002c8e50e974676f932b33c5fce10

Is this patch series ready to be applied?

thanks,
-- Shuah


