Return-Path: <linux-kselftest+bounces-27923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBAFA49F02
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F777AA508
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04027425F;
	Fri, 28 Feb 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xvaav1Wo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A826B0A1
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760706; cv=none; b=oYIEt0cLGod4M/RCwk03BkWEj2NGaWHCihdZzPqgMqH4WbOnYYu0h2F8UlEW8HcdIu0YZk7pbOFfNbHTZtSqWmhEGCYJ+nU15BkALTnl6SsCU9iShOtLuajAg+hHdO4xjU3fUMb6PV2s5QNEhQAjJkbsI3l6BFHBwu9eLuj61A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760706; c=relaxed/simple;
	bh=OtdWkXi2QX7+xbgm0vkS83yIsbMVeBXdCOlxBG16TuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OWSa1OR/5kq0BCtUPxF81t9BNqCOcckc4rA6fyjyh5STEriiZSG1N1oPWesvEhqLGI59OwkBJ+o1DK1y6dRdKYqwt9u1kyV4bmott6bq1eFJ2kOZAASB1SvIc460oos2TqUSI61SB0WWtp/QhhChgoPCHK1htlmpmmIbTg2kyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xvaav1Wo; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85517db52a2so55108739f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740760704; x=1741365504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fhppitxMyUaNZGord7s5A5rmESX/TJOA8iCXHG5l4I=;
        b=xvaav1WozOtSrPmXnaAsyfpnOwa+6fGYOW+zzqP8K3svFMt2ywHBMX2QKvxpc6wHym
         OfWl70kyRIVwBkK+0SGvaiNpcs05+Tx/5DjnHsD9A0Bu2fltqKZyxH1QhxkQwAROoiE7
         hG8goxLjdooyA+8BAj1hm936Hf+kSnrsUShklwetcgruhax74fjq3E6IlgSROx3PfER9
         YeVsyFAtcgliDMcgqMEtaD959NN5V3nxbF1QrJJRIzbbhgnyfPC7nSxO1fZZPXIHbj/0
         vANKt8uwI7aF9Z5isy14lRxAijoeDRD8+U3A3Y4H5EB3D8zlwjOKt3NLBcw5Veol5HHp
         4LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760704; x=1741365504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fhppitxMyUaNZGord7s5A5rmESX/TJOA8iCXHG5l4I=;
        b=AIdI+gJph5qEJMJsCcsjtb/mjJalvbe48ozmsP8P7gZ4YmACTUrMaz2dQsZHgBEzH4
         G//OUwGxikQWmdYyjnAf9TsaB5sTUrLAeGtw81hs9r1ltIA/t9qGGjJ9nZFOzDzOeRW8
         3EmzqkpJYpimn8ftITTxuNGFBs+e73LuF6XfHYfZJg/LSodEbXyuXQ6FymBTsWQlCaYw
         lCZLTxdbG/WG0Io05gTQCLhOMEQ/H2qr3+d4qDyX5F9O1khKsuZnClGIz/CtCChP+sXE
         ypQmCRaY9Cg4RG01O4sZcfHx3DWf7CjAZiq2ETjqw/VIud1Hjg6AVcpziT1mnDL90xUE
         mpvw==
X-Gm-Message-State: AOJu0Yxqd9dreVObLlKchnPPC9J3wjpuLxafLPFuWKuWiy+AVNpWBOzc
	R/fMkb21Lk3+tIqCk7MZyUvbzYdEBeblpWC7T3LymJptDOUUvHwnsWTZUkd3p48=
X-Gm-Gg: ASbGncuH2qixjl260M5tqL3fS94Yez+oh9ZyULTTQ0ROAAK0aDBI3vP0R4Ub6mPBbMH
	QWgxJISfxIbikgkpFwMyV4Xl1ssp0ChLeZUGrdF8D83NdXup+Osxi/J5mwNJ85bEDLEEKxXf+eh
	xZlGHMyliG38RtAkErXMy0TwGId9+pZ86FszoTiuKLtNXqn35CXpa8VXhrlji5D9UO5PevLwHx0
	+1uOWAlR23m+z/v4WlSFxTT6DLnOyr3WWVExCGqU2Dm1cSF8mPBx7gIxbkoeEbpKQ==
X-Google-Smtp-Source: AGHT+IFj51HJoXHDlGpJEwU9wsOusY/FHkRrzYhvbQxwySbR9sFzHicrJmYe0VIDwGnC23stnE0gHQ==
X-Received: by 2002:a05:6602:1541:b0:855:b27c:e834 with SMTP id ca18e2360f4ac-85881f0f4dbmr418900139f.5.1740760703872;
        Fri, 28 Feb 2025 08:38:23 -0800 (PST)
Received: from [127.0.0.1] ([99.196.128.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c4c1f0sm978411173.35.2025.02.28.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:38:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250228161919.2869102-1-ming.lei@redhat.com>
References: <20250228161919.2869102-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/3] selftests: add ublk selftests
Message-Id: <174076069911.2584282.8980328813902207680.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 09:38:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Sat, 01 Mar 2025 00:19:13 +0800, Ming Lei wrote:
> This patchset adds ublk kernel selftests, which is very handy for
> developer for verifying kernel change, especially ublk heavily depends
> on io_uring subsystem. Also it provides template for target implementation.
> 
> Please consider it for v6.15.
> 
> The 1st patch adds one ublk utility and one entry test.
> The 2nd patch adds test over file backed ublk.
> The 3rd patch adds test for ublk zero copy.
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: add kernel selftests for ublk
      commit: 6aecda00b7d1e187c31e702d607d2b51bbcddbcc
[2/3] selftests: ublk: add file backed ublk
      commit: 5d95bfb5357111028b7a37464d1a18702722efe9
[3/3] selftests: ublk: add ublk zero copy test
      commit: bedc9cbc5f9709b97646fe3423dbf530b74b09d5

Best regards,
-- 
Jens Axboe




