Return-Path: <linux-kselftest+bounces-4229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBC84C813
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A3D28225D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318B22EE8;
	Wed,  7 Feb 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVrZzz/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C823757
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299793; cv=none; b=UwtakeCGXo2wQT9WRbR77Gn37v5xkDoYsR/h4pQqg618vHTqkpG711eB6GT3mY+bHUNBH/gWx0hhBsn+GiWn5LGoAhfQB+i7ZCWLvykxTWvEcFpx15zuvVxKM+2cTlrtm9plpSIgWypavvFy7wogljet5hdXSBPyWs4ZAErgyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299793; c=relaxed/simple;
	bh=Ffw/WkqVLoBbaHS/K/csRcmb3UzmOEbVg81Hra2QAAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdZHfCqFO0NHnfC+dLDiDQr1iNb4fBWMwnIHfXSY9zQxnnwJJyTc6yJM9+N8lW0EQUvXPCTzF7UkNlzANmJ70uEBvsg6TFAOIbRVlzyNb4soSSLnr2OKV3JEnblt3fOubg4Mmpb5GWWBS9c77auKF+xdBPakdp4HT2+NQOX/dzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVrZzz/Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fdc63f4feso3568635e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707299790; x=1707904590; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBRINMVN7gGvuV2gPWLOj+4bMKi6LNNeT7KGZJCI6SQ=;
        b=SVrZzz/ZDYryvQyahStA9U/4axrnfI94BjogIoOVHju99mpXjWjuBThvr9NTf6lwat
         s8sEGhiojS/bSPEiXbvJUt3WIpHLHaKayiXp48jSfV3t7ZvkfGA+Pq8PDvgm6WrVTZf8
         cxALDR5YhUwgeB8kH0rlB/NQlbTGjRs41R4iSevwD6d169Fm4vejivdRaopUYrWsM5MO
         +V4xXiK6+6jgABEEghIru5JwY8+AjYskqm+HBxa/dLNt5UyEILA59PsZXsBH231nCO2/
         Idf8+eIMhT3iYOGprn9J0JMrYEseMIRIKmKHDElT9ZQQCb5TMtoSrvqIULjt5wEbNPUF
         xB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299790; x=1707904590;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBRINMVN7gGvuV2gPWLOj+4bMKi6LNNeT7KGZJCI6SQ=;
        b=heYrcu3TwxPRDTZ1FoDlenw4Xqbi4ERI0GN7ymWO7/qjBJHsOZ3vOz0wJVb8mRYzFA
         OqrRHeYy6VYkpGZu8b5DrHLCL97yw7sOR/W31UAFBY3O5pUjoiSYx7QrqoNxmnnEsT6q
         YRZ5CoaE9RxtDYTc5MxGLI9+nWoo2GRIyFWMX2y+6eXDAac+nWFKu7mO7xVbfTcjCh93
         IAo+ineFiADQp60qWq26SfORgl/X6cn7FTJZkdy39aj3Nhs7eryrT3y82twoSBwrBzlg
         9L5MxBtPFsatjuHX0GaANfxqLOX2Z70w3fnfFLsO2YuXuQC1yb/YX5J5Kith+RJ8Ie4v
         C+iw==
X-Gm-Message-State: AOJu0Yxds0l6hYFWEYlVKsmE02Y+5LiTjxuvx0P0G206vA4Nfh0lQ2tt
	Y+lmPLhbvxkW1Ows4e1QnMWnPG7ryyiH/264wU03t0uA7lA+1J0z0IGDgr1fQA==
X-Google-Smtp-Source: AGHT+IF8kR8B78x6TBqRljCAS0uaAxhIj59afAe+4cqPh3iM/YDKkZ4pQ2wA3orFeSk6VwV2oT/g1A==
X-Received: by 2002:a05:600c:3d8e:b0:40f:e930:9eb8 with SMTP id bi14-20020a05600c3d8e00b0040fe9309eb8mr2810266wmb.0.1707299790036;
        Wed, 07 Feb 2024 01:56:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqjfLsSMmbCH6BsS59K6SJoox9aCWhi8IF36lRKAreLYEX5BcNuvF7bnmTfJ92oKEpCfNlZ6fvcvjcjdWqWeaU1tjs3n1xXTxIS3QJJIKp8k3yHT6GYOGa16iDWF7BG2i1loc56bHAYphnkGBqC8mnRW1+7ZCBmtRttWB/3AoagDq4XpR4v3PPlm3Lc9zRiLGuzbuhuOChPB0+BkvcLAWtlJcO4rk1EgNJNmoJhja3gHGT6FAS/6qhzUWalGA/02JHNUUw+EzDP5FogM/I78WOx1oPcmvhU15ccozNPNbXknvQfughjhW16tWbkqCSY5yAbFgdnoImLbwEsaZ0OgPUlSXmu4T+VRBD1tXkTse9SZNWG1UaexmiluYYzfis6UinmCXLTT1vTkrkPqYnLTGN5/i9wmb+tLaKII+Rm6HNJbup1DjMCanPjObkK20HXzo07uRDWNMXGM7A
Received: from elver.google.com ([2a00:79e0:9c:201:4d69:c225:7956:ca4])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0040fe2d3aec4sm4704383wmo.19.2024.02.07.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:56:29 -0800 (PST)
Date: Wed, 7 Feb 2024 10:56:23 +0100
From: Marco Elver <elver@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow
 paths
Message-ID: <ZcNTx2X7Y7zA5nrC@elver.google.com>
References: <20240131141858.1149719-1-elver@google.com>
 <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
 <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
 <5a08032b-ed4d-4429-b0a9-2736689d8c33@linux.dev>
 <ZcJmok64Xqv6l4ZS@elver.google.com>
 <9908bdfb-1030-4a9f-8405-3696c5d03981@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9908bdfb-1030-4a9f-8405-3696c5d03981@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Feb 06, 2024 at 05:22PM -0800, Martin KaFai Lau wrote:
