Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A6F4B98
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfKHMcC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 07:32:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbfKHMcC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 07:32:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8CSsI2075440
        for <linux-kselftest@vger.kernel.org>; Fri, 8 Nov 2019 07:32:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w56r5c346-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2019 07:32:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 8 Nov 2019 12:31:59 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 12:31:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8CVJRK25100752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 12:31:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C454C044;
        Fri,  8 Nov 2019 12:31:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98FE44C050;
        Fri,  8 Nov 2019 12:31:54 +0000 (GMT)
Received: from dyn-9-152-98-242.boeblingen.de.ibm.com (unknown [9.152.98.242])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 12:31:54 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH RESEND v3 0/2] selftests: fix prepending $(OUTPUT) to
 $(TEST_PROGS)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <623856be-1bd3-54b9-6336-fd8daec2dfe2@kernel.org>
Date:   Fri, 8 Nov 2019 13:31:54 +0100
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 7bit
References: <20191024121347.22189-1-iii@linux.ibm.com>
 <623856be-1bd3-54b9-6336-fd8daec2dfe2@kernel.org>
To:     shuah <shuah@kernel.org>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19110812-0012-0000-0000-00000361E180
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110812-0013-0000-0000-0000219D4610
Message-Id: <EF7A3DF5-D73D-4AD2-A836-CA48B3C03401@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080124
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Am 07.11.2019 um 23:52 schrieb shuah <shuah@kernel.org>:
> 
> On 10/24/19 6:13 AM, Ilya Leoshkevich wrote:
>> Hello,
>> Is there anything blocking this from getting merged?
> 
> Please see below:
> 
>> This patch series fixes the following problem:
>> linux# make kselftest TARGETS=bpf O=/mnt/linux-build
>> # selftests: bpf: test_libbpf.sh
>> # ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
>> # test_libbpf: failed at file test_l4lb.o
>> # selftests: test_libbpf [FAILED]
>> Patch 1 appends / to $(OUTPUT) in order to make it more uniform with the
>> rest of the tree.
> 
> It isn't clear what this fixes. In addition, this patch appends an extra
> "/"
> 
> Excerpts from make kselftest-all with this patch applied:
> 
> linux_5.4/tools/testing/selftests/bpf//test_tcpnotify_user
> 
> I am not seeing any reason to take this patch.

The goal of patch 1 was not to fix a practical problem, but rather make
kselftest code follow the same convention as the rest of the build code
in tools/, namely: that $(OUTPUT) is assumed to always end with /.
However, if this commonality is not valuable, I don't think I should
pursue this. So I'd like to withdraw patch 1.

>> Patch 2 fixes the problem by prepending $(OUTPUT) to all members of
>> $(TEST_PROGS).
>> v1->v2:
>> - Append / to $(OUTPUT).
>> - Use $(addprefix) instead of $(foreach).
> 
> I can't reproduce this problem - I ran
> 
> make kselftest O=/tmp/linux-build

May I ask you, how did you check the test results? I'm asking because
some test failures, including this one, may not affect make exit code.
So you need to grep for e.g. test_libbpf.sh in make output to see the
problem. For example, in my setup a lot of eBPF tests fail without this
patch, and yet:

[root@bpf linux]# make kselftest TARGETS=bpf O=/mnt/linux-build
<snip>
ok 28 selftests: bpf: test_kmod.sh
# selftests: bpf: test_libbpf.sh
# ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
# test_libbpf: failed at file test_l4lb.o
# selftests: test_libbpf [FAILED]
not ok 29 selftests: bpf: test_libbpf.sh # exit=127
<snip>
make[1]: Leaving directory '/mnt/linux-build'

[root@bpf linux]# echo $?
0

> This might be fixing the problem in bpf case. However, I don't think
> this is the right fix.

It is weird in general that the existing code prepends $(OUTPUT) only to
the first test prog. The first test prog is by no means special. The
commit message of patch 2 explains in more detail how this discrepancy
causes a practical problem:

> The current logic prepends $(OUTPUT) only to the first member of
> $(TEST_PROGS). After that, run_one() does
>
>   cd `dirname $TEST`
>
> For all tests except the first one, `dirname $TEST` is ., which means
> they cannot access the files generated in $(OUTPUT).

Is there a problem with this reasoning?

> I would like to see this problem reproduced on another test first.

Best regards,
Ilya

