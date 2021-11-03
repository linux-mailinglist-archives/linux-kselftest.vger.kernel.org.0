Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B64448D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhKCTUm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 15:20:42 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37974 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 15:20:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:33588)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miLls-00DxQz-FN; Wed, 03 Nov 2021 13:18:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:54326 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miLlr-00C4qx-1b; Wed, 03 Nov 2021 13:18:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211103163039.2104830-1-keescook@chromium.org>
        <87lf253x1c.fsf@disp2133> <202111031139.80CE97C532@keescook>
Date:   Wed, 03 Nov 2021 14:17:56 -0500
In-Reply-To: <202111031139.80CE97C532@keescook> (Kees Cook's message of "Wed,
        3 Nov 2021 11:40:23 -0700")
Message-ID: <871r3xyrob.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1miLlr-00C4qx-1b;;;mid=<871r3xyrob.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nUrYSaq7CXOROhJQdhgL44ZtdIJWIAUE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4195]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 462 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.14
        (0.2%), extract_message_metadata: 18 (3.8%), get_uri_detail_list: 1.69
        (0.4%), tests_pri_-1000: 22 (4.8%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 177 (38.2%), check_bayes:
        173 (37.5%), b_tokenize: 6 (1.2%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 157 (33.9%), b_finish: 0.94
        (0.2%), tests_pri_0: 218 (47.2%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] selftests/seccomp: Report event mismatches more clearly
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Nov 03, 2021 at 01:37:51PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > Hi,
>> >
>> > This expands the seccomp selftests slightly to add additional debug
>> > reporting detail and a new "immediate fatal SIGSYS under tracing" test.
>> > I expect to be taking these via my seccomp tree.
>> 
>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> 
>> I am a little fuzzy on the details but I understand what and why
>> you are testing (I broken it).  So this is my 10,000 foot ack.
>
> Thanks! Yeah, and the other tests did catch it, but it was kind of a
> "side effect", so I added the specific "direct" case where it can be
> seen more clearly.

Hey.  Did you happen to understand the bit about racing with sigaction?

As much as I care about not braking ptrace.  What really decided me was
the on SA_IMMUTABLE was closing the race with sigaction changing the
signal handler.  Especially for something like seccomp.

It is a race so probably very fickle to write a test for, but if we can
figure out how to write a reliable test I expect it will be a good idea.
Do you have any ideas?

I am concerned there is some threaded program somewhere using seccomp
that is allowed to call sigaction, can use sigaction to keep from
being killed (before I send the fix to Linus). 

Eric

