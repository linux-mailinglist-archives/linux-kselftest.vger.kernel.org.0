Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2220D9DA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394553AbfJPVrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 17:47:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388409AbfJPVrP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 17:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DFE33082B40;
        Wed, 16 Oct 2019 21:47:15 +0000 (UTC)
Received: from [10.10.121.199] (ovpn-121-199.rdu2.redhat.com [10.10.121.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 061ED60BE1;
        Wed, 16 Oct 2019 21:47:12 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] selftests/livepatch: Test interaction with
 ftrace_enabled
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-4-mbenes@suse.cz>
 <61b8e995-f5a2-8094-8e91-1a60019d2916@linux.vnet.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <d4e9e2a0-51e7-e86e-9f6d-237a6c3b0204@redhat.com>
Date:   Wed, 16 Oct 2019 17:47:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <61b8e995-f5a2-8094-8e91-1a60019d2916@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 16 Oct 2019 21:47:15 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 1:06 PM, Kamalesh Babulal wrote:
> On 10/16/19 5:03 PM, Miroslav Benes wrote:
>> From: Joe Lawrence <joe.lawrence@redhat.com>
>>
>> Since livepatching depends upon ftrace handlers to implement "patched"
>> code functionality, verify that the ftrace_enabled sysctl value
>> interacts with livepatch registration as expected.  At the same time,
>> ensure that ftrace_enabled is set and part of the test environment
>> configuration that is saved and restored when running the selftests.
>>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> 
> [...]
>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
>> new file mode 100755
>> index 000000000000..e2a76887f40a
>> --- /dev/null
>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> 
> This test fails due to wrong file permissions, with the warning:
> 
> # Warning: file test-ftrace.sh is not executable, correct this.
> not ok 4 selftests: livepatch: test-ftrace.sh
> 

Hi Kamalesh,

Thanks for testing.  This error is weird as the git log says new file 
mode: 100755.  'git am' of Miroslav's patchset gives me a new 
test-ftrace.sh with "Access: (0775/-rwxrwxr-x)"  Did you apply the mbox 
directly or.. ?

-- Joe
