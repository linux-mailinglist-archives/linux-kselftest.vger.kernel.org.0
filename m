Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4308C2B61D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgKQNWp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 08:22:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbgKQNWm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 08:22:42 -0500
Received: from zn.tnic (p200300ec2f101300ba25257689a011f5.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:ba25:2576:89a0:11f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B8B1EC03CE;
        Tue, 17 Nov 2020 14:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605619361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=20A+JSZTq0uSGOoQCxJWr5HNHVawruXZylnMqKk1XtY=;
        b=XQ8/EgQsrFEBFXODTFwizejrV6cmkUB4O9w3QoB2B8+AuClH7cWIrwjLeV8PagcEIdLsOY
        LNIu2V/rAV3/7H87f7a4YFJq5x2+OjkG16LWCDLuHDcNhyCZldxBKmxmx8cf55Hu8gBGbC
        uixEsZG7WCjsAJZ4t+3YSm5zgCWYNZk=
Date:   Tue, 17 Nov 2020 14:22:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 20/24] selftests/x86: Add a selftest for SGX
Message-ID: <20201117132241.GE5719@zn.tnic>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-21-jarkko@kernel.org>
 <e58ee564-597a-336e-53dc-7c4d172d51f5@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e58ee564-597a-336e-53dc-7c4d172d51f5@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 11:19:12AM -0700, Shuah Khan wrote:
> Please keep the list sorted alphabetically as stated
> in the comment above.

Done.

> This should be KSFT_FAIL.

and done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
