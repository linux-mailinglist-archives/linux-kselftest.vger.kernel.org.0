Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE320A1DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbgFYPZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404580AbgFYPZD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 11:25:03 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC6C08C5C1;
        Thu, 25 Jun 2020 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=a41XB4ki3PuYJQxiFFnzrHyY1AyEU1gPv8dZhWlqlVY=; b=eSELIPPNsSumTimsYPTmKeR7ZN
        jV/xic9+V1i/7NJXxJTLl3lYOzhJYxf3yeQj++FQ4xJnHkhQgR7MG6fqygrSTNVuSPExtlyBmeSE8
        +m5+QTxCO5Olmc/l8CDg4oUcbiVLeInVPtPEvfIES2m+c34WXa8EMvUYnVsLTPxbIPlfbBOLb6+4A
        pBN72PGJTRbsiyUx6MWqHL2ipW5pQ4HABbrXOkDNLgtIxWy+ncD8r4JO/sMsnrwy8Mo3JRK3oeFVG
        LhqqJ62B3FH5js+0WwsQGgbuP4oWfg8ncRREqJqV6ztb4kE7X1TQ4iX3Cu5+TSVLpCiFbfRHHzvFj
        9XlrEINg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joTk4-0003Hw-5Y; Thu, 25 Jun 2020 15:24:44 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
To:     Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006241335.2C0FB5DF90@keescook>
 <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
 <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com>
 <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org>
 <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org>
 <80f501f4-d4fb-1f22-5603-57b5490a695d@infradead.org>
 <202006242300.145D555@keescook>
 <1916262186.58280.1593066248850.JavaMail.zimbra@nod.at>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <65cfbfa8-bbfe-e0d3-0255-cd3550ff09c8@infradead.org>
Date:   Thu, 25 Jun 2020 08:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1916262186.58280.1593066248850.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/20 11:24 PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Kees Cook" <keescook@chromium.org>
>> An: "Randy Dunlap" <rdunlap@infradead.org>
>> CC: "Richard Weinberger" <richard.weinberger@gmail.com>, "richard" <richard@nod.at>, "Greg Kroah-Hartman"
>> <gregkh@linuxfoundation.org>, "Prasad Sodagudi" <psodagud@codeaurora.org>, "Sami Tolvanen" <samitolvanen@google.com>,
>> "Amit Daniel Kachhap" <amit.kachhap@arm.com>, "linux-kselftest" <linux-kselftest@vger.kernel.org>, "clang-built-linux"
>> <clang-built-linux@googlegroups.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
>> Gesendet: Donnerstag, 25. Juni 2020 08:06:18
>> Betreff: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
> 
>> On Wed, Jun 24, 2020 at 06:45:47PM -0700, Randy Dunlap wrote:
>>> Looks like lkdtm/bugs.c needs to get/use arch/x86/include/asm/processor.h
>>> but it actually uses arch/x86/um/asm/processor*.h, which does not have the
>>> needed structs etc.
>>
>> Should I just test for !UML in bugs.c? (This is all for the
>> lkdtm_DOUBLE_FAULT() test.) I already do those kinds of checks for the
>> lkdtm_UNSET_SMEP() test. e.g.:
> 
> Just had a look. Yes, this sounds good to me. UML has CONFIG_X86_32=y but no GDT. :-)

Sounds good to me also. Thanks.

-- 
~Randy

