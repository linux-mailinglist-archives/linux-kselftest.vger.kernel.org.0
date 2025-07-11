Return-Path: <linux-kselftest+bounces-37095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC6B01B68
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71AB1CA1A7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080028A73E;
	Fri, 11 Jul 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebhJSSmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330F2144B4;
	Fri, 11 Jul 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235373; cv=none; b=kesY9SUcMhRa3wy2QJSLszeVieJx9RI6a2jnBcoTPeQoCdHbnwJ+2Jl/9ianrYDKvkwHq8BMhZhcT3Tgzies8e7UDtYIjNZGRcDGq7xe8IK3RslOfFHKC9TF72HQTDeJkaQgfpxZSoPfCPRGyOyAAyDULA9UyUzMqIu+R6opvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235373; c=relaxed/simple;
	bh=XsFF2I3r2LyLT3Mlh+lSG2S5J1f1unVaVJkKRBrcwWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcPIH+4JEUmaLToEoUmCkkqVr8JM4VlCYZs7qf0si7KenysnlOgfe0RLUWjOl/OGKle4NtiwGdshBlZ60RCPAJ7zmgYlXFepSgyFonE3rfk7K6SnV2D09xWSULgrmGVcgp5/JKjge2VMsLWSgMKyBtJsOQavfyzbpLqFMdhzzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebhJSSmi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so1743115a12.0;
        Fri, 11 Jul 2025 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235371; x=1752840171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsFF2I3r2LyLT3Mlh+lSG2S5J1f1unVaVJkKRBrcwWE=;
        b=ebhJSSmicdCt1irUv57fnul9kWxJyba7SME6uATRSy+OrMjko0RkFrNZlkE6xT64JJ
         DZyzvvayaR61YmgiGz4vYQ9u1rA4tUP4qJ3tHTZZcvOhtoqjFXIh1JjUpB8WXdZFHbOj
         YX/syaxRbZYAM8NkW6PSkpnGRP/nZWUbPBXRIjulRdzFJkr9oJkljF+hoWHMXMHIdChj
         Q9G3gBKhbw1sbiipZuvQ3Kmmfc6dBrC7DNg1CA2mNR3DBy97GgOqlmwR1Ozn69ArBwsZ
         87sNpx9x0ZxYc9aZTCu3l8juTjwFp86Rm72i2LGDOsgljVvNHeMK3cK9cEzdZTAMOguy
         AUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235371; x=1752840171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsFF2I3r2LyLT3Mlh+lSG2S5J1f1unVaVJkKRBrcwWE=;
        b=dPBPWRpAx6QqQRha4c5GtMEM6HXsDvbwdV0LutKPvs/c9oSILb46jKrdKAUOFFztPH
         x+M50so8PTyTM0FvA4An1hiWZAdHCt1rf/WNAfWcfewIxCQBw5APXP7+gonzxWUCZypn
         x6h8J0VaIinBDfj3VRbvM/s12Y4Lln8r949jYgAMiKguv0fBGUhb/Rv9DG5WG/tIAdc2
         Zlia/cgZBRyuv74CltzPG3j2kZB2ul0Iynr8ECPYBu7h3aKVASg4UEOSetZGyEGJPmlI
         jmUluiGMy4s22eb4HtSza7E9oS7O07zTzjhzhRuUI1rvNJSHsbzHj1drZN8JiHZw2aWR
         ykBw==
X-Forwarded-Encrypted: i=1; AJvYcCWOBzh4b9XcgzOUlcOEJMyjOu8Cn9YekzVfKX5JDaam5dB6sSpSUygQTExiijuekeIW2XFY+peufClWpuaDCYtr@vger.kernel.org, AJvYcCX0yA8RJjZzs0q5XRCIf1vJYYf5vXuxV41zvBDESPYOQW46TRCIWxZIFs8GNF8XmoR7CDqnB1wClE22uU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbeIVN5dW3Q1+9gsfmwSrrOf/oBl1LYsYgq6JOldveVN5Fv4PG
	bomwADukIqq0cdNTJQ5pABCjH/2M9/v5NolKKgDI/Bq9tlBRODKrfhyz
