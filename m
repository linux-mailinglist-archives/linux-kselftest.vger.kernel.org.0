Return-Path: <linux-kselftest+bounces-10027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB48C2A1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78541B22521
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800EA3CF4F;
	Fri, 10 May 2024 18:50:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0071D530;
	Fri, 10 May 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367052; cv=none; b=E3EgGmdkYRiYYq6jpDDStuaOIdq12ZCC6jmZainp3bZoxvHwAsrcdqeC3vS+EzLbvGhCXdgg3hm8LwjAhZfseZwgsuLL7tLSlD1L6ztEERPLBHbDh48P/x+00wB7xb7wajBe0e7h6TWZseQLj2TPjEChR7cydMOtfR4q94lshos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367052; c=relaxed/simple;
	bh=e7uIjmMcTrhCA5y0fkEdV6CCqpLq7cPfMeAYBvcsvIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q58wAht9olvhhGkJ+w9/MMKTg88fersoJ8pW6iEHrXyfMWEUCVqpPM/roStrMGRYPcXYQPKw1XBSuJ4uxNBFNy3M2a8gFiRRGfGA1JI5Ab0ab5fi+Vp1C6jZCL3AKMw2rNEMLIuel8niBgsLLabxJaHKglGAxAmzY45B2wYAa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B98C113CC;
	Fri, 10 May 2024 18:50:51 +0000 (UTC)
Date: Fri, 10 May 2024 14:50:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Muhammad Usama Anjum
 <usama.anjum@collabora.com>
Subject: Re: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
Message-ID: <20240510145049.068eae27@rorschach.local.home>
In-Reply-To: <20240510144436.37ea0276@rorschach.local.home>
References: <20240430111354.637356-1-vdonnefort@google.com>
	<20240430111354.637356-6-vdonnefort@google.com>
	<5bdb08a2-0740-4ea0-be24-a948332d60ac@linuxfoundation.org>
	<20240507193555.592a1e28@rorschach.local.home>
	<Zj3_P5UsO61yp7a7@google.com>
	<20240510144436.37ea0276@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 14:44:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 May 2024 12:04:31 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > Can you address Shuah's concerns. I'm starting to test patches 1-4 so
> > > you only need to send an update to this one, unless of course I find an
> > > issue with one of the others.    
> > 
> > I will do, as well as with the VM_ flags change.  
> 
> Just so I'm not confusing you. Pleases send a full patch series again.
> I only wanted the one patch if there wasn't another issue found. But we
> found another issue, so it requires sending a full series.
>

I just noticed that you posted the full series so never mind.

-- Steve

