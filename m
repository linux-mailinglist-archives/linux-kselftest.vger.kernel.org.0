Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508763F56A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhHXD0G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 23:26:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35716 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhHXD0G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 23:26:06 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:37352)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIN3u-007tiF-D4; Mon, 23 Aug 2021 21:25:18 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47806 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIN3h-008tKu-MV; Mon, 23 Aug 2021 21:25:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Ma\, XinjianX" <xinjianx.ma@intel.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner\@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "jannh\@google.com" <jannh@google.com>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "kernel-hardening\@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "oleg\@redhat.com" <oleg@redhat.com>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>
In-Reply-To: <06bb27f1d79243febf9ddc4633c4e084@intel.com> (XinjianX Ma's
        message of "Tue, 24 Aug 2021 01:19:52 +0000")
References: <d650b7794e264d5f8aa107644cc9784f@intel.com>
        <87a6lgysxp.fsf@disp2133>
        <20210818131117.x7omzb2wkjq7le3s@example.org>
        <87o89ttqql.fsf@disp2133>
        <20210819172618.qwrrw4m7wt33wfmz@example.org>
        <87eeajswfc.fsf_-_@disp2133>
        <06bb27f1d79243febf9ddc4633c4e084@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 23 Aug 2021 22:24:17 -0500
Message-ID: <87lf4rplsu.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mIN3h-008tKu-MV;;;mid=<87lf4rplsu.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++AiEZW5KIHsfe2U3AKqShPsf05OHNwZw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Ma\, XinjianX" <xinjianx.ma@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2130 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (0.6%), b_tie_ro: 11 (0.5%), parse: 1.43
        (0.1%), extract_message_metadata: 22 (1.0%), get_uri_detail_list: 1.64
        (0.1%), tests_pri_-1000: 23 (1.1%), tests_pri_-950: 1.61 (0.1%),
        tests_pri_-900: 1.32 (0.1%), tests_pri_-90: 386 (18.1%), check_bayes:
        377 (17.7%), b_tokenize: 9 (0.4%), b_tok_get_all: 7 (0.3%),
        b_comp_prob: 2.4 (0.1%), b_tok_touch_all: 355 (16.7%), b_finish: 1.17
        (0.1%), tests_pri_0: 221 (10.4%), check_dkim_signature: 0.65 (0.0%),
        check_dkim_adsp: 4.7 (0.2%), poll_dns_idle: 1430 (67.2%),
        tests_pri_10: 4.4 (0.2%), tests_pri_500: 1451 (68.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] ucounts: Fix regression preventing increasing of rlimits in init_user_ns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"Ma, XinjianX" <xinjianx.ma@intel.com> writes:

>> -----Original Message-----
>> From: Eric W. Biederman <ebiederm@xmission.com>
>> ...
>> Reported-by: kernel test robot lkp@intel.com
> Sorry, but <> around email address is needed 
> Reported-by: kernel test robot <lkp@intel.com>

The change is already tested and pushed out so I really don't want to
mess with it.  Especially as I am aiming to send it to Linus on
Wednesday after it has had a chance to pass through linux-next and
whatever automated tests are there.

What does copying and pasting the Reported-by: tag as included in
your original report cause to break?

At this point I suspect that the danger of fat fingering something
far outweighs whatever benefits might be gained by surrounding the
email address with <> marks.

Eric
