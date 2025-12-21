Return-Path: <linux-kselftest+bounces-47794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50192CD3E02
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04B8C3007688
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EF28469E;
	Sun, 21 Dec 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUMf8PW7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkQLGnh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241002773E9
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310280; cv=none; b=GHztkuv2u0WvU2DswIjnPju+ojCQh0u914auhdaEpKPice4hZZ7VpzEpaaThfNJNOQ4gDwoePwSkj4nDp5LYjHdNbl/oTSLhMGz3K/WP++IK8k26r/RxNLkXZRIfNkgOv3jXMm0T0WamsQzZ7jkZPmn9EzJ8ebJ7rf6XWJmV6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310280; c=relaxed/simple;
	bh=MFHk+Qor97ScSfCxuPWqXAaC6Mf8rVSRlYkH+Bdt4Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL6W0nM9dkNgvbMB3vmZsBH6yRJzU2Z5c3RUOSuyvceG5BrX+U/Gz39iVQQoSIQrlgBeDPMBZaDrBPybEN9TLm60VaGbItI55+InZ1B8RkxY/mbAx19i20Dvkz1DkF6F8PYy8HQhA2DjA+v9hL2u9OuV3VQnwYgTuLJpST6oq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUMf8PW7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkQLGnh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766310277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6+y9WLSDsSxJtOaxUSqUViYU4g6HBpwAKq4mBGcgzo=;
	b=hUMf8PW705CFa1YNt3GnKN/t0en3Iq7l7CtiNS1QiURj68m5Cj2i6MWngvSwrLsALgHEoO
	6HLP5VM4y4W6vV25EW4jllvv4XW80SLcwNqvdy+9huobxJIsGV891vwsZ49NnTuy90Yfof
	07sx1S7/iyyB+RVQjqxwL6lU8vrBMa0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-eOdnkaU5P9SkeApNDpxoIg-1; Sun, 21 Dec 2025 04:44:36 -0500
X-MC-Unique: eOdnkaU5P9SkeApNDpxoIg-1
X-Mimecast-MFC-AGG-ID: eOdnkaU5P9SkeApNDpxoIg_1766310275
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bdf47c10220so5413072a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766310275; x=1766915075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v6+y9WLSDsSxJtOaxUSqUViYU4g6HBpwAKq4mBGcgzo=;
        b=WkQLGnh+Kol290NoFzBthLu9sxIOmmiI1Xvs/zUiRfNBhY3W0fbq8xOREn6F3Xe5Qy
         /yj/nAo5A6VUiqeyLPYkwMR1AQUlAB4/gQqMnd5Z8ENvlCxIo2tMkfDou0DC9G2hVLr2
         wclEsGKENcVLBkdlZABtshUzJD7Z4nYCxF1THEJHWTos1cfkcrJ5J/aj8j2GVYgsR01G
         jhhUYZbCp5LTdxyMYgOKWN9FPyPaxHyz822BwnQWv8e75PoxqCdVCmFAIE27doPSAcqB
         QQmoG6Klo88QE5osLwbUJU4Q7byXkroq2lrIdgLFVFOWfb42Sn8TjlGAImY+b19du+B8
         up2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766310275; x=1766915075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6+y9WLSDsSxJtOaxUSqUViYU4g6HBpwAKq4mBGcgzo=;
        b=wrU5uVVAe4QEsODEGUmzi6kZMvJTLUWf1vHZ01MlpAJrk1DiFixJuO59/fi839Iqao
         oiexXZqIZw90/7Zng5kS8O5k7bsJAjIUvLh4+6Lou0grP6j0eHjCQeX5pNU4IXPaaSOc
         boJ2aV1rszByZl8AoXJgm0wEQ/OzfEj3CBJMU6FBLoiwyb0E5WJt6mWufyAZKkwkYC7i
         x+8GR3HWCn4cR4lXzgPjbdg6RNpKwaIW1e3diZzQFQvA3YkOplQV628C6tArpVCI0WRG
         8W3HamKi7X1uESjg3ok8Ev/p+4n/vNAPhyzTfofaY+KhaYZmwnlbhYGoDYYnVH4pISNG
         ncTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNdTe56/qfGM6+uHj0GnrozqSbD331XkKQqdARYDgtpXo4JYKaJEnc5MDmavo3GvdpyjGzIJVlFM0TzkCUHLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywljzflof/KIzX9tzdjT/LwaxOGuAgbmZMnEqaD4WuXBBXmW5in
	ojls4vMDKPjPE/Mqi0QCm6XLegLa5LNLbGEBMULzAcuCK3+seV/jL2Hp770spxoyYR4hmy8fGQG
	KnVJrlptZVy1wA4XEO+8HyHBuaqR+EtdBRDm3SINU8i9FrqJUHd4CoBvbxEyAfTYIar9lz2gZMN
	e3CSspcnHY8l0zHcKdLIrMu+B18zjy197Hq2mIV9xnuJsG
