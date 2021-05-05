Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22066373B55
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 May 2021 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhEEMfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 08:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhEEMfI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 08:35:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57661C061574;
        Wed,  5 May 2021 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6nDsAgZyLnevi7PNrWtRehL0qNVNJeXiu/AjwzP/hUk=; b=O7jZ7bKH59HOcHeEyNTXh8RSfj
        88AvWhK7SQ4O5d4bGiPLmvEQB2HI19SdqztgzDdK3mZ3wuw52rwJGJZsHl5VcWSQANqvUKg3UgMPl
        dCWsPW/PwURSbV139Zan4c5cNQThZdkNcdvFE52oCiI1VLSEOW56vWlHhtmWbmuMXMIcdgQLjgTYt
        jPOyze3oUKY05vcIpCPEXesuf46GtpoANYw2vYVn+Yg5RAgBcdAEnI/LFQM4fV7fZMesB/aVdnghR
        ku/oVm2Pgipn+DFtm/4hPq8r5uZbMK3u2f24428SC9coFZ2YpSswu8t9BHpHGObzdF8b1fl5JiL0U
        yA61Td/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leGgr-001CkZ-31; Wed, 05 May 2021 12:33:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45319300103;
        Wed,  5 May 2021 14:31:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C245203E67FA; Wed,  5 May 2021 14:31:43 +0200 (CEST)
Date:   Wed, 5 May 2021 14:31:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH v3 00/13] Add futex2 syscalls
Message-ID: <YJKQLkHuTH3EWJoR@hirez.programming.kicks-ass.net>
References: <20210427231248.220501-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210427231248.220501-1-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 27, 2021 at 08:12:35PM -0300, André Almeida wrote:
> Hi,
> 
> This patch series introduces the futex2 syscalls.

I still utterly detest that this adds a second hash-table for no
descernable reason.

The new syscall interface does not depend on that in any way, you
previously implemented the multi-wait thing in the current futex code.

Like I said last time; I'm okay with the new interface, but I don't see
why you need to reimplement the insides, that's all pointless code
duplication.
