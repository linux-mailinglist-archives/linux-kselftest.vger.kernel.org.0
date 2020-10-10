Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0428A3A4
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Oct 2020 01:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgJJW4x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Oct 2020 18:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbgJJTxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B0C0613B4;
        Sat, 10 Oct 2020 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6cV+tWxBY2tCvh0w9RakejaDPboIY9tCeHrHg2GCiPA=; b=eBUno4bXjQVLTMDPOm+sW25Lwv
        cowKD724NzwUh0wGoDX2eG2v9P5KJVKb8dHlTaXOU5VS9yonxo5dacyZ9QBDrEL6/NHu9yrFDVlul
        uJaKEt4lT+vM8kcKN1F9biakAjn/UcusJA6djK/yyy9on5fKvTsxSO+3sp/2KlZsoUnoiEKzwrMB4
        7TSBcjnZnVEnKSgMC/MZVlM/dgfJ6XN++gsUwy/SxMYtctBJGqU5CSC+MXoSkcGbzs6L+g82bBhNO
        Y/Lg46iD7UQGhyO+fwbJTDWyUte30Cln331o8ECV+9e4trlBM1tLfDi1pnpFFiEEQbQZdIxL/9tRX
        HbGqIARQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRCkg-00026L-PN; Sat, 10 Oct 2020 11:09:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BEED3003E5;
        Sat, 10 Oct 2020 13:09:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 017E52010B5FA; Sat, 10 Oct 2020 13:09:20 +0200 (CEST)
Date:   Sat, 10 Oct 2020 13:09:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, shuah@kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
Message-ID: <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010091255.246395A6@keescook>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 09, 2020 at 01:45:43PM -0700, Kees Cook wrote:
> On Fri, Oct 09, 2020 at 09:37:46PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 09:55:55AM -0600, Shuah Khan wrote:
> > > Simple atomic counters api provides interfaces for simple atomic counters
> > > that just count, and don't guard resource lifetimes. The interfaces are
> > > built on top of atomic_t api, providing a smaller subset of atomic_t
> > > interfaces necessary to support simple counters.
> > 
> > To what actual purpose?!? AFACIT its pointless wrappery, it gets us
> > nothing.
> 
> It's not pointless. There is value is separating types for behavioral
> constraint to avoid flaws. atomic_t provides a native operation. We gained
> refcount_t for the "must not wrap" type, and this gets us the other side
> of that behavioral type, which is "wrapping is expected". Separating the
> atomic_t uses allows for a clearer path to being able to reason about
> code flow, whether it be a human or a static analyzer.

refcount_t got us actual rutime exceptions that atomic_t doesn't. This
propsal gets us nothing.

atomic_t is very much expected to wrap.

> The counter wrappers add nothing to the image size, and only serve to
> confine the API to one that cannot be used for lifetime management.

It doesn't add anything period. It doesn't get us new behaviour, it
splits a 'can wrap' use-case from a 'can wrap' type. That's sodding
pointless.

Worse, it mixes 2 unrelated cases into one type, which just makes a
mockery of things (all the inc_return users are not statistics, some
might even mis-behave if they wrap).

> Once conversions are done, we have a clean line between refcounting
> and statistical atomics, which means we have a much lower chance of
> introducing new flaws (and maybe we'll fix flaws during the conversion,
> which we've certainly seen before when doing this stricter type/language
> changes).
> 
> I don't see why this is an objectionable goal.

People can and will always find a way to mess things up.

Only add types when you get behavioural changes, otherwise it's
pointless noise.

My NAK stands.
