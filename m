Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47019DBBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbgDCQbr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 12:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404251AbgDCQbr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 12:31:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AD8206F8;
        Fri,  3 Apr 2020 16:31:46 +0000 (UTC)
Date:   Fri, 3 Apr 2020 12:31:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     <mingo@redhat.com>, <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Always enable ftrace_enabled for
 ftrace testcases
Message-ID: <20200403123144.66d474a6@gandalf.local.home>
In-Reply-To: <5E875807.7040109@cn.fujitsu.com>
References: <20200403082929.1869-1-yangx.jy@cn.fujitsu.com>
        <20200403092204.79bb6dc7@gandalf.local.home>
        <5E874FD5.9020907@cn.fujitsu.com>
        <20200403111525.1a713576@gandalf.local.home>
        <5E875807.7040109@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 3 Apr 2020 23:36:39 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> >> >  1) Is it necessary to run all testcases if ftrace_enable is off?
> >> >  2) Is is expected to get pass if ftrace_enable is off?
> >> >       (I can understand that failure is expected if ftrace_enable is off)  
> > Because its a way to test the tests!  
> 
> I think that all tests depend on ftrace_enabled and running them should 
> report "not supported" or enable it automatically when it is disabled.

As I'm considering just removing ftrace_enable, I'm going to keep the tests
as is.

Thanks,

-- Steve
