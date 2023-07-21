Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0C75D3C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGUTOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGUTOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 15:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDE1BF4;
        Fri, 21 Jul 2023 12:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A644C61D82;
        Fri, 21 Jul 2023 19:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5461BC433CA;
        Fri, 21 Jul 2023 19:14:13 +0000 (UTC)
Date:   Fri, 21 Jul 2023 15:14:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230721151409.212791c0@gandalf.local.home>
In-Reply-To: <20230721091843.68c4d6e7@gandalf.local.home>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <20230714185824.62556254@gandalf.local.home>
        <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
        <20230718094005.32516161@gandalf.local.home>
        <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
        <20230719102310.552d3356@gandalf.local.home>
        <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
        <20230719144046.746af82e@gandalf.local.home>
        <20230721091843.68c4d6e7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 21 Jul 2023 09:18:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, I got this working and it appears to pass all my tests. I actually got
> it working Wednesday night, but I tried a different approach on Thursday
> that got rid of the evenfs_file and only used eventfs_inodes and makes the
> files more dynamic. There's still a couple of corner cases that are not
> working with this approach (the dentry counters are getting out of sync).
> This should not stop this from going in. I'll continue working on that
> approach for the next merge cycle. But for now, here's the patch to this
> series that works.

Just figured out my bug with my new design. It was in the eventfs_release()
code, where I have a loop that does the dput on the children, but I wasn't
dput(child), I was dput(parent) in that loop!!

Anyway, for this merge window I much rather have this code in, and for the
next merge window I'll add this update.

I can post the new design too, but first let's focus on this.

-- Steve
