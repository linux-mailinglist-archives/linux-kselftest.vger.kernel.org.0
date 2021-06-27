Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB803B5408
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Jun 2021 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhF0PiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Jun 2021 11:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhF0PiW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Jun 2021 11:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A2761416;
        Sun, 27 Jun 2021 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624808158;
        bh=IIp2MobQeg2HLnqt1w3NF2LefNGWMGP642ajbW5iJsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9aDm0u1a6hcYOGA7nqttUUmwaq0nMSviQPJI/KAccL/6m58Inrw71sbcL9GU2Ggc
         /+QwHFZysKpuw3vh8fS0uPSlsBBPg+3do+YKclveXTf0wfHHMtXigXSJbNOTPfkvpX
         VLb9GnZtJfGZbarYBHS7CXOkJEC0crOyFUEIZQB8=
Date:   Sun, 27 Jun 2021 17:35:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 03/12] digest_lists: Basic definitions
Message-ID: <YNia23bDCGRZ74OG@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com>
 <YNiX7nyQIS/eg+VC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNiX7nyQIS/eg+VC@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 27, 2021 at 04:23:26PM +0100, Matthew Wilcox wrote:
> On Sun, Jun 27, 2021 at 12:53:47PM +0200, Greg KH wrote:
> > > +enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
> > > +
> > 
> > For enums you export to userspace, you need to specify the values so
> > that all compilers get them right.
> 
> I've never heard that rule before.  Where does it come from?
> https://en.cppreference.com/w/c/language/enum
> says:
> 
>   If enumeration-constant is not followed by = constant-expression,
>   its value is the value one greater than the value of the previous
>   enumerator in the same enumeration. The value of the first enumerator
>   (if it does not use = constant-expression) is zero.
> 

I thought it was in the Documentation/driver-api/ioctl.rst file, but I
can't find it right now.  Maybe it was something that Arnd said?

Arnd, is this still an issue?  For some reason I thought it was always
good to have uapi .h enums be explicit as to the value in them,
otherwise some C compilers might produce other values if they were not
specified?

thanks,

greg k-h
