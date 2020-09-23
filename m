Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DD275EEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWRoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 13:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIWRoB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 13:44:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2606D2223E;
        Wed, 23 Sep 2020 17:44:00 +0000 (UTC)
Date:   Wed, 23 Sep 2020 13:43:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: BUG: kernel NULL pointer dereference, address:
 trace_event_raw_event_sched_switch
Message-ID: <20200923134358.11a83a5a@oasis.local.home>
In-Reply-To: <CA+G9fYsT+MREZ=yPb3t=Rh+MCxz6q7p_tSJ_oeh92Sd3ro+PRw@mail.gmail.com>
References: <CA+G9fYsT+MREZ=yPb3t=Rh+MCxz6q7p_tSJ_oeh92Sd3ro+PRw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Sep 2020 22:21:32 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> While running kselftest ftracetest on i386 the kernel crash reported
> on linux next tag
> 5.9.0-rc5-next-20200921.
> Good news is that this crash is not seen on today's linux next tag 20200923.

Since it appears that the 20200921 tag no longer exists (at least not
where I can see it), I can simply ignore this?

-- Steve
