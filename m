Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCC189BFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRM3z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Mar 2020 08:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgCRM3y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Mar 2020 08:29:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFCD20771;
        Wed, 18 Mar 2020 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584534594;
        bh=zjpTeDbztyUsBK+cRTHPIIxxpDwJ+iuI6+3m3wsiUCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdb4ssHBg3dN3auqBQmpDexGlh88KXuJu/bZTDbBpRWG/ZyX15EajJGFOSHSHQJ6B
         NzsEmXZPys/ylzlzZd0WbAdeLC7fdIX6qO9Z8/jmTVANZ9v0VmOFsxTj0DnBSYa62U
         ygA3kHOqnvaRzE5Yt3XodzqjofDSLtm9k4BM916o=
Date:   Wed, 18 Mar 2020 13:29:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     tkjos@android.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2] binderfs: port to new mount api
Message-ID: <20200318122951.GA2583829@kroah.com>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313153427.141789-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313153427.141789-1-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 04:34:27PM +0100, Christian Brauner wrote:
> When I first wrote binderfs the new mount api had not yet landed. Now
> that it has been around for a little while and a bunch of filesystems
> have already been ported we should do so too. When Al sent his
> mount-api-conversion pr he requested that binderfs (and a few others) be
> ported separately. It's time we port binderfs. We can make use of the
> new option parser, get nicer infrastructure and it will be easier if we
> ever add any new mount options.
> 
> This survives testing with the binderfs selftests:
> 
> for i in `seq 1 1000`; do ./binderfs_test; done
> 
> including the new stress tests I sent out for review today:

<snip>

Thanks for these, all now queued up.

greg k-h
