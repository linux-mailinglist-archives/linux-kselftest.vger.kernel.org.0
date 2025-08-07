Return-Path: <linux-kselftest+bounces-38462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31406B1D6D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9F5834CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C97279359;
	Thu,  7 Aug 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu+OG0/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86310957;
	Thu,  7 Aug 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566977; cv=none; b=jMbSE0Ya6VykAyItSMGTebuVGDBEBl+sfZmqk6J3MkbOY8T8CKiONJ0AybVyl+A7VKBuPfMjnpuykZdVjEhbb5jZw51qxyBwKUWleCE2mScB+9IQeCruNDbBFFFLjfoXub3AhlegHJXGrXRIElHQcX6oRkUcA3hybrK623tduQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566977; c=relaxed/simple;
	bh=Rj6DipUsOyvMZKPZE3nzhUz8hwwRWIeek2sdPfK3r6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buVhM/+xx1jg3rTEk/IHl6e7IA+fViFNQovJRzr0vyBJmZd9PkKo1U8CxFRE0zzOcALtWyw9vZSUFrm0WG+tgqjUlRwIYTH7T23LpnLy6xn+RB4LK4iTLm/LkqpV12alGyPPd/e2Qgr+VwMmtPiGRblHklUzfuw6k2GZfNYF6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu+OG0/B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24003ed822cso4850955ad.1;
        Thu, 07 Aug 2025 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754566976; x=1755171776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj6DipUsOyvMZKPZE3nzhUz8hwwRWIeek2sdPfK3r6U=;
        b=Hu+OG0/BfNLSlIdSdHqPWqfLNrjasnc4JaVdFlWU+Ygy7swOe8jsfMsk3qFZsggTWj
         ThnOqQdTJAuB/wZc31xtr3RgfB2hzDP5GoA/B21qtAAT7oLKSLEqBn4Bd8UEo0/5fttc
         6ksbhXmEdpV3oikhcYNYq6Yb3EAefJS6RNFnunHqDI6P++Z+VI/N8mWOwqxnoMLUVrl8
         UY1p8TDcn0yxuT7/dbF3s2QwFEox8EcO3iiEaKH5vE8QNZicYGoOMDGe16byYlFHBBaE
         AZQw2aQ29FwiGvnYi+SwJZTD6GDsr3XOSdFgafezkO2or/qni6qS1sQlmOTTawpQmGyW
         XuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754566976; x=1755171776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj6DipUsOyvMZKPZE3nzhUz8hwwRWIeek2sdPfK3r6U=;
        b=DSE+XotVUrdCUP+oSCTJylsRv5lG6QjULOmsJ9QQsMCgcI1UKdsyI9vFP2o4KecI+Z
         Px1Zr8sNevkU+gOrCGQAqqFPbmif9HTJ7T0JhRBuboPehWTWordmRqM4IiyP+J7Sn5KV
         i4qatBg8/dEX2oYckfO+djvryDQpfbQuOM7HwgIXsGwQv/TmgUO7dJK1qfwpt7RSuARK
         oqcW5CZ8XL8w2vX3Ir1GLYwsbkC0xOIjh+QduBhlVq+q3q+hlvD47AUpZaFDj9iR/cVg
         rdCiBHbUS+jdMRylPGjn787MGjn1b/dqcCArMYcn59cUfeNPPduxnuPcmfRKgvYZaUSr
         sjjg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHWTCDlv/KLzjSbkYt0N0hco2bVFsAqbb7CuQ3T15U+J81jnhUzWd+lhBKg6b8DDVkFi8VwWyeKtw+58=@vger.kernel.org, AJvYcCXQ+eey1hjVo929Ao4v9SIHx1ZyhAEEVA/cUSwj8RhYuCInNjScmjoDz/vz3uzI5ZRvw9GCcFdPfvhwDst8GHwj@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9Yuywz0GHTv68LLHdTTP+7EP36gCs6B6DCUbyjdzI/EZ8cHD
	EW4w65irpQYoZ9VbQTTRmzWhK13EmDsu2ftKsCECHphQEqKTKAH3eVbcmqR3iLxgm/4=
X-Gm-Gg: ASbGncsICLjBynu+5qleNZZQ03URSXMgFhV9xc94lI5cfthzdEISWwO8WwSK8/BC2uy
	J9H1EICXaioTUWT+MuxeHoIPYd5iB6IcDv0Dp3xJ50IXMBBS2YW9npikzbaGDb9oT5o+jP0ak7B
	ca8tzoM62dTVmcnsbkx5KHdcIi0GLBO3ViGCMqepAd9YRXK40sTcspmLxlr0EgR/4jA2l4coj/T
	J+IHMUpRwYrLzcE7ZyiyjtC4o5RDU+M0V/Cy3UH0bcX84VLi3FDzsG/oeAubltLDqkqE38s6prE
	17xTvsZCrA3M/uXg+D3i2a7BrLtr6Co/42tnaoJJ/zJz7uuHslNiwJ+Wyt6kX/4/gZEF7RUfGG/
	N7xBTK/XxDZSWR4LhrzhAPpL8xZ1sg369
X-Google-Smtp-Source: AGHT+IG3ZtqzKCP06yrA47lTy/NFZemMNJP3yjJHpioJcwNNrqfVvMG+/ltRnnS5KI5VbeTgXna0iA==
X-Received: by 2002:a17:903:22ce:b0:240:1831:eede with SMTP id d9443c01a7336-2429f51e3c5mr118816725ad.32.1754566975705;
        Thu, 07 Aug 2025 04:42:55 -0700 (PDT)
Received: from server.. ([103.251.57.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm185729405ad.73.2025.08.07.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:42:54 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: anshuman.khandual@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	broonie@kernel.org,
	yeoreum.yun@arm.com
Subject: 
Date: Thu,  7 Aug 2025 17:12:28 +0530
Message-ID: <20250807114247.5915-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
References: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anshuman,

Thanks for the feedback. I've added the warning text to the commit message
and included the Fixes tag as suggested.

Patch v2 attached.

Best Regards,
Bala Vignesh Reddy

