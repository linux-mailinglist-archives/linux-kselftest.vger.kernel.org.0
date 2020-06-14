Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A641F8962
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jun 2020 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFNOpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Jun 2020 10:45:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44607 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgFNOpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Jun 2020 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592145917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQbcADBdynyfFvL2/kP9B3MM2N/SO9nkEFELXG7wcn8=;
        b=RChqwbNUEUUMVegyRCRvmkX/R0cUQaQ32fCM7FnZ/6AtyWKe7CW1b9EnLCANwk+bO/RtYH
        F2KQNsEG8KYw2Najv1LcKQTIMPJPbw3RxzfNJOJseI/QXZNVGJ+QxgNfk+HRa+wN3WJ1zm
        Mql088IHCwPaPAUAusFp4qx1tDWSmNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-HzONS81KOJOHz3cU0I39gQ-1; Sun, 14 Jun 2020 10:45:13 -0400
X-MC-Unique: HzONS81KOJOHz3cU0I39gQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7ADBFC1;
        Sun, 14 Jun 2020 14:45:12 +0000 (UTC)
Received: from [10.10.112.56] (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BB038A;
        Sun, 14 Jun 2020 14:45:11 +0000 (UTC)
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-4-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
 <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
 <20200612114706.GH4311@linux-b0ei>
 <ba0202cf-beea-ddde-4941-053718c77257@linux.vnet.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <b1db9ae1-781c-6ea5-c748-0928bed145f1@redhat.com>
Date:   Sun, 14 Jun 2020 10:45:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ba0202cf-beea-ddde-4941-053718c77257@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/20 8:57 AM, Kamalesh Babulal wrote:
> On 6/12/20 5:17 PM, Petr Mladek wrote:
>> On Thu 2020-06-11 09:10:38, Joe Lawrence wrote:
>>> On 6/11/20 3:39 AM, Miroslav Benes wrote:
>>>> On Wed, 10 Jun 2020, Joe Lawrence wrote:
>>>>
>>>>> The livepatch selftests currently filter out "tainting kernel with
>>>>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
>>>>> modules.
>>>>>
>>>>> Further filter the log to drop "loading out-of-tree module taints
>>>>> kernel" in the rare case the klp_test modules have been built
>>>>> out-of-tree.
>>>>>
>>>>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>>>>> ---
>>>>>    tools/testing/selftests/livepatch/functions.sh | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>>>>> index 83560c3df2ee..f5d4ef12f1cb 100644
>>>>> --- a/tools/testing/selftests/livepatch/functions.sh
>>>>> +++ b/tools/testing/selftests/livepatch/functions.sh
>>>>> @@ -260,7 +260,8 @@ function check_result {
>>>>>    	local result
>>>>>    	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
>>>>> -		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
>>>>> +		 grep -e '^livepatch:' -e 'test_klp' | \
>>>>> +		 grep -ve '\<taints\>' -ve '\<tainting\>')
>>>>
>>>> or make it just 'grep -v 'taint' ? It does not matter much though.
>>>>
>>>
>>> I don't know of any larger words* that may hit a partial match on "taint",
>>> but I figured the two word bounded regexes would be more specific.
>>
>> I do not have strong opinion. I am fine with both current and Mirek's proposal.
>>
>> I am just curious where \< and \> regexp substitutions are documented.
>> I see the following at the very end of "man re_syntax":
>>
>>     \< and \> are synonyms for  â€œ[[:<:]]â€� and â€œ[[:>:]]â€� respectively
>>
>> But I am not able to find documentation for â€œ[[:<:]]â€� and â€œ[[:>:]].
>> Even google looks helpless ;-)
>>
> 
> AFAIK, using \< and \> matches exact word.  Whereas when used individually,
> \< matches beginning and \> matches end of the word.
> 

 From 
https://www.gnu.org/software/grep/manual/grep.html#The-Backslash-Character-and-Special-Expressions 
:

The ‘\’ character, when followed by certain ordinary characters, takes a 
special meaning:

...

‘\<’

     Match the empty string at the beginning of word.
‘\>’

     Match the empty string at the end of word.


I'd be happy to use any other (more readable!) whole-word matching grep 
trick, this \<one\> just happens to be committed to my cmdline muscle 
memory.

-- Joe

