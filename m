Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7A1723CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 17:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgB0QpZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 11:45:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45407 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgB0QpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 11:45:24 -0500
Received: by mail-io1-f68.google.com with SMTP id w9so116917iob.12
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rS6KqBFssX9ZUdW6+MPkG1KvIc6wVLI2emiU+QF0qwg=;
        b=XaBoABkOukH7Nu7mt4lsMgCefNzcJQuXa2aVFVbkfZpp6Tb5s+73tbFVKvoyGjA/de
         rmZCbRd35i75iH1YaR3+beQ0/MRPNMdEGj3CTigZMKUY3xL+M1uKsj1ZAx7tdcdtuV87
         YOAZpAJF4zquagazdIfTcwOMiCpDIc/iUts64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS6KqBFssX9ZUdW6+MPkG1KvIc6wVLI2emiU+QF0qwg=;
        b=oFXnoprpIxFKJ42dxqiInQVAuUHbharMOg5Zi1yQ33XSS3akJ6LJJB0kesOmdL9CZj
         HIIPN6n4M+3YGLG5mJQUBp+qd4QuV0WhojywgzmNMIP7mF1w4LdPQsjx5HkJRGbTpyVR
         iD7x/+qYI0BzH3tBnJXVF4c4IEPfVoLKS1vEVl6LuMc00U0x37w9wx3znqGVBxKF4vUA
         u0eQ26J4Ooy2bad34ds4Rfq6l4Z5yMYXhZf5sca/WZvmglUrZoOAMRdG1xNLCh44Dkxf
         WrDQGww3FBddO8yVyjkM87TR22lM+CiJ3M9nr/KJUoXQvBCcoa5PCnAo27Tb0iPksh5s
         a7uQ==
X-Gm-Message-State: APjAAAUZP8jEZWya8oFVgshkE0JIE+bumg5OYzDCmdgiDqbpLMkI289f
        cp87TrIp3CRn1MMHJvPlnbemKg==
X-Google-Smtp-Source: APXvYqx/a5Dli7aKEcWZrJspfguzTO9DfNqargT1han0HSOgIYlEsoiSlvvxXv/MLc1HIIpISgSXpg==
X-Received: by 2002:a6b:700e:: with SMTP id l14mr187328ioc.170.1582821924223;
        Thu, 27 Feb 2020 08:45:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i16sm1978584ils.41.2020.02.27.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:45:23 -0800 (PST)
Subject: Re: [PATCH] selftest/lkdtm: Use local .gitignore
To:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
 <202002270817.1C32C98@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f804d7bc-134d-27f8-daa5-6bbf9f28b54d@linuxfoundation.org>
Date:   Thu, 27 Feb 2020 09:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002270817.1C32C98@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/27/20 9:17 AM, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 02:07:10PM +0000, Christophe Leroy wrote:
>> Commit 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>> introduced patterns for git to ignore files generated in
>> tools/testing/selftests/lkdtm/
>>
>> Use local .gitignore file instead of using the root one.
>>
>> Fixes: 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Yeah, that's better. Thanks!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 

I will apply it for next rc.

Thanks. I should have noticed the problem in the previous version.
It slipped by me. :(

thanks,
-- Shuah

