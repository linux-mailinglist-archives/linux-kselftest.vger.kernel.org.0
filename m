Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEA2E9AFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jan 2021 17:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbhADQYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jan 2021 11:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbhADQYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jan 2021 11:24:39 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E17C061574
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jan 2021 08:23:59 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d9so25521720iob.6
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jan 2021 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wemsb37DzntpV4pW/5pI+u9gqkW7QMjVnMnmRP4qBjU=;
        b=VqOisZ/CdyRKbpeOUNpOVoWM1FSRb/JGk/Vsduvzmxocz6bfVdqXFetPsa2RDZOEzI
         FfL9LptnjKauZtfx0fmkWz9rDeQRbUHdx44EJv3lb7uYmhqvXYdO/aHxkjkI0XeuNgYb
         DUCzJni0/ukMUvlXz5cAq4YIpRFgJGLSslhkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wemsb37DzntpV4pW/5pI+u9gqkW7QMjVnMnmRP4qBjU=;
        b=QVHAYntCfHkjsFLko055QRYjqC4NihpU7rRo2Kc772Oah/g7D7rwyFJ3LyLZmQ9ccJ
         wguMAiMLyUGph3Wbh6E8w2B0+i20IK28/qiIpoc+4DA9Yt6NLxr5PAGwxzf7JKlqsCg/
         3U1GirkAke/tOnfANVU+DwyNgaLtMdu3HfT0/zZGbffNaVgNDck7ZxLU3s5iba+LtiBg
         cmLIATas6XSTzUdy5XhOfnsnub5joN/5OdCZ2tQ2AOkTlnF3aXaGB5j8f0mSvt01wVuk
         yblpkYPlVNfvu9fzWoCWcCYbRo2hEUB0iYb3lty52MdiIboAFcw8m8HqX6vCoDCO/Bnq
         xtSA==
X-Gm-Message-State: AOAM5336+MmbxzLace9Sor4IjVMWWmtRdCS7n1JesbpNmC79/VAO+4Q0
        xadIBOmdN6fApIovUMK1CsT/sw==
X-Google-Smtp-Source: ABdhPJxakEz6S0w0U3N0p+Y6Xti6huLJ6M//I6/UEgJPtyNIQkD8TtHQ4C+J2FRZQz47KQKtZhC1ig==
X-Received: by 2002:a5d:9713:: with SMTP id h19mr59064409iol.14.1609777438759;
        Mon, 04 Jan 2021 08:23:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n16sm41720610ilj.19.2021.01.04.08.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:23:58 -0800 (PST)
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Petr Mladek <pmladek@suse.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
Date:   Mon, 4 Jan 2021 09:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222111102.GC4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/22/20 4:11 AM, Andy Shevchenko wrote:
> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
>> kunit_tool relies on the UML console outputting printk() output to the
>> tty in order to get results. Since the default console driver could
>> change, pass 'console=tty' to the kernel.
>>
>> This is triggered by a change[1] to use ttynull as a fallback console
>> driver which -- by chance or by design -- seems to have changed the
>> default console output on UML, breaking kunit_tool. While this may be
>> fixed, we should be less fragile to such changes in the default.
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thank you all. Now in linux-kselftest kunit-fixes branch.

Will send this up for rc3.

Sorry for the delay - have been away from the keyboard for a
bit.

thanks,
-- Shuah
