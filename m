Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC43B5AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhF1Itl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 04:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhF1Itk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 04:49:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 357A36108B;
        Mon, 28 Jun 2021 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624870035;
        bh=fwqDYD3WVqhCOOp5GXfpIJP5FpsuNHICvD28AiRGpmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xToNot36Z0FTctWX4O4yKCtB4CNUuLiel82y2cNUAPBd6LtSAfAv7o+SOHFB/E0DP
         Cy134+nqFVHFGGmMopVowg+kj/577kRoRXbmzjqW6NFUbkkpZVUQAx4sz3xrNQIBgV
         jDuqrDTeuMcxiGKjE8dqmQ3Yp1DdTTB3+sqcMfxE=
Date:   Mon, 28 Jun 2021 10:47:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 04/12] digest_lists: Objects
Message-ID: <YNmMkUwaPj0Xgh2r@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-5-roberto.sassu@huawei.com>
 <YNhZTR5VSin7ABZP@kroah.com>
 <22fff08f1a70460da814d3f21b497f8b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fff08f1a70460da814d3f21b497f8b@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 28, 2021 at 08:14:41AM +0000, Roberto Sassu wrote:
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Sunday, June 27, 2021 12:56 PM
> > On Fri, Jun 25, 2021 at 06:56:06PM +0200, Roberto Sassu wrote:
> > > +++ b/security/integrity/digest_lists/digest_lists.h
> > > @@ -0,0 +1,117 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2005,2006,2007,2008 IBM Corporation
> > > + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> > > + *
> > > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License as
> > > + * published by the Free Software Foundation, version 2 of the
> > > + * License.
> > > + *
> > > + * File: digest_lists.h
> > > + *      Unexported definitions for digest lists.
> > 
> > Unexported to whom?
> 
> Hi Greg
> 
> I meant not placed in include/linux.

That's obvious based on the location of the file :)

> > > +
> > > +static inline struct compact_list_hdr *get_hdr(
> > > +					struct digest_list_item *digest_list,
> > > +					loff_t hdr_offset)
> > > +{
> > > +	return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
> > > +}
> > 
> > pointer math feels rough, are you shure you want to do this this way?
> 
> Maybe, I could change digest_list_item_ref to:
> 
> struct digest_list_item_ref {
> 	struct digest_list_item *digest_list;
> 	u8 *digest;
> 	struct compact_list_hdr *hdr;
> };
> 
> where digest and hdr are calculated in the same way.

That works better, no need to do pointer math if you do not have to.

thanks,

greg k-h
