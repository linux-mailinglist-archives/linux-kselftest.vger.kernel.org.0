Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3649A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfFRHOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 03:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRHOB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 03:14:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7548E20679;
        Tue, 18 Jun 2019 07:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560842040;
        bh=XbYebSig6WgWAtotCNmZuL+LePL+/ODdq6WIe8myLKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yS+Sr4+kgzHWVTQdk4Yg2022E1Cxe8r9DJ5qt79cG4vX8txvzNi3C8nTevsPbe3NZ
         +hqyUiwuOnkXbodTya4U9PfZq/9F85nZIE4JKxLS8emNvRohsedk3JvS6fHLcmcfQj
         0YvKKQYhudmLHdcLtslOLl5DTaSCpks8MZx4tO9U=
Date:   Tue, 18 Jun 2019 09:13:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2.5 0/3] firmware: Add support for loading compressed
 files
Message-ID: <20190618071358.GA14474@kroah.com>
References: <20190611122626.28059-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611122626.28059-1-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 02:26:23PM +0200, Takashi Iwai wrote:
> [resubmitted with the missing patch]
> 
> Hi,
> 
> here are the rest and the main part of patches to add the support for
> loading the compressed firmware files.  The patch was slightly
> refactored for more easily enhancing for other compression formats (if
> anyone wants).  Also the selftest patch is included.  The
> functionality doesn't change from the previous patchset.

Looks great, thanks for doing this.  All now queued up.

greg k-h
