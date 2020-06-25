Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA82099D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbgFYGYO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 02:24:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56628 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgFYGYO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 02:24:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 33A54626F1A9;
        Thu, 25 Jun 2020 08:24:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5lXw8bOohNOj; Thu, 25 Jun 2020 08:24:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 407E1626F1AD;
        Thu, 25 Jun 2020 08:24:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LCL_KQ4g-Hqv; Thu, 25 Jun 2020 08:24:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F0FBE626F1A9;
        Thu, 25 Jun 2020 08:24:08 +0200 (CEST)
Date:   Thu, 25 Jun 2020 08:24:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1916262186.58280.1593066248850.JavaMail.zimbra@nod.at>
In-Reply-To: <202006242300.145D555@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org> <202006241335.2C0FB5DF90@keescook> <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org> <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com> <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org> <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org> <80f501f4-d4fb-1f22-5603-57b5490a695d@infradead.org> <202006242300.145D555@keescook>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: lkdtm: Various clean ups
Thread-Index: nApJhg2/+hA+nTNrNh5Vko39Y8Hygg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Kees Cook" <keescook@chromium.org>
> An: "Randy Dunlap" <rdunlap@infradead.org>
> CC: "Richard Weinberger" <richard.weinberger@gmail.com>, "richard" <richard@nod.at>, "Greg Kroah-Hartman"
> <gregkh@linuxfoundation.org>, "Prasad Sodagudi" <psodagud@codeaurora.org>, "Sami Tolvanen" <samitolvanen@google.com>,
> "Amit Daniel Kachhap" <amit.kachhap@arm.com>, "linux-kselftest" <linux-kselftest@vger.kernel.org>, "clang-built-linux"
> <clang-built-linux@googlegroups.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 25. Juni 2020 08:06:18
> Betreff: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups

> On Wed, Jun 24, 2020 at 06:45:47PM -0700, Randy Dunlap wrote:
>> Looks like lkdtm/bugs.c needs to get/use arch/x86/include/asm/processor.h
>> but it actually uses arch/x86/um/asm/processor*.h, which does not have the
>> needed structs etc.
> 
> Should I just test for !UML in bugs.c? (This is all for the
> lkdtm_DOUBLE_FAULT() test.) I already do those kinds of checks for the
> lkdtm_UNSET_SMEP() test. e.g.:

Just had a look. Yes, this sounds good to me. UML has CONFIG_X86_32=y but no GDT. :-)

Thanks,
//richard
