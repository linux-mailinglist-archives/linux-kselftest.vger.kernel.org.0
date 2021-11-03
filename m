Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769C44485E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 19:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKCSkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 14:40:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52124 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhKCSkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 14:40:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:43636)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miL95-000YWJ-Ec; Wed, 03 Nov 2021 12:37:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53250 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miL93-00Bv7w-Lt; Wed, 03 Nov 2021 12:37:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211103163039.2104830-1-keescook@chromium.org>
Date:   Wed, 03 Nov 2021 13:37:51 -0500
In-Reply-To: <20211103163039.2104830-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 3 Nov 2021 09:30:37 -0700")
Message-ID: <87lf253x1c.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1miL93-00Bv7w-Lt;;;mid=<87lf253x1c.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/H9jK5N9976jNzDSgqO04BsgEtCX+f4KM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4327]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 361 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 10 (2.9%), parse: 1.67
        (0.5%), extract_message_metadata: 17 (4.6%), get_uri_detail_list: 1.08
        (0.3%), tests_pri_-1000: 25 (6.9%), tests_pri_-950: 1.56 (0.4%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 116 (32.1%), check_bayes:
        114 (31.6%), b_tokenize: 4.9 (1.4%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.72 (0.5%), b_tok_touch_all: 98 (27.1%), b_finish: 1.04
        (0.3%), tests_pri_0: 167 (46.3%), check_dkim_signature: 0.94 (0.3%),
        check_dkim_adsp: 3.0 (0.8%), poll_dns_idle: 0.91 (0.3%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 14 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] selftests/seccomp: Report event mismatches more clearly
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Hi,
>
> This expands the seccomp selftests slightly to add additional debug
> reporting detail and a new "immediate fatal SIGSYS under tracing" test.
> I expect to be taking these via my seccomp tree.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I am a little fuzzy on the details but I understand what and why
you are testing (I broken it).  So this is my 10,000 foot ack.

Eric




> Thanks,
>
> -Kees
>
> Kees Cook (2):
>   selftests/seccomp: Stop USER_NOTIF test if kcmp() fails
>   selftests/seccomp: Report event mismatches more clearly
>
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 56 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 6 deletions(-)
