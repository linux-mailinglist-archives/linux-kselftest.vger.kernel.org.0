Return-Path: <linux-kselftest+bounces-5330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A4860D5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DA1F259A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56561AAD2;
	Fri, 23 Feb 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuQgjong"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EA199B9
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678689; cv=none; b=Y1CHXlKqJKteVwKZ/UEdkMynyi+lKDhSyboQjR0AijV98p5sMBehv6ME7fDVHBpCv35hKnJuFfj/qcvV8LK+qtQXL05cCGEhv9aDmhFkcacNonEnyP9WH61dc71173jvVDIt/Yp5anpje/zacCwZWLc8fqgPEL1GqRE/9gyIPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678689; c=relaxed/simple;
	bh=YZbhuAtP+26wSLICWdq/lyQWSLDnxV62jHh0sN94jd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qphgOqRZC9yMqQrtmH75aYamLvlCnq7Hctea4R0XWsngQBq8JBuzymQwrWaktHN4v9qnHUu9LUr7++YOwKVCpvEgytffoP2Yuiz8ec/qpBI/EhVnVDZKMnZ0Bh0Drw6HquPyXf+AOWGC8bivs6F38Q22VbLUoUOB4LHSEx8c1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuQgjong; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708678686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLQwWfoTn0xaoRpTFSAvxI7eKjXdmQ16vLaj1rspCoQ=;
	b=HuQgjong9EkSKPxnRAI95X8K2ZeKbKXU1VLL+aDA7YuZwlfoZQN6Kzjv5BYhGaqq20OmqT
	WrKYPef8fz+mhXj/wb/EzWIDlVcjTKoqss3pN6RtlwzWTjniDsrKWcaGIcCMc4CFLbhByi
	ahXNaaUiaMYc92XQcDAXrfMZ7OLLkx8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-h_gZs6c9PX2WSRtdQQbxrw-1; Fri, 23 Feb 2024 03:58:04 -0500
X-MC-Unique: h_gZs6c9PX2WSRtdQQbxrw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412829eab17so3220825e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 00:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678683; x=1709283483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLQwWfoTn0xaoRpTFSAvxI7eKjXdmQ16vLaj1rspCoQ=;
        b=YSTgGxIU76Nq5P9Jls8XccVQ2s4Ak1um2qSOGaVgNZcJx3NIZ+hx4RIxo+ndBlJ091
         7/ks2UnaxyludNr71ksPwu/ZONQC59Hn+bFGpjMr+5s99G31E1V5+vjDVDpzljQ8j8iA
         FhogliurYjcr7vCa7OsRd3XhCAcZrBeAS/aRnkfVbElcdVL2lS0B9gsfS7U53+wIsG7L
         Mfinwvz31oU1m3vwB/OJ1wdzh/HmfA6LPXZFONj3jWC8k11SsJwUTJbDSz1FIfof4qNe
         TkqP/f4u9HuPn3h60C6n7vgcRTTlnHMtMlya+dQyU42PKXwP9ecljpmBmb278HkYxFf4
         Yg/g==
X-Forwarded-Encrypted: i=1; AJvYcCUOfvRthttCsIKuEMzriq1KouoWSZ5YvV53Mii/1HhOALwPWpw6gOqqXiu6SzC73TDU0ZxtvVLei+kzxKje7S/ZGrUddt7EH/ILPNXnY5Dt
X-Gm-Message-State: AOJu0Ywe5X+U/lVLoNNjz80ChCXySalhQShN0OVdBo3FD6D7OGdedQAM
	/0m4d6xeiSYPHCJ1tCuYJbN/WuqRmZbjTzOvsJCjOOoUs8mK6WRU4hgWkREwbo+B3g7EerHFU5x
	3I1EQfkZz6uoUNA2ZWJRUXHvw7BAHAGoVb0IZp+7LNfNErHBTxicDpsIT3mEVeQM68MI5iscv4S
	P2icYj0fPX2iT6p5TEFKEDInTLoI1EfxI1RbFJA74l
X-Received: by 2002:adf:eac3:0:b0:33d:71e5:f556 with SMTP id o3-20020adfeac3000000b0033d71e5f556mr1020419wrn.27.1708678683410;
        Fri, 23 Feb 2024 00:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+mrCKzWAaGkT/K53qU2Sd9UG7Fu614wcbzGC+OYclult0+HHvvNnkxisAg/4y0NnQxxIN8re7HwpceFAujt8=
X-Received: by 2002:adf:eac3:0:b0:33d:71e5:f556 with SMTP id
 o3-20020adfeac3000000b0033d71e5f556mr1020407wrn.27.1708678683094; Fri, 23 Feb
 2024 00:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
In-Reply-To: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 09:57:50 +0100
Message-ID: <CABgObfakz1KQ==Cvrxr5wS36Lq8mvF9uJtW3AWVe9m-b+0OKYA@mail.gmail.com>
Subject: Re: [PATCH] Build guest_memfd_test also on arm64.
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:44=E2=80=AFAM Itaru Kitayama
<itaru.kitayama@linux.dev> wrote:
> on arm64 KVM_CAP_GUEST_MEMDF capability is not enabled, but
> guest_memfd_test can build on arm64, let's build it on arm64 as well.

The test will be skipped, so there's no point in compiling it.

Paolo

> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 492e937fab00..8a4f8afb81ca 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -158,6 +158,7 @@ TEST_GEN_PROGS_aarch64 +=3D access_tracking_perf_test
>  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_aarch64 +=3D guest_memfd_test
>  TEST_GEN_PROGS_aarch64 +=3D guest_print_test
>  TEST_GEN_PROGS_aarch64 +=3D get-reg-list
>  TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
>
> ---
> base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
> change-id: 20240222-memfd-7285f9564c1e
>
> Best regards,
> --
> Itaru Kitayama <itaru.kitayama@linux.dev>
>


