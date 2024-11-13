Return-Path: <linux-kselftest+bounces-21964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5999C7A7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323D81F233B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E6204095;
	Wed, 13 Nov 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VToI0X0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2594374C4;
	Wed, 13 Nov 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520753; cv=none; b=parRFJKVF483gbkVB0hqfjt3h+RsRNLgj1nTom4JWyQX6MdAuMBdQlpLIyyzkeyHFUx367Yf4PYFUlzXOHYROAuZDLPeMovxibDjtiFEhBYHfsyP/oBD55Iu8FY2qppSnJyPdJY8ecCa5nJCcYPTbhhprV1gH9KikDiIQZAfooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520753; c=relaxed/simple;
	bh=FvI8dNWt1XzzwNR9jrLk1P2nfJK1ic/KFVBxI1WuEDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umwmkD/S7y2IPg4qvtcdnOPDlM4aVyNypRD5uOIxW53pq5S06L1hTrFzK5WoMQskt1ZWw0jIEyD8HVrSOtIjfMpltiSRQB9/d8JEvmK1vcpGsPemXjklSzvoDa52pCJoAdxB8NyclnUY8EkH1/If2V5u9TbU/NnrHOTOKUvMyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VToI0X0o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2113da91b53so53432035ad.3;
        Wed, 13 Nov 2024 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520751; x=1732125551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QU6eCVp1bzsezZotXldnZDkljMrGl4ICLAg+W/F8jg=;
        b=VToI0X0oXv2d6Ogv0d/GgZJXcKB+ryUDfWLGd1QA7UX8xTOA+atULWk0AxLkACGefu
         McsfjvwyeLZBQBwZ6SqAth6WQRZwaIoDs45SvJxF4nFZIyfa6zrpTgLb+WlW/L32mV6s
         VLZA3yL2xI6vzAi4zlaQygSP7Ao/UnfG9jvqN5ZMEvwWUB12xyotbTH1NB9zubBVRt4P
         AGJ9OtQ/f3PvIhVdgR6e3DuC/bdqpMewjzXYxNu5fQM8tshQR6c0hxJSWVszkulNx+rL
         fFbKm42M0W0mAhRLkCdznX6cGUQ+HHx++rE1C9bd6gjRZYKss5OzXLC5UPenVVnpbB9w
         eGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520751; x=1732125551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QU6eCVp1bzsezZotXldnZDkljMrGl4ICLAg+W/F8jg=;
        b=n+pWcOw2WRc0S9XBARDiB8P0gLhWPlUgvMQkGIJBVaGicrLAIT/hjxflS0D5pLF5ip
         S9n2fuukGH+y1l+I5wrZ2CNLM6iz8mLjn27NJgcuc/kBoQYujYLEkEP9zlav6uHtZDuZ
         tJRd4JjbeWXtmF5AUkJ5ChoDb1eD4GrwOgAY9V6sa1qb6UgdjSNJmB8kcMFe/UgeIduG
         MbBXgbre/rb8DVfx5qhepfX0xk8+3vXrHiT723RaITeHrFxhFfEtnBIUEYyDwxXWVG9z
         p9rLT/9fqr8Z0iKCt+uq2pXcEvnOCIgXYg8BnIvLthP+4cR9S711qZkdQXuuqYfzPlKr
         SmEg==
X-Forwarded-Encrypted: i=1; AJvYcCUnpnSOd6W9h3rU9sC8eh7Kq9/K0FQ2c2/LvPNFrBPLkX+FRqcR52ISS4km4xkQbJ+7ZS3NjrcYgMAe/Io5RnDU@vger.kernel.org, AJvYcCW6GLw3YNT52RvoBtOHgeIqyPn4sR7QERq896IlXrWRNGuKxVbUFDUTbVFU9iwKjpQsDSAnLHDIrBgMP1n6@vger.kernel.org, AJvYcCXgfDrAq/9szz+qfMmFkrh+nORhN+v6Q1zz1yom9W+zzScioBvmBIr+9b0aiiiMxfipIso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbcVvfB7eDn5ugsk+AS0e4C6FgcYaDV6aWrqtoWNEWMoZGzfF
	Bz982kfyT3kXaAdbqhomZSE6y2YLQiCrh//sSK0wCtLuWIVCzAQ=
X-Google-Smtp-Source: AGHT+IEkhNrGbY20mPHNStDw/5A5v5/HFu2nkrc8z587y6bTl9+lun4HaV3eMTadxeZDuPuoOWsDWw==
X-Received: by 2002:a17:902:ce89:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-21183d67d05mr308594605ad.32.1731520751230;
        Wed, 13 Nov 2024 09:59:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45839sm112845395ad.143.2024.11.13.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:59:10 -0800 (PST)
Date: Wed, 13 Nov 2024 09:59:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: remove
 test_flow_dissector.sh
Message-ID: <ZzTo7mTsFfbBIihU@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-10-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-10-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> Now that test_flow_dissector.sh has been converted to test_progs, remove
> the legacy test.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

