Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338D7AEC57
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjIZMTM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjIZMTL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 08:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63215FB
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695730701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFOa8v6HmzDuwfUtqIaAE2BKKG96nSYmL5UwcSOkLOQ=;
        b=dlRnsQZYIX0+iGdU3x/cOsnO7QfyBQCAqjIsCBU2J04/RcKEhQEcikt78Z96qcMM1/VJ4g
        MOTVG1CYXMvUtb86oVZ7usfR8OrkgR1Fo685vrbWWWtL5zQpfTqKqrgCnULjmmWgi+sHYU
        cUIuGVQSQ+lxQ2f9u7lamQkSQ1SqpdA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-sYah3oPLMR63Rnk3t4ymVg-1; Tue, 26 Sep 2023 08:18:18 -0400
X-MC-Unique: sYah3oPLMR63Rnk3t4ymVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBA521C06356;
        Tue, 26 Sep 2023 12:18:17 +0000 (UTC)
Received: from [10.22.16.230] (unknown [10.22.16.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5442F492C37;
        Tue, 26 Sep 2023 12:18:17 +0000 (UTC)
Message-ID: <ed2993f2-4bdc-19c5-5a0f-1e96da44fb24@redhat.com>
Date:   Tue, 26 Sep 2023 08:18:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] selftests/cgroup: Fix awk usage in test_cpuset_prs.sh
 that may cause error
Content-Language: en-US
To:     Juntong Deng <juntong.deng@outlook.com>, lizefan.x@bytedance.com,
        tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB07522BFC89B6B6DC5A89153999FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <VI1P193MB07522BFC89B6B6DC5A89153999FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/23 15:38, Juntong Deng wrote:
> According to the awk manual, the -e option does not need to be specified
> in front of 'program' (unless you need to mix program-file).
>
> The redundant -e option can cause error when users use awk tools other
> than gawk (for example, mawk does not support the -e option).
>
> Error Example:
> awk: not an option: -e
> Cgroup v2 mount point not found!
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>   tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 4afb132e4e4f..6820653e8432 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -20,7 +20,7 @@ skip_test() {
>   WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
>   
>   # Find cgroup v2 mount point
> -CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
> +CGROUP2=$(mount -t cgroup2 | head -1 | awk '{print $3}')
>   [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
>   
>   CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")

Yes, the -e option is redundant. Thanks for catching that.

Acked-by: Waiman Long <longman@redhat.com>

