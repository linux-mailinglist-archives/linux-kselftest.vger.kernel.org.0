Return-Path: <linux-kselftest+bounces-4450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A499484F7E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA56287A31
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E06BB5F;
	Fri,  9 Feb 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE7JMC1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94E6A028
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490303; cv=none; b=F83iqpES2I1Ht981hM5drqRDRRuMrS08ngaPgryWyd3PbT64IzOMGITwquO4PXEUkqZbyNMPR5vTEz0Mtq4ijhjIzDCR7B+7dQV1Ns+fKmV6J62ghlV7dPNmgzDxy6N9ArtdaKMeswu0uvv0cjIuFM6vTyIaZvLrbQDT4dgfSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490303; c=relaxed/simple;
	bh=jOeCwyPswZHY5R6F2dlSuqjnfqYjAL+/Y8Ahs1V2ei0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igLTwFRKi3I7Fa/WP91aVMgJSwsQ4xPmg5qwSejd82wsaIke3QUKp46ZRF3SDhPus1EseDPGoTyYYTI9ltpYKcMGLyeaO1Kp5J7L9uB2o1XBeyGLDsvXyPbNBxApDMlPrhVpK3avlVpvuJliXzQ/kIyNlffOn2vKvWerCQSIxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TE7JMC1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707490299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aSFq6OQR7rXjF8YgbnTHTb9jTuycNmtR+05B/t3D3Mg=;
	b=TE7JMC1uS/Pr9vrDdhNSXluzWBxeFZGJVZddnCLL7fZKS3fCSpo0d3v0rkpvV3pr8g0CfS
	3FRTungjgCzBlWaspHY9O9YvoNLnOGDquO3bcrBAULoJ6IbcbIPlXHvMg5GXPrB95sXJwj
	erN1OzDos2HYiV4/jITPi3VqQ6xZ8l4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-DbNNOjknMCS2z4tST5Xcgw-1; Fri, 09 Feb 2024 09:51:38 -0500
X-MC-Unique: DbNNOjknMCS2z4tST5Xcgw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4103bb38a68so1269345e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 06:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490296; x=1708095096;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSFq6OQR7rXjF8YgbnTHTb9jTuycNmtR+05B/t3D3Mg=;
        b=bQHaxZHQoqiL6pfq8nfWXqb7FKaCIFk9cd8ay/qO08xHwE0qoCEvnqgzpic3AxdscV
         tA1DssxAYzNdxID0lV8dcu91+ubbnvY0Qxxu9Y5PoPkGQ2RwSCcPg9vsQndNEtqc7EBg
         pFtfz8QrQZavmPMq5flxtB0QE/ttqZkNe84usDDqzpcFLZGRF/XCZlAH8+SnhE7ZJgMA
         eZ3arCej6shfnEfmgLZVhFZaX2NAKZjoyN6YNSeVgBIbZftaZ7RyavsuCSQR0eqii1cX
         GSNv0JiZSc5Eb1KBLOvAdToPe2Z0K/D2M8T7FPcOiGoE48oc9G6wJkvfg8HsaLKbsI1K
         H+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjk/kG4xGJzO4hTFHzDRaRjl59NOO9oPFRrSMomr6jlLDtk4DwpcKjse6vSKl46DxO76QYZywSacav+e/ZX6QiLw9iZiO9/HV9euy1dmTK
X-Gm-Message-State: AOJu0YxqeqIKcHGvTWxUH/OLIhkdKYGaRKDg+buig6W5wPAm7vSFMSE7
	d9UODgL9bZVo0IAAPelSXsT7DFJNQ5sypR/hVc7AqlCDDjs5JNBU/N+rgYNc/veWYHgSiTfBNT+
	iU8wUlq9uuwUKe04tUB9sFhgrfMnIOogoyNnkFW0jDsdB12WZ4Y2QkENeewIINg5Upg==
X-Received: by 2002:a05:6000:1709:b0:33b:6499:db96 with SMTP id n9-20020a056000170900b0033b6499db96mr1433240wrc.7.1707490296640;
        Fri, 09 Feb 2024 06:51:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY0emP7YCrTpNPE57bNJbsJ47uctKmUHkuoSW2x9+Jl/n5DO8nb08a9y3JLZtapUVkr09nTg==
X-Received: by 2002:a05:6000:1709:b0:33b:6499:db96 with SMTP id n9-20020a056000170900b0033b6499db96mr1433231wrc.7.1707490296260;
        Fri, 09 Feb 2024 06:51:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZiVpy/SXU4w44G64F+lIvctmRI0HBopZgiPM+JaBu2yXOug/a1F2JxsL6QQT43Tafa82Fzavjkcce3NNrVfU8IfjQqUWoewGAg6CX+iA6ewzlsGIf+8Ioawbeqx6ZdxT2STzhbpX/9oWRSmlMau2QRNUpyNtai6vz+Htpstvuo53tDS8amL/+g9D7dEofs5XadpxK5Dv3hwjt/exNCXH420ox2ZAv3x6nW6YN3a2n8OPA9JRg
Received: from gerbillo.redhat.com (146-241-228-88.dyn.eolo.it. [146.241.228.88])
        by smtp.gmail.com with ESMTPSA id bk27-20020a0560001d9b00b0033b55661f32sm2078215wrb.9.2024.02.09.06.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:51:35 -0800 (PST)
Message-ID: <5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>,  linux-kselftest@vger.kernel.org
Date: Fri, 09 Feb 2024 15:51:34 +0100
In-Reply-To: <53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
References: 
	<53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 16:45 +0100, Paolo Abeni wrote:
> The mentioned test is failing in slow environments:
>=20
>   # SO_TXTIME ipv4 clock monotonic
>   # ./so_txtime: recv: timeout: Resource temporarily unavailable
>   not ok 1 selftests: net: so_txtime.sh # exit=3D1
>=20
> The receiver is started in background and the sender could end-up
> transmitting the packet before the receiver is ready, so that the
> later recv times out.
>=20
> Address the issue explcitly waiting for the socket being bound to
> the relevant port.
>=20
> Fixes: af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that to really cope with slow env the mentioned self-tests also
> need net-next commit c41dfb0dfbec ("selftests/net: ignore timing
> errors in so_txtime if KSFT_MACHINE_SLOW"), so this could be applied to
> net-next, too

Oops... CI is saying the above is not enough...

> @@ -65,6 +70,7 @@ do_test() {
> =20
>  	local readonly START=3D"$(date +%s%N --date=3D"+ 0.1 seconds")"
>  	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S=
 "${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
> +	wait_local_port_listen "${NS2}" 8000 "${PROTO}"
>  	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S=
 "${SADDR}" -D "${DADDR}" "${TXARGS}"

The binary explicitly waits up to $START time, and that conflicts with
the wait_local_port_listen, something different is needed. Apparently I
was just "lucky" during my local testing.

Cheers,

Paolo


