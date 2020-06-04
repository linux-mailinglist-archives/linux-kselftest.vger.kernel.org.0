Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ADE1EE780
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgFDPQW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jun 2020 11:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgFDPQW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jun 2020 11:16:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC9420738;
        Thu,  4 Jun 2020 15:16:21 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:16:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Message-ID: <20200604111620.1168c2d9@gandalf.local.home>
In-Reply-To: <20200605000850.9dc797919133e3e245ceda99@kernel.org>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
        <159108891139.42416.16735397217311780715.stgit@devnote2>
        <20200602092145.06afaf72@gandalf.local.home>
        <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
        <20200603103343.2db5b5c6@gandalf.local.home>
        <20200605000850.9dc797919133e3e245ceda99@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 5 Jun 2020 00:08:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Thanks, and I've already sent v3.
> 
> https://lkml.kernel.org/r/159115200085.70027.6141550347953439240.stgit@devnote2

I tested that too, and you can keep my Reviewed-by on the patch set.

Shuah,

Want to take v3 for 5.9?

-- Steve
