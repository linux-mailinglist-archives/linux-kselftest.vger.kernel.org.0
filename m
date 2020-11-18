Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6347E2B8395
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKRSE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 13:04:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKRSE7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 13:04:59 -0500
Received: from zn.tnic (p200300ec2f0caf00cee835374c0b640d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:cee8:3537:4c0b:640d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3AD01EC04B9;
        Wed, 18 Nov 2020 19:04:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605722697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JaQw+o5CPDUvhtL42lypkEsjqenpsUoTRUYLzM4aOYc=;
        b=DDcw5W3qVpxwcMqkTS4dXYhYosiBkSsUbvu67bCZi4wzE+bEwdmMOYncNV9rJ6ujcnvMhJ
        wujvTTDimzQ4awRlu5suG/v2jAWfL+31Z/D56zBkRF1UTDk3R5do02WceNt596hdmXY96G
        nMZDXLmiLK+dburzRBPwyIU1XYKyCWQ=
Date:   Wed, 18 Nov 2020 19:04:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
Message-ID: <20201118180450.GL7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
 <20201118175850.GA42022@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118175850.GA42022@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 07:58:50PM +0200, Jarkko Sakkinen wrote:
> Duh, I sent the fix for the selftest before seeing this.

All, good - your static key fix is queued now too. The only thing that's
needs work now is the anon inode thing but that can come later.

> Thank you, I'll separately clone tip and test it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
