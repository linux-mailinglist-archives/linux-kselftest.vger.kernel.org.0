Return-Path: <linux-kselftest+bounces-46863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39676C99A81
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 01:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D73473457C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076E13C3F2;
	Tue,  2 Dec 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q25IqU2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DD22097;
	Tue,  2 Dec 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635784; cv=none; b=pvwxzjlVnRlDMd0XBI9luypJnFbfkW5lRLb5iH85b1x9eT+XRGhRvy9WwK3faed/N4d+cAXx7k/I/ATilQSwkwpSGziexUOZbtBUgCF0qhpBMDn2tWMTBDvojYB9bg3KrUYQ8eOs0fHu9tCEZcgqzCJIMXI4HBa87Sy54EfFFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635784; c=relaxed/simple;
	bh=rNqSKIEZABAD5RykiDYsun+nHDAK0efshJ2S5T5lf1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7q6KWF5K0vDSRh+yIxHCd4gkzVRm18aRuCNSVHCCXxOiqQpQAqQ+H9J7tdSRn6worK1w2+wC4Re7uHN5XFmL6kqeVo8jeJxirflREs1mLNOfHq5XkHrjAqDp8O/XP/KtZVoan7m6lSiV8xzxVMyuZwBBC7kdhwfKpYy1mwlFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q25IqU2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A4C116C6;
	Tue,  2 Dec 2025 00:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764635784;
	bh=rNqSKIEZABAD5RykiDYsun+nHDAK0efshJ2S5T5lf1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q25IqU2kwF1u+ntUzsmQ79EXXO6KQvcCgtyqX2BiNMFbpMORcMvwBRUN45jSmM5T0
	 7UIjWINuTpUond5Mfe58Fo714YxvBrcPcsSVN6RyMrzYl4gbYg7gZgXA+oh3fM36JG
	 GGojawkFetKeSnb1c3M3p10S6WTiElkRco582NTRvnyP8DuQ4gKaX022XIsYwT1vCg
	 zzf4nffOERMuZnuhiayvn3dfDGpZcr+kPF2DJjQWFBJQm2X2KsFwHaEFDLkbTqY75R
	 u5krqRsacwmnpbGjlNIBY4ysMszUohssA3x7whUYsTRZjMY0AnJ1EQ3j1i0lmoL2Fe
	 jPpslayzGfQwQ==
Date: Mon, 1 Dec 2025 16:36:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <20251201163622.4e50bf53@kernel.org>
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 06:20:45 -0800 Breno Leitao wrote:
> This patch series introduces a new configfs attribute that enables sending
> messages directly through netconsole without going through the kernel's logging
> infrastructure.
> 
> This feature allows users to send custom messages, alerts, or status updates
> directly to netconsole receivers by writing to
> /sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
> buffers, and sending msgs to the serial, which could be slow.
> 
> At Meta this is currently used in two cases right now (through printk by
> now):
> 
>   a) When a new workload enters or leave the machine.
>   b) From time to time, as a "ping" to make sure the netconsole/machine
>   is alive.
> 
> The implementation reuses the existing message transmission functions
> (send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
> message formats.
> 
> Regarding code organization, this version uses forward declarations for
> send_msg_udp() and send_ext_msg_udp() functions rather than relocating them
> within the file. While forward declarations do add a small amount of
> redundancy, they avoid the larger churn that would result from moving entire
> function definitions.

The two questions we need to address here are :
 - why is the message important in the off-host message stream but not
   important in local dmesg stream. You mention "serial, which could be
   slow" - we need more details here.
 - why do we need the kernel API, netcons is just a UDP message, which
   is easy enough to send from user space. A little bit more detail
   about the advantages would be good to have.
The 2nd point is trivial, the first one is what really gives me pause.
Why do we not care about the logs on host? If the serial is very slow
presumably it impacts a lot of things, certainly boot speed, so...
perhaps it should be configured to only log messages at a high level?

