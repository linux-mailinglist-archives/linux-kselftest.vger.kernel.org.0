Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3E50C4E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiDVXec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 19:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiDVXeQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 19:34:16 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC40CFB8A;
        Fri, 22 Apr 2022 16:16:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id dw17so7170013qvb.9;
        Fri, 22 Apr 2022 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XILRaenKA+ux+cNfTMsUP27EqkAzqma1HpXDmAsliJU=;
        b=q4ASX2mCJbEKW71AjFTChyikd7lizEo2iA3qJlcg0DC6Vlw1btKxB6yccbdtxkXb4X
         Db9UG7qM8BZ1rAVqTsLpS6ZM/T/iV8QMGEj0q8QiY+sGOE+dVx1frERw0kVy+AJqorQg
         s8Iuf3W+ac1VRxMys/drqYh2D+SPm1GH/tyQjWlSIauPL17Uiy/0V/c9wfMTaqUdoGsT
         WFvHvZPYTHqbWDuQJ+0OKtbUoBmGFoYaWz1ypaDvKhlysdSBSTIo40xKFD2DpzqOR+DF
         C/X6zTEHrxxGr8AmC5SFceeCfPb3a6gY1wQP3EwHPEaqL4dLbJUrgGSGQRdErjC0VT8S
         e4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XILRaenKA+ux+cNfTMsUP27EqkAzqma1HpXDmAsliJU=;
        b=jiZ7nH6Y9jTZ6zuRMoIqx6KgUw5J8hBR3X9aqIHriI8mZVjcobBAfPrW8Dow2DvGR1
         lOgojG5Jk3fhVWbrtT/FYX2m7TslwaTyBi/JBDgklZNuYxUayDRG48duBDdKDW/uuqpn
         Jb4qNQNjUS/oo4n3i+nVHhe4LQL34lvJfRLvFssUNoFoF/7Lnrb1LH0ekbflGkeVxO/y
         kuw5Hq04VVEMWbwlCaJHIG33/bAajUR9jbIGjrQaL+TpFV0HByhnrB6rv/rOAhe5z3Ho
         M4HEjzBdpgDqh72H6eMdA3yHm0CBJNhcSwG2TXdG8DfWbQVHgLkI6JJNDl1fbnowFGof
         7ppA==
X-Gm-Message-State: AOAM5339iYL0oJahld7CWLHeZNoFMg/PJzmjuVnTRoAdfrvTz+SAsWUj
        9Cx991TUqd3DaECJpVBq0pA=
X-Google-Smtp-Source: ABdhPJxFt2jKcJwJdocNdwtDGsiOwWYIQci+16+7XrfNQBgQ3LsJ36wNBfZ94jEqfR5MQKKIegZk4w==
X-Received: by 2002:ad4:5d69:0:b0:446:3d44:2fbe with SMTP id fn9-20020ad45d69000000b004463d442fbemr5382416qvb.16.1650669414771;
        Fri, 22 Apr 2022 16:16:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:98a4:ff1d:3bb2:5350? ([2600:1700:2442:6db0:98a4:ff1d:3bb2:5350])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a0d5400b0069c71a71ed3sm1489737qkl.33.2022.04.22.16.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 16:16:54 -0700 (PDT)
Message-ID: <37465a0f-7deb-bedb-1a84-90324f554ad1@gmail.com>
Date:   Fri, 22 Apr 2022 18:16:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/2] Documentation: dev-tools: begin KTAP spec v2
 process
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220316202622.324866-1-frowand.list@gmail.com>
 <CABVgOSmkvxhHSJx0W6BEYz=Ai9vB=nCz625dSKLLUfU0rMLkFA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CABVgOSmkvxhHSJx0W6BEYz=Ai9vB=nCz625dSKLLUfU0rMLkFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/17/22 03:42, David Gow wrote:
> On Thu, Mar 17, 2022 at 4:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> An August 2021 RFC patch [1] to create the KTAP Specification resulted in
>> some discussion of possible items to add to the specification.
>> The conversation ended without completing the document.
>>
>> Progress resumed with a December 2021 RFC patch [2] to add a KTAP
>> Specification file (Version 1) to the Linux kernel.  Many of the
>> suggestions from the August 2021 discussion were not included in
>> Version 1.  This patch series is intended to revisit some of the
>> suggestions from the August 2021 discussion.
> 
> Thanks for kicking this off again. There were definitely a lot of good
> ideas in those threads which we haven't got to yet.
> 
> I think there is an interesting line to walk between keeping KTAP
> sufficiently "TAP-like" (particularly w/r/t being able to reuse
> existing TAP parsers), and actually adding features, but I don't
> recall seeing many such issues in the previous threads.
> 
>>
>> Patch 1 changes the Specification version to "2-rc" to indicate
>> that following patches are not yet accepted into a final version 2.
> 
> I'm okay with this, though I'd want us to be a little careful with the
> timing so we don't end up with, for example, 5.18 having a KTAP spec
> called 2-rc which is functionally indistinguishable from v1.

I finally have some time to return to this.

I could host a branch on my kernel.org "frowand" linux kernel.  When
agreement is reached on a patch on this mail list, I would add it
to the branch.  When the discussion determines that it is time to
release a version 2 of the specification I would add one more commit
that only updates the version.

Does that sound like a good way to proceed?

> 
>>
>> Patch 2 is an example of a simple change to the Specification.  The
>> change does not change the content of the Specification, but updates
>> a formatting directive as suggested by the Documentation maintainer.
> 
> Thanks -- personally, I'd rather this change _does_ go in straight
> away, even before the 2-rc renaming.
> 
>> I intend to take some specific suggestions from the August 2021
>> discussion to create stand-alone RFC patches to the Specification
>> instead of adding them as additional patches in this series.  The
>> intent is to focus discussion on a single area of the Specification
>> in each patch email thread.
> 
> Seems like a sensible way to structure the discussion. It could get a
> little bit messy if there end up being merge conflicts, but the whole
> thing could be collapsed into a single patchset later if that ended up
> making more sense. (Though that might remove the need for the "rc"
> version, depending on exactly when and how it happened.)

Yes, if I host a branch then no need for the preliminary rc version.

> 
> I'd also be curious to see patches to tests and/or test parsers to
> show off any particularly compatibility-breaking and/or interesting
> changes, though I don't think that _has_ to be a prerequisite for
> discussion or the spec.

That is a good suggestion.

-Frank

> 
>>
>> [1] https://lore.kernel.org/r/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com
>> [2] https://lore.kernel.org/r/20211207190251.18426-1-davidgow@google.com
>>
>> Frank Rowand (2):
>>   Documentation: dev-tools: KTAP spec change version to 2-rc
>>   Documentation: dev-tools: use literal block instead of code-block
>>
>>  Documentation/dev-tools/ktap.rst | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>
> 
> Cheers,
> -- David

