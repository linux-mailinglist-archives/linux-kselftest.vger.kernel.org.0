Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10F1222CDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGPUay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPUax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 16:30:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951CFC061755;
        Thu, 16 Jul 2020 13:30:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EA6E62A5A65
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        gofmanp@gmail.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, jannh@google.com
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Organization: Collabora
References: <20200716193141.4068476-1-krisman@collabora.com>
        <202007161300.7452A2C5@keescook>
        <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
        <202007161324.E75E01B@keescook>
        <20200716202935.yorxrz2om67r366x@wittgenstein>
Date:   Thu, 16 Jul 2020 16:30:48 -0400
In-Reply-To: <20200716202935.yorxrz2om67r366x@wittgenstein> (Christian
        Brauner's message of "Thu, 16 Jul 2020 22:29:35 +0200")
Message-ID: <871rlbjj7r.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Thu, Jul 16, 2020 at 01:25:43PM -0700, Kees Cook wrote:
>> On Thu, Jul 16, 2020 at 10:22:34PM +0200, Christian Brauner wrote:
>> > On Thu, Jul 16, 2020 at 01:04:38PM -0700, Kees Cook wrote:
>> > > On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>> > > > This is v4 of Syscall User Redirection.  The implementation itself is
>> > > > not modified from v3, it only applies the latest round of reviews to the
>> > > > selftests.
>> > > > 
>> > > > __NR_syscalls is not really exported in header files other than
>> > > > asm-generic for every architecture, so it felt safer to optionally
>> > > > expose it with a fallback to a high value.
>> > > > 
>> > > > Also, I didn't expose tests for PR_GET as that is not currently
>> > > > implemented.  If possible, I'd have it supported by a future patchset,
>> > > > since it is not immediately necessary to support this feature.
>> > > 
>> > > Thanks! That all looks good to me.
>> > 
>> > Don't have any problem with this but did this ever get exposure on
>> > linux-api? This is the first time I see this pop up.
>> 
>> I thought I'd added it to CC in the past, but that might have been other
>> recent unrelated threads. Does this need a full repost there too, you
>> think?
>
> Nah, wasn't my intention to force a repost. Seems that several people
> have looked this over. :) Just curious why it didn't get to linux-api
> and we know quite some people who only do look at linux-api (for sanity). :)

That's my mistake.  I didn't think about it when submitting :(

If this get re-spinned again I will make sure to CC linux-api.

-- 
Gabriel Krisman Bertazi
