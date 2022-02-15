Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251624B67AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiBOJfI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 04:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiBOJfH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 04:35:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEFB717F;
        Tue, 15 Feb 2022 01:34:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42B13210F3;
        Tue, 15 Feb 2022 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644917697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBcOuKd0LOYeF5+y7S2lOA080trYx3ZHTlWXhiJlqiM=;
        b=RKv0NNZz2vBgTJcZ0fO+arxVBI9zO6VahdMKsSTqlCeUr4+Vg9mEvZDquASiPPu6y3tpCC
        BE6atyFpa4Ctv1uLzATw6and2QdjoBCXx5tLrQ/hdWn7j1YexWJl/AJaJM30ePgRs+sTZq
        BhpsSVt+Zd1tn5iECmMj61CICB0Fd3U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18A0C13C36;
        Tue, 15 Feb 2022 09:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id liBQBcFzC2LbAgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Feb 2022 09:34:57 +0000
Date:   Tue, 15 Feb 2022 10:34:55 +0100
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
Subject: Re: [RFC PATCH 6/6] selftests: Test RLIMIT_NPROC in clone-created
 user namespaces
Message-ID: <20220215093455.GB21589@blackbody.suse.cz>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <20220207121800.5079-7-mkoutny@suse.com>
 <789bda88-1ef7-8c60-5c00-d3b7a2b8588d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789bda88-1ef7-8c60-5c00-d3b7a2b8588d@linuxfoundation.org>
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

On Wed, Feb 09, 2022 at 06:25:34PM -0700, Shuah Khan <skhan@linuxfoundation.org> wrote:
> Does this test run in non-privileged user mode? If it doesn't
> let add a check and skip the test.

It requires user namespaces created by the privileged user (to bypass
RLIMIT_NPROC on the top level).

I'll add the check into code.

Michal
