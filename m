Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890768E75F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2019 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfHOItZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 04:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfHOItZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 04:49:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78148218C9;
        Thu, 15 Aug 2019 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858964;
        bh=hWTTTkR4rwS2l5FUJgldUqWsSPmx6Qek8c4m1QxhUZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8AWuu4fOejF2RYy+PawpZAqyzXp/u36EwXSoyuwIVTiJh3PmN8+cLh1CbYclj0zj
         Yt9LP0sq+ypW5XMoQ0yddIDatDT7WgwIfvXdV79rAYO0C36sYi3mB8xmiYgX03juSl
         yiMai7+diCiyTFHAtcgdnVT6IawYsx4mBjAvkpTc=
Date:   Thu, 15 Aug 2019 10:49:21 +0200
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
Message-ID: <20190815084921.GE3512@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
 <20190813082152.GA17627@kroah.com>
 <a63bea757e02656a38463cc794da7da15273dd16.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63bea757e02656a38463cc794da7da15273dd16.camel@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 14, 2019 at 07:17:07PM +0200, Knut Omang wrote:
> I notice the discussion and your response here: 
> http://linux-kernel.2935.n7.nabble.com/debugfs-and-module-unloading-td865175.html
> I assume that means that protection against module unload while a debugfs file
> is open is now safe.

It should be, if you set the *owner field of your file_operations
properly.  Try it and see!

> On older kernels, having this code in place is far better than an unprotected 
> debugfs entry/exit - I have tested it extensively in the past :-)

Yes, it seems to work, but again, it really is racy and will fail.
Please don't use it.

> I perfectly agree with you that reducing the hole for a race condition 
> is generally a bad idea, but from the above mail thread 
> it seems that's the only available choice for older kernels?

I have no idea, but please, do not use that pattern of code as it is
racy in all kernels, from all of time.

thanks,

greg k-h
