Return-Path: <linux-kselftest+bounces-36096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82979AEDAD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1891784DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543FD25CC64;
	Mon, 30 Jun 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1EQ00KU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0125C833;
	Mon, 30 Jun 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282748; cv=none; b=saob24GHqps3Vu5Qltkgrw4Tt0wWI/edXz9I44Xvn3AUsicUQWd4Gh/S5ClwaVX6NlJE1x2LunsmbaFrsu5PDsxtrgNFIdUcWVXf/5h9HpXHhw0ohLYfKNIesPCUMKVj8q1UexXftAtP2wO/yand10CJZxQ94B3eD+1Ka5mJ48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282748; c=relaxed/simple;
	bh=D7vuJq1nll6jHkSYHUN97HFmHGVop+R8o7Ki/EsO3Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niCBniPFn5D6UICst13eQ2tazDvzOUFRajOx60+oXsKqyNgee/dsflwktLK2CkqKZWvvrLw0zfqK+LiQzNvRol3CKJfjm9KWwf/GmUbABJ3sdLJgtx98atZYtjzbzsL6ZLvtgCzTAMoXXM3zPreGtPIVxIaEJx8YhX88D1MAYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1EQ00KU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so3035832a12.0;
        Mon, 30 Jun 2025 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751282745; x=1751887545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9PQIUz1gn61Y7LljRY3kDMGMzsDdkZNp8ZHbQ5TSJ0=;
        b=f1EQ00KUwO7MJyFil2Xqt1kIzu5ci7RQuj/UL49MkRgJCke/JXFNId9mL8sq8LKsCd
         F557PV/VriRmuXmbbf3pdZVbOtAdlo9zsFlUuoeBcxoycju4NzO8EyjL6w7JpMM53if0
         r1kcBwVj89l5Lx4XTTgvolC2QVJX/187mRKbNxJw5Y1/2tsYJuU5mbvyGoeXmN8Xt5ZL
         pV5ekBL0rcarimTwIiQLANCd7njDTU91O4htodXdLgEU2cJcmD6LCEmbimeHF0pQdmXy
         mrMbdDMuHe98g2QLASOemJxxHBhrJxz2Nf4UrBwCR2XM1R/g04/PEoc2PzkF0OKX2so0
         GEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751282745; x=1751887545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9PQIUz1gn61Y7LljRY3kDMGMzsDdkZNp8ZHbQ5TSJ0=;
        b=FsJPNO8YPioaPtz+/1cHP6LkSasXS3K73B/IWSfrncfrfcjPrd1kcXEH+9D+opeDDk
         7FPdMFlAppdGaUygflFdyxQQnlloIIwxst80LTeUS+PT6MEP3MecH+LBwosO45ngMKfT
         AOAJivrHmEJGHU+WDTKTXob9G9lxMcu3rFw/Qdw45wwE/Fdht6iXhOAGCYxggqo4a/tO
         9wl6P7ckyTON1uXBZ4EshkGaHAa/HVyQSGg76YsU2JBcHRtBNRmCAYilgcvPCmUIcF8A
         +uwTvGgsf8OFZvgztzXzhb57P0eN46rlnfPbNx86UU1KcdzaWR3WMV2hQzZf1gmtIS2Z
         wDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUvTOM8ExEkiQOCgvFx4GZ/gOc36RrGqmM9adzBBnP8G5TG2VWFgk8RuuVgyXOWWy/d2g4d+YeRK39pEhE=@vger.kernel.org, AJvYcCVfJMEKSQj8rvJl3Y4ciEvi0h7GooLXuEpnuileR2QNXxHTvgPYICvAgA9L3tcK1VffIaX1ByDjwwmquXcD3oBu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhp4osSEvI4ztcU8d4IuGmxIFL3FMKqG7sgCa9+E6cTrbBL9ZQ
	KD1e198SJdt45sjoQIP0JyZcSyDbgzRBlVmKzgGxNIfm5EOMLOZ5qhMAS/yOuy65R5irZY+5q7X
	W9N+kLcKklfmojaHWcJMS6P3yjkvJPg==
X-Gm-Gg: ASbGncsvYW4bsjJzTjOJUsVony3M5zuymatmcV+PAMu9SXHJUoSkyp+9qvMyzbRvqNU
	JOQod4DmhXNNlEg0Rynm28UxjN7uopiT3uNCSKpPC+lILaFensWZGSn5NhI0yK562TCrLlpwgre
	iNoaXkJyiC1NAiKWyU0NkxEHBkPBHUMsAz6j43DqfQeG4=
X-Google-Smtp-Source: AGHT+IFlXd9TXmbgPHTA8gAIX494c7LaBmUhpPKwIlDuYwjBU0pVnyw3tgKc4C0UD+q3aEMZ5y52BjfVcoqCXZMVoHo=
X-Received: by 2002:a17:907:9d19:b0:ae3:56af:5a78 with SMTP id
 a640c23a62f3a-ae356af5c57mr992092566b.41.1751282744846; Mon, 30 Jun 2025
 04:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250616100406.2853-1-ujwal.kundur@gmail.com>
 <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
 <aFGPVPDKGLOIEucg@x1.local> <aFGkVh-rs2ZqcL6g@x1.local> <DAPKLM86IC4F.1MCOR35P2D9VV@google.com>
 <CALkFLLK2-SCPZz9tOseFp4Ry77GYg+LKik0SEbjK6LuanDyyKw@mail.gmail.com> <aF1VURZrk4vGlOQL@x1.local>
In-Reply-To: <aF1VURZrk4vGlOQL@x1.local>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 30 Jun 2025 16:55:32 +0530
X-Gm-Features: Ac12FXyAuAC3GXUH-C2j9o7z64av1Pj-08W1BtLlY7PXo7lq7AVWZO3NYnnnHZg
Message-ID: <CALkFLLJ8VR73u4B5Q8q-eCZWNbzBrkVj7B2GwVexkuu6ma6FVA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Peter Xu <peterx@redhat.com>
Cc: Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> The script I mentioned in that other mail should help with this:
>
> https://github.com/bjackman/linux/blob/github-base/.github/scripts/run_local.sh
>
> That's my hacky attempt at a "hermetic" runner for these tests, it
> ought to let you get the exact Kconfig, userspace, and QEMU command
> that I used when I hit the issue.
>
> The GitHub workflow definition shows how to get its dependencies
> installed on a Debian-alike:
>
> https://github.com/bjackman/linux/blob/github-base/.github/workflows/test.yaml

Thanks for sharing this, I was able to reproduce and fix the problem.
Turns out char *area_src_alias, area_dst_alias, area_remap were left
uninitialized in uffd_test_ctx_init while it was working before this
refactor because of the global nature of these variables.
Using virtme-ng also helps me ensure that the next spin on this patch
will work :)

> Ideally the test changes
> should run the same before/after that series applied.  Meanwhile, no
> conflict expected between the two, hence no worry on the order to land.

Sorry, I meant to link the uffd_poison_test changes [1], I've rebased
on top of those changes.

Will send a v6 soon.

[1] https://lore.kernel.org/all/20250620150058.1729489-1-peterx@redhat.com/

Thanks,
Ujwal

