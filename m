Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC33DB07E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 03:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhG3BDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 21:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3BDe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 21:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1CF960E09;
        Fri, 30 Jul 2021 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627607010;
        bh=AktQh6JLFUAYr6R5McfeUKBxwClypkgS4Rv7pzn41gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6/q702zDk3sob+6PsfffOeGWNPRlBrkiJFEWgVjq9odapABAjC7T+FVFIF/I1biB
         kXWQtjb5Aywpgnn/kdNs7Uj0xrFZ8PIaftrWAcJAvTs1YqC5ozBJQW8gux1iOqvjBg
         GjYMj++8EKaNuACO801OUWQwgjN4aPKfldNGPkUFoguLJPHcOu5GaLx5CTkLFwQ3/3
         AOq5No0m3DwPlKXRgzC5JuokITkX3uqHRYdBlBr+UYExX1Ej3WQ7MJHmvRHsbR45Gq
         fDUol9tk/OWZ8xa5COAQ+O4x7TZGAZ1PZ/hSaigpeiPVuXipclcSDU7plp/B39auJX
         knhcK8GQML/oA==
Date:   Fri, 30 Jul 2021 04:03:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/sgx: Fix Q1 and Q2 calculation in
 sigstruct.c
Message-ID: <20210730010327.zp2amwhmfr5l3nc7@kernel.org>
References: <20210705050922.63710-1-jarkko@kernel.org>
 <be6227d1-728a-c658-f962-380c28afc926@linuxfoundation.org>
 <20210727031227.tx2gqx2qg3mg4522@kernel.org>
 <c5491afc-2a7e-cb36-2a24-6dfa6b08b31a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5491afc-2a7e-cb36-2a24-6dfa6b08b31a@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 03:33:10PM -0600, Shuah Khan wrote:
> On 7/26/21 9:12 PM, Jarkko Sakkinen wrote:
> > On Fri, Jul 23, 2021 at 01:53:06PM -0600, Shuah Khan wrote:
> > > On 7/4/21 11:09 PM, Jarkko Sakkinen wrote:
> > > > From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > > 
> > > > Q1 and Q2 are numbers with *maximum* length of 384 bytes. If the calculated
> > > > length of Q1 and Q2 is less than 384 bytes, things will go wrong.
> > > > 
> > > > E.g. if Q2 is 383 bytes, then
> > > > 
> > > > 1. The bytes of q2 are copied to sigstruct->q2 in calc_q1q2().
> > > > 2. The entire sigstruct->q2 is reversed, which results it being
> > > >      256 * Q2, given that the last byte of sigstruct->q2 is added
> > > >      to before the bytes given by calc_q1q2().
> > > > 
> > > > Either change in key or measurement can trigger the bug. E.g. an unmeasured
> > > > heap could cause a devastating change in Q1 or Q2.
> > > > 
> > > > Reverse exactly the bytes of Q1 and Q2 in calc_q1q2() before returning to
> > > > the caller.
> > > > 
> > > > Fixes: dedde2634570 ("selftests/sgx: Trigger the reclaimer in the selftests")
> > > > Link: https://lore.kernel.org/linux-sgx/20210301051836.30738-1-tianjia.zhang@linux.alibaba.com/
> > > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > The original patch did a bad job explaining the code change but it
> > > > turned out making sense. I wrote a new description.
> > > > 
> > > > v2:
> > > > - Added a fixes tag.
> > > >    tools/testing/selftests/sgx/sigstruct.c | 41 +++++++++++++------------
> > > >    1 file changed, 21 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> > > > index dee7a3d6c5a5..92bbc5a15c39 100644
> > > > --- a/tools/testing/selftests/sgx/sigstruct.c
> > > > +++ b/tools/testing/selftests/sgx/sigstruct.c
> > > > @@ -55,10 +55,27 @@ static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
> > > >    	return true;
> > > >    }
> > > > +static void reverse_bytes(void *data, int length)
> > > > +{
> > > > +	int i = 0;
> > > > +	int j = length - 1;
> > > > +	uint8_t temp;
> > > > +	uint8_t *ptr = data;
> > > > +
> > > > +	while (i < j) {
> > > > +		temp = ptr[i];
> > > > +		ptr[i] = ptr[j];
> > > > +		ptr[j] = temp;
> > > > +		i++;
> > > > +		j--;
> > > > +	}
> > > > +}
> > > 
> > > I was just about apply this one and noticed this reverse_bytes().
> > > Aren't there byteswap functions you could call instead of writing
> > > your own?
> > 
> > Sorry for latency, just came from two week leave.
> > 
> > glibc does provide bswap for 16, 32, 64 bit numbers but nothing better.
> > I have no idea if libssl has such function. Since the test code already
> > uses this function, and it works, and it's not a newly added function in
> > this patch, I would consider keeping it.
> 
> I will queue this up since it is fixing an important problem.
> Let's look into if this can be replaced with a lib call when
> you do cleanups perhaps for the next release.

Thank you.

/Jarkko
