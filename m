Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2603683AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2019 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfGOGuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 02:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbfGOGuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 02:50:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6F6ks3A027948
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 02:50:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trhmhwwax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 02:50:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Mon, 15 Jul 2019 07:50:43 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 07:50:40 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6F6odX340829378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 06:50:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54B09A4055;
        Mon, 15 Jul 2019 06:50:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E632A4053;
        Mon, 15 Jul 2019 06:50:38 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.124.35.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 06:50:38 +0000 (GMT)
Subject: Re: [PATCH] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
References: <20190714142829.29458-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Mon, 15 Jul 2019 12:20:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190714142829.29458-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071506-0012-0000-0000-00000332A910
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071506-0013-0000-0000-0000216C1DAA
Message-Id: <9de46fed-785c-d5c4-8a76-205674bd0912@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150079
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/19 7:58 PM, Joe Lawrence wrote:
> Before running a livpeatch self-test, first verify that we've built and
> installed the livepatch self-test kernel modules by running a 'modprobe
> --dry-run'.  This should catch a few environment issues, including
> !CONFIG_LIVEPATCH and !CONFIG_TEST_LIVEPATCH.  In these cases, exit
> gracefully with test-skip status rather than test-fail status.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

[...]
> 
> +function assert_mod() {
> +	local mod="$1"
> +
> +	if ! modprobe --dry-run "$mod" &>/dev/null ; then

Just a preference comment, shorter version 'modprobe -q -n'
can be used here.

Thanks,
Kamalesh