> On 2/6/24 9:04 AM, Marco Elver wrote:
> > On Mon, Feb 05, 2024 at 03:24PM -0800, Martin KaFai Lau wrote:
> > [...]
> > > > Or can you suggest different functions to hook to for the recursion test?
> > > 
> > > I don't prefer to add another tracepoint for the selftest.
> > 
> > Ok - I also checked, even though it should be a no-op, it wasn't
> > (compiler generated worse code).
> 
> I am interested to how the tracepoint generates worse code. Can you share
> some details ?

My guess is that it produces enough code that some inlinable functions
are no longer being inlined. Specifically __bpf_task_storage_get().

> > 
> > > The test in "SEC("fentry/bpf_local_storage_lookup")" is testing that the
> > > initial bpf_local_storage_lookup() should work and the immediate recurred
> > > bpf_task_storage_delete() will fail.
> > > 
> > > Depends on how the new slow path function will look like in v2. The test can
> > > probably be made to go through the slow path, e.g. by creating a lot of task
> > > storage maps before triggering the lookup.
[...]
> > Could you suggest how we can fix up the tests? I'm a little stuck
> > because there's not much we can hook to left.
> 
> I don't see a solution either if only the cache insertion code path is in a
> traceable function.
> 
> The prog->active counter has already been covered in another test. This test
> is mostly only covering the lookup => delete recur case and the code path is
> contained within the bpf storage logic. The future code review should be
> able to cover. I would make an exception here and remove this test case
> considering anything (e.g. tracepoint) we do here is likely to make it
> worse. (more on the test removal below).
> 
> > 
> > Thanks,
> > -- Marco
> > 
> > ------ >8 ------
> > 
> > From: Marco Elver <elver@google.com>
> > Date: Tue, 30 Jan 2024 17:57:45 +0100
> > Subject: [PATCH v2] bpf: Allow compiler to inline most of
> >   bpf_local_storage_lookup()
> > 
> > In various performance profiles of kernels with BPF programs attached,
> > bpf_local_storage_lookup() appears as a significant portion of CPU
> > cycles spent. To enable the compiler generate more optimal code, turn
> > bpf_local_storage_lookup() into a static inline function, where only the
> > cache insertion code path is outlined (call instruction can be elided
> > entirely if cacheit_lockit is a constant expression).
> 
> Can you share more why only putting the cache insertion code to a function
> improves the larger number of maps case. In the benchmark, cacheit_lockit
> should always be true and __bpf_local_storage_insert_cache() should always
> be called.

Keeping bpf_local_storage_lookup() smaller (even if just outlining the
cache insertion) makes a difference as it allows the compiler generate
more optimal code, specifically we avoid duplicating setting up calls to
_raw_spin_lock/unlock. E.g.  __bpf_task_storage_get is not being inlined
anymore if bpf_local_storage_lookup() becomes too large (i.e. everything
is up for inlining incl. cache insertion).

Also, on x86 preempt builds, spin_lock/unlock aren't inlinable, so we
have to pay the price of 2 calls regardless: previously for calls to
_raw_spin_lock_irqsave and to _raw_spin_unlock_irqsave. However, with
the version of __bpf_local_storage_insert_cache in my patch, the call to
_raw_spin_unlock_irqsave is tail called, which allows the compiler to
perform TCO, i.e. we still only pay the price of 2 calls: one to
__bpf_local_storage_insert_cache and to _raw_spin_lock_irqsave (but no
call to _raw_spin_unlock_irqsave, which can just be jumped to):

<__bpf_local_storage_insert_cache>:
  endbr64
  nopl   0x0(%rax,%rax,1)
  push   %r15
  push   %r14
  push   %r12
  push   %rbx
  mov    %rdx,%rbx
  mov    %rsi,%r12
  mov    %rdi,%r15
  lea    0xa8(%rdi),%r14
  mov    %r14,%rdi
  call   ffffffff82323650 <_raw_spin_lock_irqsave>
  cmpq   $0x0,0x18(%rbx)
  je     ffffffff8127ea80 <__bpf_local_storage_insert_cache+0x40>
  add    $0x40,%rbx
  movzwl 0x10e(%r12),%ecx

  mov    %rbx,(%r15,%rcx,8)
  mov    %r14,%rdi
  mov    %rax,%rsi
  pop    %rbx
  pop    %r12
  pop    %r14
  pop    %r15
  jmp    ffffffff823237d0 <_raw_spin_unlock_irqrestore>        <--- TCO

I also compared a version where _everything_ is inlined vs. the one with
__bpf_local_storage_insert_cache outlined: the one where everything is
inlined nullifies any performance improvements and is significantly
worse than the one with __bpf_local_storage_insert_cache outlined.

[...]
> > -SEC("fentry/bpf_local_storage_lookup")
> > +SEC("fentry/??????????????????????????") >   int BPF_PROG(on_lookup)
> 
> Remove this BPF_PROG.
> 
> >   {
> >   	struct task_struct *task = bpf_get_current_task_btf();
> > diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> > index 4542dc683b44..d73b33a4c153 100644
> > --- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> > +++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> > @@ -27,7 +27,7 @@ struct {
> >   	__type(value, long);
> >   } map_b SEC(".maps");
> > -SEC("fentry/bpf_local_storage_lookup")
> > +SEC("fentry/??????????????????????????")
> 
> Same here. The checks related to on_lookup in
> prog_tests/task_local_storage.c need to be removed also.
> 
> >   int BPF_PROG(on_lookup)
> >   {
> >   	struct task_struct *task = bpf_get_current_task_btf();
> 

Thanks,
-- Marco

