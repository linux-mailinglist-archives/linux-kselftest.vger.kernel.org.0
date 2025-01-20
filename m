Return-Path: <linux-kselftest+bounces-24802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCAFA171F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C391885925
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D491547E7;
	Mon, 20 Jan 2025 17:30:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281213AA5D;
	Mon, 20 Jan 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394255; cv=none; b=m3zlEzzHUMMIf1pjdyQ8pPwjzHIPiQie1mmh7O1Lc7sAD0Knfcc82yJ0ylVmayGRaInlxXzCpj27sDr7PLDbuUXFFjIQBubvu2X5bRpbkCqeYWt7fQ4V8azWJh32SQ3JOiElyRhfDPm0dizxWzCeT2MS4iOJNGA3ntYgDSxQJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394255; c=relaxed/simple;
	bh=co4rh7mcehuLyfpxVs2kCx5deaYX52yDp0kZrDc/z8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJV9cA1BHEerbKeqZF272KuyAsbR0NvfhfFGDD+Z/KL55Dg0idWg2huL+cXt7VoB/OPDgEf3KFBRLZvSB72w0jaPa8m0YrdfevyztDa92cjQeSncdg3FPPqC/q/uvlJNWnVr3QsOkoyMsEPKqpf365KNzuLt/nC4K/KVK2M8ZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaef00ab172so731937366b.3;
        Mon, 20 Jan 2025 09:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394251; x=1737999051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjKwZAMnGwVfQ1uehkUpRVLkmdlR6xAZAUrURRogCUo=;
        b=UA+tJNjEI011ydMho2eKpEGke/lnr9t3W4TkJU3JA88y+I8q4Qmp/2+8VfS+de5fZp
         7qMFxon3YJ326lkjkBN0B++jXnwoi1VCKFgrr39w8NLavSxwW5GcNbMirINhVJQCzM6V
         dUxCJ15KzJcSFbCwvla+TurQxfr055lzMX99QVdiGa7RKp16sJ6Ei1faz6lfDvb3VflU
         /Wlg/NmHNfusMInhjAFbGJIIqqPjFQriTSxYNWNSPCezTAJa+H8R9sxg56oObko596w3
         mFiSY2NVvyLU3UaPXVBLQJiYCE9idDIrg67ymp2rYeDsLO85S1kd3dofkaQ8tlK6n9l4
         rnTg==
X-Forwarded-Encrypted: i=1; AJvYcCV76LXJiQo9e94fk3FYMR54nkMiHghvzPGX0f2m5AdnTorBsiua2Rs+q7BxNQQ3hbIgLRuasfgo@vger.kernel.org, AJvYcCWHjn9VoDZEkYI5SC4x1HnQbl20dAT2wO5kOsf1cMD4I7SX7DTQOM822X10N6geaab8IiFIEmrIvIKgfzb/@vger.kernel.org, AJvYcCWXZ3CGBESslPQcLXu7DHZsVXrJMzJzv47Rs0YH/ekufSj8CqSHwPy09ob2fMehDGKBAjjtDTiAu9U=@vger.kernel.org, AJvYcCXdq+aVjP53tYybWRdbdWb5HW+7C9RM+zc/8QZkmNZ8twsPpxiAYyERkGLrytsFqmaAPPjfKjQNhC3YNYmmL9+d@vger.kernel.org
X-Gm-Message-State: AOJu0YygsUuKzmLiyeuDntvjhtQ7cMUo7SK/kTF9S/jFaJp1tn9WmQ5m
	fRrllNzFRD0kY8oDhbfQ8ZqN1H0uBW8AfM0TNWPbSrQiKUU9diQZ
X-Gm-Gg: ASbGnctc+7zxUyYsuxCAEZJsLHBLbzNXiblKrZHlQx5/sY7aR7tHWG2R4otVWXrzVvP
	NkwzoWhzhmEyu+k9dwP3waHI9R9K1xPzCJ2HhmS++vKj1h6mLzLF2EDAmkNzckysdhJTshJMwm0
	Kii7nLgsjoukA/T/M+apfmkbtfNS/EenlGssH2QtymZjsywOaz1UnRudWsEK3Azp3XBT/5n6qDP
	UYa0ZjHBCdWJglp4YCU9yTu44/CfGFx8lHD8uQhBrJQW5T89Q4cv8YHvJV3
