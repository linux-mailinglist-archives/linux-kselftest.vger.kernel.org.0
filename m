Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE33D9D95
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 23:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfJPVjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 17:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfJPVjU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 17:39:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73B2B3078475;
        Wed, 16 Oct 2019 21:39:20 +0000 (UTC)
Received: from [10.10.121.199] (ovpn-121-199.rdu2.redhat.com [10.10.121.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3628E600C4;
        Wed, 16 Oct 2019 21:39:18 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] selftests/livepatch: Make dynamic debug setup and
 restore generic
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, rostedt@goodmis.org,
        mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-3-mbenes@suse.cz>
 <f50cf434-6dd2-51eb-a688-0da79d7ab8bc@linux.vnet.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <5def9a66-1029-e963-b44d-020791763f16@redhat.com>
Date:   Wed, 16 Oct 2019 17:39:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f50cf434-6dd2-51eb-a688-0da79d7ab8bc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 16 Oct 2019 21:39:20 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 1:10 PM, Kamalesh Babulal wrote:
> On 10/16/19 5:03 PM, Miroslav Benes wrote:
>> From: Joe Lawrence <joe.lawrence@redhat.com>
>>
>> Livepatch selftests currently save the current dynamic debug config and
>> tweak it for the selftests. The config is restored at the end. Make the
>> infrastructure generic, so that more variables can be saved and
>> restored.
>>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>> ---
>>   .../testing/selftests/livepatch/functions.sh  | 22 +++++++++++--------
>>   .../selftests/livepatch/test-callbacks.sh     |  2 +-
>>   .../selftests/livepatch/test-livepatch.sh     |  2 +-
>>   .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
> 
> A minor nit pick, should the README also updated with the setup_config()?
> 

Yup, good eye.  I think it should be a simple matter of 
s/set_dynamic_debug/setup_config/g

-- Joe
