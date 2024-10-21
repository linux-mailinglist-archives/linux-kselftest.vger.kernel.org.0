Return-Path: <linux-kselftest+bounces-20303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087139A90CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37801F21064
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AF1E1A16;
	Mon, 21 Oct 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f5dDGPMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD019EEC4
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541772; cv=none; b=RwN6NNShWgo4/W4R0FRuYAwUpzIhyReNWzM0U+VtgLMeI8zMyqT4hKvtBfaDu4QDjaEYnRhjIZdqgN9pH+R8xW6Rb1y2m3PWdAW24Wnyu17XjXP6AenrlNONiSD8PX08ibam0ymN6k7pyIqbr98dtISfZGUQddnEpplznsEGGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541772; c=relaxed/simple;
	bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1T+xyguyuoibI6bfB6F6wArc5TtEwbPsEThgqzQe3C7+UxfKPyZJ+z/bg94I06yesTVkVZEbyb+kpDGVTvtgpIsP4V4+wLoeky9aM+WiP8jHk/N+ydSn3Je8VYtPbr3CHr5eYE03hvBaaZ6GVE0SnUiDSi/0Sk5IkuQ3LfciOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f5dDGPMj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so1224022a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729541768; x=1730146568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
        b=f5dDGPMjPqSoTXkPFy3H57ZqHFDsZGJXZeeve2dCfL1Mr/8IVIbAUkEQQbWuZSQmyx
         oVAmwAoZoRVE8RXBs/zNpIocFpM6DI2hcTDTWzY9bzTo+l+XXrKnJBzz/Z+l8XHWImMA
         fWwNXGNeKA4HdKRFLFMUeCcmdJs9RZI8smA4YqfmWEL/MX/xHZq2zWPg+KRAf3PnzDhf
         WLIFv/pPYJYoukPMLVLeUnPC4oL3LQkFypDWr9g51lRbK8TTDzfmy+AyPQ7eceKGp5ey
         ARYUq/Djxq7LrhNedTDEkTjcw4ElgvdDfkRVBC4cWK0HhrVbFe/Ln6AZkpDE6DC2eTk/
         N8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541768; x=1730146568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFwzr5dHaLpfBFmugZgbppOyLruS2DUUmkleAkWdFGs=;
        b=NEYwHB8371RHxsJM3rgrdIDzTr1iMjAVu4ivOe/q/o5Jp1rqxS7w2+J2CSXMYqXVvi
         Z1mz0ciqq6EcudmPsX5YvvY+fpw+eEvzn6DoI1EcAcKh+p3y0qv12XFzNnesi6sIARlj
         tvWSeDGaGw6ZqeFD1hUoYcgkejQpnMYdT2xwT+18bYwjmVawd5rjlS67UGeHHmmFD1fW
         xVMOdMMgmfeh7SlHy2WFsH8QLECe3Z/LXvyOIroxfMbjB767oNGHPXENnoXVhUuxgJf+
         bU3X2ouyv/JaBYBeU7ljDSliymqORjdZiGR95l3LwmoIzBs8yt5X3z7cIRL0Ruy7XVES
         2Waw==
X-Forwarded-Encrypted: i=1; AJvYcCUvyP9vv47J13z3M6/1V9KL0XLOle5wg6EQK85RnLz87lFfNeTEGjaNfc4lPzCipyIqhSYLLQg5J4KHbbqhvOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPskABJRA4NGZANXiYMf2gRZ6AS3EFqAG4g2UF3L8ueZsEguxy
	7h1zJmbUbqUOGvY07PwLGY3UbWUh1Eis5+BOwrxazMeH30/1MKLEPSF3CKhPHRjeGyeTODwO+Gm
	8CAs=
X-Google-Smtp-Source: AGHT+IGbLDt8ZDXNCiOg6R8VCnpkVelDlKHWtxr/WdbCXV+AQpiE7tEgEa04LNydACGk9Ydg88ChrA==
X-Received: by 2002:a17:907:9711:b0:a99:ff79:51a5 with SMTP id a640c23a62f3a-a9a69772b2emr1345823966b.3.1729541768510;
        Mon, 21 Oct 2024 13:16:08 -0700 (PDT)
Received: from [192.168.3.33] (61.39.160.45.gramnet.com.br. [45.160.39.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571e3asm249542966b.147.2024.10.21.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:16:08 -0700 (PDT)
Message-ID: <985f11db4b861a7fffcc29b74f9025649cf510d3.camel@suse.com>
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a
 kprobed function
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2024 17:16:02 -0300
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
References: <20241017200132.21946-1-mvetter@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 22:01 +0200, Michael Vetter wrote:
> Thanks for all the reviews.
>=20
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.
>=20
> V4:
> Use variable for /sys/kernel/debug.
> Be consistent with "" around variables.
> Fix path in commit message to /sys/kernel/debug/kprobes/enabled.
>=20
> V3:
> Save and restore kprobe state also when test fails, by integrating it
> into setup_config() and cleanup().
> Rename SYSFS variables in a more logical way.
> Sort test modules in alphabetical order.
> Rename module description.
>=20
> V2:
> Save and restore kprobe state.

With the syntax error pointed out by Joe resolved, you can add:

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

>=20
> Michael Vetter (3):
> =C2=A0 selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
> =C2=A0 selftests: livepatch: save and restore kprobe state
> =C2=A0 selftests: livepatch: test livepatching a kprobed function
>=20
> =C2=A0tools/testing/selftests/livepatch/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +-
> =C2=A0.../testing/selftests/livepatch/functions.sh=C2=A0 | 29 +++++----
> =C2=A0.../selftests/livepatch/test-callbacks.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 24 +++----
> =C2=A0.../selftests/livepatch/test-ftrace.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../selftests/livepatch/test-kprobe.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 62
> +++++++++++++++++++
> =C2=A0.../selftests/livepatch/test-livepatch.sh=C2=A0=C2=A0=C2=A0=C2=A0 |=
 12 ++--
> =C2=A0.../testing/selftests/livepatch/test-state.sh |=C2=A0 8 +--
> =C2=A0.../selftests/livepatch/test-syscall.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../testing/selftests/livepatch/test-sysfs.sh |=C2=A0 8 +--
> =C2=A0.../selftests/livepatch/test_modules/Makefile |=C2=A0 3 +-
> =C2=A0.../livepatch/test_modules/test_klp_kprobe.c=C2=A0 | 38 +++++++++++=
+
> =C2=A011 files changed, 150 insertions(+), 41 deletions(-)
> =C2=A0create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
> =C2=A0create mode 100644
> tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
>=20


