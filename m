Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20C82B7CFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 12:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKRLov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 06:44:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38564 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgKRLov (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 06:44:51 -0500
Received: from zn.tnic (p200300ec2f0caf00530924e6be7c3eae.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5309:24e6:be7c:3eae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43B6C1EC04B9;
        Wed, 18 Nov 2020 12:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605699890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SArmuYZkk+ECEW0oRVWMCb5OMmeBMQbrJUZ8LKaPvJA=;
        b=oQPh+bDJBTVqtszwqWA6s8+f8QSTgifPZ6QqY8xcEr1cYL2bbQZm5xrHc4h3VVKqZe5SrT
        3ABmlFo7IEsBnTsu8gQIu0mckx0zEARY3B9ex0WjxgFApi3jnBkD0P8rmxJDA6+Kd5Wi6D
        AsIl++Qd/B0/vJH13VBFHwHcU+5Ll+4=
Date:   Wed, 18 Nov 2020 12:44:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
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
Message-ID: <20201118114444.GC7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 12:18:00PM +0100, Jethro Beekman wrote:
> Just to double check, since you didn't show the /dev mount line: that
> is also not mounted noexec?

Yes:

udev on /dev type devtmpfs (rw,nosuid,noexec,relatime,size=8021332k,nr_inodes=2005333,mode=755,inode64)

but this is how udev mounts it by default. Now I did:

# mount /dev -o remount,exec

and I got

udev on /dev type devtmpfs (rw,nosuid,relatime,size=8021332k,nr_inodes=2005333,mode=755,inode64)

and now it fails differently:

0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
encl_load: encl->nr_segments: 3
encl_load: seg2 offset: 0x3000, seg2 size: 12288
encl_load: encl_size: 32768, src_size: 24576
encl_map_area: encl_size: 32768
encl_map_area: area: 0x0x7feae0db2000
encl_map_area: encl_base: 0x7feae0db8000
SGX_IOC_ENCLAVE_INIT failed: errno=1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
