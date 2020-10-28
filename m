Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD029D62F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgJ1WLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgJ1WLu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13FC0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wdyb7qRuLjR6s6XwwT89tkhrLT43vXhm0ixZ6vQNaB8=; b=hp0ozUsPB0Fw0gJZivtfAYk/bf
        B3KQahTA80SGKkWIi0hizERQVDna+C8kieHsEy5H+ZmnPW21mAy6mbkJoUGlMXk6ACxJDftsb6i72
        LiKErYWinHPh0kJeJLhA7IA7FoE/cq1oKWV/cIJyELTLtXm1XGg8nEt9miOxHuJvD1tNor6oajeI4
        5+nZ0oTtfnVjFCQAEo7N3e8ysg2bp1V1Et7ryebPWpkJfhdgKiOc/rOjXjl7/U3tD+S/hXYcuphfM
        34hn8ghQSFdXtHknDES69h1fSYRe6pzzjLDcWJnObIRtAvGoFUPMiVh2Q71UGv0b2JsGcHc50v7Lk
        Shzlo54A==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXe4V-0001wK-41; Wed, 28 Oct 2020 05:32:31 +0000
Subject: Re: [PATCH] KUnit: Docs: style: fix some Kconfig example issues
To:     David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20201027184909.20881-1-rdunlap@infradead.org>
 <CABVgOSmtTK=V8EFL8KTmN+e+pP6HKZQo+LMsmqG3PnxuhFtZ9A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <07963645-1644-53c2-b1da-8f89fe865eda@infradead.org>
Date:   Tue, 27 Oct 2020 22:32:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSmtTK=V8EFL8KTmN+e+pP6HKZQo+LMsmqG3PnxuhFtZ9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/27/20 8:00 PM, David Gow wrote:
> On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix the Kconfig example to be closer to Kconfig coding style.
>> (Except that it still uses spaces instead of tabs for indentation;
>> I guess that Sphinx wants it that way.)
>>
>> Also add punctuation and a trailing slash ('/') to a sub-directory
>> name -- this is how the text mostly appears in other Kconfig files.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: David Gow <davidgow@google.com>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: kunit-dev@googlegroups.com
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> ---
> 
> Thanks for fixing this!
> 
> For what it's worth, I _think_ we could get away with tabs for
> indentation in the file without Sphinx actually complaining, but it
> does annoy some of the editors, and as far as I can tell, Sphinx
> converts them back to spaces in its output. I'm far from an expert,
> though...
> 
> Regardless, this is:
> 
> Reviewed-by: David Gow <davidgow@google.com>

I tested with tabs for indentation and it's no problem with Sphinx.
Some editors care?  I am surprised.  and don't much care.

I would be happy to submit a v2 using tabs for indentation.

thanks.
-- 
~Randy