X-Google-Smtp-Source: AGHT+IHHBMwM1y47uiYGiCZ5wJnCsj0WmgnVWFyMm4lJpp3CtPhJHPHE4Y68jLBM9H+zTGUpmqtIfQ==
X-Received: by 2002:a05:6402:50d4:b0:5d0:cfad:f71 with SMTP id 4fb4d7f45d1cf-5db7db2bea3mr32816210a12.32.1737394251064;
        Mon, 20 Jan 2025 09:30:51 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fcd73dsm646619066b.178.2025.01.20.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:30:50 -0800 (PST)
Date: Mon, 20 Jan 2025 09:30:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	max@kutsevol.com, thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Message-ID: <20250120-rational-bullfrog-of-tornado-2cd6f4@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
 <20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
 <20250116174405.20a0e20b@kernel.org>
 <20250117-terrestrial-clam-of-satiation-cf312f@leitao>
 <20250117183520.11d93f4d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117183520.11d93f4d@kernel.org>

On Fri, Jan 17, 2025 at 06:35:20PM -0800, Jakub Kicinski wrote:
> On Fri, 17 Jan 2025 03:02:40 -0800 Breno Leitao wrote:
> > > Looks like previously all the data was on the stack, now we have a mix.  
> > 
> > Not sure I followed. The data ({userdata,extradata}_complete) was always
> > inside nt field, which belongs to target_list.
> 
> I mean the buffer we use for formatting. Today it's this:
> 
> 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
> 	int header_len, msgbody_len;
> 	const char *msgbody;
> 
> right? I missed that "static" actually so it's not on the stack, 
> it's in the .bss section.

Since you raised this topic, I don't think buf needs to be static
for a functional perspective, since `buf` is completely overwritten
every time send_msg functions are called.

> > > Maybe we can pack all the bits of state into a struct for easier
> > > passing around, but still put it on the stack?  
> > 
> > It depends on what state you need here. We can certainly pass runtime
> > (aka sysdata in this patchset) data in the stack, but doing the same for
> > userdata would require extra computation in runtime. In other words, the
> > userdata_complete and length are calculated at configfs update time
> > today, and only read during runtime, and there is no connection between
> > configfs and runtime (write_ext_msg()) except through the stack.
> > 
> > 
> > On the other side, if we want to have extradata_complete in the stack, I
> > still think that userdata will need to be in the stack, and create a
> > buffer in runtime's frame and copy userdata + sysdata at run time, doing
> > an extra copy. 
> > 
> > Trying to put this in code, this is what I thought:
> > 
> > 	/* Copy to the stack (buf) the userdata string + sysdata */
> > 	static void append_runtime_sysdata(struct netconsole_target *nt, char *buf) {
> > 		if (!(nt->sysdata_fields & CPU_NR))
> > 			return;
> > 
> > 		return scnprintf(buf,  MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS,
> > 				  "%s cpu=%u\n", nt->userdata_complete, raw_smp_processor_id());
> > 	}
> > 
> > 	/* Move complete string in the stack and send from there */
> > 	static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
> > 				     int msg_len) {
> > 		...
> > 	#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > 		struct char buf[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
> > 		extradata_len = append_runtime_sysdata(nt, buf);
> > 	#endif
> > 
> > 		send_msg_{no}_fragmentation(nt, msg, buf, extradata_len, release_len)
> > 		...
> > 	}
> 
> My thinking was to handle it like the release.
> Print it at the send_msg_no_fragmentation() stage directly 
> into the static buffer. Does that get hairy coding-wise?

I suppose the advantage of doing this approach is to reduce a
memcpy/strcpy, right?

If this is what your motivation, I think we cannot remove it from the
fragmented case. Let me share my thought process:

1) sysdata needs to be appended to both send_msg_fragmented() and
send_msg_no_fragmentation(). The fragmented case is the problem.

2) It is trivially done in send_msg_fragmented() case.

3) For the send_msg_no_fragmentation() case, there is no trivial way to
get it done without using a secondary buffer and then memcpy to `buf`.

Let's suppose sysdata has "cpu=42", and original `buf` has only 5 available
chars, thus it needs to have 2 msgs to accommodate the full message.

Then the it needs to track that `cpu=4` will be sent in a msg and create
another message with the missing `2`.

The only way to do it properly is having a extra buffer where we
have `cpu=42` and copy 5 bytes from there, and then copy the last one in
the next iteration. I am not sure we can do it in one shot.

On top of that, I am planning to increase other features in sysdata
(such as current task name, modules and even consolidate the release as
sysdata), which has two implications:

1) Average messages size will become bigger. Thus, memcpy will be needed
one way or another.

2) Unless we can come up with a smart solution, this solution will be
harder to reason about.

If you want to invest more time in this direction, I am more than happy
to create a PoC, so we can discuss more concretely. 

Thanks,
--breno

