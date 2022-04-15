Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD945030FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 01:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356155AbiDOVrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356182AbiDOVps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 17:45:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC649C8B
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 14:43:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso9215550pjf.5
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zQtVzR+qX7thidCkrKxZWal2lu7IMO3a3sTmsXDOSnA=;
        b=EVnLlP5HvcQ7mfMWcKBySfBzKktk4RuTNYJFYZGC7GP2b6ckxKgNRBH4W6ma4vs/9d
         5ARTSlkDusrXNDfgVpN9vPEMuSy1WevbRS4d78goN03mGRJ2DvOE+UkehyNBAEsC4qZs
         m82DsvDgvdTXKFjUNU1v0BWZnpfCZm7ixqKm6+RehaHI3auKeorhGY77XOPvnT8q/1id
         WbyzxnyImFI+ry+t+EGs9zqk4ZOvldQEqvOF05n0udZ8/TmSYW96FvHzC2Kz5N9vdPeh
         a8xY42Zdv6fvx1ZIePEdVNUoNRe39dXN60QhRCX/hd7NHgUABc5qJttmp0NiRCYEMnv1
         N4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zQtVzR+qX7thidCkrKxZWal2lu7IMO3a3sTmsXDOSnA=;
        b=xPaghMWmvU2OKnF9oJ3INRQJyy/y3GsLj3GvR8K1Y3Ptd4n5lck2AAe8fuVQrmpKd/
         iAaAJrhc8TZ1L5BJ0UERMO+YpqgZDbkcOuyCJFK4EIR+U7+GM5cFqpo5LMKExjgjTz6L
         AeL2izvdJddej4YwEv+PJWwcaSCFPJbEILz6dG4dvNAl9CK95G19wKybuvjGh7ia22UM
         p5EsFvW/VB5ZROH1MdcP826681Br/UW7wv7u0FKps82z/wuZbt41XJT5u2t/HpijwhIn
         MThz8qsAEV8pAEGgeD+mfsFiuAz+GslQZwa8WH5Get3GIPXo2PSn6mQoR8KkftcnaChI
         kZjg==
X-Gm-Message-State: AOAM532p5tk3RJaSOMsAeRlA8SgCZERCyCUZID5Nbodi2tXRsktGrX1f
        b6teMC2uXb2veT4+u9RWt2u3Ag==
X-Google-Smtp-Source: ABdhPJyypS0vPqvwlpeOutgmScic8LUDanAQL6k5AZV9O6DDA/v4X8rx3sJTxfjHxTTTJ81aWvL7HQ==
X-Received: by 2002:a17:903:12c1:b0:158:ad00:60e with SMTP id io1-20020a17090312c100b00158ad00060emr940315plb.62.1650058997479;
        Fri, 15 Apr 2022 14:43:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:2d:3:51d5:33b1:431b:be0? ([2620:15c:2d:3:51d5:33b1:431b:be0])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a001c6300b00505ff320d97sm3980753pfw.91.2022.04.15.14.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:43:17 -0700 (PDT)
Message-ID: <f65c2381-1e9c-5945-7672-848d1826532d@google.com>
Date:   Fri, 15 Apr 2022 14:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
Content-Language: en-US
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20220318021314.3225240-1-davidgow@google.com>
 <20220318092159.6f275782@gandalf.local.home>
 <CAFd5g461Poh37o=3m6EXppdX7oS0D5vZxvFAEtzJMwtBD1VJEw@mail.gmail.com>
From:   Steve Muckle <smuckle@google.com>
In-Reply-To: <CAFd5g461Poh37o=3m6EXppdX7oS0D5vZxvFAEtzJMwtBD1VJEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/4/22 13:13, Brendan Higgins wrote:
> On Fri, Mar 18, 2022 at 9:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Fri, 18 Mar 2022 10:13:12 +0800
>> David Gow <davidgow@google.com> wrote:
>>
>>> Does either (or both) of these features sound useful, and is this
>>> sort-of API the right model? (Personally, I think there's a reasonable
>>> scope for both.) Is anything obviously missing or wrong? Do the names,
>>> descriptions etc. make any sense?
>>
>> Obviously I'm biased toward the ftrace solution ;-)
> 
> Personally, I like providing both - as long as we can keep the
> interface the same.
> 
> Ftrace is less visually invasive, but it is also less flexible in
> capabilities, and requires substantial work to support on new
> architectures.

The general feature looks useful to me. I'm not sure the ftrace based 
API is worth it given it is only offering a visual improvement and has 
some drawbacks compared to the other implementation (won't work with 
inline functions, dependencies on other features). Livepatch is absent 
on arm64 which mostly rules it out for my purposes (Android Generic 
Kernel Image testing).

cheers,
Steve
