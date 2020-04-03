Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77F519DA4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404365AbgDCPgr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 11:36:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44501 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403936AbgDCPgq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 11:36:46 -0400
X-IronPort-AV: E=Sophos;i="5.72,340,1580745600"; 
   d="scan'208";a="88459583"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2020 23:36:44 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id A670150A9960;
        Fri,  3 Apr 2020 23:26:21 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 3 Apr 2020 23:36:41 +0800
Message-ID: <5E875807.7040109@cn.fujitsu.com>
Date:   Fri, 3 Apr 2020 23:36:39 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Always enable ftrace_enabled for ftrace
 testcases
References: <20200403082929.1869-1-yangx.jy@cn.fujitsu.com>        <20200403092204.79bb6dc7@gandalf.local.home>        <5E874FD5.9020907@cn.fujitsu.com> <20200403111525.1a713576@gandalf.local.home>
In-Reply-To: <20200403111525.1a713576@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: A670150A9960.A8A61
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/4/3 23:15, Steven Rostedt wrote:
>>> Why would it be disabled by default? Anyway, I'm thinking failure is the
>>> >  >  right answer if ftrace_enable is off.
>> >
>> >  Sorry, it seems better to say that ftrace_enabled is disabled by user.
> But then why would you run the tests after disabling it?
Hi Steven,

I disabled it accidentally.

>
>> >
>> >  I got 75 pass and 19 failure if ftrace_enable is off. Just have some
>> >  questions:
>> >
>> >  1) Is it necessary to run all testcases if ftrace_enable is off?
>> >  2) Is is expected to get pass if ftrace_enable is off?
>> >       (I can understand that failure is expected if ftrace_enable is off)
> Because its a way to test the tests!

I think that all tests depend on ftrace_enabled and running them should 
report "not supported" or enable it automatically when it is disabled.

Thanks,
Xiao Yang





