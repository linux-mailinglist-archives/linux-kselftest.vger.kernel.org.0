Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263864C1A7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiBWSBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiBWSBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 13:01:17 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96C3E5EA;
        Wed, 23 Feb 2022 10:00:49 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:50190)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMvwT-001Zwz-5t; Wed, 23 Feb 2022 11:00:45 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34504 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMvwS-00CTRp-1i; Wed, 23 Feb 2022 11:00:44 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-api@vger.kernel.org>
Cc:     Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        <security@kernel.org>, Neil Brown <neilb@cse.unsw.edu.au>,
        NeilBrown <neilb@suse.de>, "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
In-Reply-To: <87zgmi5rhm.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 22 Feb 2022 18:57:57 -0600")
References: <20220207121800.5079-1-mkoutny@suse.com>
        <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
        <20220215101150.GD21589@blackbody.suse.cz>
        <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 23 Feb 2022 12:00:16 -0600
Message-ID: <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nMvwS-00CTRp-1i;;;mid=<87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9RCjhfluUYzpGOmLuFphN7caHHRxw2iw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-api@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 488 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.8%), b_tie_ro: 2.8 (0.6%), parse: 0.79
        (0.2%), extract_message_metadata: 3.0 (0.6%), get_uri_detail_list:
        1.53 (0.3%), tests_pri_-1000: 3.3 (0.7%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 105 (21.5%), check_bayes:
        104 (21.3%), b_tokenize: 7 (1.4%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 1.93 (0.4%), b_tok_touch_all: 85 (17.3%), b_finish: 0.72
        (0.1%), tests_pri_0: 357 (73.1%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 1.94 (0.4%), poll_dns_idle: 0.66 (0.1%),
        tests_pri_10: 1.76 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: How should rlimits, suid exec, and capabilities interact?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


[CC'd the security list because I really don't know who the right people
 are to drag into this discussion]
 
While looking at some issues that have cropped up with making it so
that RLIMIT_NPROC cannot be escaped by creating a user namespace I have
stumbled upon a very old issue of how rlimits and suid exec interact
poorly.

This specific saga starts with commit 909cc4ae86f3 ("[PATCH] Fix two
bugs with process limits (RLIMIT_NPROC)") from
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git which
essentially replaced a capable() check with a an open-coded
implementation of suser(), for RLIMIT_NPROC.

The description from Neil Brown was:

   1/ If a setuid process swaps it's real and effective uids and then forks,
     the fork fails if the new realuid has more processes
     than the original process was limited to.
     This is particularly a problem if a user with a process limit
     (e.g. 256) runs a setuid-root program which does setuid() + fork()
     (e.g. lprng) while root already has more than 256 process (which
     is quite possible).
    
     The root problem here is that a limit which should be a per-user
     limit is being implemented as a per-process limit with
     per-process (e.g. CAP_SYS_RESOURCE) controls.
     Being a per-user limit, it should be that the root-user can over-ride
     it, not just some process with CAP_SYS_RESOURCE.
    
     This patch adds a test to ignore process limits if the real user is root.

The test to see if the real user is root was:
	if (p->real_cred->user != INIT_USER) ...
which persists to this day in fs/fork.c:copy_process().

The practical problem with this test is that it works like nothing else
in the kernel, and so does not look like what it is.  Saying:
	if (!uid_eq(p->real_cred->uid, GLOBAL_ROOT_USER)) ...

would at least be more recognizable.

Really this entire test should be if (!capable(CAP_SYS_RESOURCE) because
CAP_SYS_RESOURCE is the capability that controls if you are allowed to
exceed your rlimits.

Which brings us to the practical issues of how all of these things are
wired together today.

The per-user rlimits are accounted based upon a processes real user, not
the effective user.  All other permission checks are based upon the
effective user.  This has the practical effect that uids are swapped as
above that the processes are charged to root, but use the permissions of
an ordinary user.

The problems get worse when you realize that suid exec does not reset
any of the rlimits except for RLIMIT_STACK.

The rlimits that are particularly affected and are per-user are:
RLIMIT_NPROC, RLIMIT_MSGQUEUE, RLIMIT_SIGPENDING, RLIMIT_MEMLOCK.

But I think failing to reset rlimits during exec has the potential to
effect any suid exec.

Does anyone have any historical knowledge or sense of how this should
work?

Right now it feels like we have coded ourselves into a corner and will
have to risk breaking userspace to get out of it.  AKA I think we need
a policy of reseting rlimits on suid exec, and I think we need to store
global rlimits based upon the effective user not the real user.  Those
changes should allow making capable calls where they belong, and
removing the much too magic user == INIT_USER test for RLIMIT_NPROC.

Eric
