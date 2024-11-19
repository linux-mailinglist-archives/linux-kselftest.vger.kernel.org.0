Return-Path: <linux-kselftest+bounces-22216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA049D1CB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 01:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51164B21397
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0627473;
	Tue, 19 Nov 2024 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTBQBxgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EA200A0
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976800; cv=none; b=L9jtV30y0XBR7bSDJFkyEiPGRrKCXNtdrArZfKrdOHJEJ9GIbcDtLZKYClgAzXn2dKcB1TcP9vWjYWVHnBoc8mi3TVzbk7hW6vPlcUlbb2elDzzh5uXCDe2Pq16JsVYhcgxFX/3H6nd2/3uWRSbMubUEaIgzrDIxN8HOHSAHZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976800; c=relaxed/simple;
	bh=YzMNvJAMgAye6FGH0t0zMVzWqRVdNrG+1sIZy8+p89A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddd8L1XYY+FcYGr/ZpfvFKLVvC6B0aKXQ4l/hRvYZxPKWtxcssKVWilK0XIzdAqGEX+Y+GUSZ2Z3x5Kw682vLvOXFtIN/K+BoJKwu7gFnJd5Dd/YFaEgCb90wMzeXIfFTv5QtbBKv8E2os6tZaZfq7Zq66OlHdhN4r5QQVorB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTBQBxgK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so4267a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 16:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731976797; x=1732581597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzMNvJAMgAye6FGH0t0zMVzWqRVdNrG+1sIZy8+p89A=;
        b=dTBQBxgKsBAZa/t6YBs62+MeMILN92Ktw2GxP4wsG6pwcy2I3XUjJCUvPcwQ5uEDoH
         M76UgWhZDEloosLxerYCmxmHTaLBBV1h8CPtJQ5IF2ZAZC3m0sJM4RuUi3E15oyuMLhP
         Y702b0F9Nk5HwYTsEjl1aKjNAIZ0GE9Wz7+KHzJPJ066KMeoPyK4ueFfDki79jdhOxyr
         FELRF8w8+hIoTSCgw0dMQjL1kFYmmtgleaWvY501gAtxeOhPjTLpXU3Wu3gzkAflH68f
         I6fF8c4m4mv081v8+S3QldhkjtuDfK40tkUzWJLKxAIrFSjSFwS5/M4RSYEDyQMORbFQ
         Cq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731976797; x=1732581597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzMNvJAMgAye6FGH0t0zMVzWqRVdNrG+1sIZy8+p89A=;
        b=qGibTbBnEY0vvrxnS1+fNJVHxjjtEOUZwcANZql/80kVqxhN7XDM7p7DilquLLyL9G
         VrheEKaCfi+lP6KKh6aqeloKWTcIGZNDK8+FSMYbr1BfuSqWsmZG2l0mnAX0NsUJWmKt
         ufV9+ZgcWep+lO8XxDrWj0MuRDwjeo2S/smmVXXulQmVsgvzHIjFKWtJdwj/049hyLEB
         L5Fb3bdor416hx9GKR36X3eq/BhyGvAgKADTIa6nOcJJZuKNAKI2xMba1ecKVTRSw6vW
         AcgGSIhFn/0TPI+Gu5+4LX2zWSZvg2C+uIi5lCScvTOps5FG3MGmlIbe/lpzH33NEmNV
         Qgyw==
X-Forwarded-Encrypted: i=1; AJvYcCXcZ/Zips4AQnw9nE3LlsL8jx5M5cT6RDX7cArYS02YMt1jIew8qMBc7p2I7o3pWci4DuWQf+uE74/97fYDPlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1GSgYkyT6yA3OH3eHBE1p23TrlLQok1fQhYKLD71IZoPYYtf
	e3MWCieSLJvNi7GMLyHR9Xcnx4gzEFB44Zwaa5sltyS2OvkiMk4KcRpAOUzrVox+FTbw4vuMuN8
	klZ4uDFQpw8k5jjEel20g4OGkmsP3FBIf+3No4YhRknj0ON74Y4O/zNpU6w==
X-Gm-Gg: ASbGncvZV+9eal5JgnHmW0oPkJOHJcGIBXyJpHE6n94syg61BgpBwaPBlksn301GVk4
	p/JStOq/cUNjOEkLqnhZqQsaygpkvzkveHh9pfCS2p6iOyMrP1nrVHWRDOo+k
X-Google-Smtp-Source: AGHT+IEqFrrGyfsezRMsp/X151aTE55F7rPkKrYZLMq7HZJ1MQF2NOGKpWL8huBQFIpX81LUzRGmY7/k9ZOF+cLi7qc=
X-Received: by 2002:a05:6402:1351:b0:5cf:bd9a:41ec with SMTP id
 4fb4d7f45d1cf-5cfdec244d3mr32883a12.2.1731976796952; Mon, 18 Nov 2024
 16:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
