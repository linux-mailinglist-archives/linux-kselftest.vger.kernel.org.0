Return-Path: <linux-kselftest+bounces-12549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F78914562
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AA41C21242
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 08:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12037745E2;
	Mon, 24 Jun 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBOI14/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F96A347;
	Mon, 24 Jun 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219171; cv=none; b=oBr0nPfayxy4KOPGUogkYyGIzatR3RBvJnYY705td/t/V+/soq85nTusZQW4WgbmZUyvvNE6ZulCw8JYe0YzCqwpsMWEfUgLbJS4Dih4km/GQIqi3Pl56DAgzOUnadk8XcfxPS3svKuQZ/pPpNcUM48aJF33m6Go6LnZh+Vppk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219171; c=relaxed/simple;
	bh=Jz2YPX0sMcFcT9gDrGUv+vNcyE/fgQCLh5AW7ZHQyYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCfMz14qFLiWagLAjd37nTFxWzAD0Wqs/mhyA8s+XlYV7JeKzygzf9dYP35hEakd0lXfmfFaz6SMhOnj4YZlq/fPyACNsl+3t1z/fUFUhi45piH8LC4ozsl/9FH3JM6tDs7wNqzwn6sDEMpMaU4XpaGe0yAUxtsu3YE0tFmYd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBOI14/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A0C2BBFC;
	Mon, 24 Jun 2024 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719219170;
	bh=Jz2YPX0sMcFcT9gDrGUv+vNcyE/fgQCLh5AW7ZHQyYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBOI14/oYPx8q48kf6Xxu1uDVeHExkrJB9bxubtil/4hi6VDo/3eSS814m7EqKNuE
	 sAUGs9lNICAvuXWfcvd6d/qGekEWhRMKG8agxKIfjzXQWtvWNZ1s6/h4OY2L/v8gLu
	 D/JR4UifvKjfzypXKqSI0zEuKwQpxuZXvZVUCOAOmrFvfWZ2ZdERiQoxBu+ruSxnY5
	 Ao8bm9G96rz/dEl393pZtwgv20in3w3Z+0yuUOkTfQ4gfWEWgsqM/M6NWXWeHBBLVR
	 w7Lq+bwWcvK5homVzrnhRt1Vf7IiL7il3wycrQWaSA5ladKWDgoZe0tvBuH+6RmWJ0
	 386WOj5EUzWhw==
Date: Mon, 24 Jun 2024 10:52:45 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID 06/12] HID: bpf: add HID-BPF hooks for
 hid_hw_output_report
Message-ID: <zjcva76d6qk5hshkyf7x6jmkahmicboei4tbxxhrrfbemxcu6v@cv2vdhjszdsf>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
 <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org>
 <CAADnVQ+us6cQepSGWbOB4K1bb_0Wh43Cpo4zXJxB2d+SVpYinQ@mail.gmail.com>
 <dcbgoe7gija3fn5zsooulnq3jey4twwqvsxjv4yjijacnrlt2h@q6obu65ifctt>
 <CAADnVQKE6RyGUhQbTiOfa15=D9B_vtAg=VMDv8cfYrUKOv5UFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKE6RyGUhQbTiOfa15=D9B_vtAg=VMDv8cfYrUKOv5UFQ@mail.gmail.com>

On Jun 21 2024, Alexei Starovoitov wrote:
> On Fri, Jun 21, 2024 at 9:08 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > On Jun 21 2024, Alexei Starovoitov wrote:
> > > On Fri, Jun 21, 2024 at 1:56 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > > >
> > > > Same story than hid_hw_raw_requests:
> > > >
> > > > This allows to intercept and prevent or change the behavior of
> > > > hid_hw_output_report() from a bpf program.
> > > >
> > > > The intent is to solve a couple of use case:
> > > >   - firewalling a HID device: a firewall can monitor who opens the hidraw
> > > >     nodes and then prevent or allow access to write operations on that
> > > >     hidraw node.
> > > >   - change the behavior of a device and emulate a new HID feature request
> > > >
> > > > The hook is allowed to be run as sleepable so it can itself call
> > > > hid_hw_output_report(), which allows to "convert" one feature request into
> > > > another or even call the feature request on a different HID device on the
> > > > same physical device.
> > > >
> > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Here checkpatch complains about:
> > > > WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code
> > > >
> > > > However, we are jumping in BPF code, so I think this is correct, but I'd
> > > > like to have the opinion on the BPF folks.
> > > > ---
> > > >  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++++----
> > > >  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
> > > >  drivers/hid/hid-core.c               | 10 ++++++++--
> > > >  drivers/hid/hidraw.c                 |  2 +-
> > > >  include/linux/hid.h                  |  3 ++-
> > > >  include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
> > > >  6 files changed, 68 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > > > index 8d6e08b7c42f..2a29a0625a3b 100644
> > > > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > > > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > > > @@ -111,6 +111,38 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
> > > >
> > > > +int dispatch_hid_bpf_output_report(struct hid_device *hdev,
> > > > +                                  __u8 *buf, u32 size, __u64 source,
> > > > +                                  bool from_bpf)
> > > > +{
> > > > +       struct hid_bpf_ctx_kern ctx_kern = {
> > > > +               .ctx = {
> > > > +                       .hid = hdev,
> > > > +                       .allocated_size = size,
> > > > +                       .size = size,
> > > > +               },
> > > > +               .data = buf,
> > > > +               .from_bpf = from_bpf,
> > > > +       };
> > > > +       struct hid_bpf_ops *e;
> > > > +       int ret;
> > > > +
> > > > +       rcu_read_lock_trace();
> > > > +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> > > > +               if (e->hid_hw_output_report) {
> > > > +                       ret = e->hid_hw_output_report(&ctx_kern.ctx, source);
> > > > +                       if (ret)
> > > > +                               goto out;
> > > > +               }
> > > > +       }
> > > > +       ret = 0;
> > > > +
> > > > +out:
> > > > +       rcu_read_unlock_trace();
> > >
> > > same question.
> >
> > re What is this for?:
> >
> > e->hid_hw_output_report might sleep, so using a plain rcu_read_lock()
> > introduces warnings.
> 
> Ok, but just replacing rcu_read_lock() with rcu_read_lock_trace()
> doesn't fix it.
> rcu and rcu_tasks_trace are different.
> If you're using call_rcu to wait for GP to free an element in that
> list the thing will go wrong.
> 
> If you really need rcu life times here use srcu. It's a much better fit.
> There will be srcu_read_lock() here, paired with call_srcu().

OK, thanks for the explanation.

I'll work on this for v2

Cheers,
Benjamin

