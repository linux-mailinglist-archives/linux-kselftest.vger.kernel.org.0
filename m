Return-Path: <linux-kselftest+bounces-13309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D7929F87
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3641C23915
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C56F2FD;
	Mon,  8 Jul 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMiGYhQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB959147;
	Mon,  8 Jul 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432234; cv=none; b=aDfOkoJ/PBXSPmwoTTiMKMX0O4xU+Odxo3syclnCGHT4atfHvsd6uYeo/lOmhoz4ZWv9/9WrcnLfJBjZfx1nSQNAFl1O13redMwtz5s1/KsLOTvd3iTBFkp9hVWvroJkeqEFRZC9BU7gGcl5FEJ6T727O+dMGma3PvceCHyC9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432234; c=relaxed/simple;
	bh=2y9H3SO2wCdXIiNfeB+qTTwx0ye8jxOfoT4WBoPfuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh4CRAMf24CfmQYD0g3/F+xAZIZWl1sAyUPhBBBlF5Y9Kmj6tvRh6IQhy/FrSqJI01W7moYN7Q4h0RKXewdFJtSEKyerg58MESRrNjcV7xf5XFT+Uy4LrEQH9IcSzrJz2j7bXMMPJ/g41W+vrHvPI3RzTwoe4pCs38EHzN6/tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMiGYhQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E3C116B1;
	Mon,  8 Jul 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720432234;
	bh=2y9H3SO2wCdXIiNfeB+qTTwx0ye8jxOfoT4WBoPfuyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMiGYhQTIu3esIEvb6A7nczpYsFsSqa+zNuJyOWfuwd7lPCt053+9oVdEqcm5NPoq
	 F3FnAtK+O6qtPz/lROwRrtzqVmv70OYNJiuBSZlSekKXJxjcbDamJhTVfGlKzpRNWY
	 CuJLjZcSmzv7V2FNJOPjbNk1Byei31X2f7D2nNrB8y6A5sTd0Epp9PNhZuG3xA5eQG
	 PdwTvMpRz8vKgsi9xbpCKeOqtHhqhghJgaZFFCuoPI6QYw6UEkRAfwSTQEXxfk6PPt
	 B76obI8SzP5+W0EWfA7w1gISUgTx0ueTfvconufUessLaX1CsbeAy4Nwc2vY3Ps3vO
	 wbnIhFXg+sbvw==
Date: Mon, 8 Jul 2024 11:50:27 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: amend for wrong
 bpf_wq_set_callback_impl signature
Message-ID: <6emjbxxw63ujlyvdodotvvuoo3pcr32y73ilaarquksfguz4bo@2wkdzokk2huk>
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org>
 <20240705-fix-wq-v1-2-91b4d82cd825@kernel.org>
 <9742abda93ae2d90148f54b585adc825e55a1a38.camel@gmail.com>
 <CAADnVQLvWHd9i0tcTib5cO=AGJN2EG5cCrV02FsLu9JRe54_zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvWHd9i0tcTib5cO=AGJN2EG5cCrV02FsLu9JRe54_zg@mail.gmail.com>

On Jul 06 2024, Alexei Starovoitov wrote:
> On Fri, Jul 5, 2024 at 1:54 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Fri, 2024-07-05 at 15:44 +0200, Benjamin Tissoires wrote:
> > > See the previous patch: the API was wrong, we were provided the pointer
> > > to the value, not the actual struct bpf_wq *.
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> >
> > Would it make sense to update one of the tests, so that it checks the
> > specific value put in the map?
> > E.g. extend struct elem:
> >
> > struct elem {
> >         int answer_to_the_ultimate_question;
> >         struct bpf_wq w;
> > };
> >
> > And put something in there?
> 
> +1
> let's tweak the selftest.

OK, v2 it is then :)

Cheers,
Benjamin

