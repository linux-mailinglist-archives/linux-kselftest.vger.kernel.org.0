Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB07562A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGQMYR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGQMYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F5B9;
        Mon, 17 Jul 2023 05:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F5161042;
        Mon, 17 Jul 2023 12:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2198C433C8;
        Mon, 17 Jul 2023 12:24:12 +0000 (UTC)
Date:   Mon, 17 Jul 2023 08:24:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 10/10] test: ftrace: Fix kprobe test for eventfs
Message-ID: <20230717082411.147abfa6@gandalf.local.home>
In-Reply-To: <54F18849-4C39-4F30-A3D7-969F14EA3810@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-11-git-send-email-akaher@vmware.com>
        <20230713223758.31a1e391@rorschach.local.home>
        <20230714222705.bc38f83d857473656a45d441@kernel.org>
        <54F18849-4C39-4F30-A3D7-969F14EA3810@vmware.com>
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

On Mon, 17 Jul 2023 05:24:43 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> >> As this patch as is will break when running on older kernels, I was
> >> wondering if we should do this instead?  
> > 
> > +1 since the latest kselftest is used also for checking the older
> > stable kernels, the test case has to check the environment and
> > change the parameter (or make it unsupported for new feature)
> > So below looks good to me.  
> 
> +1, many ftrace tests are unsupported in my setup and may few require
> changes, not sure. Does any auto job takes care of this?

You mean like some kernel CI? Not that I know of.

Shuah, do you run these selftests on older kernels to make sure they don't
fail just because the test is unsupported?

-- Steve
