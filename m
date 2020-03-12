Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABC183410
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCLPFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 11:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgCLPFt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 11:05:49 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEE92067C;
        Thu, 12 Mar 2020 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584025548;
        bh=FbmUiVOA14nTP0Xhx1vi8oiKbCQV1kWtBDPOyRnEwCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hooWW8c2eciNTDjHVxxKZfWyBN1INv++BQ+GWOeowSMvpkJh8+IzpAKfdS8SEV58z
         wFTKR1dXTcpvxC6qRv91KI309ZZ84J3Z7i52g/tslhRT6wMzTZnHqyF51V4Xul5FuO
         /hE/buEsOB64GvYZqEgvnKjnOYqAJjUYKydNz3Pw=
Subject: Re: [PATCH] selftests/ftrace: Fix typo in trigger-multihist.tc
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200312040337.7631-1-standby24x7@gmail.com>
 <20200312092355.73d8c019@gandalf.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <4aee9c92-b83a-97ac-a9d7-242eb785cf2b@kernel.org>
Date:   Thu, 12 Mar 2020 09:05:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312092355.73d8c019@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/12/20 7:23 AM, Steven Rostedt wrote:
> On Thu, 12 Mar 2020 13:03:37 +0900
> Masanari Iida <standby24x7@gmail.com> wrote:
> 
>> This patch fix a spelling typo in trigger-multihist.tc
>>
>> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
>> ---
>>   .../selftests/ftrace/test.d/trigger/trigger-multihist.tc        | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> index 18fdaab9f570..68ff3f45c720 100644
>> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
>> @@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
>>       exit_unsupported
>>   fi
>>   
>> -echo "Test histogram multiple tiggers"
>> +echo "Test histogram multiple triggers"
> 
> Winnie the Pooh will be upset.

I recall one like this one a while back. :)
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah, want to take this?
> 

Yes. I will pull this in.

thanks,
-- Shuah
