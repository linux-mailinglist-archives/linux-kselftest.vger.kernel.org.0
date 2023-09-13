Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2479DE70
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 05:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIMDBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 23:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjIMDBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 23:01:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958D10F7;
        Tue, 12 Sep 2023 20:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5101C433C8;
        Wed, 13 Sep 2023 03:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694574097;
        bh=F8bl2DbCzDBsTUKDv3rVr02AaeyY+56PVhs05mU6/Fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m1hRhxVsP2lXowGgNWYqy5n/3zpFidVnI994D3uYOqaGmWqZ3X8dJFB94N8VwRvWx
         neiX1MUUEzRfGmvKxt8GRh6I1PraPYN7+q54jAcMfmNoeEaFazxvPymM1H6Hd6LdU4
         mo2Ptyii4gutVZ5UO8whxjzgngyvHykqhfOo9kiHKToiR62v4Tk0gTfpojyo+OuX1E
         0n7ehzCTsMbdgCFBs292Z/tl+kzBthBwbpuZEpnIOTVBbcYhvVEVacwNU4O+noD0Bn
         dVWDvi0PcCHOZ64zgKYASsnnPKUBxd7TrwGdgJ9HHeTcvjMy4Y/kJx1/77W14BSJJK
         fNLvWUZdijWtw==
Date:   Wed, 13 Sep 2023 12:01:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [FIX PATCH v2] selftests: tracing: Fix to unmount tracefs for
 recovering environment
Message-Id: <20230913120134.ebe446942ad5d3b883c3e9a6@kernel.org>
In-Reply-To: <49f6d44b-b6e8-bfca-1df7-3ab94684902e@linuxfoundation.org>
References: <169448103881.242465.4589561134225171701.stgit@devnote2>
        <20230911212453.58b9082a@gandalf.local.home>
        <49f6d44b-b6e8-bfca-1df7-3ab94684902e@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Sep 2023 09:35:58 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 9/11/23 19:24, Steven Rostedt wrote:
> > On Tue, 12 Sep 2023 10:10:39 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> >> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>
> >> Fix to unmount the tracefs if the ftracetest mounted it for recovering
> >> system environment. If the tracefs is already mounted, this does nothing.
> >>
> >> Suggested-by: Mark Brown <broonie@kernel.org>
> >> Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
> >> Fixes: cbd965bde74c ("ftrace/selftests: Return the skip code when tracing directory not configured in kernel")
> >> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> ---
> >>   Changes in v2:
> >>     - use -n option explictly for testing the string is non-zero.
> >> ---
> >>   tool
> > 
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > -- Steve
> 
> Thank you all. Applied to linux-kselftest fixes branch for next rc
> 

Thanks Shuah!


> thanks,
> -- Shuah


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
