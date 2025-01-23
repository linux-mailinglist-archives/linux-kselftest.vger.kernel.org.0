Return-Path: <linux-kselftest+bounces-25054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37055A1ACA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521C616A465
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A71D014E;
	Thu, 23 Jan 2025 22:25:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2E1CF5F2;
	Thu, 23 Jan 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671124; cv=none; b=AdNaAVmGRY2ApKFlG/fLXXXQvBAr2fcSfATWf2NPwFOKiCQ2zErz+Lmpz+QX6FXZXtsEqmJmatSqUYeCnMewWC7E4h5czrw7POFDypuweVaKkfudLYut4yW4l1PnGqCc3SlyN6rA8evkMqwi9tWelNAAoynYEr31BhmePzqvC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671124; c=relaxed/simple;
	bh=1F5+zbSF4Law8g7xXL9ql6mF0AbpGo+/gJRp8r7GTrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrDxUgYcQBdajYi2vmjOmXe7hnItuaDDvmtu+mbV7hcOCZASGeSGaXvObpGLyrsHHzgOcIoUbwtcd/+rnzxhAhTzLbgIn2PWbs65ziCpmmlJRaE/FLHt3ex66zVOv3W86WPfkeW8LFUNJ97dbcORnrVu88LnWtKK9e9kBMdgXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A931DC4CEDF;
	Thu, 23 Jan 2025 22:25:22 +0000 (UTC)
Date: Thu, 23 Jan 2025 17:25:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not
 the instances
Message-ID: <20250123172530.474e873f@gandalf.local.home>
In-Reply-To: <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
	<20250115202607.00c6d353@gandalf.local.home>
	<571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 14:56:55 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > 
> > Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
> >   
> 
> Do I need to do anything or is this taken care of?

I think you can take that series. If you want I can resend with you and the
mailing list Cc'd.

-- Steve

