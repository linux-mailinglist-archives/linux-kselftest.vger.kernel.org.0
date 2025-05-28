Return-Path: <linux-kselftest+bounces-33962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D38AC70E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AE2A24F0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21228E5ED;
	Wed, 28 May 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bcdf9GzU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019D28E56E
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456745; cv=none; b=FsnqaEonHyhUdBIbZhOkQ6L1d6WH4kFHXTvqei6cqURijuRqZG1vfJyDXTHf1W3oYfnWaOmRZnr8TfccSvcKIl/2Udkh8PwBvh8wjIbzcSRIoqCrLLvzQW7boNITTKajhx8biURvxi78uK7r8YH4XJ9vu9CWrwYkS9MgmPMSQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456745; c=relaxed/simple;
	bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAoJy8i5rlAoM4JCLbYam0Oi8N2l5ZlAXa8L6OWdksqA9u9ggIHdbb4hjndnww4puVvIEkyS65/kv0UK2pl4Y8qK8Ud2ZqfetVIHi+OnsHVi3Hgtwe3Ea2kYw+X9IxcvUSgwWobfsvq+FbXB5P1EDX9jiEAZp9vy5UYPNCQgLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bcdf9GzU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234eaea2e4eso256985ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748456743; x=1749061543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
        b=bcdf9GzUH/qkvrQSKiVwX3UGs1vEkrTQECdy0fa2oyHOgsyjRl9EharQdf1hrOxT5S
         aOgqVAhiFy38epz8gLWuFNKnZVI87uDMvm2Czhz4ACUQFWufFrAm7cNj4iMzmIstrJdR
         6SPaI1NtnmZ5amQbOuuBLlGr90UEvwq/Ox33pfIIwfce/Fa/0xkO7KIziJEhtVGxloz8
         sZDwmrFOgsPCuqm2GwgExxbVBxsf/lhbSYNJXoaAdlIhhETa4mvvzVv2CZCp95SE3KoU
         JrNM1aTQQpngAB/1d1KJdpyUyAeq7PyX/U8XqoPUhJwHvShnK5vz4AEn0LIcbBA8gBB2
         +9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456743; x=1749061543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
        b=srT3h2hyGLCiEHU7U3byt4J/oIHyMJuslxXSKV2r3p8D0Gf13YneKB9hTxYGccqbbn
         BCQzgkoc3Q2mzIySrLryXdsB6chMqnVEHgBtGE6UfAduhlG8xTwkqLb/krAfzj9KocQT
         Bywsd5xB3ILnjZ0+cG9YOOAZ08xsFQpyo7mKC7LS2gEF8h8CgVPMXp3rx3eWy37QpSYP
         zzK2GVYmQkQoGMbadAiCx2o0+VUFfZqbEron4mK/mblJpPlSADn/DwIuBP2yRqgAZeUu
         yhr9OETedgx2EDZXD2yRYU2Ld37n+zg0z1Sp/Tmc8B7k2sbFluOyHq88Xd58zGG35PCt
         20uw==
X-Forwarded-Encrypted: i=1; AJvYcCUL6cj5Hv/LV0pNXHqD8W0A+FoWqkfIZexWp5gXUYmzeoh9lBgcqBLgHLnDL7ws4bf3O0TracUr9EVv94+TrhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XzE4p8n5vbZQC4+iYaf5pIt8jazHl8fnHuy7AIkdYCYZ3dMC
	VPHMb03+WZy6R5ma7WuxDbsf15SZRIn2UegBya116BYXfOwr0K+t4syrmk9hr6nBhHu1Q9Ymmom
	osnQUVYtrzC/KwX2/O5fK3vnSzml3dwnfSEwMJCvAAQ==
X-Gm-Gg: ASbGnctghajTtEMr2TqT8NAQP2RXMzwByLsSTK9IeBSN7T9j78HbuS/wLv9dCww6DWD
	n3od9PN6/eehXAC5S5Nt4fzxmK4x+bAFEg479sdZCnk4sd/6bDRCEjO2i0563Jn+AuLJWCoxxon
	64orMg2sIv2lQpTGfj6QPzaH4vyqKagPhQ
X-Google-Smtp-Source: AGHT+IEqPgJEvwuKzLiSxyyIQ81so3lXBN15LCeb6qSM07Ix99PnGXOOlMeJsGGG1A/YckjG2+wZSDm+qfUtj+1ifm4=
X-Received: by 2002:a17:903:1b6d:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-23414f53285mr102307925ad.5.1748456742958; Wed, 28 May 2025
 11:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com> <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 11:25:31 -0700
X-Gm-Features: AX0GCFtwLbawvnl7mK2nPLXhDZ3ch13VYeZVtizo1aZXU9QSxG4dusWwjli_jhE
Message-ID: <CADUfDZpjFv9Vo1H2rzeCyYo2nsnP_k1prkTCQqTtpk1YjL==zg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] Documentation: ublk: document UBLK_F_PER_IO_DAEMON
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:01=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Explain the restrictions imposed on ublk servers in two cases:
> 1. When UBLK_F_PER_IO_DAEMON is set (current ublk_drv)
> 2. When UBLK_F_PER_IO_DAEMON is not set (legacy)
>
> Remove most references to per-queue daemons, as the new
> UBLK_F_PER_IO_DAEMON feature renders that concept obsolete.
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

