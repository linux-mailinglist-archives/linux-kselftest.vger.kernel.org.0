Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06484620994
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 07:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiKHG3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 01:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHG3n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 01:29:43 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE5C13CFD;
        Mon,  7 Nov 2022 22:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667888982; x=1699424982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7xP5TpKUqB7egpe5bWLlRd8LPgmKi22LPe7NE5mGBqU=;
  b=BOfDYZbST6pvJGJoEFrFuQA6NEfAcuinZ6dOW8zjW2gJ3WaLalP/AfSZ
   4ZlD7677XYsttoTG0+kySNC3P7WvBggv5xlrorVK0CmMCvpiYwNnOlm0B
   D4GuXZXItuOyVfVQ5XxfosJ/SmaOz+9Cc1JCiSL8MvaAcKdylCJK8ZFYe
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Nov 2022 22:29:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 22:29:41 -0800
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 22:29:37 -0800
Message-ID: <b123bd21-241c-de06-c3d7-e4505ee6e1e3@quicinc.com>
Date:   Tue, 8 Nov 2022 11:59:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] selftests: cgroup: Fix unsigned comparison with less than
 zero
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <shuah@kernel.org>, <yosryahmed@google.com>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <rientjes@google.com>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221105110611.28920-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221105110611.28920-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 11/5/2022 4:36 PM, YueHaibing wrote:
> 'size' is unsigned, it never less than zero.
> 
> Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6f2f9c..e8bbbdb77e0d 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
>   ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>   {
>   	char path[PATH_MAX];
> +	ssize_t ret;
>   
>   	if (!pid)
>   		snprintf(path, sizeof(path), "/proc/%s/%s",
> @@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
>   	else
>   		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
>   
> -	size = read_text(path, buf, size);
> -	return size < 0 ? -1 : size;
> +	ret = read_text(path, buf, size);
> +	return ret < 0 ? -1 : ret;
>   }
>   
>   int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
