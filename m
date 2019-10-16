Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB38D984F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406578AbfJPRKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 13:10:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406544AbfJPRKh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 13:10:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GH88Ca109269
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:10:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vp75wrg0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:10:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Wed, 16 Oct 2019 18:10:33 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 18:10:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9GHAS2N39453030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 17:10:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC9D6AE045;
        Wed, 16 Oct 2019 17:10:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8FA2AE053;
        Wed, 16 Oct 2019 17:10:26 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.32.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Oct 2019 17:10:26 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] selftests/livepatch: Make dynamic debug setup and
 restore generic
To:     Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-3-mbenes@suse.cz>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Wed, 16 Oct 2019 22:40:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016113316.13415-3-mbenes@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101617-0016-0000-0000-000002B8A3F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101617-0017-0000-0000-00003319C83C
Message-Id: <f50cf434-6dd2-51eb-a688-0da79d7ab8bc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160143
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 5:03 PM, Miroslav Benes wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Livepatch selftests currently save the current dynamic debug config and
> tweak it for the selftests. The config is restored at the end. Make the
> infrastructure generic, so that more variables can be saved and
> restored.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  .../testing/selftests/livepatch/functions.sh  | 22 +++++++++++--------
>  .../selftests/livepatch/test-callbacks.sh     |  2 +-
>  .../selftests/livepatch/test-livepatch.sh     |  2 +-
>  .../selftests/livepatch/test-shadow-vars.sh   |  2 +-

A minor nit pick, should the README also updated with the setup_config()?

-- 
Kamalesh

