Return-Path: <linux-kselftest+bounces-24713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F0A14E1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E7F7A12FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA71A1FCCF5;
	Fri, 17 Jan 2025 11:02:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014501F7577;
	Fri, 17 Jan 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111767; cv=none; b=ZsWlqaKVHD4J4vhAXCnfEFVrFIsdTecZqiGBgS7oTapWrNSB1S9FrmQtADyBXtRYth7HaG1S/SscMYyk6wML1Q1bSz0bnGkzmlCwff5Z1ay/Lb6nmbXFn1P+BRLm4I/i5UD5s0ImiFZJQXRbQ+1ue3If8lsU+IGZc9ChXt9qWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111767; c=relaxed/simple;
	bh=c6+L2Rwk15a+td57DbDbPDyEYtK7MOGgveqVh/MJXnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdrATZ/G2U+wa24GmvtfvTsqmYMzmPujTnHe+ccSvYVBeF2WfYsIPzm1ZRdCFFMqfAHu2iAk2TSJfV0wLbt0SUZV0gCtDbDL+mf4DXhv448cgR2efGajtaUesNX7c9UGuvFMWjM6/o0Uw9F5mltg/a1NBagkJ1FYK1RBk7VpL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso370976366b.2;
        Fri, 17 Jan 2025 03:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737111764; x=1737716564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51F+1maMrhx6mhtRzm797H0J9chmoIpuqA0W0BWbLr4=;
        b=MFsqucvbJlmTdMfHqw1g0WNdkMAxIzRI0YB5Swn+g5e6cJx8qFyecqzQUmeSdddc4f
         R04rZTq3OO+H5Sqw+Fvg1QeNR3AgjOgtzaErjQfkOTqsekWyFJHFozDp/vpZ7G71xSgP
         jLU6AJwU5WbnfiyWcwgj5OcSbMkare5Lnbo9y5EJ1RD72Dyws9owfw0TU3fqB0+rWkxo
         +vaN25S2LXh4NZFvu8gWwlPumHR+rk3Kob6rj4IcxzSG9rLlKGEOjuR0mMKxOCBUheV8
         LVKa+O1DBBT8eeyBL8g5Uz64qyE8YucJPKefpdKd7IhkKV8IfmWXKlneiF0jtuq3UQLk
         AAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6M3H89GnuDojE1Vye0065R0Virwa3ld1U96236M6UsYW2yf6AhYibO1OdoDz77Ji51SaRpoPnXgnqBmdLsZln@vger.kernel.org, AJvYcCUDPvsPkAbjO6kqwdLIgtVUm4SG5hzAua3pN3xYboHcRhvnnJkxsrd2fCStO6xMYCId+pIgrlrV@vger.kernel.org, AJvYcCUPSgYjZDtDBbxyiLSnwSKAjtQPKMINm0v2mlIU/3Ulk/tHV8yV3OCXNNfP/J+xDLS+gUYtusNZRerehAyY@vger.kernel.org, AJvYcCVh+VkaRLAUcgocpYhAkInpNmEexSfyjIVlaE0gdnqbjnxf0VflO5gXHm6GODAv6Wypxsmqb7gsIOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDJbrqAa1lurueVOOOw4qL6LWDJuocndoLQHYE8t/mmzZEJvm
	KB1/3bdtu5Vxdr2KiBSXu9PeksIxEYy/YQLYrViA4xS0dByOBmax
X-Gm-Gg: ASbGncuR1q40+vc0HF3Q98xDrdLQO/0dKaUWMMVvwDqStr072YY+Dsulp34R2lKAsx/
	3lmwulZ8E/RU4wlx8mj86tmjGrfVA7qMZtQJDUOQ2iSI7qwr89HqcJP76mdBYoze1ZmqYlyVPBS
	LXZTfta6VItBw//m7NstROL9lYSjTyxcPJ4QxI5lcRycrsPPzgPsD5ZGXLzYlZT2bUkJWif/DLx
	AnahMLoa+X/bAWmhJKz/hQHaIzvCcdoIwimYhAGy7dt
