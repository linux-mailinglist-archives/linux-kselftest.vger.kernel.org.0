Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D54B03D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 04:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiBJDUU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 22:20:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBJDUU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 22:20:20 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A121EAF5;
        Wed,  9 Feb 2022 19:20:21 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:41030)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHxEu-00EcR6-Rv; Wed, 09 Feb 2022 17:23:12 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41838 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHxEs-00A1Nk-OT; Wed, 09 Feb 2022 17:23:12 -0700
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
        <20220207121800.5079-5-mkoutny@suse.com>
Date:   Wed, 09 Feb 2022 18:21:07 -0600
In-Reply-To: <20220207121800.5079-5-mkoutny@suse.com> ("Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD=22's?=
        message of "Mon, 7 Feb 2022 13:17:58 +0100")
Message-ID: <87a6eza7ws.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nHxEs-00A1Nk-OT;;;mid=<87a6eza7ws.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+x1wyLwJjAEjidVjc0O5LqBuAMgqtDSuQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?***;Michal Koutn=c3=bd <mkoutny@suse.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 1440 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.09
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 1.28
        (0.1%), tests_pri_-1000: 16 (1.1%), tests_pri_-950: 1.50 (0.1%),
        tests_pri_-900: 1.13 (0.1%), tests_pri_-90: 66 (4.6%), check_bayes: 65
        (4.5%), b_tokenize: 9 (0.6%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.8 (0.2%), b_tok_touch_all: 41 (2.8%), b_finish: 1.05 (0.1%),
        tests_pri_0: 1313 (91.2%), check_dkim_signature: 0.67 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 1.15 (0.1%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 11 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 4/6] ucounts: Allow root to override RLIMIT_NPROC
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> Call sites of ucounts_limit_cmp() would allow the global root or capable
> user to bypass RLIMIT_NPROC on the bottom level of user_ns tree by not
> looking at ucounts at all.
>
> As the traversal up the user_ns tree continues, the ucounts to which the
> task is charged may switch the owning user (to the creator of user_ns).
> If the new chargee is root, we don't really care about RLIMIT_NPROC
> observation, so lift the limit to the max.
>
> The result is that an unprivileged user U can globally run more that
> RLIMIT_NPROC (of user_ns) tasks but within each user_ns it is still
> limited to RLIMINT_NPROC (as passed into task->signal->rlim) iff the
> user_nss are created by the privileged user.

My apologies.  When I first looked at this I thought this change was
non-sense.  However I had missed the special logic that happens with
RLIMIT_NPROC to carefully allow the root user to bypass the NPROC
limits.

So yes this does look like something that needs to be addressed as well.

Thank you for reporting all of these issues.

Eric

>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/ucount.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 53ccd96387dd..f52b7273a572 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -356,6 +356,9 @@ long ucounts_limit_cmp(struct ucounts *ucounts, enum ucount_type type, unsigned
>  		if (excess > 0)
>  			return excess;
>  		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		/* Next ucounts owned by root? RLIMIT_NPROC is moot */
> +		if (type == UCOUNT_RLIMIT_NPROC && uid_eq(iter->ns->owner, GLOBAL_ROOT_UID))
> +			max = LONG_MAX;
>  	}
>  	return excess;
>  }
