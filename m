Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370A919D9AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbgDCPBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 11:01:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23627 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404057AbgDCPBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 11:01:50 -0400
X-IronPort-AV: E=Sophos;i="5.72,340,1580745600"; 
   d="scan'208";a="88458355"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2020 23:01:43 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4E0A450A9960;
        Fri,  3 Apr 2020 22:51:24 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 3 Apr 2020 23:01:44 +0800
Message-ID: <5E874FD5.9020907@cn.fujitsu.com>
Date:   Fri, 3 Apr 2020 23:01:41 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Always enable ftrace_enabled for ftrace
 testcases
References: <20200403082929.1869-1-yangx.jy@cn.fujitsu.com> <20200403092204.79bb6dc7@gandalf.local.home>
In-Reply-To: <20200403092204.79bb6dc7@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 4E0A450A9960.AA0AF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/4/3 21:22, Steven Rostedt wrote:
> On Fri, 3 Apr 2020 16:29:29 +0800
> Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>
>> A lot of ftrace testcases get failure if ftrace_enabled is disabled by default
>> because ftrace_enabled is a big on/off switch for the whole function tracer.
>
Hi Steve

Thanks for your quick reply.

> Why would it be disabled by default? Anyway, I'm thinking failure is the
> right answer if ftrace_enable is off.

Sorry, it seems better to say that ftrace_enabled is disabled by user.

I got 75 pass and 19 failure if ftrace_enable is off. Just have some 
questions:

1) Is it necessary to run all testcases if ftrace_enable is off?
2) Is is expected to get pass if ftrace_enable is off?
    (I can understand that failure is expected if ftrace_enable is off)

