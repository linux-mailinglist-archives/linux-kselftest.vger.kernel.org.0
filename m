Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896AD1F687E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgFKNCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 09:02:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgFKNCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 09:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591880521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cRAprkT7S89tlGY48hka4FQEbiwNER+FmCFXXMuntE=;
        b=N59RA121/ZTX6Jgp/zVUewIzhp32pjdk6YMzWOhPst455KgGTszN/N36ga2/nlj4e67/ru
        DhTgVnbIq4lT5fPdO3Q2Kaf2uI9Ofa9Ngt1bvRrPc8EYNWChyQoMOPlnkTNmcluf8LqZjl
        z2KGqn3HYGgfx/AsJ2bmvLbDPM5tdtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-EEow7cx4PVapwtrteqGONw-1; Thu, 11 Jun 2020 09:01:50 -0400
X-MC-Unique: EEow7cx4PVapwtrteqGONw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A8D7EC1AF;
        Thu, 11 Jun 2020 13:01:49 +0000 (UTC)
Received: from [10.10.117.142] (ovpn-117-142.rdu2.redhat.com [10.10.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77F2C5C3F8;
        Thu, 11 Jun 2020 13:01:48 +0000 (UTC)
Subject: Re: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running
 tests
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-2-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110930590.32091@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <f08eb372-0282-7d07-180f-ff0d7220708b@redhat.com>
Date:   Thu, 11 Jun 2020 09:01:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2006110930590.32091@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/20 3:38 AM, Miroslav Benes wrote:
> Hi,
> 
> On Wed, 10 Jun 2020, Joe Lawrence wrote:
> 
>> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
>> index 32b57ba07f4f..c3d949da5bb7 100755
>> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
>> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
>> @@ -12,7 +12,7 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
>>   setup_config
>>   
>>   
>> -# TEST: target module before livepatch
>> +start_test "target module before livepatch"
>>   #
>>   # Test a combination of loading a kernel module and a livepatch that
>>   # patches a function in the first module.  Load the target module
>> @@ -28,9 +28,6 @@ setup_config
>>   #   unpatching transition starts.  klp_objects are reverted, post-patch
>>   #   callbacks execute and the transition completes.
>>   
>> -echo -n "TEST: target module before livepatch ... "
>> -dmesg -C
>> -
> 
> A nit, but I think it would be better to place start_test here below the
> comment. The same for other occurrences in test-callbacks.sh.
> 

The idea was to remove the duplicate # TEST: comment and then the same 
echo -n "TEST: ..." entries.

Would it still look okay if we move start_test to below the comment and 
omit that # TEST ... part?  (This might be what you're suggesting, but I 
wanted to make sure.)

> [...]
> 
>> diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
>> index a08212708115..bf8db1613961 100755
>> --- a/tools/testing/selftests/livepatch/test-state.sh
>> +++ b/tools/testing/selftests/livepatch/test-state.sh
>> @@ -10,10 +10,7 @@ MOD_LIVEPATCH3=test_klp_state3
>>   
>>   setup_config
>>   
>> -# TEST: Loading and removing a module that modifies the system state
>> -
>> -echo -n "TEST: system state modification ... "
>> -dmesg -C
>> +start_test "Loading and removing a module that modifies the system state"
> 
> start_test should get the message from the original echo command and not
> the comment above, I think...
> 

Yup, good eye.

>>   load_lp $MOD_LIVEPATCH
>>   disable_lp $MOD_LIVEPATCH
>> @@ -41,10 +38,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>>   % rmmod $MOD_LIVEPATCH"
>>   
>>   
>> -# TEST: Take over system state change by a cumulative patch
>> -
>> -echo -n "TEST: taking over system state modification ... "
>> -dmesg -C
>> +start_test "Take over system state change by a cumulative patch"
>>   
>>   load_lp $MOD_LIVEPATCH
>>   load_lp $MOD_LIVEPATCH2
>> @@ -85,10 +79,7 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
>>   % rmmod $MOD_LIVEPATCH2"
>>   
>>   
>> -# TEST: Take over system state change by a cumulative patch
>> -
>> -echo -n "TEST: compatible cumulative livepatches ... "
>> -dmesg -C
>> +start_test "Take over system state change by a cumulative patch"
> 
> ...because now we have two "Take over system state change by a cumulative
> patch" tests in the log.
> 

Right, the start_test messages should be unique.  I'll fix those up for v2.

-- Joe

