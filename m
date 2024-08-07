Return-Path: <linux-kselftest+bounces-14996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47494B2F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 00:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0157D282AA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378F155300;
	Wed,  7 Aug 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owfKrhbk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7714EC5D
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069362; cv=none; b=sT2gXlRo5aFOm2hHSEnLqSWIiT/kpU9MJqqDaygL2RIv9B+n+TJe7b++zM0VOxv0M8TerAHMYz0y6bMwAHgSIkBZScA0InJi2BBk1Kx81kV8D8s5Th9CjvwqKlY86nS6p1uT4cQmEAf/fZiSPN3kXtMrRC6Q3av3dyi0ptWyqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069362; c=relaxed/simple;
	bh=3btizCSSAKzA1J+IVvS5w27hk1nP/wRY5h7VZDI2y8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABfa6z+oPVc/bw6a1BFGx3VTfLAXvIFWp5/OMrGRrGLI5zpV7PgQjSJXiTOy8VDrx5mP7pzH3+nIaPsSG2rcpQ1Pe3s1ZGIGuiMnATsstjlQWn7UPY3NboAH4jUciMAkMR95JtuKeaDJawRL+YgPezNnqe/lS0icup9aq37O5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owfKrhbk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso301079b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069360; x=1723674160; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZVO8jPYcIWWyL3ex1mes3d5ZlFCIJ9T4CxX0DBumqo=;
        b=owfKrhbky9m4wOA4iJYhNPOT8hpdnh0vXsYiWFMNRqec7cuddz13AdKo+iK3CFaX7x
         O4fSycWbVugnKBX3A/n7SVdDKLh3/F6LFroNUYHBByUcEIb/oAKgj1Ebv2iFg1zoVd+b
         DcBxRvX8P1g30qq/CZ7P/ljAR9LlOO0diMeR1Xg6QJXwS8bwpbkTTjGg/UBu7/udjD/u
         TrS3ZrYerB1D02O7m/Wynl0Z1QKqDBDri8ZgBjMljikUxr3VVABWl7CWbknJnqMSXi+7
         Ua6FyGUDb+F4bRajQ4G5Kqe4jGv6eNwIEiCiOYZFbyir3xySUYpaUZlaLB3eJHD35X8W
         /NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069360; x=1723674160;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZVO8jPYcIWWyL3ex1mes3d5ZlFCIJ9T4CxX0DBumqo=;
        b=GKJXhxU88ejPmhIgwJHfvXQX2Qmj8pLTdGaLjhrcsH106Ws/YdDcuut6DwFASzd4CC
         3eaWmEmzYlNx5XtsEKfeKPnLXFfSS6I0FOpagEBeryt8w8NxPkaKSmJ5ZcdvAet5eM0O
         gveRnfDV5tRK/42rOskrGnkuIqJ9ZTJEySzX9/iCPKppsdL3aGrgw86JF9X0E9JEt/ot
         V4ggSSlUIrguLei/l4haUha90LyGRVUif8iLgePrZ1A1L7o3+dby/M5TU2NjCcyUm2AK
         yMeT0Y5tP1EKV1hIhA1i9JeLq/nJVT3azoM5rzZMarYRJrAS1GKBGTEN4C8sgkue4cYm
         rsOw==
X-Forwarded-Encrypted: i=1; AJvYcCUGK04pzRCwNP2NDcrOIxTZS8B8lJ5VDP6dcE8eq0moW3xa0Jj4AhtDofNIWgqmktiusTEt6ZHlClOk1A6rS3TT9kn/qtgc7CiagIEId5j6
X-Gm-Message-State: AOJu0YypqRSWPqpghoJTLh15ZBTuF9zXvadDpUY7Q62Wi6MPmfEXBzJv
	D2xV53pKxYe8LSATLG/x/vWZghG6JAsZq/OUGgWDGyYDiblfgAQMopyk9i28f2M=
X-Google-Smtp-Source: AGHT+IH2Cc0g0B6ra70L5cg48YZJx7srHh+PqfLxpX9PDwnG8XSpUfpqxIf7dyUyWUuyhSQCs84ohw==
X-Received: by 2002:a05:6a00:1302:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-710cad5a30emr137306b3a.8.1723069360049;
        Wed, 07 Aug 2024 15:22:40 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb228d37sm5911b3a.46.2024.08.07.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:22:39 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 27/40] kselftest/arm64: Verify the GCS hwcap
In-Reply-To: <20240801-arm64-gcs-v10-27-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:06:54 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-27-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:22:37 -0300
Message-ID: <87zfpodlci.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

Mark Brown <broonie@kernel.org> writes:

> Add coverage of the GCS hwcap to the hwcap selftest, using a read of
> GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

The hwcap test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

