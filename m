Return-Path: <linux-kselftest+bounces-5367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFF861CC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289661C23C76
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED21448F3;
	Fri, 23 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJkGTk8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1F46AB;
	Fri, 23 Feb 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717504; cv=none; b=L11Iudbvpi7j3TdSarzeVw2IEP+5vBldjkGtV9S+JLBFglSNwNkUegByPcrQb2E9b60lksOLyoScxxRQVV9bNa/Zco+1Imo00q0j97aEr+hKpUwwzPXFFoUpx2rbVIH7d9E41txiCSFfQ7p+Nlu+WBVqdHXR2wnZNcbX47F9d1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717504; c=relaxed/simple;
	bh=61ZPwyu9SRxE8LspTKZJRDCV3i5FHGC9oOaA/Lh95VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEQvh3snkwiWAGpn8GSKjQHxmQOHxS772jQ3PkfvN1zBiDUTviCG8bQJ06GRXMBLhz46+k5sdbwlkMpSoKpbD88Ba+rMIe8WC7A36+koymiIuTy5R0cP/MX3YmPxkIUYSkappjcI1fTSN9AoqLQitfbAo1y5ExvlP2I2ZFLEUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJkGTk8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04F3C433F1;
	Fri, 23 Feb 2024 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717503;
	bh=61ZPwyu9SRxE8LspTKZJRDCV3i5FHGC9oOaA/Lh95VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJkGTk8dGv7PfYkNiMIrg9eHvTzqU//JoVn9bWxqA1BGDfd16B6R/c//u5KREMfD1
	 86A8HqPNt7vqdb9O6I5QIrKkPiAgtWf3qI55XUEu3Qr2Ipu4DGNZCHy/LGAAyqqNSK
	 FBrKD6XJ0hvsV+dkWwRvLs+6sG6+tzNzwz7hMtn4o7dOUcWT9I/MUHEocjptQzTmke
	 w6Whzs2nxwEbGju8DFtJ3r+5hgj25SLA4GPOf98ALP0ybsd6Z4p3lhn9paMSFPYfWg
	 bm3+BAtj0iOIaGrdTQ+x/UUfozS1O+bqOZ32X9To5vzVdJJIJvzNM/f5WY8hDRWyZa
	 x3wglURpuyuyw==
Date: Fri, 23 Feb 2024 20:44:55 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v3 09/16] HID: bpf/dispatch: regroup kfuncs
 definitions
Message-ID: <ld4rv7gw6cpj4emlqo5tj5zprrrk4qjlr6xl3mfkdrq4uyoof2@zhmehkrr5st7>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-9-1fb378ca6301@kernel.org>
 <962a182f514e96ce258e7173608c282a6183775a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962a182f514e96ce258e7173608c282a6183775a.camel@gmail.com>

On Feb 22 2024, Eduard Zingerman wrote:
> On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:
> 
> [...]
> 
> > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > index e630caf644e8..52abb27426f4 100644
> > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > @@ -143,48 +143,6 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
> >  }
> >  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> >  
> > -/* Disables missing prototype warnings */
> > -__bpf_kfunc_start_defs();
> 
> Note:
> this patch does not apply on top of current bpf-next [0] because
> __bpf_kfunc_start_defs and __bpf_kfunc are not present in [0].
> 
> [0] commit 58fd62e0aa50 ("bpf: Clarify batch lookup/lookup_and_delete semantics")

Right... this was in Linus' tree as a late 6.8-rcx addition. Depending
on how bpf-next will be rebased/merged, I'll see if I merge this
subseries through the HID tree or the BPF one.

Cheers,
Benjamin

> 
> > -
> > -/**
> > - * hid_bpf_get_data - Get the kernel memory pointer associated with the context @ctx
> > - *
> > - * @ctx: The HID-BPF context
> > - * @offset: The offset within the memory
> > - * @rdwr_buf_size: the const size of the buffer
> > - *
> > - * @returns %NULL on error, an %__u8 memory pointer on success
> > - */
> > -__bpf_kfunc __u8 *
> > -hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr_buf_size)
> > -{
> > -	struct hid_bpf_ctx_kern *ctx_kern;
> > -
> > -	if (!ctx)
> > -		return NULL;
> 
> [...]

