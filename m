Return-Path: <linux-kselftest+bounces-35048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3CADA85C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DC07A159E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C881DF246;
	Mon, 16 Jun 2025 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPDkcRFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F681DE2BD;
	Mon, 16 Jun 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055919; cv=none; b=QHULENgkYr7sCdIXQqGMkkfj6L+LrSIhZA9S5fxBU9ECiztFfaeMD4lRgDxPU3kad7uSgSknV/k7+1/hNZyYCH7M9I3i+ZpoJE3p4KHO+hWmwQzpLi5gRViID6ZIRvyZNYiv0Ggii9mC+X5VpDANe2FZN0GEH1gLUcL970Z0OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055919; c=relaxed/simple;
	bh=j0tRNlJLpdyvZl0mIxgoe0xQ1+jjmgBWLJvVQPy5YbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egQG4JJFPuE4fW5cnFSeEPQT1D13udSAWdxzLk3ijuuw47aLubQGRoSfD2UjRQsaykyxEtvdAPjalOBsVMN8JeVU/r5uqDtRHO+hl269v9PpPi/SUxZinS/dnTgF22BoxKaSfeVLyeIo+ATfrsnFvH3ggQ9itmQj9oTl4ub+bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPDkcRFp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313a001d781so3748131a91.3;
        Sun, 15 Jun 2025 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750055916; x=1750660716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0tRNlJLpdyvZl0mIxgoe0xQ1+jjmgBWLJvVQPy5YbA=;
        b=OPDkcRFpJRMSjpv54GtgsEkQ95NMjaIbbzxk/ceo5ibb4bFhswunB7xImElv/Fkmth
         CKyaQ0Y5n6CRJJ9D5g0pYdDb2hWx3xyZfT2fYtWEq4lWR7a4K6NB4xp9Y0fh5LXzVBX1
         UEBQgElYImwAa2FYdZYJag1bGQ0gjTzz/WfvNyUDjvksxXfcpe6J+laaCzGdqJ2qN4ED
         xPxkqoO+VNeBLJ/AR9Mi/ag/cSLZLlMOaKyLGxko2b2KUadBUoWc+1w7W1Nzk9S57xf5
         vToUYS94k6VuWB3kZ0Ii3jL9VxrzCICJiiXzyodF6h7xP+uCgkRqyNkk0yJ8VJrSnByl
         lCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750055916; x=1750660716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0tRNlJLpdyvZl0mIxgoe0xQ1+jjmgBWLJvVQPy5YbA=;
        b=ho+iFq89TmFlMucZZgGq0qohVphwbxpZkpu7D7rZ/ORyi1GEqNPsjW9/2JKQ29doIa
         tLh/gJ+D8knM7NeoYs3cHWEV5a9eBgBvbIOYyWLBNyNujewS6ibDQcvRfyGwG69f0eBd
         S8NhIKvxrhCq+jW4PHDlpH2OBgKC1pEijb8phssg1slZCQn0XxkfkpmvLlbbISBjhLXd
         A1LPNWx3GA03D3fNvFuiFc2q7xwIS22jlMDBr99lzncRzhU0yWFDaqc0L6HHcGyoiFWT
         OGx/5sNU/FlXUUUqXPdKakN23Mv6CBFTwIFG4gEOQX9csMjn2wNF+L6rdwJwHsNkvv6r
         ekig==
X-Forwarded-Encrypted: i=1; AJvYcCWEqhDdB9mxpf2maaVTTOxWLC5kIlXR51YLi2aQ6mPEq439K2R0+O5rjclJ3CvBK2dPnbr1NdW4AKhP0MI=@vger.kernel.org, AJvYcCWPalVHEHn0ed79eRx59b/8D97i2k+m8+/ZHDN3kf8PKlzKMVv6ptUg/o0tc0VtHAdgBBmjQe3Okr20XiiuGt2W@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAjLeU2GH3DXIvu60GlbEjGhaO6WejLgTCkHpk4jN2MBPHIfb
	7PE87VyGCeVUaeUFSavRPe0hl/jLM0n+4OAiJYh3dGctHOOIHz4FmMIigdRGsbuhwBw8rYFz3O9
	Oj4QpsjXOb2ymrapPnSezi8/ofrhEEg==
X-Gm-Gg: ASbGncvTbXAHQXB2tq36iNltFV3hhwV60GGiPt40m5FkQPnw2gbWc7IFxp1r1ChGBDX
	9/DxfNTU5HYU6J8PsbL/7EGbYVsROoTerXSxzQ8BaGULcyCx97Z78zHDeRNNC/xJ9qBLrkQiM0e
	r2S3TR2P4W5GsSoGQZ43J/OeJTSTdMDqTuhDEQFqxhxN2y
X-Google-Smtp-Source: AGHT+IEQmuo+vL5DDj2INvCFfoKg4r9b0HxlnKIL+B7e3aP6FbOm30oKU+CcD+1HpQ9Zh43IvQI9CHVdoXJ8uzK7O3s=
X-Received: by 2002:a17:90b:540f:b0:311:b0ec:135f with SMTP id
 98e67ed59e1d1-313f1e22bf7mr12485448a91.30.1750055915803; Sun, 15 Jun 2025
 23:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250531074625.478-1-ujwal.kundur@gmail.com>
 <DAITJKYRQMFD.OLOUWS7UPGVD@google.com>
In-Reply-To: <DAITJKYRQMFD.OLOUWS7UPGVD@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 16 Jun 2025 12:08:24 +0530
X-Gm-Features: AX0GCFt56CmERt6ve4-ANd9_KWfMkOS73gp_KuYLfTvWYMofoQ8g_CgjlTWpnow
Message-ID: <CALkFLL+kPAWcXrmVf8fEWdNcuh0O=s6FVCF4xOUo6PcAOmsrkQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> And I hit this:
>
> # -------------------------
> # running ./uffd-unit-tests
> # -------------------------
> # Testing UFFDIO_API (with syscall)... done
> # Testing UFFDIO_API (with /dev/userfaultfd)... done
> # Testing register-ioctls on anon... ERROR: munmap (errno=22, @uffd-common.c:277)
> # done
> # [FAIL]
> not ok 6 uffd-unit-tests # exit=1
>
> It reproduced on a second run but I haven't dug any further at all.

I haven't been able to reproduce this -- both with and without my
patch on mm-new and mainline; I see why you've commented out
uffd-tests in your test script :)
I ran into this *once* earlier when liburing wasn't installed, perhaps
that could be related?

Will send a v5 soon retaining the test_uffdio_copy_eexist variable as suggested.

Thanks,
Ujwal

