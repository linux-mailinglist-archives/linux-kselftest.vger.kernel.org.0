Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E859F2A9462
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 11:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgKFKbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 05:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFKbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 05:31:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A43C0613CF
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 02:31:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so849862wmd.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M1+FhL1Hdj59VRzZdZhioMqeWvhNPbEdiUD7VULxQQU=;
        b=M/JE0jWWrCdwzcZCXwIZD3eRRKTYy/8g8OKV0ZKDif3qphFlkO2H5JyC59iyuMtxNE
         Nu/yOa22/Toc1SAzQWEzm3poObF9hJw+XoFLePpHjoYvGPXXFpqYtwwf18kuAxDWyZzI
         3KPHLXLwiikOSMubcfovBClQGtt9xnFGPPeyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M1+FhL1Hdj59VRzZdZhioMqeWvhNPbEdiUD7VULxQQU=;
        b=QL6TT0uBH9dhkwG6FLuALrtGX2vNq7qfhFO0bWrG39FMdDv8sf1u7EYwdAtJaNWoNS
         T03yz9R9S4a516ZJ5bCZmESqtJhcTj6IqtBCTJMn7Tl+3PMMsoqNtJ33PwYcot0YF7kX
         R5zuSP21mTQ7UP3CzEP+nnh28a74twNCgOhLQqqOIvqWFyjph166S/mP/5pk/0j4/lK+
         xcNRxKFx5XL3qrYqkpVRRRKfEg8vrphLeUR11TMnhlN3H6846Xwwl4j34oEE1MSHwRyE
         sJavRw29kiLAzdA99mwMQPnxBYxcAc6DL7AeFk1lE9mUsfhla9YhmeD6MbuMMfpp3Ik/
         nUsg==
X-Gm-Message-State: AOAM531mCz9fFZyya9O8RM24r3KWc19Fke8Za8S7zJAHS6ZBxN1bLxEc
        W+FJgOX6r48qMvxrnHLJJUOLEg==
X-Google-Smtp-Source: ABdhPJzurZkBLjeRcDX+srfxJ/ab/V528S8yjKu3GWSmBaPWEbZPW7e13Q8ol2knWYcGMw1McbppEg==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr1631220wma.126.1604658705755;
        Fri, 06 Nov 2020 02:31:45 -0800 (PST)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t74sm1652566wmt.8.2020.11.06.02.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:31:44 -0800 (PST)
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        alexandre.belloni@bootlin.com, rdunlap@infradead.org,
        idryomov@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com> <20201103160728.GQ20201@alley>
 <57976ff4-7845-d721-ced1-1fe439000a9b@rasmusvillemoes.dk>
 <b24a8200-b456-ecab-cc60-6f4ff10baa5d@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1b452380-53a5-f396-bf2f-97736db28afb@rasmusvillemoes.dk>
Date:   Fri, 6 Nov 2020 11:31:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b24a8200-b456-ecab-cc60-6f4ff10baa5d@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/11/2020 05.04, Arpitha Raghunandan wrote:
> 
> The total number of "atoms" can be printed by maintaining a static variable
> total_count that can be incremented as is in the original test_printf test.
> But, the reporting of the random seed currently is done in kselftest and so
> will not show up with KUnit. I am not really sure which is better in this case.

So my real questions are: Why do we have both kselftest and kunit?
What's the difference? Are there any plans to merge the two frameworks?
What's the point of converting from one to the other if not? And if one
is to take a currently stand-alone ad hoc test module and place it under
one of those umbrellas, which one should one choose?

I don't really care if the "deterministic random testing" prep work goes
with kstm or kunit; whichever framework could provide that boilerplate
is the framework I'd make sure to use for subsequent work on various tests.

The reporting of the number of "atoms" in the printf test suite is
something I'd miss if not preserved, but if there's sufficient good
rationale for doing the conversion to Kunit I could live with that. But
if kunit then can't provide a per-test-module rnd_state and handle its
seeding (and reporting of what seed was used), I won't ack the conversion.

Rasmus
