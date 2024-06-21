Return-Path: <linux-kselftest+bounces-12454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD83912AEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511AA1C25D21
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044B15FCFE;
	Fri, 21 Jun 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP4BI3Cp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AE15FA77;
	Fri, 21 Jun 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986099; cv=none; b=hVvPR/KgPwqGxXlTztqvblDPvPYoKE+CxQOBTUz8wt8xln2wX450sVmdgSs6C8LJfkQCxdp0N15VmaDdqMO4Spxov9QPRsfjHDg+Ut78279v5cfmBLe43mnCIWe8J5WvqjwKvpM2eLh9mE7hgLWSzxcR4p3u5brW2AxEHnTFbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986099; c=relaxed/simple;
	bh=8WHoPkIuAPMXnYnVZeBwVBbF05/VzGx9LNpn4kMkvvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtR4rt1+Ly22wnJ4ROe6/eVsuS/XD23XlcXBwml0e1+b8QRVw0SEs3D9zm/oE6OuDBTpHJXsh84Q9W/8A8EWGRRf7olrGDuXv6E0UzFrdFvwNGbLh5PU4PkcL5gQnhE/OpmvqFKCZ+LSQyKtpeajsVhjU5KAMSXDNbXXqqHO1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP4BI3Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D308C2BBFC;
	Fri, 21 Jun 2024 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986098;
	bh=8WHoPkIuAPMXnYnVZeBwVBbF05/VzGx9LNpn4kMkvvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP4BI3CpwhbwdpbR69Sr1cSfMeFlNfMnU+cPKetMq109UvULUaY+Fv06l3sWHvHoK
	 F5IUwJ0bpHa/zYLTOuAgAvz4faflN4d9uJhPqXAlYYH1F47GckztMpdOSzJ0usKmLM
	 5rDPV6MIoETAFVqI2WDpPTHcp+ohE0eKAkcZFGh9osy1F/VpEoJIrcQnH1WndcP1BF
	 ZUtbUjSPWjqatFduKY2PehIurNxWk6s+NNXyvSX2DDp2n4yRZCkRN0d9rGbenTIfjw
	 3IkuI3d4hG54tG/sC1oyqN9j/m5d3/IskXHFcwBY8WYNKC8+sf1BzadbHd8c+Er7Ln
	 lfW8aiy89ZT4A==
Date: Fri, 21 Jun 2024 18:08:13 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID 06/12] HID: bpf: add HID-BPF hooks for
 hid_hw_output_report
Message-ID: <dcbgoe7gija3fn5zsooulnq3jey4twwqvsxjv4yjijacnrlt2h@q6obu65ifctt>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
 <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org>
 <CAADnVQ+us6cQepSGWbOB4K1bb_0Wh43Cpo4zXJxB2d+SVpYinQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+us6cQepSGWbOB4K1bb_0Wh43Cpo4zXJxB2d+SVpYinQ@mail.gmail.com>

On Jun 21 2024, Alexei Starovoitov wrote:
> On Fri, Jun 21, 2024 at 1:56 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > Same story than hid_hw_raw_requests:
> >
> > This allows to intercept and prevent or change the behavior of
> > hid_hw_output_report() from a bpf program.
> >
> > The intent is to solve a couple of use case:
> >   - firewalling a HID device: a firewall can monitor who opens the hidraw
> >     nodes and then prevent or allow access to write operations on that
> >     hidraw node.
> >   - change the behavior of a device and emulate a new HID feature request
> >
> > The hook is allowed to be run as sleepable so it can itself call
> > hid_hw_output_report(), which allows to "convert" one feature request into
> > another or even call the feature request on a different HID device on the
> > same physical device.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > Here checkpatch complains about:
> > WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code
> >
> > However, we are jumping in BPF code, so I think this is correct, but I'd
> > like to have the opinion on the BPF folks.
> > ---
> >  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++++----
> >  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
> >  drivers/hid/hid-core.c               | 10 ++++++++--
> >  drivers/hid/hidraw.c                 |  2 +-
> >  include/linux/hid.h                  |  3 ++-
> >  include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
> >  6 files changed, 68 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > index 8d6e08b7c42f..2a29a0625a3b 100644
> > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > @@ -111,6 +111,38 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
> >  }
> >  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
> >
> > +int dispatch_hid_bpf_output_report(struct hid_device *hdev,
> > +                                  __u8 *buf, u32 size, __u64 source,
> > +                                  bool from_bpf)
> > +{
> > +       struct hid_bpf_ctx_kern ctx_kern = {
> > +               .ctx = {
> > +                       .hid = hdev,
> > +                       .allocated_size = size,
> > +                       .size = size,
> > +               },
> > +               .data = buf,
> > +               .from_bpf = from_bpf,
> > +       };
> > +       struct hid_bpf_ops *e;
> > +       int ret;
> > +
> > +       rcu_read_lock_trace();
> > +       list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
> > +               if (e->hid_hw_output_report) {
> > +                       ret = e->hid_hw_output_report(&ctx_kern.ctx, source);
> > +                       if (ret)
> > +                               goto out;
> > +               }
> > +       }
> > +       ret = 0;
> > +
> > +out:
> > +       rcu_read_unlock_trace();
> 
> same question.

re What is this for?:

e->hid_hw_output_report might sleep, so using a plain rcu_read_lock()
introduces warnings.


> What protects prog_list ?

I currently have a mutex in "struct hid_bpf" (prog_list_lock).

I tried to take the lock instead of calling rcu_read_lock_trace() but
while in e->hid_hw_output_report, we can call hid_bpf_hw_output_report
exactly once, which leads to a deadlock as we are re-entering
dispatch_hid_bpf_output_report() (same applies to hid_raw_request).


> list_for_each_entry_rcu() should be used within RCU CS
> if elements of that list are freed via call_rcu().
> rcu_read_lock_trace() looks wrong here.

I'm not sure if I could use nested mutexes or if I should work with some
other locking mechanism (or not take the lock when we are coming from
bpf, but I would need to keep tabs on who actually called what).

Anyway, thanks for having a look at it :)

Cheers,
Benjamin

