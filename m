Return-Path: <linux-kselftest+bounces-11504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736B9013A7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D890C1F21F7B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBA22F17;
	Sat,  8 Jun 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EZ71DIVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuI1V7Th"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5F1C698;
	Sat,  8 Jun 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881793; cv=none; b=hVMkzkGm83Lria9u9mjWcxjuT0vq1vqQGzLDgn6TgsmaWDyurO1otaL3/6ODoM02RwdJ3jx5B0V0O1tK7rpxCsx52iCdHT+8m/yfLR168Yeh7tjI8/bP4eYrfm0035oo+ONAsKeX6hKsy7DaplDpdIYAiIjDUF558+aUlORyxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881793; c=relaxed/simple;
	bh=nPpfHqjB8ECJoQcQxd81rwO8kyHOA7R3sHnvHxyFwHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPi9tTBVGEVwjmIu1lmqy+Bnl+YhwQRRbCAlcvtgm8ZcBIuVzmBB0kMIIcyjBsTqLgkjUjzqthV7wanWYJiXMsme/PMbUNVQXySZg1ezSe3dGHVCfY+5KkV4F/y1NX379zFXiKbwUjOma53Sal65Wp4E6eQsIVcMmZCSzSKPDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=EZ71DIVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuI1V7Th; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 10B9C1800097;
	Sat,  8 Jun 2024 17:23:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 08 Jun 2024 17:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717881789; x=1717968189; bh=yYg7wzIf8U
	Ce8+qz6R6GMATvHmkISuN1P+RUeT4wo50=; b=EZ71DIVyNH9rjssYyLvsTPGhGq
	rhgZfMsRKOmKw2eTO0ApVIJiLrVEUAhgXJk4MtCH/Aj1z7rmnV5lhlpxZtYE1bXt
	3VoPSegW4N2PNFQSIOSes2nfil4yrJVtybtjeDMzSupUmjwuqdRgIw3FQOmhy9so
	mhazy17eIMttZZvBw1qq+/fYU4c3jKeM1Z6RaRq4CwyQKoMZyCetDg4RLOiWg7Go
	SgOhcBR+FebK6eHm14n4ZtVUhTfnsCYF8QK6MeBshGv+xfmIeSq8F9UlW1qPeGjc
	xa7KloZz3aEC6Wbxuf8w4C1+QL54Gs39GMrktNinomyosGRN78AEU+qyY1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717881789; x=1717968189; bh=yYg7wzIf8UCe8+qz6R6GMATvHmkI
	SuN1P+RUeT4wo50=; b=OuI1V7ThYhR87o9tdmTKzKGRr5LNmMRdCrzGUfnYHkKu
	cKpGd3voCTHpqMqxfaMWG+TKlZW7EGNoXrQ3/Wo0HrfSSedk8GZ6t3yNiihFytJl
	XZezf6r4wsDDeQB30xo3+eC04YwKXVNcLwgh3a+S37gdd+ojfXh8O9Ju561TEmUf
	neh+EKqm+TSaawpLZ7+oQyCHqfe2rdW45gnQ+w+TSv+ZL2yWkOFyhk27kpaBQIRK
	RQ/SslrwN76apqhhAHVzU8qfVAPkrKbLBcd6GGx9QDeA9sh9NMJGvgXOnmdAoJqr
	b8c0yG8elDiacJjrE6kSOJddEftfeFAAEsRtZQqtBQ==
X-ME-Sender: <xms:vctkZi_ZJou4ViJXB0GLAI2FxYEa93h83llvqELmeDRfOS4KGtOZsQ>
    <xme:vctkZivP9GfrfT_T1Jkx6EOY4yTJamoq44eucpYgx1PK21xNKvJVeJPjS_rrcM8T7
    lxJwiD6TPowgnsvwg>
X-ME-Received: <xmr:vctkZoAvYXIehuvjywTIQK1HPjJEc8FdSw2nPfLobgaGJPYOJhtrX_Y1AjlPU05pM0GX7l5VMc-uSAcFw2CkcFqZuza2P3rf3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdejkeduleeitedvfe
    egvdegjeehhfdvgffgjeduuedtgeevieevtdfhheefleeknecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:vctkZqel8RJnfssnLySoE6DfrGKmzXHihudZe2AAUNa1sg3rmBITOA>
    <xmx:vctkZnNW7--PBrfyGjsqeNptdRUfBnjjwZcyKy-eAFiWLnU-LnusoQ>
    <xmx:vctkZkm9fR0U_LnkVUfQDnyyIwSArCPAUB-mYHU_FpVfejhu9eGkUQ>
    <xmx:vctkZpu_gsaXF8A8VL-_WqnLEkmkvZbFJEw0a4-_5Cd66OxVEKaoww>
    <xmx:vctkZumlfhUgr33CAQiTNZf9iBaPdvHw09-p0crfWlLi_eAHeql01SLZ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:23:08 -0400 (EDT)
Date: Sat, 8 Jun 2024 15:23:07 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fsverity@lists.linux.dev, andrii@kernel.org, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, acme@kernel.org, eddyz87@gmail.com
Cc: kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 00/12] bpf: Support dumping kfunc prototypes
 from BTF
Message-ID: <u42jmbratxsej74zrtzn47j7evmdksswyrp6kfvr5tze36qcwt@mbl5e7fkekrz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>

On Sat, Jun 08, 2024 at 03:15:56PM GMT, Daniel Xu wrote:
> This patchset enables both detecting as well as dumping compilable
> prototypes for kfuncs.
> 
> The first commit instructs pahole to DECL_TAG kfuncs when available.
> This requires v1.27 or newer. v1.27 is nearing release at time of
> writing. Following this, users will be able to look at BTF inside
> vmlinux (or modules) and check if the kfunc they want is available.
> 
> The final commit teaches bpftool how to dump kfunc prototypes. This
> is done for developer convenience.
> 
> The rest of the commits are fixups to enable selftests to use the
> newly dumped kfunc prototypes. With these, selftests will regularly
> exercise the newly added codepaths.

I tested that this patchset works for both pahole:

    <1.27: https://github.com/kernel-patches/bpf/pull/7168
    >=1.27: https://github.com/kernel-patches/bpf/pull/7163

I meant to include that in the cover letter but I forgot. I'll try to
remember next time.



