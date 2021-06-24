Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6B3B3000
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jun 2021 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFXNfF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Jun 2021 09:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXNfF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Jun 2021 09:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB18160FD9;
        Thu, 24 Jun 2021 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624541565;
        bh=oI7RBYCu19BujLvtx3xIAdptc4lZUQyYBAY3znUi5zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hia2WkyLxva1Y/Nlt3HoxS2CqTuPLLmHoo4p8BbX/zVP1Ch0NJghjWG5KegOsV23O
         ZhkzsJCv8EWpJCBmemORpsdXefZc/v2yi7Y05om//I37+WXN9QtpUikbDM2klSkHm0
         u+N32jXwusUKG4QsAvqfJMQ1rG0+6nfFnjsdEu2o=
Date:   Thu, 24 Jun 2021 15:32:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/9] LKDTM: Improvements for kernelci.org
Message-ID: <YNSJZ0h3oITHA/tW@kroah.com>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 23, 2021 at 01:39:27PM -0700, Kees Cook wrote:
> This is a bunch of LKDTM clean-ups to improve and expand testing,
> given feedback from testing at kernelci.org. Adds a few new tests as
> well.
> 
> (If a pull-request is preferred, please let me know.)

This works, thanks!

greg k-h
