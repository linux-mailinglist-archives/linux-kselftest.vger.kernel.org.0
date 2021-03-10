Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AA3349E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 22:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCJVkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 16:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCJVjg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 16:39:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D14864FC4;
        Wed, 10 Mar 2021 21:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615412375;
        bh=UdFxVt64TzjKasA+NMSYVTgOVpISnwKFURrW8ppuVck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=El7iw81ezSJi4ARA7ejwk5ECH5c2j22Aay12Zi77N7B5T7/Fdw7c3wOJk35JlyBBW
         H8WtGS3rFYrYVYZcXQBFzQXDoeYjMeQ0/ElxndxpDnp1HpkvBz4CVjJ5952mcg7tgn
         LFZ9hXoZuTr4QdTJU7dhoKWkgOR2hOpRdFhAu/XGuywTu87XwgQhE7/37TEDLe92/Y
         +W762Xh/CO/ZL4zcdqk7e6VMUgL2uy4RpzpNeeVfTVLHhuh5UcUUNTSH1RGuoyMweZ
         sDCpsIkSFxOruGMEWq92/6GdUo/G748CQ/UqHa06QogWLJ/SqVhsm3M93XDkKmBOMJ
         vODf01DZHbIog==
Date:   Wed, 10 Mar 2021 23:39:11 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
Message-ID: <YEk8f/29icpsUhas@kernel.org>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
 <YDy51R2Wva7s+k/x@kernel.org>
 <3bcdcf04-4bed-ed95-84b6-790675f18240@linux.alibaba.com>
 <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
 <YD5B7P++T6jLoWBR@kernel.org>
 <1f5c2375-39e2-65a8-3ad3-8dc43422f568@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f5c2375-39e2-65a8-3ad3-8dc43422f568@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 10, 2021 at 08:44:44PM +0800, Jia Zhang wrote:
> 
> 
> On 2021/3/2 下午9:47, Jarkko Sakkinen wrote:
> > On Mon, Mar 01, 2021 at 09:54:37PM -0800, Andy Lutomirski wrote:
> >> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
> >> <tianjia.zhang@linux.alibaba.com> wrote:
> >>>
> >>>
> >>>
> >>> On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
> >>>> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
> >>>>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
> >>>>
> >>>> What does determine this?
> >>>>
> >>>>> In this case, the valid portion of q2 is reordered reversely for
> >>>>> little endian order, and the remaining portion is filled with zero.
> >>>>
> >>>> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
> >>>>
> >>>> I'm lacking these details:
> >>>>
> >>>> 1. Why the length of Q2 can vary?
> >>>> 2. Why reversing the bytes is the correct measure to counter-measure
> >>>>     this variation?
> >>>>
> >>>> /Jarkko
> >>>>
> >>>
> >>> When use openssl to generate a key instead of using the built-in
> >>> sign_key.pem, there is a probability that will encounter this problem.
> >>>
> >>> Here is a problematic key I encountered. The calculated q1 and q2 of
> >>> this key are both 383 bytes, If the length is not processed, the
> >>> hardware signature will fail.
> >>
> >> Presumably the issue is that some keys have parameters that have
> >> enough leading 0 bits to be effectively shorter.  The openssl API
> >> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
> >> variable-size integers.
> > 
> > But the test uses a static key. It used to generate a key on fly but
> 
> IMO even though the test code, it comes from the linux kernel, meaning
> that its quality has a certain guarantee and it is a good reference, so
> the test code still needs to ensure its correctness.

Hmm... what is working incorrectly then?

/Jarkko
