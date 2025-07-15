Return-Path: <linux-kselftest+bounces-37321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB8BB0507C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C0E7B3192
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 04:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB42D322E;
	Tue, 15 Jul 2025 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qCM8U2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA2EEC8
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555143; cv=none; b=By53I5rpn29uCIcBAvnK1BPO8/1s1Tvfl/eOCiThwLh6PIVpTD/ABH/LD53rwMBxhqPGH4TGsaENxAi3SBkCDZf12q4Uj7ugFrAuemRtEkiOMkQI8G1X2wWAGVnooaum+9ro9EGrWQvvpuk+Gj8SqJ7zRF/HYqrBvXvgTBc2ivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555143; c=relaxed/simple;
	bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0vdOP9UnYHCreb6O6QF08b3ySP+jXLBksPiw2db7B7t+WOCJX8d40sacnLezXlo0aKnZfLFwTdAMn4V4bklZXDsU74TEVKk4U4hGIG626X+D4fep/IDHJ4FoJdYFUHP+LP+Qv1372RM07WvvPPgtKOVTj78oEHlhqR/2HKEIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qCM8U2T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso237841cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555141; x=1753159941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
        b=2qCM8U2T2GmqqjHeycy0hR7orZnxQvfRKN1cTEqqTDU6BXSorfYCxwX8sM+luBubuK
         T4DF2JXAAasFlVHyGVmMSUc3f0XE//XClxJaqUPY//Z4xHDRE8LlzWpMgR3WWK6RmlPH
         lkrIjmw/4SXxFCWRCIElkQpDpnQ96hGPrspf+Mmn733JXQ8R5sx0TYqqBYlHMurGVt85
         FD2SSaqvSvd+6xGeZgaZ4V7OzJrYHQ17TOxkvvLEchhmd93vuwtOSTM2ZlVpwPEY2CmB
         akYRVcaEFSFwb5FpsoIOmdA7y8hGtIJzoLNAXqzW4slDgNN48Nf8n5MnVPqF/h5Aqo4x
         /Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555141; x=1753159941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
        b=vZ5Q+Uz1GgZLzk72Hb6SFdyXTq7N+VYOv3ofdffKi2+s3rlqrBFHeQRZwYDufM+Jck
         nQSdj0Y3SyWUURuZ6YlMmkqI1lIpLq+7mHQ0L6zUi33QR8Aw60ZwvR+A689/2SME17vU
         zDAJhSWCxk+jUcLamrbCppoomE84Oj+k+cfJg1SdWtcu9MJF0FkQzV4qX/gTMumHiCuJ
         B8TnOLCkods+v8py7rnXwTKbDYmGum73gaEmt8RrTcIEvyhbvKp8v67HfBhsW8N75lVa
         7ewUtnIisB4bII7vt2wNQg3p6cy2RsS3n22+00lCmnnrpYX+/hM/OLP+qmJXST1hfrK1
         yr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWheBvjAAzOmFnfixpAWMGBAfj7GANnGFfEgQuV0Mg0YdCUUuX1Ay/wKaBHYOqpKr0/DWJMGHomGRfW60LerT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/fyvaGy081UKti5SB6DXpcv/OwqC8+44QfMum+J8L5wtcZ74
	1g9bQEwIi+fa6ACW583ePIhd+HSfoHH7kW/g7kxWzwAYee5Lr+d5UA4JUd1Mp9vXB6RWjA/8m/7
	kz7QMV8zCw+3tjd5rv0q2GOGRGQm3JbRbkAffOCxp
X-Gm-Gg: ASbGncvtpE1REXmGyu/9ej8aDK54HfBPyp0yd3LhukA5h5nQxYRzUkMWi0qKi28o3Lo
	s+k8xEH7oOAga7kOMd923tKKug0N6rh35K737FbS1/JbFHqqEUKsT8PfQkleFwG9eFhnwANomZ+
	YNJVk+dEaS0V3Hk408GAGYwfric1s3Xy/QTl2LW2vl1Sw0OEBUSvIGDuQv2277zBL37I1TFGhVU
	24RMQ==
X-Google-Smtp-Source: AGHT+IED7N/lFrOYBOYjF0Dvn3zylukKfxNlLoQX8mf7MZZJLc58OLah+XC3MNlIKZT5qh5n2NtYRCvvSWgJnwsQexw=
X-Received: by 2002:ac8:6909:0:b0:4a9:d263:d983 with SMTP id
 d75a77b69052e-4ab80cc6f95mr2687821cf.22.1752555140881; Mon, 14 Jul 2025
 21:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-3-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-3-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:08 -0700
X-Gm-Features: Ac12FXy73gl4GP6af37XKxpu8Kr2I-Iyp6kE6QBvVYc6xfOcNLtXE2zrbgmOfwU
Message-ID: <CAFuZdDL50S0Nos_U07Zt18LwiKEz=ChyEt0d6qNWeMqKRS133w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] binder: Store lru freelist in binder_alloc
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:15AM -0700, Tiffany Yang wrote:
> Store a pointer to the free pages list that the binder allocator should
> use for a process inside of struct binder_alloc. This change allows
> binder allocator code to be tested and debugged deterministically while
> a system is using binder; i.e., without interfering with other binder
> processes and independently of the shrinker. This is necessary to
> convert the current binder_alloc_selftest into a kunit test that does
> not rely on hijacking an existing binder_proc to run.
>
> A binder process's binder_alloc->freelist should not be changed after
> it is initialized. A sole exception is the process that runs the
> existing binder_alloc selftest. Its freelist can be temporarily replaced
> for the duration of the test because it runs as a single thread before
> any pages can be added to the global binder freelist, and the test frees
> every page it allocates before dropping the binder_selftest_lock. This
> exception allows the existing selftest to be used to check for
> regressions, but it will be dropped when the binder_alloc tests are
> converted to kunit in a subsequent patch in this series.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>

