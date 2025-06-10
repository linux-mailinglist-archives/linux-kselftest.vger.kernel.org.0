Return-Path: <linux-kselftest+bounces-34544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39426AD2E30
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C6A16F146
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672827A469;
	Tue, 10 Jun 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkKeo+2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E82EB11;
	Tue, 10 Jun 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538690; cv=none; b=cAn0nGqS/enULad6CCglzurtcMjtr6znWtLYOGvCdOp8OWL3imj1cS9OONdRvsOWDHZW9bMDhXhK1WnVq9dBKuXodS3hbhn0Duu09qDHZhC70RKuwLJywlkWbNBhvQUwW+UaKErgW36iPt+FHSaAMSzW2DPzx0f0kokqD6UJDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538690; c=relaxed/simple;
	bh=S0dMvL4cHCUVN4I4bj1t9Zvhqa+7+nYmYS7RR+TWSE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca3y+RXIQloWo1RSUILgVOnGQCDXc47atV7nKpz9d27OvovpmDKzZYMn6jUdRlanLXawZeqbuNf3ZOoC/FtNemzVi1C3BcNh0CZaJnhFalOANVBNxc8k/ZnVbMB70pmqUnZmqfnk7Xd2rvj+n9uclxa8wsTp1RUjhkhgQqyCrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkKeo+2G; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c035f2afso3579217b3a.2;
        Mon, 09 Jun 2025 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749538688; x=1750143488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0dMvL4cHCUVN4I4bj1t9Zvhqa+7+nYmYS7RR+TWSE8=;
        b=RkKeo+2GqJDaazKOKgHjPvrZuf7wfshXNWoO/k9Innvaz/xk40hpPxDecx2fPCo9bv
         x+7kcsYfFs93QZuNv7SoFBYBlVGfT9q+UQdpiKGS4tNWm6hWp5b+t5UHU4g+TdOePLyn
         pa9yaXB2ZXGaEy7bJqrOsJMGPRkYorB6SW6Qb+l2+zEaOVaPNQiNtKsP8nPmrwYBXf0H
         0mYlbIDMi66SDqAHYPGqw2nnhpglsj7UvxIQEzI6NrbU38FYG3hl2yRPcssJAIotpOuL
         VtvTHAzWMnBgz7JiewfXBx2NNK3IgYg06uP+TmkJS9s1rw0FMx5q710NEm+Ss7/K0Ulk
         uS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538688; x=1750143488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0dMvL4cHCUVN4I4bj1t9Zvhqa+7+nYmYS7RR+TWSE8=;
        b=WR643BMmSAQUZ2xw/91jlH9B5d4gULfKU6KQSDNzQKRgoNs3zoCWM87TZwxISFCnir
         y7+ZjMVH9ol6fS+IVyZ6s1cAM8QVcKp6pkHIp+JPGN6Shs+vsWJwts/lf6o3BrC/kBIN
         LG2XNLUY+xN70l8SOs/T8apBxBCyPs07f5Qa0qLv939apq9LosFySEI92Rmu2qr4O59e
         5xLoqw38il5nlcIkSVBOxp4ciiW9wUQ+qnJKeDoZIKCHqoaQGukCbeRIpEsa/AABP7C0
         DSjyVldd2MXZuJ5IutS6nUP6ECuj++Z66wJS9R7OVrSwHZ8KFczDk5Q5BKEuzXcK8p3L
         qiNw==
X-Forwarded-Encrypted: i=1; AJvYcCU40smfrUjJq7GcS801m7YrDTQgFdnCVO9uGSNacAvDEmk9c027RToWd3OC27/CCkY/VqRP19YYxq1aVIgHyLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvltkI5fhd6NbhOR0tt8vkbHHAagkM+FIfVRMHi/lQJEwaALZk
	SzPlcj8rTjmq5A9L5mPNeouTeDD6Nk4hMbqySNL6Z6MYAjshCyZNnUBuiEVtAMDUu9t8Lwl9fjd
	lUhCkkXk4qQEcY+/gkwTAIC+WGdpYyA==
X-Gm-Gg: ASbGnctnc/sVp6T1W6LO5sZhyGKS0Reb+YehPc7giZiv1J1N6xg1QjVctNBziTkkjWC
	zMTV8scpXKQPUDCKnpkGnBipLBBf6FY9uTBWbC9uZHKvFcmGqciFoUEnuxvZgWWU1LBUlkwO8jB
	PHEeseRELFCK6xoDh1OVQ3ELjTlElWtt+KjuuzJm7FN9LA2DX+PGoLZQ==
X-Google-Smtp-Source: AGHT+IFvtzeVVIyCGu9hgD2Zpy7Kbr4cifNUZppXFTkQzFBoardh1hAqUCWSM70UQkc8jpvXhoOkqeookh+1Qrb/ymc=
X-Received: by 2002:a05:6a00:986:b0:748:2fa4:14c0 with SMTP id
 d2e1a72fcca58-748616cae30mr2363710b3a.0.1749538688368; Mon, 09 Jun 2025
 23:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250531074625.478-1-ujwal.kundur@gmail.com>
In-Reply-To: <20250531074625.478-1-ujwal.kundur@gmail.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Tue, 10 Jun 2025 12:27:56 +0530
X-Gm-Features: AX0GCFtCrMYImzmzDrbl4Cxr7ClCetMYzMQUdGPGCb0rS_0j_Yw3oCsA5BZn7Qk
Message-ID: <CALkFLL+BDJyN-A9ZLF84saD48hany7G2B6sH41wUvCjzTVH6+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	jackmanb@google.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello! Pinging for review now that we are out of the quiet period.

Thanks,
Ujwal

