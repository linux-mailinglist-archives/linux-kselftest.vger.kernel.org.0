Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C166E3A6C51
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhFNQrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhFNQrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 12:47:48 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A83C061767
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 09:45:45 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso2805823ooa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PFSRmp8JKTSq2aEG0094DvugKBOda8AdaRxBNubaTys=;
        b=KgD39h1HjXt/ebnoAuXPxq3c2WU46s43ejAz2HDZX7yR3/teArjfZ3uNpnoGuOeDuA
         JXJ45b12d6ILvZCnpTQjkhNFAYYOwabWL+kNbIeirF2RjOyg81uKl4OOj3q//zR4HLFz
         zFNlZRAJnXwIKR1/t9z9LuAVdLHqz38WMRMQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFSRmp8JKTSq2aEG0094DvugKBOda8AdaRxBNubaTys=;
        b=gS5EyBFiFT1o4tiH17DoEhDTaqwzJI5Fsg+FD6F1MAzdw6S7XSfUbo87HpYDXbx1kn
         9EurtRKGSLDUtmO1NSXfkB2O02BJOE6EY9P9DG5j5iBFl6lYY+Ra6hfy3WFhm/cuvXM+
         UtdFJFFeZiRrHKc4LSpKsywLkbMpYQ4XDpStU1VATZxFyKl9OeSKQasudUhmPB2dLVFg
         wVAgP1+46zpt6kKZoPx7t4YrBLeAFryBM9fIJ+1+L+CK8mmwcuihsGqYSxiknKButDwC
         jGHkoJvwBwjYkjB3u3UUB905daItOYP+S2xAGhR0NwvUxHA35h7lzsDntlgK2spZToxc
         bDMQ==
X-Gm-Message-State: AOAM532Widjxjmeb+BNJKHGRvujmCqG70qC+7p1uvybKJLtIabqnJLFn
        r+YLDMuEGKuudxDnXHx4po97ww==
X-Google-Smtp-Source: ABdhPJzNffNtbA5YBzkOiXlPRc7yVP3MO7ZyIGJJfvUK2X+q/StJjff0bpIYpjn33GPrU8GyTzUu5Q==
X-Received: by 2002:a4a:91cb:: with SMTP id e11mr2229118ooh.53.1623689144764;
        Mon, 14 Jun 2021 09:45:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 2sm3359048ota.58.2021.06.14.09.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:45:44 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] selftests/sgx: Dump enclave memory map
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-3-jarkko@kernel.org>
 <bb39b6af-5921-64e8-793b-5ef4b150153e@linuxfoundation.org>
 <20210612042723.vp26eafhyzrv7t66@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c18409da-dd2b-c813-d7dd-bad81db102bd@linuxfoundation.org>
Date:   Mon, 14 Jun 2021 10:45:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210612042723.vp26eafhyzrv7t66@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/21 10:27 PM, Jarkko Sakkinen wrote:
> On Fri, Jun 11, 2021 at 04:45:19PM -0600, Shuah Khan wrote:
>> On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
>>> Often, it's useful to check whether /proc/self/maps looks sane when
>>> dealing with memory mapped objects, especially when they are JIT'ish
>>> dynamically constructed objects. Therefore, dump "/dev/sgx_enclave"
>>> matching lines from the memory map in FIXTURE_SETUP().
>>>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>>    tools/testing/selftests/sgx/main.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
>>> index 6da19b6bf287..14030f8b85ff 100644
>>> --- a/tools/testing/selftests/sgx/main.c
>>> +++ b/tools/testing/selftests/sgx/main.c
>>> @@ -117,6 +117,8 @@ FIXTURE_SETUP(enclave)
>>>    	Elf64_Sym *sgx_enter_enclave_sym = NULL;
>>>    	struct vdso_symtab symtab;
>>>    	struct encl_segment *seg;
>>> +	char maps_line[256];
>>> +	FILE *maps_file;
>>>    	unsigned int i;
>>>    	void *addr;
>>> @@ -167,6 +169,18 @@ FIXTURE_SETUP(enclave)
>>>    	memset(&self->run, 0, sizeof(self->run));
>>>    	self->run.tcs = self->encl.encl_base;
>>> +	maps_file = fopen("/proc/self/maps", "r");
>>
>> I almost applied these. Does this require root access, if so,
>> please add logic to skip the test if non-root user runs it.
>>
>> Same comments for all other paths that might require root access.
> 
> As Dave stated, it does not. A process can inspect its own state
> through /proc/self path. E.g. Chrome web browser uses /proc/self/exe
> to initialize multiple instances of itself for browser tabs...
> 

Ah yes. I missed the self part. Thanks for clarifying.

> As far as other things go, this patch set does not bind to any other
> new OS resources.
> 

Thank you. I will apply these for 5.14-rc1.

thanks,
-- Shuah

