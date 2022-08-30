Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A185A66E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiH3PGn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 11:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiH3PGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 11:06:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1711F8253;
        Tue, 30 Aug 2022 08:06:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8239763otd.12;
        Tue, 30 Aug 2022 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gt+RROWjrFTvnGIzrdFJlgohvyJs9kgN8mfi4g5sjLY=;
        b=KsbI0LO23gbP/mSXaUQH9jUeFxXYva/2H3vog4iwAP4IIjCB4J35cIX7gYZtnmhQDJ
         EFl7G9BuvBH49fzNShnkRCqEBomJ7Zw8zRO/2tMWBZWYNvCTJx+6aU3gJoFiC2nAk1aJ
         YOrqB47zAjF+KZ1z+ps7/nW0QBiymeWgWJZP9VhY+njmyg2n12kJYB+hTjBkaHPt92Pa
         txNOF0KEGVVDbkGqDmhunhpSeUo53aAAlVF/C03MsLwl6ceRMU6WCd5EgpAjGdgL73y6
         feBPy8nLhEx3Q3EHNJmy4nYjimSQc0iJxuv4ZyFafXzmMaGaQb0s6ZtVa9PF4j/oPLg4
         Fn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gt+RROWjrFTvnGIzrdFJlgohvyJs9kgN8mfi4g5sjLY=;
        b=JhqpSMf6TwqSVv7r4cE/UysQONED0ETlVklthAX5VbaCwq1p8KAFag0nlCYfO/J+jC
         tjp7wngcG0E7r9vOPFxPACdllWAgiPF++0O99+GdC46681dODxIuUIailfV0PeMaRtQI
         DeielEyFbv7g1b7eavnU+TkvvKC1j8ACnlRonsudMmvwzBGItOrOzLRss7Bb+nnUmepd
         ts+n9fkyZHAz752UKAV7gvhhB6UQNXWqM1A0GaTNG4y1xb3R4XVAPVotcb3K3oN1otmF
         mQ8Lj1YXsV9VERsy//tJCD4mNc91ip0Pz+I5yMoKkQLqjRerF7He4A0kT+juSeYkKZUq
         NvcA==
X-Gm-Message-State: ACgBeo1pTEmWj4NeUBV6HHZU+UCm1o01Z/deQ/dHOappieJGKswxJ6Cl
        0oxl8N9vwcmOtxyET7nWvSY=
X-Google-Smtp-Source: AA6agR4V3i5veWa9xUNov7g55L9EWkzjWJEl1kdk8Kv37gBFlkHvtqZ7WU+JOUqs/HbiwuvgZ7Q/ng==
X-Received: by 2002:a9d:c45:0:b0:636:fd89:7ed8 with SMTP id 63-20020a9d0c45000000b00636fd897ed8mr8638229otr.284.1661871997922;
        Tue, 30 Aug 2022 08:06:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1485:e42c:9c81:f760? ([2600:1700:2442:6db0:1485:e42c:9c81:f760])
        by smtp.gmail.com with ESMTPSA id k11-20020a0568301beb00b0063b2251a78asm5449861otb.12.2022.08.30.08.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:06:37 -0700 (PDT)
Message-ID: <ceab750d-c107-9273-3718-9632085362b3@gmail.com>
Date:   Tue, 30 Aug 2022 10:06:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP
 specification
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829233150.3564612-1-frowand.list@gmail.com>
 <20220829233150.3564612-2-frowand.list@gmail.com>
 <Yw4InUF5TpR/wdwb@casper.infradead.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <Yw4InUF5TpR/wdwb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/22 07:54, Matthew Wilcox wrote:
> On Mon, Aug 29, 2022 at 06:31:49PM -0500, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Prepare KTAP Specification for the process of creating version 2.
>>
>> The version will remain "2-rc" until the final commit to complete
>> Version 2.  Adding the "-rc" ensures that none of the development
>> versions will be mistaken for the completed version 2.
>>
>> After this commit, Sphinx complains that we now need more '=' signs:
>>
>>   Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
>>   ===================================================
>>   The Kernel Test Anything Protocol (KTAP), version 2-rc
>>   ===================================================
> 
> Hey Frank, you can actually use overlength lines to prevent this kind of
> problem from occurring.  eg, this is perfectly acceptable:
> 
> ===================================================================
> Hi
> ===================================================================
> 
> I wonder if we should prefer this style to avoid the rash of complaints
> when a headline is changed.

Thanks, that is useful to know.  I think it might be a good idea to
switch to the longer style at some point before the final version 2
release.

-Frank