In-Reply-To: <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 01:39:19 +0100
Message-ID: <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:24=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Mon, Nov 18, 2024 at 7:54=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Mon, Nov 18, 2024 at 12:17=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> > > > It operates through the Linux debugfs interface, with two files: "v=
irt"
> > > > and "phys".
> > > >
> > > > The "virt" file takes a virtual address and PID and outputs informa=
tion
> > > > about the corresponding page.
> > > >
> > > > The "phys" file takes a physical address and outputs information ab=
out
> > > > that page.
> > > >
> > > > The output is presented via kernel log messages (can be accessed wi=
th
> > > > dmesg), and includes information such as the page's reference count=
,
> > > > mapping, flags, and memory cgroup. It also shows whether the page i=
s
> > > > mapped in the kernel page table, and if so, how many times.
> > >
> > > I mean, even though I'm not a huge fan of kernel pointer hashing etc.=
 this
> > > is obviously leaking as much information as you might want about kern=
el
> > > internal state to the point of maybe making the whole kernel pointer
> > > hashing thing moot.
> > >
> > > I know this requires CAP_SYS_ADMIN, but there are things that also re=
quire
> > > that which _still_ obscure kernel pointers.
> > >
> > > And you're outputting it all to dmesg.
> > >
> > > So yeah, a security person (Jann?) would be better placed to comment =
on
> > > this than me, but are we sure we want to do this when not in a
> > > CONFIG_DEBUG_VM* kernel?
> >
> > I guess there are two parts to this - what root is allowed to do, and
> > what information we're fine with exposing to dmesg.
> >
> > If the lockdown LSM is not set to LOCKDOWN_CONFIDENTIALITY_MAX, the
> > kernel allows root to read kernel memory through some interfaces - in
> > particular, BPF allows reading arbitrary kernel memory, and perf
> > allows reading at least some stuff (like kernel register states). With
> > lockdown in the most restrictive mode, the kernel tries to prevent
> > root from reading arbitrary kernel memory, but we don't really change
> > how much information goes into dmesg. (And I imagine you could
> > probably still get kernel pointers out of BPF somehow even in the most
> > restrictive lockdown mode, but that's probably not relevant.)
> >
> > The main issue with dmesg is that some systems make its contents
> > available to code that is not running with root privileges; and I
> > think it is also sometimes stored persistently in unencrypted form
> > (like in EFI pstore) even when everything else on the system is
> > encrypted.
> > So on one hand, we definitely shouldn't print the contents of random
> > chunks of memory into dmesg without a good reason; on the other hand,
> > for example we do already print kernel register state on WARN() (which
> > often includes kernel pointers and could theoretically include more
> > sensitive data too).
> >
> > So I think showing page metadata to root when requested is probably
> > okay as a tradeoff? And dumping that data into dmesg is maybe not
> > great, but acceptable as long as only root can actually trigger this?
> >
> > I don't really have a strong opinion on this...
> >
> >
> > To me, a bigger issue is that dump_page() looks like it might be racy,
> > which is maybe not terrible in debugging code that only runs when
> > something has already gone wrong, but bad if it is in code that root
> > can trigger on demand?
>
> Hi Jann, thank you for reviewing this proposal.
>
> Presumably, the interface should be used only when something has gone
> wrong but has not been noticed by the kernel. That something is
> usually checksums failures that are outside of the kernel: i.e. during
> live migration, snapshotting, filesystem journaling, etc. We already
> have interfaces that provide data from the live kernel that could be
> racy, i.e. crash utility.

Ah, yes, I'm drawing a distinction here between "something has gone
wrong internally in the kernel and the kernel does some kinda-broken
best-effort self-diagnostics" and "userspace thinks something is
broken and asks the kernel".

> > __dump_page() copies the given page with
> > memcpy(), which I don't think guarantees enough atomicity with
> > concurrent updates of page->mapping or such, so dump_mapping() could
> > probably run on a bogus pointer. Even without torn pointers, I think
> > there could be a UAF if the page's mapping is destroyed while we're
> > going through dump_page(), since the page might not be locked. And in
> > dump_mapping(), the strncpy_from_kernel_nofault() also doesn't guard
> > against concurrent renaming of the dentry, which I think again would
> > probably result in UAF.
>
> Since we are holding a reference on the page at the time of
> dump_page(), the identity of the page should not really change, but
> dentry can be renamed.

Can you point me to where a refcounted reference to the page comes
from when page_detective_metadata() calls dump_page_lvl()?

> > So I think dump_page() in its current form is not something we should
> > expose to a userspace-reachable API.
>
> We use dump_page() all over WARN_ONs in MM code where pages might not
> be locked, but this is a good point, that while even the existing
> usage might be racy, providing a user-reachable API potentially makes
> it worse. I will see if I could add some locking before dump_page(),
> or make a dump_page variant that does not do dump_mapping().

To be clear, I am not that strongly opposed to racily reading data
such that the data may not be internally consistent or such; but this
is a case of racy use-after-free reads that might end up dumping
entirely unrelated memory contents into dmesg. I think we should
properly protect against that in an API that userspace can invoke.
Otherwise, if we race, we might end up writing random memory contents
into dmesg; and if we are particularly unlucky, those random memory
contents could be PII or authentication tokens or such.

I'm not entirely sure what the right approach is here; I guess it
makes sense that when the kernel internally detects corruption,
dump_page doesn't take references on pages it accesses to avoid
corrupting things further. If you are looking at a page based on a
userspace request, I guess you could access the page with the
necessary locking to access its properties under the normal locking
rules?

(If anyone else has opinions either way on this line I'm trying to
draw between kernel-internal debug paths and userspace-triggerable
debugging, feel free to share; I hope my mental model makes sense but
I could imagine other folks having a different model of this?)

