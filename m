Return-Path: <linux-kselftest+bounces-11687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F418904093
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B111C22A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC13987D;
	Tue, 11 Jun 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BVBfk5ic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7i49d1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AB3839C;
	Tue, 11 Jun 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121260; cv=none; b=mJCRQCFTOSaKmKVpSPc+U2Md9O9jPz6a7v3gio4q1W5u+e2W2kFgHraxJ1QKXmG8PEkwQPIA/7xzOKqz65CEf/QURu+i+cN7EXfAgWKi2oPQKPpMmTiYnlUBTKBefXi5uIJ6wrdDIYiq5XzcmlT+Bh0MMpJ4oW5SBZt0xJe8iVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121260; c=relaxed/simple;
	bh=VZqZaxrcAUgGpNBDDDgIyvW3HvA8U2wHvEt9CbBeF7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUfkDAYiqLUPj0X4Q7eJYV8s7AT8o8YbBTg4dMkfJ/6fL/wyOpQzcQlpEZ0THw5kCnYRreLBqBmrZn1mtjPzCFZtHlmacEL0l2UBEs4Dnf9NbgS9x7HbGmIAep2iL6EqzjeWXxxY85XGOaO93u/5x1b3ku/YBAjPVHbvm6q25ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BVBfk5ic; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7i49d1u; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id AE809200303;
	Tue, 11 Jun 2024 11:54:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 11:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718121257; x=1718128457; bh=/qwb4kBfjw
	dkZhMXnXQWoxDNl+qAk6Ti4gLEpYdSNdc=; b=BVBfk5ic+f2qYjJ21uZvb10IIW
	rRhCcp4zalutYEhnGjSgl3KAkDaIRVeXy5DECOa1CbzwGH7nNFLzgnkw724xyMwF
	8AlpMEwZ1SJVo2ckKMYeJPhDBSALCyZGNHg7hXpD6e99JVWVg8BcnDe3/InxHyCx
	aQZhlRJZgJfFPwK1KYqZ7LcaqadaqqEWlw7I4IFfWPXNeuR2Nf9C5JjaUQQQg3FR
	6KzkzPAXx9TjTORdeyyCoTgqpWQ1yj6IuNGOU87GAc05pPzKlJ9njVyx7NyhnmJ6
	12tTqMI34GTA54gx4t5QukpxuyHH4uvvDpYdT15h/slMPKeLtJZU1/xtR+Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718121257; x=1718128457; bh=/qwb4kBfjwdkZhMXnXQWoxDNl+qA
	k6Ti4gLEpYdSNdc=; b=o7i49d1unuDvyC0FuQy3Il0CvbBUUfvs1k4HQeW82jRN
	QZyESnWYoAno/+sMpWrH292CDO/eDYzkNTIHG7A8X0THfhe9olDW3nO3SG2gqx78
	zxTQVoX31uWZjtB2HfhjhWgBRjSoMTun82ZbbfMojz22Lb5KMZ+H5BQp3ZvmSCX+
	LCOLZWuBp+MQx5MXR/wdpq/uUCxqpwlZFG/eZ8gEDQupM8Xrw6rrAnJTyd6cS0IF
	DynKW4+uOFRhumli94bNSrZzxTtTqSHS57Bvs1TZc+kA4Ung2Mx+qc7autcTXcW+
	8r00SdYrFHognNW9hQK88kulcp3Jy6Pzu9lCQj7NkQ==
X-ME-Sender: <xms:KXNoZj0e20vi7dibCy4Cfnfh7QB2EpSyceUpqTGlSyi18euHuGuGrA>
    <xme:KXNoZiHKqDcNNASaxe7weqblaqv_zmrfhkH4g9tvuG_VpCIS8mcWcr129BP9YK4MT
    xEI2RuIS-KsTZnFdQ>
X-ME-Received: <xmr:KXNoZj4ORESKoI2bYikeE7c9y_G9aHYJaVK8OnLPu6hXEC21FYmeb1kQRgCRlM5BfYQskXm8qEXZ3tXEa70UnUtx338NnCGz4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:KXNoZo0w0V8slEd2LBHniQIaPzjgGBf40qadZceI3Q0O-KZEyPOaCA>
    <xmx:KXNoZmEe8AGJMvmPG6qEDMaLvehDRTFqxKVctaLxL9jgAuwUQyE7oA>
    <xmx:KXNoZp-x2i7rKw12T-RA1RPeuWktEgl30_AFTkn2TIpQUQIT9GeN4Q>
    <xmx:KXNoZjkM5IE8rnT7NmCEjp8T0_n_RAofsFnItfLBDpYVWtQWj-6NEg>
    <xmx:KXNoZk_LiqI7dVDgvDVIQVG7Q4xOvqOX3ruB1wlJZXppVt-4KnVp7Ewn>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 11:54:15 -0400 (EDT)
Date: Tue, 11 Jun 2024 09:54:14 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: shuah@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	daniel@iogearbox.net, quentin@isovalent.com, alan.maguire@oracle.com, acme@kernel.org, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix
 bpf_session_cookie() kfunc prototype
Message-ID: <chydnuotqnmamlfmgzgnwurj5flaegp2bjebxldqwc2y2ngs5x@3h4blknbqhlw>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmb52Qp__CBzbgDh@krava>

Hi Jiri,

On Mon, Jun 10, 2024 at 03:04:25PM GMT, Jiri Olsa wrote:
> On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > The prototype defined in bpf_kfuncs.h was not in line with how the
> > actual kfunc was defined. This causes compilation errors when kfunc
> > prototypes are generated from BTF.
> > 
> > Fix by aligning with actual kfunc definition.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
> >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > index be91a6919315..3b6675ab4086 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> >  				      struct bpf_key *trusted_keyring) __ksym;
> >  
> >  extern bool bpf_session_is_return(void) __ksym __weak;
> > -extern long *bpf_session_cookie(void) __ksym __weak;
> > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> 
> the original intent was to expose long instead of __u64 :-\
> 
> could we rather change the bpf_session_cookie function to return long?
> should be just return value type change

Sounds reasonable to me. I don't think the kfunc has made it to a
release yet, so perhaps if we extract this commit out as a fix to bpf
tree it can still make it into 6.10. That way we won't have to worry
about any ABI changes.

Thanks,
Daniel

