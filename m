Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586581411A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 20:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgAQT0h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 14:26:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQT0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 14:26:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HJITLg023212;
        Fri, 17 Jan 2020 19:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=gqxK7vkCcTECVPU7G7R4kJNNecY+690ASWDWrqyibTI=;
 b=gyhaiCtu3LD4E7u6eKLrXfbj7HV8FgjP7U5WQ1j1GRZ4ss6t53H6/PHle2lZCwM29/IC
 q5Ld+v46vPot2bGzRygxoAhYGU0mBOG4ny4lwtJIVsUkqqYSqBulidxS7cmu3rvGYqrX
 +iPv00AuJ1363TlGADLBJKEIppB1not73t7IiSOWLSMaJH4hPEc703D8IDt0dHKaiKTV
 ubuAEkU/qIDLWLzRAIKLeZeFZ36bXdc38FqNFkQPBeJCYtAted+v7P86SYQPP/EoQJWG
 RJEGpPbFdSCY6drv/8PAJuTX1JsINNRVqY6eN45zIYycfs0sSBaPbth+SO5lhg9N7rXa 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf7402ktr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 19:26:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HJJieb128223;
        Fri, 17 Jan 2020 19:26:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xjxp5pdpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 19:26:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HJQR7J016478;
        Fri, 17 Jan 2020 19:26:28 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 11:26:27 -0800
Subject: Re: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>, rientjes@google.com,
        shakeelb@google.com
Cc:     shuah@kernel.org, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7e1d2c5f-3b07-4d16-9e1b-bd89d25e7fb3@oracle.com>
Date:   Fri, 17 Jan 2020 11:26:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115012651.228058-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170148
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/14/20 5:26 PM, Mina Almasry wrote:
> Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> usage or hugetlb reservation counter.
> 
> Adds a new interface to uncharge a hugetlb_cgroup counter via
> hugetlb_cgroup_uncharge_counter.
> 
> Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in v10:
> - Added missing VM_BUG_ON

Thanks for addressing my comments.
I see that patch 8 was updated to address David's comments.  I will also
review patch 8 later.

I am again requesting that someone with more cgroup experience comment on
this patch.  I do not have enough experience to determine if the code to
not reparent/zombie cgroup is correct.

For now,
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
while waiting for cgroup comments.

-- 
Mike Kravetz
