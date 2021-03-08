Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E817933133B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCHQSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 11:18:47 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:50380 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCHQSe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 11:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RmNhH5XRUuG3UKqdqRAk2ui+eZgYvhYalUYwnX71Zk0=; b=kS52GJXBfoLqcsm0bQi3+gnsis
        E1MCGH5z67nXrZMNX0E2lDQ3VK9yevVudpCJpLA90DM1/rPQq6fbBcJAumwhff+rR+gW/2bm+aJ3I
        yfnYJwLObFRwvIkuKgJRHUwi3FDXQq85J1UOd1kkseYu/4J/p/XMUsEJI8wbHjg2ybPY=;
Received: from [10.69.139.34]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zfigura@codeweavers.com>)
        id 1lJIaU-0003bZ-9h; Mon, 08 Mar 2021 10:18:30 -0600
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net
References: <20210304004219.134051-1-andrealmeid@collabora.com>
From:   Zebediah Figura <zfigura@codeweavers.com>
Message-ID: <2421ca75-5688-61c6-c0ac-02e55e7272a3@codeweavers.com>
Date:   Mon, 8 Mar 2021 10:18:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210304004219.134051-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/21 6:42 PM, André Almeida wrote:
>   ** The wait on multiple problem
> 
>   The use case lies in the Wine implementation of the Windows NT interface
>   WaitMultipleObjects. This Windows API function allows a thread to sleep
>   waiting on the first of a set of event sources (mutexes, timers, signal,
>   console input, etc) to signal.  Considering this is a primitive
>   synchronization operation for Windows applications, being able to quickly
>   signal events on the producer side, and quickly go to sleep on the
>   consumer side is essential for good performance of those running over Wine.

It's probably worth pointing out, for better or for worse, while this is 
*a* use case, it's also limited to an out-of-tree patch set/forked 
versions of Wine. I'm currently working on a different approach that 
should be upstreamable to Wine proper, as detailed in [1].

[1] 
https://lore.kernel.org/lkml/f4cc1a38-1441-62f8-47e4-0c67f5ad1d43@codeweavers.com/
