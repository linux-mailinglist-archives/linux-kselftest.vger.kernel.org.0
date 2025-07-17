Return-Path: <linux-kselftest+bounces-37467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3282AB08280
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253B44A7473
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7021E3761;
	Thu, 17 Jul 2025 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxxRZTSX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA861C8611
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716298; cv=none; b=UqRN4H30+0lpHMLjZkwROOIoKmknAJ3BHyrqwk6+WX2QrG5tzJMBaekA14FaRWc5LmNDEtTiaS8WOs6wHTo6nZnnD+cZ9j32BgRtjM51yhNEU+d1YCvcWU0yTr3kqnMDGZRmTHwPpzIul73XzVNTBYfITO7OV6XDNphQA999HX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716298; c=relaxed/simple;
	bh=XEl9xWdkm001s4BWnfLogzuaUUgUnWcQGefbm9+v6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNdjbGhggIvo9DdRIFo0EhK1TdVwf2zpIZD/h5ly8fgZnL/A8kmKVEQLEhvnLQMR6A9S/R+4lgy8PTcirGjFh7KvbCbuNK5lWASoDbnmGflSLC2zD6RsZ6mCM2uDtOBovpLjOnvH7dF3YIQUBJbV78aKNtxS3ft1h7nMbYodcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxxRZTSX; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso51361cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752716295; x=1753321095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=OxxRZTSXtTD9FlCZefwGZvtN6zgTd/mAAiQ9U9Mo/GrseOIKTaNUvUz8B0epqcT0iB
         QzmkABZYq33cQD3Psg9WEmpue9OKSgCv6zkuSsv3+1HFIxJ228ZUvuuqWCe5gCsHGI3n
         hrKYRiD8GDocH6Ivg/ge/qeKQnVkETWEcKqqSVWyoyGeiNzeDrRpu4/AmLBfvAE0RUTT
         S4yNB2zd6Fafe0q7I9Bu/jqW81nOZzXqQLaLoA9OrkhKJ1GPgIBaLlXyiWR/300MhtxX
         wOBWdEzAX9m4DcqUwniHM0LkSwm1XXsUpFQt/oqIUSaVMf+12uyghXdG2Fd6opuF9vlw
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716295; x=1753321095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=VSofGVeCzpay3f8QHEW8G2r4EcYkCLDD1PwHULJh5VVVDdfGeYFd+W8D3lLjejWgBj
         HfrtgYkGv2CSGwSXc1w4/jc41NVnT9nqCcJuURO4W68jSw5LR4ljqksy7ex4KFJ1hDAs
         1U/E4+Dl114b7d2AGzDB17/PdGbxgleLBhADzusKmQymGvyCrPnLPLmSyzQhpbvJ3ELN
         E7rh6eU8OltwyFgVkLhIvQg2XDX/0WwMvF/+e9/kTZNexNQay6gpZfKa9vGy0CW9P9ko
         alOLzrbbbcjMDrXFJMxllPGmqlixmJ0mSZAtJKHTQRAkTLx3ESIO9/g43EaxlpBjkeZu
         XQqw==
X-Forwarded-Encrypted: i=1; AJvYcCW8IiGZbmdPmKgGWJLFTH01zBEPR+H8h60pHlit1usCPgcgkB5B7Wf6h6Vsq24NfDRBeNRuMmi/KyvBwqH8snc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/J8JqbqpPTu4XLop6v7IuzCb7dT4GUY1UjUfL9sj5NM6KhE8
	78ajAAHodAE9jwRuVH7ZAp+S6WXRYGTgmh0HhlfwAsk0Kn5GZo1Z/eUx76KyQYMukfyjChTPU0/
	v6kfUMoUBtogk9pq73pR6jy7i0cD0ZQYPEq/ybPHT
X-Gm-Gg: ASbGncssMN/+gX+ktlJoKXoSHq8d9IKitZqP5gTcplgh+s54XajX0YoaD+qJKIHt95U
	U3Yn8MHd01eGiRaDeFkPOk8P/rs04r9xmBM4zaJ/momoj/9bmOHZuht+B+tvN5SU62ufCt/vdur
	yQCrCR0sdR9olp3yoE6nBkFaIxGog+jLyecd5/CmnOvBX73FCOLStghuow8l39KRNAGgZqEKekD
	ne6rDw0JNfLtJOx
X-Google-Smtp-Source: AGHT+IFhiaeqzK2nQ8VSVgEqrMotFK2LCspw+YJrQhNSUfoYY0N+Vy0kgJUtxif7ZxBwweEETtv622z4tIyINzqhXvw=
X-Received: by 2002:a05:622a:a492:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aba2bcfa11mr1814001cf.10.1752716294281; Wed, 16 Jul 2025
 18:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
In-Reply-To: <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 18:38:03 -0700
X-Gm-Features: Ac12FXxcylNiHfdNrzrYc5xn0C76o-sRxtUR8Ak1vbrrsG08KbBBjpmWceaRzxY
Message-ID: <CAJuCfpE7TAZmk+y-BC9WAYMTH31Ao1PNd9H8h=0GCLEyXygUdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 15 Jul 2025 20:05:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > This patchset switches from holding mmap_lock while reading /proc/pid/m=
aps
> > to taking per-vma locks as we walk the vma tree.
>
> Thanks, I added this v7 series to mm-new.  Which I usually push out
> mid-evening California time.

Thanks! There are some comments on the last version as well, so
unfortunately I'll have to respin and bother you again once that's
addressed but this update should at least remove the syzbot noise.

