Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9D155D97
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBGSQ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 13:16:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbgBGSQ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 13:16:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017ID7Zh050227;
        Fri, 7 Feb 2020 18:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0uBr6XR4Zt4xjOg6S4oT3byCfbBlkldYwrJH52Ta7Js=;
 b=gvq3fnqtPy4SDQK/z/Li3x6am80Pjk6AWjfElg0ENzzjRZwvMt5UZLeeJf9+aI+wgQ9H
 n+lJUUsk+l0Gf/PyBbK0bkuH2BLIxVEF2G+XMS4sm6tpyhFsdPlNPbj0hcNBl4cggSNW
 oMMP9dXjJGxTfVGGXDygPOvGJGNxT7Ym/oObUcfN1uziFiXqwxIKeNtzPeA4MvQ2phTX
 LQiGonZVOVcKLzX5JcIgzulR+NpcciwZ9IgYb14DsbZcloD3tGvcJ5AT2bkuRKyOtXug
 pdidOABPrktDUZtHi6IjuLTRXrMkCyaJImLD34Fxt/tXod6qPw/kpSnW9jN79xXs/qOD 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbphkfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 18:16:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017IENVq118728;
        Fri, 7 Feb 2020 18:16:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y16pr7rkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 18:16:46 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017IGib9001800;
        Fri, 7 Feb 2020 18:16:44 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 10:16:44 -0800
Subject: Re: [PATCH v11 6/9] hugetlb_cgroup: support noreserve mappings
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-6-almasrymina@google.com>
 <6cc406e7-757f-4922-ffc0-681df3ee0d18@oracle.com>
Message-ID: <ac89801a-1285-78df-9baf-3404054b89cb@oracle.com>
Date:   Fri, 7 Feb 2020 10:16:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6cc406e7-757f-4922-ffc0-681df3ee0d18@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070136
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/6/20 2:31 PM, Mike Kravetz wrote:
> On 2/3/20 3:22 PM, Mina Almasry wrote:
>> Support MAP_NORESERVE accounting as part of the new counter.
>>
>> For each hugepage allocation, at allocation time we check if there is
>> a reservation for this allocation or not. If there is a reservation for
>> this allocation, then this allocation was charged at reservation time,
>> and we don't re-account it. If there is no reserevation for this
>> allocation, we charge the appropriate hugetlb_cgroup.
>>
>> The hugetlb_cgroup to uncharge for this allocation is stored in
>> page[3].private. We use new APIs added in an earlier patch to set this
>> pointer.
> 
> Ah!  That reminded me to look at the migration code.  Turns out that none
> of the existing cgroup information (page[2]) is being migrated today.  That
> is a bug. :(  I'll confirm and fix in a patch separate from this series.
> We will need to make sure that new information added by this series in page[3]
> is also migrated.  That would be in an earlier patch where the use of the
> field is introduced.

My appologies!

cgroup information is migrated and you took care of it for new reservation
information in patch 2.  Please disregard that statement.

-- 
Mike Kravetz
