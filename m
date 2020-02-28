Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8474C174088
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1TuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 14:50:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1TuL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 14:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MQLRxFDsNnQ4JQhc5wBShCTpfmOkOqYbr8PMSU0Vj4g=; b=b4Lweuy0vRcXWdNTbWnD02tCTf
        I9OlWlryhbG2M02AnrL6siDc0jBH3kKXRxdQr/L9CUkPRbEBV1oXJgAoN+ZSObYdo/iNW3wfS4lLK
        /b3nSEJd2QVgnSYQGJjUX3M0bTQ8BwWfSIRUXbtlaU2osUf6TMgiasQCsjHeXBle3s3DiUBX7CkWK
        fDWuiae4AQeSgTrSREUTktvJShl9KY5/HXLuCHHt5nORPMt9wekM2lwF3034dPhlj6+64OnBJbkve
        2evW/bhx8XwlHmm+S3xQPCQEFxwsKCcB0nwI2HD6cg/b5DNn7Eg5fOwRmafWoo+jTyl0urRwJH13g
        G/x8MGUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7le4-00014p-Do; Fri, 28 Feb 2020 19:50:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD50B30067C;
        Fri, 28 Feb 2020 20:48:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 471BC2B73FC15; Fri, 28 Feb 2020 20:49:58 +0100 (CET)
Date:   Fri, 28 Feb 2020 20:49:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net,
        malteskarupke@web.de
Subject: Re: [PATCH v3 1/4] futex: Implement mechanism to wait on any of
 several futexes
Message-ID: <20200228194958.GO14946@hirez.programming.kicks-ass.net>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
 <20200213214525.183689-2-andrealmeid@collabora.com>
 <20200228190717.GM18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228190717.GM18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 28, 2020 at 08:07:17PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 06:45:22PM -0300, André Almeida wrote:
> > @@ -150,4 +153,21 @@ struct robust_list_head {
> >    (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
> >     | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
> >  
> > +/*
> > + * Maximum number of multiple futexes to wait for
> > + */
> > +#define FUTEX_MULTIPLE_MAX_COUNT	128
> > +
> > +/**
> > + * struct futex_wait_block - Block of futexes to be waited for
> > + * @uaddr:	User address of the futex
> > + * @val:	Futex value expected by userspace
> > + * @bitset:	Bitset for the optional bitmasked wakeup
> > + */
> > +struct futex_wait_block {
> > +	__u32 __user *uaddr;
> > +	__u32 val;
> > +	__u32 bitset;
> > +};
> 
> So I have a problem with this vector layout, it doesn't allow for
> per-futex flags, and esp. with that multi-size futex support that
> becomes important, but also with the already extand private/shared and
> wait_bitset flags this means you cannot have a vector with mixed wait
> types.

Alternatively, we throw the entire single-syscall futex interface under
the bus and design a bunch of new syscalls that are natively vectored or
something.

Thomas mentioned something like that, the problem is, ofcourse, that we
then want to fix a whole bunch of historical ills, and the probmem
becomes much bigger.

Thomas?
