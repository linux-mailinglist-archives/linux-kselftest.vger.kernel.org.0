Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4079ADB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbjIKVU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbjIKSHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 14:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082B103;
        Mon, 11 Sep 2023 11:07:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EE0C433C8;
        Mon, 11 Sep 2023 18:07:43 +0000 (UTC)
Date:   Mon, 11 Sep 2023 14:07:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace/selftests: Add softlink to latest log directory
Message-ID: <20230911140759.725af6b4@gandalf.local.home>
In-Reply-To: <20230911092105.95425e2d773f79c9b3b4b94f@kernel.org>
References: <20230908181721.00f7eb71@gandalf.local.home>
        <20230911092105.95425e2d773f79c9b3b4b94f@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 Sep 2023 09:21:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 8 Sep 2023 18:17:21 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > When I'm debugging something with the ftrace selftests and need to look at
> > the logs, it becomes tedious that I need to do the following:
> > 
> >  ls -ltr logs
> >  [ copy the last directory ]
> >  ls logs/<paste-last-dir>
> > 
> > to see where the logs are.
> > 
> > Instead, do the common practice of having a "latest" softlink to the last
> > run selftest. This way after running the selftest I only need to do:
> > 
> >  ls logs/latest/
> > 
> > and it will always give me the directory of the last run selftest logs!
> >   
> 
> Nice! I like this and this looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you!
>

Should this go via Shuah's tree?

-- Steve
