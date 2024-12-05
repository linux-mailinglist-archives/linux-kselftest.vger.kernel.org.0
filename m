Return-Path: <linux-kselftest+bounces-22874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4149E5B11
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32D11887561
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85E22145C;
	Thu,  5 Dec 2024 16:12:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736521D5A8;
	Thu,  5 Dec 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415140; cv=none; b=R5S8LHJWneFyQfMgqBlZk/SgR0C/rHswX87iBeY0thluNDrTBozUAnb5lHKOCOUCsObVZpb6HCvRNnHDogzXROQ/55slQ0B5M00yCHh77Bo3mNtZJ8aGKTTJYtWUnlI/Ble4xxM/II3KkByBDq7YHjxt7wlgs+AEw4jgBv+CN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415140; c=relaxed/simple;
	bh=OG5fCxgMQ2Y/Y54cuXKA24jMQsIKEcpN7WyTfNoTDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZ2n6B83jJfN2yLZG4SGPHah9+XOTe02IHooi3LbaaLhmaMwgiEYNMFCqf2QWwmWXAdf76vPqbIfGRG572rM7aKDG1kDr/1w24OReUcBIvDlB5eSr9ZNqnKQrJkyHCSbMqAUrXo6LqCx+3zDIyb2nDuKT0HpscRXX/o0vIrB6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC47C4CED1;
	Thu,  5 Dec 2024 16:12:17 +0000 (UTC)
Date: Thu, 5 Dec 2024 11:12:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Naveen N. Rao" <naveen@kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
Message-ID: <20241205111222.6dbcd3f3@gandalf.local.home>
In-Reply-To: <d9467ba5-ec01-4683-8078-d85574b2506c@linuxfoundation.org>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
	<20241202144111.75d1bb3b@gandalf.local.home>
	<fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
	<20241203202008.1f30a266@gandalf.local.home>
	<d9467ba5-ec01-4683-8078-d85574b2506c@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 09:06:43 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> I applied this to linux-kselftest fixes - will send it up for rc2 or rc3

Thanks Shuah,

-- Steve

