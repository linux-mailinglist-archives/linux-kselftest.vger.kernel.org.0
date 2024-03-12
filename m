Return-Path: <linux-kselftest+bounces-6261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FE8797C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A651C21542
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410A7D091;
	Tue, 12 Mar 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0z8OKEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AA07D065
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257912; cv=none; b=K4CKkjKQRwTbMLI1/8vVExns9MK8F03Fcay9dmm/+XTpapsrsQ7hrSe97s7SovswAcUwK5wYaHBTsvw3SQzc5AbZSDwBIjXSIG1yuYbLut09/z87WkRHi99FzyhPFCpx3YRcrsSyGDDhNYoERt2YzpgmJ1gqrBd2ymTF0t7mXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257912; c=relaxed/simple;
	bh=gn0sV1uxiOEoJMBzIZ3R7cJwBhxeZ+ywvlsbeFJxWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icl/3JDHsjPjM56NidQIlOWg+bpLiI2fp+GWd09ltI6ZwqgzMDn0SAiRMG1DcOdT0ckl7lNLy6/DL57Pdq0PMRDmNGQwrTw4DcdMsTuNYGsCEQ4twQ9ifKZUPbDSsdgMabsvl5oJHiFd4rpin5E1lCtxM8eUF81qywuIzqyJjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0z8OKEB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710257909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NO2ng5ojcuuq2VJkd8yzdtqpo1AFnaPqHeS1TAsaTo=;
	b=A0z8OKEBhlZG60K0oE83e/t0n2z7AT7OUgn94Q2VyOMwxIVdJbNdTyL/L+BkEQZJJ5UG38
	40HNfe+u4rODluyUTbSbypYx7wjBoaQCKeEfg3+MWEocPppYc6d7Fgws0lmIde/RP+WygK
	S3ojY94EFXJe/6v9fbXN7unwo9ENo+A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-oIqedRQ7NaWIQRrQNMnnyQ-1; Tue, 12 Mar 2024 11:38:28 -0400
X-MC-Unique: oIqedRQ7NaWIQRrQNMnnyQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42f30752eb4so17467041cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 08:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257907; x=1710862707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NO2ng5ojcuuq2VJkd8yzdtqpo1AFnaPqHeS1TAsaTo=;
        b=hCNTDlFpjF/QQKu6GTANarBLad4KRyK91N2TY6M/khMhJ7UwMRGYUXWr4IuDwdnnRq
         tPeC74K9hMlsyuNOkV/KIL9PyNqdNboCOLx/lnzq/VAV5gYeKfq23zz/3rni02iUCGTX
         kh0+oVlBYTsUkD3RX2z4otMP4+OVt36CqMuEBbDvWbo8XxfJZAaCVeBTKMliVKqyAO1I
         IFDQvVh2E3Zr/zTDKAPAYTnD+blaUMwE3PkzzlI4AFtqvgB6fBDbFIsh3Su7onhxVeid
         qlCEvAGKGeksST2gVDfGlxunvUYhMR3K5GLZNrtohMo+q0zW7RG1PiDH4/AnEVMeGeYd
         Lofw==
X-Forwarded-Encrypted: i=1; AJvYcCVCC5YrpH0pnkbkgsuzGJf4EAxnUh3PAiaJmgtFbMFQFezS7+f3oGkYEwq6OWNv4sB3HWz+6tbfEYvzk2/rAHluLPyPVeohDjjuxba4rgEx
X-Gm-Message-State: AOJu0YyMag3/eO6uw00MlSmSrSFY8SvcOCWKAOdYiAkyHI/raREn4k5I
	pESC+6VXYdcPO0iGJ1pJBGu4T0z5L689nOUZLu2zPq98ozNBAt/ul+4eCMpY9GXgMN91i8alffr
	LNGQHIG+8tmTfU8yu/l1USJOZ5aDC3UYvdbSepwE5UxKL/PQo2AgzuiF4aiuVvJVTRA==
X-Received: by 2002:a05:620a:3710:b0:788:5c6b:16bf with SMTP id de16-20020a05620a371000b007885c6b16bfmr13059535qkb.0.1710257907599;
        Tue, 12 Mar 2024 08:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3+TlXwXVB3tqs6EXZGDEfptiQhjVAgR1EIKYOT2l1whs/cgzV0RS0fKe3uH059/AIE8NOpg==
X-Received: by 2002:a05:620a:3710:b0:788:5c6b:16bf with SMTP id de16-20020a05620a371000b007885c6b16bfmr13059511qkb.0.1710257907234;
        Tue, 12 Mar 2024 08:38:27 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a0cf200b007871bac855fsm3792631qkj.47.2024.03.12.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:38:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:38:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: James Houghton <jthoughton@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: BUG selftests/mm]
