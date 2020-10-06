Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE35284EC9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJFPVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJFPVG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 11:21:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB98DC0613D3
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Oct 2020 08:21:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so11326109ilh.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Oct 2020 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmj7x7pJat8UNIIwIa7Sd+SRNOWKvcmn8r90tiL0s1A=;
        b=IXQwwVAi7F6pRyGOUEQ8zaCzPCqLYGzR6fWH1AMiUEwCFiSYJ471FkLdAmCwbx2c54
         ItJ9whV/AqUo+mM2d7MbaozYvKfTm/b80nFjzDVrSdzgt+4L5TPDPIQZWJW4+sAYwEpy
         BbucuKw8YdnI1BxGGqAvEq5di/ZoXDjLG4oTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmj7x7pJat8UNIIwIa7Sd+SRNOWKvcmn8r90tiL0s1A=;
        b=HFGEZ+YORDdZ4T+NynUi+Iy4E0N3fJ3xVnJLV0+itBcQM896SKnmjotBainZcv0LJb
         /Oq+5SRtCPVsr7ctHK+syHe3NSeHrtnchfKl99tcVVsB2657uRBi4Vdsqhh7vQBLlpse
         ZlitfcGkfegJexVB2xcbftInNsKPR+KbyHSE8oqtvBw5Tpmt/KtG6FNPpKH2/K0Rcbib
         knVc0lwPOtx+qjX7j1gK8RQ7VeNWRU1Bep7cNlzwZsGpjHjy9oVD8T+47dQu3yDAV9aY
         YHyyxoiUqL9bkDoZMchQwO6rqIZqijYtgCXntYh5fntN/QiN7cK1WRWFGKU94f4n4puz
         K+Ew==
X-Gm-Message-State: AOAM532+ZKYqKxTGZAhIFU1WIkNBSd04lyvHZRMx8+ERvUxBF9ApTaJx
        emWxqVOET2Jhz3E83bNykOFktw==
X-Google-Smtp-Source: ABdhPJyqEmZz43/2Pp1HykB1ZUp+7my5maxDOMBk3deo+zKUWBRwafPlIzkV/qrgjjh1lVhgQ7y1zw==
X-Received: by 2002:a92:b50b:: with SMTP id f11mr4049407ile.109.1601997664092;
        Tue, 06 Oct 2020 08:21:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z76sm349366ilf.76.2020.10.06.08.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 08:21:03 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009260923.9A2606CFF6@keescook>
 <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
 <202009281612.EDC1C0078@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <700f0ed4-fe09-7610-b460-89b5ad08452c@linuxfoundation.org>
Date:   Tue, 6 Oct 2020 09:21:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009281612.EDC1C0078@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/20 5:13 PM, Kees Cook wrote:
> On Mon, Sep 28, 2020 at 04:41:47PM -0600, Shuah Khan wrote:
>> On 9/26/20 10:29 AM, Kees Cook wrote:
>>> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>>>>      7. Verified that the test module compiles in kunit env. and test
>>>>         module can be loaded to run the test.
>>>
>>> I meant write it using KUnit interfaces (e.g. KUNIT_EXPECT*(),
>>> kunit_test_suite(), etc):
>>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/
>>>
>>> Though I see the docs are still not updated[1] to reflect the Kconfig
>>> (CONFIG_foo_KUNIT_TEST) and file naming conventions (foo_kunit.c).
>>>
>>
>> I would like to be able to run this test outside Kunit env., hence the
>> choice to go with a module and kselftest script. It makes it easier to
>> test as part of my workflow as opposed to doing a kunit and build and
>> running it that way.
> 
> It does -- you just load it normally like before and it prints out
> everything just fine. This is how I use the lib/test_user_copy.c and
> lib/test_overflow.c before/after their conversions.
> 

I am not seeing any kunit links to either of these tests. I find the
lib/test_overflow.c very hard to read.

I am going to stick with what I have for now and handle conversion
later.

I think it might be a good idea to add tests for atomic_t and refcount_t
APIS as well at some point.

thanks,
-- Shuah
