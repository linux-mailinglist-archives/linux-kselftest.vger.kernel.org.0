Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B075D5DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUUkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUUkV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 16:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAD30CD;
        Fri, 21 Jul 2023 13:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8937261D6D;
        Fri, 21 Jul 2023 20:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD62C433CA;
        Fri, 21 Jul 2023 20:40:18 +0000 (UTC)
Date:   Fri, 21 Jul 2023 16:40:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        Nadav Amit <namit@vmware.com>, oe-lkp@lists.linux.dev,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230721164016.68bbe69a@gandalf.local.home>
In-Reply-To: <20230721091947.0df9fd73@gandalf.local.home>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <20230714185824.62556254@gandalf.local.home>
        <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
        <20230718094005.32516161@gandalf.local.home>
        <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
        <20230719102310.552d3356@gandalf.local.home>
        <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
        <20230719144046.746af82e@gandalf.local.home>
        <20230721084839.4a97a595@gandalf.local.home>
        <20230721091947.0df9fd73@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 21 Jul 2023 09:19:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +	} else {
> > +		/* A race here, should try again (unless freed) */
> > +		invalidate = true;  
> 
> I had a WARN_ON() once here. Probably could add a:
> 
> 		WARN_ON_ONCE(!ef->is_freed);

Yeah this should have a WARN_ON_ONCE() because the only way to get here
with having a dentry and the ef->dentry being set is if we have two
dentries with the same name in the same directory. Which should never
happen.

I think we can add:

		/*
		 * Should never happen unless we get here due to being freed.
		 * Otherwise it means two dentries exist with the same name.
		 */
		WARN_ON_ONCE(!ef->is_freed);

> 
> > +	}


-- Steve
