Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3130137B356
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 03:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhELBPO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 21:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhELBPN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 21:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 238EC6191C;
        Wed, 12 May 2021 01:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620782046;
        bh=vfOxNCe9BxPc36rFi4QK3dRxJEm1Vn5HiuA75DFmjZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlEXFwpzLowyEC8dCdgHpO67JNHHumW8D4MCxSRhgSMjkEIVhToPbRoYkLENJMoX0
         eXcYGp5ApLdmYzQzqtWykEzdRdAC1pKAyYpF0mm5P3Mpa8fec5rmFs2yque1zfDaRI
         FBciARyv4bQxFsKhO1EzVrX/5XIWKqfrjhMCp7tsrydPQx0JtmpKpqEVX2SaGulN6V
         T/eAzglCqkmd4BhWA5eAbfO6VAz9lUY7uxn74DNArqiyNUdp5OotlLVfpndAiX4cpu
         Z3ysCd/jdcOkLbRfzLlC5wpH0tKET1x+pSNjKKJ1N719E+38FRlPBh12qneCcY4QC9
         wMWO2E4NbwTBg==
Date:   Wed, 12 May 2021 04:14:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        reinette.chatre@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Message-ID: <YJsr3MWf55UWLCiO@kernel.org>
References: <20210508035648.18176-1-jarkko@kernel.org>
 <4b8d9604-8d35-eefe-41cb-511b92a3f086@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8d9604-8d35-eefe-41cb-511b92a3f086@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 11, 2021 at 11:49:18AM -0700, Dave Hansen wrote:
> On 5/7/21 8:56 PM, Jarkko Sakkinen wrote:
> > Rename symbols for better clarity:
> > 
> > * 'eenter' -> 'vdso_sgx_enter_enclave'
> > * 'sgx_call_vdso' -> 'sgx_enter_enclave'
> 
> Another sentence or two here would do wonders:
> 
> 'eenter' might be confused for directly calling ENCLU[EENTER].  It does
> not.  It calls into the VDSO, which actually has the EENTER instruction.
> 
> 'sgx_call_vdso' is *only* used for entering the enclave.  It's not some
> generic SGX call into the VDSO.
> 
> Make the naming reflect that.
> 
> Right?

Agreed.

I'll spin off a yet new version of the series, taking also care
of the log messages that the enclave loader emits (Renette's
feedback). They should be wrapped with TH_LOG() macro I suppose.

/Jarkko
