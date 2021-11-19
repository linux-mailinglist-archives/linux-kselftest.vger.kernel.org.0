Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB9456D17
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhKSKVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 05:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSKVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 05:21:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A9C061574;
        Fri, 19 Nov 2021 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mU7CXYA7+Z8znZ6H/7El6odieLZp2FQkQXrbGlUHrow=; b=AN3WwQWp9tlGDluAti6I4VlegU
        GJNtz4TQoreH/oOGY1wkiClDMTiTZxWAEadyO91SHM3iM2cQ7AD2zPIc5g6CuY4Jk33bXfF5mOMIZ
        0ymOxNZMfQb0p16Rq/svxXUK52AH/eVS4f2hOpg6Gy9zcnZaXbyfz2tXaRn41/uoj5uq0c7BPYQkd
        j5WmlCVOb2c4fmHmMUPIiiEyndLF5cB6Cs6QGtS22u0viSCBet7zSUW5yglsEP0Slodde5k0nw32f
        7b59OVtTJZ6iytV0an7/OCwSFhRSneZakgyEp5jE/d83SVdjMXuHJcXnSZRtwrqaitXXkFLWA99ji
        3jtyoJtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo0xm-00GsMZ-GU; Fri, 19 Nov 2021 10:17:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B555A300130;
        Fri, 19 Nov 2021 11:17:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F1E9265BA1EB; Fri, 19 Nov 2021 11:17:45 +0100 (CET)
Date:   Fri, 19 Nov 2021 11:17:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
Message-ID: <YZd5yeql//37xSuw@hirez.programming.kicks-ass.net>
References: <20211119090327.12811-1-mbenes@suse.cz>
 <20211119090327.12811-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119090327.12811-3-mbenes@suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 10:03:26AM +0100, Miroslav Benes wrote:
> livepatch's consistency model requires that no live patched function
> must be found on any task's stack during a transition process after a
> live patch is applied. It is achieved by walking through stacks of all
> blocked tasks.
> 
> The user might also want to define more functions to search for without
> them being patched at all. It may either help with preparing a live
> patch, which would otherwise require additional touches to achieve the
> consistency, or it can be used to overcome deficiencies the stack
> checking inherently has. For example, GCC may optimize a function so
> that a part of it is moved to a different section and the function would
> jump to it. This child function would not be found on a stack in this
> case, but it may be important to search for it so that, again, the
> consistency is achieved.
> 
> Allow the user to specify such functions on klp_object level.

Ok, so this relies on the patch generator to DTRT but then it should
work.

Thanks!
