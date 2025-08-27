Return-Path: <linux-kselftest+bounces-40034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD8B37ADE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 08:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F3362701
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79B275AED;
	Wed, 27 Aug 2025 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dCFVyUgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B651DB546
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277684; cv=none; b=SkomXqAeQ08ntFUdtoCfv/lqjUWtlmDUhOX/kEJSPSElMt/O5kiKcY8daOZqYTVJrRLmU9tVLggv5dn8z79/Z6Y6YR9b1vfecpYgKOaC41IMH2lZAmApe0lyvhVi8r0w9TIPzy7Zklf006jayvRYY/GKcYIPUFU3uJHTWrl3LEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277684; c=relaxed/simple;
	bh=skkMaqJJ+U3kGklh+BMpgZ/SHZGzQXad2rHRCM6J5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuF+RRURZxUvb6hhl68DZT39wCbApUXl+HoFWahIp6Zsso/cStxrRUDFuWqvqBtyiakRewkXnHS/B5Bf6D8YQOFWWwiK+uN2+sNTbzuEgrOsmWVFHv+RdnobfD3dzzzckL4GCQlzyGyRM8WD4+ONmnJROMMOHuR/xGDjkjseEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dCFVyUgy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756277678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skkMaqJJ+U3kGklh+BMpgZ/SHZGzQXad2rHRCM6J5RQ=;
	b=dCFVyUgyh81T2anCnyTj3HBh4+W2MO8awED6tEyqwZtQkNrFE+npdx0pEcv80PpedYvjBZ
	FReaeZ0w8I/OMgVdpyvFRzsTtUMLbI9qiG0HoDLgOudSuOhwNK9Ha2uEAeKQSOXYMz1Vtk
	HZeRxL8KTmnz4ipOQ79uKkojEwvCQH0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, yikai.lin@vivo.com,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 3/3] selftests/bpf: add benchmark testing for
 kprobe-multi-all
Date: Wed, 27 Aug 2025 14:54:29 +0800
Message-ID: <6338236.lOV4Wx5bFT@7940hx>
In-Reply-To: <aK4BiJduYDsw7e0m@krava>
References:
 <20250826080430.79043-1-dongml2@chinatelecom.cn>
 <20250826080430.79043-4-dongml2@chinatelecom.cn> <aK4BiJduYDsw7e0m@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025=E5=B9=B48=E6=9C=8827=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=89 02:48 Jiri=
 Olsa <olsajiri@gmail.com> write:
> On Tue, Aug 26, 2025 at 04:04:30PM +0800, Menglong Dong wrote:
> > For now, the benchmark for kprobe-multi is single, which means there is
> > only 1 function is hooked during testing. Add the testing
> > "kprobe-multi-all", which will hook all the kernel functions during
> > the benchmark. And the "kretprobe-multi-all" is added too.
>=20
> hi,
> fyi this bench causes panic on my setup.. very silent, so not sure
> yet which function we should blacklist next, attaching my .config
>=20

Yeah, I can reproduce it easily with your config. Let me have a
debug on this problem.

Thanks!
Menglong Dong

> jirka
>=20




