Return-Path: <linux-kselftest+bounces-36900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C06AFF84E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 07:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF12484A4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DD21E0B2;
	Thu, 10 Jul 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etk91LfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBF21C173;
	Thu, 10 Jul 2025 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752124042; cv=none; b=IC97RwOPLqrq+Lh7rZjbzkSCuPHGPrnBxuii/dhocwqUdBKnmdH9K8A5zbIGgNYD88rV1x7JH4KBNxqU5T7hmlsWu/jiFgUyms66WeuR2VTzhqJeJqEqejnc5qYZ5SMeFuV94A5Flq/gmoOX+KQ6wET8GGc9nr8sPKB/jfGCLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752124042; c=relaxed/simple;
	bh=UJZPhlmtWdBAIkWLIWhjOnObm3ZFZHnukiiBMSZQEuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8iKMtnqU3+3L6zBrE/K+M+NfAVcVSBP9/DoiFEX3i4u1Su+nT6oCTy8cCkkrbWLLToXY5SdbRLYf/DREfNZ8d7IkdjrmxyZywxjifRHpt3xu+WUUvuxyqNiePHUbrUROGIRBcmpHzeOIDKsb0PR/2lkxAc0qDkkhaF6/V7aV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etk91LfT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso837835a12.1;
        Wed, 09 Jul 2025 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752124039; x=1752728839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QTSZ2zin2g+3pt16pNyvgqz80KF68yI9KMbZz3WP6vo=;
        b=etk91LfTtrU2Vee85IUjnspy9ec1pA1qNxIE2ZX3GhqcxQHZqmOa3RmA5FmLNnktTT
         q96N8UUTuD9DyP1+EnLhU6fYNc506MWchP+Dc5c5UAv8K6KBKIVyB4zD7oB5zZYexgTm
         TO0pp9oJP44DclgJMQsQCwy7Wh2Lvtybo/JZ6mjV4vKYbG9sifLuJ2SQNvLUgEQ4SbhF
         D8DCeCFi+cXo9f4QxkVcqd7fA5RJsgr9GimvwX0eDp43Lf8DyMmTabDUJ2P+CY5SZsLl
         KFp1z7Xv70v1r25t57v07/q9HJ4y3AblAuasjShxRzpfq3A3zL0YtuTaYs7mH0aO7crY
         Od+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752124039; x=1752728839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTSZ2zin2g+3pt16pNyvgqz80KF68yI9KMbZz3WP6vo=;
        b=mF1hqg0wvvgRlNuDbQBYpuRjpBRJIC+I8kPnwj+pM7PmhGSJ62hIsIno0vTJ+YN/Ij
         nh3OBQvFIy5RNDz4sw7+8vKTggdphcDyB0pgGZve2m1I6SuhK/Z/gZk1W65Tx4s4Z9aX
         RtvRWRPGQRm1fcC9Cmsro+V45397NNNXtNq2Kd+KiYIHQ1/UxnyJ2pY/Jyco6OLUKc1J
         oAv3yytZhCMGplyD8A90LoSHhT7pCAxbAvDN7usn4BP1qgWGAkEqdI+I6iKYRL/TpGfY
         xTFLFbVoGTgVOiDdjugyeEuYbJ796YWHvWTKcsZzaTM75CsShrlpdWl8Vs/yzc8A98F4
         0Egg==
X-Forwarded-Encrypted: i=1; AJvYcCUO1myy6nduDRYcxQ8Sx8UbUOtaYYJHMPu0aR5oiRDtzJ4b5GruPR16cPKT6B+f53bvIIZv359SpaHynVI=@vger.kernel.org, AJvYcCVi7xsG4DtUUNs9nZvbK9doG0uo0/NbhGLsbX+4I9nGX8x/otj5JM0KnnvmaVi+UhvSbzFGEn/c4xyQLSrd9iF8@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfYzkcr68hxoBXdAmwRIRiY01tE6brR4vHj9dTyghowVIUp2M
	Q/jA1nRn03XzMt+8+mQLCCGgtovCPuQynKfiT1MzwwkTw5anW4szX3CuaGVC5AS4BAGPpIZCl54
	n265TwJQfbwPKoC+KyWIDaSpZN2sogg==
X-Gm-Gg: ASbGnctMiLI7+xtY1hNwsW/KgaCbE6L8ro91V8wH+ENPRTGDQGnA24p952ebepJZ2vU
	BMb3H4XkfcH0I0FNKXEiaIMJt8VrCa5qpff41MbomR67x5EvWtCPbEkx+5BFtYxab8Urp5bBUuW
	VXg4CYLwPHu40wEJSe66v7BBsf9VMbVnx+3WuFVMC2xWAz
X-Google-Smtp-Source: AGHT+IEz2O2SKmZS2+p3hVTwONVcxNEyKtOTlm7NaAcrOS0ESQ08afoaPpkS8SkH8kIfg8qDPaQQDh5h4Ed9mEHjWDU=
X-Received: by 2002:a17:907:a70d:b0:ae3:de00:3a31 with SMTP id
 a640c23a62f3a-ae6e1253edcmr226329266b.30.1752124038437; Wed, 09 Jul 2025
 22:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250702152057.4067-1-ujwal.kundur@gmail.com>
 <aGf_W_ZgIf63dmAz@x1.local>
In-Reply-To: <aGf_W_ZgIf63dmAz@x1.local>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Thu, 10 Jul 2025 10:37:06 +0530
X-Gm-Features: Ac12FXyRlqKAsFwzEluZ_0ytp1T4o09NFAA5JIIJvsc_jwEMQKZ5dCVgXeqbixU
Message-ID: <CALkFLLJua-LeS+S5GpiXORA-3wNSR0DTzbh2bvU=Vg-Uzd2VFA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, jackmanb@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It runs all fine here now.  I didn't check line-by-line, but I keep
> thinking this is in general good.
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thank you!

