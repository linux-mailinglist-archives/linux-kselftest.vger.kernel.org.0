Return-Path: <linux-kselftest+bounces-44564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF9C27672
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09C13B7C8D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D4199920;
	Sat,  1 Nov 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CLFRKK9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D088A41;
	Sat,  1 Nov 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761967164; cv=none; b=YVwAOK+wJoRjegEKvmMtLNW8r4hpEVCxQ8Ox//8YPFu+Evs0NIXt01+WaDV2aJ0zfspguIbcgSF0MfKRb7xZIdsGZ9F3qxsR2ymnf32Lh2Bn8BzK8Abc1p5Q6F41h+54BvvB7APZSpl3AvSpZOI9foqPMEu+wn5gxYeMDBRXb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761967164; c=relaxed/simple;
	bh=0bDl4Evl43JD3FcmfjL9pGUxTnN5KWMJY8C8qeVhF+Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hf8oNMf+kcYogWsq0kQJA+KE49Yra66aMmYjvXl6yPsp28x1YN2vpornrYr0RBy/TWA/huFuQT6tvdq2gVjNGwHTXQ9xCEph9gDlsz5vIa/hiQuTjCiW9eR3dXjTuUVa24VnMTOEwtP9boSnKBPI6/g7fLq9d6jHDAUmzgWbBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CLFRKK9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C8CC4CEF7;
	Sat,  1 Nov 2025 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761967164;
	bh=0bDl4Evl43JD3FcmfjL9pGUxTnN5KWMJY8C8qeVhF+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLFRKK9TWsimttfuaW9EtO5QFoKpOVoQnRWdpjAS0qdvxt2bFvMkPcC4bcArqHtaQ
	 aFcBWz2z7DCoc2sGAp2bGOyuujPsyO2sRbuTR36Jft1WpIktstGLYw5fQ5bYfCiaQk
	 +yfqCb7YHBbG4LwOiePhDC/6ZQZMi+F6ct5vdTW8=
Date: Fri, 31 Oct 2025 20:19:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Wei Yang
 <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-Id: <20251031201923.2e9a592a209c0978246f63d6@linux-foundation.org>
In-Reply-To: <aQIwxjBNonW5Py_I@fedora>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
	<20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
	<aQD2Igc3svAF3klc@fedora>
	<20251028132605.2926d3ef5eb6ea60d22ceffe@linux-foundation.org>
	<aQIwxjBNonW5Py_I@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 20:50:38 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:

> > > > >  	/* Ensure write shows up at correct offset */
> > > > > -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> > > > > +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> > > > > +	ASSERT_NE(-1, write(self->data_fd, &write_index,
> > > > >  	                    sizeof(reg.write_index)));
> > > > 
> > > > Simply casting &write_index to void* would fix this?
> > > 
> > > yes, this hides the type mismatch from the compiler. But i think
> > > casting to void * will not fix the alignment mismatch for packed struct.
> > > It works on x86, but might break on other platform.
> > 
> > It's the second argument to write(2)!  write(2) expects a const char *,
> > but void* will work.
> 
> Hi Andrew,
> Indeed 
> `ASSERT_NE(-1, write(self->data_fd, (void *)&reg.write_index, 
> 		     sizeof(reg.write_index)));`
> 
> would work. However since `reg` is packed struct, directly taking the 
> address of its member  `&reg.write_index` may lead to unaligned access 
> on some architectures. as indicated by the compiler warning
> 
> 	perf_test.c:239:38: warning: taking address of packed member
> 	'write_index' of class or structure 'user_reg' may result in 
> 	an unaligned pointer value [-Waddress-of-packed-member]

Well sure, we might get an unaligned pointer value and it would be an
error to dereference that pointer.

But we don't dereference it!  We pass that pointer to write(2), which
is happy with any alignment.

The warning is accurate.  It "may" indeed "result in an unaligned
pointer value".  But there is nothing at all wrong with this code.  OK,
let's find some way to suppress the warning (preferably without adding
a pointless memcpy) and let's make the changelog and code comments be
clear about what's going on here.


