Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481104EFF2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiDBG1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Apr 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBG1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Apr 2022 02:27:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E01A61E2;
        Fri,  1 Apr 2022 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3/eAlUSKNeuyto+OqATxwA7fPEqfTlSEsY0k898No9g=; b=kYdgkgSXPhG28/+ZJKZiRlpPm6
        74MbM/JrXRMX4bl0Brhe4U6rTRydE7bUNMhDyi8nEW360vr85ClBGt6HnWhjOS1kegy7NB4i5fbph
        yeqVt78azp21+RlhWSUAHq46Ldg/P8+53PnrTAdWeXDE8huPQC9VJMWlQQOpitVyXOjyId5DDhfT/
        c8B9Kj9/FPWebTZgWs3OHgXoLkX3KKn1wDePSv4vM62qdTXJaXUbZfWnyXvSII05SIeGXREFkRwy/
        Nrr1lSaBGHx7UPiutfjW8mOjTN571OTae4XgB01D4+IRvYW2lBk6GnzyCP7KCAEdzTSfpu9OR2tG9
        7G9mH1gw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naXC4-000m9U-6B; Sat, 02 Apr 2022 06:25:05 +0000
Message-ID: <87010ada-86a2-4fb4-7ffd-8db1b656598d@infradead.org>
Date:   Fri, 1 Apr 2022 23:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
References: <20220401024707.10550-1-rdunlap@infradead.org>
 <CABVgOSk-8O9jLZncbJvsZdTaA9VjBKbByktnwhPCNJHWME2Nug@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABVgOSk-8O9jLZncbJvsZdTaA9VjBKbByktnwhPCNJHWME2Nug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On 3/31/22 23:26, David Gow wrote:
> On Fri, Apr 1, 2022 at 10:47 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix Sphinx complaints about code-block directive missing an argument.
>> For start.rst, add "none" since that is already heavily used in that
>> file. For run_wrapper.rst, use the simpler "::" literal block instead.
>>
>> dev-tools/kunit/start.rst:83: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>>
>> dev-tools/kunit/run_wrapper.rst:17: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:23: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:31: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:51: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:57: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:78: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:85: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:109: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:116: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:124: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:139: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>> dev-tools/kunit/run_wrapper.rst:162: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>>
>> Fixes: c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")
>> Fixes: 46201d47d6c4 ("Documentation: kunit: Reorganize documentation related to running tests")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: kunit-dev@googlegroups.com
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Harinder Singh <sharinder@google.com>
>> Cc: Tim Bird <tim.bird@sony.com>
>> ---
> 
> Thanks for fixing these.
> 
> Out of curiosity, is there a particular config option or version you
> need to set in sphinx to get these warnings? My setup (with Sphinx
> 4.3.2) doesn't warn on this.

No options. I expect that it's just an older version of Sphinx that
is causing this. I have v1.8.5 installed (comes with OpenSUSE Leap 15.3).

> Nevertheless, I'll keep a closer eye on code-block directives in future.
> 
> Reviewed-by: David Gow <davidgow@google.com>

thanks.
-- 
~Randy
