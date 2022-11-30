Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361AD63E34E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 23:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK3WUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 17:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3WUC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 17:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9386A36
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669846749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6o5xsiCb8krzXFleCMYPHZ4PemlXBw4WGglNIquBOc=;
        b=Ux5+W+2RSfjPxHOLYRNmBsqDgb5IsvEWDinTSblEsetOKxZpKeRuGSEcnbVEeVnbTLKsJe
        +bBkiKUmMa1/YdYMSnf5V2sIH8MaXXCcjsaqq+paLABdCLFN7ICnN4jj4br182ERZhD+ge
        oY+H5ipAYnxwZFnOtiwhKrj5gXmZRRM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-a264PMQTOyOZ9-kIHrC_iA-1; Wed, 30 Nov 2022 17:19:07 -0500
X-MC-Unique: a264PMQTOyOZ9-kIHrC_iA-1
Received: by mail-qk1-f199.google.com with SMTP id bj4-20020a05620a190400b006fc7c5d454cso28472819qkb.14
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 14:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:subject:from:references:cc:to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6o5xsiCb8krzXFleCMYPHZ4PemlXBw4WGglNIquBOc=;
        b=CFDUrS9vQYe8+c9tKipgCrGFGqyKORBIvw7CIgUo2zJjccjke2YeV0aejtXepTn8Ib
         VwtwD/CmrrlaEXR1HstDbiY/Fm5Mi74r1lgLzI8lY7pl9p5kMxdd3R5yjKjDV0xMf1g5
         jf2by7qMmi8tnNUXKz3rp51dLRls4UYyYI7DelAMhzprVnz/JwxNL2uKFZjKJpRBuFze
         7DHAOqs33keGndrpWCOLvXGnuJHC7MzNcNuyn9hytea/jG0YF1LfhglM47G4YIht8uwK
         XgBC56kCI2Y1nU4xAbYkFAyOxPcY98orKKHwZJ9OXpBVAabeqw9vW1dh9ES9bY89Wxeu
         rRuw==
X-Gm-Message-State: ANoB5pkg5LMh0PH5xN+B0Rtp1pnBIlba9t1+nekZNGeEJO8xV8LzxrCc
        4uFZa7KyjtOg3hfHSfvtJAjYp28xMN5onW9X6n5agumkpeVfSOaKW/cwzqieCTgD1+1hH8cel2Q
        Qojb1GxZHDMLs578VtYRJ406u2MxN
X-Received: by 2002:a37:3c3:0:b0:6fc:9786:2809 with SMTP id 186-20020a3703c3000000b006fc97862809mr6715349qkd.766.1669846747431;
        Wed, 30 Nov 2022 14:19:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5pN3jJGoF0gbBWxCZMJ1retVBfgEGufqLp719e7LR7xzbVfmLyToAzM4Z6FvMs6oYpHHng5g==
X-Received: by 2002:a37:3c3:0:b0:6fc:9786:2809 with SMTP id 186-20020a3703c3000000b006fc97862809mr6715332qkd.766.1669846747121;
        Wed, 30 Nov 2022 14:19:07 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id l28-20020a37f91c000000b006fca1691425sm1194426qkj.63.2022.11.30.14.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 14:19:06 -0800 (PST)
To:     Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <20220630141226.2802-3-mpdesouza@suse.com> <Ys2Li9ilYtpmJhN3@redhat.com>
 <20221124130545.2f7cpc5xkzqiybsw@daedalus>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 2/2] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <62c7c2b3-bcc0-22c3-a2f2-f3570434a3a4@redhat.com>
Date:   Wed, 30 Nov 2022 17:19:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221124130545.2f7cpc5xkzqiybsw@daedalus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/24/22 8:05 AM, Marcos Paulo de Souza wrote:
> On Tue, Jul 12, 2022 at 10:56:11AM -0400, Joe Lawrence wrote:
>> On Thu, Jun 30, 2022 at 11:12:26AM -0300, Marcos Paulo de Souza wrote:
> ...
>> nit: no need to init global to 0
>>
>>> +static int sig_int;
>>> +
>>> +void hup_handler(int signum)
>>> +{
>>> +	stop = 1;
>>> +}
>>> +
>>> +void int_handler(int signum)
>>> +{
>>> +	stop = 1;
>>> +	sig_int = 1;
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	pid_t orig_pid, pid;
>>> +	long count = 0;
>>> +
>>> +	signal(SIGHUP, &hup_handler);
>>> +	signal(SIGINT, &int_handler);
>>> +
>>> +	orig_pid = syscall(SYS_getpid);
>>> +
>>> +	while (!stop) {
>>> +		pid = syscall(SYS_getpid);
>>> +		if (pid != orig_pid)
>>> +			return 1;
>>
>> This test doesn't care about the user program return code, but I wonder
>> if the status should be flipped -- this is the desired code path, not
>> the one at the end of main(), right?
>>
> ...

Ah, nevermind ...

>>> +	 */
>>> +	mutex_lock(&kpid_mutex);
>>> +	list_for_each_entry_safe(kpid, temp, &klp_pid_list, list) {
>>> +		if (current->pid == kpid->pid) {
>>> +			list_del(&kpid->list);
>>> +			kfree(kpid);
>>> +			npids--;
>>> +			break;
>>
>> I think it would be safer to return task_tgid_vnr() here, but ...
>>
>>> +		}
>>> +	}
>>> +	mutex_unlock(&kpid_mutex);
>>> +
>>> +	return task_tgid_vnr(current);
>>
>> task_pid_vnr() here.  That way we're only changing behavior for the
>> processes in the list and not all programs across the system.
> 
> I believe that these two suggestions can be linked per your answer. First of
> all, I didn't write the original test program, but I agree that we can make it
> better.
> 
> My intent by upstreaming the test was to ensure that test programs
> would keep working even when livepatching getpid while having processes calling
> getpid nonstop. For the purpose of the test, the test module livepatches getpid,
> but keeping the same behavior as before. The only change is to keep track of the
> test programs that need to transition to livepatched state.
> 
> Per your comment on the test program it seems that we expected to receive a
> different value from getpid, but it's not the case here. I believe the chec on
> test program is confusing and doesn't bring any benefit, so maybe it's better to
> remove it and keep the test even simpler:
> 

Now that I re-read it months later, I see that I mistakenly thought that
the livepatch was supposed to modify the return value.  So disregard my
earlier suggestions / questions about that.

>   --- a/tools/testing/selftests/livepatch/test_programs/test_klp-call_getpid.c
>   +++ b/tools/testing/selftests/livepatch/test_programs/test_klp-call_getpid.c
>   @@ -26,18 +26,13 @@ void int_handler(int signum)
> 
>    int main(int argc, char *argv[])
>    {
>   -   pid_t orig_pid, pid;
>       long count = 0;
> 
>       signal(SIGHUP, &hup_handler);
>       signal(SIGINT, &int_handler);
> 
>   -   orig_pid = syscall(SYS_getpid);
>   -
>       while (!stop) {
>   -       pid = syscall(SYS_getpid);
>   -       if (pid != orig_pid)
>   -           return 1;
>   +       (void)syscall(SYS_getpid);
>           count++;
>       }
> 
> As as only care about the processes transitioning to the livepatched state, we
> really don't care about the getpid return value (as it should be the same from patches
> and unpatched state).
> 
> I believe this resolves both issues. What do you think?
> 

Verifying orig_pid against the current pid return value would verify
that it was cleanly patched... though that seems incidental to the
purpose of the test.  The simplification above is ok with me either way.

-- 
Joe

