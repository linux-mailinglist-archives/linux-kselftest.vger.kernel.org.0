Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05938D9833
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfJPRGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 13:06:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388161AbfJPRGs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 13:06:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GGw29u085655
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:06:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vp76nr9wr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:06:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Wed, 16 Oct 2019 18:06:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 18:06:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9GH6Yan44236942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 17:06:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70B2BAE051;
        Wed, 16 Oct 2019 17:06:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CCBAE057;
        Wed, 16 Oct 2019 17:06:31 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.32.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Oct 2019 17:06:31 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] selftests/livepatch: Test interaction with
 ftrace_enabled
To:     Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-4-mbenes@suse.cz>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Wed, 16 Oct 2019 22:36:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016113316.13415-4-mbenes@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101617-0012-0000-0000-00000358A60E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101617-0013-0000-0000-00002193C080
Message-Id: <61b8e995-f5a2-8094-8e91-1a60019d2916@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160142
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 5:03 PM, Miroslav Benes wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Since livepatching depends upon ftrace handlers to implement "patched"
> code functionality, verify that the ftrace_enabled sysctl value
> interacts with livepatch registration as expected.  At the same time,
> ensure that ftrace_enabled is set and part of the test environment
> configuration that is saved and restored when running the selftests.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

[...]
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> new file mode 100755
> index 000000000000..e2a76887f40a
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh

This test fails due to wrong file permissions, with the warning:

# Warning: file test-ftrace.sh is not executable, correct this.
not ok 4 selftests: livepatch: test-ftrace.sh

-- 
Kamalesh

