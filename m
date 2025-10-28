Return-Path: <linux-kselftest+bounces-44210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB4C16C65
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 084FF4FE037
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1532C325C;
	Tue, 28 Oct 2025 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LqATq1YJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC72BE650;
	Tue, 28 Oct 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683168; cv=none; b=W/JLlfyQwAl+f1DAB7rvEexKltDM20uo7lnS0ftsB6hTlZWYKPo5NTWe+9m7n+vYjIJDfxoVJXMiQZGY0tn2+zQtY02XKQkVrz9UAtCocVt/m7t2oeBYGGk34khDfsKg9EDe99hASLyD5Vz9oPJc9dxl0pWUoRJo2Zhv71LDLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683168; c=relaxed/simple;
	bh=mufjAN3ZOaAAOgKYwrgWMAEjc4T917ZVwPZR3WxJgy8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C/oA9QZfz5NrmxoL6oXZ2cIII4QWb/ZNhUbe+dOz5zlL5IMibQbuyP1tg+5Jw2rgbJI1i+oD8EJxtCrzn24zueWdDB18GQ5m7f5bt79Vk68tZzQvFARwcl5KKeWt/cENyQgn5+G3fFlVh48KlH+4BhQcZC2GAW5+pihZ4o8zBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LqATq1YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910AFC4CEE7;
	Tue, 28 Oct 2025 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761683167;
	bh=mufjAN3ZOaAAOgKYwrgWMAEjc4T917ZVwPZR3WxJgy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqATq1YJi0hjM1WG9L/R86XeOCVJFfgdgNVmn99vpM1ll3zuXM3fzCnVVdfCzwRQW
	 idKaRBsqgmBLOztOd1B+0jnWH9gWZBu29t6ncYefyHMbSTQ5qO7MPPKgw21PMtTKp0
	 Z98c/vafkmtUaDhZIks2QqCh7TREbiV+Rwd0wADk=
Date: Tue, 28 Oct 2025 13:26:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Wei Yang
 <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-Id: <20251028132605.2926d3ef5eb6ea60d22ceffe@linux-foundation.org>
In-Reply-To: <aQD2Igc3svAF3klc@fedora>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
	<20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
	<aQD2Igc3svAF3klc@fedora>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 22:28:10 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:

> > > @@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
> > >  	ASSERT_EQ(1 << reg.enable_bit, self->check);
> > >  
> > >  	/* Ensure write shows up at correct offset */
> > > -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> > > +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> > > +	ASSERT_NE(-1, write(self->data_fd, &write_index,
> > >  	                    sizeof(reg.write_index)));
> > 
> > Simply casting &write_index to void* would fix this?
> 
> yes, this hides the type mismatch from the compiler. But i think
> casting to void * will not fix the alignment mismatch for packed struct.
> It works on x86, but might break on other platform.

It's the second argument to write(2)!  write(2) expects a const char *,
but void* will work.

