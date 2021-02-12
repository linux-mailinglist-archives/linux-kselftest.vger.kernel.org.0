Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A3319E49
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Feb 2021 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBLMXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Feb 2021 07:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhBLMVD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Feb 2021 07:21:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5DE564E13;
        Fri, 12 Feb 2021 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132423;
        bh=6DUCsRFYGHnXzFyHTGf4hocmnKpotj3GJZCdaFxix9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtEIGgy3iwx0plj0Z2kAB72EZ8HTzRMI+kzbD+6YPzBhUV2FaYanPAAN0WQnF9Jsd
         /PpKzB4rfL3kDOG2/ad7q6PDyteVkck49PfdgDHdvy0SfO0BDSeeSm3KrTjS3rFT+W
         Jo6zyeMOEpqxcU1UMfLbzre5PYhqufICw3rRVhLtgFIbgzXWc3aMnudP0Upg5Un8sK
         lLv/GzWRbDsZ9BlSOKiiKFJOvufviu5je4/xxW1X6psg67hPoffEKT0DWjPQRDkFb4
         2c0Ge0JacRQaPtZaXbLH8H85YHqZprJttUe5w+CXxPg7RycCt6nluS5avK5LBBhdxJ
         jii+hv1Un+OXw==
Date:   Fri, 12 Feb 2021 14:20:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v4 1/5] selftests/x86: Use getauxval() to simplify the
 code in sgx
Message-ID: <YCZyfnalpqhE39dd@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-2-tianjia.zhang@linux.alibaba.com>
 <YBnMCWW8tux490JK@kernel.org>
 <91629d56-a890-18ac-7b10-b20229343d2f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91629d56-a890-18ac-7b10-b20229343d2f@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 08, 2021 at 05:09:21PM -0700, Shuah Khan wrote:
> On 2/2/21 3:02 PM, Jarkko Sakkinen wrote:
> > On Mon, Feb 01, 2021 at 09:26:49PM +0800, Tianjia Zhang wrote:
> > > Simplify the sgx code implemntation by using library function
> > > getauxval() instead of a custom function to get the base address
> > > of vDSO.
> > > 
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > This needs also ack from Shuah.
> > 
> 
> Looks good to me. Thank you.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah

Thank you.

/Jarkko
