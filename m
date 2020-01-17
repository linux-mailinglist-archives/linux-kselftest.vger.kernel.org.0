Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711951413F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 23:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAQWQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 17:16:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQWQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 17:16:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HM8HXd150359;
        Fri, 17 Jan 2020 22:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HFFGUnfSqVWShYbKt3p582lD3bfMPINDrNFPG0jJqvE=;
 b=kW1I3h9CqDB0WI8iNf10+m0iPa1caxU1I2lL1DtfW2t6Uujt+6MaHhDAA108OOEPPtMf
 goLIn+mP/rVpqL+EO+HM0B7wM5FQpwXMNqCmaqcrB6Z600IT925wNPtfUgkBRPg35LZM
 Mo3dMDUo92fmDi4WY7wvg2kCn4OK3T3EzCi9VB+NxluNT0ym96Ld1u4W/C9uk8KvsMGr
 ALkR6o/MlhLR0mM5EhBRvTo5MSi/0IRdQQoo4d7fwn4ZOJsqxEcP9dswoYez6M29dLuT
 +cn9qJ0lC19z4UEYkqRZLSynbDNwNVrxZ4aMQ/66dfOuMU/4COFYdA4k5s46rgjTEbHD 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf74037wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 22:09:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HM8mVc008512;
        Fri, 17 Jan 2020 22:09:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xjxm9pau4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 22:09:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HM9iG3027286;
        Fri, 17 Jan 2020 22:09:44 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 14:09:44 -0800
Subject: Re: [PATCH v9 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-3-almasrymina@google.com>
 <dec1ccd5-5973-c498-f2fe-390c1c51b2d0@oracle.com>
 <CAHS8izMzXpNMCmFh_SD7n+4+rj3QTqyRfeWQyXAhFo1-qV4iEQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0ea993b0-af18-cee8-527e-f6df7e76b0be@oracle.com>
Date:   Fri, 17 Jan 2020 14:09:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izMzXpNMCmFh_SD7n+4+rj3QTqyRfeWQyXAhFo1-qV4iEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170170
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/14/20 2:52 PM, Mina Almasry wrote:
> On Mon, Jan 13, 2020 at 4:55 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>> +#ifdef CONFIG_CGROUP_HUGETLB
>>> +     /*
>>> +      * Since we check for HPAGE_RESV_OWNER above, this must a private
>>> +      * mapping, and these values should be none-zero, and should point to
>>> +      * the hugetlb_cgroup counter to uncharge for this reservation.
>>> +      */
>>> +     WARN_ON(!resv->reservation_counter);
>>> +     WARN_ON(!resv->pages_per_hpage);
>>> +     WARN_ON(!resv->css);
>>
>> I was once again wondering if these were always non-NULL for private mappings.
>> It seems that reservation_counter (h_gc) would be NULL in these cases from
>> these early checks in hugetlb_cgroup_charge_cgroup().
>>
> 
> You are right. I'm fixing in v10 the code and comments to account for
> h_cg potentially being NULL, but I'm having trouble testing. Looking
> at the code, I'm a bit confused by the checks. Seems to me
> hugetlb_cgroup_disabled() is the same as #ifdef CONFIG_CGROUP_HUGETLB;
> I can't find a way to enable the Kconfig but have that return false
> unless I hack the code.

What about the boot options?

cgroup_disable=
cgroup_no_v1=

-- 
Mike Kravetz
