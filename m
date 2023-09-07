Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E0796E98
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 03:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjIGBkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 21:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjIGBkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 21:40:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B2133;
        Wed,  6 Sep 2023 18:39:58 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rh2042w3KzMlBr;
        Thu,  7 Sep 2023 09:36:36 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 09:39:56 +0800
Message-ID: <6b0fc12d-e6c5-4a05-a6e6-46e5e5c9ae7b@huawei.com>
Date:   Thu, 7 Sep 2023 09:39:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     <akaher@vmware.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <shuah@kernel.org>, <skhan@linuxfoundation.org>,
        <yeweihua4@huawei.com>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
 <20230906142652.191866-1-naresh.kamboju@linaro.org>
 <20230906145000.29291a1b@gandalf.local.home>
 <20230906184650.074dfdcf@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230906184650.074dfdcf@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/7 06:46, Steven Rostedt wrote:
> On Wed, 6 Sep 2023 14:50:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> BTW, when you ran these, did you apply:
>>
>>    https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230905183332.628d7cc0@gandalf.local.home/
> 
> Can you both try the above patch and this patch?
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c

Hi, Steve

Only apply this new patch, the kasan issue seems gone.

--

Thanks,
Zheng Yejian

> index 35783a7baf15..0827037ee3b8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4973,6 +4973,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
>   	return 0;
>   }
>   
> +/*
> + * The private pointer of the inode is the trace_event_file.
> + * Update the tr ref count associated to it.
> + */
> +int tracing_open_file_tr(struct inode *inode, struct file *filp)
> +{
> +	struct trace_event_file *file = inode->i_private;
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(file->tr);
> +	if (ret)
> +		return ret;
> +
> +	filp->private_data = inode->i_private;
> +
> +	return 0;
> +}
> +
> +int tracing_release_file_tr(struct inode *inode, struct file *filp)
> +{
> +	struct trace_event_file *file = inode->i_private;
> +
> +	trace_array_put(file->tr);
> +
> +	return 0;
> +}
> +
>   static int tracing_mark_open(struct inode *inode, struct file *filp)
>   {
>   	stream_open(inode, filp);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5669dd1f90d9..77debe53f07c 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -610,6 +610,8 @@ void tracing_reset_all_online_cpus(void);
>   void tracing_reset_all_online_cpus_unlocked(void);
>   int tracing_open_generic(struct inode *inode, struct file *filp);
>   int tracing_open_generic_tr(struct inode *inode, struct file *filp);
> +int tracing_open_file_tr(struct inode *inode, struct file *filp);
> +int tracing_release_file_tr(struct inode *inode, struct file *filp);
>   bool tracing_is_disabled(void);
>   bool tracer_tracing_is_on(struct trace_array *tr);
>   void tracer_tracing_on(struct trace_array *tr);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index ed367d713be0..2af92177b765 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2103,9 +2103,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
>   };
>   
>   static const struct file_operations ftrace_enable_fops = {
> -	.open = tracing_open_generic,
> +	.open = tracing_open_file_tr,
>   	.read = event_enable_read,
>   	.write = event_enable_write,
> +	.release = tracing_release_file_tr,
>   	.llseek = default_llseek,
>   };
>   
> @@ -2122,9 +2123,10 @@ static const struct file_operations ftrace_event_id_fops = {
>   };
>   
>   static const struct file_operations ftrace_event_filter_fops = {
> -	.open = tracing_open_generic,
> +	.open = tracing_open_file_tr,
>   	.read = event_filter_read,
>   	.write = event_filter_write,
> +	.release = tracing_release_file_tr,
>   	.llseek = default_llseek,
>   };
>   

