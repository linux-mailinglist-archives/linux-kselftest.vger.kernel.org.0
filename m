Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF939F936
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhFHOd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 10:33:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhFHOdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 10:33:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C61D219C1;
        Tue,  8 Jun 2021 14:31:42 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 23A03118DD;
        Tue,  8 Jun 2021 14:31:34 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kUhXOEZ/v2D8DwAALh3uQQ
        (envelope-from <dave@stgolabs.net>); Tue, 08 Jun 2021 14:31:34 +0000
Date:   Tue, 8 Jun 2021 07:31:26 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Darren Hart <dvhart@infradead.org>,
        fweimer@redhat.com, joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <20210608143126.xd6fvtdnoq6annq7@offworld>
References: <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
 <YL9Q2tKLZP6GKbHW@kroah.com>
 <YL9YLCY9/MkhOW7F@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YL9YLCY9/MkhOW7F@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 08 Jun 2021, Peter Zijlstra wrote:

>On Tue, Jun 08, 2021 at 01:13:30PM +0200, Greg KH wrote:
>> On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
>> So what's keeping the futex2 code from doing all that futex1 does so
>> that the futex1 code can be deleted internally?
>
>I'd much rather see it the other way around. Much of what futex2 does
>can already be done with the futex1 code-base. And then we can add
>features on top.

Yeah furthermore, how can futex2 be thought of replacing futex1 in the
future when the PI aspects haven't even been mentioned?

Thanks,
Davidlohr
