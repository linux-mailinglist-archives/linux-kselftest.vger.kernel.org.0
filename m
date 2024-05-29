Return-Path: <linux-kselftest+bounces-10864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700108D3FFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 23:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D601C21F2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFA1C8FD1;
	Wed, 29 May 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijRmXGee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BD1C8FA3
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016644; cv=none; b=cExRvRKXknnCjrypp6vRZzITUkmZ+Bg4gpXhIMipo291VCme6uDiYDpKjJQ5vsl7kgJOLnd/xo7sxwwkUeXL+wNREmHYTsk9lBE3js+oW8yifFMUFEbsg6SISIYOtHbJVYcp3NyWG4mNTx0MMixNt3ksj+TU10O2x9yMeIm+tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016644; c=relaxed/simple;
	bh=BCBSe826+nKw2daLQ4TIlXiD2I054RSipXGDwuLppXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoIV+PKpo8g3Trb0fKWIfczlKM08Wb4tL8RiZK2qQet2KP1W+x+tvN7+jAlJUhq9ohu+twRYRRRg/VKhSu6k8XavDc9Iaz+7rojhGQklQiVQv3BKb7UbptZyLl7j9YS0ZTOv0+rQsljuzGTYu//ARsyM0qbDrej3ogoQLGYelME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijRmXGee; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420107286ecso21565e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717016640; x=1717621440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCBSe826+nKw2daLQ4TIlXiD2I054RSipXGDwuLppXE=;
        b=ijRmXGeehgI5neC/TycAug7mg9rG5pDgOZvkwGtuJu0Mbm6pCFIKJJEmsjebY27VN4
         TYxqZUnaQwiGe0N4+pHJr9YfbZWWkpOIa0EAMt5v4sQgsxfOBGzB+ucbFyg4FVeEYAi0
         m4agMhgSlwT3Nh5p2vkLIV2K0te9MHyVdPh/jh7rj6CgsGecdwrVkD8XSYgOWjDYU3jf
         ME2TKK9utqccJwGFaIQsqjGIEe6xx5MDZQfupSmeD5MZkTY6bj6omccpJZg1KuTKpNsa
         LZJu/3OssGgYM8xlkEmpXmJYtJw0idtnC6CxfTQPi1TgVNLXCnCPBd/M3UljA9velwvc
         rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717016640; x=1717621440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCBSe826+nKw2daLQ4TIlXiD2I054RSipXGDwuLppXE=;
        b=c+CWAh3gLo24HnUe/UEIY2wY0AGimMkDP1gGTg4rZuD0OgcxjFf+LtkSWHUZN77TmM
         lPQGkJa6/PRXCvdCQ97wurC8NvhaZLNr1LnB0+mTUqKNrBf6caM9wAmCuayX34x3yr0Y
         w7S8894jcW9gh2OncfqrmqzbMef76cHgQZfc5GoL/paT19MBv2rNw/mcJJH9RQoXL/CN
         K6E2HbrKvaYEKOb0JmUb06g/X9I0suxm0cFz2Avy4gm+U6JISzRgF5pc5N7WFdkEXkB8
         Lb1T8vej3tb4mi2cm1Bez1dMSPQMzE8Y7EbwcV1DLg8R6tSFt5SGSMNKXt3O4IxZC2yI
         5UBw==
X-Forwarded-Encrypted: i=1; AJvYcCVeUfndDQI1WyGb84TSNBjnzJdt0z7x7ks7FE+zfU/3gclIu4Qf8l+RlVF6WpgpuE4JWiu9gros/V44+b31lUMLCIFuRQm8L9HA96TQxZ3r
X-Gm-Message-State: AOJu0YzmyiodSmL6zliLPGg/rxvQaLVQtQgV/HnYkfnFaUO/TySDIJ58
	agMroDkXJtwdGMqpX5LvsqmKLc63AGEF27w9YNmidL4JJACALQ2CUqG2Ya5HO1bb1M0RpxPZWDW
	KX3NnuHcroqoW0FwUCE2SNHFypleeC17gb8Aj
X-Google-Smtp-Source: AGHT+IHwVBgFo5das5shZb/z5hgC8KCkV+Jkj5w99z9LyfmWhmSM4ldtkdm2dxotNGGlvICz4N/Nu5ZLrwoOjjiw7Io=
X-Received: by 2002:a05:600c:3b85:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-42127ec7dbdmr148185e9.3.1717016639372; Wed, 29 May 2024
 14:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com> <20240529180510.2295118-3-jthoughton@google.com>
In-Reply-To: <20240529180510.2295118-3-jthoughton@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 29 May 2024 15:03:21 -0600
Message-ID: <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:05=E2=80=AFPM James Houghton <jthoughton@google.=
com> wrote:
>
> Secondary MMUs are currently consulted for access/age information at
> eviction time, but before then, we don't get accurate age information.
> That is, pages that are mostly accessed through a secondary MMU (like
> guest memory, used by KVM) will always just proceed down to the oldest
> generation, and then at eviction time, if KVM reports the page to be
> young, the page will be activated/promoted back to the youngest
> generation.

Correct, and as I explained offline, this is the only reasonable
behavior if we can't locklessly walk secondary MMUs.

Just for the record, the (crude) analogy I used was:
Imagine a large room with many bills ($1, $5, $10, ...) on the floor,
but you are only allowed to pick up 10 of them (and put them in your
pocket). A smart move would be to survey the room *first and then*
pick up the largest ones. But if you are carrying a 500 lbs backpack,
you would just want to pick up whichever that's in front of you rather
than walk the entire room.

MGLRU should only scan (or lookaround) secondary MMUs if it can be
done lockless. Otherwise, it should just fall back to the existing
approach, which existed in previous versions but is removed in this
version.

> Do not do look around if there is a secondary MMU we have to interact
> with.
>
> The added feature bit (0x8), if disabled, will make MGLRU behave as if
> there are no secondary MMUs subscribed to MMU notifiers except at
> eviction time.
>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>

This is not what I suggested, and it would have been done in the first
place if it hadn't regressed the non-lockless case.

NAK.

