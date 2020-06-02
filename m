Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17A1EB4D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFBFCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 01:02:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgFBFCC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 01:02:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0524XkCG114231;
        Tue, 2 Jun 2020 01:02:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm07mjrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 01:02:01 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0524u4xN006388;
        Tue, 2 Jun 2020 01:02:01 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm07mjqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 01:02:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0524xnkB030256;
        Tue, 2 Jun 2020 05:01:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31bf47w9wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 05:01:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05251uck8716598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 05:01:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADFB84C044;
        Tue,  2 Jun 2020 05:01:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A72BE4C05A;
        Tue,  2 Jun 2020 05:01:55 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.37.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Jun 2020 05:01:55 +0000 (GMT)
Subject: Re: [PATCH 0/4] selftests/livepatch: rework of
 test-klp-{callbacks,shadow_vars}
To:     Yannick Cote <ycote@redhat.com>, live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
References: <20200528134849.7890-1-ycote@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <5ca6dcae-c686-6f62-2927-afeba97fbe2a@linux.vnet.ibm.com>
Date:   Tue, 2 Jun 2020 10:31:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_04:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1011 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020025
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 7:18 PM, Yannick Cote wrote:
> The test-klp-callbacks change implement a synchronization replacement of
> initial code to use completion variables instead of delays. The
> completion variable interlocks the busy module with the concurrent
> loading of the target livepatch patches which works with the execution
> flow instead of estimated time delays.
> 
> The test-klp-shadow-vars changes first refactors the code to be more of
> a readable example as well as continuing to verify the component code.
> The patch is broken in two to display the renaming and restructuring in
> part 1 and the addition and change of logic in part 2. The last change
> frees memory before bailing in case of errors.
> 
> Patchset to be merged via the livepatching tree is against: livepatching/for-next
> 
> Joe Lawrence (1):
>   selftests/livepatch: rework test-klp-callbacks to use completion
>     variables
> 
> Yannick Cote (3):
>   selftests/livepatch: rework test-klp-shadow-vars
>   selftests/livepatch: more verification in test-klp-shadow-vars
>   selftests/livepatch: fix mem leaks in test-klp-shadow-vars
> 
>  lib/livepatch/test_klp_callbacks_busy.c       |  42 +++-
>  lib/livepatch/test_klp_shadow_vars.c          | 222 +++++++++---------
>  .../selftests/livepatch/test-callbacks.sh     |  29 ++-
>  .../selftests/livepatch/test-shadow-vars.sh   |  85 ++++---
>  4 files changed, 214 insertions(+), 164 deletions(-)
> 

Series looks good to me, with one minor typo in patch 3 (s/kpatch-patch//),
which Miroslav as already mentioned.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh
