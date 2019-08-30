Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055B2A3C43
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3Qkr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:40:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfH3Qkr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A347F344;
        Fri, 30 Aug 2019 09:40:46 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5C73F718;
        Fri, 30 Aug 2019 09:40:45 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Add arm64/signal initial kselftest support
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190813162254.GX10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <b4c9cb22-6e08-8096-addb-4ac267fc0a84@arm.com>
Date:   Fri, 30 Aug 2019 17:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162254.GX10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 13/08/2019 17:22, Dave Martin wrote:
> On Fri, Aug 02, 2019 at 06:02:49PM +0100, Cristian Marussi wrote:
>> Hi
>>
>> this patchset aims to add the initial arch-specific arm64 support to
>> kselftest starting with signals-related test-cases.
>> A common internal test-case layout is proposed which then it is anyway
>> wired-up to the toplevel kselftest Makefile, so that it should be possible
>> at the end to run it on an arm64 target in the usual way with KSFT.
> 
> The tests look like a reasonable base overall and something that we can
> extend later as needed.
> 
> There are various minor things that need attention -- see my comments on
> the individual patches.  Apart for some things that can be factored out,
> I don't think any of it involves redesign.
> 
> 
> A few general comments:
> 
>  * Please wrap all commit messages to <= 75 chars, and follow the other
>    guidelines about commit messages in
>    Documentation/process/submitting-patches.rst).
> 
>  * Remember to run scripts/checkpatch.pl on your patches.  Currently
>    various issues are reported: they should mostly be trivial to fix.
>    checkpatch does report some false positives, but most of the warnings
>    I see look relevant.
> 

Thanks for the review. I addressed latest issues in V4, published now.

I kept tests verbose (outputting to stderr) as of now.
Removed as a whole standalone build/run.

Thanks

Cristian

>  * If you like, you can add an Author: line alongside the copyright
>    notice in new files that you create.  (You'll see this elsewhere in
>    the kernel if you grep.)
> 
> One general stylistic issue (IMHO):
> 
>  * Try to avoid inventing names for things that have no established
>    name (for example "magic0" to mean "magic number 0").
> 
>    The risk is that the reader wastes time grepping for the definition,
>    when really the text should be read at face value.  It's best to use
>    all caps just for #define names, abbreviations, and other things
>    that are customarily capitalised (like "CPU" etc.).  Other words
>    containing underscores may resemble variable / function names, and
>    may cause confusion of there is no actual variable or function with
>    that name.
> 
>    I don't think it's worth heavily reworking the patches for this, but
>    it's something to bear in mind.
> 
> [...]
> 
> Cheers
> ---Dave
> 