Attach the test log:
------------------------------------------------
[root@Fedora-31 20200403-141956]# cat ftracetest.log
Fri 03 Apr 2020 02:19:56 PM CST
=== Ftrace unit tests ===
[1] Basic trace file check      [PASS]
[2] Basic test for tracers      [PASS]
[3] Basic trace clock test      [PASS]
[4] Basic event tracing check   [PASS]
[5] Change the ringbuffer size  [PASS]
[6] Snapshot and tracing setting        [PASS]
[7] trace_pipe and trace_marker [PASS]
[8] Test ftrace direct functions against tracers        [UNRESOLVED]
[9] Test ftrace direct functions against kprobes        [UNRESOLVED]
[10] Generic dynamic event - add/remove kprobe events   [PASS]
[11] Generic dynamic event - add/remove synthetic events        [PASS]
[12] Generic dynamic event - selective clear (compatibility)    [PASS]
[13] Generic dynamic event - generic clear event        [PASS]
[14] event tracing - enable/disable with event level files      [PASS]
[15] event tracing - restricts events based on pid      [PASS]
[16] event tracing - enable/disable with subsystem level files  [PASS]
[17] event tracing - enable/disable with top level files        [PASS]
[18] Test trace_printk from module      [UNRESOLVED]
[19] ftrace - function graph filters with stack tracer  [FAIL]
[20] ftrace - function graph filters    [FAIL]
[21] ftrace - function trace with cpumask       [PASS]
[22] ftrace - test for function event triggers  [FAIL]
[23] ftrace - function glob filters     [PASS]
[24] ftrace - function pid filters      [FAIL]
[25] ftrace - stacktrace filter command [FAIL]
[26] ftrace - function trace on module  [UNRESOLVED]
[27] ftrace - function profiler with function tracing   [FAIL]
[28] ftrace - function profiling        [PASS]
[29] ftrace - test reading of set_ftrace_filter [PASS]
[30] ftrace - Max stack tracer  [PASS]
[31] ftrace - test for function traceon/off triggers    [FAIL]
[32] ftrace - test tracing error log support    [PASS]
[33] Test creation and deletion of trace instances while setting an 
event       [PASS]
[34] Test creation and deletion of trace instances      [PASS]
[35] Kprobe dynamic event - adding and removing [PASS]
[36] Kprobe dynamic event - busy event check    [PASS]
[37] Kprobe event with comm arguments   [FAIL]
[38] Kprobe event string type argument  [FAIL]
[39] Kprobe event symbol argument       [FAIL]
[40] Kprobe event argument syntax       [PASS]
[41] Kprobe dynamic event with arguments        [FAIL]
[42] Kprobes event arguments with types [FAIL]
[43] Kprobe event user-memory access    [FAIL]
[44] Kprobe event auto/manual naming    [PASS]
[45] Kprobe dynamic event with function tracer  [FAIL]
[46] Kprobe dynamic event - probing module      [UNRESOLVED]
[47] Create/delete multiprobe on kprobe event   [PASS]
[48] Kprobe event parser error log check        [PASS]
[49] Kretprobe dynamic event with arguments     [FAIL]
[50] Kretprobe dynamic event with maxactive     [PASS]
[51] Register/unregister many kprobe events     [PASS]
[52] Kprobe events - probe points       [PASS]
[53] Kprobe dynamic event - adding and removing [PASS]
[54] Uprobe event parser error log check        [PASS]
[55] test for the preemptirqsoff tracer [UNSUPPORTED]
[56] Meta-selftest      [UNRESOLVED]
[57] Test wakeup RT tracer      [PASS]
[58] Test wakeup tracer [PASS]
[59] event trigger - test inter-event histogram trigger expected fail 
actions   [XFAIL]
[60] event trigger - test field variable support        [PASS]
[61] event trigger - test inter-event combined histogram trigger 
[PASS]
[62] event trigger - test multiple actions on hist trigger      [PASS]
[63] event trigger - test inter-event histogram trigger onchange action 
[PASS]
[64] event trigger - test inter-event histogram trigger onmatch action 
[PASS]
[65] event trigger - test inter-event histogram trigger onmatch-onmax 
action    [PASS]
[66] event trigger - test inter-event histogram trigger onmax action 
[PASS]
[67] event trigger - test inter-event histogram trigger snapshot action 
[PASS]
[68] event trigger - test synthetic event create remove [PASS]
[69] event trigger - test synthetic_events syntax parser        [PASS]
[70] event trigger - test inter-event histogram trigger trace action 
[PASS]
[71] event trigger - test event enable/disable trigger  [PASS]
[72] event trigger - test trigger filter        [PASS]
[73] event trigger - test histogram modifiers   [PASS]
[74] event trigger - test histogram parser errors       [PASS]
[75] event trigger - test histogram trigger     [PASS]
[76] event trigger - test multiple histogram triggers   [PASS]
[77] event trigger - test snapshot-trigger      [PASS]
[78] event trigger - test stacktrace-trigger    [PASS]
[79] trace_marker trigger - test histogram trigger      [PASS]
[80] trace_marker trigger - test snapshot trigger       [PASS]
[81] trace_marker trigger - test histogram with synthetic event against 
kernel event    [PASS]
[82] trace_marker trigger - test histogram with synthetic event [PASS]
[83] event trigger - test traceon/off trigger   [PASS]
[84] (instance)  Basic test for tracers [PASS]
[85] (instance)  Basic trace clock test [PASS]
[86] (instance)  Change the ringbuffer size     [PASS]
[87] (instance)  Snapshot and tracing setting   [PASS]
[88] (instance)  trace_pipe and trace_marker    [PASS]
[89] (instance)  event tracing - enable/disable with event level files 
[PASS]
[90] (instance)  event tracing - restricts events based on pid  [PASS]
[91] (instance)  event tracing - enable/disable with subsystem level 
files      [PASS]
[92] (instance)  ftrace - test for function event triggers      [FAIL]
[93] (instance)  ftrace - function pid filters  [FAIL]
[94] (instance)  ftrace - stacktrace filter command     [FAIL]
[95] (instance)  ftrace - test for function traceon/off triggers 
[FAIL]
[96] (instance)  event trigger - test event enable/disable trigger 
[PASS]
[97] (instance)  event trigger - test trigger filter    [PASS]
[98] (instance)  event trigger - test histogram modifiers       [PASS]
[99] (instance)  event trigger - test histogram trigger [PASS]
[100] (instance)  event trigger - test multiple histogram triggers 
[PASS]
[101] (instance)  trace_marker trigger - test histogram trigger [PASS]
[102] (instance)  trace_marker trigger - test snapshot trigger  [PASS]

# of passed:  75
# of failed:  19
# of unresolved:  6
# of untested:  0
# of unsupported:  1
# of xfailed:  1
# of undefined(test bug):  0
------------------------------------------------

Thanks,
Xiao Yang

>
> -- Steve
>
>
> .
>



