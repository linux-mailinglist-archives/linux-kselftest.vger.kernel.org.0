Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4EE24463B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHNINM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 04:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNINL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 04:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE37D2068E;
        Fri, 14 Aug 2020 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597392791;
        bh=MmxQNl8+vLlHzOR3qnK3CTNQlzCrPiowIyHnwsh4Te4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5Y3OMEcOwAECD8bL+8gJnC3dK/tHABFsBSBMEqFqTIZojB9lu+YyiUqm8Y3e+5pd
         UsnqvIreB/iqsdauEBOksdFNJakgQD79jLMntIV37vF/EzK1FhIpbWPwvWPPTVn44k
         GbL2DilF46d7kuC06NkbyFEzpm8GgK+7cUENAJns=
Date:   Fri, 14 Aug 2020 10:13:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Restore EACCES of S_ISDIR execve()
Message-ID: <20200814081319.GA4075588@kroah.com>
References: <20200813231723.2725102-1-keescook@chromium.org>
 <20200813231723.2725102-2-keescook@chromium.org>
 <20200814071102.GA4062560@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814071102.GA4062560@kroah.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 14, 2020 at 09:11:02AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 13, 2020 at 04:17:22PM -0700, Kees Cook wrote:
> > The return code for attempting to execute a directory has always been
> > EACCES. Adjust the S_ISDIR exec test to reflect the old errno instead
> > of the general EISDIR for other kinds of "open" attempts on directories.
> > 
> > Reported-by: Marc Zyngier <maz@kernel.org>
> > Link: https://lore.kernel.org/lkml/20200813151305.6191993b@why
> > Fixes: 633fb6ac3980 ("exec: move S_ISREG() check earlier")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/namei.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 2112e578dccc..e99e2a9da0f7 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2849,8 +2849,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >  	case S_IFLNK:
> >  		return -ELOOP;
> >  	case S_IFDIR:
> > -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> > +		if (acc_mode & MAY_WRITE)
> >  			return -EISDIR;
> > +		if (acc_mode & MAY_EXEC)
> > +			return -EACCES;
> >  		break;
> >  	case S_IFBLK:
> >  	case S_IFCHR:
> 
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@google.com>

And to round out the "let's use a different email address for each
response, to drive accounting tools crazy!" effort, you can also add:

Tested-by: Greg Kroah-Hartman <gregkh@android.com>

thanks,

greg "I don't have enough different email addresses" k-h
