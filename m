Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6456C371
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiGHVYr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiGHVYq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 17:24:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB15923BF9
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 14:24:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h200so136669iof.9
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42cZlLqESbSzGOIQC6IhKSPqgo/QyLTrwwAMCp9WNzo=;
        b=IV0paG90JHXaGZbrxl8pRjANIsQWCXppiwcKYlmXVIxXcJ27wNUF4yH2g+6tA4C+qd
         mamfHwnW/lcS3+Uv/gPQPJf5q/UUMz6XSShpn+/NkJMb/c/gai50uarqyLdYdTFa7a08
         wnNNt2hidpsVCeeD1GYrXUswLcElFqWYI67m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42cZlLqESbSzGOIQC6IhKSPqgo/QyLTrwwAMCp9WNzo=;
        b=ovhaplXsUba/jGxEupIkQ5rqE15q+Lnoiw/xWhxJAwHXfv5RJAQR/3gtuZSGVGKqJg
         KjuG7iXqwGUbsuXkFZN/NH8vOGk5igOZFYkfsnXjt+KStnFIcVe6dyjj+C6XYwBBdftv
         /wX9K/90Hxk04kEYY7Fh5pYHfkdFz1uibljDMJBK1/gfGSEevojk1p3gYBRlaidI/J4R
         +O29F53ThsNvBcyBa3BU+7pcoYA07JJUaj9MNvWMylfbyJEA2TnCUofkMGTvhhN7uqBX
         A2SRY7o7RfsVwjpTgJbZIslbF4sxWwQfCmUsGJRV0vioP0imLxeSHyXuOsyzv9SBtHLA
         xqRg==
X-Gm-Message-State: AJIora+iPKY9tkXcPOTm1y711dLezSJF/47ps0CBhmHG1YNyU76bkSNX
        f+wcRmogihv5teuW84sAJC+F1A==
X-Google-Smtp-Source: AGRyM1sZRJgZl+2OfYXRBrVXka293FsGfZm0I0q0MCwgNYiktkDFQ9OSDQ5BXDPGzW4St1/3aCUuqA==
X-Received: by 2002:a05:6638:438b:b0:33c:b617:fb46 with SMTP id bo11-20020a056638438b00b0033cb617fb46mr3370276jab.238.1657315483051;
        Fri, 08 Jul 2022 14:24:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a13-20020a927f0d000000b002d8f50441absm16814624ild.10.2022.07.08.14.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 14:24:42 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220708044847.531566-1-davidgow@google.com>
 <20220708044847.531566-3-davidgow@google.com>
 <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
 <CAGS_qxpODhSEs_sMm5Gu55EsYy-M9V98eLU-8O+xGMxncXmY4A@mail.gmail.com>
 <f25f96ce-1c9b-7e66-a5be-96d7cf2988cf@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a00efaa8-71e0-c531-b6a4-e3d695ad628b@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 15:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f25f96ce-1c9b-7e66-a5be-96d7cf2988cf@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/8/22 3:22 PM, Shuah Khan wrote:
> On 7/8/22 3:00 PM, Daniel Latypov wrote:
>> On Fri, Jul 8, 2022 at 1:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> On 7/7/22 10:48 PM, David Gow wrote:
>>>> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
>>>> Due to KUnit tests not being intended to run on production systems, and
>>>> potentially causing problems (or security issues like leaking kernel
>>>> addresses), the kernel's state should not be considered safe for
>>>> production use after KUnit tests are run.
>>>>
>>>> This both marks KUnit modules as test modules using MODULE_INFO() and
>>>> manually taints the kernel when tests are run (which catches builtin
>>>> tests).
>>>>
>>>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>>>> Tested-by: Daniel Latypov <dlatypov@google.com>
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>> Signed-off-by: David Gow <davidgow@google.com>
>>>> ---
>>>>
>>>> No changes since v5:
>>>> https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/
>>>>
>>>> No changes since v4:
>>>> https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/
>>>>
>>>
>>> David, Brendan, Andrew,
>>>
>>> Just confirming the status of these patches. I applied v4 1/3 and v4 3/4
>>> to linux-kselftest kunit for 5.20-rc1.
>>> I am seeing v5 and v6 now. Andrew applied v5 looks like. Would you like
>>> me to drop the two I applied? Do we have to refresh with v6?
>>
>> Just noting here that there'll be a merge conflict between this patch
>> (3/4) and some other patches lined up to go through the kunit tree:
>> https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/
>>
>> Not sure how we want to handle that.
>>
> 
> I can go drop the two patches and have Andrew carry the series through
> mm tree.
> 

Sorry spoke too soon. Yes there are others that might have conflicts as
Daniel pointed out:

https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/

thanks,
-- Shuah

