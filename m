Return-Path: <linux-kselftest+bounces-22313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42A9D2FD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 21:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89E21F236AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B151D47A0;
	Tue, 19 Nov 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qdEVRNRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5501D4323
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049863; cv=none; b=tIThrJ/V3eA5GosBqcbZw1pFYiKNXs6hHnobXuN3EPX6IwG/ooH4XbMsoLVPEe9mqRnaeMru6g3LfZ8e2+jpd/fdQRQYuFYsgQ0rzYbJfh89vriDO+2j99tTzaFoDCh6u1GKZki9NMk5vsw+pOA8FUUtkohMFMQbW2rtG+q1Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049863; c=relaxed/simple;
	bh=eu3fdGlakjQ+sjcp9GBTMZDSyKI4T+Y4TCKB2oSD/R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWUXXgSBVghsjuyMZA1Jy9xY6gzd96C/UqOjbp9Zpgs3GnlPgZ8RuwvLF5xgh0ezbYylYHsuEcle/DjSVDxN/TF2FI3hmda+L/atYdHUCMlvU7u+Z4QOSa/cLt+uJuRH6RJWIKusz8C5byfnRwyGn9fKZXCamBz0WsQoniQ+vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qdEVRNRv; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Nov 2024 20:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732049854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikYo5Qt2GJ/06mlBFEkzK0zdCcALXlrhVesJOzP8WU4=;
	b=qdEVRNRv9idMTgDOAQ5Z/L2XYwEhLjKQGmW+uWLHP5ziZ0RiuL3Vqa4qe+OAFPmuaGFudb
	lZASQb0wSRq/4frvukWqXPhGaNXBkFVkCp0eIk33Sb9I3Q4h8zAwu6lTWoVdJN95op0crD
	n9atx3wtYFhsMc+4RIfipRwTUL/dJhY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
	corbet@lwn.net, derek.kiernan@amd.com, dragan.cvetic@amd.com,
	arnd@arndb.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
	oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
	gthelen@google.com
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <Zzz7tGqYM-0FCOe3@google.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com>
 <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh>
 <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com>
 <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
 <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 19, 2024 at 11:35:47AM -0800, Yosry Ahmed wrote:
> On Tue, Nov 19, 2024 at 11:30 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Tue, Nov 19, 2024 at 1:23 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > > > On Mon, Nov 18, 2024 at 8:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > > > Additionally, using crash/drgn is not feasible for us at this time, it
> > > > > > requires keeping external tools on our hosts, also it requires
> > > > > > approval and a security review for each script before deployment in
> > > > > > our fleet.
> > > > >
> > > > > So it's ok to add a totally insecure kernel feature to your fleet
> > > > > instead?  You might want to reconsider that policy decision :)
> > > >
> > > > Hi Greg,
> > > >
> > > > While some risk is inherent, we believe the potential for abuse here
> > > > is limited, especially given the existing  CAP_SYS_ADMIN requirement.
> > > > But, even with root access compromised, this tool presents a smaller
> > > > attack surface than alternatives like crash/drgn. It exposes less
> > > > sensitive information, unlike crash/drgn, which could potentially
> > > > allow reading all of kernel memory.
> > >
> > > The problem here is with using dmesg for output. No security-sensitive
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
> 
> We do something very similar with memory_stat_format(). We use the
> same function to generate the memcg stats in a seq_buf, then we use
> that seq_buf to output the stats to memory.stat as well as the OOM
> log.

+1

Thanks!

