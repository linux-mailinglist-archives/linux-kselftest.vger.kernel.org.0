Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC616BE7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGQOpn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 10:45:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbfGQOpn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 10:45:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HEhZjl100439
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 10:45:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tt47ycrca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 10:45:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Wed, 17 Jul 2019 15:45:40 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 15:45:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6HEjM4q35389812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:45:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C8DA405F;
        Wed, 17 Jul 2019 14:45:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5F9A4059;
        Wed, 17 Jul 2019 14:45:34 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.115.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Jul 2019 14:45:34 +0000 (GMT)
Subject: Re: [PATCH v2] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
References: <20190716133414.20196-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Wed, 17 Jul 2019 20:15:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716133414.20196-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071714-0012-0000-0000-00000333C7A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071714-0013-0000-0000-0000216D4690
Message-Id: <eac825ab-04c2-77cf-671e-1a2a576109b0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170172
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/16/19 7:04 PM, Joe Lawrence wrote:
> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh

