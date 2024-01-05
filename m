Return-Path: <linux-kselftest+bounces-2669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8D8258B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FCB283D63
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CD31A61;
	Fri,  5 Jan 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Acz4kIcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9BYb8iT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9A2E823;
	Fri,  5 Jan 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 643F82B002FE;
	Fri,  5 Jan 2024 11:55:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 Jan 2024 11:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704473749; x=1704480949; bh=QW7jt9Lu7f
	ke8mG4lP5bYmPmDvOXPBpGzIUDBHIekTk=; b=Acz4kIcq6y/rMD3GdA7cQZFH/X
	t+UCDk8kiRTwuEzv4ajq3EDfufkIZkO8rGAkbX3sbhxHt16W2NOVO6gW2gQHxnZr
	G4znBN6j8ey0yPSzv+AlK6ZSJwteCnfW3d+5qDl/eg2aJTqU9Tgdw3YjZEKbWiiA
	xDjCkNbH8TatuNfFUavrE+ffldAtLl1v9baWSzFGVpUeiYCRlCeZGSoqIOyzPHvn
	QzvCgTBrCyaLUW/MlTUJL8Udfek55UMpp0KfgTZyqMYearp0x1HoJW30AG1RainQ
	7jUdJb7RD7OtoMFP4EUhEya/MWTwpfUkkKqXxvWzEKPyF0P6ySZ4aWmCm73g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704473749; x=1704480949; bh=QW7jt9Lu7fke8mG4lP5bYmPmDvOX
	PBpGzIUDBHIekTk=; b=K9BYb8iThvNsRc3uDbU2A4HF+NqmpozLE145a0RZM6s+
	HlSs93vsFRPOZ4j+D7yanP8AH1MORLgVIUDI/smsj0tgQHb1QcdzskIXumAkTdaI
	aYWKtH9GM5E2idjjTXJdHaRlRm+zABDB8nY9iGIO+T3ni/GGWRr3B/rAtlNxTMAa
	442AnTkTIKtZDG71QbRbhfRDzlUBII9A+3MGR239UuUry3gcSCza/5J8eBt8YfDp
	qSaUg0ncHYhXvJ5JLZQ2x+uSxOHpqddfG6B+3/DQ4dtJ8Bvy8Eo4uJ9FwtXpOXbS
	lAKesJFuhuTY1UEqKamWKqMwsebhP2LexY2pyWEAjQ==
X-ME-Sender: <xms:kzSYZaaAy3dR9G7HtiXxWg4Zxmeum0A9kFX20liLaKbR07SHFcyxcg>
    <xme:kzSYZdYGOayfCataHnEAMMKquFtux6p39JzrR3A07WSDo0A-s4okO5JaDREMOkZsI
    mghom6qS61yd_6_bg>
X-ME-Received: <xmr:kzSYZU-FFGlFxqtZW9JrU1DfOghSBraArHdWeqKl_bYBn4B9XbhJJcaTjNPSd7Gh34QiYd3oUUZRytJdmx23CPk7Jxq8EIEzMnNLQ-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:kzSYZcooOdkX-X1KqvlBh60yFjwUF6ho3KRoF4sCW1I-TfmvCqZcQA>
    <xmx:kzSYZVqed9r_UIcFbBgVtpyedquDrgSmBEtX74gK0NVzOv-CO9t0Wg>
    <xmx:kzSYZaTkEQUWNf-X1GtvBv5FK6CVlonQJvKyRbPer6PmkJB9Vt_cTA>
    <xmx:lTSYZXSsnZAjmPDbBJ3T6sdwqsgrrVfZBsEsu-lv1wIgRfR5oMP26phlS_0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jan 2024 11:55:44 -0500 (EST)
Date: Fri, 5 Jan 2024 09:55:43 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
 	lizefan.x@bytedance.com, Herbert Xu <herbert@gondor.apana.org.au>,
 dsahern@kernel.org, 	hannes@cmpxchg.org, rostedt@goodmis.org,
 mcoquelin.stm32@gmail.com, 	pablo@netfilter.org, martin.lau@linux.dev,
 edumazet@google.com, daniel@iogearbox.net, 	ebiggers@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, 	hawk@kernel.org,
 steffen.klassert@secunet.com, jikos@kernel.org, kuba@kernel.org,
 	fw@strlen.de, ast@kernel.org, song@kernel.org, pabeni@redhat.com,
 	shuah@kernel.org, tytso@mit.edu, tj@kernel.org, kadlec@netfilter.org,
 	davem@davemloft.net, mhiramat@kernel.org, andrii@kernel.org,
 	alexei.starovoitov@gmail.com, quentin@isovalent.com,
 alan.maguire@oracle.com, memxor@gmail.com, 	kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, 	mathieu.desnoyers@efficios.com,
 mykolal@fb.com, linux-input@vger.kernel.org,
 	linux-kernel@vger.kernel.org, fsverity@lists.linux.dev,
 bpf@vger.kernel.org, 	cgroups@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kselftest@vger.kernel.org,
 	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <4tsn6x45gh3vgdst3ozzmxori5gzylvpx6btxue6sbsmx7siok@6wajzdgwxfpa>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
 <a923e3809955bdfd2bc8d6a103c20e01f1636dbc.1704422454.git.dxu@dxuuu.xyz>
 <ZZgcJTdwMZHglPtr@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZgcJTdwMZHglPtr@krava>

On Fri, Jan 05, 2024 at 04:11:33PM +0100, Jiri Olsa wrote:
> On Thu, Jan 04, 2024 at 07:45:49PM -0700, Daniel Xu wrote:
> 
> SNIP
> 
> > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > index bf7a5f4cccaf..3969d54158d1 100644
> > --- a/fs/verity/measure.c
> > +++ b/fs/verity/measure.c
> > @@ -159,9 +159,9 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
> >  
> >  __bpf_kfunc_end_defs();
> >  
> > -BTF_SET8_START(fsverity_set_ids)
> > +BTF_KFUNCS_START(fsverity_set_ids)
> >  BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> > -BTF_SET8_END(fsverity_set_ids)
> > +BTF_KFUNCS_END(fsverity_set_ids)
> >  
> >  static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >  {
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 51e8b4bee0c8..8cc718f37a9d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7802,6 +7802,10 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
> >  {
> >  	enum btf_kfunc_hook hook;
> >  
> > +	/* All kfuncs need to be tagged as such in BTF */
> > +	if (WARN_ON(!(kset->set->flags & BTF_SET8_KFUNCS)))
> > +		return -EINVAL;
> 
> having the warning for module with wrong set8 flags seems wrong to me,
> I think we should trigger the warn only for kernel calls.. by adding
> kset->owner check in the condition above

Just checking:

The reasoning is that =m and out-of-tree modules can and should check
return code, right?

And =y modules or vmlinux-based registrations do not check return code,
so WARN() is necessary?

If so, I'd agree.

[..]

Thanks,
Daniel

