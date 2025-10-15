Return-Path: <linux-kselftest+bounces-43159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03427BDC336
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 04:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5813C3B5A50
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F306156F20;
	Wed, 15 Oct 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+evYeex"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C27263E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496344; cv=none; b=mtfc7Rjc+H0Z7uP4jDJs2HdfJYHe3aUUA4lg2UM3QkmUMRdVAM3xN71V74is5Bbqh+ID8efd/XCVgFjEM1ijff/LWcgpaelTvGTsNkRRO1aodn4zHPVH9CExFC3e5Wa5uW+WP9TTtBBctE9MQibjJaw1k2IS0BMhXwiGd2FHlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496344; c=relaxed/simple;
	bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJyREJYOhRHo+drsRF9fBZuQxhPfosE1iJpLgV1XctvNdHRMM6gl5fXAtDi24UMAWtkmljJ3YsDAaXxK+6Jr2dEE7RgN0D8oOWmFVprnlWCLPy1+QI+cuySqsEGMY7r5R0bScGg3hcufbSRVBfpVdoydHzsATisCjJv4ncFtv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+evYeex; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4667277f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496341; x=1761101141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
        b=N+evYeex+bmOeZNcqzWvaJwzG0irH1zlZXvSTZ9afU2O4EYG0LVYWSjq2QnmoLA/dH
         0Ylp6pTKLtCYDXtOKiyoYGwgXSNTQyQNpzG2z4LLB96fvynNgLq8iy9wQjHtkpOyWkS+
         ltnb3VQNIPbKJWPVzKXcFbrWI50Nk9RFulCg3yNR1VXUiiwGxGBgMZJugVQlyFbX8pTT
         4ju1eXFcsTTP5Q3/sMH55HkG+a2SQY6HWgX/VRk6jVJviA8b8oldVEaTGMefToCPKgxx
         soKOqH41xuiaOwFu9uS5c3q0hZ4fwohLKOGRphee2kXYWiXGzcxgZvCVgrxoLMOlQIpg
         tW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496341; x=1761101141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovsT9HzaGAh9fSCPxIjE7Xaf73imND+dmOguXYT91Fk=;
        b=qgP3XjV3Xu58oCECreyW+PFvO5Wt8nTtRcFS/ZHOg008Sh9451ZrNIYxbhY79AlJET
         swBKhoijG55s2dad3J2Q3Xh6T8sGcxs+oL5QOPwgkQ9ZPhDgLNoQkbIsw0Le0nbXTtNu
         /PR00uIRZcksqksK2sPNMNXFJDNNDObeOiBhlXGJKuczSbTiMmQzABCiEu5oWKhYibpm
         ufMHxLeEpsa7FdAe3ey0PLB5suKmq5PnqC7fZ5LSkiEkM60iMeYXZ0cG1Z+SA/3bjKSv
         TgAQEdXP/AFJrttHw9r3jAFWol2YxFALbEYX8EyWFXufKYRzboo2o/fK1VyFf+pNFkUn
         9kNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0YAxSDU0db3qSO6YAvfHcdUxGtnatXBdrk5i2Q08a+gicIJTu9e5j3nV0TNqzRWrkjeoGeZXd+PjX++e0HiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhe+9D8HnZbLtJkNPSDNfiusjrWg0VJ1QK18O25hDHgZZAzUhx
	VJJn9012C4wqKByne9UosChbWtqUgNmBK2/IHpy1octGeZ2xfdLoUKEjeYoWWnXK24/ye7rEsty
	XcJrK/3qzjqQk4xtuF+FSWhbLzo0Kcm8=
X-Gm-Gg: ASbGncuRkl1Df/LI59Jlq/ugtVqZg4aXj8FZtKR+jNuhvNf1XcXq607I8yfDbcFwwuQ
	X2D0vLl1ywTXCnFMYnS/YAiMChDBYk7KzfQRALz9/Bb2+jgjDlMj5NMTkXWZoyZRGSSdgrX+zNc
	4MCynpvhPkALdfZ7L/CG7X/3VHd3+m9eVq2jKTBZ04m07wWojQQKncvX8FX+a/Znbm3jFcWoQnE
	f4eVbTYnbAp0CbkoXsRvU63GCSV/L+922lIVzQ33ZauETE3/gZ+Ukl8FMo=
X-Google-Smtp-Source: AGHT+IF7oNH/E0uNEVekTX3Tm9X3VMO0ZKJWoIby8hf8YOQofSG9E+8zMc0FjQadaJzJ99xoYzLqPJtQe6Jd5d9A4C8=
X-Received: by 2002:a05:6000:2307:b0:426:ee44:6ef with SMTP id
 ffacd0b85a97d-426ee440a47mr3265010f8f.11.1760496341157; Tue, 14 Oct 2025
 19:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
 <20251015024307.7924-1-higuoxing@gmail.com>
In-Reply-To: <20251015024307.7924-1-higuoxing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 19:45:29 -0700
X-Gm-Features: AS18NWC-KA8bcaqPWQ4Wj8xwtDfJJ-Rjy0OCNE0few8rMBzb7rlHXn-lbZShhxw
Message-ID: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Xing Guo <higuoxing@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:43=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Thanks for reviewing! Here's the revised patch.

Please send it as a proper patch with SOB, etc.

