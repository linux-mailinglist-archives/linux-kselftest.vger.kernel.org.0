Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31E14C905
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2019 10:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFTIKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jun 2019 04:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfFTIKH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jun 2019 04:10:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB172084A;
        Thu, 20 Jun 2019 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561018205;
        bh=vqNCz79Tokyx4AP8RsZ5iaOcEK9utXl0gWsvvk2Inxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2r43J1W+zJltuSjk7EDmgOiOjbFBa1NtY4yEZv6oEUOQNZEGLBxFWpPZ3aQum5vP
         UPFHIK//UOVil45957P3LA9qwLZZLn3uYvviLY/wqr1hm0PPsj1eol29BUamfYz44v
         pPD+6flFNWFA4cfFP+6vqUT+ZQkX3LGVqSEqxHsM=
Date:   Thu, 20 Jun 2019 10:10:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2.5 2/3] firmware: Add support for loading compressed
 files
Message-ID: <20190620081003.GA21685@kroah.com>
References: <20190611122626.28059-1-tiwai@suse.de>
 <20190611122626.28059-3-tiwai@suse.de>
 <20190619232646.GE19023@42.do-not-panic.com>
 <s5h1rzog13w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1rzog13w.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 20, 2019 at 09:36:03AM +0200, Takashi Iwai wrote:
> On Thu, 20 Jun 2019 01:26:47 +0200,
> Luis Chamberlain wrote:
> > 
> > Sorry for the late review... Ah!
> 
> No problem, thanks for review.
> 
> > On Tue, Jun 11, 2019 at 02:26:25PM +0200, Takashi Iwai wrote:
> > > @@ -354,7 +454,12 @@ module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
> > >  MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
> > >  
> > >  static int
> > > -fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> > > +fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
> > > +			   const char *suffix,
> > > +			   int (*decompress)(struct device *dev,
> > > +					     struct fw_priv *fw_priv,
> > > +					     size_t in_size,
> > > +					     const void *in_buffer))
> > 
> > I *think* this could be cleaner, I'll elaborate below.
> > 
> > > @@ -645,7 +768,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> > >  	if (ret <= 0) /* error or already assigned */
> > >  		goto out;
> > >  
> > > -	ret = fw_get_filesystem_firmware(device, fw->priv);
> > > +	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
> > > +#ifdef CONFIG_FW_LOADER_COMPRESS
> > > +	if (ret == -ENOENT)
> > > +		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
> > > +						 fw_decompress_xz);
> > > +#endif
> > 
> > Hrm, and let more #ifdef'ery.
> > 
> > And so if someone wants to add bzip, we'd add yet-another if else on the
> > return value of this call... and yet more #ifdefs.
> > 
> > We already have a list of paths supported. It seems what we need instead
> > is a list of supported suffixes, and a respective structure which then
> > has its set of callbacks for posthandling.
> > 
> > This way, this could all be handled inside fw_get_filesystem_firmware()
> > neatly, and we can just strive towards avoiding #ifdef'ery.
> 
> Yes, I had similar idea.  Actually my plan for multiple compression
> formats was:
> 
> - Move the decompression part into another file, e.g. decompress_xz.c
>   and change in Makefile:
>   firmware_class-$(CONFIG_FW_LOADER_COMPRESS_XZ) += decompress_xz.o
>   
> - Create a table of the extension and the decompression,
> 
>   static struct fw_decompression_table fw_decompressions[] = {
> 	{ "", NULL },
> #ifdef CONFIG_FW_LOADER_COMPRESS_XZ
> 	{ ".xz", fw_decompress_xz },
> #endif
> #ifdef CONFIG_FW_LOADER_COMPRESS_BZIP2
> 	{ ".bz2", fw_decompress_bzip2 },
> #endif
> 	.....
>   };

But why?  Why not just stick with one for now, we don't need a zillion
different formats to start with.  Let's just stick with .xz and that's
it.  There is no need to do anything else for the foreseeable future.

thanks,

greg k-h
