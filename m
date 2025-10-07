Return-Path: <linux-kselftest+bounces-42793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B2BBFD97
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 571BD4E10D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 00:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C491AF0BB;
	Tue,  7 Oct 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWNQ7Yzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417010957
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759796978; cv=none; b=cNHv+WVZF+bdWWPCfnXQK23u4JeTKQkeHZasdrVE/Dg1LP+6ZlQ24IViDPqoeJlIS9OPrMueAZYHcTLi7T2JhZGc5vLkbP63JLrFH7rPT6QlOdOuNBf1AidtyH7Vmgs4sm5iFrAGn5RzyzlLRfVmECw+YVCxBcHH6MAkUC2qAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759796978; c=relaxed/simple;
	bh=VhE3lEq1z32eklFQuWsYnAJ9lZnTGtD7Yhza8TRvObM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxAb3en5wCxlgOGw4qNfdVsijTdt7fvVtR8lqm1ZhLlQHI/vkxtV/7z/cR+MkvKvtwKKDbCQvqBMeodYn1i9EoKDJR7RDpcRboizWsTT2gvXhTpW0i96Kdtm2dpxjh80d0uyXRRSIpMDmeKfpWRmM/k1y/aaeSp0R2rjrrGIGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWNQ7Yzb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4914720a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759796976; x=1760401776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1hcAc7s4XhYQRH+R2s8ZmE/7qgDIwbOMHGuS8cxmck=;
        b=FWNQ7YzbPGGVtDv8QM3eamo20TyaTXxDNzZAA/9wLALc51sDgYd5+vZw8Z/cN+J/0L
         WzzjlJovjDRnsHCIBzzYwslNodV/GbKCzNZoC4ci5+3cKdIckLISeO/0+VKraWxMoCYu
         ExeWMWIySW5A0Bh1UN2cEWnVEdwoiGnsvAfWrk2l2PfVXMe4Hk/u+5B3bHsYSg8exAoL
         mvIanMj/R8f9uqpVfooHp18ROTgI9LzvKDcQ8LpPF9J0R9MVxb/3uhxZDvB7mHq7i/ce
         JDx+IcCTiNFtGqwCAMYoZieCywpKELLyMyhG5X54dcyVKQmRS15fiTA2ngWSoie1XTKB
         kpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759796976; x=1760401776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1hcAc7s4XhYQRH+R2s8ZmE/7qgDIwbOMHGuS8cxmck=;
        b=NFNDvWjcInOxaPwG8x7ogUSiozQCb3dnLkMKTI+ccy7ywNLQ2zf5xQHailz0ymENmx
         NVIzQGbRXpZRbtDKoEjw1AH/7iLrz9ssHXwiKsZLAeLqpWDIGdZGC62sNfFuhKnECxQI
         IvGg2F0bUMoW15pKRlSi4dA4+j0rDxmA6G8flrCQ7OJ6bw4ohxHfAmOG4JduAknbRobr
         bjgJQAyQ16sQ1h5clhhLPhIoQbgawdJjh6BwXNyQ/vXmCYY0jYfDDb40eOhl9Owl/Nib
         yTGTj4AWydSarztfwqgHTn+NVf6xwreklBbbs8wGFhxjEeJQhfN7Eyd5W7kjro9tVKab
         e3fA==
X-Forwarded-Encrypted: i=1; AJvYcCXXGc+lZ5nHPqAB+Khzs7Y8ZBetN7Dj7wkNZhtTML3Wa8bC7mNkFK5T5ABJhfY1ogPKHcr8FWumRJ9x8gI+0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsoeFBdetZppJs2YpSOkO6olkHiCbAX6V//+vkBYBB/5ONYTl
	RolZEG8rbYAthL/VKA4/UoLQWcCau9ss7bB21LbMso8hZlzjN5Ijw1aR
