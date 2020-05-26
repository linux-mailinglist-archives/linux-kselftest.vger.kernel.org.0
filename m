Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF171DF514
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 May 2020 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgEWGFx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 May 2020 02:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbgEWGFx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 May 2020 02:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACD42072C;
        Sat, 23 May 2020 06:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590213952;
        bh=C1Z/ykijQkXEDxKuat87W9+yNZvMZvP4bUwTmC+spjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjXxc9dw7SZ93/g6KObshDL9/6CkEB6mKSTSZ0Ay1pyfblZRRPVDdr5XCf3rvjT4J
         gv58zQ1jkBmwl7eR3xCk35Sw0+etCsWgN0yMuhc3uZ3/Ipa0tfg+XZB7B15nB2PsQQ
         8pwI3oHK1JDr5D4U8WMzN86Uiy8HFHwtVoTws6jQ=
Date:   Sat, 23 May 2020 08:05:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] firmware_loader: change enum fw_opt to u32
Message-ID: <20200523060548.GA3124611@kroah.com>
References: <20200522214658.12722-1-scott.branden@broadcom.com>
 <20200522224508.GE11244@42.do-not-panic.com>
 <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
 <20200522230025.GG11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522230025.GG11244@42.do-not-panic.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 22, 2020 at 11:00:25PM +0000, Luis Chamberlain wrote:
> On Fri, May 22, 2020 at 03:49:05PM -0700, Scott Branden wrote:
> > Hi Luis,
> > 
> > On 2020-05-22 3:45 p.m., Luis Chamberlain wrote:
> > > On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
> > > >   /**
> > > > - * enum fw_opt - options to control firmware loading behaviour
> > > > + * fw_opt - options to control firmware loading behaviour
> > > >    *
> > > >    * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
> > > >    *	when the firmware is not found. Userspace is in charge to load the
> > > > @@ -33,15 +33,13 @@
> > > >    *	the platform's main firmware. If both this fallback and the sysfs
> > > >    *      fallback are enabled, then this fallback will be tried first.
> > > >    */
> > > > -enum fw_opt {
> > > > -	FW_OPT_UEVENT			= BIT(0),
> > > > -	FW_OPT_NOWAIT			= BIT(1),
> > > > -	FW_OPT_USERHELPER		= BIT(2),
> > > > -	FW_OPT_NO_WARN			= BIT(3),
> > > > -	FW_OPT_NOCACHE			= BIT(4),
> > > > -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
> > > > -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
> > > > -};
> > > > +#define FW_OPT_UEVENT			BIT(0)
> > > > +#define FW_OPT_NOWAIT			BIT(1)
> > > > +#define FW_OPT_USERHELPER		BIT(2)
> > > > +#define FW_OPT_NO_WARN			BIT(3)
> > > > +#define FW_OPT_NOCACHE			BIT(4)
> > > > +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
> > > > +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
> > > Everything looked good up to here. The enum defines each flag.
> > > We just want to use an enum for *one* flag represetnation, not
> > > a bundle.
> >
> > I do not know exactly what you are looking for then.� The FW_OPT_*
> > values are OR'd together in the code.� You still want the fw_opt enum
> > above left in place entirely and then the values used in OR'd
> > together?
> 
> Yes, exactly. If they are combined then we just use a u32 to represent
> these are then flags combined. An enum represents just *one* flag, not
> a set which are OR'd together. Let me know if this is still not clear.

If this is the case, why have an enum at all?  What difference is it
from a #define like was done here?

thanks,

greg k-h
