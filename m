Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758251A908C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 03:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbgDOBkc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 21:40:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17049 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392662AbgDOBkb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 21:40:31 -0400
X-IronPort-AV: E=Sophos;i="5.72,385,1580745600"; 
   d="scan'208";a="89043254"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Apr 2020 09:40:28 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id AA7D9406AB15;
        Wed, 15 Apr 2020 09:29:53 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 15 Apr 2020 09:40:22 +0800
Message-ID: <5E966604.1020400@cn.fujitsu.com>
Date:   Wed, 15 Apr 2020 09:40:20 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiao Yang <ice_yangxiao@163.com>
Subject: Re: [PATCH v2] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
References: <f4e4614b-e3df-e255-42d0-1148e39b3f8a@web.de>
In-Reply-To: <f4e4614b-e3df-e255-42d0-1148e39b3f8a@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: AA7D9406AB15.AD627
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020/4/14 15:54, Markus Elfring wrote:
>> Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()
>
> I suggest to improve the change description.
>
> * Adjustment:
>    … operation (i. e. …
Hi Markus,

Which part of description do you want to change or could you provide an 
example for reference?

>
> * Will the tag “Fixes” become relevant?

Do you mean to add the following "Fixes" tag?
Fixes: 93e31ffbf417 "tracing: Add 'snapshot' event trigger command"

Thanks,
Xiao Yang
>
> Regards,
> Markus
>
>
> .
>



