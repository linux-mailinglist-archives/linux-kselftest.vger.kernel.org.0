Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD50A1F897D
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jun 2020 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgFNPTU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Jun 2020 11:19:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgFNPTT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Jun 2020 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592147958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCVU/yh8O2bi++F6sN13Rq/PxshVHJ12h2H5dgF1PZg=;
        b=Elq+p+y8j9o3qE/1shiefcQlsFBdxr9pe2mbmsMxnFNo9x0dTUPe3u6vB2rXvRYDcHvyMH
        eSZx/xcVSW0VgRe4U7J5apA14uV9X8QBxjNDZ9YvLIGG0L3aZsrZgibuvPGBS8IDYKqAjX
        YtO4B3QWSqdNbgcLJztmJtKAAciT2g0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-OCwPZXNFPnShXXrNItIFmA-1; Sun, 14 Jun 2020 11:19:09 -0400
X-MC-Unique: OCwPZXNFPnShXXrNItIFmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93721107ACCA;
        Sun, 14 Jun 2020 15:19:08 +0000 (UTC)
Received: from [10.10.112.56] (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE2B7C0A5;
        Sun, 14 Jun 2020 15:19:07 +0000 (UTC)
Subject: Re: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running
 tests
To:     Petr Mladek <pmladek@suse.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-2-joe.lawrence@redhat.com>
 <20200612094903.GE4311@linux-b0ei>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <5dc57181-383f-666a-8d3e-17d36ba6aa8c@redhat.com>
Date:   Sun, 14 Jun 2020 11:19:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200612094903.GE4311@linux-b0ei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/20 5:49 AM, Petr Mladek wrote:
> On Wed 2020-06-10 13:20:59, Joe Lawrence wrote:
>> [ ... snip ... ]
>>   
>> +function start_test {
>> +	local test="$1"
>> +
>> +	# Save existing dmesg so we can detect new content below
>> +	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
> 
> There is a nice trick how to remove the temporary files even
> when the script fails from other reasons. The following should
> do the job:
> 
> function cleanup {
> 	rm -f "$SAVED_DMESG"
> }
> 
> trap cleanup EXIT
> 

Right, we currently trap EXIT INT TERM HUP to pop the dynamic debug and 
kernel.ftrace_enabled sysctl settings.  I can add a cleanup() function 
to take care of both the settings and the tmp file.

>> +	dmesg > "$SAVED_DMESG"
>> +
>> +	echo -n "TEST: $test ... "
>> +}
>> +
>>   # check_result() - verify dmesg output
>>   #	TODO - better filter, out of order msgs, etc?
>>   function check_result {
>>   	local expect="$*"
>>   	local result
>>   
>> -	result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
>> +	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
>> +		 grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | \
>> +		 sed 's/^\[[ 0-9.]*\] //')
>>   
>>   	if [[ "$expect" == "$result" ]] ; then
>>   		echo "ok"
>> @@ -257,4 +269,6 @@ function check_result {
>>   		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
>>   		die "livepatch kselftest(s) failed"
>>   	fi
>> +
>> +	rm -f "$SAVED_DMESG"
> 
> This change will not be necessary with the above trap handler.

Well start_test() and check_result() are called multiple times per 
script.  That means that with the original v1 change, we're creating new 
$SAVED_DMESG files per start_test() since check_result() is comparing 
only the new entries from test to test.

So I think this particular hunk in the modification would be necessary 
even with the trap handler.  The trap handler would still be nice to 
have in case the script is interrupted though.

> 
> Otherwise, I really like the change. I was always a bit worried that these
> tests were clearing all other messages.
> 

Yup, we ran into an instance internally where another test was failing 
because were blowing away the logs :(


-- Joe

