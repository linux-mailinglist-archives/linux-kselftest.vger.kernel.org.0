Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD22206AC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 05:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbgFXDst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 23:48:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388288AbgFXDss (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 23:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592970526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9mmmSYUQts29pccjkqtdI3xyAW6oFJFtioXZrdF2dE=;
        b=HicTTcSrNH1W1ZP5x011sFv1lSGHSPkE65+TXaU3zUn+0czXu56+j8AYvLJ4eIt43lP+LZ
        PowhWyHCzvWqHcKx3xMQDmnDiWWQ3fYQ2GKQgBtOvC3lEOjZiXyvbNdGYx+Vm4qZpKjzBH
        ChexJll8ij5F7AihH4zqWtEOKH5Ri/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-6d5_5QTQNo-JDVy78zrAaA-1; Tue, 23 Jun 2020 23:48:40 -0400
X-MC-Unique: 6d5_5QTQNo-JDVy78zrAaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6DB805EE3;
        Wed, 24 Jun 2020 03:48:38 +0000 (UTC)
Received: from [10.10.112.56] (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BD2B10013C1;
        Wed, 24 Jun 2020 03:48:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
Date:   Tue, 23 Jun 2020 23:48:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/22/20 4:51 AM, Naresh Kamboju wrote:
> On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> It is Very Rude to clear dmesg in test scripts. That's because the
>> script may be part of a larger test run, and clearing dmesg
>> potentially destroys the output of other tests.
>>
>> We can avoid using dmesg -c by saving the content of dmesg before the
>> test, and then using diff to compare that to the dmesg afterward,
>> producing a log with just the added lines.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   tools/testing/selftests/lkdtm/run.sh | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
>> index dadf819148a4..0b409e187c7b 100755
>> --- a/tools/testing/selftests/lkdtm/run.sh
>> +++ b/tools/testing/selftests/lkdtm/run.sh
>> @@ -59,23 +59,25 @@ if [ -z "$expect" ]; then
>>          expect="call trace:"
>>   fi
>>
>> -# Clear out dmesg for output reporting
>> -dmesg -c >/dev/null
>> -
>>   # Prepare log for report checking
>> -LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
>> +LOG=$(mktemp --tmpdir -t lkdtm-log-XXXXXX)
>> +DMESG=$(mktemp --tmpdir -t lkdtm-dmesg-XXXXXX)
>>   cleanup() {
>> -       rm -f "$LOG"
>> +       rm -f "$LOG" "$DMESG"
>>   }
>>   trap cleanup EXIT
>>
>> +# Save existing dmesg so we can detect new content below
>> +dmesg > "$DMESG"
>> +
>>   # Most shells yell about signals and we're expecting the "cat" process
>>   # to usually be killed by the kernel. So we have to run it in a sub-shell
>>   # and silence errors.
>>   ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>>
>>   # Record and dump the results
>> -dmesg -c >"$LOG"
>> +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> 
> We are facing problems with the diff `=%>` part of the option.
> This report is from the OpenEmbedded environment.
> We have the same problem from livepatch_testcases.
> 
> # selftests lkdtm BUG.sh
> lkdtm: BUG.sh_ #
> # diff unrecognized option '--changed-group-format=%>'
> unrecognized: option_'--changed-group-format=%>' #
> # BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
> v1.27.2: (2020-03-30_164108 #
> #
> : _ #
> # Usage diff [-abBdiNqrTstw] [-L LABEL] [-S FILE] [-U LINES] FILE1 FILE2
> diff: [-abBdiNqrTstw]_[-L #
> # BUG missing 'kernel BUG at' [FAIL]
> 
> Full test output log,
> https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200621/testrun/2850083/suite/kselftest/test/lkdtm_BUG.sh/log
> 

D'oh!  Using diff's changed/unchanged group format was a nice trick to 
easily fetch the new kernel log messages.

I can't think of any simple alternative off the top of my head, so 
here's a kludgy tested-once awk script:

  SAVED_DMESG="$(dmesg | tail -n1)"
  ... tests ...
  NEW_DMESG=$(dmesg | awk -v last="$SAVED_DMESG" 'p; $0 == last{p=1}')

I think timestamps should make each log line unique, but this probably 
won't handle kernel log buffer overflow.

Maybe it would be easier to log a known unique test delimiter msg and 
then fetch all new messages after that?

-- Joe

