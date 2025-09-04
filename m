Return-Path: <linux-kselftest+bounces-40788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87238B440F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D5A169FAB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB0266B59;
	Thu,  4 Sep 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj5L0VLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E611FBC91;
	Thu,  4 Sep 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000932; cv=none; b=KygtOF5uLUWX6wnyCMtO3kxDU3SggHJneH8fKWuuXqDLb3v7hi58QeCp0/Qf3vYuAceaxez+Rf8rQEJRESjyo7Y7xO94l6FhEF97FXf4/miKvpQLr1GMFLLDk/GZznssCTkD78/IB/bAFgGHHFaPmfft65bNdzbiXU67IXmXpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000932; c=relaxed/simple;
	bh=+vBSXd9sOWgC5H7/jhIKwGpSzEmuCrBs94PQmADH8Q8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WN0CR0A6yFxzLCa9eJxW8ppBiAackeS/KOyv69IjlyHs3dw+G9f2oEjOevgyR24x+TOKi3LGQYpi17vmP6FPOEYsAb6/kIP6bmwGklqXlLEw8/ZWr0HBBBW/hYJ8VgEMIpLoDq7INCgMxefvVDjWawlAzek33xGUUde2F+j1BJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj5L0VLm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso945491a12.2;
        Thu, 04 Sep 2025 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757000931; x=1757605731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Av1N5aGit/P+J1Yl+2LeeoH83qS/K0Xo7Da29MOYquc=;
        b=dj5L0VLm2p4w+u7XGZufS+U+pc9Dmm0mSn/MbmXMSHCVxL28wZQ1r6fwNUYe8cCJye
         jjAenCB/8rpqDOAHPoSFiBHmB481hR1H9KAPG+Bj6jI6ZqnZhYlyZA5pyVSRgLDrsfdC
         /dl6QtKPvTdImn4tWlyB07m5rSukYqj1QrKUA4XA3WDIVYmf42wzroV+4wkjyQ7/sZ1P
         4aXzYnYZ0zS33AX3sy7uEkicRat1xwMXmuH7wav5Y5ZhANDpv0oxh5R16gzGjAqn9U6M
         UHCuNze4+rzKZVxkSV8DnKw4SiU4ZbWyZ5tfmnzAnq4LV44RPJaVOFsCXpNlryuz6Rnz
         8ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000931; x=1757605731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Av1N5aGit/P+J1Yl+2LeeoH83qS/K0Xo7Da29MOYquc=;
        b=pNR+CnlEoqSmnsvLs10Ygz4efpOTrTTJwgcKTR8ShYPSCVQb92N+Vu3InlFWA9gS1f
         mjUamxrXnrQyZ50Di/nFNJNufywe86buEtIYFSyms+t0mp2zOIQZLoClr+N+rqkPbmdB
         1Nvqb0O0cr/xJ73L5TJjMod6nURamiO9ouOURzCOTh0igQhv2N17IDu4B5P+cuLwlO1G
         WWf7c4AETr6g0Gn9MfmK0MDNBFQbY+ocCLHU+ycfx3wQMikBBYR2J6ZGWD2/ZgHVyAdY
         8MiQHN3Qz3oRESMrvJaPobOXkEUQf8i3gkIUcmx4bO/i8qUHkhP4dWGU3hMfshuN7LXI
         fc+g==
X-Forwarded-Encrypted: i=1; AJvYcCWAn2dmiY7sCFwz8kDJS5JKE2htjzmaDuIizejR8lVz9xkQt3IcuHAfc6nDO69ep3q3bmrmGAAX58saXns=@vger.kernel.org, AJvYcCWcQ8E8Kzl4VUSQsh4a7bFJCkd+uzkwejf3LAHd8i/pCsZTOJJJ0tNRCLb5zP5+e4AL47gUpY98E6y8wg69AhYl@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDbxqneaQMbOA13NIhxehR138Np0lSt965q/lO5B9txG4fmM/
	dVgaEL+mQP/qEpqT4m5v+AU3Lf+N/6615TO1z/5Te9BXLSEW++X5UJWG
X-Gm-Gg: ASbGncv/iUTeWgptqeJabgnKNYnqcdE0QXrPfKnmpf9fRZcliJ3lwnRLPTsOtoxyrJ0
	eBykzs/HibG9b/w72GwvFQ8DG8xieP/5ZpsNuy2tRePLW/GILDYivBhepxDiWIBIdVfrc/Cw4tq
	2YX4mUK3lyxg8eQB/67/nr1BHbzWyYRLL6MuTYi2Rj+tKF2BUVmW6hm6FkvitKJvQkCstva6Xdz
	KA0fFAfOeb6o+JtadozQVlmpRh1PfAV9ootrVwmN0Rg6f++GoG9m7CS5f0/fTH9r/cvHQrt+szs
	1Qxlbrly1zJcv2BwRdYD3y/k7O1rSRU0Wbt6MExp2haSWnI13wLe7sS9/q+6DVd8Sg0nzLR3lMA
	RTJLd392PolHKhjqT6DM=
X-Google-Smtp-Source: AGHT+IFvFCxcwLLfF8xIU765xduJQycqiwbtTv5fPpk1+u5jwXz+C/chGbozQDewxf+A8z/4Sew+ZA==
X-Received: by 2002:a17:903:2b0e:b0:24c:7861:2ee9 with SMTP id d9443c01a7336-24c78613106mr106139185ad.2.1757000930537;
        Thu, 04 Sep 2025 08:48:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd763948sm17925345ad.118.2025.09.04.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:48:49 -0700 (PDT)
Message-ID: <7a037c0579e1cbabb83935c05c24ddbc6bc43327.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix the invalid operand for
 instruction issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Date: Thu, 04 Sep 2025 08:48:45 -0700
In-Reply-To: <20250828020135.248869-1-yangfeng59949@163.com>
References: <20250828020135.248869-1-yangfeng59949@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 10:01 +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>=20
> The following issue occurs when compiling with clang version 17.0.6:
> progs/compute_live_registers.c:251:3: error: invalid operand for instruct=
ion
>   251 |                 "r0 =3D 1;"
>       |                 ^
> <inline asm>:1:22: note: instantiated into assembly here
>     1 |         r0 =3D 1;r2 =3D 2;if r1 & 0x7 goto +1;exit;r0 =3D r2;exit=
;
>       |                             ^
> 1 error generated.
>=20
> Use __imm_insn to fix this issue.
>=20
> Fixes: 4a4b84ba9e453 ("selftests/bpf: verify jset handling in CFG computa=
tion")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---

Hi Feng,

This message felt through cracks a bit.  It's a minor thing, of
course, but there is a legit question of how much backward we'd like
to support clang versions for the test suite.

Could you please provide some detail on your build environment,
why do you want to run the tests with older clang?

[...]

