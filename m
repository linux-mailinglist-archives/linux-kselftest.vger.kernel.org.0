Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322D82AF6BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKKQmS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 11:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgKKQmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 11:42:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91FBC0613D1;
        Wed, 11 Nov 2020 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CdmQLCwtYnJ5737miMX6EDzo04FbVACXjJLBV8q9mKA=; b=Km1fuPPHydJXaMwRTIxnTPT7pO
        pBU+59/VZfX5+xusAShQ4joPY0E+weOOpsFrbpcjoBXqybcfQCo20iR0qOx84e37PHNvivcx13mhg
        kZLfAEDCCsFHPMVKhaaLWI3JbuPdA79ERGR5z5Y2JKW84K+BdzUVao/f5nFSFvG/8T23p26PAd1+8
        Sc9oTLXb56vCknvvtNf6xsfcfjwrBZOhFIaVp7SSel7dlQDtw+Cb8e9qg4OKMbVxzPdyfuHM3Ab+B
        FZSEmkPx0JPBQacjL5Z+Y4ZGf8Wkmwuio1lE5oZpUmXji4lB70vEynRHF5/EMdIwopzpaxPOx93A9
        r93p8KYg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kctBx-00026P-W3; Wed, 11 Nov 2020 16:41:54 +0000
Date:   Wed, 11 Nov 2020 16:41:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/13] Introduce seqnum_ops
Message-ID: <20201111164153.GV17076@casper.infradead.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <20201111043304.GS17076@casper.infradead.org>
 <e84de5d0-f2b2-5481-eb8e-47370d632c4d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84de5d0-f2b2-5481-eb8e-47370d632c4d@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 09:03:20AM -0700, Shuah Khan wrote:
> On 11/10/20 9:33 PM, Matthew Wilcox wrote:
> > On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
> > > There are a number of atomic_t usages in the kernel where atomic_t api
> > > is used strictly for counting sequence numbers and other statistical
> > > counters and not for managing object lifetime.
> > 
> > We already have something in Linux called a sequence counter, and it's
> > different from this.  ID counter?  instance number?  monotonic_t?  stat_t?
> > 
> 
> No results for monotonic_t or stat_t. Can you give me a pointer to what
> your referring to.

We have a seqcount_t.  We need to call this something different.
maybe we should call it stat_t (and for that usage, stat_add() as well
as stat_inc() is a legitimate API to have).
