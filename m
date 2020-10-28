Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2735829DEAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 01:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgJ2A4D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 20:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbgJ1WRh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F6422384;
        Wed, 28 Oct 2020 02:46:59 +0000 (UTC)
Date:   Tue, 27 Oct 2020 22:46:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201027224657.413fd7bd@oasis.local.home>
In-Reply-To: <cedad9bf-ba6b-78ad-644f-ce5074f2fbed@linuxfoundation.org>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
        <20201023093523.65c495f8@gandalf.local.home>
        <20201023151243.GA1537@oc3871087118.ibm.com>
        <20201023114948.6900aa68@gandalf.local.home>
        <20201023115111.1c0e8768@gandalf.local.home>
        <cedad9bf-ba6b-78ad-644f-ce5074f2fbed@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Oct 2020 15:55:32 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:


> > Let me pull in the latest changes, and whip up a patch that works on both
> > the older kernels as well as the newer ones.
> > 
> > -- Steve
> >   
> 
> Assume this is handled by
> 
> selftests/ftrace: Use $FUNCTION_FORK to reference kernel fork function
> https://patchwork.kernel.org/project/linux-kselftest/patch/20201026162032.124c728d@gandalf.local.home/
> 
> Just making sure.

Yep, that was the result of this thread.

Thanks Shuah,

-- Steve