X-Gm-Gg: AY/fxX4TtNymEZ9noEd48rgiTyoShmpRZoSqZ4V2Cm1KLbi9lXxH2cBN8f4OGRnuV5Z
	W8mNg7Jkh+wPSTQPGsequspqix7n/YghRnjep1WsY+YuqNO5mhX2L2wCNwTRZ/80XnhW3fbPF1+
	PvVR6tENQupedRaJEFcHIJoNycfOl8I+WfF6heDmXn8JOjN4DjMvR2xp9H41CNggWTHo0=
X-Received: by 2002:a05:7300:cf92:b0:2a4:61a1:c0d5 with SMTP id 5a478bee46e88-2b05ec97dc9mr9020798eec.36.1766310275292;
        Sun, 21 Dec 2025 01:44:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL1i6p8N2hSuUv+xL5rM61Q5+a8Vkv7Ev7XAzGkSrg7/P90k3Cd5PYS0PYFknoNJAdnKhv9+PtZSswlmQYASE=
X-Received: by 2002:a05:7300:cf92:b0:2a4:61a1:c0d5 with SMTP id
 5a478bee46e88-2b05ec97dc9mr9020789eec.36.1766310274957; Sun, 21 Dec 2025
 01:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221085810.3163919-1-liwang@redhat.com> <20251221085810.3163919-4-liwang@redhat.com>
 <970fa015-9ec8-4903-8e2f-f3e847d550d1@kernel.org>
In-Reply-To: <970fa015-9ec8-4903-8e2f-f3e847d550d1@kernel.org>
From: Li Wang <liwang@redhat.com>
Date: Sun, 21 Dec 2025 17:44:22 +0800
X-Gm-Features: AQt7F2pHfdiMRMRnZKTZtwZEUfCrHUSow0ksQmNv49Fll4mVQHzB9tXkUYQfG5U
Message-ID: <CAEemH2f67p=wqGrwYnoVCP1fR82xxwJv1xfbMmFrvNaP7LZJog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests/mm/charge_reserved_hugetlb: fix
 hugetlbfs mount size for large hugepages
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand (Red Hat) <david@kernel.org> wrote:
> On 12/21/25 09:58, Li Wang wrote:
> > charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with
> > a fixed size of 256M. On systems with large base hugepages (e.g. 512MB),
> > this is smaller than a single hugepage, so the hugetlbfs mount ends up
> > with effectively zero capacity (often visible as size=0 in mount output).
> >
> > As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
> > waiting for progress.
>
> I'm curious, what's the history of using "256MB" in the first place (or
> specifying any size?).

Seems the script initializes it with "256MB" from:

commit 29750f71a9b4cfae57cdddfbd8ca287eddca5503
Author: Mina Almasry <almasrymina@google.com>
Date:   Wed Apr 1 21:11:38 2020 -0700

    hugetlb_cgroup: add hugetlb_cgroup reservation tests


-- 
Regards,
Li Wang


