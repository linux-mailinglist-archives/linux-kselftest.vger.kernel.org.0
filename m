Return-Path: <linux-kselftest+bounces-41756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E82B81A21
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F54188C3F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DBC306D5F;
	Wed, 17 Sep 2025 19:30:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11432F83B8;
	Wed, 17 Sep 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137405; cv=none; b=c9rq5t6oLxVSY7JSlR18gs5BZuZPekxJeOfOl9iFWsG8HU/q57/ZAH0Ty3jnidvyiiULml1USwzBQV/6AcMpMLMcWkgbzqIrwp0S0VnJSz0Q1J4MQOLj30EVdnTs5u5PkWgmn9ji3qNKeCp3+nPWaMr2DtLhE7dz0zK4MWAZEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137405; c=relaxed/simple;
	bh=ZnMRKLn0qyUGROjH/cSGBvjzMuSNHc9RHc0rwxb6dFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxY0TItu0cQ8KlnJsfKrTAkC49XAM2QlwkBgG/DNVjmod7Ea9qyS/LCRl//74VVhWl/DFQ4i33vHZ7ut4ov1xyJibLdUtrOhhbXrF/JRhMuMW2HRT0qEwyd5Vatpc2y04EHZfC068UiKZUiTQcIPwSyZ4caOW+1OPkyGsDV2cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7A5371DF3D5;
	Wed, 17 Sep 2025 19:29:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 2316430;
	Wed, 17 Sep 2025 19:29:49 +0000 (UTC)
Date: Wed, 17 Sep 2025 15:30:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 haoluo@google.com, jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <20250917153055.6fee814f@gandalf.local.home>
In-Reply-To: <20250917072242.674528-1-zhaofuyu@vivo.com>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2316430
X-Stat-Signature: j94jtr56jpxuhefubu3apgodg8t3ptxb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RZLjwHcDXxmzAeVwGwIyEjGeUYjMsKY8=
X-HE-Tag: 1758137389-399912
X-HE-Meta: U2FsdGVkX18tGG5q2NUrL+YhIfzBLvn4G+9YbPhTQObhs83gjknkX3Ot3igWVxiVfemS6aF/Ot/6ACKrBVUGoLjjBFKZB3ojVCLifTdP8lEzl2ri3wo8XV0nLuDW7XhHmO2++q3hyT1axdSYO/pteHZAb7MKuqt16EO1MLxhlEVCV7SEJxpI6Sxxd9d/U+++AEokxAEAjNfEtKrTNFXEkATDN81n7jJvNMLvSNeRWJCqvQallPUZ5GiwzzY5LgCjWwOU6UGMdXBtS2dqHJ1PJaHwGDc/hDeh+zGKAdLGefuDTvvXFWGHxggfNj+MCbbz9Uek/VxvC/4O/+0M5sXPblUoMklB1YCq

On Wed, 17 Sep 2025 15:22:39 +0800
Fuyu Zhao <zhaofuyu@vivo.com> wrote:

> Hi everyone,
> 
> This patchset introduces a new BPF program type that allows overriding
> a tracepoint probe function registered via register_trace_*.
> 
> Motivation
> ----------
> Tracepoint probe functions registered via register_trace_* in the kernel
> cannot be dynamically modified, changing a probe function requires recompiling
> the kernel and rebooting. Nor can BPF programs change an existing
> probe function.

I'm confused by what you mean by "tracepoint probe function"?

You mean the function callback that gets called via the "register_trace_*()"?

> 
> Overiding tracepoint supports a way to apply patches into kernel quickly
> (such as applying security ones), through predefined static tracepoints,
> without waiting for upstream integration.

This sounds way out of scope for tracepoints. Please provide a solid
example for this.

> 
> This patchset demonstrates the way to override probe functions by BPF program.
> 
> Overview
> --------
> This patchset adds BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE program type.
> When this type of BPF program attaches, it overrides the target tracepoint
> probe function.
> 
> And it also extends a new struct type "tracepoint_func_snapshot", which extends
> the tracepoint structure. It is used to record the original probe function
> registered by kernel after BPF program being attached and restore from it
> after detachment. 

The tracepoint structure exists for every tracepoint in the kernel. By
adding a pointer to it, you just increased the size of the tracepoint. I'm
already complaining that each tracepoint causes around 5K of memory
overhead, and I'd like to make it smaller.

-- Steve


