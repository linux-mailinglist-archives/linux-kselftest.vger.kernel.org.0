Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D426558C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 01:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIJXeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 19:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgIJXeg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 19:34:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65517208A9;
        Thu, 10 Sep 2020 23:34:35 +0000 (UTC)
Date:   Thu, 10 Sep 2020 19:34:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] tracing/boot: Add new options for tracing
 specific period
Message-ID: <20200910193433.236cf081@oasis.local.home>
In-Reply-To: <159972809455.428528.4737752126800169128.stgit@devnote2>
References: <159972809455.428528.4737752126800169128.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Sep 2020 17:54:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the series to improve the boot-time tracing to
> support kretprobe and tracing_on option. Previous version is here:
> 
>  https://lkml.kernel.org/r/159894698993.1478826.2813843560314595660.stgit@devnote2
> 
> This version adds uprobe %return suffix support ([5/8]) and the testcases
> ([8/8]), and update kprobe %suffix support([4/8]) and the uprobe event
> document([6/8]).
> 
> 
> The combination of tracing_on and kretprobe allows us to trace events
> while a specific function call period. For example, the below bootconfig
> will make a function callgraph in the pci_proc_init() function at boot
> time.
> 
> ftrace {
> 	tracing_on = 0  # off at start
> 	tracer = function_graph
> 	event.kprobes {
> 		start_event {
> 			probes = "pci_proc_init"
> 			actions = "traceon"
> 		}
> 		end_event {
> 			probes = "pci_proc_init%return"
> 			actions = "traceoff"
> 		}
> 	}
> }
> 
> Here is the example output;
> 

[..]

Hi Masami,

This looks really great! I just got back from a 10 day holiday, and I'm
drowning in "catch-up".  I plan on looking at all this relatively soon
(in a week or two?). I just don't want you to think I'm ignoring this.

-- Steve
