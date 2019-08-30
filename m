Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2564A4018
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3WGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 18:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfH3WGu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 18:06:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B7923431;
        Fri, 30 Aug 2019 22:06:48 +0000 (UTC)
Date:   Fri, 30 Aug 2019 18:06:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     shuah <shuah@kernel.org>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/ftrace: Fix typo in trigger-snapshot.tc
Message-ID: <20190830180647.118523b4@gandalf.local.home>
In-Reply-To: <2484ed4e-2a59-07f3-3f00-4ac3d1178621@kernel.org>
References: <20190803000126.23200-1-standby24x7@gmail.com>
        <20190830173154.467d9335@gandalf.local.home>
        <2484ed4e-2a59-07f3-3f00-4ac3d1178621@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 30 Aug 2019 15:47:01 -0600
shuah <shuah@kernel.org> wrote:

> On 8/30/19 3:31 PM, Steven Rostedt wrote:
> > On Sat,  3 Aug 2019 09:01:26 +0900
> > Masanari Iida <standby24x7@gmail.com> wrote:
> >   
> >> This patch fixes a spelling typo in tigger-snapshot.tc
> >>  
> > 
> > As Randy said: "trigger-snapshot.tc"
> > 
> > Shuah, can you take this?
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >   
> 
> Done. Applied with typo fix to the commit log.
> 

Thanks Shuah!

-- Steve
