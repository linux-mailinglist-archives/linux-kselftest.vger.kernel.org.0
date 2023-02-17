Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2E569AFA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBQPkb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 10:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQPka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 10:40:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3604CCBA;
        Fri, 17 Feb 2023 07:40:29 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HDD1ao020134;
        Fri, 17 Feb 2023 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AdQm94RM/cpywaxf/j+ZLQZDUY5Ox4sTXDPhYLWj9Vo=;
 b=evfRo47qMYvj7IhxDPZ+Rsa0eR21Ki2mRVcEl22P/qdD61bWk/mzU6wmbuNpCu60jMKE
 sInpX7558TKFeL3CPfqEoEQ+pj/cr55v7Nxs90B9M/ba798BfHLq5i4fVKk3r37+LAnA
 1VDxb4YJBk6mPqHH4rH94pmnhRxD4+3w8EovZarHVxnwWGjABLAK4C3CfeaTMJb+1w/K
 BqpGCJyVb1vbtfyNPu8aY0adEmJNhXWM8C4KCPYI8HIK9fvR43NIKX2/dXQPyeBxXBTB
 qdYb43xEe85zd1zoZITR+xTPNRn5mdQd2ugVcevaO4DAwHDmIljtQmMrpc9A+SIRv3JF 4w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt91u0gww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:40:20 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HFeJXp012769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:40:19 GMT
Received: from [10.216.18.25] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 07:40:15 -0800
Message-ID: <07b22590-b51d-1871-2f2d-d031085ad8c3@quicinc.com>
Date:   Fri, 17 Feb 2023 21:10:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/6] selftests: use canonical ftrace path
Content-Language: en-US
To:     Ross Zwisler <zwisler@chromium.org>, <linux-kernel@vger.kernel.org>
CC:     Ross Zwisler <zwisler@google.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-3-zwisler@google.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230215223350.2658616-3-zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TgIku-QCwOHMRpF0og7UFrKovvAdaGhs
X-Proofpoint-GUID: TgIku-QCwOHMRpF0og7UFrKovvAdaGhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=738 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170140
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/16/2023 4:03 AM, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>    Before 4.1, all ftrace tracing control files were within the debugfs
>    file system, which is typically located at /sys/kernel/debug/tracing.
>    For backward compatibility, when mounting the debugfs file system,
>    the tracefs file system will be automatically mounted at:
> 
>    /sys/kernel/debug/tracing
> 
> A few spots in tools/testing/selftests still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>   tools/testing/selftests/user_events/dyn_test.c    |  2 +-
>   tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
>   tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
>   tools/testing/selftests/vm/protection_keys.c      |  4 ++--
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> index d6265d14cd51..8879a7b04c6a 100644
> --- a/tools/testing/selftests/user_events/dyn_test.c
> +++ b/tools/testing/selftests/user_events/dyn_test.c
> @@ -16,7 +16,7 @@
>   
>   #include "../kselftest_harness.h"
>   
> -const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
> +const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
>   const char *clear = "!u:__test_event";
>   
>   static int Append(const char *value)
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index 404a2713dcae..a0b2c96eb252 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -16,11 +16,11 @@
>   
>   #include "../kselftest_harness.h"
>   
> -const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> -const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> -const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
> -const char *trace_file = "/sys/kernel/debug/tracing/trace";
> -const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
> +const char *data_file = "/sys/kernel/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/tracing/user_events_status";
> +const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
> +const char *trace_file = "/sys/kernel/tracing/trace";
> +const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
>   
>   static inline int status_check(char *status_page, int status_bit)
>   {
> diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
> index 8b4c7879d5a7..31505642aa9b 100644
> --- a/tools/testing/selftests/user_events/perf_test.c
> +++ b/tools/testing/selftests/user_events/perf_test.c
> @@ -18,10 +18,10 @@
>   
>   #include "../kselftest_harness.h"
>   
> -const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> -const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> -const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
> -const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
> +const char *data_file = "/sys/kernel/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/tracing/user_events_status";
> +const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
> +const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
>   
>   struct event {
>   	__u32 index;
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 95f403a0c46d..0381c34fdd56 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -98,7 +98,7 @@ int tracing_root_ok(void)
>   void tracing_on(void)
>   {
>   #if CONTROL_TRACING > 0
> -#define TRACEDIR "/sys/kernel/debug/tracing"
> +#define TRACEDIR "/sys/kernel/tracing"
>   	char pidstr[32];
>   
>   	if (!tracing_root_ok())
> @@ -124,7 +124,7 @@ void tracing_off(void)
>   #if CONTROL_TRACING > 0
>   	if (!tracing_root_ok())
>   		return;
> -	cat_into_file("0", "/sys/kernel/debug/tracing/tracing_on");
> +	cat_into_file("0", "/sys/kernel/tracing/tracing_on");
>   #endif
>   }
>   


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
