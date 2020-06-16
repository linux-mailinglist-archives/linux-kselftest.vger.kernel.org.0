Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCA1FAB31
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFPI3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 04:29:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44510 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgFPI3e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 04:29:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G81aLg124781;
        Tue, 16 Jun 2020 04:29:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31phf5dthp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 04:29:28 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05G82Do9127769;
        Tue, 16 Jun 2020 04:29:28 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31phf5dth1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 04:29:28 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G8LB3J011391;
        Tue, 16 Jun 2020 08:29:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 31mpe820k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 08:29:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05G8TNVP43122836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 08:29:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0245A4057;
        Tue, 16 Jun 2020 08:29:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6729A4040;
        Tue, 16 Jun 2020 08:29:21 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.112.16])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jun 2020 08:29:21 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] selftests/livepatch: small script cleanups
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <9502b7e6-bf62-678c-aa10-6be01d769c6f@linux.vnet.ibm.com>
Date:   Tue, 16 Jun 2020 13:59:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_02:2020-06-15,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160053
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/15/20 10:57 PM, Joe Lawrence wrote:
> This is a small collection of tweaks for the shellscript side of the
> livepatch tests.  If anyone else has a small cleanup (or even just a
> suggestion for a low-hanging change) and would like to tack it onto the
> set, let me know.
> 
> based-on: livepatching.git, for-5.9/selftests-cleanup
> merge-thru: livepatching.git
> 
> v2:
> - use consistent start_test messages from the original echoes [mbenes]
> - move start_test invocations to just after their descriptions [mbenes]
> - clean up $SAVED_DMSG on trap EXIT [pmladek]
> - grep longer kernel taint line, avoid word-matching [mbenes, pmladek]
> - add "===== TEST: $test =====" delimiter patch [pmladek]
> 
> Joe Lawrence (4):
>   selftests/livepatch: Don't clear dmesg when running tests
>   selftests/livepatch: use $(dmesg --notime) instead of manually
>     filtering
>   selftests/livepatch: refine dmesg 'taints' in dmesg comparison
>   selftests/livepatch: add test delimiter to dmesg
> 
>  tools/testing/selftests/livepatch/README      | 16 +++---
>  .../testing/selftests/livepatch/functions.sh  | 32 ++++++++++-
>  .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
>  .../selftests/livepatch/test-ftrace.sh        |  4 +-
>  .../selftests/livepatch/test-livepatch.sh     | 12 +---
>  .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
>  .../testing/selftests/livepatch/test-state.sh | 21 +++----
>  7 files changed, 63 insertions(+), 81 deletions(-)
> 

For the series:

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh
