Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9687461BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCSCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGCSCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 14:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367DE60
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688407292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFe8atToFS2utTEa2xH/lGx0LLo+DpKgRn21BdsYeHk=;
        b=Eyj1tDRyX0v/X1G7HWQ0vIq+wc3fuT/nG2rPE6RZkaFyf9HOCNiSfB8i9S/bYI7wUXKNKR
        Yk+L1Scm4gPsJzQDVwDSX3IxhxOI42YZ3/7k60P66OeBpcqJ1oqgPe+MWOGckGoOXyJaoL
        qSn8j2py6Lf2+i765NJSzNmjvaArBfY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-qlbEta4WP7Otec50GMPY9g-1; Mon, 03 Jul 2023 14:01:27 -0400
X-MC-Unique: qlbEta4WP7Otec50GMPY9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 139C93C02B68;
        Mon,  3 Jul 2023 18:01:27 +0000 (UTC)
Received: from [10.22.17.92] (unknown [10.22.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACF6D2166B31;
        Mon,  3 Jul 2023 18:01:26 +0000 (UTC)
Message-ID: <4bae7852-61b9-999d-765d-a8f0d0084256@redhat.com>
Date:   Mon, 3 Jul 2023 14:01:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/3] selftests: cgroup: Minor code reorganizations
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
References: <20230703172741.25392-1-mkoutny@suse.com>
 <20230703172741.25392-3-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230703172741.25392-3-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/3/23 13:27, Michal Koutný wrote:
> No functional change intended, these small changes are merged into one
> commit and they serve as a preparation for an upcoming new testcase.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   MAINTAINERS                                       | 1 +
>   tools/testing/selftests/cgroup/cgroup_util.c      | 2 ++
>   tools/testing/selftests/cgroup/cgroup_util.h      | 2 ++
>   tools/testing/selftests/cgroup/test_core.c        | 2 +-
>   tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
>   5 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0976ae2a523..03bec83944c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5260,6 +5260,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
>   F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
>   F:	include/linux/cpuset.h
>   F:	kernel/cgroup/cpuset.c
> +F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
>   
>   CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>   M:	Johannes Weiner <hannes@cmpxchg.org>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index e8bbbdb77e0d..0340d4ca8f51 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -286,6 +286,8 @@ int cg_destroy(const char *cgroup)
>   {
>   	int ret;
>   
> +	if (!cgroup)
> +		return 0;
>   retry:
>   	ret = rmdir(cgroup);
>   	if (ret && errno == EBUSY) {
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index c92df4e5d395..1df7f202214a 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -11,6 +11,8 @@
>   #define USEC_PER_SEC	1000000L
>   #define NSEC_PER_SEC	1000000000L
>   
> +#define TEST_UID	65534 /* usually nobody, any !root is fine */
> +
>   /*
>    * Checks if two given values differ by less than err% of their sum.
>    */
> diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
> index 600123503063..80aa6b2373b9 100644
> --- a/tools/testing/selftests/cgroup/test_core.c
> +++ b/tools/testing/selftests/cgroup/test_core.c
> @@ -683,7 +683,7 @@ static int test_cgcore_thread_migration(const char *root)
>    */
>   static int test_cgcore_lesser_euid_open(const char *root)
>   {
> -	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
> +	const uid_t test_euid = TEST_UID;
>   	int ret = KSFT_FAIL;
>   	char *cg_test_a = NULL, *cg_test_b = NULL;
>   	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 2b5215cc599f..4afb132e4e4f 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -10,7 +10,7 @@
>   skip_test() {
>   	echo "$1"
>   	echo "Test SKIPPED"
> -	exit 0
> +	exit 4 # ksft_skip
>   }
>   
>   [[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
Reviewed-by: Waiman Long <longman@redhat.com>

