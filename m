Return-Path: <linux-kselftest+bounces-24750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64FA15B11
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE353A91DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 02:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330A1F60A;
	Sat, 18 Jan 2025 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEcoktss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0E42077;
	Sat, 18 Jan 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737167722; cv=none; b=oIX6erxLqcPBxjpLxyLgPNnF5hNvIPKF5TxBOQgVvR4EehAaluQvid6YhPPILQQgixJurtGCTISQcNctTIRga46G7iDGiQXWnxIA3IV4uKEIogUQsB8xuVdX+j0lUz5zawjDtby1fnxbKP0Rc39jmsjQchK71FrSzheoj1xgf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737167722; c=relaxed/simple;
	bh=X3m9dS/6uYE0ZFgeI29Imle31bC+EF49CBQpNsA5NQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adwRMXKqn0cZBlDLZSjmsG0m/YG8teIQ/d3KuJqdXl8J3NwEIY62IG5PM6238tiF2UZmXTWu6GnWmVR/pYWGrNS39mdhp4SPcN4IXtJ1mSUYvKtjDI3TWfm5hZIR/Fx4ZljcVwtgPqzOH9qBxNYGhA/sJycVl2wD80X0dkhuTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEcoktss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B01C4CEDD;
	Sat, 18 Jan 2025 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737167721;
	bh=X3m9dS/6uYE0ZFgeI29Imle31bC+EF49CBQpNsA5NQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZEcoktssYSQY7O5sJjcTh0ibS3P3LHiLQYXP0tR8GFtV/jrXV1gj9OYrL1tIKRPJG
	 0zA+NOIPxDvC6h69uFZWKm/zLQ8Pquol3PkWiawWerSgzlGYZ9yk6cBNWEk3Rfwk/L
	 VGVLgo3Bk3TLUowKtbS0kHSamprQHTUIdPgbF4zTueifrUgCs1VoFZ8gD3R82S6ZVG
	 Y1Z3gv41nOXYQMcudU44+H+bjcM6CIfsOjeZxZSmaSra/5DXzndh/yl35owmAQy5UK
	 0oIQbMCQgzhfvxiJ3BhYwd1esOFScCkNVIKXiA+OZuUKGEYG/3PBYCdbw/wm1MMriZ
	 EVLYBzay+PSHg==
Date: Fri, 17 Jan 2025 18:35:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, max@kutsevol.com,
 thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Message-ID: <20250117183520.11d93f4d@kernel.org>
In-Reply-To: <20250117-terrestrial-clam-of-satiation-cf312f@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
	<20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
	<20250116174405.20a0e20b@kernel.org>
	<20250117-terrestrial-clam-of-satiation-cf312f@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 03:02:40 -0800 Breno Leitao wrote:
> > Looks like previously all the data was on the stack, now we have a mix.  
> 
> Not sure I followed. The data ({userdata,extradata}_complete) was always
> inside nt field, which belongs to target_list.

I mean the buffer we use for formatting. Today it's this:

	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
	int header_len, msgbody_len;
	const char *msgbody;

right? I missed that "static" actually so it's not on the stack, 
it's in the .bss section.

> > Maybe we can pack all the bits of state into a struct for easier
> > passing around, but still put it on the stack?  
> 
> It depends on what state you need here. We can certainly pass runtime
> (aka sysdata in this patchset) data in the stack, but doing the same for
> userdata would require extra computation in runtime. In other words, the
> userdata_complete and length are calculated at configfs update time
> today, and only read during runtime, and there is no connection between
> configfs and runtime (write_ext_msg()) except through the stack.
> 
> 
> On the other side, if we want to have extradata_complete in the stack, I
> still think that userdata will need to be in the stack, and create a
> buffer in runtime's frame and copy userdata + sysdata at run time, doing
> an extra copy. 
> 
> Trying to put this in code, this is what I thought:
> 
> 	/* Copy to the stack (buf) the userdata string + sysdata */
> 	static void append_runtime_sysdata(struct netconsole_target *nt, char *buf) {
> 		if (!(nt->sysdata_fields & CPU_NR))
> 			return;
> 
> 		return scnprintf(buf,  MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS,
> 				  "%s cpu=%u\n", nt->userdata_complete, raw_smp_processor_id());
> 	}
> 
> 	/* Move complete string in the stack and send from there */
> 	static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
> 				     int msg_len) {
> 		...
> 	#ifdef CONFIG_NETCONSOLE_DYNAMIC
> 		struct char buf[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
> 		extradata_len = append_runtime_sysdata(nt, buf);
> 	#endif
> 
> 		send_msg_{no}_fragmentation(nt, msg, buf, extradata_len, release_len)
> 		...
> 	}

My thinking was to handle it like the release.
Print it at the send_msg_no_fragmentation() stage directly 
into the static buffer. Does that get hairy coding-wise?

