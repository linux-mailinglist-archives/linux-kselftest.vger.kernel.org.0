Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3C31F021
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhBRTlt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Feb 2021 14:41:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42370 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhBRTNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Feb 2021 14:13:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E2A681F45E51
Subject: Re: [RFC PATCH 06/13] docs: locking: futex2: Add documentation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        acme@kernel.org, corbet@lwn.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-7-andrealmeid@collabora.com>
 <4e70780e-1a4d-79a9-e183-44a3454e0298@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <2a88124e-6cc1-a886-6076-affeb25039f7@collabora.com>
Date:   Thu, 18 Feb 2021 16:12:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4e70780e-1a4d-79a9-e183-44a3454e0298@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Randy,

Thanks for the feedback. All suggestions/fixes were applied for next 
version.

Às 15:34 de 16/02/21, Randy Dunlap escreveu:
> On 2/15/21 7:23 AM, André Almeida wrote:
>> Add a new documentation file specifying both userspace API and internal
>> implementation details of futex2 syscalls.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
