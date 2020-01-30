Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05114D4C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2020 01:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgA3AoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 19:44:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48668 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3AoE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 19:44:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U0SbKm039876;
        Thu, 30 Jan 2020 00:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HxaL1diqaEv286OlhDwXeFz8SznwXgpMh0T9XvkcS/4=;
 b=LJ9NJDtZ0xIKPfo7TT45ZkKFwtd9FFccN180bLdE9yns4f+qBam/ogmCeWLDlc2ZNCAg
 I+FH9dVYVyMPmEjJyYU2ddfw6f4duwPwx7jCXuAMw49PxmA2JGAHhY+J6wfFjaA7rC0U
 DY1g+95BqBT5v8sSEvlm9s55Xe2OpckmxNgf+UDRxw9DGZC/CBpXQu/Jm/LchvMU/aOV
 jxoV82UQsrwH/kS3aw+K7BHRBy3utlkidz/84ERau0SgG7q+VrCvTzEVbwPHN2HxtklE
 6Zm2vdYAvRE7A2FV5xurm72isVkq0rcJ2EYPCZe5og/YSoQpt08U8mwyHjf9aqRw9SXQ Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xreargvmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 00:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U0Ta5l022634;
        Thu, 30 Jan 2020 00:41:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xuc2xu82x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 00:41:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00U0frUM019805;
        Thu, 30 Jan 2020 00:41:53 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 16:41:53 -0800
Subject: Re: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     shakeelb@google.com, shuah@kernel.org, gthelen@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-2-almasrymina@google.com>
 <alpine.DEB.2.21.2001291312490.175731@chino.kir.corp.google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <43930e45-7505-1fc2-36ac-69a91a00a336@oracle.com>
Date:   Wed, 29 Jan 2020 16:41:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001291312490.175731@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300001
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/29/20 1:21 PM, David Rientjes wrote:
> On Tue, 14 Jan 2020, Mina Almasry wrote:
> 
>> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
>> index 063962f6dfc6a..eab8a70d5bcb5 100644
>> --- a/include/linux/hugetlb_cgroup.h
>> +++ b/include/linux/hugetlb_cgroup.h
>> @@ -20,29 +20,37 @@
>>  struct hugetlb_cgroup;
>>  /*
>>   * Minimum page order trackable by hugetlb cgroup.
>> - * At least 3 pages are necessary for all the tracking information.
>> + * At least 4 pages are necessary for all the tracking information.
>>   */
>>  #define HUGETLB_CGROUP_MIN_ORDER	2
> 
> I always struggle with a way to document and protect these types of 
> usages.  In this case, we are using the private filed of tail pages; in 
> thp code, we enumerate these usages separately in struct page: see "Tail 
> pages of compound page" comment in the union.  Using the private field is 
> fine to store a pointer to the hugetlb_cgroup, but I'm wondering if we can 
> document or protect against future patches not understanding this usage.  
> Otherwise it's implicit beyond this comment.
> 
> Maybe an expanded comment here is the only thing that is needed because 
> it's unique to struct hugetlb_cgroup that describes what struct page 
> represents for the second, third, and (now) fourth tail page.

I think that expanding the comment may be sufficient.  Let's at least
document what the private field of the of the tail pages are used for
WRT cgroups.
Second tail page (hpage[2]) usage cgroup
Third tail page (hpage[3]) reservation cgroup

BTW, we are just adding usage of the third tail page IIUC.  The comment
that 4 pages are necessary includes the head page.
-- 
Mike Kravetz
