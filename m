Return-Path: <linux-kselftest+bounces-23404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F779F2EA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647237A1FBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E9203D77;
	Mon, 16 Dec 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNZT81EL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7F203D6B
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346590; cv=none; b=HjIb1rUz6dJT0HN8SQ/p7CEI/jUPSdsIBf3Y8gkTVnNNsAvbEi88vVqehjudP3YjAQR1A4jngWb1fAkbVrSrnhB+HLU/DGnuTDy2PiDPZnJsWaR2rRecn+x2xuHVZGlxMcjjQOsyM4qjavj1Y+RZr1ztuoL3YMCwEILdfyXKbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346590; c=relaxed/simple;
	bh=RLUoaB+1v1ObhQtQzm0iMLd3DVLdNwVU11xerjKzkIg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YkwexTP0clAYvzKQO1Hi7GwZ815KMK8rLebMoweqZqg1caBptLGqXqZmstATrSa9KbCQ2X8R2hopiQHVlqWoPGPqguvZiR6Xi+x8HEwk0FeFjOr/AkweWRUi3skE7hKUWfxGjqQ7j3FZiuFOjA3gICnlOcpeA4ODzKt1qkci8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNZT81EL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ec840a8aso4169472b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734346587; x=1734951387; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnug43zVwuHgF5ksLoeaIclgiDip3wakxrlun38CpQ4=;
        b=JNZT81ELpRNSjTx8TEhDQgfAnuByi9s2nvsJb43XNthoOxPjq4KthQdwxRdIxtSBDZ
         vXgVJyYSxFevdDeMtZj5pty+2nZSU1qavL7Ucy/Voxh6hyXOT5yy1pqX2w0i269HIJGT
         F7mT3fdUAfdOpHQJEj3rxvqY457sJ6ptzqLXO8uUi0q8dIYMJF4AZAvcBZxHkBTlWium
         TOg32WTS/Z3e620R8nfRhd28KqnEVlcmBvqrpHBXWkySmNCdwFunNG7QtDAAYoiXDuQF
         opxuZReBKL7AO1sTRuBsNeuR3cpjwV1fbB0LXzHnbJdiW67uaXEGsUE6/omAlJe1ff4j
         L4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346587; x=1734951387;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnug43zVwuHgF5ksLoeaIclgiDip3wakxrlun38CpQ4=;
        b=dPhVG3P2yzqgEwjxlOXBMwkNHC3PAilib99cqOTg6thEOsl1oW3crPtRVC5Nb17OHo
         pNhtFdmnRQK/xtR9oCvXFC3C7T0edy/CiVBsJoY6tqJGJQ9JIUsfGUYXkksYzIpr5KEx
         +HPy6y/cnoBLTUDOpA1MRQVhfekAx4uAzc0nrff+8Zlk7+do7/zEnlIKWq1ZUDQctWBi
         Fe9XmSQRSwqVFr6nXiYsMcMPkD3DT+wt0IADS3b+or7V5UJrxKDC4mK3vrOTynExCNjI
         eYH4h3iThmK/0Cukgv/T2qBlH73pdI1N5fjb4G1Dtx8WRQuf2DIzp6hwnTvEzAugPArp
         mFxg==
X-Forwarded-Encrypted: i=1; AJvYcCWRTEA76Wpsdip6wQU+Y2lkkRZBuUBKEEQijOWXR1yf0chQK6X16jFN7FW5SAY9g79LZC+1kC1qZf74G3ejSUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGI/RDcP3jDqljNzzC+zCloduLbrC6C1QQXbhrYA+UtkJVFxp
	nzvU6ph3R7EjyYiTi8Dw/xAFZkOnTDSnjehvt/19lDNs4SkIKx1w
X-Gm-Gg: ASbGnctg2Fty0VkXJHfkFFtoZ5lQh+Jj+geim+VBH7YR6hcJhIDmykREXcw2H+TgJd7
	KfrMQ+2t0shAgDT1vmGc9uJEECKbN04vXDSruimz/GRgpTa4NM9r8rbw/mQbw5hQ9MYu9rzHrT/
	beX/1cEG9k4NEe9RhgKGKyGrsUMREDhKiVJ4lZ9in5ntEJlYtcxR7HMWTD+pNMsSmkeHkF/k4ew
	ZBQC8ayjT8d8zlJXomQUS7LR5m4ZA5daw5IhDMBFw7FojbFiw==
X-Google-Smtp-Source: AGHT+IGqJ95IRtz/8wfjaNkt3SAtl9YnDmEtN2MogEjuhbLNQEajw73seuM7YcR6hnG8b6iPyL0I8g==
X-Received: by 2002:a05:6a20:a11f:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1e1dfd3d97dmr20475205637.11.1734346587306;
        Mon, 16 Dec 2024 02:56:27 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0effasm3867778a12.60.2024.12.16.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:56:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com> 
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH 2/3] selftest/powerpc/ptrace/ptrace-pkey: Remove duplicate macros
In-Reply-To: <20241209151418.348085-2-maddy@linux.ibm.com>
Date: Mon, 16 Dec 2024 16:24:50 +0530
Message-ID: <87msgv524l.fsf@gmail.com>
References: <20241209151418.348085-1-maddy@linux.ibm.com> <20241209151418.348085-2-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> ptrace-pkey.c test has macros defined which
> are part of "pkeys.h" header file. Remove those
> duplicates and include "pkeys.h"
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>

Similar to previous patch. Cleanup looks good to me. 

Please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> 

-ritesh

