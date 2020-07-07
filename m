Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64221697F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGJt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 05:49:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46133 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726745AbgGGJt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 05:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594115394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HE0YCKlLU9F99TG9T+Hhh+hBQwUhwm8N1RW6a+ShOK4=;
        b=ZDuwFQkysDQgBqEo+lepexzEwlhxXcQ/JwrNeF+H5YRLAlHdBMtcPQDB+uxm44Fd9nmKIB
        QX+WDEq8r+FzK2h1aZS5TN74ZUnU/LcLmY5BaDBJH/o+Vw5IL89Dctjlm4IkJ+H/x9ckYF
        MoeNeLt4FYlPhjzutbecAeQUt7gTNrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-nEBlGxtOPTWlaNqOBCMwzQ-1; Tue, 07 Jul 2020 05:49:53 -0400
X-MC-Unique: nEBlGxtOPTWlaNqOBCMwzQ-1
Received: by mail-wr1-f69.google.com with SMTP id w4so46098053wrm.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 02:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HE0YCKlLU9F99TG9T+Hhh+hBQwUhwm8N1RW6a+ShOK4=;
        b=lY2XhbFtYBloARcPVghLJo4NVjL2Bt3LFjwiXCSppJlTGw4wyR3h2biKw3jJVybOF+
         RtRm+4/jc0dKlR9j8ZblpQj+rnDRY/hUDPNgCJANx14jUSLcInswb25uCKpHJQxyufjk
         cP982uHA6wByWO47wagVzk+jrWUbjKrUbncr9f8Wf0osUYTxip2vZHjzmc+qXhV7BvNm
         zRVVEMnEPYQDAlfnheGAxnm9sDg3gyMZDa2GOIlOmDsp4KnADv3WVdCZXqYcd9YjffN4
         pD3sLISnGsQrFscDUTaLV12nBXgjC+INrl46Ns8GlFGDIDyngMeF+XAF+s6wdRYYKb+w
         Jtqg==
X-Gm-Message-State: AOAM5312zky0JtCQdFosq5JYsjSeWrCtMHP2sYh7QUaBJeog423qSj9O
        TYiOQekVnaO1Ldx10Y6INl0cslnwB286hNMbpYsNoKeZgoTDAs6zdxUWowSUlB7IqV8pVHhxSTg
        r95cIZxn0QItJMzgE7Dq4nbjjQI5u
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr56651323wrn.179.1594115391984;
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx833zL/K0cNEjUfxy2wssoAehJsLXM23AeWFK29RZHs/YmUnXxRgtM3f+w/l4wfBu5MefiCw==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr56651300wrn.179.1594115391755;
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id 1sm354662wmf.21.2020.07.07.02.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 02:49:51 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
 <20200623204441.phngiwlj2idonpe6@wittgenstein>
 <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
 <f0b60da1-ce3f-da53-9ffc-94fea233181a@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e98d690-2202-4183-5b49-942f29b0a955@redhat.com>
Date:   Tue, 7 Jul 2020 11:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f0b60da1-ce3f-da53-9ffc-94fea233181a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/07/20 22:55, Shuah Khan wrote:
> On 6/24/20 12:21 AM, Paolo Bonzini wrote:
>> On 23/06/20 22:44, Christian Brauner wrote:
>>>>       ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>>>>       if (ret < 0) {
>>>> -        if (errno == ENOSYS)
>>>> -            ksft_exit_skip(
>>>> +        if (errno == ENOSYS) {
>>>> +            ksft_test_result_skip(
>>>>                   "%s test: pidfd_send_signal() syscall not
>>>> supported\n",
>>>>                   test_name);
>>> If pidfd_send_signal() is not supported, you're falling through and then
>>> you're reporting:
>>>
>>> ok 5 # SKIP pidfd_send_signal check for support test:
>>> pidfd_send_signal() syscall not supported
>>> ok 6 pidfd_send_signal check for support test: pidfd_send_signal()
>>> syscall is supported. Tests can be executed
>>
>> You're right, this needs a "return".
>>
> 
> Hi Paulo,
> 
> I am applying the rest of the patches in this series except this one.
> Please send v3 for this.

Thanks, I was actually going to send everything but you're making it
even simpler.  I'll send v3 of this patch only.

Paolo

