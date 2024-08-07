Return-Path: <linux-kselftest+bounces-14950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B994B06F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F380D1F22853
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF51442E8;
	Wed,  7 Aug 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG1DCMNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499B14388F;
	Wed,  7 Aug 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058759; cv=none; b=dl3hTClNYWnUXdU3nq0bOmIDou//dpLGXKJE/6XKYobyAtKoCuozi3N7AHtfa6HHTOh1f7m4yuT5WeYdDq4gPNxiitWI1vnvIkC/3dSoJvIPe85oJDvEOXGWG6oEYkUXHRXIEdzdxGR6h7Kc3aX8RnmerYdTaEuDlNMCa9BKoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058759; c=relaxed/simple;
	bh=jq/PqrXLEa3pxfqcv0R+71WNrpDHLU/hS0kqTy3ln6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMqvbITFSOxTkVW8CiI1bTBNSpLoPBwYh11XLD1wBq/Z/lLtUhvT9Z5eQJCkw8E7PxVo7528ZcTguB6Rd4U9qKjvgwJH7vi120EPIW2Zy7HwUA/FhueLzggMFwdKhnd2oFjt2lyBR/hj+RQO9RyvWQ0oOnBpz1lLtmsGSC5Scn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG1DCMNF; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso97486e0c.0;
        Wed, 07 Aug 2024 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058757; x=1723663557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7+ks3dDwY2zSJcOKPPopRCqEmx2fHtiEAIp/0e5Fjw=;
        b=gG1DCMNFE0bfYxaFCQtiolrrWka3DgCMsDAoqd0Cc7W4XSRuxMc7ldqggSvAQ3KnyE
         eOdAhGxKD9NhcZQhjwCM2CeCsxzxoieDeQfPNrSx3o6k4ZokWVKs3hbf6aqG7fxpAFI4
         vIEVJ5nFBtg+AuuaOopwiF9T186BqcGrulwVs7O3gCrRRrSUq9fxCVh4rstP5idYmM1K
         QjflaP0FcuF1fcRU/TaPgTBM33UDJ2y3T30OMMVZnAK81Tp0Hc+noLIvmK6DhR/wzL3t
         K1wJX0udh3D/5rIwYLhd5URn137zCKonVvrUrW2fU1INwnqy1OfbvL/+rCDkTUf/WwjJ
         lDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058757; x=1723663557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7+ks3dDwY2zSJcOKPPopRCqEmx2fHtiEAIp/0e5Fjw=;
        b=t+f2S5IwVSYv1nrGXL04baqfcT6lSy4n46J2M+gx0sQmzJ8sU0popKhrLmGxzYZk1N
         by+Rx431sid0I1Fh5pwtUSen1DhG+IFswOqeaguFGJ72opOtZ9bwnbBddDyv4OVl71Lh
         NqZu0XeRLk7hMm11JWHnsBgkT5XWyx1p+16XcUH4aJkKs4epjnoT6ElCQjLbFyFyAxJz
         ZuqAJoV2o4N8r38Yg4i5OagBfOThxLlgcuJv3bPlWuxZF+Qp18wPHRhBv2EQIFvyHR34
         sYdDD3AQvTN37oak1OBXBzGZV8HAay1oUXl0eZ+P1SFdgdL60+JivyGD+AvBoiFkpDoT
         T+rA==
X-Forwarded-Encrypted: i=1; AJvYcCUtzodsFCQ5nwX/Ai3O44EGAm4NqPDCQaPl/P+UN8ywWg06mHzbg4a6a/65nqgW03tF9d/ED9kZS+NKnLo9WKEfRC+MW0J0aSwfkyjaRLTOZzqfwacxRqgvy6gVbqx7qEuV51RAfI2JwGLX40HjCiR0yfCtPMsO6w7AoAoXmznKjBt+z7wJ
X-Gm-Message-State: AOJu0YwZYSN1DuTt4hG0wl3TRsv8I5qaDZVIofiGfdq6M8NbutHsRpy/
	dR1NMKg50R6m9rlhaYVUhftTDgEN5Gpiu90Kqe1e6NBXAsZe7KxJ1qa2d015pHTeZFWVhJkcaAj
	VZUttVdfkMGI0eU6U63pmsBmYHl0JlNYT
X-Google-Smtp-Source: AGHT+IHZ7Hy8CfkwRCjo+waNwMVTOTTSZrBT7/8h6o4tUqtJGoi7Eb7+cllEHgdxtssEJIOKNM/PlmLj39cKWdmqvjQ=
X-Received: by 2002:a05:6122:3c50:b0:4f5:1d9a:ad5c with SMTP id
 71dfb90a1353d-4f8a002274amr23871247e0c.14.1723058757092; Wed, 07 Aug 2024
 12:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807173336.2523757-1-pedro.falcato@gmail.com>
 <20240807173336.2523757-2-pedro.falcato@gmail.com> <20240807115824.f5c29702dda952abd709351d@linux-foundation.org>
In-Reply-To: <20240807115824.f5c29702dda952abd709351d@linux-foundation.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 20:25:45 +0100
Message-ID: <CAKbZUD3kNTKfV5yMQW7YYbRx2XJiMNM4owGiYue1Y-A=yVbWog@mail.gmail.com>
Subject: Re: [PATCH 1/2] mseal: Fix is_madv_discard()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:58=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  7 Aug 2024 18:33:35 +0100 Pedro Falcato <pedro.falcato@gmail.com=
> wrote:
>
> > is_madv_discard did its check wrong. MADV_ flags are not bitwise,
> > they're normal sequential numbers. So, for instance:
> >       behavior & (/* ... */ | MADV_REMOVE)
> >
> > tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
> > discard operations. This is obviously incorrect, so use
> > a switch statement instead.
>
> Please describe the userspace-visible runtime effects of this bug?

The kernel could erroneously block certain madvises (e.g MADV_RANDOM
or MADV_HUGEPAGE) on sealed VMAs due to them sharing bits with blocked
MADV operations (e.g REMOVE or WIPEONFORK).

Thanks,
Pedro

