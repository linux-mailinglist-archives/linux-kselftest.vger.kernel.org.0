Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F74B6B90
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 12:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiBOLzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 06:55:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiBOLzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 06:55:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26692A251D;
        Tue, 15 Feb 2022 03:55:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF30A1F38C;
        Tue, 15 Feb 2022 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644926139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoPYCDygpGvEIbFdbv3LLB3EascduTiUcqWT4Mp3dTU=;
        b=OsExu9/YCdm0eLrImqwwU4tkjScD00gApj4EEW+yz8/lgDEbnOmDmtpLqF29TEB5Wy2O6L
        c78AOEQ2mz1JahQ+OaydMT5MjKyWhkEwUrdSLI+GBVnYrifV+Vf43pJZnLlOzq7c+hcaQR
        ySow/MVXnSzKnaUGz9VzLvFFSu/UOWs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE2F213C63;
        Tue, 15 Feb 2022 11:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zyjxKbuUC2IZTQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Feb 2022 11:55:39 +0000
Date:   Tue, 15 Feb 2022 12:55:38 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Solar Designer <solar@openwall.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 1/6] set_user: Perform RLIMIT_NPROC capability check
 against new user credentials
Message-ID: <20220215115538.GJ21589@blackbody.suse.cz>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <20220207121800.5079-2-mkoutny@suse.com>
 <20220210011405.GA17076@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210011405.GA17076@openwall.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 02:14:05AM +0100, Solar Designer <solar@openwall.com> wrote:
> However, I think you need to drop the negations of the return value from
> security_capable().
> security_capable() returns 0 or -EPERM, while capable() returns a
> bool, in kernel/capability.c: ns_capable_common():

Oops. Yeah, I only blindly applied replacement with a predicate for
(new) cred and overlooked this inverse semantics. Thanks for pointing
that out to me!

Nevertheless, this will likely be incorporated via Eric's series
anyway.


Michal

