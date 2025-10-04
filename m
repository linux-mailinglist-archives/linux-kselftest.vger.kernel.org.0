Return-Path: <linux-kselftest+bounces-42760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B6BB8EC2
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4095519C0635
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F9221DB3;
	Sat,  4 Oct 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgUGJyU9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42021E098
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588120; cv=none; b=KV/1tPyOVYcaX4fonVfjL2pJF3MW6mgVYsG1tLr2fH8ekBsDuSNG6e85Dsvq8sHawqUYmlr4wgFbjVEg0nvz6wPMkhfrYE+w/irvA2RwCHo42gNYRMChBGtexAyZ0oy8KvdE6RD1MPoXvtNabsw9EI4AhHc1NdJPV9/oRagdcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588120; c=relaxed/simple;
	bh=ojfKhhX/8wUyfMb+0xl3q5bck6Je10S6jxPo6lslJEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/X0vzoz9qtUgJHKYZJK4PCyaLqgYw8B20bGdD8v4ZPtC3xMxC7CPgrGDuRh9DI/5B3KJ9bhdjI4k2hDbYYnNOB3PDh8iWX0m9LjWh25Xl6BN1D5rnaZbPlm5c2wjIXBjVkBcVEOZYGl4CQ9/9bZO8F5zv/0HkWYpx7LZ1Wug8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgUGJyU9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so19630825e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Oct 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759588116; x=1760192916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=HgUGJyU9lY9XfMmR5jKWeDUi6m6Zz7B8cOMokwD14swueHss1J3cQZNw/fTghgopFf
         pNxCKAn5MK6a5x5sWvxwHG4yGeOxNoO7IBR7PThtpXXPHQRl63H9HS2kd9egqr4JD4ix
         wjHQtKTfRf8lwNFdlrD1w2AmqnntF92gs26RXr1r8YDvrthCMUJapVc6hsRl4pH5mBhi
         Mz1CCjxovOK3WncCW0SXUq+dsrrF7debagSsE2fL6c3RyGG6abNeGVxTD9OwAHHZOJDV
         p10Ir8KMYAN12HV29Wu3pv4qevyU5fA1+XItfJver/MbWsHiRjHVcYGGsBqEJZD8KxdK
         pgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588116; x=1760192916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=FSejtPO0gzVNgGVdGQ/vj2IXsp9sD9908d9HHKgtBIl8lDbvBDArhtwPJDq12PM5Lf
         yS3s/mFLpZtBCLZOu/v1x7qzhBksJgTevdlaTrYOGHl7s1dRxmmuzwNPcRcBXFXuEJ8R
         ai52weC6hvnMssSzUvnBqy4j7sVoyWIz1nygoh3fYCqNCfP9sgwEOUxoJEr3mU9EpenD
         BBvhEDvI7CUmPFowKlX/xckmC9jWgdyJkSHv++GVJQDiss/8DiusHyrEJoLxqWJ2d2cf
         f0tSp82nXCHRksCgBVqb9t0W2A9PxhlpXHDwcGjsz5etZ3TB3Edhr3rTVRi8E0O/WmqW
         Iy9g==
X-Forwarded-Encrypted: i=1; AJvYcCU8l/WALhj1YQEurcf+r/gpxF0xKA+PF4ngyGUcF8twlnEOIU9vbLq+a2w7eceleiYr8e25SpyOznTox7bbyK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6Spfi3JYjjMBa5+Axby/mnA58Wz0p0S/+w1KiPbUxmQavuQ5
	oUUSMaxEb3Wcl+QD5lPTxq/1nF6WrxmEsAcarclZrs16VnMV40dcb4l3Q9dtyXPxCtpxM4GNTXl
	GdTwaBmzgut03N1zjymcjUKw6rkTmzs8=
X-Gm-Gg: ASbGnct8kZIGfUQFcjXwm02tzRkMm/jKFYtq1XXUTaXoJvggSRZ0nKToyOGALcmQXMp
	tbYvJQtkuyQ+7oj/weIpB90xstNyTl8vps7FtRXfD2vopNgjiKeOTpxzVZxPd+U2cKDZdqhdTFb
	xuuGBqahBMqkbTIs/evgyajOurnG4RSzXxQ3qYnEZUo3srYeGJYqAsTHv2aWA4aTeGbKMcrARrS
	kP2mT3RJIn2tzcTBpNuvXt2yyONVSfLzfCFFrJTnEyT0A3Q2c8GUssiJUcr
X-Google-Smtp-Source: AGHT+IE4Og6jwiPBBmHNkCPbBDPgBPqP5LwHuX1iUxTwECiL+8Mx2MUFp14C8Hb8qOdMhIteAMZP/szUC0EtCxKPQzg=
X-Received: by 2002:a05:6000:2dc3:b0:425:58d0:483b with SMTP id
 ffacd0b85a97d-425671ab837mr4385671f8f.45.1759588115404; Sat, 04 Oct 2025
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759584052.git.rongtao@cestc.cn> <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
In-Reply-To: <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 07:28:24 -0700
X-Gm-Features: AS18NWCncY86K82MEOsvI4_LR56kfq3c6aMGWJWk4LCNmAzvAbhcCXDAaeximk8
Message-ID: <CAADnVQ+iERbZZ35CbPRamMqEu32ptEAXL0OQAhansfzBX+HDKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Rong Tao <rongtao@cestc.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:37=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, si=
ze_t len)
> +__bpf_kfunc int __bpf_strnstr(const char *s1, const char *s2, size_t len=
,
> +                                                         bool ignore_cas=
e)
>  {

Still __bpf_kfunc ?

pw-bot: cr

