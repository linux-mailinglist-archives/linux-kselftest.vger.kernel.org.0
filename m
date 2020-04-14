Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5041A70C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 04:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbgDNB76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 21:59:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22422 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgDNB75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 21:59:57 -0400
X-IronPort-AV: E=Sophos;i="5.72,381,1580745600"; 
   d="scan'208";a="88984692"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Apr 2020 09:59:53 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4E67649DF135;
        Tue, 14 Apr 2020 09:49:22 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Apr 2020 09:59:50 +0800
Message-ID: <5E951914.70104@cn.fujitsu.com>
Date:   Tue, 14 Apr 2020 09:59:48 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
References: <20200413071252.13720-1-yangx.jy@cn.fujitsu.com> <20200413110207.01a48591@gandalf.local.home>
In-Reply-To: <20200413110207.01a48591@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 4E67649DF135.AAE37
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/4/13 23:02, Steven Rostedt wrote:
> On Mon, 13 Apr 2020 15:12:52 +0800
> Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>
>> Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()
>> or snapshot_count_trigger()) when register_snapshot_trigger() has completed
>> registration but doesn't allocate spare buffer for 'snapshot' event trigger.
>> 'snapshot' operation always detects the lack of allocated buffer in the rare
>> case so make register_snapshot_trigger() allocate spare buffer first.
>>
>> trigger-snapshot.tc in kselftest reproduces the issue on slow vm:
>> -----------------------------------------------------------
>> cat trace
>> ...
>> ftracetest-3028  [002] ....   236.784290: sched_process_fork: comm=ftracetest pid=3028 child_comm=ftracetest child_pid=3036
>>       <...>-2875  [003] ....   240.460335: tracing_snapshot_instance_cond: *** SNAPSHOT NOT ALLOCATED ***
>>       <...>-2875  [003] ....   240.460338: tracing_snapshot_instance_cond: *** stopping trace here!   ***
>> -----------------------------------------------------------
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   kernel/trace/trace_events_trigger.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
>> index dd34a1b46a86..00e54cdcef3e 100644
>> --- a/kernel/trace/trace_events_trigger.c
>> +++ b/kernel/trace/trace_events_trigger.c
>> @@ -1088,9 +1088,13 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
>>   			  struct event_trigger_data *data,
>>   			  struct trace_event_file *file)
>>   {
>> -	int ret = register_trigger(glob, ops, data, file);
>> +	int alloc_ret, ret;
>>
>> -	if (ret>  0&&  tracing_alloc_snapshot_instance(file->tr) != 0) {
>> +	alloc_ret = tracing_alloc_snapshot_instance(file->tr);
>> +
>> +	ret = register_trigger(glob, ops, data, file);
>> +
>> +	if (ret>  0&&  alloc_ret != 0) {
>>   		unregister_trigger(glob, ops, data, file);
>>   		ret = 0;
>>   	}
>
>
> Why register if the allocation failed? Just switch the logic:
>
> 	int ret = tracing_alloc_snapshot_instance(file->tr);
>
> 	if (ret != 0)
> 		return 0;
>
> 	return register_trigger(glob, ops, data, file);
Hi Steve,

It looks simpler and better.
I think we can drop the unnecessary ret variable as well.

Thanks,
Xiao Yang
>
>
> -- Steve
>
>
> .
>



