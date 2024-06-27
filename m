Return-Path: <linux-kselftest+bounces-12849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECF91A2E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08084281D60
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB44132492;
	Thu, 27 Jun 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhtVPYPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982961B949;
	Thu, 27 Jun 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481557; cv=none; b=puyS09n4wm7OvsM/1jA7djnvhEaCWlyLDd9WYYmzaHp0ZEZIFcCVNQYFvrZL9uUaZf5aWzyYUtJQbianU+m28EwLgzl4oFi0iPx8NQQq8yriIkc2VEB1UO3QEgd+502MpFEgN1q+TOl5KktkHabf/7ArbKC3KUumOOIOD8/0eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481557; c=relaxed/simple;
	bh=NpwvjC4ANVgCf+aio1aXDIJ5ySMQ1KmL1srx2aEJLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTjGcx6NRb/VFmSmUu5KclfkKM4IsfimVNrsjAkqX2dXAOrPafMK6aYmqSITxo3U8MM7AYSHqh1DAr9CEkj+ePca4rlGCLz0slV0QTcv3lAy4i9/P8n+zx+tNXIbJxgS9uDBXLGsmkaV/vLU6TjsDf9EUaaNqI9MDQUPrry6NF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhtVPYPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BA5C2BBFC;
	Thu, 27 Jun 2024 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719481557;
	bh=NpwvjC4ANVgCf+aio1aXDIJ5ySMQ1KmL1srx2aEJLZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhtVPYPCNEXrnrCh4Yq69IhewZgEW3R3aaoPIfz63RmIW/FmlDfldLjOLfo0l2TzN
	 yHstj7QGuFbDdZK4vkO/ZWz6U0G8Vh98s6SBbx51QGchDz9sdH6rz9K9Yw7YATB4La
	 aSIQ3+j/YSeev0/TkpJqlBzkZ0oA4rlRrCF7pLIREDQhlwYiaV7kcAZ6YuD/MWMrgW
	 cM08BWJZnusT0n6yGfVJPs/0Hxkufmuwx+F7fdrkNQ1MXzxwsgGB1/HZv2z/0BdsTr
	 4JL/j/QyHvr/r18PgRcf9DsProb+LeHJCvyckrp54m69AmorBChKkeRZCIL/6xVxHB
	 xN6tFSNIZ5Aiw==
Date: Thu, 27 Jun 2024 11:45:52 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID v2 04/13] HID: bpf: add HID-BPF hooks for
 hid_hw_raw_requests
Message-ID: <tbn4vj2myjcic3mgms5nzci2tl3okpswlkddummubs2llqiruu@u3ctih7cfhhv>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
 <20240626-hid_hw_req_bpf-v2-4-cfd60fb6c79f@kernel.org>
 <CAADnVQLZRE_QxuEaqbTpKNQt+0VUB=DK37FqScaxtqwbn9UorA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLZRE_QxuEaqbTpKNQt+0VUB=DK37FqScaxtqwbn9UorA@mail.gmail.com>

On Jun 26 2024, Alexei Starovoitov wrote:
> On Wed, Jun 26, 2024 at 6:46 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > This allows to intercept and prevent or change the behavior of
> > hid_hw_raw_request() from a bpf program.
> >
> > The intent is to solve a couple of use case:
> > - firewalling a HID device: a firewall can monitor who opens the hidraw
> >   nodes and then prevent or allow access to write operations on that
> >   hidraw node.
> > - change the behavior of a device and emulate a new HID feature request
> >
> > The hook is allowed to be run as sleepable so it can itself call
> > hid_bpf_hw_request(), which allows to "convert" one feature request into
> > another or even call the feature request on a different HID device on the
> > same physical device.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > changes in v2:
> > - make use of SRCU
> > ---
> >  drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++++++++
> >  drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
> >  drivers/hid/hid-core.c               |  6 ++++++
> >  include/linux/hid_bpf.h              | 35 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 79 insertions(+)
> >
> > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > index c026248e3d73..ac98bab4c96d 100644
> > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > @@ -74,6 +74,43 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
> >  }
> >  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
> >
> > +int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
> > +                                 unsigned char reportnum, u8 *buf,
> > +                                 u32 size, enum hid_report_type rtype,
> > +                                 enum hid_class_request reqtype,
> > +                                 u64 source)
> > +{
> > +       struct hid_bpf_ctx_kern ctx_kern = {
> > +               .ctx = {
> > +                       .hid = hdev,
> > +                       .allocated_size = size,
> > +                       .size = size,
> > +               },
> > +               .data = buf,
> > +       };
> > +       struct hid_bpf_ops *e;
> > +       int ret, idx;
> > +
> > +       if (rtype >= HID_REPORT_TYPES)
> > +               return -EINVAL;
> > +
> > +       idx = srcu_read_lock(&hdev->bpf.srcu);
> > +       list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
> > +                                srcu_read_lock_held(&hdev->bpf.srcu)) {
> > +               if (e->hid_hw_request) {
> > +                       ret = e->hid_hw_request(&ctx_kern.ctx, reportnum, rtype, reqtype, source);
> > +                       if (ret)
> > +                               goto out;
> > +               }
> > +       }
> 
> here and in patch 7 I would reduce indent by doing:
> if (!e->hid_hw_request)
>    continue;
> ret = e->hid_hw_request(...);
> 
> otherwise lgtm

Thanks for the quick review.

I've changed the patches as you requested before applying them and also
added the Ack from Jiri he gave me over IRC.

Cheers,
Benjamin


