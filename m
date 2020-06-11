Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F491F68DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFKNKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 09:10:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726868AbgFKNKw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591881051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFGOLUaFh/hmkT/1igewJVMp/edmLIDMlEr14/5OK/s=;
        b=Lj8yRFHs32vaymMTfIiFK6bGZBlikQRhGhpKutH7r8nWRkZj3YaixU1khdzzrxnWIF6Ppe
        YjxHgteCrfRM40YMz9Rd9Jtchcvy13td/N2RANNZvlgPsd4MroJoSiyh956WSW5yP6VJw3
        6jCAyjqOYSzPbs5ppaUYy7i7FVajeTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-JlW18mHzNn2XWmMyytPn5g-1; Thu, 11 Jun 2020 09:10:40 -0400
X-MC-Unique: JlW18mHzNn2XWmMyytPn5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C88138018A7;
        Thu, 11 Jun 2020 13:10:39 +0000 (UTC)
Received: from [10.10.117.142] (ovpn-117-142.rdu2.redhat.com [10.10.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BC175D9DC;
        Thu, 11 Jun 2020 13:10:39 +0000 (UTC)
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-4-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
Date:   Thu, 11 Jun 2020 09:10:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/20 3:39 AM, Miroslav Benes wrote:
> On Wed, 10 Jun 2020, Joe Lawrence wrote:
> 
>> The livepatch selftests currently filter out "tainting kernel with
>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
>> modules.
>>
>> Further filter the log to drop "loading out-of-tree module taints
>> kernel" in the rare case the klp_test modules have been built
>> out-of-tree.
>>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
>>   tools/testing/selftests/livepatch/functions.sh | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>> index 83560c3df2ee..f5d4ef12f1cb 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -260,7 +260,8 @@ function check_result {
>>   	local result
>>   
>>   	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
>> -		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
>> +		 grep -e '^livepatch:' -e 'test_klp' | \
>> +		 grep -ve '\<taints\>' -ve '\<tainting\>')
> 
> or make it just 'grep -v 'taint' ? It does not matter much though.
> 

I don't know of any larger words* that may hit a partial match on 
"taint", but I figured the two word bounded regexes would be more specific.


* https://www.wordfind.com/contains/taint/ : guess I need to up my 
scrabble game :D

-- Joe

