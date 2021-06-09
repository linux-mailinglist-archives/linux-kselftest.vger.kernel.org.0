Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C33A150B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFINEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 09:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhFINED (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 09:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D443C61108;
        Wed,  9 Jun 2021 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623243729;
        bh=HJUj0Zp7HP5Zllx4h5EYuzKlgKy4TSOLM0QRjmLM2rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J12GHf3XzR6X0GIw7L++qzGrGor4N3jL6KIp4GQXurdsf+ylcLaP07KW5utk5LRJW
         /M1ijmE2iw6tGQ+I2sU8hJb3SwDCGIMnDXmycAgp6cRUT2uHHJVIQMdBm10ARwLUak
         aeoQVIbfpwM7I0uKMsXsdiwI5zLtWqreyExr5f9JgLttcvOFkr21EBcBgkDzT+zA6q
         QD8UIxeXBNo3d8IOTld0FWT+8snqVaMZFtrl+szcYVU1xEwU6P1JCrkYH/k/J2dANh
         4cC0TQGDRnxHZDMBP8GrHHkFdG39+m46pOmIjT9OuT3DYTYCM4a0sCmaBE8Nx0zh4c
         GN7225lOiK9uA==
Date:   Wed, 9 Jun 2021 16:02:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] selftests/sgx: Migrate to kselftest harness
Message-ID: <20210609130206.ezv5flznlb2g6wm7@kernel.org>
References: <20210526124740.16783-1-jarkko@kernel.org>
 <20210526124740.16783-2-jarkko@kernel.org>
 <da0c7ded-3fec-9b30-8955-7a2525dc1f22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0c7ded-3fec-9b30-8955-7a2525dc1f22@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 07, 2021 at 09:35:25AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/26/2021 5:47 AM, Jarkko Sakkinen wrote:
> 
> ...
> 
> > -	exit(KSFT_PASS);
> > +static inline int encl_call(const void *in, void *out, struct sgx_enclave_run *run, bool clobbered)
> > +{
> > +	void *in2 = (void *)in;
> > +	int ret;
> > -err:
> > -	encl_delete(&encl);
> > -	exit(KSFT_FAIL);
> > +	if (clobbered)
> > +		ret = vdso_sgx_enter_enclave((unsigned long)in2, (unsigned long)out, 0,
> > +					     EENTER, 0, 0, run);
> > +	else
> > +		ret = sgx_enter_enclave(in2, out, 0, EENTER, NULL, NULL, run);
> > +
> > +	return ret;
> > +}
> 
> I find this change unnecessary because it is very specific to the current
> test cases and limiting future test cases. From what I understand it
> attempts to create a generic "call into the enclave" wrapper but in doing so
> it constrains the call to use only two registers, assuming there will always
> and only be just an "in" and "out" parameter needed.
> 
> Reinette

Thank you, good catch, it should be a macro. I'll turn in such.

Other than that, it does not limit anything as we are talking neither API
or ABI.

/Jarkko
