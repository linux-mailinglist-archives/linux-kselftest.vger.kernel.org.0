Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337E814643B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 10:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAWJPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 04:15:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgAWJPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 04:15:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9CkBs104384
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 04:15:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp93qn587-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 04:15:45 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 23 Jan 2020 09:15:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Jan 2020 09:15:38 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00N9FbuE41353368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 09:15:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 831D14C040;
        Thu, 23 Jan 2020 09:15:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90CD54C04A;
        Thu, 23 Jan 2020 09:15:35 +0000 (GMT)
Received: from [9.124.35.38] (unknown [9.124.35.38])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jan 2020 09:15:35 +0000 (GMT)
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 tests
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, rientjes@google.com, shakeelb@google.com,
        shuah@kernel.org, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Thu, 23 Jan 2020 14:45:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115012651.228058-7-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012309-0020-0000-0000-000003A33EF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012309-0021-0000-0000-000021FAD787
Message-Id: <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_01:2020-01-23,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=996 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230079
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 15/01/20 6:56 am, Mina Almasry wrote:
> The tests use both shared and private mapped hugetlb memory, and
> monitors the hugetlb usage counter as well as the hugetlb reservation
> counter. They test different configurations such as hugetlb memory usage
> via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
> MAP_POPULATE.
> 
> Also add test for hugetlb reservation reparenting, since this is
> a subtle issue.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
system with Hash MMU and ran into problems because the tests assume that the
hugepage size is always 2MB. Can you determine the huge page size at runtime?


- Sandipan

