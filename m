Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AEB2B7D07
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKRLtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 06:49:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRLtE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 06:49:04 -0500
Received: from zn.tnic (p200300ec2f0caf00530924e6be7c3eae.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5309:24e6:be7c:3eae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D0711EC01A8;
        Wed, 18 Nov 2020 12:49:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605700143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OgfyCF8+YHrnJLvqSJmwferwYBl5T8hzi+N+O9sZtzE=;
        b=QepjF3a/JUcVWc/343kCJF2KtjD9w3tysQyk7vYfHgnmC84wqulylbZUFKd773Pl5DQvlK
        MGjEbR9Av5b/Q8NNqJLpVoyXHm2cAD52dPwwfxnLumMZAO1FxdplD79OTnkowymy9cfrcK
        8F1S+bXuTn09H5ndwk2mkwcsipEO10A=
Date:   Wed, 18 Nov 2020 12:49:02 +0100
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
Message-ID: <20201118114902.GE7472@zn.tnic>
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
 <20201118114703.GD7472@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118114703.GD7472@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Looks like 10% failure rate:

for i in $(seq 0 100); do ./test_sgx | grep failed; done
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1
SGX_IOC_ENCLAVE_INIT failed: errno=1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
