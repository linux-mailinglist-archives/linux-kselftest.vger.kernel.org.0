Return-Path: <linux-kselftest+bounces-41861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBBB85AA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA1188BC6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB134312814;
	Thu, 18 Sep 2025 15:31:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159730CDAC;
	Thu, 18 Sep 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209496; cv=none; b=nKmkHqjKuH01FUco/sO2z9cjEbwz59cfdOZN1hYCKgkA+VC57tP7DeLexnGpvEoaPgJPinGELTvsPCXcH9VpWheZfOy78A2bdfsEs+gWebTDU5o4GDLdD6k0YDkyCbDa4PaXsqx93f4ap2Ijv0ZRQ4e/mUeXPBsi2HF2FVoTxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209496; c=relaxed/simple;
	bh=QZCy1OJjqBJh0gFIG7MWM+0jYLNNxOxd2PqQq5mo5Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnMScQxMII1i3+DAU1yEd0Zax+66YwGRoljzWM49Yw37sDMZD1aOBYX4T9O7hL4C+0LBhLJZ8dU2VETwrYz/+Fbp+TY9xR2Oj5N+jClZZsIMR+KW4i/vRKjXdCubPJmgHnMFzSAAM7r2wbA26ZOskSgjArNBzf0RBG60op8DMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 90BC213A0CD;
	Thu, 18 Sep 2025 15:31:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 26ACE20016;
	Thu, 18 Sep 2025 15:31:26 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:32:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, yonghong.song@linux.dev, haoluo@google.com,
 eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 willemb@google.com, kerneljasonxing@gmail.com, paul.chaignon@gmail.com,
 chen.dylane@linux.dev, memxor@gmail.com, martin.kelly@crowdstrike.com,
 ameryhung@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <20250918113234.3f9e556a@gandalf.local.home>
In-Reply-To: <9cb5b3d5-97bb-4165-9a84-394d3d45a20e@vivo.com>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
	<CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
	<b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>
	<aMvHE-iW5eAwf4km@krava>
	<9cb5b3d5-97bb-4165-9a84-394d3d45a20e@vivo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xexywcpfgjs6zafak66u594a4iimzte3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 26ACE20016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5VKD1WZaH+qlJjD8FFIkR8XM8YVm/Fvc=
X-HE-Tag: 1758209485-346587
X-HE-Meta: U2FsdGVkX1/j1e4fDuVmFwYkOTLvvV2NOP6rFhn6Fkk6YvTNGBQsKDcC8yTW9CMKh9nnzfqWO430S3SN+A1gNHnPGJbdafl1IgHkggXCdvGXv3cV4YAjThA8kjwC/6+Ta1tMmod474GzfgIzXP2sGMDt4FTW704Q1mC7O6aRUK2aOt0h9KPmkcWRcOghUTCdRyhfAndY2VCWXPVZ5GvCtSubejUa1vn64VQ2rb+BHZXYqoLTJ7QLwzJdssI8sEbZpBmk9X92AzVZK8w/nOoNGIZy9XxvXLkd4i2r2qlcUbpZKsOUkpqsxz1YsvF0CdyPc/7DSIVfOImbMgwZUwVtBXaS3KBmlrnP

On Thu, 18 Sep 2025 21:15:57 +0800
Fuyu Zhao <zhaofuyu@vivo.com> wrote:

> As for the reason not to unregister and register a new callback:
> callbacks registered directly inside the kernel cannot be unregistered from
> user space. From user space, we can only attach additional callbacks
> with BPF programs, but can not remove or replace the ones already
> registered in the kernel. Therefore, an override mechanism is needed.

The fact that user space cannot unregister or override the current
callbacks, to me is a feature and not a bug.

-- Steve

