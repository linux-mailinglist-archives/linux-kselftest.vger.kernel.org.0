Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD4231345
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgG1T4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 15:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgG1T4s (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 15:56:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC242070A;
        Tue, 28 Jul 2020 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595966208;
        bh=t6ZBb6aKjOP/D53m5Lux0B4l1dQapES6T4xqgzSEF5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loUq6fsR9oQLkUjlfoFYvKPr2i6bqC2ehfaKt0sMzOhA6vcojo09dKpNP4VbTxW2E
         DF9qQ0DxImikxo7X1nRO5ZV5hDN+Br9zU/HrU0uT4QuGJg7KWwiO6dd6l5KMBHxbej
         P/ZKKP7Qx1kmZ0W6BZXMajP5aV5AwEY2cU4oWR0U=
Date:   Tue, 28 Jul 2020 21:56:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/19] IMA: Add support for file reads without contents
Message-ID: <20200728195640.GA342741@kroah.com>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-16-keescook@chromium.org>
 <1595856214.4841.86.camel@kernel.org>
 <202007281244.2F2681AE9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007281244.2F2681AE9@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 28, 2020 at 12:44:50PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 09:23:34AM -0400, Mimi Zohar wrote:
> > On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > > From: Scott Branden <scott.branden@broadcom.com>
> > > 
> > > When the kernel_read_file LSM hook is called with contents=false, IMA
> > > can appraise the file directly, without requiring a filled buffer. When
> > > such a buffer is available, though, IMA can continue to use it instead
> > > of forcing a double read here.
> > > 
> > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > After adjusting the comment below.
> > 
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Sure!
> 
> Greg, shall I send a v4 with added Reviews and the comment change or is
> that minor enough that you're able to do it?

v4 is needed, as this series is a mess of reviewes and you will have to
redo at least one patch and drop some others, right?

thanks,

greg k-h
