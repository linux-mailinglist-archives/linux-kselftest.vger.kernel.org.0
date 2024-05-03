Return-Path: <linux-kselftest+bounces-9428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9C8BB457
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F61283EF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98F158D62;
	Fri,  3 May 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjsYKxmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1269D51A;
	Fri,  3 May 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765844; cv=none; b=o65FYk/8WIysCF2ZMU0owfRdEGuhIuuypu4NOuc46mwgbuSO7ND/FRUBBZ96nWhNwXBds8gJDsbGIsxRL2DaJP9kMkHtgHm9a4WHlTw75Q8srOHudmQ4E0SaiAWwrbr9SkWt465ghJ5kKzqjblhhldtymRQ8QbIIwKy3tq9skQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765844; c=relaxed/simple;
	bh=KN3OMp2RxTcIZRuhyPTjSWHGJjFCoqc9Q5ufOJcmQ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEDUoLOr0zFAw0mBeThMkNqz1hHHKiz/BBGoKPqx1GVT5xugFEUZCcs2InlnZius8UfA8cW3uN5T//eXBPZzNCmPacDJe4QJu2kJQy3XS1CB6LWeC/3ng0GyMwoAu9cwg19NTgxirvM0YwC+/LqC0AszRGKYIec0QUoxeQe188Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjsYKxmY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a04bae512aso264226d6.2;
        Fri, 03 May 2024 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714765841; x=1715370641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuVUTGivGv+RNT3apO0p2n+zz8phIuPLwQeuA6Csm8A=;
        b=IjsYKxmYgzJ6QPqKHHfiZjZBG+4Aupn9Zv4gT0HYIgmD/kCuYpWwZvOEHkc06AhPJU
         JV1OBrbtFRlKgqE4Hfv/encjGtYzN3SZFAjd3eWL7abu0HCFYzNaIkcKytN4pVQna5j0
         KD6hh9rE+QCuFIiq6UA97yPZvjdOXIGIdUarJGVx6m8Js0eta2xZE1az2PPYoQFQrbAV
         vm0cvmZwi26Pztbu9YbKX8txReXdEKh3vNhJnZe7dn470VOCIRotjZNivXXOqJWqJofj
         iO5BlM5JtgySYx/7A/zZ7iYWBMkJLGBSEabMxekSZA1VefdEij/TyhO4k3TG1iW2GpbG
         cQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765841; x=1715370641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuVUTGivGv+RNT3apO0p2n+zz8phIuPLwQeuA6Csm8A=;
        b=GkENZD4CjwwsIjO5i4FUf6UYkFUHGBzDzGCpLx/Xz5c/DH5K1dSQH3HFhhE64JcCdJ
         98Bc/j4HguRQva4khcgnw7k7TC0FmhUBnrdiKK8ZQ9oujcmJ7qEEEnm6SvbqnZowNTCK
         SZtao2tNvP32gzfFtOyAdmtsoSy1XICIHrlF1tbEL7ZLv9+XGfuemMYRfzq9snJPgU1D
         ggowPqfoSWYv3KJREtMbkgdueHHtqHP2HWqVyixMejBN70Vd874wvJMlQphF8YUqoQEj
         0r17GWyeJvUi9w5wWPQK8Zmjlr9P9vYMN64whUBe0jsUDqbbXmVQAL8PvNcMbRpr/x1t
         ibNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaoMmlcw6ZX5I0EKXX4DsoPd7UK3m7Og9pAQupoBei45dOnwMCLteygjmvUxobHB0MOiSoYBFMU8OtVIvj1FS5/2RoovkrZSjXk+/CxSz8pqtFdM6mmhEMR32V+YHdZkaLcCuZopp7TikvQSAfNahl06St698NK0fkVAdATVo+KRcizlNMtQ==
X-Gm-Message-State: AOJu0YwohYinGBzpnVOZB0ok26g6RWaifglNTXCwXlUoMaCXuTswuFhg
	03zFU/mowiFFwDc2oo55u5Lf2Hfie9WpUGavHAs2S92JPhuSTswzZUv12w894/v8fatKygciMT3
	3H0C/GIFv5OLdZU0aNJk35Kic1lM=
X-Google-Smtp-Source: AGHT+IHwsKaZ7g4EJ175fFjyaFI1whbPu9tvhSXfH4HIZV0Fc9Dc2fTEfVQKadr/oY7bJDXaWRRTj2m7au4X01JgX1U=
X-Received: by 2002:a05:6214:da8:b0:6a0:cd1b:9f9f with SMTP id
 h8-20020a0562140da800b006a0cd1b9f9fmr3712807qvh.38.1714765841550; Fri, 03 May
 2024 12:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503035105.93280-1-jhubbard@nvidia.com> <20240503035105.93280-5-jhubbard@nvidia.com>
In-Reply-To: <20240503035105.93280-5-jhubbard@nvidia.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 3 May 2024 12:50:28 -0700
Message-ID: <CAKEwX=OzV+hCXwwFhnAWKvsrDq_vMaS6GaJgRn8LG_EsB80OCw@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/cgroup: fix uninitialized variables in test_zswap.c
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Waiman Long <longman@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 8:51=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
>
>     make LLVM=3D1 -C tools/testing/selftests
>
> ...clang finds and warning about some uninitialized variables. Fix these
> by initializing them.
>
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f=
9ed7d1c49f@valentinobst.de/
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> ---

