Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BD25E740
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Sep 2020 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIELZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Sep 2020 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgIELZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Sep 2020 07:25:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8BC061244;
        Sat,  5 Sep 2020 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcCo8rpDVaNpQkStt8c1HunAQwH7Y1hkDms25uGh7OM=; b=H5fhTYLnze+6FRQQl4W6tmfH1q
        pcIodbtZk0OZNy1KMaQTx5BS8S0CDbBZcr/8epL6/qMDSFzs52nOdoO8lVQW9tofPDZJDQx8A+nQZ
        SP5WBd5Lt7+WFiHjRZ5U5NeD1JdUH8LYQ7LRVitgJBSLXj3PIdezDLjvbFnFEAf/LB+tlBvhjd/P6
        8W+BoR9OzLU7bO4kjLDP5F483ZezNZPg/YwE/lreGRBFF+PmZJ4NbBZyU+iC9qBiUciNFrmN7V7/I
        1ls9g2doQTwnJH+JRPyGSZbHF2VKf89ceWGTMDjCGVhY0amiyxJlqK06cFWWIHxhPnmnb1G91GUwD
        AZ2H91Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEWJC-0006qo-6M; Sat, 05 Sep 2020 11:24:38 +0000
Date:   Sat, 5 Sep 2020 12:24:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com,
        Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH v6 5/9] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200905112438.GA16750@casper.infradead.org>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-6-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:43PM -0400, Gabriel Krisman Bertazi wrote:
> +int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
> +			      unsigned long dispatcher_end, char __user *selector)
> +{
> +	switch (mode) {
> +	case PR_SYS_DISPATCH_OFF:
...
> +	case PR_SYS_DISPATCH_ON:
...
> +	default:
> +		return -EINVAL;
...
> +	case PR_SET_SYSCALL_USER_DISPATCH:
> +		error = set_syscall_user_dispatch((int) arg2, arg3, arg4,
> +						  (char __user *) arg5);

This makes aliases of DISPATCH_OFF and DISPATCH_ON every 4GB throughout
the 64-bit space of arg2.  I don't think that was intentional (nor
desirable).  I'd suggest just making 'mode' a long and dropping the cast.
