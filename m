Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3051FD028
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQO61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 10:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQO61 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 10:58:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 195F62073E;
        Wed, 17 Jun 2020 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592405906;
        bh=Oe3ctSYHh81sJ9zFPkFFSb61TFxBF9INoUBqGvQuqwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0ukF5hfuc4+4JVXkkpjVkV68bHjNuoYc0UbW/yLPg3/17DpXVUDwsX72W0Vrhz3V
         xahHsFYkd0emOZcbFmuMBqt0tRGWGHAnKMMS+pTZtQaH6PsS3qzONdsaL1X4mJ9s13
         EsdEATfmBiWTbMTu3d/Mu5V8uiRx2nT5KIuvdsy4=
Date:   Wed, 17 Jun 2020 23:58:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
Message-Id: <20200617235822.76b94496733a3d7c5bb647b6@kernel.org>
In-Reply-To: <41b50b37-c9cb-9e7c-3ea7-d0824a41c03c@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
        <159115203782.70027.2241223276591824366.stgit@devnote2>
        <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
        <20200610145535.747d2765d60e6e3923441768@kernel.org>
        <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
        <20200610093206.5b9fb1b7@oasis.local.home>
        <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
        <41b50b37-c9cb-9e7c-3ea7-d0824a41c03c@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Tue, 16 Jun 2020 10:48:12 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 6/11/20 6:03 AM, Shuah Khan wrote:
> > On 6/10/20 7:32 AM, Steven Rostedt wrote:
> >> On Wed, 10 Jun 2020 06:04:33 -0600
> >> Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >>>> Steve, what would you think?
> >>>
> >>> No worries. As far as kselftest tree is concrned, I can apply these
> >>> after rc1 comes out with Tom's patch.
> >>>
> >>> Or I can give Ack and Steve can take these through tracing tree.
> >>
> >> All my patches have already made it to Linus's tree. Perhaps
> >> cherry-pick the commit needed from Linus's tree (it shouldn't break
> >> anything when Linus pulls it). Just let Linus know what you did, and
> >> everything should be fine.
> >>
> > 
> > Good to know. I will get these in.
> > 
> 
> I applied all 7 patches to linux-kselftest next for my second update.
> I saw a couple of merge problems with 4/7 patch even when I applied
> it on top of with Tom's patch.

Oh, I might miss something.

> 
> I resolved them and amended the commit message to indicate the merge.
> It is straight forward. Please check for sanity.

Yes, I confirmed that the merge looks good, and also test ran out
without any error. :)

Thank you!

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu <mhiramat@kernel.org>
