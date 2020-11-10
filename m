Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270332AE0DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKJUoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 15:44:16 -0500
Received: from netrider.rowland.org ([192.131.102.5]:56959 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726706AbgKJUoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 15:44:16 -0500
Received: (qmail 205608 invoked by uid 1000); 10 Nov 2020 15:44:14 -0500
Date:   Tue, 10 Nov 2020 15:44:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20201110204414.GA204624@rowland.harvard.edu>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used strictly for counting sequence numbers and other statistical
> counters and not for managing object lifetime.
> 
> The purpose of these Sequence Number Ops is to clearly differentiate
> atomic_t counter usages from atomic_t usages that guard object lifetimes,
> hence prone to overflow and underflow errors.
> 
> The atomic_t api provides a wide range of atomic operations as a base
> api to implement atomic counters, bitops, spinlock interfaces. The usages
> also evolved into being used for resource lifetimes and state management.
> The refcount_t api was introduced to address resource lifetime problems
> related to atomic_t wrapping. There is a large overlap between the
> atomic_t api used for resource lifetimes and just counters, stats, and
> sequence numbers. It has become difficult to differentiate between the
> atomic_t usages that should be converted to refcount_t and the ones that
> can be left alone. Introducing seqnum_ops to wrap the usages that are
> stats, counters, sequence numbers makes it easier for tools that scan
> for underflow and overflow on atomic_t usages to detect overflow and
> underflows to scan just the cases that are prone to errors.
> 
> Sequence Number api provides interfaces for simple atomic_t counter usages
> that just count, and don't guard resource lifetimes. The seqnum_ops are
> built on top of atomic_t api, providing a smaller subset of atomic_t
> interfaces necessary to support atomic_t usages as simple counters.
> This api has init/set/inc/dec/read and doesn't support any other atomic_t
> ops with the intent to restrict the use of these interfaces as simple
> counting usages.
> 
> Sequence Numbers wrap around to INT_MIN when it overflows and should not
> be used to guard resource lifetimes, device usage and open counts that
> control state changes, and pm states. Overflowing to INT_MIN is consistent
> with the atomic_t api, which it is built on top of.

If Sequence Numbers are subject to wraparound then they aren't reliable.  
Given that they aren't reliable, why use atomic instructions at all?  
Why not just use plain regular integers with READ_ONCE and WRITE_ONCE?

Alan Stern
