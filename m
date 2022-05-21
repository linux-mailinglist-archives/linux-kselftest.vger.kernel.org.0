Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69952FAA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 12:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiEUKZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiEUKZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 06:25:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B654032;
        Sat, 21 May 2022 03:25:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id CFE571F46413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653128707;
        bh=lBOnXIC7rDI/XGVOI25lydeYhAWS63MlMY/nx5UGlLI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=GkT6VGFso/wL6JhQo1/m7n2V+8gVKfvw5W0OgrXT76T7QVQmHpDTwOcb44zavI/QJ
         PWBMDkcVjAxMH0VyLou7Kz+dQ6lMdHBL83AgFO2KfLX84ZYZdfPhIt4s47ZiHgXZAy
         AMRnl9hLLfnO8pVa+uiZAosCmNIvu61yMgGkDmxXvAbFKseL09c9OMyeBSica2i2fC
         z7OucM+WeBD4zQPxkwuBrTibedhPZl8tkvPwW9mrw/t4DuAasHb4qfy5zti2Hex0q9
         nDsiDOOHd4xgYQiaIT5i3sSovhAxKSpd1HemtYndb75Evx/5Z7QBIYlYt43nsfIfXN
         jfVw0HiauCLLw==
Message-ID: <0ede5fe6-89c8-5e63-0c0c-265b57ea5ca6@collabora.com>
Date:   Sat, 21 May 2022 15:24:59 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Subject: Re: [PATCH v11 8/8] kselftest/cgroup: Add cpuset v2 partition root
 state test
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-9-longman@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220510153413.400020-9-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 8:34 PM, Waiman Long wrote:
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index 745fe25fa0b9..01687418b92f 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -1,10 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -Wall -pthread
>  
> -all:
> +all: ${HELPER_PROGS}
>  
>  TEST_FILES     := with_stress.sh
> -TEST_PROGS     := test_stress.sh
> +TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
> +TEST_GEN_FILES := wait_inotify
Please add wait_inotify to .gitignore file.

>  TEST_GEN_PROGS = test_memcontrol
>  TEST_GEN_PROGS += test_kmem
>  TEST_GEN_PROGS += test_core

-- 
Muhammad Usama Anjum
