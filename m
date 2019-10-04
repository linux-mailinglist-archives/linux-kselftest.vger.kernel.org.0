Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E172BCC33C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfJDTBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 15:01:20 -0400
Received: from smtp1.linuxfoundation.org ([140.211.169.13]:34874 "EHLO
        smtp1.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDTBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 15:01:20 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 15:01:19 EDT
Received: from rt.cvo.linuxfoundation.org (rt.cvo.linuxfoundation.org [172.17.192.131])
        by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2F62F735;
        Fri,  4 Oct 2019 18:55:48 +0000 (UTC)
Received: by rt.cvo.linuxfoundation.org (Postfix, from userid 48)
        id 1AD13706; Fri,  4 Oct 2019 18:55:48 +0000 (UTC)
Subject: [Kernel.org Helpdesk #80110] Bugzilla Component for KUnit?
From:   "Konstantin Ryabitsev via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20191002215351.GA177672@google.com>
References: <RT-Ticket-80110@linuxfoundation>
 <20191002215351.GA177672@google.com>
Message-ID: <rt-4.4.0-12639-1570215347-1334.80110-6-0@linuxfoundation>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #80110
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: konstantin@linuxfoundation.org
To:     brendanhiggins@google.com
CC:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Fri, 04 Oct 2019 14:55:48 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2019-10-02 17:53:58, brendanhiggins@google.com wrote:
> Hi,
> 
> I am thinking about requesting a Bugzilla component for my kernel
> project KUnit. I am not sure if this is the right place for it.  Some
> background on KUnit: We are working on adding unit testing for the
> Linux
> kernel[1][2]. We have our initial patchset that introduces the
> subsystem
> in the process of being merged (Linus sent our PR back to us for a
> minor
> fix[3], so it should be in either 5.4-rc2 or 5.5, but is nevertheless
> in
> linux-next). However, we also have a staging repo that people are
> using
> and some supporting code that lives outside of the kernel.
> 
> So I am trying to figure out:
> 
> 1. Is it appropriate to request a Bugzilla component before our
>    subsystem has been merged into torvalds/master? I would just wait,
>    but I have some users looking to file issues, so I would prefer to
>    provide them something sooner rather than later.
> 
> 2. Is it appropriate to use the kernel's Bugzilla to track issues
>    outside of the Linux kernel? As I mention above, we have code that
>    lives outside of the kernel; is it appropriate to use kernel.org's
>    Bugzilla for this?
> 
> 3. Does Bugzilla match my planned usage model? It doesn't look like
>    Bugzilla get's much usage aside from reporting bugs. I want to use
>    it for tracking feature progress and things like that. Is that
> okay?

Yes, we can certainly host this on bugzilla.kernel.org. Would you be okay with Tools/KUnit as product/category?

Regards,
-- 
Konstantin Ryabitsev
Director, LF Projects IT
The Linux Foundation
