Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF21A9099
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 03:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392721AbgDOBqv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 21:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392682AbgDOBqp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 21:46:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9277C20732;
        Wed, 15 Apr 2020 01:46:44 +0000 (UTC)
Date:   Tue, 14 Apr 2020 21:46:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Xiao Yang <ice_yangxiao@163.com>
Subject: Re: [PATCH v2] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
Message-ID: <20200414214643.2e14ac76@oasis.local.home>
In-Reply-To: <5E966604.1020400@cn.fujitsu.com>
References: <f4e4614b-e3df-e255-42d0-1148e39b3f8a@web.de>
        <5E966604.1020400@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Apr 2020 09:40:20 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/4/14 15:54, Markus Elfring wrote:
> >> Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()  
> >
> > I suggest to improve the change description.
> >
> > * Adjustment:
> >    … operation (i. e. …  
> Hi Markus,
> 
> Which part of description do you want to change or could you provide an 
> example for reference?

That part is fine for me.

> 
> >
> > * Will the tag “Fixes” become relevant?  
> 
> Do you mean to add the following "Fixes" tag?
> Fixes: 93e31ffbf417 "tracing: Add 'snapshot' event trigger command"
> 

Yeah, that fixes tag is appropriate. But I usually add those myself, you
don't need to resend.

-- Steve
