Return-Path: <linux-kselftest+bounces-22364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E19D40A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CDB38AD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149B145A07;
	Wed, 20 Nov 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="cdtUej7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92368137930
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119258; cv=none; b=mS71J7KhE3iqX3azT8oyH3buZTX1omFrTJonsIaWtQwwfT8sbwz5+OhESqoI5imQT8p4awwhWb/3b8HiZpawXRfVRe1mHeEjjTkwMBvtPmtEeydEA1tOQ0+zGaPKMH4eAysNcdBmyYsrO13SUk5d+7h+EQv3xYVaoIDl9V15IP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119258; c=relaxed/simple;
	bh=g7QfRcSQn+gmJxBWhXW/TDF3sI8DjgoFIAHLcTGc4so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUSugQTlvVAlYLmH5o4hCrekyTkLnwD9jb0c85I4IJc3WoSD7gMbjX6Y+bCa3qLHh5EVHSh23MLYmZzQdB9mDcrw0hFv8CDW2oHUVuzp8vGMGY9VbYKXVjwdPBwnRc1FSQYUg8sefrjY4qHTozTSO7JC/9XieEdZkAH6gxHXMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=cdtUej7x; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b158542592so304683385a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732119255; x=1732724055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mHAHuOoczvUZMevzRpdY4PbCa8tx9CNRg6h+RZgJg=;
        b=cdtUej7x3IYT7y9XJ5WDfNS9BQ4CEugaJF8mLkReIuZbp5SQ/cK64/1lRDqsOpxXJh
         Y8Ff8MiwLAO1wHoXCjkhaDeld6ozrWthThzAp+so1nL2OdjduAekmqw8OsIqhh41Jzai
         ibnhz7uY0+tDvht+9a/2BttZjOLFPQ1avZApk899yvcXXedUBE3p7pVbDOtCsw6s/+Iz
         duWxuy8NdbUiBfYvGo0HhnYCvH6vB9vyAu4HLJ7JbfePlXAaf+09m/GzcmXv7mXA9nLi
         b03CrcZYUWBWHkCZr04GHkHYIfBBzxX0kbGb1aANjN16nwSLG/eN6ARZF9GZaeL/hVlY
         SLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119255; x=1732724055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mHAHuOoczvUZMevzRpdY4PbCa8tx9CNRg6h+RZgJg=;
        b=DybceZXo4MMR/whHbqvMNR/ZR9p/BsSSc0H5A2NFasBwNjI7AfaBZGCbndi+ywM5JT
         Ep5P0pLIZaF/xEcYhipXeUncQBNXRccDGZi9zo40dplaWQezXFIyJEOsjPLFyKYaMwBW
         i7L3rIJOiMhlZdg4zdU81I3J+eaZjcOP0YA0lN1HlBXp8k/0hsuu+yACRffEgFliY7v9
         YL3P64OMio3Hew0YRK+ukYbK2iZlKbiNGBecUC7N3TMRe6DHH15gK2yDn+SHWEV0HjzO
         H3eU+O9Qc0j9guZfVZPzL1UZLACzRbnco4V3xz3mD31Pn+mbgxD3zCL4/ydupQ5CsaZe
         4KXw==
X-Forwarded-Encrypted: i=1; AJvYcCWY+IxS+ebQ0OO2WTKBvnY9JMeFAM2RAGB/RbWA/qHxtiShTgEB0xDTzly719oD9KbEU4t4wvmGfCF4wlXMgSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgq9CShCKIsctTqyOm3E7m/6gpPaOkKHILLSKxtduWTZuiyC3w
	r2ZKAQ5/aJOKMAd8lXq4PIi5vpgcfoT+T0cQTAL6AuAZBi6VZgcnwbs9rGnNx+pmEAuugIsoasF
	T4gKDVaZeDVCVstg8yAkAHBRRD+ZEufQHlT2uZg==
X-Google-Smtp-Source: AGHT+IFt7Yq3qdxAOZPq5rfspDx9bBIP2Xc48nqDhvTlFobjMOD2awIarz0pB2lJFk6Gsup7XNJxHXCOtbCvhDGq3MA=
X-Received: by 2002:a05:622a:14d2:b0:458:5ed8:628 with SMTP id
 d75a77b69052e-464777e2232mr41870841cf.2.1732119255280; Wed, 20 Nov 2024
 08:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com> <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
 <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
In-Reply-To: <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Nov 2024 11:13:37 -0500
Message-ID: <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, 
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

On Tue, Nov 19, 2024 at 2:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Nov 19, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > > > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > > > Additionally, using crash/drgn is not feasible for us at this t=
ime, it
> > > > > > requires keeping external tools on our hosts, also it requires
> > > > > > approval and a security review for each script before deploymen=
t in
> > > > > > our fleet.
> > > > >
> > > > > So it's ok to add a totally insecure kernel feature to your fleet
> > > > > instead?  You might want to reconsider that policy decision :)
> > > >
> > > > Hi Greg,
> > > >
> > > > While some risk is inherent, we believe the potential for abuse her=
e
> > > > is limited, especially given the existing  CAP_SYS_ADMIN requiremen=
t.
> > > > But, even with root access compromised, this tool presents a smalle=
r
> > > > attack surface than alternatives like crash/drgn. It exposes less
> > > > sensitive information, unlike crash/drgn, which could potentially
> > > > allow reading all of kernel memory.
> > >
> > > The problem here is with using dmesg for output. No security-sensitiv=
e
> > > information should go there. Even exposing raw kernel pointers is not
> > > considered safe.
> >
> > I am OK in writing the output to a debugfs file in the next version,
> > the only concern I have is that implies that dump_page() would need to
> > be basically duplicated, as it now outputs everything via printk's.
>
> Perhaps you can refactor the code in dump_page() to use a seq_buf,
> then have dump_page() printk that seq_buf using seq_buf_do_printk(),
> and have page detective output that seq_buf to the debugfs file?

Good idea, I will look into modifying it this way.

> We do something very similar with memory_stat_format(). We use the

void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
{
        /* Use static buffer, for the caller is holding oom_lock. */
        static char buf[PAGE_SIZE];
        ....
        seq_buf_init(&s, buf, sizeof(buf));
        memory_stat_format(memcg, &s);
        seq_buf_do_printk(&s, KERN_INFO);
}

This is a callosal stack allocation, given that our fleet only has 8K
stacks. :-)

> same function to generate the memcg stats in a seq_buf, then we use
> that seq_buf to output the stats to memory.stat as well as the OOM
> log.

