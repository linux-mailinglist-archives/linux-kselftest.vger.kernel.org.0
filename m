Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913B8651807
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 02:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiLTBYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 20:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiLTBWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 20:22:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA685E0C3;
        Mon, 19 Dec 2022 17:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99887B80F9B;
        Tue, 20 Dec 2022 01:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EABC433F0;
        Tue, 20 Dec 2022 01:21:46 +0000 (UTC)
Date:   Mon, 19 Dec 2022 20:21:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Message-ID: <20221219202143.7fd28ac7@gandalf.local.home>
In-Reply-To: <a854db66-0a14-e40b-f3f0-369228fcd835@linuxfoundation.org>
References: <20221219183106.518341498@goodmis.org>
        <20221219183214.075559302@goodmis.org>
        <Y6DQTvOrHRZ8gjDz@google.com>
        <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
        <20221219173507.410915a3@gandalf.local.home>
        <a854db66-0a14-e40b-f3f0-369228fcd835@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 19 Dec 2022 17:20:39 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/19/22 15:35, Steven Rostedt wrote:
> > On Mon, 19 Dec 2022 15:11:39 -0700
> > Shuah Khan <skhan@linuxfoundation.org> wrote:
> >   
> >> On 12/19/22 13:57, Ross Zwisler wrote:  
> >>> On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:  
> >>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >>>>
> >>>> With the new filter logic of passing in the name of a function to match an
> >>>> instruction pointer (or the address of the function), add a test to make
> >>>> sure that it is functional.
> >>>>
> >>>> This is also the first test to test plain filtering. The filtering has
> >>>> been tested via the trigger logic, which uses the same code, but there was
> >>>> nothing to test just the event filter, so this test is the first to add
> >>>> such a case.
> >>>>
> >>>> Cc: Shuah Khan <shuah@kernel.org>
> >>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >>>> Cc: linux-kselftest@vger.kernel.org
> >>>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> >>>
> >>> Reviewed-by: Ross Zwisler <zwisler@google.com>  
> >>
> >> Thank you both. I will apply this after rc1 comes out.  
> > 
> > It's dependent on the first patch.
> >   
> 
> In which case,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>

Thanks Shuah!

-- Steve
