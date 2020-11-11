Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F72AE76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 05:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgKKEde (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 23:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKEde (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 23:33:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02FC0613D1;
        Tue, 10 Nov 2020 20:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gL0OocahXZn8ZQNF8szmGW51uY79EBzlZ34GhrWeBso=; b=oDeBdofTe937SyWQ5KS04zcvqC
        lgvZ1G91Fpn0+Q6hWzn8iz4pOCTvXSHpD6P1QhX5Qd04Kt1Qw+XpMngVvHfktQNVQ1ulA67YiL7nL
        tA8aihrql/H2AMkAyYWzWFIN9Ce0745Pa94PaKzEiQEtKHdWkthYtwOI+SQpKIJw6ptG47vbEq7Sm
        XbhcamxT5yKVkB0cRiWCzjhuX2LfopicPBECLbWzvfoBpL8c7A/pYE1TRlavFekqmDsyuYQ9Lmaqv
        TacYawpzSIaJXXew8hPtbksnGSLMeAoHskMPJw9V8IhREGECwGEFySLXGWxjJ//+BgXGebA+WR5kI
        gAImvbZw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kchoe-0002CB-P0; Wed, 11 Nov 2020 04:33:04 +0000
Date:   Wed, 11 Nov 2020 04:33:04 +0000
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
Message-ID: <20201111043304.GS17076@casper.infradead.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used strictly for counting sequence numbers and other statistical
> counters and not for managing object lifetime.

We already have something in Linux called a sequence counter, and it's
different from this.  ID counter?  instance number?  monotonic_t?  stat_t?
