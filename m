Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7430CE3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Feb 2021 22:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhBBVy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Feb 2021 16:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232865AbhBBVy4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Feb 2021 16:54:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7804064E46;
        Tue,  2 Feb 2021 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612302856;
        bh=XeZmOfUoVNuBsKDrI2Zf2/XMta6hoxfTXzCxxpBleLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUDffvXgVeI752W/eYf5S3VNWY6peEBDPpSGOPqaYuGnG+RaC8f+SeAzl1vkKLes3
         yhMR7kbVcZOHleUH8Wr9d2zlQFHdvi96vHyqoLx2vsLG2riFmR3Mza5WbUfs8BWPBv
         28wfujh4nSQTjEQY133INAuvcJy/UkzWgDTQ2jRV26azVgw3ADwfen4WGv7Wcdj5Gh
         mhHoOGm8xF9IqdoGpFWpotJIScI6bbIE5U8iyDaCv/UeGHTpRhHnHZDV+QmvGCElOz
         fzdKzSizCpMPAzHog1dvBajxkQOTiKkoEcVPJkJ3R9p3KMkRD2bVy63XeC0o2tVGtU
         vc2PzVb6eJMPg==
Date:   Tue, 2 Feb 2021 23:54:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v4 3/5] x86/sgx: Optimize the free_cnt count in
 sgx_epc_section
Message-ID: <YBnKAP2fIGs7F5Xm@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132653.35690-4-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:51PM +0800, Tianjia Zhang wrote:
> 'section->free_cnt' represents the free page in sgx_epc_section,
> which is assigned once after initialization. In fact, just after the
> initialization is completed, the pages are in the init_laundry_list
> list and cannot be allocated. This needs to be recovered by EREMOVE
> of function sgx_sanitize_section() before it can be used as a page
> that can be allocated. The sgx_sanitize_section() will be called in
> the kernel thread ksgxd.
> 
> This patch moves the initialization of 'section->free_cnt' from the
> initialization function sgx_setup_epc_section() to the function
> sgx_sanitize_section(), and then accumulates the count after the
> successful execution of EREMOVE. This seems to be more reasonable,
> free_cnt will also truly reflect the allocatable free pages in EPC.
> 
> Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>

I just copy-paste my earlier response to save time sice you  seem
to save time by ignoring it and spamming with the same obviously
illegit patch.

https://lore.kernel.org/linux-sgx/YBGlodsOaX4cWAtl@kernel.org/

/Jarkko
