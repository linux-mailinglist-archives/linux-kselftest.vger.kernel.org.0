Return-Path: <linux-kselftest+bounces-2255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800D819DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC7D1C20F7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F521340;
	Wed, 20 Dec 2023 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hrUh7nxY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460D21350;
	Wed, 20 Dec 2023 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6UF3u024892;
	Wed, 20 Dec 2023 05:16:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=VZbrjRCy0AAo8RNgyyUy8yOaJCjKdRG4waMvAX3/Dv8=; b=
	hrUh7nxYOYvDDvrpblKEPcJYufp3IzT7cC3msl2Au7wT9TAswacIBcqbum0OQ8pE
	SZ6OIiearssd645dabnLtxXI/wIr9f4Zp9uiOxvmgrL0UQ/8eSF2WaccV9kfccnK
	2Puz7BGgDVAAXYSqN2y439+Sqs4Fz4OgY5f1UJiuhU0VqTtf4XE4t8mPf2KaZFBc
	wE0OoPOHoBeT/YBu0jWLzjBaVdSoZQcctBWlBDts2TxeDl3NJARigBXFSVakIIGa
	5Hy3JTluujsEM3ZebZN+TT4VASceXXvzWJVaHT4VlFvoJ6Q1pYf0ukCdGL6aVwOK
	W1DBMl7Nk4AMv2y96PeVpw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196nd9hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 05:16:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 11:16:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 20 Dec 2023 11:16:23 +0000
Received: from [198.90.251.82] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 962A111AB;
	Wed, 20 Dec 2023 11:16:22 +0000 (UTC)
Message-ID: <b88d4e9c-d249-498b-afeb-63a2e823e089@opensource.cirrus.com>
Date: Wed, 20 Dec 2023 11:16:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kunit: run test suites only after module
 initialization completes
To: Marco Pagani <marpagan@redhat.com>,
        Brendan Higgins
	<brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Rae Moar
	<rmoar@google.com>
CC: Javier Martinez Canillas <javierm@redhat.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
References: <20231206150729.54604-1-marpagan@redhat.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20231206150729.54604-1-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 254LZ0vv1XrUbXvNUpnwMgUrIC8-NLhr
X-Proofpoint-GUID: 254LZ0vv1XrUbXvNUpnwMgUrIC8-NLhr
X-Proofpoint-Spam-Reason: safe

On 06/12/2023 15:07, Marco Pagani wrote:
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
> happened during the loading phase of test suites built and executed as
> loadable modules. However, it also introduced a problematic side effect
> that causes test suites modules to crash when they attempt to register
> fake devices.
> 
> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
> MODULE_STATE_COMING states before reaching the normal operating state
> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
> MODULE_STATE_GOING before being released. However, if the loading
> function load_module() fails between complete_formation() and
> do_init_module(), the module goes directly from MODULE_STATE_COMING to
> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
> 
> This behavior was causing kunit_module_exit() to be called without
> having first executed kunit_module_init(). Since kunit_module_exit() is
> responsible for freeing the memory allocated by kunit_module_init()
> through kunit_filter_suites(), this behavior was resulting in a
> wild-memory-access bug.
> 
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed this issue by running the tests when the
> module is still in MODULE_STATE_COMING. However, modules in that state
> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
> module attempts to register a fake device, it will inevitably crash.
> 
> This patch proposes a different approach to fix the original
> wild-memory-access bug while restoring the normal module execution flow
> by making kunit_module_exit() able to detect if kunit_module_init() has
> previously initialized the tests suite set. In this way, test modules
> can once again register fake devices without crashing.
> 
> This behavior is achieved by checking whether mod->kunit_suites is a
> virtual or direct mapping address. If it is a virtual address, then
> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
> pointing to the original address that was set when looking up the
> .kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
> 
> v3:
> - add a comment to clarify why the start address is checked
> v2:
> - add include <linux/mm.h>
> 
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

For V3:

Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Fixes this crash:
https://lore.kernel.org/all/e239b94b-462a-41e5-9a4c-cd1ffd530d75@opensource.cirrus.com/

Also tested with sound/pci/hda/cirrus_scodec_test.c

