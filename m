Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A42DE0AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbgLRKAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 05:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733012AbgLRKAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 05:00:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB9C0617A7;
        Fri, 18 Dec 2020 01:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fKOvh3a2GZ34rXvLOLqMenb3Y5+fW2+k0TfKgHEyRc=; b=MTsUQlIJSWJvw7bOtuQ2GJuIgU
        nzCut7tMCmigJOpQGv3jwIA91hTiS29B4x+QogWz7kmT/qQRCeS8Ya99PIMmkw9Oli/w/u4d0ZFZl
        Fzos0wmbI1uCY5KVOmUaU0GV8sK+gTkpTJyUcOaK1Qg56JrobEyJaH6658WOlfKbJPmSx469Cc9fF
        fVoquPtcJvmRy7nX7f8gjuP9hy3lVGK67lsBOQltD1WtlM2tl0+D07eNIMZrcVdcwItvYUTz2ZzO1
        S+GvY507CaqBh2HQF2tUjhkJcJg7RUEjo0C5maJxT7yIswNHRMQ5VCq2mlldW+rGZMbxqrv/L4iQ4
        nlYM3WXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqCXq-0003Xf-B4; Fri, 18 Dec 2020 09:59:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 846F0304B92;
        Fri, 18 Dec 2020 10:59:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B01B2012B50F; Fri, 18 Dec 2020 10:59:27 +0100 (CET)
Date:   Fri, 18 Dec 2020 10:59:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] selftests/x86: Test Key Locker internal key
 maintenance
Message-ID: <20201218095927.GE3021@hirez.programming.kicks-ass.net>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
 <20201216174146.10446-7-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216174146.10446-7-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 16, 2020 at 09:41:44AM -0800, Chang S. Bae wrote:
> +	/* ENCODEKEY128 %EAX */
> +	asm volatile (".byte 0xf3, 0xf, 0x38, 0xfa, 0xc0");

This is lacking a binutils version number. Boris, didn't you do a
checkpatch.pl thing for that?
