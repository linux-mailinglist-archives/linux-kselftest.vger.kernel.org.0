Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A50F4071
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 07:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfKHGhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 01:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKHGhT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 01:37:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6CA421882;
        Fri,  8 Nov 2019 06:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573195038;
        bh=sXe/lKnHWXWz0aIej4oPyDwjQIRvSAnRd4dPdmDpkII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlvNmAWEIFV3DOIrxKnv8p/Io0xVltpUHrWIziebLbV98yw0fcsZwyxSmE25Af5V8
         lCAriWwM88CjnNik4h37rJD5I1XjJYSR0YIZdq/vgelAa8ihvdPvFW8FOf3VIdZNCg
         QIjP4MEv3UaTX2KWtlJdvJUdrv5bRc0tOXixTUxM=
Date:   Fri, 8 Nov 2019 07:37:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108063715.GA513315@kroah.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
 <20191108020614.GA99567@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108020614.GA99567@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 07, 2019 at 09:06:14PM -0500, Joel Fernandes wrote:
> On Thu, Nov 07, 2019 at 05:00:23PM -0800, Andrew Morton wrote:
> > On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > 
> > > F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> > > A private mapping created after the memfd file that gets sealed with
> > > F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> > > children and parent share the same memory, even though the mapping is
> > > private.
> > 
> > That sounds fairly serious.  Should this be backported into -stable kernels?
> 
> Yes, it should be. The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so
> v5.3.x stable kernels would need a backport. I can submit a backport tomorrow
> unless we are Ok with stable automatically picking it up (I believe the
> stable folks "auto select" fixes which should detect this is a fix since I
> have said it is a fix in the subject line).

Never rely on "auto select" to pick up a patch for stable if you already
know it should go to stable.  Just mark it as such, or tell stable@vger
after the fact.

thanks,

greg k-h
