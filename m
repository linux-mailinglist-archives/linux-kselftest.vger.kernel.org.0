Return-Path: <linux-kselftest+bounces-47270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B2CAD6B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AF1303B7C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB36329C48;
	Mon,  8 Dec 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUhmOcJe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBF0zTRd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C08329C41
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203650; cv=none; b=J4YRr1cGn3jWUxJvDJPpoAeiez5wGfCJJvZ/F0xgoQIwxW2+8K8dTVytdQcqM4uT+e19EKhjw25E4/3ybUDFgjKtkrPKWjQ1m0aTOQXK659LWmSJjdAsItFcc7cT3XhVK9jSd2eS9Hi6e6pe7+MYYqeJzV93ROqeKWJLJB6/olA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203650; c=relaxed/simple;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nL5wfVfd4ok/TiCt3GkYfJA8Qbfw1nwZdevQuIKAIqVXZWpCO5l4AW8Md/acgX6rsuXvAxEBxT1qxcZpIkUN8ad5mQf9voNvlyyXMF8EyWJQv80td1k6tUETHHkLbpNBwTa4CJfx9MHJl7lVRHeFDHRDvkLpOkriS5Z9gJJnvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUhmOcJe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBF0zTRd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	b=bUhmOcJebvjjFwHTXlojCQEzzSykZucJxsNCAl/rk0l6WTzPlUSmHB+BGNs5apGdoWUK7m
	Ir812Gr1rRV/Jq+InPnw+d+oyGiPptwUwqaLnZTTP9hflHSa8R+FmhmOvur1ADo8Cm4Uui
	GrudpC0QCE0ZTXRrGCpOv/YPHdDgsyg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-FaJ4B4b7NYanV_jYoRG8vQ-1; Mon, 08 Dec 2025 09:20:47 -0500
X-MC-Unique: FaJ4B4b7NYanV_jYoRG8vQ-1
X-Mimecast-MFC-AGG-ID: FaJ4B4b7NYanV_jYoRG8vQ_1765203646
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b70b2a89c22so536664566b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203646; x=1765808446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=cBF0zTRd892NkDsjeVWIrrUVFn4iDvAPTOO6YKNRxcX6C8UgBzbbM2pW8V6fi5Uilx
         IJH9H1TqGdMMSrkfr4hIqfNKEhsYtHxSSMQqTN5nBLsISDnZ02r/2tBX+j3qZpfntbky
         OyL9JJxDXwjYkpdMQ/9VHWGebMPaHdwweebf3gGUBvWba4yMD2rjnYa720cRzpd4THHQ
         xCeq6UaHJgepVvVqojiuceWH1y6kEd7eGtdQ6aR/v8H+1/fKrmg2NU0kZ3Nzf8yE0hnB
         gi0NlBRbEfNW0nRfgNnftiDUOcCoHPOlq91mFgiyw7fmv2u1g2f3cstqcHGEXboKFd3z
         AfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203646; x=1765808446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=uQoTqrJiR1ndCfi6frnxB7s28u70RGWfxJfqfZtngC+A8IQXCK63xrP1jUHE3ZOsLq
         TTvjb43zcpLINoFLgnYwMcKkaMVM50y8yfRljOHfcTDADuTZ9xATZb/GbkNIiuZo/cih
         wYd6za81+YYiPr3BK8p4qxjKk4kxNPpAOYWzjt5DTDgZDzaOSrQEQMbkmann4TixsCqF
         GJzJBSU9AAG3ub34Ak+A2uP+noiVncAcPwt9HwIqMHgGq0y/WQYA03ol2NfBPpgGQ4Qe
         ktgTa5UgFxicrBoJ2t1eeyAmmkA4e7uquDcxkrtEEJVyMdzDjLB4HfgKPWo/KmmDdnrA
         DbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwi4GrrPmRbgz5NkkOkaOaPcyXVI4NdEOb5e3jmFHgVS0wPK9+Qct8LZuvqDquRCXmhMemUvMb7aGnxUX8Eug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvuBQ3qefCT+fuuUYdUVYuNEEHW2XOy5tdktvYwxC6tqud5rf8
	4ccIaTb0tV50c/FQNuGINNSjoAX4Ouj+lndO1FJZPW/jeNTpEmfl50+cZFmKEMscXAr+QVOt6To
	dddX9CaFxLAvfgK/2ws317h9LAGxa2IPAR8kyNKTsTaPp8dBQr9iJNq+Jwp9y+5r1Lkt+zA==
X-Gm-Gg: ASbGnctnKV5kgf9j8x1Xql84w7KYim9nJ7dlItI+wtO1UmCYObP9dqJXPkURl4NVrQT
	HgZvKIDRx8btkWpa9iCj+mAU2OUoOWVMgXb6ebm55bMw7mY+Itihdkq1bw+1CrmmQXn8yF4cAh/
	sVBXm66pbZtqnEOXvAehCGEZKSoQ0vny0rYFu9zlf0UGhuuRT0dUfMs4b730f4Itxa186MsiCnP
	QRo9V5GpHBMYZfq9lwMkR0ZzaiYG1wa3TVoBm8L4NHQCZVs23luaa2odevJkY0OSfJC9Uz+TV2x
	lW8Yi/Ytu4gE3RnCEftS6W37sVX0g6UzW5tqka/xGLxUviqjHE3JNEiBOPvUEWJmqs80BdOlsqk
	YS33xCfqtYX+Dj0ItqO8lru7c4ae1RPT9Ew==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792475966b.23.1765203645757;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeICR9a9Zyl705kBwz+fQ+K9zHYu4wc7uwPWOV2osX2dj4Awtr08onWyj57fv57pFb+ioxow==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792473166b.23.1765203645298;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f426413esm1142503666b.0.2025.12.08.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:20:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BE593B25D9; Mon, 08 Dec 2025 15:20:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for attaching
 invalid fd
In-Reply-To: <20251208131449.73036-3-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-3-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:20:44 +0100
Message-ID: <87ldjd6on7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> Add test cases for situations where adding the following types of file
> descriptors to a cpumap entry should fail:
> - Non-BPF file descriptor (expect -EINVAL)
> - Nonexistent file descriptor (expect -EBADF)
>
> Also tighten the assertion for the expected error when adding a
> non-BPF_XDP_CPUMAP program to a cpumap entry.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


