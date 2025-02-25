Return-Path: <linux-kselftest+bounces-27400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C696FA4328A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 02:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7463B4A2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF857C9F;
	Tue, 25 Feb 2025 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="yhRcTsfc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C906EB4C;
	Tue, 25 Feb 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447698; cv=none; b=RSdgdGIRmGYKZIA17v0zL97XQpKJG4Z00Iw0l6xn5NTV3aaRqmOQZwKXJnJXLClwr2eoFu/HmxBFeeNFwMVaEzG2FDPVjiPYoDy9BhEOu74GAOvu9osssu64wiQXgtLSLf3JMtgYQXAhXOiDBCKnNEFIDcOAeM1Y5+DtGGK6BTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447698; c=relaxed/simple;
	bh=g6aUaTojdNvf/YcN3Weqm/NHumO0uO2W45Rn+zfqbbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R99XOdJyMgYlWtQfSBVc5k4mtM/MrB86Vg5pOGwB5EaQsGNq2wpTAJ+tqElFX3hEaSGtitg/x4UfSU9DsLjkBtsWBTWXiGN6sOnU1KBdQmxcuDA2PDrgtGo8BKND7H13UP4jyrJpxTRXWLrXt1brrdj1fGK3BLMwVcEd1OIXMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=yhRcTsfc; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLj3tF002668;
	Tue, 25 Feb 2025 01:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=C3dnc16gEIyGpwzy8St3qAXWKJxIdmhRQXzAy2TPXcI=; b=yhRc
	TsfcFnQza8lU8dnqTnhrjd82usIvrtEsdz8PV8UOGFWcUfcP5AvUlVCLwOFeooW2
	vI71ELfALo5GOA2+9QYpNYH2rtEtu8c7QzcMAXlS1bd+bSIanpesmpsJuPFfrypT
	1HuF2kNu3BbJmjzCKjz3Ga4SdpxasIZ/PXxJsqkkM1FdQOAcCideoJRaPjKQI/+E
	dKgJyGUs8mr+i4Ieqmg+bd36PlwRQbNtsBYDCgkabrR04OhJQvtyVXajc0VsMmnv
	Cv/Zt/y4s/TjYItzaYJukESD+bWM8BiSLR+PGoLk1P82/QvljPslm+WphUq0in6U
	ZO8kVLl8Jo2Mh4TBfA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 450vxnhgb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 01:12:39 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 01:12:33 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <andrii.nakryiko@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mark.fontana@crowdstrike.com>, <martin.kelly@crowdstrike.com>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: Re: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
Date: Tue, 25 Feb 2025 12:12:31 +1100
Message-ID: <20250225011231.27681-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com>
References: <CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=MM6amNZl c=1 sm=1 tr=0 ts=67bd1907 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=P-IC7800AAAA:8 a=YdVmfgTgZjZG2QomKWsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: guqdbejqgUvRNFYOP4EUwJSqXeGbtK_B
X-Proofpoint-ORIG-GUID: guqdbejqgUvRNFYOP4EUwJSqXeGbtK_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250006

This reply was resent as the previous email had a missing In-Reply-To
in the header.

> > > On Mon, 2025-02-10 at 16:06 -0800, Andrii Nakryiko wrote:
> > > > Tracking associated maps for a program is not necessary. As long as
> > > > the last BPF program using the BPF map is unloaded, the kernel will
> > > > automatically free not-anymore-referenced BPF map. Note that
> > > > bpf_object itself will keep FDs for BPF maps, so you'd need to make
> > > > sure to do bpf_object__close() to release those references.
> > > >
> > > > But if you are going to ask to re-create BPF maps next time BPF
> > > > program is loaded... Well, I'll say you are asking for a bit too >
> > > > much,
> > > > tbh. If you want to be *that* sophisticated, it shouldn't be too
> > > > hard
> > > > for you to get all this information from BPF program's
> > > > instructions.
> > > >
> >
> > We really are that sophisticated (see below for more details). We could
> > scan program instructions, but we'd then tie our logic to BPF
> > implementation details and duplicate logic already present in libbpf
> > implementation details and duplicate logic already present in libbpf
> > (https://elixir.bootlin.com/linux/v6.13.2/source/tools/lib/bpf/libbpf.c#L=
6087
> > ). Obviously this *can* be done but it's not at all ideal from an
> > application perspective.
> >
>
>
> I agree it's not ideal, but it's also not some complicated and
> bound-to-be-changed logic. What you point out in libbpf source code is
> a bit different thing, reality is much simpler. Only so-called ldimm64
> instruction (BPF_LD | BPF_IMM | BPF_DW opcode) can be referencing map
> FD, so analysing this is borderline trivial. And this is part of BPF
> ISA, so not going to change.


Our approach is to associate an array of maps as a property with each
BPF program, this property is initialised at the relocation stage.
So, we do not need to parse BPF program instructions. Instead, we rely on
recorded relocations. I think this is a more robust and clean solution with
advantage of all code in the same place and being at the higher level of
abstraction with a relocation table.

The mainline libbpf keeps array of maps for a bpf_object, we extended
this by adding an array of maps associated with each bpf_program.

