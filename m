Return-Path: <linux-kselftest+bounces-11466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49A90100C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D57A1F22370
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3E14EC48;
	Sat,  8 Jun 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmUGFplI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF264D52E;
	Sat,  8 Jun 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833642; cv=none; b=ZlIYVN3tmwmFAfqEeMyqclBbdV8UfJblMcN7DyLg8mr5M5BsQQhZr4GqMUFCxeN0KMZWOjV9ln7Xupv9ElFIpd2vv6eVPTf3mMvxlQOYfoZoqx5Hwp70o0iyTCC1Fcp2VAvBZ+/2wyKmzXQpY6xWjXaoFvOu2Wkn7wfIYO+iAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833642; c=relaxed/simple;
	bh=dyWkWAjcmcVyqpJpwtWFXArNsMhN/Ls0PlJNmB6jSWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GowNRDnM5H6/OMgmpg5/iB6lQTlpvSIQI220A0pscqQg6Afnq0Bag8fP/x64uckdkyoWEWvYLvP0NJmyLubYFweKKFqBBrT2XctkKdxcWo7yL4DjMb3+IACbVroaG7V48sWFhpyw0MbbvTmTi2H5aE5FkxzzbNuF36d2+ktDDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmUGFplI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4DC2BD11;
	Sat,  8 Jun 2024 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717833642;
	bh=dyWkWAjcmcVyqpJpwtWFXArNsMhN/Ls0PlJNmB6jSWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmUGFplIRYZ6FKMM0Db5avlYYgfnBZvibvT91XjzD8enagYtpEEHpQw19xoLrjgYi
	 X6SHi127j6e+lvLIwCR8gr8dTEu8pyH5p3jFrP5WeVbWprALSeGN+vV1Fz5+8a/zWP
	 ZCnlGq3CEj6ee+mzuoQNI4bW+PmrHn3B2aTTgb/MAWi/QUgwwqlE4feOK1iGA85i0W
	 3etRqQ8k37gYnjvGU1AgUp32xnGl5Jllr7puChKx3WIGAY7xwThFmgfRYrSKdtBcVx
	 Dt1xlPdcqmoMzVqRgcKKhoJoEln927zbRgzojs9S3J/CAunooih7v8mvDbcmKNbQM/
	 fOYjx3vytIbYA==
Date: Sat, 8 Jun 2024 10:00:37 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID v2 03/16] HID: bpf: implement HID-BPF through
 bpf_struct_ops
Message-ID: <m2eq2mdkdjrbumnj2mgvbsstfi4pcigss35gkj365ck2stx2vf@gatvf73z2sd4>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
 <20240607-hid_bpf_struct_ops-v2-3-3f95f4d02292@kernel.org>
 <CAADnVQJo71xGQKLTW6Z1xsTLjtikN8bfemPUF4zj2c2Uvi5JMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJo71xGQKLTW6Z1xsTLjtikN8bfemPUF4zj2c2Uvi5JMw@mail.gmail.com>

On Jun 07 2024, Alexei Starovoitov wrote:
> On Fri, Jun 7, 2024 at 8:28 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > +struct hid_bpf_ops {
> > +       /* hid_id needs to stay first so we can easily change it
> > +        * from userspace.
> > +        */
> > +       int                     hid_id;
> > +       u32                     flags;
> > +
> > +       /* private: internal use only */
> > +       struct list_head        list;
> > +
> > +       /* public: rest is public */
> 
> Didn't notice it before, but the above comments are misleading.
> The whole struct is private to the kernel and bpf prog, while
> registering, can only touch a handful.
> I'd drop "internal use" and "is public". It's not an uapi.

Good point. The only purpose of this was to expose or not the fields in
the doc, so I'll make it clear that this is the reason of
"private/public".

> 
> > +
> > +/* fast path fields are put first to fill one cache line */
> 
> Also misleading. The whole struct fits one cache line.

true :)

> 
> > +
> > +       /**
> > +        * @hid_device_event: called whenever an event is coming in from the device
> > +        *
> > +        * It has the following arguments:
> > +        *
> > +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> > +        *
> > +        * Return: %0 on success and keep processing; a positive
> > +        * value to change the incoming size buffer; a negative
> > +        * error code to interrupt the processing of this event
> > +        *
> > +        * Context: Interrupt context.
> > +        */
> > +       int (*hid_device_event)(struct hid_bpf_ctx *ctx, enum hid_report_type report_type);
> > +
> > +/* control/slow paths put last */
> > +
> > +       /**
> > +        * @hid_rdesc_fixup: called when the probe function parses the report descriptor
> > +        * of the HID device
> > +        *
> > +        * It has the following arguments:
> > +        *
> > +        * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
> > +        *
> > +        * Return: %0 on success and keep processing; a positive
> > +        * value to change the incoming size buffer; a negative
> > +        * error code to interrupt the processing of this device
> > +        */
> > +       int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);
> > +
> > +       /* private: internal use only */
> > +       struct hid_device *hdev;
> > +} ____cacheline_aligned_in_smp;
> 
> Such alignment is an overkill.
> I don't think you can measure the difference.

ack

> 
> > +
> >  struct hid_bpf_prog_list {
> >         u16 prog_idx[HID_BPF_MAX_PROGS_PER_DEV];
> >         u8 prog_cnt;
> > @@ -129,6 +188,10 @@ struct hid_bpf {
> >         bool destroyed;                 /* prevents the assignment of any progs */
> >
> >         spinlock_t progs_lock;          /* protects RCU update of progs */
> > +
> > +       struct hid_bpf_ops *rdesc_ops;
> > +       struct list_head prog_list;
> > +       struct mutex prog_list_lock;    /* protects RCU update of prog_list */
> 
> mutex protects rcu update... sounds very odd.
> Just say that mutex protects prog_list update, because "RCU update"
> has a different meaning. RCU logic itself is what protects Update part of rcU.

Ack

> 
> The rest looks good.

Thanks for looking into it!

Cheers,
Benjamin

