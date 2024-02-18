Return-Path: <linux-kselftest+bounces-4915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6F8597BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E880280F2C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4D6D1BE;
	Sun, 18 Feb 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwRk8WPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A76D1B6;
	Sun, 18 Feb 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708272893; cv=none; b=sec4xB145XUpPS3Nkrd9H/uZA52bRZCgnrw35C4xa1uTo7LvCzZxZ7duDi/dAcvh5m5ZgSsE5NJselWM+El1xaSU9UGsGcgEAvo735Xbr+32huRYamycFxiDihOwqINSPtll/2Ces5w/GNNG+0q1nDym+JAWz8UhxDX/K7HaqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708272893; c=relaxed/simple;
	bh=KWAyxR0P1SelFxL/jAWkpeot6DvJbS6DVpjN+zhCWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxpnsOkhm2+MlMV3RFsc8KPPzbnKst+N4OozwXFMJ8vqfN2RzJ1MjDq3Nn57wgQqcS88UTW6C9KPFEbEha8qwTvoPVlhRKSWSCYaTT9Fah5qjMMsn0hHtbULYxM99Xk3LcamgmQMPsfySHGAWM+Xh41ECTxLsLribd7WjoQYEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwRk8WPH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d934c8f8f7so33919655ad.2;
        Sun, 18 Feb 2024 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708272891; x=1708877691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWAyxR0P1SelFxL/jAWkpeot6DvJbS6DVpjN+zhCWtE=;
        b=RwRk8WPH/i3z6RoeKvDL00pBLEHZTh09vA1nbuD7dpx9RR81jH9DgurrwSPXN9jCK4
         nlYD6tLiZEVtHyIlTtPgXb2sWL5WcpMEiZ4HxpMHfvipQH6us+kKeS5OsYbBaZaroRx0
         O3K6A8UnmfRBPxpS0jZxI7zghl9jlydFVB6ejRz7jQ/MT4XU/t9B7mBIhh0dJcf6uiC6
         DXDnpITY42WSS5y4ZWWtp7w1J/4qi7iR6K2WwbwkIyrqxJQ8564WS4DLB+FnsxCMk/BK
         i9jDFZ7UEkhJ+0FvFql1i/d3WBNzz8E5SRy6/troaE9w4PC9JQ8RXcZ0bvIxAnRluWK8
         lPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708272891; x=1708877691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWAyxR0P1SelFxL/jAWkpeot6DvJbS6DVpjN+zhCWtE=;
        b=GKhpEjau6rWpePl0Hn1Xnb45pp3vJj4OgcU5m3ZJxp+tb44JLj3BiDfKyRYhWcAsFu
         DbKi2+h0mAiXdhjgqBVQ31jLR+ELBRmTZXqlUGF/4Vy2l7Z9nboN0nvRgltZ7hxzXqu+
         xTrQsGSSTpBW0EkhPdX0HTlVtj9iiPQg4x7MiLIFSmWXA6nyuThpvArkC8FqRxp837Sg
         Gyd4RSnNC74KTIqxuQ2lo9qJcGESFDDXfi+0wXLz8WTZw7TtV87T6EeiGD54JzDV3+f2
         Bz/W+EBDEUmLv7FigV564jJzYzCjuyQIb/4WvhRjFfMnY/KDHaD2+S5dRbvuyTUHMAYB
         4ufA==
X-Forwarded-Encrypted: i=1; AJvYcCWUJW8ytqaaJDAgsW6SlRCbr2aVNOlYbEdGP6FUfzoMDK9feZlE8Uc6fWFbO0y16qNkiNEf1zCNdmvSAPJipeKKeiCuQTcQDqwJ/ke/PDhMKBgMo0LR8hlm72Q9asdEy8Ay0fcvYsrOe35ZU5UFFzTHqDeGXkKSU1qc+TX3G42girGp/OJE3mkylqUMiz3+tY6Y+X/tEnTItOGwEFZvcaj/0Un+
X-Gm-Message-State: AOJu0YzJU5w6Xd4CJf8fChUXAyv9ZJ6p6kf2JteiXSVi/M3455j3U8GT
	e5YeHlk9oySKxezdTfQLuMVWnyX4lzjnDXZF50mpOYoce9vTjO4X
X-Google-Smtp-Source: AGHT+IHz+X3SQBoReWXOgdtliQZai4QR45NIoF6DjKjc39m4Ih58pAWJu5DpuHd+g+88sRTjTARV5A==
X-Received: by 2002:a17:902:c40e:b0:1db:5b41:c5ac with SMTP id k14-20020a170902c40e00b001db5b41c5acmr11689188plk.68.1708272891272;
        Sun, 18 Feb 2024 08:14:51 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2000:500f:a246:8a16:bee7:140f])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001db4caef8d6sm2849500plb.161.2024.02.18.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 08:14:50 -0800 (PST)
From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
To: rafael@kernel.org
Cc: Perry.Yuan@amd.com,
	Xiaojian.Du@amd.com,
	alexander.deucher@amd.com,
	bp@alien8.de,
	deepak.sharma@amd.com,
	li.meng@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	nathan.fontenot@amd.com,
	oleksandr@natalenko.name,
	rafael.j.wysocki@intel.com,
	ray.huang@amd.com,
	shimmer.huang@amd.com,
	skhan@linuxfoundation.org,
	viresh.kumar@linaro.org,
	x86@kernel.org
Subject: Re: [PATCH V14 0/7] amd-pstate preferred core
Date: Mon, 19 Feb 2024 00:10:30 +0800
Message-ID: <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
References: <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all,
I have found an issue with the patchset when applying on 6.7, leading to a large degradation in performance.

On my 7840HS on *STOCK* 6.7 highest_perf is reported as 196, not 166 as assumed in the patchset. Applying the patchset causes highest_perf to be misreported and hence a misreported maximum frequency as well, at 4.35GHz instead of 5.14GHz, leading to the degradation in performance.
However, On my 5950X, highest_perf is indeed reported as 166 before and after applying the patchset.

Hence, I propose the following patch (should be attached).

I do apologize for any mistakes as I am new to this and this is my first email on the mailing list.

Cheers!
Lucas

