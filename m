Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B555E3C63D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jul 2021 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhGLTp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jul 2021 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhGLTp0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jul 2021 15:45:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597DC0613DD
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jul 2021 12:42:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h3so20721842ilc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jul 2021 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miTV5hqnW4EPZWVXufx2n/PRXkTcJW4p7CWdR36CIew=;
        b=LMSzFCaiR4GD3YI1boTGrHQJHxKnm8Ougeao4dN2yHS0QKhB4xUL1ZCfjic3q2Lv2V
         w+OTnd6oxZJdqe0O+uu9DnqfLndb0oPX6nMefi/FkHZgthaj5lM1/w8YBCl5smhTu5hS
         fQEO2g4RSJNMfwMs90sdR2uFF+MEAAVoi+P48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miTV5hqnW4EPZWVXufx2n/PRXkTcJW4p7CWdR36CIew=;
        b=nm5VAfbCSRModetFflGniAXBGO4hqXy/Xc7OXmDfuJCiEcvJG5zWG+/6TJzUT6Yo3P
         1P03u/6CFHjorP7FbWXw24xU98uPNi/QG8lL5EzeBj4lOEoxybKCOwGpQqjqr0e0F22j
         YxE28TEH5KySkVm99fUM9hG3la2rE02txrgrvWIaqtaToHpdgi278A3bJiHCoohcztqt
         TtyJOzHCBKQ6BuCd/z2+jJzPECqnSaZRpyQQCun7SjqFtsGUBzllsayuKAiBNQRxOiup
         H0almFiMiXE6nikD7wxk++wzdJtqZv068mrzdVXwhsqz3BQ+EamGxj0NVVUYzGKpszeh
         Af/g==
X-Gm-Message-State: AOAM5305JM1u1F7nirko09uwjA7NpNUQLvuvCqUCxOmwXd+OqMBDwjFc
        g/l1VtKZxdmhlXPUTJYoeTq06g==
X-Google-Smtp-Source: ABdhPJw+D9Y0t0uSlGkP9VzCV9UbbIM3ffohaXASpJ/ygzivQ+RnraMTivofQpig2E8WneA/SSmY4A==
X-Received: by 2002:a92:360e:: with SMTP id d14mr361226ila.106.1626118955879;
        Mon, 12 Jul 2021 12:42:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e14sm8606044ile.2.2021.07.12.12.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:42:35 -0700 (PDT)
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210617073937.16281-1-sjpark@amazon.de>
 <20210617074638.16583-1-sjpark@amazon.de>
 <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6fb4706b-ce58-a397-d777-10338c2a8d4e@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 13:42:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/28/21 1:41 PM, Brendan Higgins wrote:
> On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
>>
>> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
>> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
>> Because it is supported on only >=3.7 Python, people using older Python
>> will get below error:
>>
>>      Traceback (most recent call last):
>>        File "./tools/testing/kunit/kunit.py", line 20, in <module>
>>          import kunit_kernel
>>        File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>>          from __future__ import annotations
>>          ^
>>      SyntaxError: future feature annotations is not defined
>>
>> This commit adds a version assertion in 'kunit.py', so that people get
>> more explicit error message like below:
>>
>>      Traceback (most recent call last):
>>        File "./tools/testing/kunit/kunit.py", line 15, in <module>
>>          assert sys.version_info >= (3, 7), "Python version is too old"
>>      AssertionError: Python version is too old
>>
>> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Your from and Signed-off-by email addresses don't match.

Please resend the patch with the correction.

thanks,
-- Shuah
