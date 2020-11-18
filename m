Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779082B86EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKRViF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 16:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgKRViF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 16:38:05 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6995420715;
        Wed, 18 Nov 2020 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605735484;
        bh=1GNhQS9oJ1VMOeVJZd7DckTPUAzaUGj3VELjqx9eCrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbQS0LDDaR73lYUBkITbwgJU+F0yk29fgfF2xGCCuLCf2SRPda8grCiFvwGyzDW9X
         EQXsom1Y4GhNk5hMPuDI+pj/Kui9XHyTUgsd4lxMWaAkn/JfAauH7isg7UM5pyr5/f
         JqLyxcDXOGeSScCDOmQ4XZKKIBsiM21WOzsXE+f4=
Date:   Wed, 18 Nov 2020 23:37:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20201118213755.GA62979@kernel.org>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118171900.GJ7472@zn.tnic>
 <20201118175850.GA42022@kernel.org>
 <20201118180450.GL7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118180450.GL7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 18, 2020 at 07:04:50PM +0100, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 07:58:50PM +0200, Jarkko Sakkinen wrote:
> > Duh, I sent the fix for the selftest before seeing this.
> 
> All, good - your static key fix is queued now too. The only thing that's
> needs work now is the anon inode thing but that can come later.

Just checking that I got this right: you want me to port my anon inode
changes from March to be applied on top of tip and send them?

> > Thank you, I'll separately clone tip and test it.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
