Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D2770D3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHEB6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHEB6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 21:58:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461510D4;
        Fri,  4 Aug 2023 18:58:16 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHlz35dSxz1Z1VS;
        Sat,  5 Aug 2023 09:55:27 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 09:58:12 +0800
Message-ID: <77897888-bd4a-8fb7-36d0-2722402d5095@huawei.com>
Date:   Sat, 5 Aug 2023 09:58:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] tracing: Fix cpu buffers unavailable due to
 'record_disabled' messed
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
CC:     <mhiramat@kernel.org>, <vnagarnaik@google.com>, <shuah@kernel.org>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20230804124549.2562977-2-zhengyejian1@huawei.com>
 <202308050048.bUnVeBjV-lkp@intel.com>
 <20230804125107.41d6cdb1@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230804125107.41d6cdb1@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/5 00:51, Steven Rostedt wrote:
> On Sat, 5 Aug 2023 00:41:13 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>>    5276			if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
>>    5277					!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
>>    5278				atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
>>    5279				ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
>>> 5280				ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
> 
> The access to max_buffer requires a:
> 
> #ifdef CONFIG_TRACER_MAX_TRACE
> 
> Around them.
> 
> -- Steve

Thanks, Steve, I'll add it in v2.

-- Zheng Yejian

> 
>>    5281			}
>>    5282			if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
>>    5283					cpumask_test_cpu(cpu, tracing_cpumask_new)) {
>>    5284				atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
>>    5285				ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
>>    5286				ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
>>    5287			}
>>    5288		}
>>    5289		arch_spin_unlock(&tr->max_lock);
> 

