Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78242B7D7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKRMP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 07:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgKRMP6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 07:15:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4EC0613D4;
        Wed, 18 Nov 2020 04:15:58 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf0066ae0a9db02cf7f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:66ae:a9d:b02c:f7f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F6461EC01A8;
        Wed, 18 Nov 2020 13:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605701756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tOGMtap9B3qwzc4M/+6PsUoPZ17ytoVOwSGkC5WkXdk=;
        b=b0Lb0EPWHVXOzWORPjX7OubdVMhH3reVPdczyS2qeKKqDhq1RUcA3hy8vI6ItTf4CXf0m3
        7FnhxzccWtBJOk0dt9ukbp1A28shblEOdKxHMehl3hEx/POxIz02p8dvGCvx9W5UMbnSoA
        MlVXSCjBpB3Xl5vBr+RGW60htkr8bFw=
Date:   Wed, 18 Nov 2020 13:15:50 +0100
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
Message-ID: <20201118121550.GG7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
 <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 01:00:30PM +0100, Jethro Beekman wrote:
> On some distros, unfortunately, yes, and this breaks SGX. See
> https://www.spinics.net/lists/linux-sgx/msg02562.html and
> https://www.spinics.net/lists/linux-sgx/msg02617.html

I guess anonymous inode doesn't sound all too bad, albeit Sean calls it
an ugly hack.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