X-Gm-Gg: ASbGncuaeKpCLcAb+VTeIgbBhBQ1cQ3HyeLoazA8i0TNXa1K31Y/VtS5l/4C8HpORZ1
	13U3zcArRByRYflIjfoHaoS2r/SjFFLCEmsFC3wjvRakL0tVJaRU9WfQR4XS2fNaTkWx+JwJoNA
	2kR9eiTh8SXNWm0bEU82W1CjFCn0LQX8JmcCqzBckT+8ubKF2dN7EKHFuZeWZZro/xYyI7WveXg
	0swf4x/Txzw8h87CGz2ptgrmnbtbI98kZFRBVxPOg2DCe7RDN8G4hM9AO+BVq8qfKNY/n2++fG+
	etpuCPudeyz8IlDz1cECT+a0Hos61qPIWDE5g82JGfMG5941AXgGH4UjiefNFaXvf6/FmV3d32b
	bgSerPBDf4jYVTigOfw3hsY+CpxJPIQpI6NYLgXRqpsu9KamY3jPNSswaJwCLwDxJNboNG5Vt
X-Google-Smtp-Source: AGHT+IEHDV8lJwxzCwsyHrfSYwJV2pBhYeFFmns7zfDlhAwW+nJPp4T/QHVKbEtSEmo+3rnHX8uZ2g==
X-Received: by 2002:a17:903:3c66:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-28e9a5ec80bmr168213335ad.19.1759796976151;
        Mon, 06 Oct 2025 17:29:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d60a:adc8:135e:572b? ([2620:10d:c090:500::5:b20b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87e7sm146377475ad.82.2025.10.06.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:29:35 -0700 (PDT)
Message-ID: <405da03e33853622da3a70ad88df3396c85926e4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcasestr,bpf_strncasestr kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Rong Tao <rtoax@foxmail.com>, vmalik@redhat.com, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  "open list:BPF [GENERAL] (Safe Dynamic Programs and
 Tools)"	 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>
Date: Mon, 06 Oct 2025 17:29:33 -0700
In-Reply-To: <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
References: <cover.1759588929.git.rongtao@cestc.cn>
	 <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-04 at 22:47 +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> Add tests for new kfuncs bpf_strcasestr() and bpf_strncasestr().
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index 2e3498e37b9c..d21330b4cc3b 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -33,8 +33,12 @@ __test(11) int test_strnlen(void *ctx) { return bpf_st=
rnlen(str, 12); }
>  __test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
>  __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
>  __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "wor=
ld"); }
> +__test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasestr(=
str, "world"); }
> +__test(6) int test_strcasestr_found2(void *ctx) { return bpf_strcasestr(=
str, "WORLD"); }

Nit: I'd compress these two tests into one:
     __test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasest=
r(str, "woRLD"); }
     (and did the same for (str, "hello") variants below).

>  __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(=
str, "hi"); }
> +__test(-ENOENT) int test_strcasestr_notfound(void *ctx) { return bpf_str=
casestr(str, "hi"); }
>  __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, "");=
 }
> +__test(0) int test_strcasestr_empty(void *ctx) { return bpf_strcasestr(s=
tr, ""); }
>  __test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", ""=
, 0); }
>  __test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "=
hello", 5); }
>  __test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "=
hello", 6); }
> @@ -42,5 +46,14 @@ __test(-ENOENT) int test_strnstr_notfound1(void *ctx) =
{ return bpf_strnstr(str,
>  __test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strns=
tr(str, "hello", 4); }
>  __test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strns=
tr("", "a", 0); }
>  __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, ""=
, 1); }
> +__test(0) int test_strncasestr_found1(void *ctx) { return bpf_strncasest=
r("", "", 0); }
> +__test(0) int test_strncasestr_found2(void *ctx) { return bpf_strncasest=
r(str, "hello", 5); }
> +__test(0) int test_strncasestr_found3(void *ctx) { return bpf_strncasest=
r(str, "hello", 6); }
> +__test(0) int test_strncasestr_found4(void *ctx) { return bpf_strncasest=
r(str, "HELLO", 5); }
> +__test(0) int test_strncasestr_found5(void *ctx) { return bpf_strncasest=
r(str, "HELLO", 6); }
> +__test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_s=
trncasestr(str, "hi", 10); }
> +__test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_s=
trncasestr(str, "hello", 4); }
> +__test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
> +__test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> =20
>  char _license[] SEC("license") =3D "GPL";

