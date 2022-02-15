Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F94B67FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiBOJpN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 04:45:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiBOJpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 04:45:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B382E61E1;
        Tue, 15 Feb 2022 01:45:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2EAF1F38A;
        Tue, 15 Feb 2022 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644918301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30j1t+BysVNM2M5YkR9BOryVBI0lVA+UTPwiJwtZ/ck=;
        b=l2uC+Y5I+VaWIvIauDW98b9US/LXnMopiuG50JFdVDqlHW7fx+TVxgVrlcpdAtEh3YTZ4y
        4KRWReMNSjqaFxO+1v2RRrdxF3YFVBuygZL4wrr8ms1EXO/A8mGmKqxlZEe1qVY8MSLoBA
        +cGa8ByBW2GntE0h8IKSXvbn9HKfTSk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ADCD13C36;
        Tue, 15 Feb 2022 09:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKqyJB12C2IVCAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Feb 2022 09:45:01 +0000
Date:   Tue, 15 Feb 2022 10:45:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 5/6] selftests: Challenge RLIMIT_NPROC in user
 namespaces
Message-ID: <20220215094459.GC21589@blackbody.suse.cz>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <20220207121800.5079-6-mkoutny@suse.com>
 <f0585ae4-5642-361f-11d6-9399bd9cc550@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0585ae4-5642-361f-11d6-9399bd9cc550@linuxfoundation.org>
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

On Wed, Feb 09, 2022 at 06:22:18PM -0700, Shuah Khan <skhan@linuxfoundation.org> wrote:
> Please see comments below. A bit of a concern with how long this test
> will run.  Did you time it?

It runs around 1 s, I didn't measure it and I used it manually only.

> How long does this test now run for with this loop?

I kept this sleep to space output from individual tasks for
better readability of output. It's not necessary for the sake of the
test. I'll remove it in next version.

> > -	for (i = 0; i < NR_CHILDS; i++) {
> > +	for (i = 0; i < NR_CHILDREN; i++) {
> >   		if (WIFEXITED(wstatus[i]))
> >   			warnx("(pid=%d): pid %d exited, status=%d",
> >   				pid, -child[i], WEXITSTATUS(wstatus[i]));
> > 
> 
> Please a add few more comments in the code path.

Hehe, this is inherited from the original version. (True, it's not
overly clear on its own.)

Michal

