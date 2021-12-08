Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8C46CE1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 08:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhLHHLW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 02:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbhLHHLW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 02:11:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8855C061574;
        Tue,  7 Dec 2021 23:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D51BECE19BA;
        Wed,  8 Dec 2021 07:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D66C00446;
        Wed,  8 Dec 2021 07:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638947266;
        bh=wutgiMs0XujmMpHmW7BVLnhSE5vS+yA9SLyoA4H4HTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ha6e/BylqojqulxgeZ3IZZdpIXApJ9PUhLZCE0M7CwCIF3SECNq2FiTtUtQM/nb3u
         zKGmy6YofGX+RDBwmWzXh7xp2rn6ajTnyOQv1hpNivdYBAH74FYaJeC28WQTn1M4xd
         HFXzfUkAeGFUWsLbFNN3XgHIW7l8X7MMwPz6Ypqg=
Date:   Wed, 8 Dec 2021 08:07:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBZuwXZWMV9uRXI@kroah.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBYtJFQ47UH2h/k@unreal>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > Adds get/set driver data helpers for auxiliary devices.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Mark Gross <markgross@kernel.org>
> > ---
> > V2
> >   - No changes
> > 
> >  include/linux/auxiliary_bus.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> I would really like to see an explanation why such obfuscation is really
> needed. dev_*_drvdata() is a standard way to access driver data.

Lots of busses have this helper.  This is nothing new at all, and is
nice to have.  Look at all of the calls to dev_get_drvdata() in
include/linux/ for the examples.

thanks,

greg k-h