Message-ID: <ZfB28NIbflrnsqiX@x1n>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>
 <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com>
 <Ze8fYF5I4mlUGHd9@x1n>
 <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
 <Ze9bWkrD6UBZ2ErV@x1n>
 <CADrL8HW59nt4ztY3x5G3VgpmaXQbXoXZeAjvzMp7SpsqxgDCxw@mail.gmail.com>
 <CACw3F51vMqPBHmvj4ehSA8PadXw30s3MxCqph1op5dxtB-tV6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51vMqPBHmvj4ehSA8PadXw30s3MxCqph1op5dxtB-tV6Q@mail.gmail.com>

On Mon, Mar 11, 2024 at 03:28:28PM -0700, Jiaqi Yan wrote:
> On Mon, Mar 11, 2024 at 2:27 PM James Houghton <jthoughton@google.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 12:28 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 11:59:59AM -0700, Axel Rasmussen wrote:
> > > > I'd prefer not to require root or CAP_SYS_ADMIN or similar for
> > > > UFFDIO_POISON, because those control access to lots more things
> > > > besides, which we don't necessarily want the process using UFFD to be
> > > > able to do. :/
> >
> > I agree; UFFDIO_POISON should not require CAP_SYS_ADMIN.
> 
> +1.
> 
> 
> >
> > > >
> > > > Ratelimiting seems fairly reasonable to me. I do see the concern about
> > > > dropping some addresses though.
> > >
> > > Do you know how much could an admin rely on such addresses?  How frequent
> > > would MCE generate normally in a sane system?
> >
> > I'm not sure about how much admins rely on the address themselves. +cc
> > Jiaqi Yan
> 
> I think admins mostly care about MCEs from **real** hardware. For
> example they may choose to perform some maintenance if the number of
> hardware DIMM errors, keyed by PFN, exceeds some threshold. And I
> think mcelog or /sys/devices/system/node/node${X}/memory_failure are
> better tools than dmesg. In the case all memory errors are emulated by
> hypervisor after a live migration, these dmesgs may confuse admins to
> think there is dimm error on host but actually it is not the case. In
> this sense, silencing these emulated by UFFDIO_POISON makes sense (if
> not too complicated to do).

Now we have three types of such error: (1) PFN poisoned, (2) swapin error,
(3) emulated.  Both 1+2 should deserve a global message dump, while (3)
should be process-internal, and nobody else should need to care except the
process itself (via the signal + meta info).

If we want to differenciate (2) v.s. (3), we may need 1 more pte marker bit
to show whether such poison is "global" or "local" (while as of now 2+3
shares the usage of the same PTE_MARKER_POISONED bit); a swapin error can
still be seen as a "global" error (instead of a mem error, it can be a disk
error, and the err msg still applies to it describing a VA corrupt).
Another VM_FAULT_* flag is also needed to reflect that locality, then
ignore a global broadcast for "local" poison faults.

> 
> SIGBUS (and logged "MCE: Killing %s:%d due to hardware memory
> corruption fault at %lx\n") emit by fault handler due to UFFDIO_POISON
> are less useful to admins AFAIK. They are for sure crucial to
> userspace / vmm / hypervisor, but the SIGBUS sent already contains the
> poisoned address (in si_addr from force_sig_mceerr).
> 
> >
> > It's possible for a sane hypervisor dealing with a buggy guest / guest
> > userspace to trigger lots of these pr_errs. Consider the case where a
> > guest userspace uses HugeTLB-1G, finds poison (which HugeTLB used to
> > ignore), and then ignores SIGBUS. It will keep getting MCEs /
> > SIGBUSes.
> >
> > The sane hypervisor will use UFFDIO_POISON to prevent the guest from
> > re-accessing *real* poison, but we will still get the pr_err, and we
> > still keep injecting MCEs into the guest. We have observed scenarios
> > like this before.
> >
> > >
> > > > Perhaps we can mitigate that concern by defining our own ratelimit
> > > > interval/burst configuration?
> > >
> > > Any details?
> > >
> > > > Another idea would be to only ratelimit it if !CONFIG_DEBUG_VM or
> > > > similar. Not sure if that's considered valid or not. :)
> > >
> > > This, OTOH, sounds like an overkill..
> > >
> > > I just checked again on the detail of ratelimit code, where we by default
> > > it has:
> > >
> > > #define DEFAULT_RATELIMIT_INTERVAL      (5 * HZ)
> > > #define DEFAULT_RATELIMIT_BURST         10
> > >
> > > So it allows a 10 times burst rather than 2.. IIUC it means even if
> > > there're continous 10 MCEs it won't get suppressed, until the 11th came, in
> > > 5 seconds interval.  I think it means it's possibly even less of a concern
> > > to directly use pr_err_ratelimited().
> >
> > I'm okay with any rate limiting everyone agrees on. IMO, silencing
> > these pr_errs if they came from UFFDIO_POISON (or, perhaps, if they
> > did not come from real hardware MCE events) sounds like the most
> > correct thing to do, but I don't mind. Just don't make UFFDIO_POISON
> > require CAP_SYS_ADMIN. :)
> >
> > Thanks.
> 

-- 
Peter Xu


