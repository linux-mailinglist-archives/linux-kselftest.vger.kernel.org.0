Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD07CB7F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJQB2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQB2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 21:28:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661A9B;
        Mon, 16 Oct 2023 18:28:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S8bqV47KFzVlCL;
        Tue, 17 Oct 2023 09:24:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 09:28:00 +0800
Message-ID: <8f08ef23-bbe1-bebb-eee5-e202c98dbb44@huawei.com>
Date:   Tue, 17 Oct 2023 09:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] kunit: run test suites only after module initialization
 completes
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
References: <20231016203548.21993-1-marpagan@redhat.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20231016203548.21993-1-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/10/17 4:35, Marco Pagani wrote:
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") is causing all test suites to run (when
> built as modules) while still in MODULE_STATE_COMING. In that state,
> test modules are not fully initialized and lack sysfs kobjects.
> This behavior can cause a crash if the test module tries to register
> fake devices.
> 
> This patch restores the normal execution flow, waiting for the module
> initialization to complete before running the test suites.
> The issue reported in the commit mentioned above is addressed using
> virt_addr_valid() to detect if the module loading has failed
> and mod->kunit_suites has not been allocated using kmalloc_array().
> 
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  lib/kunit/test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 421f13981412..1a49569186fc 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -769,12 +769,14 @@ static void kunit_module_exit(struct module *mod)
>  	};
>  	const char *action = kunit_action();
>  
> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +		return;
> +
>  	if (!action)
>  		__kunit_test_suites_exit(mod->kunit_suites,
>  					 mod->num_kunit_suites);

If the module state is from MODULE_STATE_LIVE to MODULE_STATE_GOING, in
kunit_module_init() the kunit_exec_run_tests() is executed when action
is NULL whether kunit_filter_suites() succeeds or not. But in
kunit_module_exit() __kunit_test_suites_exit() will not be executed when
action is NULL if kunit_filter_suites() fails.

>  
> -	if (suite_set.start)
> -		kunit_free_suite_set(suite_set);
> +	kunit_free_suite_set(suite_set);
>  }
>  
>  static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
> @@ -784,12 +786,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>  
>  	switch (val) {
>  	case MODULE_STATE_LIVE:
> +		kunit_module_init(mod);
>  		break;
>  	case MODULE_STATE_GOING:
>  		kunit_module_exit(mod);
>  		break;
>  	case MODULE_STATE_COMING:
> -		kunit_module_init(mod);
>  		break;
>  	case MODULE_STATE_UNFORMED:
>  		break;
