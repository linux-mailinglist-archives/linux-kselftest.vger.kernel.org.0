Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79A32A7ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579229AbhCBQq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351217AbhCBNtZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 08:49:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3B7D60C41;
        Tue,  2 Mar 2021 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614692863;
        bh=1QT9Jo+ZtFYdSbb6Zn/Pha/R/xZ7LYXPosLrCrzMQcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSh8R9umiFJRz+GUvZwTd2thTzX9ClmlXqz8aglezu0NoxCyoRi87nCzNRsFAz5h5
         xHpje6dLGhNJ/bzyC+yvU0Reo+7x3tm2NBVX0n6ytmmyL4US6+irCTb3wkPT9yy9io
         ZLGwKsrL9Lkklekkd7u9FdxyC4WvXS7NsaATpNMns1vzXOI/prFyywA0mN4nCPiR8s
         Wa8KXA5q4FOOiHiPNsQcTFijayStjXeGLv55MeypRFbLFMSZOTz3OT2gcHGdrYdGgl
         spb554fomGDxD5ibG9F7ByYgXNRMdHLaDmUYrIa51EpL0Z5WuY+CXePaJYC6eQPDwO
         RXg2g1yztMugA==
Date:   Tue, 2 Mar 2021 15:47:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
Message-ID: <YD5B7P++T6jLoWBR@kernel.org>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
 <YDy51R2Wva7s+k/x@kernel.org>
 <3bcdcf04-4bed-ed95-84b6-790675f18240@linux.alibaba.com>
 <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 01, 2021 at 09:54:37PM -0800, Andy Lutomirski wrote:
> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
> > > On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
> > >> q2 is not always 384-byte length. Sometimes it only has 383-byte.
> > >
> > > What does determine this?
> > >
> > >> In this case, the valid portion of q2 is reordered reversely for
> > >> little endian order, and the remaining portion is filled with zero.
> > >
> > > I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
> > >
> > > I'm lacking these details:
> > >
> > > 1. Why the length of Q2 can vary?
> > > 2. Why reversing the bytes is the correct measure to counter-measure
> > >     this variation?
> > >
> > > /Jarkko
> > >
> >
> > When use openssl to generate a key instead of using the built-in
> > sign_key.pem, there is a probability that will encounter this problem.
> >
> > Here is a problematic key I encountered. The calculated q1 and q2 of
> > this key are both 383 bytes, If the length is not processed, the
> > hardware signature will fail.
> 
> Presumably the issue is that some keys have parameters that have
> enough leading 0 bits to be effectively shorter.  The openssl API
> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
> variable-size integers.

But the test uses a static key. It used to generate a key on fly but
in some of the last versions I replaced key generation with a static
key:

static RSA *gen_sign_key(void)
{
	unsigned long sign_key_length;
	BIO *bio;
	RSA *key;

	sign_key_length = (unsigned long)&sign_key_end -
			  (unsigned long)&sign_key;

	bio = BIO_new_mem_buf(&sign_key, sign_key_length);
	if (!bio)
		return NULL;

	key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
	BIO_free(bio);

	return key;
}

/Jarkko