X-Gm-Gg: ASbGncsLw+gej7XwO7KFS7dkw8Zh4HxJ65517opMKhS6s22kZ9no6m+5g43NYNH/Wle
	VHkOsEtdH38SnGaOmBFHD7BYaLTr4bzDEtDw1JYheWx1PNtVqOc1MehHavJvUOITv0IU/DPKHYK
	B6gAVBzsPdF2aJ28SCsq21dC7rXiYk554DFbNmlwWYNYuWA8k9BwVWG8PHahgUQnnZd5CAU7S7z
	IV0SjlRZR4fpQcVKtunpGn6brbtWj+W/hvNnEyzcrVdmZbTYiCaciFWANjb3gk8xhjhvpHynwPe
	n8N4QQFPzu+RwLV4i6uE5kRHC0ImCIBwH1whfZW74293Ww1Rwq/Bh41gZo+QPErqVZ9Cp3a3ubm
	GHn2RUnRclXw+RZ8NxlK3WHWKQesRmqrwot1Wb3cokHvnMu/RLBRiLk8=
X-Google-Smtp-Source: AGHT+IFYWQ/ZoNjvtPKzQLCzn9YTVSOIlm6UJwjlTwkSQUC7rk/srKvasjhL4LUz8bqQlLKaz/2kWg==
X-Received: by 2002:a17:90b:4c0d:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-31c50e1763cmr2463122a91.16.1752235371389;
        Fri, 11 Jul 2025 05:02:51 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e978c75sm5660371a91.19.2025.07.11.05.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:02:50 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Date: Fri, 11 Jul 2025 20:02:00 +0800
Message-ID: <20250711120232.13452-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a6c8e519-69a5-4de8-a857-64459581233f@lucifer.local>
References: <a6c8e519-69a5-4de8-a857-64459581233f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

Hi Lorenzo Stoakes,

> > Hi Lorenzo Stoakes,
> >
> > >> + *
> > >> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
> > >> + * on a remote process, other advices are difficult to verify reliably.
> > >> + *
> > >> + * The test verifies that a memory region in a child process, initially
> > >> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
> > >> + * request from the parent. The result is verified by parsing the child's
> > >> + * /proc/<pid>/smaps file.
> > >> + */
> >
> > > This is clever and you've put a lot of effort in, but this just seems
> > > absolutely prone to flaking and you're essentially testing something that's
> > > highly automated.
> >
> > > I think you're also going way outside of the realms of testing
> > > process_madvise() and are getting into testing essentially MADV_COLLAPSE
> > > here.
> >
> > > > We have to try to keep the test specific to what it is you're testing -
> > > which is process_madvise() itself.
> >
> > > So for me, and I realise you've put a ton of work into this and I'm really
> > > sorry to say it, I think you should drop this specific test.
> >
> > > For me simply testing the remote MADV_DONTNEED is enough.
> >
> > My motivation for this complex test came from the need to verify that
> > the process_madvise operation was actually successful. Without checking
> > the outcome, the test would only validate that the syscall returns the
> > correct number of bytes, not that the advice truly took effect on the
> > target process's memory.
> >
> > For remote calls, process_madvise is intentionally limited to
> > non-destructive advice: MADV_COLD, MADV_PAGEOUT, MADV_WILLNEED,
> > and MADV_COLLAPSE. However, verifying the effects of COLD, PAGEOUT,
> > and WILLNEED is very difficult to do reliably in a selftest. This left
> > MADV_COLLAPSE as what seemed to be the only verifiable option.
> >
> > But, as you correctly pointed out, MADV_COLLAPSE is too dependent on
> > the system's THP state and prone to races with khugepaged. This is the
> > very issue I tried to work around in v4 after the v3 test failures.
> > So I think this test is necessary.
> > As for your other opinions, I completely agree.

> MADV_COLLAPSE is not a reliable test and we're going to end up with flakes. The
> implementation as-is is unreliable, and I"m not sure there's any way to make it
> not-unreliable.

> This is especially true as we change THP behaviour over time. I don't want to
> see failed test reports because of this.

> I think it might be best to simply assert that the operation succesfully
> completes without checking whether it actually executes the requested task - it
> would render this functionality completely broken if it were not to actually do
> what was requested.

> >
> >
> >
> > Best regards,
> > Wang Lian

Thank you for the clarification. You've convinced me.

Your suggestion provides a much cleaner path forward. It allows the test
to focus on the process_madvise syscall's interface—asserting the
successful return—without the flakiness of verifying side-effects that
are difficult to observe reliably. This makes the test much more robust.

I will update the patch to implement this clear assertion logic. Thank
you for guiding me to this better solution.


Best regards,
Wang Lian

