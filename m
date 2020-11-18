Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6ED2B82B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKRRKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgKRRKB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:10:01 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF63221F1;
        Wed, 18 Nov 2020 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605719400;
        bh=c8Mnehbf32C+bHvE+4NC0fVU9q1Lyqk/yGWhTVt2OgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIcbGcZE7SZwAB0Ef+ybFlbmsttbA8KH8VjB+ReGtlbO75FMVb9aA7Jo7U6TFu+8U
         I6FZPrBQN3vo8gMFStZbPKnCYK+biT39u5RwPiOQRlx53NeLqJrvn2izYEiAn2lEiG
         oR9b3NaDgCUcJZzmV/8dcC9N5m+JCiACwwCCvGNc=
Date:   Wed, 18 Nov 2020 19:09:51 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-sgx@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201118170951.GA39857@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
 <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 01:00:30PM +0100, Jethro Beekman wrote:
> On 2020-11-18 12:44, Borislav Petkov wrote:
> > On Wed, Nov 18, 2020 at 12:18:00PM +0100, Jethro Beekman wrote:
> >> Just to double check, since you didn't show the /dev mount line: that
> >> is also not mounted noexec?
> > 
> > Yes:
> > 
> > udev on /dev type devtmpfs (rw,nosuid,noexec,relatime,size=8021332k,nr_inodes=2005333,mode=755,inode64)
> > 
> > but this is how udev mounts it by default. Now I did:
> 
> On some distros, unfortunately, yes, and this breaks SGX. See https://www.spinics.net/lists/linux-sgx/msg02562.html and https://www.spinics.net/lists/linux-sgx/msg02617.html
> 
> > 
> > # mount /dev -o remount,exec
> > 
> > and I got
> > 
> > udev on /dev type devtmpfs (rw,nosuid,relatime,size=8021332k,nr_inodes=2005333,mode=755,inode64)
> > 
> > and now it fails differently:
> > 
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > encl_load: encl->nr_segments: 3
> > encl_load: seg2 offset: 0x3000, seg2 size: 12288
> > encl_load: encl_size: 32768, src_size: 24576
> > encl_map_area: encl_size: 32768
> > encl_map_area: area: 0x0x7feae0db2000
> > encl_map_area: encl_base: 0x7feae0db8000
> > SGX_IOC_ENCLAVE_INIT failed: errno=1
> > 
> 
> I think that means SGX_INVALID_SIG_STRUCT, which is a very odd error
> to get. It basically means the file header is wrong. Maybe some
> concurrency/fflush issue in the test?

Sent a fix:

https://lore.kernel.org/linux-sgx/20201118170640.39629-1-jarkko@kernel.org/T/#u

> --
> Jethro Beekman | Fortanix
> 

/Jarkko
