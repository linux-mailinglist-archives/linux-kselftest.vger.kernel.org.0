Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678177395DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFVDbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVDbp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 23:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EE1A4;
        Wed, 21 Jun 2023 20:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAE761735;
        Thu, 22 Jun 2023 03:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E1DC433C0;
        Thu, 22 Jun 2023 03:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687404701;
        bh=WBmd0nq3sx1Y1vI60yLf61g1XYsV04DTZ0OhzpLUGBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qKpiAZdZxPraq1RHCCL2jgP4YMW8kD2nFTP6eBOg6qczrJnu9ZGo/6DDbPxBeDNVY
         TaEwXKKO2PSwiHanFWf48B0ZTZvbh58cGgfPY37mVnHWMmGSMtmWy2YjFnLV/r5BfS
         PDY0A84VD1Cqhib3Ux1c+imtQkS40Z8CGN4+HvzG9q6iz3G9VNq5uWjXw234FqTLZT
         BdkMdjZUBX7/Q2lhWxiyfDaY2oogiVdU1zdJ/jARqLAaQJ+3/fYNILN798xC6rWmbM
         M2u49QkBp9ekoyCGigaqRW7jCPn1uoDzvESuzSeLg3cGNFH7IermGnIOQxG6kZooGP
         bWOwX+R1fud7Q==
Date:   Thu, 22 Jun 2023 12:31:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 00/10] tracing: introducing eventfs
Message-Id: <20230622123137.4b74a306c9032de70cd99c51@kernel.org>
In-Reply-To: <1C7D95B2-3DF0-43AB-8F8B-7D3F7AE7FC0D@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <34E6364B-2B3D-4597-8143-1EEA645B6CDD@vmware.com>
        <20230620110227.6a944a19@gandalf.local.home>
        <1C7D95B2-3DF0-43AB-8F8B-7D3F7AE7FC0D@vmware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 21 Jun 2023 11:42:24 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> 
> 
> > On 20-Jun-2023, at 8:32 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > !! External Email
> > 
> > On Mon, 19 Jun 2023 05:38:25 +0000
> > Ajay Kaher <akaher@vmware.com> wrote:
> > 
> >> # of passed:  65
> >> # of failed:  3
> > 
> > Unrelated to your patches, but have you checked why these fail? Do you have
> > the latest tests running on the latest kernel?
> > 
> 
> Failed test got passed after enabling /proc/kallsyms, using:
> echo 0  > /proc/sys/kernel/kptr_restrict

Oh, interesting. It should be 'unresolved' (skipped) if that happens.

[23] event filter function - test event filtering on functions [FAIL]
[60] Kprobe events - probe points [FAIL]
[106] (instance)  event filter function - test event filtering on functions [FAIL]

OK, let me see.

Thanks for reporting!

> Following is the report of ftracetest on Linux v6.4.0-rc7 (with/without eventfs):
> # of passed:  68
> # of failed:  0
> # of unresolved:  6
> # of untested:  0
> # of unsupported:  45
> # of xfailed:  0
> # of undefined(test bug):  0 
> 
> If lockdep is enabled getting same warning as reported by 'kernel test robot' for v3 09/10:
> https://lore.kernel.org/all/1686640004-47546-1-git-send-email-akaher@vmware.com/
> 
> >> # of unresolved:  6
> >> # of untested:  0
> >> # of unsupported:  44
> >> # of xfailed:  0
> >> # of undefined(test bug):  0
> >> 
> >> These results are same with/without eventfs.
> > 
> > I'm hoping to look at these patches this week.
> 
> Yes, please. Thanks.
> 
> -Ajay
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
