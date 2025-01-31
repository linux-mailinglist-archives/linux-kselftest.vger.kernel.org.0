Return-Path: <linux-kselftest+bounces-25485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B547A23CC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF113A383D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B91BEF66;
	Fri, 31 Jan 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLLL61Ed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A21BCA11
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738322399; cv=none; b=NVjHBUt+9tRK3fAAwOIexP3HllsesyJWe3/YCxW27+zLvmyzu+Q8yxyjD3kmZsSIa3ajqJgPwmn1Gf5T/kZU7EfNytw6VL1DOqkbx/3FEMKhaTbC/kzt6nEuijsExxWWYpdbVUaDAEE7hMDlkxkP4fAOxfS2V/71UtPk4jmPGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738322399; c=relaxed/simple;
	bh=t/1Bdz2vnYWGOFNF/aZoRa0rdJK6Inp6acUrQba2Av8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC2H7+ehTLq1NbgsK0CBBOgLoEZmCA9cXH2G4RHDgUilfcfl/Vx2haODyd0IxPyUc4C0WGo8EsLZLX8gQGQBYO4aQfCwZ1nMOSEqmnEiixOt8AU+Q2VVP80M2K6j7Vpxalr/WkOYXNosoUw7yPUfZbmcyBYKSwFi2lF/QhDTxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLLL61Ed; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467abce2ef9so196861cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738322397; x=1738927197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/1Bdz2vnYWGOFNF/aZoRa0rdJK6Inp6acUrQba2Av8=;
        b=hLLL61EdJ965kR0WRjjNUyYmzmmmtWZekJHCJB7PyoDlieQqFVDeARvsjfmkomASOV
         H4RwYHt2qw3smhIKE0N/oA7JM8r6jTsl+mDdxwmRMd7S748A9NEQ6ubrETVcA5WELHJc
         6IAMqX8rERNZhuPJmmFH2/ixuOME9TBQigmlFfWhnXP3l2ys0dM3S/kazkuUHk2SBGjH
         2zx5Zdicr7Q6s3UZX2vH+7rx5EkfxG1s11y9qRDzwu/fUAlj7iH88Ghfcusvdb/j954C
         q6WX0Zsk6ROoHcykPspIFRAqCVNzj62gfsm1xnFkSwaAElyZA7nr+Rh9QxMNVXn+Og4m
         M1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738322397; x=1738927197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/1Bdz2vnYWGOFNF/aZoRa0rdJK6Inp6acUrQba2Av8=;
        b=M4LucFS2JdAOccQj5y2STd4r3LZUo4pFCknEl5sjqJ3X7XWGdRncdAZ3HA2SO8LNpT
         Tntx39LEZMykoRkactJ6Tzt8tJ98U4q3jfQAhPRR1+aLAUGSjTTQH8hE4tTUifxWuQz1
         4Ia+PJ/XcxNjQdaYnRPbi9SCNZX7mina+95pow733w1/oVxqM0n5x228ZC+8/A6G61oF
         48gDtUjm0AVYOSVY/6FAhlk15aJmBM7zyB6usS395SedwueiNppgP1sU28gevJ2VoGhL
         7vD3ekiRGZ8ywe24xC6X91yU/MTAPdWa1WuxsHA1lwvKYXbBW7dS9xgnr1KT2T0f60Px
         QyBw==
X-Forwarded-Encrypted: i=1; AJvYcCXkUfIBhEHhbKOl4B0G/CeJcCuTVBpFhg6J21wgCwAnb6VQtX9TG1erSb10CSy2n11lh3vGO6StOJPom02edOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwADV+8raHcGg9TYzgE3gaErFLNaqSMtquxrZ2M/uF35lNOmV
	7pVKdPQXh2dmLlzg1POAXuXXZUH8hyG7lBXoFaeZz33t+rqkfWnWDuqXCPodUaceTg2W/hC4f4v
	Qq3z8hyz30BhPWmy77Mr2uYyUNcmjYnhUm5CG
X-Gm-Gg: ASbGncsPug77J5/Hy7LGqwu1wwApc8oYCoFAMRw1xP+kEpUmjTZBIV80pWxSrXRn1IG
	Xfx8ClY4rit5G5eCkiFj9DxDqHtLUO7OvpGXk1vZVxwezfewPJ+ZtQNqzFqXMESojYlEQUDwFTi
	g/PLYfuS5Iiy3USWrtXZP5dNFtTg==
X-Google-Smtp-Source: AGHT+IFQMV5owGTwkyaUt/GttHn0ge/tPUHauh8pIwzpMHm9ezFDU5ek3sx8ZlG2RPbA1EsQQSe00VyqS9aR6zZQ0mA=
X-Received: by 2002:a05:622a:1b06:b0:466:8f39:fc93 with SMTP id
 d75a77b69052e-46febf1890emr2403221cf.3.1738322396573; Fri, 31 Jan 2025
 03:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124-kunit-qboot-v1-1-815e4d4c6f7c@google.com> <CABVgOSnB8OeBgiBhkGyGiuXpJocUHimfS+aX75kwZ=DqvaWpPA@mail.gmail.com>
In-Reply-To: <CABVgOSnB8OeBgiBhkGyGiuXpJocUHimfS+aX75kwZ=DqvaWpPA@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 31 Jan 2025 12:19:45 +0100
X-Gm-Features: AWEUYZlKDWpX_XJXa9A8howuz_baVIVTZryeq5wmQW8_cg46hq8LehCg4M-sSk4
Message-ID: <CA+i-1C1ciaySyegzm802vmDaaSOONVdUPJRctqFvUoW7EdqXJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Use qboot on QEMU x86_64
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 09:45, David Gow <davidgow@google.com> wrote:
> One future idea would be to look into microvms, which might be even
> faster. I'll give myself a TODO to experiment with those.

Yeah, that would be cool although I think they require CONFIG_PARAVIRT
which isn't an entirely negligible constraint. Still, microvm doesn't
have to be mandatory.

Anyway, I don't personally think that startup speed is a big issue for
KUnit right now, I only mentioned it as a nice freebie for qboot, the
terminal garbage was my only real motivator.

> This'll go in post-rc1, but nevertheless, it's:
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

