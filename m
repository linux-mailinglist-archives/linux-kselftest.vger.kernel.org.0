Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE619E1FC
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDDAlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 20:41:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48197 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgDDAlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 20:41:10 -0400
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; 
   d="scan'208";a="88474987"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Apr 2020 08:41:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6859950A999A;
        Sat,  4 Apr 2020 08:30:45 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sat, 4 Apr 2020 08:41:05 +0800
Message-ID: <5E87D79F.9030807@cn.fujitsu.com>
Date:   Sat, 4 Apr 2020 08:41:03 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Always enable ftrace_enabled for ftrace
 testcases
References: <20200403082929.1869-1-yangx.jy@cn.fujitsu.com>        <20200403092204.79bb6dc7@gandalf.local.home>        <5E874FD5.9020907@cn.fujitsu.com>        <20200403111525.1a713576@gandalf.local.home>        <5E875807.7040109@cn.fujitsu.com> <20200403123144.66d474a6@gandalf.local.home>
In-Reply-To: <20200403123144.66d474a6@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 6859950A999A.A9C49
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/4/4 0:31, Steven Rostedt wrote:
> As I'm considering just removing ftrace_enable, I'm going to keep the tests
> as is.
Hi Steven,

Thanks for your explanation.
It is reasonable for me to keep the tests.

Thanks,
Xiao Yang



