Return-Path: <linux-kselftest+bounces-47001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4BECA3A24
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E3E300FFA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569033FE08;
	Thu,  4 Dec 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsrNw45S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D033EAFF
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851948; cv=none; b=u1ngnQtNgWTK0Rb3L7eZEfyaIZOfwmMt5cCcZDnGt2UHW4YMoN1cmR0bxtuIgeGA0/Du/0TLmzaP8Sg28oASTAI2eKgV/pkxpgEeKIMfisNSiIk+fXy9rvTwU3b33SHfGiamCuOaAAwnwBCH5xVC/mU4Wxd4bX2OgD/5Q7/Rn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851948; c=relaxed/simple;
	bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3a5sFf+xelrHuKF6m5Tn4BWTgRN4omBawst/G62DPbE6oPyBoOz5lnfYm9w1NvOxcgWqh2KizyTiJH2FYlMlhUqwGJAfkApEgAcfqBjiI1zt5/l3CLh7+IUMm9Le+z/PF3z/bIcnb9pAZB1Bjl+sUu7vZHmhU6eiNvc5l5vzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsrNw45S; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640e065991dso619512d50.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764851946; x=1765456746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=HsrNw45Sw0qZhJpdlG/WgjH3nlhIEkm4EdpLNBUykie9ug5/9q1aG+EeLU1bc02nPm
         UUnXoFh601CHrbCpbStdpXOf05pyoBCWDH6ZTSXL8c2GpO7HhfpSfARkqY4JIp9biDRT
         vXJIOWL+UiwXR1H30L26SUeflgcBWUIrq7O7yyp4aATGa4XRwgnrgPDkqHs0ZpreNd5V
         lrjyjh5Etk6qNfx6sKk35SWiaTe3rMa12Is0CUBafm+EVb67M/LRBMFg+z17zwK1ucUk
         WXuTyC03Lvidk+CMPHud+2ANe7LjLj8rYyagl3TFQ+4wi5oQaMF/tDPKSm5EbweUzY9w
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764851946; x=1765456746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=BFxuAuyssOe/X/xcztMTjsWZSfqN97EBmJ8OqONZGq9GRGgC382sT1LbfnIGYJEcwl
         hCTInG9YNn5qRWzijwmKMgP3EC3YJsZEYQtv/970q4WtbMk4jkU/Hzpx1pGz1GSMsm0P
         zfEhNF4H0GHIhmLUW0qEAUPvrfMi8sjNGs99i78W3ocBP529iFlUhJ8d8LZvqMoVQtHx
         1eSP69aY4/MgppOBh54BTHxCxuLd5YSKmYRplpdS6+d/OxwoI0+3lGiY4x0Hp656K8Fh
         /1bKcWh5zVRseZCi1bAyHcIFoT2e59/IHH0H0Gb58+MIGnLE+QV9J9pJjmWtbldwdMDU
         DdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmPRNqpuKwYkjuTv0ObfxCM682P8JRu4F07WxyeZjW4AvKpte2Hx9uZFML5pY6OeUDrezD/JlLiee/qCOrOnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOA5WxgKu4Ms1/Q+mp77UAe60CDAafLh7GCu5UCtmbl/fMhDXC
	wraXe/QxtmCtttkTLjRZIjPXgzkDtBJrYCADbRHHhWefGV6eO1fsAKu1
X-Gm-Gg: ASbGncvhXEbrjRptKECieh9QNB2e9ICLgWnhjv3TE/aajE/Y7RtUKPBaadk044FQ/O7
	yOOv2o7KqvJnsF9bBT92huydT3OxhZTB6UGzfn9+n+bSz+Xi3UGo0BtmhoMXDUKKpHhKVBKKbvI
	Na2JmqK/Nhl8uZflK9215ky4Y1gSGgGvcXY9GcEMEJpROQTuwgnrJ9Pexw76XUOSkv3mSAAtSIN
	aAE8StP1aHjnHRnfVI3odXvC4xAP8+m8/cl0FBbCwTPnr3yX0U11ga6qXm0+SkbL99FIpUKF6BO
	HmjhAvhitSH8ChnPXYUKWcMAS9D983VeO1XFr+vaR6bKnP6SL/ynR6hiQ+jP7nAMQ5tkCNtpFew
	JKFyQi+jfSxu6btFqUZSZ3E19T/v9D6gRTYkPHxZdc1GtzbkofEG2OcNo9zdmvih7OONrsvxlMl
	BLHpkSD3sXDI2Yu0Aikcd05qGJWUS2bfhnXr6OZlF/9Qw6QQ++/nY=
X-Google-Smtp-Source: AGHT+IGxKuUtlyaX8PN+PqMbMQ7N09I5gYeGDl8pe/k/jby/JuQK+UYr3WKkNen2o5yTwoJekvFxYg==
X-Received: by 2002:a05:690e:1908:b0:63f:b0ca:dc9e with SMTP id 956f58d0204a3-64436f6bea5mr4880835d50.10.1764851946376;
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e892sm4766667b3.44.2025.12.04.04.39.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Thu,  4 Dec 2025 20:38:52 +0800
Message-ID: <20251204123853.1235-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-3-electronlsr@gmail.com>
References: <20251204074632.8562-3-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I looked into the CI failure and it’s caused by the test assuming
/tmp is on tmpfs, which is not true in the CI environment, so
fallocate() fails there. Since /dev/shm is mounted as tmpfs on that
setup, would it be acceptable to change the test to use a file under
/dev/shm instead of /tmp?

