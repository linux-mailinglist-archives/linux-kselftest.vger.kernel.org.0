Return-Path: <linux-kselftest+bounces-24169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19355A083FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 01:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B3C168FCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1109224D7;
	Fri, 10 Jan 2025 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gVbgB49v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CD175AB
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468859; cv=none; b=MOkiCb+Fz8MBMNfsAEix3W9QYZCTe9/EMp25JokXGGmLH4gRyZ4GFMjbupcWbbxyUfUGec3Sg0k6xZWy8bJuu0mQqPVqnOxJLMzK41OELRdWS1y8SFSA6vLviBS01RYZjurN44RZyM1yEbijCTq8EhB3/UiglVwlhen7fkMwRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468859; c=relaxed/simple;
	bh=8Uz7ZSBumyspngOFRx7xieRmLo9XQWVpv/0ScNFcxiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRHCiXi2tC3HsHd9gisdo11ogo0sOBc0IV8w7m5UEHakcgGB0wGQB3XT7H0Mh67uwV4jM/7N4vdt58xwv5DVW61yNg8hoQB32WvLRmyFMihvFX9SkVktD1cd00bthiYMgfwoQg4/r2GGJAwyUaxrEuqN9gqJVsq2l/Qiici13Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gVbgB49v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-218c8aca5f1so31463235ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736468857; x=1737073657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5FIVQBG/19Kn/ktK89Bwn+zvRNqLpJe6idV6sMfvB4=;
        b=gVbgB49v39CaXxdeSDEPzjTXqnwuCKOgswn4iscoEH9zGIhLBa3wVvzRl3KIkU6Bnb
         hI679EB/IonsPYn07Iknj0iovKiT24Al5nm5Gpclq5WRYbvuzkLca1J85Mgrk7+M6818
         lCuVXZm9J7RcwdHQaH3r3Mf8YLXQBBN8W4AugjOyCXZB6POGBoQfTp0y7UEhAutVebrT
         uLWpOcvAk0oOuGV+1QRusDjx8xL4af/n0nYjdy489NL6YrnWP/rzdhSKc1AxQp6Lo2Ne
         YuZTderaTpPluQVJtWNlsuKTWh2WgrBWIoNHflAOhne4/W6BeXwSRUFM8mo1kqxBvahi
         ukqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736468857; x=1737073657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5FIVQBG/19Kn/ktK89Bwn+zvRNqLpJe6idV6sMfvB4=;
        b=GqgWFE7w29LDO/ZSXxsOoV8+tC3KyHhcXTFcP8oumBzr+rx/gDWnmfH6f2FW1Iq8h5
         tNEC/ifLf2w21vARaPqSNIAJQwyNR4KnVyJ6Mk1x2eyLHQH2pbb9Ua65zno1YemBMPc2
         vlrWr8pRhZgnreD/c8gPxXZe6Zi8wSfoEQDnn9RaRhauReSsTxcH8HnX6ojROLXN/CH6
         u0tM3WT4lDjsJfobQdI5Gd2tE7WunfJE+wZy2t0wHzd/Y/DG0d6szg3226y6OHwg6t2q
         5gMJM3q+6ns0+xiczj8v8YDm66MvP9UB4na4xU49ZbFkl75ICt7wuPddlY07KtMNRj93
         lneQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvVqg0PPXc9N7ECCV1/VVv1VUNIzFzeSaaI6Fp6BAXFBVLSJqZ0qbNchMPrT6JEjTWUss5RSUSNmOC6wmYACw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQTTXe2Bl2/ibgENdvFRXwGwsrm0g3sPOfkUSLRoN+5PhsqMA
	Zl7MgOeC0f+kqvF0d1SVJvXIhWpspB2boNvLrcIzLV+VLNDoNC7mqZHnpoeQgX8=
X-Gm-Gg: ASbGncumPUZEdYcFntXisCwa2uxjXiMO2RapYxNuM5Qo0eD41VIPLLDpNXYo0IEzNai
	8babBz6kPPGZlcEK+ZvR7Zmd6tNeI7A0Kvibv0gLLNcTs+8Zrd6Pps8AFFhnjY2D6d6lC8IavjM
	y8A7hV5/5/5hgKyBFBnFtuIFYIG6UUSs0sMYp88PhoYKg7yVsspmmBNZ0Z/U4YQC3gz1LK9ygcS
	pW98y9chz8Mbm0+NwQnZcCtgVNLwDcUEPA1xtRXpR9zE6CB3dY8
X-Google-Smtp-Source: AGHT+IFFLu559HZep7Z4pf7mVNR4iyH+/ZmHD6Q1a3lnPqYVJRG2tLN8xkguxuqbMFb8E9v4uibeKA==
X-Received: by 2002:a05:6a20:2594:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1e88d13b502mr16186403637.8.1736468856651;
        Thu, 09 Jan 2025 16:27:36 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3b1efd4551sm1430396a12.68.2025.01.09.16.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 16:27:35 -0800 (PST)
Date: Thu, 9 Jan 2025 16:27:33 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org, greentime.hu@sifive.com,
	vincent.chen@sifive.com, andybnac@gmail.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 0/2] selftest: fix riscv/vector tests
Message-ID: <Z4BpdQA4t1ip0yK7@ghost>
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>

On Fri, Dec 20, 2024 at 05:17:25PM +0800, Yong-Xuan Wang wrote:
> Add test counts and pass message to remove warning of riscv/vector tests.

A similar patch has been staged on Palmers for-next tree that I sent out
a long time ago. I also reworked these tests so that they use the
kselftest_harness [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=8fcaf922831887e32c8bdf5ebff76bbd80c971cb

- Charlie

> 
> Yong-Xuan Wang (2):
>   tools: selftests: riscv: Add pass message for v_initval_nolibc
>   tools: selftests: riscv: Add test count for vstate_prctl
> 
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
>  tools/testing/selftests/riscv/vector/vstate_prctl.c     | 2 ++
>  2 files changed, 6 insertions(+)
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

