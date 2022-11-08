Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F3620580
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiKHBA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 20:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiKHBAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 20:00:46 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6020BF6;
        Mon,  7 Nov 2022 17:00:45 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:00:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667869243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwrfcPLWegZuEEj6CKXHwu1qKx5JNoa40Mx3JbzZqAQ=;
        b=B7ri3UCtv3d9fm2jpYiLnPJPeUql2n6CDoGeYOaKmhurHDVulZvaXfdl9zcXOySTiQXpdl
        3NBMoukjfCAUQPIHFGwBdG4Y6Z1OICOr5yjOAtskNfzQJixSbkIep7zDd6HOK5TlhDDwYo
        7Edd6tBQzP3ulK36p3Y6KEKHG2aK06o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, yosryahmed@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: Fix unsigned comparison with less
 than zero
Message-ID: <Y2mqNtqpmRnEBxcC@P9FQF9L96D>
References: <20221105110611.28920-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105110611.28920-1-yuehaibing@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 05, 2022 at 07:06:11PM +0800, YueHaibing wrote:
> 'size' is unsigned, it never less than zero.
> 
> Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6f2f9c..e8bbbdb77e0d 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
>  ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>  {
>  	char path[PATH_MAX];
> +	ssize_t ret;
>  
>  	if (!pid)
>  		snprintf(path, sizeof(path), "/proc/%s/%s",
> @@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
>  	else
>  		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
>  
> -	size = read_text(path, buf, size);
> -	return size < 0 ? -1 : size;
> +	ret = read_text(path, buf, size);
> +	return ret < 0 ? -1 : ret;
>  }

Indeed, good catch!

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
