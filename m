Return-Path: <linux-kselftest+bounces-44164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EEC12241
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6824188892A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E728F5;
	Tue, 28 Oct 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Tn7f9yCQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CAB672
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609850; cv=none; b=anJkd5pt/AI4zlhWLP9RLSJ5Eyk00bgg9UTA4cpoVSh5cAqT+Rs8jvfenfFAFMJEaX3wli/hRSaSz+2xjtUyf87SbE3IN8+UUVmuCCzhHtVTK2nDJY2bGUJL1mrgE6vOzd1nq/9YeyjKHggc5JTBougR0Ap9qYCliL4LAhtPPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609850; c=relaxed/simple;
	bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/uyuWcD8ESOaHo4bxjr82ZzYQQ791v4/He440Yl+KqTTE7F8RMQ4Lf56TWGKxXoCQBxGUodzqVOFlCrLpxF5kproAlGCrLX2Q/gfjv/tLxlivN0h7Y4PwBFcOZTI6I/u83lZolnD5Vev4W6tcwQBwPpGPyMIGwpY9Q7WxCwKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Tn7f9yCQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so8144849a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761609847; x=1762214647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
        b=Tn7f9yCQWVdG/r3ho14VZKyB/48dXQU3HDqVKh3yGqKeq8ONhY4dObmDw8SSM8UOFu
         5va7BJ/MdyxJXapcqrcvcBL02AEU4M3S42f73c+bYIQ1aAttyqUMJEuPxhmahd4kpYz/
         QvfCQkvgZDjJF73j4YcUsPn5AzjIhSNBdOHi9qAbKIJ5itPEGNpPwY5a3QSznhxAVvic
         gzxOu/M2D4sjEnwEYJwPTlqyA9JUh4Jck4ofier5hQ7lYgJLjBZEZNV9287AohbETMRZ
         klR7hhmJenRG5pmA8klIR5ctsIQNi/6RRDR/tDKcc1O8HkaFVmOgv6tLQ51plMZW0ZMO
         ga4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609847; x=1762214647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
        b=gjiKhBPI3oIyWAlzZon2kGu3we6JGuUnJOe98Pu66eq9e4ZztCqjwenv9HByeM+DcN
         E3/YmKbU7Xvq6azjkpRGX8TTn09lSXF4p+fAknC5apHS2RSdvNnzG366Pw6EPo3jeu11
         3Qb7YvY0IKDJ849F4K4TFP7VE9Bo9Y5AeXE3ocdCJom1iKIPMY/VQ4sa7SpS5LhvFaEz
         0igf962x5wVTgZaWrc9fvN80gk5qp+mGnHF627gGvkYfHgNOqDYw/+xK5M1Vih7vi4Ho
         1QcWYl+dQr/xGNHp7jO4Hp3lVmw+KRil+k1zzwjr4TIpfyWBSmOZ8DNlWCs/qcuFrA4v
         wnsA==
X-Forwarded-Encrypted: i=1; AJvYcCUyR51iXJiNyhQLkWbnYfbGUTrajUBO8h1iutr6anZKFAxy8FH7pz8f7pFP1Mk+OvQYWpusmnz0VxujwPBzcMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYK0RsPMzoFJP4/Agdh4fd5B7j5zEVe5C9MztMcR39gsq+iza
	INUMn+iaTx0O4vWm2eJQI7Cww5kqWqE+X5d8bzhSRjzTX+bVh+/SOeTLtOxFCTAo645qeRqKeGx
	nW89uBMwHNd1c0mZI6sflNxQ+dcu3FJIERm3AJEa/vQ==
X-Gm-Gg: ASbGncuODBrKxUUZ3jTw0xnKDyYGecYxAW3UuDM7CAoUe7zNSWGPQkLy8ExSRAa8eCp
	7t78Zy0h2oEWyV05ef+ebXmp9nGj+jUb4NtOaghQYNQMTfz6ApSrgVOKADX8LdrdMY5J4paMtGm
	HkB7O96xgVONspi2icUJaCErUrD4NMZBa3tvq3dokkwD82T7JpAKjcBHLHRxflpf6Igdf3isB2t
	U1cWpcbIF4JraHBjRGuQPi1QzX2nsctoM8Al2EG1ieMaN5DMUU9DbskUg==
X-Google-Smtp-Source: AGHT+IFTSxT5C/qi2iJ4dW36Q64XxwPLdzowo6gGddt58jWhCVpKXMJqTgXpnFO8ktQqxcCj5WA5879rgg3vpN1c4fs=
X-Received: by 2002:a05:6402:50c8:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-63ed82613ecmr1478635a12.32.1761609847331; Mon, 27 Oct 2025
 17:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-4-pasha.tatashin@soleen.com> <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
In-Reply-To: <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 27 Oct 2025 20:03:29 -0400
X-Gm-Features: AWmQ_bn-zfKJHiglHnpNE8yXm_PQCrs_rUjFkmbehJKOvSAt70K516WwkjY9HeI
Message-ID: <CA+CK2bAE5A4rvgxNzJbmdcTHWJ6LiyoQ5v8uMbTH4p6YxxToTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from
 the buddy allocator
To: David Matlack <dmatlack@google.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:05=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > KHO allocates metadata for its preserved memory map using the slab
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
> >
> > When booting via KHO, the memblock allocator is restricted to a "scratc=
h
> > area", forcing the KFENCE pool to be allocated within it. This creates =
a
> > conflict, as the scratch area is expected to be ephemeral and
> > overwriteable by a subsequent kexec. If KHO metadata is placed in this
> > KFENCE pool, it leads to memory corruption when the next kernel is
> > loaded.
> >
> > To fix this, modify KHO to allocate its metadata directly from the budd=
y
> > allocator instead of slab.
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Reviewed-by: David Matlack <dmatlack@google.com>

Thank you,
Pasha

