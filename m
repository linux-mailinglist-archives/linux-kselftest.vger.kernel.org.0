Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD619169F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 17:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXQkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 12:40:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXQkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 12:40:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGdEdY166419;
        Tue, 24 Mar 2020 16:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Z05suOHf2IDzsq2FPAO2+DX7KrqPxW6csjVKUUkFIXw=;
 b=gg6emeKgunC7p7RGjiJUerU/Uwo15KfvFn7XDFj7zqxWTZtUfQ2n9Yje4bU4h1+j+76q
 PGp3iuGJgG5dzy/WLXkJuNPFHDpLpLLVewOFZN9o6/JetCpGQg/6ikDOHd8VyjqYQ9rA
 0X2qlZf7dOsrQBitgGr2hpQCI4ql2BtpRwztJcKA4L9qX0nOiy0I4B0fD6Ls/SNzSXQl
 Tnmwpywnw7kGUYUrkXPm+1/46hwiepQECpIY6b3SXoJs+yuqb1Yt3vS1OZWhVHYImhYt
 HcdpATyKFquNpnEwBl3dMk79FdK+ZOhxZ6wNh6rADwnYpYDdEPSOhMeALIaTBcRkSRnu KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ywabr5ef0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:40:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGKTKa091634;
        Tue, 24 Mar 2020 16:40:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yxw4pmjd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:40:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OGdwIG007862;
        Tue, 24 Mar 2020 16:39:58 GMT
Received: from dhcp-10-175-162-99.vpn.oracle.com (/10.175.162.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 09:39:57 -0700
Date:   Tue, 24 Mar 2020 16:39:50 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Patricia Alfonso <trishalfonso@google.com>
cc:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
In-Reply-To: <20200319164227.87419-2-trishalfonso@google.com>
Message-ID: <alpine.LRH.2.21.2003241635230.30637@localhost>
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240087
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Thu, 19 Mar 2020, Patricia Alfonso wrote:

> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
> 
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
>  include/linux/sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..1fbfa0634776 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1180,6 +1180,10 @@ struct task_struct {
>  	unsigned int			kasan_depth;
>  #endif
>  
> +#if IS_BUILTIN(CONFIG_KUNIT)

This patch set looks great! You might have noticed I
refreshed the kunit resources stuff to incorporate
feedback from Brendan, but I don't think any API changes
were made that should have consequences for your code
(I'm building with your patches on top to make sure).
I'd suggest promoting from RFC to v3 on the next round
unless anyone objects.

As Dmitry suggested, the above could likely be changed to be
"#ifdef CONFIG_KUNIT" as kunit can be built as a
module also. More on this in patch 2..

> +	struct kunit			*kunit_test;
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	/* Index of current stored address in ret_stack: */
>  	int				curr_ret_stack;
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
> 
