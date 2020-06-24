Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E3206DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgFXHdG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 03:33:06 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33582 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgFXHdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 03:33:06 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2020 03:33:05 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03BAC6089348;
        Wed, 24 Jun 2020 09:23:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kIp0YWd4f9Wp; Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 987DE6246915;
        Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id guvA4nah7l7J; Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6A8CC6089348;
        Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
Message-ID: <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
In-Reply-To: <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
References: <20200529200347.2464284-1-keescook@chromium.org> <202006231610.4993DC5@keescook> <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: lkdtm: Various clean ups
Thread-Index: AQwsBIGnKjKHDWJPXuIGObKRE4SqJA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- Ursprüngliche Mail -----
>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> 
>> True that, we can rip the file.
> 
> Has anyone fixed the uml build errors?

I didn't realize that this is a super urgent issue. ;-)

Kees, if you want you can carry a patch in your series, I'll ack it.
Otherwise I can also do a patch and bring it via the uml tree upstream
as soon more fixes queued up.

Thanks,
//richard
