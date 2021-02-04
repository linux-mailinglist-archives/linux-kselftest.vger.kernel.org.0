Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB24030EF8A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhBDJVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 04:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBDJVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 04:21:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F340C061573;
        Thu,  4 Feb 2021 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MIQB8t7kt6mqNl1Bn84T0udleZca2EnAi6Ix4VEe7UU=; b=Ju+atNzUB4pbSQUpXYsoUH6mdS
        4yZRAnUcMYHcFVUlsCe+OaTvKgstwDY9MRqbxpqIaIWDedoHcx0IjrfsFzXU066i+a7had7WGFX/Q
        DJVyHTOuDK+36bBvD1DkxbieQ5DBkhwCc4oMaWShWt3nXFq4AtNIFdyQKlZ399PZ+NHVnpGhaRPZy
        PkrGX1x8EVLXCDb75ANO4ysv2iExZXla4J3SayMpoQv2ygSa9k+mlYlPyiemQ/KXs1xM4OziancWJ
        KFn7FTc5jW3xbQ2Qlr49ZcMaeJFU1YnA8FxpA/9LWT0X5jDZrIOXhOjLhturLaUtS/pbMohdYLd8b
        /1G4+GaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7aoi-000eV4-QS; Thu, 04 Feb 2021 09:20:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAA06301CC4;
        Thu,  4 Feb 2021 10:20:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 920B7213D2E27; Thu,  4 Feb 2021 10:20:45 +0100 (CET)
Date:   Thu, 4 Feb 2021 10:20:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, keescook@chromium.org,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v3 1/7] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <YBu8bRth+4wyvql/@hirez.programming.kicks-ass.net>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
 <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 03, 2021 at 11:11:57AM -0700, Shuah Khan wrote:
> +static inline u32 seqnum32_inc(struct seqnum32 *seq)
> +{
> +	atomic_t val = ATOMIC_INIT(seq->seqnum);
> +
> +	seq->seqnum = (u32) atomic_inc_return(&val);
> +	if (seq->seqnum >= UINT_MAX)
> +		pr_info("Sequence Number overflow %u detected\n",
> +			seq->seqnum);
> +	return seq->seqnum;
> +}

What kind of broken garbage is that?
