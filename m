Return-Path: <linux-kselftest+bounces-6773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAE890A8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2DCB2365F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCCC1386A3;
	Thu, 28 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDLQvDAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C813A41A;
	Thu, 28 Mar 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656134; cv=none; b=VPOSgAWbAtLKXvfcq7MX/HMn2YeUg6DDPlBWmysC6QeVU+uggUW2m0pGIQfZxojFhIT5saVW/FJi6QOhvQ+KNVllfeyiVKzDd3geIvdCC6Fn716jL/WPDRTVogJnuDYwYv6GKq6pssdpQ/ugIkq6hJhUawEZwHDJ8fRPbWC6cmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656134; c=relaxed/simple;
	bh=Z7vcjNq9iuDxV3o65whbRSs5plrB2OCKjhzQZCsPSbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMyU9ISjTT1AmSt06kfVMRwxUeYvcH6Ku9K0h+htsNz0s76ddVq6ldC2cd1lkERPFhyWeNPwPvUi2g3Oyrzg82iSymgmO+Ej8dP2ffrC2m3vETts7b6kxUfGrtZOoRSL2ZU9dko92i3YdcvnAvH6NTYdXR5PlzpDUI5w7/M74L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDLQvDAT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so436850b3a.2;
        Thu, 28 Mar 2024 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656132; x=1712260932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exQ2zy2WHkjHmygTSs/OFLcB/44Kfp63nWW6TTuS9co=;
        b=JDLQvDATelqKwgvM919l1qpGY5jD68CEsZD2Oj7HPTFx1TYhuLPv7YjOLekxJQF1/o
         GGfxmAdVxvj2cOdTuyg3akcNfonF3bBZ6fydV9+wipVYqqPXxqdC1oyftqkOuUcPNOxg
         LphaY/Jp+SBSHNqoREf3vFtHmDgrJi/mZPyEfcD256UBoYa2ZmN+waeAH+gHBqZhRUDr
         poWnByGkV0UR3J4tEx+cZCtCGufFmvl7QtyIx4U2Xpf6h6L57fiT3atpmBvhCJ7pGoo8
         6DcGHh8dqqWKuuwd8dDlxkNhbZE4Z+lnZpnwNRJs8q02oaufw9///Xp6mm0LuRAq/I+n
         jc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656132; x=1712260932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exQ2zy2WHkjHmygTSs/OFLcB/44Kfp63nWW6TTuS9co=;
        b=nmILSvvEgpmg0x88uj+Ikuvpffnp6oEAtUABkOi5ZTiX33bU23Vur9GX77nqM17MHT
         jyPL996ME2pn0IauddA0ynC5zZHgVO17pAqb+HQRZjn2VzZuDtBhHWaRABNH0iYikt7a
         qoozqvqXxyEzOk+c0z9L0wsoDq7so00I6JESZ0BU8y/PchlygP6Co8MwOBFk7+z0m80T
         +9taoRZgQWA6Spr5WswKJgsKBd/nhE2tnbeH5hU9IGyfJD6qR+SvsKTppFPRtsuG4sJm
         ZwhRxAhU2mjPPybA746XYGcUawfjW+AZQjz51KSgZtTKS+XIa6QD5ohyHhfE20r3BuRO
         0MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbVOUrCA+bVvhJqKqkImq1mImOS4+Gqj+seURchDPzsy1UHAzLrJ6azVd1rkTiblsMnPMq4dZ25xD9TywQUKBJKPIMZpLgC1iDHJ9urOS9bNvxbI0PGATii3ZYFLSXghtr6DwslXuyclY6K67Qxb5FdHzmXX1qd7gYW/bKkxmc94wNJJrPFzP9au3u5pl673XqG+ULUzp95wqGDQ==
X-Gm-Message-State: AOJu0YwSBNLtKXmmIMLCmHkcEPDaOMMGXAI5s3Vg/A2ysgEbjMh4jIrv
	bGgq5FoQZpd8ivz5TUF8XVzciEXG2iAVS10Tjez4Jf2T+TY6lY6d
X-Google-Smtp-Source: AGHT+IFACNiaq+1NYDRgLNEhercMPfzINXB3PvhMHD2tixWVt5eUtCDZPiJ0ztdRKKdkNFaCLHZpVQ==
X-Received: by 2002:a17:903:1c8:b0:1e0:b60e:2cd9 with SMTP id e8-20020a17090301c800b001e0b60e2cd9mr602011plh.30.1711656132474;
        Thu, 28 Mar 2024 13:02:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b001e042dc5202sm2026332plf.80.2024.03.28.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:02:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 10:02:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>

Hello,

On Thu, Mar 28, 2024 at 12:46:03PM -0700, Alexei Starovoitov wrote:
> To use kernel_file_open() it would need path, inode, cred.

Yeah, it's more involved and potentially more controversial. That said, just
to push the argument a bit further, at least for path, it'd be nice to have
a helper anyway which can return cgroup path. I don't know whether we'd need
direct inode access. For cred, just share some root cred?

> None of that is available now.
> Allocating all these structures just to wrap a cgroup pointer
> feels like overkill.
> Of course, it would solve the need to introduce other
> cgroup apis that are already available via text based cgroupfs
> read/write. So there are pros and cons in both approaches.
> Maybe the 3rd option would be to expose:
> cgroup_lock() as a special blend of acquire plus lock.

Oh, let's not expose that. That has been a source of problem for some use
cases and we may have to change how cgroups are locked.

> Then there will be no need for bpf_task_freeze_cgroup() with task
> argument. Instead cgroup_freeze() will be such kfunc that
> takes cgroup argument and the verifier will check that
> cgroup was acquired/locked.
> Sort-of what we check to access bpf_rb_root.

There's also cgroup.kill which would be useful for similar use cases. We can
add interface for both but idk. Let's say we have something like the
following (pardon the bad naming):

  bpf_cgroup_knob_write(struct cgroup *cgrp, char *filename, char *buf)

Would that work? I'm not necessarily in love with the idea or against adding
separate helpers but the duplication still bothers me a bit.

Thanks.

-- 
tejun

