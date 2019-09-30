Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923EBC269E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2019 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfI3Ui1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Sep 2019 16:38:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfI3Ui1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Sep 2019 16:38:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UHWm3l083029
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:50:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbkj100vn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:50:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 30 Sep 2019 18:50:24 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 18:50:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UHnrlG36831614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 17:49:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 951914C044;
        Mon, 30 Sep 2019 17:50:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D444C04E;
        Mon, 30 Sep 2019 17:50:21 +0000 (GMT)
Received: from dyn-9-152-96-81.boeblingen.de.ibm.com (unknown [9.152.96.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 17:50:21 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <cb4e3c3c-3ab8-5d21-495f-5f751c79dde6@kernel.org>
Date:   Mon, 30 Sep 2019 19:50:21 +0200
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 7bit
References: <20190910121813.45742-1-iii@linux.ibm.com>
 <cb4e3c3c-3ab8-5d21-495f-5f751c79dde6@kernel.org>
To:     shuah <shuah@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19093017-4275-0000-0000-0000036CA069
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093017-4276-0000-0000-0000387F2860
Message-Id: <5CE66619-878B-4CC7-8477-32050A131FB4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Am 16.09.2019 um 18:18 schrieb shuah <shuah@kernel.org>:
> 
> On 9/10/19 6:18 AM, Ilya Leoshkevich wrote:
>> The current logic prepends $(OUTPUT) only to the first member of
>> $(TEST_PROGS). Use $(addprefix) to prepend it to each member.
> 
> Can you please send me the error messages you are seeing so I can see
> what is being fixed.

linux# make kselftest TARGETS=bpf O=/mnt/linux-build

Without the patch:
# selftests: bpf: test_libbpf.sh
# ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
# test_libbpf: failed at file test_l4lb.o
# selftests: test_libbpf [FAILED]

With the patch:
# selftests: bpf: test_libbpf.sh
# selftests: test_libbpf [PASS]

What happens is that run_one() does

    cd `dirname $TEST`

dirname is . without the patch, so the test cannot access the files
generated in $(OUTPUT).

> 
>> Also, $(OUTPUT) is assumed to end with a / almost everywhere else in
>> the kernel, make this the case for kselftest as well.
> 
> Why are these two changes in one patch? Does this fix 1a940687e424?
> If so how?

I will split the patch in two and resend. Adding / does not fix
anything, it just makes the code more uniform w.r.t. the rest of the
tree.

