Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB662FEBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKRUXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 15:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiKRUXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 15:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DC853EE4
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Nov 2022 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668802967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLNx2lv/9wKRUvF6SaKybhGa6+X/Ftk2qDUqbH/DPVM=;
        b=EdjXZpK+1EqTQeNSBNpLWdWkOAqRdPxiSY1fEtYECzKX+GVBJUiBUpwB2lLoi9kNrT4skN
        llcqbuaj8kYnvxN0duZyoQ8rnTy2DNFCTokHXweR7+vTS1vUJeYm+H5KILqhAquA5dgTBk
        sd62RHjy5wmmlrVVm8lAchgSf5fdxBI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-zHP1jgBKMXmR7pO1DgdPJw-1; Fri, 18 Nov 2022 15:22:44 -0500
X-MC-Unique: zHP1jgBKMXmR7pO1DgdPJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4227A1C05EC0;
        Fri, 18 Nov 2022 20:22:43 +0000 (UTC)
Received: from [10.22.18.201] (unknown [10.22.18.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6BF340C6EC3;
        Fri, 18 Nov 2022 20:22:42 +0000 (UTC)
Message-ID: <5c92d811-63d4-2c92-3018-7ba8d9c4f21a@redhat.com>
Date:   Fri, 18 Nov 2022 15:22:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] kselftest/cgroup: Add cleanup() to test_cpuset_prs.sh
Content-Language: en-US
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118101330.251332-1-kamalesh.babulal@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221118101330.251332-1-kamalesh.babulal@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/18/22 05:13, Kamalesh Babulal wrote:
> Install a cleanup function using the trap command for signals EXIT,
> SIGINT, SIGQUIT and SIGABRT.  The cleanup function will perform:
> 1. Online the CPUs that were made offline during the test.
> 2. Removing the cgroups created.
> 3. Restoring the original /sys/kernel/debug/sched/verbose value,
>     currently it's left turned on, irrespective of the original
>     configuration value.
>
> the test performs steps 1 and 2, on the successful runs, but not during
> all of the failed runs.  With the cleanup(), the system will perform all
> three steps during failed/passed test runs.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
>   .../testing/selftests/cgroup/test_cpuset_prs.sh | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 526d2c42d870..b8ed82b55b1d 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -16,7 +16,12 @@ skip_test() {
>   [[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
>   
>   # Set sched verbose flag, if available
> -[[ -d /sys/kernel/debug/sched ]] && echo Y > /sys/kernel/debug/sched/verbose
> +if [[ -d /sys/kernel/debug/sched ]]
> +then
> +	# Used to restore the original setting during cleanup
> +	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
> +	echo Y > /sys/kernel/debug/sched/verbose
> +fi
>   
>   # Get wait_inotify location
>   WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
> @@ -54,6 +59,15 @@ echo +cpuset > cgroup.subtree_control
>   [[ -d test ]] || mkdir test
>   cd test
>   
> +cleanup()
> +{
> +	online_cpus
> +	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
> +	cd ..
> +	rmdir test > /dev/null 2>&1
> +	echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
> +}
> +
>   # Pause in ms
>   pause()
>   {
> @@ -666,6 +680,7 @@ test_inotify()
>   	fi
>   }
>   
> +trap cleanup 0 2 3 6
>   run_state_test TEST_MATRIX
>   test_isolated
>   test_inotify

That looks good to me. Thanks for the improvement.

Acked-by: Waiman Long <longman@redhat.com>