X-Google-Smtp-Source: AGHT+IFXztlqwpxselOI2ZQ7Ho9PNO4LfSy55N0oANn3eeF3xkUbwMKcDOAOzemkTvuOwwwpwT0jiw==
X-Received: by 2002:a17:906:2594:b0:aaf:f1a:d2ad with SMTP id a640c23a62f3a-ab38b4c6af1mr186073966b.50.1737111764022;
        Fri, 17 Jan 2025 03:02:44 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f1e57bsm152313966b.104.2025.01.17.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:02:43 -0800 (PST)
Date: Fri, 17 Jan 2025 03:02:40 -0800
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
Message-ID: <20250117-terrestrial-clam-of-satiation-cf312f@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
 <20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
 <20250116174405.20a0e20b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116174405.20a0e20b@kernel.org>

Hello Jakub,


On Thu, Jan 16, 2025 at 05:44:05PM -0800, Jakub Kicinski wrote:
> On Wed, 15 Jan 2025 05:35:20 -0800 Breno Leitao wrote:
> > +	WARN_ON_ONCE(userdata_len + sysdata_len >
> > +		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
> > +
> > +	/* nt->sysdata_length will be used later to decide if the message
> > +	 * needs to be fragmented.
> > +	 * userdata_len cannot be used for it, once next sysdata append should
> > +	 * start from the same userdata_len location, and only overwrite old
> > +	 * sysdata.
> > +	 */
> > +	nt->sysdata_length = sysdata_len;
> 
> Updating nt-> fields at runtime is something we haven't done before,
> right?

Correct. nt-> fields were only updated by configfs helpers.

> What's the locking? We depend on target_list_lock ?

Correct. "Runtime updates" (aka nt->sysdata_length) always occur within
the target_list_lock().

At the same time, userdata updates (aka nt->userdata_length) happen
inside dynamic_netconsole_mutex().

The weirdness here is that:

	1) Writers of nt->sysdata_length hold dynamic_netconsole_mutex()

	2) Readers of nt->sysdata_length hold target_list_lock()

	3) There is no dependency between target_list_lock() and
	dynamic_netconsole_mutex()

	4) Creating a dependency on target_list_lock() in configfs could lead to
	potential DoS attacks by userspace holding target_list_lock() for
	extended periods, starving netconsole.

	5) A possible solution might involve using read-write or RCU locks.


> Looks like previously all the data was on the stack, now we have a mix.

Not sure I followed. The data ({userdata,extradata}_complete) was always
inside nt field, which belongs to target_list.

{userdata,extradata}_complete was always in the stack. It is allocated
in the following way:


	struct netconsole_target {
		...
		char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
	}

	static struct netconsole_target *alloc_and_init(void) {
		struct netconsole_target *nt;
		nt = kzalloc(sizeof(*nt), GFP_KERNEL);
		...
		return nt
	}

	static struct netconsole_target *alloc_param_target(char *target_config,
							    int cmdline_count) {
		nt = alloc_and_init();
		....
		return nt;
	}

	static int __init init_netconsole(void) {
		nt = alloc_param_target(target_config, count);
		...
		list_add(&nt->list, &target_list);
	}

> Maybe we can pack all the bits of state into a struct for easier
> passing around, but still put it on the stack?

It depends on what state you need here. We can certainly pass runtime
(aka sysdata in this patchset) data in the stack, but doing the same for
userdata would require extra computation in runtime. In other words, the
userdata_complete and length are calculated at configfs update time
today, and only read during runtime, and there is no connection between
configfs and runtime (write_ext_msg()) except through the stack.


On the other side, if we want to have extradata_complete in the stack, I
still think that userdata will need to be in the stack, and create a
buffer in runtime's frame and copy userdata + sysdata at run time, doing
an extra copy. 

Trying to put this in code, this is what I thought:

	/* Copy to the stack (buf) the userdata string + sysdata */
	static void append_runtime_sysdata(struct netconsole_target *nt, char *buf) {
		if (!(nt->sysdata_fields & CPU_NR))
			return;

		return scnprintf(buf,  MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS,
				  "%s cpu=%u\n", nt->userdata_complete, raw_smp_processor_id());
	}

	/* Move complete string in the stack and send from there */
	static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
				     int msg_len) {
		...
	#ifdef CONFIG_NETCONSOLE_DYNAMIC
		struct char buf[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
		extradata_len = append_runtime_sysdata(nt, buf);
	#endif

		send_msg_{no}_fragmentation(nt, msg, buf, extradata_len, release_len)
		...
	}


Thank for the review and the help with the design,
--breno

