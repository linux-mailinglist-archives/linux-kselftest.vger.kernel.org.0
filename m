Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523F3B5AA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhF1Isv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 04:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhF1Isv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 04:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 202066108B;
        Mon, 28 Jun 2021 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624869985;
        bh=9+S3F7N7khxscRTbbj60Z7nXQGu4ulqBkmJG0nAyrE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQik9Y9Z6+t4k6qUbWXRP77n1bPcxiX/kInnghlhn6vP+QnzAhD/nKAAwNwYnnDwP
         KiPR3HOFy5LKe70/jSLCBUsf9pml+uJ4c3Mun86HUonl4j3boM6eGudz3ZadjDM3UD
         c+PxJvjQg9w7tgd/zIt8AJ7CccCt2uZTNxTbO8hQ=
Date:   Mon, 28 Jun 2021 10:46:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 03/12] digest_lists: Basic definitions
Message-ID: <YNmMX4EODT0c4zqk@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com>
 <860717cce60f47abb3c9dc3c1bd32ab7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860717cce60f47abb3c9dc3c1bd32ab7@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 28, 2021 at 08:30:32AM +0000, Roberto Sassu wrote:
> > > +struct compact_list_hdr {
> > > +	__u8 version;
> > 
> > You should never need a version, that way lies madness.
> 
> We wanted to have a way to switch to a new format, if necessary.

Then just add a new ioctl if you need that in the future, no need to try
to cram it into this one.

> > > +	__le16 type;
> > > +	__le16 modifiers;
> > > +	__le16 algo;
> > > +	__le32 count;
> > > +	__le32 datalen;
> > 
> > Why are user/kernel apis specified in little endian format?  Why would
> > that matter?  Shouldn't they just be "native" endian?
> 
> I thought this would make it clear that the kernel always expects the
> digest lists to be in little endian.

Why would a big endian system expect the data from userspace to be in
little endian?  Shouldn't this always just be "native" endian given that
this is not something that is being sent to hardware?

thanks,

greg k-h
