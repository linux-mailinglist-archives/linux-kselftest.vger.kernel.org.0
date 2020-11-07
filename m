Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D252AA474
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKGKpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Nov 2020 05:45:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKGKpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Nov 2020 05:45:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A7AWfRd075183;
        Sat, 7 Nov 2020 05:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ASSvCDmGzoqF2PFS56D4BqHaEHoPz8ILlYUcwC2XJ+I=;
 b=Oym/QW+Ay382l11ERN6PepGslFgxbFgwD6cMCAJ4UJSqmcyBKyoTvu183FNl4swvxiAC
 fBL8t9FBCjrpTVvU06ceFpSwqaZgg5ZbIgwq9dygF3K67QNcE3VNTDolQMb0Jl2Iw90x
 Dt1km7b6W2b3lAUHimSXnxRtpazqVU6L3gUTQhnotboGd4NMVb3XxqNrgwgspB0sckMp
 z9i3ikwtthVkP8MtJKEctRb/N0a0fngA8RW0fnj6jrF5Z5pdfQKeNfoaUmcySws5Jjef
 mHKyIQSCFqhJ5MAEPcD4B+WwgcHtBcPzzPWbti0+7kIqoGyNxkt+cTAebcslutmIqFHw iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34nrm71svv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Nov 2020 05:45:00 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A7Ah43r105309;
        Sat, 7 Nov 2020 05:45:00 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34nrm71sv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Nov 2020 05:44:59 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A7Ai5Gh006941;
        Sat, 7 Nov 2020 10:44:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 34nk78888b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Nov 2020 10:44:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A7Aitva7537382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 7 Nov 2020 10:44:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 672424C040;
        Sat,  7 Nov 2020 10:44:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF0F4C046;
        Sat,  7 Nov 2020 10:44:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.53.17])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  7 Nov 2020 10:44:54 +0000 (GMT)
Date:   Sat, 7 Nov 2020 12:44:52 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tool: selftests: fix spelling typo of 'writting'
Message-ID: <20201107104452.GF301789@linux.ibm.com>
References: <1604740776-27082-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604740776-27082-1-git-send-email-wangqing@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-07_04:2020-11-05,2020-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=100 mlxlogscore=-1000 adultscore=0
 spamscore=100 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011070067
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 07, 2020 at 05:19:35PM +0800, Wang Qing wrote:
> writting -> writing
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 9b0912a..9132fae7
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -894,7 +894,7 @@ static int faulting_process(int signal_test)
>  				count_verify[nr]);
>  	        }
>  		/*
> -		 * Trigger write protection if there is by writting
> +		 * Trigger write protection if there is by writing
>  		 * the same value back.
>  		 */
>  		*area_count(area_dst, nr) = count;
> @@ -922,7 +922,7 @@ static int faulting_process(int signal_test)
>  				count_verify[nr]); exit(1);
>  		}
>  		/*
> -		 * Trigger write protection if there is by writting
> +		 * Trigger write protection if there is by writing
>  		 * the same value back.
>  		 */
>  		*area_count(area_dst, nr) = count;
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