For example, a code excerpt, from our development branch, which associates
a map with bpf_program at relocation phase:

     insn[0].src_reg = BPF_PSEUDO_MAP_FD;
     insn[0].imm = map->fd;
     err = bpf_program__add_map(prog, map);


> > > > > >
> > > > bpf_object is the unit of coherence in libbpf, so I don't see us
> > > > refcounting maps between bpf_objects. Kernel is doing refcounting
> > > > based on FDs, so see if you can use that.
> > > >
> >
> > I can understand that. That said, I think if there's no logic across
> > objects, and bpf_object access is not thread-safe, it puts us into a
> > tough situation:
> > - Complex refcounting, code scanning, etc to keep consistency when
> > manipulating maps used by multiple programs.
> > - Parallel loading not being well-balanced, if we split programs across
> > objects.
> >
> > We could alternatively write our own custom loader, but then we’d have
> > to duplicate much of the useful logic that libbpf already implements:
> > skeleton generation, map/program association, embedding programs into
> > ELFs, loading logic and kernel probing, etc. We’d like some way to
> > handle dynamic/parallel loading without having to replicate all the
> > advantages libbpf grants us.
> >
>
>
> Yeah, I can understand that as well, but bpf_object's single-threaded
> design and the fact that bpf_object__load is kind of the final step
> where programs are loaded (or not) is pretty backed in. I don't see
> bpf_object becoming multi-threaded.


We understood this, but the current bpf_object design allowed us to use
it in a multithreaded environment with minor modification for bpf_program
load.

We understand that the design choice of libbpf being single threaded
is unlikely to be reconsidered.


> > > > > >
> > > > bpf_object is the unit of coherence in libbpf, so I don't see us
> > > > refcounting maps between bpf_objects. Kernel is doing refcounting
> > > > based on FDs, so see if you can use that.
> > > >
> >
> > I can understand that. That said, I think if there's no logic across
> > objects, and bpf_object access is not thread-safe, it puts us into a
> > tough situation:
> > - Complex refcounting, code scanning, etc to keep consistency when
> > manipulating maps used by multiple programs.
> > - Parallel loading not being well-balanced, if we split programs across
> > objects.
> >
> > We could alternatively write our own custom loader, but then we’d have
> > to duplicate much of the useful logic that libbpf already implements:
> > skeleton generation, map/program association, embedding programs into
> > ELFs, loading logic and kernel probing, etc. We’d like some way to
> > handle dynamic/parallel loading without having to replicate all the
> > advantages libbpf grants us.
> >
>
>
> Yeah, I can understand that as well, but bpf_object's single-threaded
> design and the fact that bpf_object__load is kind of the final step
> where programs are loaded (or not) is pretty backed in. I don't see
> bpf_object becoming multi-threaded. The dynamic program
> loading/unloading/loading again is something that I can't yet justify,
> tbh.
>
>
> So the best I can propose you is to use libbpf's skeleton and
> bpf_object concept for, effectively, ELF handling, relocations, all
> the preparations up to loading BPF programs. And after that you can
> take over loading and handling program lifetime outside of bpf_object.
>
>
> Dynamic map creation after bpf_object__load() I think is completely
> outside of the scope and you'll have to solve this problem for
> yourself. I would point out, though, that internally libbpf already
> switched to sort-of pre-creating stable FDs for maps before they are
> actually created in the kernel. So it's conceivable that we can have
> more granularity in bpf_object preparation. I.e., first step would be
> to parse ELF and handle relocations, prepare everything. After that we
> can have a step to create maps, and then another one to create
> programs. Usually people would do all that, but you can stop right
> before maps creation or before program creation, whatever fits your
> use case better.
>
>
> The key is that program instructions will be final and won't need
> adjustments regardless of maps actually being created or not. FDs, as
> I mentioned, are stable regardless.


We used this in our design, so we did not need to scan BPF program
instructions to fix map's fds referenced by instructions from a dynamically
loaded bpf_program with dynamically created maps.


> >
> > The use case here is that our security monitoring agent leverages eBPF
> > as its foundational technology to gather telemetry from the kernel. As
> > part of that, we hook many different kernel subsystems (process,
> > memory, filesystem, network, etc), tying them together and tracking
> > with maps. So we legitimately have a very large number of programs all
> > doing different work. For products of this scale, it increases security
> > and performance to load this set of programs and their maps in an
> > optimized, parallel fashion and subsequently change the loaded set of
> > programs and maps dynamically without disturbing the rest of the
> > application.
>
>
> Yes, makes sense. You'll need to decide for yourself if it's actually
> more meaningful to split those 200 programs into independent
> bpf_objects by features, and be rigorous about sharing state (maps)
> through bpf_map__reuse_fd(), which would allow to parallelize loading
> within confines of existing libbpf APIs. Or you can be a bit more
> low-level with program loading outside of bpf_object API, as I
> described above.

Yes, this can be one of the ways to share bpf maps across multiple
bpf_objects and use existing libbpf for parallel bps programs loading,
if we want to keep a full libbpf compatibility, but at a cost of
complicating design, as we need to convert a single bpf_object model
to multiple bpf_objects with a new layer that manages these bpf_objects.

In our case, as a bpf_program can map to multiple features, which can be
modified independently, and to achieve an even load balancing across
multiple threads, it would be probably one bpf_program for a bpf_object.





