Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E84ADAE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377758AbiBHOMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 09:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377752AbiBHOMs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 09:12:48 -0500
X-Greylist: delayed 1092 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 06:12:43 PST
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18384C03FEDA;
        Tue,  8 Feb 2022 06:12:42 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:39206)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHQwu-0004wn-9Z; Tue, 08 Feb 2022 06:54:28 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42144 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHQws-009yMp-W6; Tue, 08 Feb 2022 06:54:27 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
Date:   Tue, 08 Feb 2022 07:54:00 -0600
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com> ("Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD=22's?=
        message of "Mon, 7 Feb 2022 13:17:54 +0100")
Message-ID: <87ee4dihvr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nHQws-009yMp-W6;;;mid=<87ee4dihvr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ahRGJgxPKAsR4MwgKINp4kU2cAU6uSPQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?*;Michal Koutn=c3=bd <mkoutny@suse.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 611 ms - load_scoreonly_sql: 0.21 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.51
        (0.2%), extract_message_metadata: 14 (2.3%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 14 (2.2%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 148 (24.3%), check_bayes:
        142 (23.2%), b_tokenize: 7 (1.1%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.5 (0.4%), b_tok_touch_all: 121 (19.7%), b_finish: 0.96
        (0.2%), tests_pri_0: 406 (66.4%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/6] RLIMIT_NPROC in ucounts fixups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> This series is a result of looking deeper into breakage of
> tools/testing/selftests/rlimits/rlimits-per-userns.c after 
> https://lore.kernel.org/r/20220204181144.24462-1-mkoutny@suse.com/
> is applied.
>
> The description of the original problem that lead to RLIMIT_NPROC et al.
> ucounts rewrite could be ambiguously interpretted as supporting either
> the case of:
> - never-fork service or
> - fork (RLIMIT_NPROC-1) times service.
>
> The scenario is weird anyway given existence of pids controller.
>
> The realization of that scenario relies not only on tracking number of
> processes per user_ns but also newly allows the root to override limit through
> set*uid. The commit message didn't mention that, so it's unclear if it
> was the intention too.
>
> I also noticed that the RLIMIT_NPROC enforcing in fork seems subject to TOCTOU
> race (check(nr_tasks),...,nr_tasks++) so the limit is rather advisory (but
> that's not a new thing related to ucounts rewrite).
>
> This series is RFC to discuss relevance of the subtle changes RLIMIT_NPROC to
> ucounts rewrite introduced.

A quick reply (because I don't have a lot of time at the moment).

I agree with the issues your first patch before this series addresses
and the issues the first 3 patches address.

I have not looked at the tests.

I actually disagree with most of your fixes.  Both because of
intrusiveness and because of awkwardness.  My basic problem with
your fixes is I don't think they leave the code in a more maintainable
state.

Hopefully later today I can propose some alternative fixes and we can
continue the discussion.


One thing I think you misunderstood is the capability checks in set_user
have always been there.  There is a very good argument they are badly
placed so are not exactly checking the correct credentials.  Especially
now.

Your patch 4/6 I don't think makes sense.  It has always been the
case that root without capabilities is subject to the rlimit.  If  you
are in a user namespace you are root without capabilities.


Eric
