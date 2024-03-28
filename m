Return-Path: <linux-kselftest+bounces-6772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D789098C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 20:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A321F21A9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85C1386A3;
	Thu, 28 Mar 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUerO6QI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B21849;
	Thu, 28 Mar 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655178; cv=none; b=LOtlFXufwnuEClYWoTg4ex/XkoPP9iobuIH0cGcV+Q2gZ6JpZfkt5jAiQMDfyWExXEsj0VVpXMtdWz6O8Q+Ei/AgAyfd2djbrIklkJzKwLBsZzO4KNNXcnuSUvKyyS3I7A4QCS7tFKE8T5trLdRM+B82ea354ah1tWo9yXlprFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655178; c=relaxed/simple;
	bh=spgJqmt4sgwaRYWhJ7flL2ZvsHlYCW0N6JgDCKojbDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTBgBQXZH6tC5+nWZ+58cqKF6KpLSgiBl5ocQlnP8+cFILHiOnVKPyX7ETgKrk8QeOMdBeLJmxe1xdRWWxv0f7DTqsrENEQEc0QHG7P4PQyWmZhZzS5MoG2Wh917D58kcl5Se1ryTjo95poKbVu3cukjFOLdibmxl9v5d0iL6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUerO6QI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341b9f6fb2eso864898f8f.2;
        Thu, 28 Mar 2024 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655175; x=1712259975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spgJqmt4sgwaRYWhJ7flL2ZvsHlYCW0N6JgDCKojbDc=;
        b=KUerO6QI5JQ/YwBujcu/N1ElqfV1Y2/PcBI8LWNh9Fa6l8ijI3QLr8qJdyViTUUiPM
         +px9K9TO6dB4AYxUMt1wJs0SRW6m81gG7YZ6SmMDKtlYNuZafuadriIH5nx6hT5cEHwi
         yL8bh90xea5HssZdWnVYdg4rMCDrrdRU4MTt/gqJqvjoByO9cNF+olYepzDomrCOYL48
         k7odhOKf+q+yEYZWB2we4vmKNKkFaXTFlDliF7GXqflWBDcqXCkIllBBNgCJvzpMJqCw
         w5cxtzO0MT+gpgyDXcm6cJ+O1P0Q/YgUPFBZau52yJCnA3umiZeqkLbHP+MNMmdE5BdC
         He4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655175; x=1712259975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spgJqmt4sgwaRYWhJ7flL2ZvsHlYCW0N6JgDCKojbDc=;
        b=wxRhp7FJJIYFXOzdkpxi4Ww4+S6sFV2FvI401AAB0DtPbJ/aMmVq3elJin3iEXl7pr
         0vmQS3O+gZFNg9JSIE9XAUo2XLFmjG/eWA3bJF5mEDS0yB3vE5C0UvXS3czozFUFMbXC
         ZRdGW+Hq8eL+BILnorEsKjEyzr3Te3AG8n/UHsgMk1gwal1PTEDnO4AwiZNs2Xhywm2X
         66egB2wI/2hjXantqUty6aQNTZAZRmzcZF49SnLxXeLI5onXeklWBU98nYMyK9Prjdvk
         CDzHTrqllPssygOeUVzJQip/5Kd7j4ot5mvwy6S7gnpRbhSYiprMes2AC1bnevc5y+N0
         YCEg==
X-Forwarded-Encrypted: i=1; AJvYcCVx1HhP/nhXQAOaPeZRUMSKnTQoB133dgUlTHs6kdDVrVVmkjDCXuSAx7k9/bm91tJussp0S4yjRQFdrvHbHGNBeF85Ho+9N1EbFHFPF85Iu+BDR7xvEl4dwlWQPLIjaFhRFy61JnA/t3HRQBnZyDvrc1NFew/i9bxneSVIa1G292wjYzTCdj9KgIogxDpmd0o3rNkLxv2bpVt2Ag==
X-Gm-Message-State: AOJu0YwC47D81a/brX+fwjRQoofLbXvy4XqaNUAXpXC9SY0HOvo1qB2W
	hpbJDj4kmgaQS5gR9ZEIEIHnIAVaHYRw1FC/dq2TXfhXJIvcLgaZkZkEzmTxVG9JElV/NIJepD2
	0mFCnzBimdByA1q/EYTm5InsxVeQ=
X-Google-Smtp-Source: AGHT+IFWusnGRofxUqkdce214ptGaKSLBbD5ujAd410w8xh3y92TbU6CAQLelLuqig0w7Y4NkcB6iXOU8DyX1KjSe4Q=
X-Received: by 2002:a5d:66d0:0:b0:33e:d547:4318 with SMTP id
 k16-20020a5d66d0000000b0033ed5474318mr29659wrw.47.1711655174605; Thu, 28 Mar
 2024 12:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org> <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
In-Reply-To: <ZgWv19ySvoACAll4@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 12:46:03 -0700
Message-ID: <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Alexei.
>
> On Thu, Mar 28, 2024 at 10:32:24AM -0700, Alexei Starovoitov wrote:
> > > It bothers me a bit that it's adding a dedicated interface for someth=
ing
> > > which already has a defined userspace interface. Would it be better t=
o have
> > > kfunc wrappers for kernel_read() and kernel_write()?
> >
> > How would that look ?
> > prog cannot and shouldn't open a file.
>
> Oh, I didn't know. Why is that?
>
> > The seq_file would be passed/pinned by user space?
>
> Would it work if it's just "open this file, write this and then close it"=
?

Continuing discussion...
To use kernel_file_open() it would need path, inode, cred.
None of that is available now.
Allocating all these structures just to wrap a cgroup pointer
feels like overkill.
Of course, it would solve the need to introduce other
cgroup apis that are already available via text based cgroupfs
read/write. So there are pros and cons in both approaches.
Maybe the 3rd option would be to expose:
cgroup_lock() as a special blend of acquire plus lock.
Then there will be no need for bpf_task_freeze_cgroup() with task
argument. Instead cgroup_freeze() will be such kfunc that
takes cgroup argument and the verifier will check that
cgroup was acquired/locked.
Sort-of what we check to access bpf_rb_root.

