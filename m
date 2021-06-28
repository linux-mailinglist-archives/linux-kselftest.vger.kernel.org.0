Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FB3B5B66
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhF1Jes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 05:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232152AbhF1Jer (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 05:34:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 968D5619C5;
        Mon, 28 Jun 2021 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624872742;
        bh=lsamg+PxzeY+uZhhCSlp8N3GB8mjamZ+vBUc2M5/IYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyJ9GaPwLeevhfj1fFwQA3wbu0RqZcRtqjK2xyU8GUAuPRE2DQ0WerR6AvwzpJaZs
         4FvFkl0XcIQDnn9boKYDXPBNRul/IT0PuqxAXR53l+yfYs9QBQgZWHwL1GB64S2JWB
         MCn4MTwXS/iybIsQIU+StErstpj64CMUH/GH/RXA=
Date:   Mon, 28 Jun 2021 11:32:18 +0200
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
Message-ID: <YNmXIk7orQavkEME@kroah.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com>
 <860717cce60f47abb3c9dc3c1bd32ab7@huawei.com>
 <YNmMX4EODT0c4zqk@kroah.com>
 <4acc7e8f15834b83b310b9e2ff9ba3d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4acc7e8f15834b83b310b9e2ff9ba3d2@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 28, 2021 at 09:27:05AM +0000, Roberto Sassu wrote:
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Monday, June 28, 2021 10:46 AM
> > On Mon, Jun 28, 2021 at 08:30:32AM +0000, Roberto Sassu wrote:
> > > > > +struct compact_list_hdr {
> > > > > +	__u8 version;
> > > >
> > > > You should never need a version, that way lies madness.
> > >
> > > We wanted to have a way to switch to a new format, if necessary.
> > 
> > Then just add a new ioctl if you need that in the future, no need to try
> > to cram it into this one.
> 
> Given that digest lists are generated elsewhere, it would be still
> unclear when the ioctl() would be issued. Maybe the kernel needs
> to parse both v1 and v2 digest lists (I expect that v1 cannot be easily
> converted to v2, if they are signed).
> 
>  It would be also unpractical if digest lists are loaded at kernel
> initialization time (I didn't send the patch yet).

Then that is up to your api design, I do not know.  But note that
"version" fields almost always never work, so be careful about assuming
that this will solve any future issues.

> > > > > +	__le16 type;
> > > > > +	__le16 modifiers;
> > > > > +	__le16 algo;
> > > > > +	__le32 count;
> > > > > +	__le32 datalen;
> > > >
> > > > Why are user/kernel apis specified in little endian format?  Why would
> > > > that matter?  Shouldn't they just be "native" endian?
> > >
> > > I thought this would make it clear that the kernel always expects the
> > > digest lists to be in little endian.
> > 
> > Why would a big endian system expect the data from userspace to be in
> > little endian?  Shouldn't this always just be "native" endian given that
> > this is not something that is being sent to hardware?
> 
> The digest list might come from a system with different endianness.

Ok, I have no idea what digests really are used for then.  So stick with
little endian and be sure to properly convert within the kernel as
needed.

thanks,

greg k-h
