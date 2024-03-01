Return-Path: <linux-kselftest+bounces-5682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45C86DA48
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1291C22452
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 03:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DC45C0C;
	Fri,  1 Mar 2024 03:39:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B055101A;
	Fri,  1 Mar 2024 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264368; cv=none; b=Isnpdw5eICUPSdBiRrRWR/WJn6EzgJdIInvTBkNdEjnPGXmqHRsaZjIoB1mGv8mk/+hpFsyXrVHeCbB9Kd1AWo7pJUl+9IxbsKolqzuKfMFO2Zp+hCqJHmrA7+ipB4t9608Mgzdq7xeyPaAHDt9JkB5X5xyRqsqPStBYrr3scC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264368; c=relaxed/simple;
	bh=hCwHC6YHYeHRrzYtIjmVMYTNuMcifRouL3WqqWiAl9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWmGJ+nsKf1+GiXvzwGosBML2O1/5uyj0tdvUd4fkM1shObF1sLS8gFphjTmL0gJyMqW1E1hD85k+XZozXrQFZcDSCETvVkB1OBLQiNCEVRw+SIjUX47HD2K/lJgzMbGztx7HKn4c58gzIPX48nF4jzQhhdqfaKyGxGE886Hv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E3C433F1;
	Fri,  1 Mar 2024 03:39:26 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:41:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-ID: <20240229224134.55c1c36b@gandalf.local.home>
In-Reply-To: <20240229175216.96bb2e16b510f81e3802ef23@kernel.org>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
	<20240229145139.a215085c44add62302463312@kernel.org>
	<20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
	<20240229161320.978190f42dcc1a521c192e7d@kernel.org>
	<20240229175216.96bb2e16b510f81e3802ef23@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 17:52:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Lol, I haven't allocate the entry data size when initialize rethook.
> That's a bug.
> Please try below.

I'll wait to review patches 5,6,7 as I'm guessing this will have a v3?

-- Steve

