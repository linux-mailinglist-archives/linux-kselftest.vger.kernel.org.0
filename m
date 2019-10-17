Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A402DA659
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405126AbfJQHZU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 03:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730715AbfJQHZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 03:25:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H7McnX092374
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 03:25:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vpjyf9sgy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 03:25:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Thu, 17 Oct 2019 08:25:15 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 08:25:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H7PALV46006782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 07:25:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE3AAE058;
        Thu, 17 Oct 2019 07:25:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F867AE05A;
        Thu, 17 Oct 2019 07:25:07 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.102.28.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Oct 2019 07:25:07 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] selftests/livepatch: Test interaction with
 ftrace_enabled
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-4-mbenes@suse.cz>
 <61b8e995-f5a2-8094-8e91-1a60019d2916@linux.vnet.ibm.com>
 <d4e9e2a0-51e7-e86e-9f6d-237a6c3b0204@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Thu, 17 Oct 2019 12:55:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d4e9e2a0-51e7-e86e-9f6d-237a6c3b0204@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101707-0016-0000-0000-000002B8D112
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101707-0017-0000-0000-00003319F7A1
Message-Id: <65e9f12d-4f93-ca49-1238-1894d63ab09a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170064
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 3:17 AM, Joe Lawrence wrote:
> On 10/16/19 1:06 PM, Kamalesh Babulal wrote:
>> On 10/16/19 5:03 PM, Miroslav Benes wrote:
>>> From: Joe Lawrence <joe.lawrence@redhat.com>
>>>
>>> Since livepatching depends upon ftrace handlers to implement "patched"
>>> code functionality, verify that the ftrace_enabled sysctl value
>>> interacts with livepatch registration as expected.  At the same time,
>>> ensure that ftrace_enabled is set and part of the test environment
>>> configuration that is saved and restored when running the selftests.
>>>
>>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>>
>> [...]
>>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
>>> new file mode 100755
>>> index 000000000000..e2a76887f40a
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
>>
>> This test fails due to wrong file permissions, with the warning:
>>
>> # Warning: file test-ftrace.sh is not executable, correct this.
>> not ok 4 selftests: livepatch: test-ftrace.sh
>>
> 
> Hi Kamalesh,
> 
> Thanks for testing.  This error is weird as the git log says new file mode: 100755.  'git am' of Miroslav's patchset gives me a new test-ftrace.sh with "Access: (0775/-rwxrwxr-x)"  Did you apply the mbox directly or.. ?
> 

Hi Joe,

Thanks, I was using patch command to apply the patches and using git am
helped. Sorry for the noise. The test cases passes now, without the issue
I previously reported:

[...]
# TEST: livepatch interaction with ftrace_enabled sysctl ... ok
ok 4 selftests: livepatch: test-ftrace.sh

Long story is that the patch command version installed on the test machine
doesn't understand new file mode permission from the git diff, updating
the patch version creates the patch with 755 mode.

-- 
Kamalesh

