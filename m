Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08B492AEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiARQPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 11:15:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiARQOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 11:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5A38B8170D;
        Tue, 18 Jan 2022 16:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46FFC00446;
        Tue, 18 Jan 2022 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642522444;
        bh=PSneYsa7NC27IMT71cW3a2HWxU3TGCHFByHMVfxMNLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Muyf1BzGrXHozhWbUJBGbajNRp3tH0IFPSY3A/vEMxRQK68S31kEXs4GBt5CYDveK
         QiqwmHNke6MW7RjAkyX+bSS3aUNwa/P9TbGIXnC676Xx9uLFZM+Rm3QFffyUs4UaKV
         GvDy9oyqhqIsn5uD7DKVZjA9RxACY9jtSUeXHsHs=
Date:   Tue, 18 Jan 2022 17:10:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: Re: [REGRESSION] lkft kselftest for next-20211124
Message-ID: <YebmcuuckaSr6Tfy@kroah.com>
References: <0100017e6deccd3f-77964da7-0ebe-4914-b2dd-15e0449aa7fd-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100017e6deccd3f-77964da7-0ebe-4914-b2dd-15e0449aa7fd-000000@email.amazonses.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 04:02:22PM +0000, lkft@linaro.org wrote:
> ## Build
> * kernel: 5.16.0-rc2

Why are you testing an old kernel that is known to have issues?

confused,

greg k-h
