Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E658E94D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2019 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfHOKw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 06:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbfHOKw2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 06:52:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F13C20665;
        Thu, 15 Aug 2019 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565866347;
        bh=0iwh4It9DTUtLTh6DHbA8L+rgka8HF2BN9oR2BEsK24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFbvlL/XpSfYFoaaYLK7CUkPh+jvKby1YKjr5f1OTsHNkM0HYdfLNsekt7Uz5OUv5
         DkIJtPtFCAFLs1fLjIe8PRZ8w8N0brEMdi+52WcblAe7dyzPZaDkXHGQuKblYoUhTg
         hPPfq/LeRdXGdeIOor9P5AMnRHYPSCE1slVTm8xg=
Date:   Thu, 15 Aug 2019 12:52:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 06/19] ktf: A simple debugfs interface to test results
Message-ID: <20190815105225.GA16395@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
 <20190813082152.GA17627@kroah.com>
 <a63bea757e02656a38463cc794da7da15273dd16.camel@oracle.com>
 <20190815084921.GE3512@kroah.com>
 <9629068a41a160de0145a18dd22924bce70f37fe.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9629068a41a160de0145a18dd22924bce70f37fe.camel@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 15, 2019 at 12:35:26PM +0200, Knut Omang wrote:
> On Thu, 2019-08-15 at 10:49 +0200, Greg Kroah-Hartman wrote:
> > > I perfectly agree with you that reducing the hole for a race condition 
> > > is generally a bad idea, but from the above mail thread 
> > > it seems that's the only available choice for older kernels?
> > 
> > I have no idea, but please, do not use that pattern of code as it is
> > racy in all kernels, from all of time.
> 
> Ok, will remove it :-)
> 
> I tried in vain to find the commit from Al Viro that made the code safe,
> to identify which kernels that are safe from this issue,
> but he has a **lot** of commits, do you have a clue for what/where to look?
> 
> It will be good to have a mention/comment on this for future reference, 
> like the earliest kernel version where this is safe.

Always use a "newer" kernel to be "safe" and you will be fine :)

> Maybe we can even get rid of some more of the remaining of these too..
> (I notice there's 65 cases of 'if (!try_module_get(THIS_MODULE))'
> right now)

Something to put on a TODO list somewhere...

thanks,

greg k-h
