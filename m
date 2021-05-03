Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA24237181B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhECPjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 11:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPjD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 11:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6385061159;
        Mon,  3 May 2021 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620056289;
        bh=SkaNcNSC8IW7uIOhzo9I99etpohr4y6w3U/SqE4P9TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BK8aSu1CYZo7rclcvcJtm5GkJ8t2fTA+FeviFJUlWgwoNdcJHHfBqlXKQ/Zy7AKg3
         qyVFwSEYFTJNlxOhbWsGr41CrJNjbmojHwiqFnnMtu5xhP+djSB3MtLGxHtgZghX2I
         jFf9ZSdr2nshzoQXxy+Y/3Cm20OWhiB/BFv9NA2tvbNgAHBqu6Gy3sCpxBqm3O6+vo
         YRlwBfdAzdvua1ISTKNAWbabPe08Hva1q9Y4AAu3caNfbMJplqtV8YXum0bes8Bh5a
         4MjbYyF0Xx1mPDmSjwp0Fz5iloVSIyTZtrqUNWhGIB953KDgxYh59avni2U/j97BGu
         2b9AqQ1qY314w==
Date:   Mon, 3 May 2021 18:38:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH 0/1] SGX self test fails
Message-ID: <YJAY345r2GZ0X9bP@kernel.org>
References: <20210429183952.22797-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429183952.22797-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 29, 2021 at 12:39:51PM -0600, Tim Gardner wrote:
> I'm just starting my learning curve on SGX, so I don't know if I've missed
> some setup for the SGX device entries. After looking at arch/x86/kernel/cpu/sgx/driver.c
> I see that there is no mode value for either sgx_dev_enclave or sgx_dev_provision.

Take a look at

https://github.com/systemd/systemd/pull/18944

> With this patch I can get the SGX self test to complete:
> 
> sudo ./test_sgx
> Warning: no execute permissions on device file /dev/sgx_enclave
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> SUCCESS
> 
> Is the warning even necessary ?
> 
> Tim

With a quick look, I think that check is too strict. AFAIK, mmap(PROT_EXEC)
can be done, as long as the file is not in a noexec FS.

Dave?

For reference:

https://lore.kernel.org/linux-sgx/20210318194301.11D9A984@viggo.jf.intel.com/

/Jarkko
