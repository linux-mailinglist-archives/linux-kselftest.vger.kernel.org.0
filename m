Return-Path: <linux-kselftest+bounces-22212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13559D1AE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F18D1F216DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077121E6329;
	Mon, 18 Nov 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Gb6Yp+hb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351E1925A2
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967761; cv=none; b=G/qwTGjApB73uSZGJwYFpy2O2DQCdISylnNZcSeR62BzQPdKHljelRtxp5nEk7/yqtJQDMM9cFVh/wTEQE4AJuDCaMECARzQnd65BbSl9jwbwaRT5wV+hOTjmmE98UqMhJdjod0AfXvGFrBMFMFEIo8Ezlu6U676cTd/z34bKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967761; c=relaxed/simple;
	bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRpSXOjFODr0aClO6wR9UYvcO8YCnVAeCvg5jGibzIzhYPzOApslP0kYQiaRj1B54U3PcpSnNblX4Gq9nY7iuFPiXHtCCCILciBrZnlYSVscXSP0hmP35+8am+yVXRHyZEIvE9+PW6raq1ylZocf10AgWqvRxJUgSBtMoPIh4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Gb6Yp+hb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460a415633fso27249751cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731967759; x=1732572559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
        b=Gb6Yp+hb3LS2S3zgzu9xXG4v1kmiTe9wY1PbV3QgOWMQHSmHWOWT1xI8dU7iO68kBV
         4Ojo3PWXytSFdernv3ZGsb9YFfVbwDrZd5mI/0vNDx9a1+Q/WWeCJ3GevOlUWT/SqRy4
         Gy05r3/i+oZu1i3SopG02MLYAPG24QJUhTP/gryTdmzcfiNnp2l3x1v7JdQqq6aM2mR9
         vfETuXNlo83U6lSzYagXrpZbraIsauv0elkttf3q65wCPujazJlhFsgWbv1NLU2UjZjj
         VAIK7E0RbqfZVOV7eBQtKfINmP2xPdFxtDvH6O6VPmZrYP75MyniX6+BzzI7rtGsZoi+
         MBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967759; x=1732572559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8MIscQQe9cVfzpDABcS2/+GpjCcV2Zx/6rrV6Zgl5M=;
        b=Ipbn8OF+3Cd6uERXazDC7ed9Y2ZhDRWfb2q7uUSTc5aEhcT2eN+rleuv/nRLZLAhD7
         5uMvBRfph5w0BIK5Glrb/lKZkDK1aJS2+TgaUZqr/ERb3x0i+vlVm7c1a0CgHCp1fH1f
         j/vykpDJMxhfbq1kk4scBLAufFsxv/p8DWTAcK46EUHwR3cvOukave1/B06KKU+EGCN+
         pFO6elkMeTyfb4XQAKRSeryGeRoyZnogtQndQ6j87bLcFC1yyb+VIAzI4DvTOCBK6/EZ
         ME36/TTYpoMR7atBXS4ApfnA7OWvnruyXilg3wrpxt8VAfZDMSnrvYUP1H+jc9d9KFR9
         Kx+w==
X-Forwarded-Encrypted: i=1; AJvYcCWSUYJg7yiWxKp9dn3FQvDwyZWUAZUdCbzlnZ7y6veQbdME6Z5vEDzUztgoxXm2rVtUB7RwmU27SPHxMtyp/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkM+ne4L4z5tMQ4WyFJGNV0T0WMKjgZRnJSQp+Y+WyoED30Sw
	8S+ZYgsOkvLf9cUbhW0zAVRO4snrMjRa0nEzubh+cWjTgk3tQpWUjVVEGuCdpz1PsH5YOSLZbQA
	VGGaiy1KTjQwQkZGa4lc5XiTj3TtUj3MaXWGCgQ==
X-Google-Smtp-Source: AGHT+IGuHkyDbKbXTopolKHlpXUuh5hPb8odsFN1/bRhiOBmnf88AGPczox19phVHKQRb/h9sm7V4erFguZn2MVlnKk=
X-Received: by 2002:ac8:5946:0:b0:458:2764:37d5 with SMTP id
 d75a77b69052e-46363de80famr188224651cf.6.1731967759219; Mon, 18 Nov 2024
 14:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <ZzuRSZc8HX9Zu0dE@google.com>
In-Reply-To: <ZzuRSZc8HX9Zu0dE@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 17:08:42 -0500
Message-ID: <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 2:11=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > Page Detective is a new kernel debugging tool that provides detailed
> > information about the usage and mapping of physical memory pages.
> >
> > It is often known that a particular page is corrupted, but it is hard t=
o
> > extract more information about such a page from live system. Examples
> > are:
> >
> > - Checksum failure during live migration
> > - Filesystem journal failure
> > - dump_page warnings on the console log
> > - Unexcpected segfaults
> >
> > Page Detective helps to extract more information from the kernel, so it
> > can be used by developers to root cause the associated problem.
> >
> > It operates through the Linux debugfs interface, with two files: "virt"
> > and "phys".
> >
> > The "virt" file takes a virtual address and PID and outputs information
> > about the corresponding page.
> >
> > The "phys" file takes a physical address and outputs information about
> > that page.
> >
> > The output is presented via kernel log messages (can be accessed with
> > dmesg), and includes information such as the page's reference count,
> > mapping, flags, and memory cgroup. It also shows whether the page is
> > mapped in the kernel page table, and if so, how many times.
>
> This looks questionable both from the security and convenience points of =
view.
> Given the request-response nature of the interface, the output can be
> provided using a "normal" seq-based pseudo-file.

We opted to use dmesg for output because it's the standard method for
capturing kernel information and is commonly included in bug reports.
Introducing a new file would require modifying existing data
collection scripts used for reporting, so this approach minimizes
disruption to existing workflows.

> But I have a more generic question:
> doesn't it make sense to implement it as a set of drgn scripts instead
> of kernel code? This provides more flexibility, is safer (even if it's bu=
ggy,
> you won't crash the host) and should be at least in theory equally
> powerful.

Regarding your suggestion, our plan is to perform reverse lookups in
all page tables: kernel, user, IOMMU, and KVM. Currently, we only
traverse the kernel and user page tables, but we intend to extend this
functionality to IOMMU and KVM tables in future updates, I am not sure
if drgn can provide this level of details within a reasonable amount
of time.

This approach will be helpful for debugging memory corruption
scenarios. Often, external mechanisms detect corruption but require
kernel-level information for root cause analysis. In our experience,
invalid mappings persist in page tables for a period after corruption,
providing a window to identify other users of the corrupted page via
timely reverse lookup.

Additionally, using crash/drgn is not feasible for us at this time, it
requires keeping external tools on our hosts, also it requires
approval and a security review for each script before deployment in
our fleet.

Thanks,
Pasha

