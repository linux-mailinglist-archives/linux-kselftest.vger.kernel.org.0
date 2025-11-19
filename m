Return-Path: <linux-kselftest+bounces-46024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DCC7148C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C4218208A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D52E0415;
	Wed, 19 Nov 2025 22:34:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BC25BEE7;
	Wed, 19 Nov 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591663; cv=none; b=H2uRSIk+RFcKCtqh0r5N4EusoF+cwBSMtygycABSJ18na/w5HBSvVskAh+MVTLzxPjaE4k+smUTmRPgHBwMshJed9kx1NgD447nZbc3bUBComL82uq74ULKWSZpOLS4icisZyiLh2HFCgfVKT40Q/KB+qVvlpew/55UZM8pSxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591663; c=relaxed/simple;
	bh=SnbvjvrX77gO8SzkYhCJY0xBXmPN4XI0ZbTQe/xfOXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIjcAqgmKSLxm8cNxsb2zoRSEqF1uWVq5pz6FIAztfW/E7EK25sTQHnjBpYk4YskHS062bKNg6wJfY/KJtlmfs4Cv5vxIY7oxwu/bBMJ9K+IGvSCFRWS+U9dDcNQxd4QTDCya+s3XloA/yLB4EUhRSvT0k7ovj95b/NuTlY0kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 58D0DBA94A;
	Wed, 19 Nov 2025 22:34:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 4967818;
	Wed, 19 Nov 2025 22:34:11 +0000 (UTC)
Date: Wed, 19 Nov 2025 17:34:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: tracing: Update fprobe selftest for ftrace
 based fprobe
Message-ID: <20251119173441.3aa33415@gandalf.local.home>
In-Reply-To: <f6831d9a-4ea6-4100-9b1b-716ac93e1cdd@linuxfoundation.org>
References: <176295318112.431538.11780280333728368327.stgit@devnote2>
	<f6831d9a-4ea6-4100-9b1b-716ac93e1cdd@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4967818
X-Stat-Signature: yru9doabtx9zix1yjx5k5t34q7zh58pf
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+c5yWUdYkSaQYYwlFp1IMTaS15bQw9QD8=
X-HE-Tag: 1763591651-374537
X-HE-Meta: U2FsdGVkX188VNyUNtqM4j95nY1svkSPoJk59wldZSd9DpjIeMZ/yN0pqbvxZRZASTKhCIpHkZDlmx/5V6pk4C5bdhixIUnOWjLGd0J7bVSrRnm6h9WJ1695VdmkActmpE6W9q8Q4mAYIU4R02cEUEk4r/U+xy3aJPKGl1FFe9yDRWMbGiCakHRL39ep4RIyrKLpadmzx/B5R5fJXJDzPwTK8W4ENExb+PACN2Sazpfo0z2eGijzTPBP8EOBzl9ioTxOp4L0uacVQ7p1Fm4koGXG7iIOI6XHvudf5FRvGnCxSWPeZlhPiPVutwkEK48MrKSFFeXBh618bYM0mu521YOXlhfTpK5BvBsDDDinQPzl8ck9DOnTnumoRiMxcBLE6q+Qex03RUHh6V1BsChGTA==

On Wed, 19 Nov 2025 15:16:04 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 11/12/25 06:13, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the ftrace fprobe is both fgraph and ftrace based implemented,
> > the selftest needs to be updated. This does not count the actual
> > number of lines, but just check the differences.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   18 ++++--------------
> >   1 file changed, 4 insertions(+), 14 deletions(-)
> >  
> 
> Steve, do you want me to take this through my tree?

Yes please, unless Masami thinks otherwise.

-- Steve


