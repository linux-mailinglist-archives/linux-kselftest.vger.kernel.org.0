Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC1640D34
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiLBS3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 13:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiLBS3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 13:29:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E88EE7D;
        Fri,  2 Dec 2022 10:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3BCABCE1F5E;
        Fri,  2 Dec 2022 18:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA6FC433C1;
        Fri,  2 Dec 2022 18:29:44 +0000 (UTC)
Date:   Fri, 2 Dec 2022 13:29:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Use long for synthetic event probe
 test
Message-ID: <20221202132942.62e9a71f@gandalf.local.home>
In-Reply-To: <ef842cd8-1228-54e2-c298-f524be7abc59@linuxfoundation.org>
References: <20221202120331.343a821d@gandalf.local.home>
        <ef842cd8-1228-54e2-c298-f524be7abc59@linuxfoundation.org>
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

On Fri, 2 Dec 2022 10:56:18 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/2/22 10:03, Steven Rostedt wrote:
> >  From 8bb1734388b89bdb2ac176882786dc02b7df92c2 Mon Sep 17 00:00:00 2001  
> 
> Steve,
> 
> git am doesn't like the line above and I get "Patch is empty"
> error.
> 
> I had to manually remove this to apply the patch to linux-kselftest
> next for the merge window.
> 
> Please check if there is something in your workflow that adds this
> problematic line.
> 

When I do single patches, I just insert the format-patch output directly,
and sometimes I forget to trim it :-/

Thanks,

-- Steve

