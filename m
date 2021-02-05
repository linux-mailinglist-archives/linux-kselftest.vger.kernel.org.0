Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4656331170F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBEXXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 18:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhBEJ7T (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 04:59:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F3AD64E2C;
        Fri,  5 Feb 2021 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612519118;
        bh=nV/rbqwWRF8qM4CIyf4ANBmKaUDGONxRBkHMpb/7CR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suxX5FVBS+WooJ8axVdYhFfyaX4TTMrJP9y6L6NxvLOb22YUJK1w1qsAyy6vSL1p8
         WC4DhmtWEfw/bFhWsVLHvEUUYJ6kMLxYk8dbBMSsn+7qONou9MHKzqST1PRylbUKQs
         Jg9D26ueFHg0n4uFtR7jbEz/yFPmQaDGgHJf8PHU=
Date:   Fri, 5 Feb 2021 10:58:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, peterz@infradead.org, keescook@chromium.org,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, devel@driverdev.osuosl.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/7] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <YB0WzBnLd+OcpxEE@kroah.com>
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

As Peter points out, this is doing doing what you think it is doing :(

Why do you not just have seq->seqnum be a real atomic variable?  Trying
to switch to/from one like this does not work as there is no
"atomic-ness" happening here at all.

Oh, and checkpatch should have complained about the extra ' ' in your
cast :)

thanks,

greg k-h
