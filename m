Return-Path: <linux-kselftest+bounces-4543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447258527A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 04:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686DD1C23360
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9978C0A;
	Tue, 13 Feb 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIXNrED1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15738BFC
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793649; cv=none; b=B+3i4I8X6OSflJkHViBgfMqDgDISGiN/G0R7PO4l+AyZhUktP6z965dJw/JLxYcU7XVXG6H7PSMEIdbSshtV+qZyzlAXRiyUOvNc2GaEqMB7/4480W0NH4M3vN1bbdjj2AehpR+qbIV3t/c2HaTGoBEiMfBD0VOSNqwKv7E3ORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793649; c=relaxed/simple;
	bh=m1/doowd5GK+v7WOSqX7sG6jJ9oDJl0r5asumkU4VaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DaDCHBTNeNKXeQHAvgxh4e4PAvGMQcd/KZsHIoVCaM3GWm01olPZIj+KkxXeKH/EJ8ADPTYTz/vq0G9/XIBSNg0HjdcNYlqcIaZ4b2N1NMeynWEL6yKKGHx0c8dR664w2GgW7bZCOerAgujoz4oajW23i9+l2tIOIW3k95nzm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIXNrED1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc73148612so488390276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707793646; x=1708398446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDyGRPlFXhZbZuymw2eh2GCe/IMO4/k7iwoMfqLh98I=;
        b=kIXNrED1UDUnOJU6YRZzdTHOzmoS1ZuwPfb4UAxiwzgRt93NpdO5GFtQ4rh8MzDO7O
         UJBVkFW4jqMzHHlx9CLIkZrguCEuvHQx/0ZbRzSBb1fdmnESnCF/lEtbePkvfkxRMN6T
         xRj0RLoCuDbm713uuEA64ezEU1yKmbg0eOxCa/nl2CPt55cZNtDCEtxm42WfGZ6CmgOQ
         Qmgs6mbo74aef1R/X39FYM95rjF9smizRwu+S/DrRjE2Dk87JORaPqtDnUKrsrF6fV+l
         wLifwMv9cVWoBgtLiCJM5FJJLwSN0hdpxZu/UrvKwpRGzcedPdI8XFJQJ5SVX0Ey7xfR
         YaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707793646; x=1708398446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDyGRPlFXhZbZuymw2eh2GCe/IMO4/k7iwoMfqLh98I=;
        b=cK+OPKrz+LAjOGWPPRBeHTy0+febxsqtuYI1IPDJNn9hQBrGR/FVi3BlGndVjYrdpM
         vxcS7pJ0YrK3Q2xlMQCQXgNxnhqRmWc4ojcJgYLufvOqrwxNMqX0Bh2KVpP0t0YrlZuQ
         6pb6GhFQrfK3+RKhfrsUfEQxTKYUQd0cP0nVDBDDCrlXHmRPhoz19eEUoyJHHd0JEn4L
         gHikeHjT2D2arhwrRJyGQ+4g8ABbbx7DwEiV6NeO+4ippCWJcOL+ZxYbkJhOxJ3LmPfh
         +fXeHKZv7iCXw2veZJ3oxQuMiSzoHcQykLQJODYwUOGM5pYA+YKgdXWV78b6dpc0p9Vt
         nhRA==
X-Gm-Message-State: AOJu0YyiSZCUtR12OdO873zRzoY6J/+rcMG/bKVLC3rtmjMgGf2upwlT
	GKClwkIy/UFAH6Q+bli6U2bBsYPLM6Lv4iV4Se0SJEyGQ+nVS8sHYMnGHdhFVZ4DYFBzW4Khtb5
	jhg==
X-Google-Smtp-Source: AGHT+IFx8TR/MIxlLVsYexKB/j+RGg6asZ6+QdHFN/AKxH1qPhN1E0yuDVwBXitEVuZTu0mnkbf32YdKgAI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:709:b0:dbd:73bd:e55a with SMTP id
 k9-20020a056902070900b00dbd73bde55amr389575ybt.4.1707793646745; Mon, 12 Feb
 2024 19:07:26 -0800 (PST)
Date: Mon, 12 Feb 2024 19:07:25 -0800
In-Reply-To: <20240103084327.19955-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
Message-ID: <Zcrc7UxSO3-Cncjm@google.com>
Subject: Re: [RFC PATCH v2 0/3] KVM: allow mapping of compound tail pages for
 IO or PFNMAP mapping
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	stevensd@chromium.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 03, 2024, Yan Zhao wrote:
> This is a v2 for previous series [1] to allow mapping for compound tail
> pages for IO or PFNMAP mapping.
> 
> Compared to v1, this version provides selftest to check functionality in
> KVM to map memslots for MMIO BARs (VMAs with flag VM_IO | VM_PFNMAP), as
> requested by Sean in [1].

Doh.  So I didn't intend for you to have to create a mock device just to be able
to run a selftest.  I assumed it would be easy-ish to utilize an existing generic
device.  I take it that's not the case?

