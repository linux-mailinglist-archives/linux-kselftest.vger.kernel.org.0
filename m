Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E65031C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiDOWHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 18:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356334AbiDOWHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 18:07:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D212AE19
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 15:05:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so8054284plg.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5Yc5nA+eIwNnXR+6RY73UVvrs0acLFxzlFm0011Wj4Q=;
        b=GOEHAkdFgn9QOei6MdAgQC92tVEgXroUcbg63n3wmAsUPvCNyg+f063VbelURjh0zl
         od4B7AuhFslcEzREFHIZcwPCdbscFjRqME27P2BHp4y4yODqgkDQl1QOC1EDKSonR8Dz
         70zAsRsjeupcsoqcYM4MSTySgWoYmiuysroPKQ/E4+zFc2YOYFDW8e3U+HeR+arBJ4KA
         En0tErQzhFF/AzOCOs8vJWk9plBFrw9uP+uC4zTAAwvUZwj7Bkf1SBN/5PlQitcXoVq0
         4VHKi9QH6mEwQ/OF/kZg3RyjM7l9is3/mpv2WEKBnAmn3fpVr+YVfadC0vd7YTsGicXp
         DL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5Yc5nA+eIwNnXR+6RY73UVvrs0acLFxzlFm0011Wj4Q=;
        b=RqmCFd+SPguZFQ/VwYl+yOQEuT4lVudAguIJuR0k2WwNLuCOuSk8hnYXRVDmv/wRCn
         Cc3ojBqNF42avRRt9s6xaxJyF9/pql3Dnioa9SmqvrXcRq40bfvW2JP/YWspXkB3+yiJ
         KxLc9mhg0SAB7v+5W4D8OvFmJpjX6mfzvNe2zq4DeCQxj2CegpOhw4motk0cn8MZJGTd
         EO+9cFrw2K+hB+F2nvSHVaYOVLeQ4YLs7HrwOXu/krJ355VV41E8Tn1c/vr544OzsPA1
         DQrpfJRFX37go3NButrLKT9cml1+mTgR0pEsDG9WnHdGEMWH/VZRF2e5E7VWcGALOee0
         SjHg==
X-Gm-Message-State: AOAM5306P+ThZgdgwpyevDv5RAnBrJk8DVt3NfM8X9HbjGZeCQgujZTR
        AIHz91cSlnu+OShnKH4r4MapbA==
X-Google-Smtp-Source: ABdhPJymHzAKAPcA7VasP8sK/FN9gCsLPObTHs7vIpSosIttcWoPBrVUO9HJiyZwdRScBTzFV5IPGg==
X-Received: by 2002:a17:902:7088:b0:156:1aa9:79eb with SMTP id z8-20020a170902708800b001561aa979ebmr974760plk.71.1650060302439;
        Fri, 15 Apr 2022 15:05:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:2d:3:51d5:33b1:431b:be0? ([2620:15c:2d:3:51d5:33b1:431b:be0])
        by smtp.gmail.com with ESMTPSA id v1-20020a62c301000000b00505bc0b970dsm3811701pfg.178.2022.04.15.15.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 15:05:02 -0700 (PDT)
Message-ID: <96ea015d-7d95-a214-5e46-85015975e7d0@google.com>
Date:   Fri, 15 Apr 2022 15:05:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/2] kunit: Expose 'static stub' API to redirect
 functions
Content-Language: en-US
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Fradley <joefradley@google.com>
References: <20220318021314.3225240-1-davidgow@google.com>
 <20220318021314.3225240-2-davidgow@google.com>
 <CAFd5g46zjsrz16mYmu1Q57dYkch6J2FO1XkM9XwS=cWiUidz6g@mail.gmail.com>
From:   Steve Muckle <smuckle@google.com>
In-Reply-To: <CAFd5g46zjsrz16mYmu1Q57dYkch6J2FO1XkM9XwS=cWiUidz6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/4/22 13:16, Brendan Higgins wrote:
> On Thu, Mar 17, 2022 at 10:13 PM David Gow <davidgow@google.com> wrote:
>> +/**
>> + * KUNIT_STATIC_STUB_REDIRECT() - call a replacement 'static stub' if one exists
>> + * @real_fn_name: The name of this function (as an identifier, not a string)
>> + * @args: All of the arguments passed to this function
>> + *
>> + * This is a function prologue which is used to allow calls to the current
>> + * function to be redirected by a KUnit test. KUnit tests can call
>> + * kunit_activate_static_stub() to pass a replacement function in. The
>> + * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
>> + * will then return from the function. If the caller is not in a KUnit context,
>> + * the function will continue execution as normal.
>> + *
>> + * Example:
>> + *
>> + * .. code-block:: c
>> + *     int real_func(int n)
>> + *     {
>> + *             KUNIT_STATIC_STUB_REDIRECT(real_func, n);

I wish there was a way to avoid having to repeat the function's name and 
arguments here...
