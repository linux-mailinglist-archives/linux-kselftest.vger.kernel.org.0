Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA7206C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgFXGNd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 02:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbgFXGNd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 02:13:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39532078A;
        Wed, 24 Jun 2020 06:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592979212;
        bh=dmUwVTJNAFHOpffdcZY9P3YPg9+d0bN/Koh//XCFD00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD+IX9YyGuPZCqR3nCiU0cvmby8fEGszUQk92c3rj6e9nRGyh/i6Ph8SorX9n+bnY
         QgIKUX7gJ7XwqtHcYVt6RayAZGlRWhg/G4lwLJeo1PGGWb1+nYtAWirZIpeRPNZ9zT
         1SkspiA07ZKw+HWFeVDoCo8Nncc+iXrDKymXEOI8=
Date:   Wed, 24 Jun 2020 08:13:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <20200624061331.GB933050@kroah.com>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006231610.4993DC5@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 23, 2020 at 04:10:23PM -0700, Kees Cook wrote:
> On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
> > Hi Greg,
> > 
> > Can you please apply these patches to your drivers/misc tree for LKDTM?
> > It's mostly a collection of fixes and improvements and tweaks to the
> > selftest integration.
> 
> Friendly ping -- we're past -rc2 now. :)

$ mdfrm -c ~/mail/todo/
1970 messages in /home/gregkh/mail/todo/

You are in good company, give me some time to catch up please...

thanks,

greg k-h
