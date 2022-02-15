Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710074B68EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiBOKMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 05:12:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiBOKMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 05:12:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C610E06C;
        Tue, 15 Feb 2022 02:11:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EE591F38A;
        Tue, 15 Feb 2022 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644919912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn4ZOnzkLUwdV4GSdmhBv6HuJ+flbDE0pzlK1n4n1ks=;
        b=eCOM7jhLs38pfcQ1gzcSRPU749WffBvghxjPn1mdJChcZrH2Z/dmhHESjTxHseKtCVz+pT
        rAU/sJ+cAHfe10HPrrJHW4t6l1jRzX7Xqq/U8HVdnkNvXB0TK8zuovJdAs+Z7roOATJHFm
        nJAteGNPVGZeeoDpOnINu4hNRiI3IH4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06EA713C16;
        Tue, 15 Feb 2022 10:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGwuAWh8C2L2FgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Feb 2022 10:11:52 +0000
Date:   Tue, 15 Feb 2022 11:11:50 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Etienne Dechamps <etienne@edechamps.fr>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 0/6] RLIMIT_NPROC in ucounts fixups
Message-ID: <20220215101150.GD21589@blackbody.suse.cz>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
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

On Sat, Feb 12, 2022 at 03:32:30PM +0000, Etienne Dechamps <etienne@edechamps.fr> wrote:
> I'm not sure I understand everything that's going on in this thread but it
> does seem very relevant. You guys might want to double-check the behavior in
> the particular scenario described there. I'm mostly sending this to make
> sure everything is cross-linked.

Thanks for the report with strace.

AFAICT, it's caused by setresuid() after unshare(), i.e. all root's
tasks are (wrongly) compared against the lowered RLIMIT_NPROC.

This is tackled by my RFC patch 2/6 [1] or Eric's variant but 3/8
(equivalent fix for this case but I haven't run that build).

Michal

[1] I could run your test (LimitNPROC=1 actually) against kernel with my
patches and the service starts. 
