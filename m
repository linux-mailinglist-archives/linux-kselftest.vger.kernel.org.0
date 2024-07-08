Return-Path: <linux-kselftest+bounces-13333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CEF92AA0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C21F2162A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BB14A60C;
	Mon,  8 Jul 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gylCo7ed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E93146016;
	Mon,  8 Jul 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468070; cv=none; b=lB+cIE0T3x2lyHBFnOnODrFIaz58WLzdpKxKnj61SYLhW+q2BThNDV4zDHtMujkYLCR/OKGLVZZDR8NzWBLNdosL/nUVKBsaPWiNZ821s3lVQ7nhfezQjPn2L0erCoBVzmImNd3mBdW9xiUhOKF5+IJTP0X5mIW8T2dvXmfhj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468070; c=relaxed/simple;
	bh=+idKtDjFWW5fqejAcGY81KlXjU0hAWtBznBLhDe2Yfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em1F0A7GXU/YhqwhneOZjfOFdpFfCkahrOolF30m9FqKIJ5o8WJMQwQCDq4VBzmpd4YcEqaE6LWoGTNiwisPcZEQu4WUukrQ+wGqQ8U88U+HO2F9JCSGZzdyo/8RIX8geu/Ip9MOP97KBKvotG+fCILiXVLRVq6O7TedOvMN3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gylCo7ed; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so2054668b3a.2;
        Mon, 08 Jul 2024 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720468068; x=1721072868; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgbXhf3pDi2we/WS/SNjA0Rotql0/JZdyvgd0kN5iZ4=;
        b=gylCo7edTkix0lVhMmipllZzaXdau40BGor4JzTyS0cwu3cxOlODmMiLhjtlAgNEH4
         yfaHBE//ra0Y7NRiNSZ5+PptCxsBv1DzpChfAEYaEkxKkdh2KyRwJIkJysGpN3aY2iw7
         4sC/3AWaAQfwNDN2rp8S3QQczYyLkKwmwUbBc/QW4hLJz5DIFc1QHR87GFP/1WpddIyG
         RKGOWqOlpE1hcDAG+qQY7ZY9qoH2Q09Gi27qeAeW7umAs33PukJHe1fJ2NswC84JJWiJ
         PJ5tcQYBtahzVOpoK2AeHloefsYpCYNE5pCWINCxp91R6xHfGcTfqZ3afRcYoxZBeQxH
         tsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468068; x=1721072868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgbXhf3pDi2we/WS/SNjA0Rotql0/JZdyvgd0kN5iZ4=;
        b=InJIWamgt6wUVMoRRrye1boG1abskoSFhp7CMeRT08IqBt3GroHDbBslCi7Z2hPEoV
         Z706t9aIWrPA4yjKuzcZkcYKlAe/rkSd4JqIx7YCBZ1x5gBv5Yvr2x63SMwide7yqcP3
         IL9vVKCeLiGyhhC1hJodJo1PRjQdviafqNHtWqt6hgKEkIKdF2ZLc4NM3u3S+UTFy1DW
         RvVTKQ7cpcrhPe7MxVCTThAcSUXczQgy5v1jMhZocUBe9CQkDvWNAjmLPksSqrYHkWhr
         fgt/bVi9hFhOeLRd2Sp+I2NY5+/zYCdujESENoy9vsVoGjUMN11naaOSNNcMesS5cAiS
         nGaw==
X-Forwarded-Encrypted: i=1; AJvYcCWHHhlJa1C8VtQNDujgacZz8erFaZalCVb3iQG7+nelDbfc8J/vVUkYY9zLgYXGNZmvRdbM1APPQFnWcE6QqZdJ4PvjE1tmfHpH1BYKWoNFerN6lnkWXUFSEmx5MDp2M4N0qV4C
X-Gm-Message-State: AOJu0YxlFeMd9YvXcXja6yYQkWQc3MLRO8TbO4y3N39WNZHpgYLuPj58
	Je/OBDFHVu6mYHoRBH3+rs/LT6l3OEu6gzFL7VHwkBVtpx/xqtOc
X-Google-Smtp-Source: AGHT+IHVT7OrbB0hyz5rmkWRD3dhD4RlTNxveGyU4FVfdNioybYv9YBO2Cfl0mzytcb96GLGa70Iyw==
X-Received: by 2002:a05:6a21:3393:b0:1be:ce69:ca5f with SMTP id adf61e73a8af0-1c29820b7dbmr525967637.1.1720468067874;
        Mon, 08 Jul 2024 12:47:47 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a951825sm8597239a91.14.2024.07.08.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:47:47 -0700 (PDT)
Message-ID: <57342e8b8ca1c82d57d78335a73d465f16a41811.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] selftests/bpf: Skip ENOTSUPP in
 ASSERT_OK
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Geliang Tang
	 <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 08 Jul 2024 12:47:41 -0700
In-Reply-To: <CAEf4BzZ=df1LZrNh90UXURm0DOm1D12MkWKF+D6uTsiQG4rsDg@mail.gmail.com>
References: <cover.1720146231.git.tanggeliang@kylinos.cn>
	 <f6773559686a553269d84870eb23142e2dc1dc8c.1720146231.git.tanggeliang@kylinos.cn>
	 <CAEf4BzZ=df1LZrNh90UXURm0DOm1D12MkWKF+D6uTsiQG4rsDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 11:54 -0700, Andrii Nakryiko wrote:
> On Thu, Jul 4, 2024 at 7:38=E2=80=AFPM Geliang Tang <geliang@kernel.org> =
wrote:
> >=20
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Just like handling ENOTSUPP in test_lsm_cgroup_functional(), this patch
> > adds a new helper test_progs_get_error() to check whether the input err=
or
> > is ENOTSUPP (524) or ENOTSUP (95). If it is, invoke test__skip() to ski=
p
> > the test instead of using test__fail().
> >=20
> > Use this helper in ASSERT_OK() before invoking CHECK() macro.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../selftests/bpf/prog_tests/lsm_cgroup.c     |  6 +----
> >  tools/testing/selftests/bpf/test_progs.h      | 23 +++++++++++++++++--
> >  2 files changed, 22 insertions(+), 7 deletions(-)
> >=20
>=20
> I haven't followed these patch sets, but no, let's not add magical
> special error codes handling into ASSERT_xxx() macros.

I agree with Andrii here.
You might use -d (denylist) option for test_progs to filter out test
cases you know are not supported.

[...]

