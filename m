Return-Path: <linux-kselftest+bounces-4499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104AC850EFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893C91F209B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A6522C;
	Mon, 12 Feb 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6IkSfQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77349101C2
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727246; cv=none; b=Bj5quXBSpnPscXfJGQp8iycKUeeTKP+0tL9lDrQ/BL6FOmQtbeoJJaLMpTkCrhjDUMzRFhm1schg5l+WBV98lQ+rEOKTJekBcOBhCslHxSIB9PqiSHCDVMm2ZxTMgDlSwSLVxn+gFNPrVLGDFcCwsANEtte+J/LyONV9ki4S4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727246; c=relaxed/simple;
	bh=eg9dg5C2/P35uO5uzbv0HQTfLSJe2hVk7STd/K0EP00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvNJXnhdPwNq3RQ4kflypxotvFi2G4QGK1vITxcv4k5c5+zOPhy+f6c8CTsHtE5boZpLbkdpNi0NmfG4P47weJu0Qn2pGzUPSuVPhKdosi7wIqK6Ezq4KSYweWzgsRhbXluwgn6fChxittOOj0ytDiWwBVsb8ET53IKAQs4h8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6IkSfQp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707727243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DO3zZ6iDjZBLL1qmNnGC4rRDmpTWWuM6FEtthoAe/4k=;
	b=J6IkSfQpLzQy1ayNL6Yv5BPAzuICuVZrKlcxifX20dbISDqZLbAXs1dRMf7mUmmNFQBlHw
	8rKh1dDU4g7ciWNCZvL30DPjRurW2ING+phWBXudhRtcvWUUKl2faN2XXkxIDKbZ9I6Z0Q
	eYfmcCjQKkatcklgEIUYKGjs1nQv+A4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-VRLnJKzwMoCPfEkSXAxqpg-1; Mon, 12 Feb 2024 03:40:42 -0500
X-MC-Unique: VRLnJKzwMoCPfEkSXAxqpg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so7540285e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 00:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727241; x=1708332041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO3zZ6iDjZBLL1qmNnGC4rRDmpTWWuM6FEtthoAe/4k=;
        b=A7dowgu0HzdiRIB/gaxY2QsjykogmD+HEnWFXhCmM+YNvVYt6XpidNmiyVKMoJJ3cc
         9TxgdFSGlrSU+IWy8smIXPvUSgOBBuu7esnnV7InnT4W8EtrTRMVtwhp2q8qPBzwZ+oS
         cxCumI4lpX5jmX4TecrjWcHevZATTcu97MZqvwrDVq4Y3UsMYxnlpw4N128N9BJIv70X
         f8A7EpE2KVbadmtmOxWOcSc4hS/lyFMA0+A0aMXiZw2YLNczDrMZmXOZd9pKord9IpWm
         scOVogNSp62OeV0RNHm+SYBd1ddZEjzXXEiyq5QIgfwPZvstjeLIPMnRYREhlcbFtQMD
         0jtg==
X-Forwarded-Encrypted: i=1; AJvYcCUDljeYRi4q6cpsPPKNUfvPrsosjn31ONwDQheO8+wATKWYMY57tNxvTOkpX9gbRqrm8otSVlyNt5LCUu3n0XsB5T2Qtj6saWXOhL33XfwD
X-Gm-Message-State: AOJu0YxWjIs2Wi9S2hvyvpUzwXTcyQheE2BIDk819WbRsyjql0L2vRxG
	Kkvl5sfKmB8c0ec8vZzipk32pWC677HTkfAC/5OSGQ3jlItaBtU1yaWwx6tq/6CXoCcQQJ4rqL2
	IkjHaIkQM5LP5tG6sKJMZ5RWMDOX4NyyaVHVfUmyQxAlqJm4qTsj4SxukIinwCMawfQ==
X-Received: by 2002:a05:600c:1549:b0:410:cb93:8a21 with SMTP id f9-20020a05600c154900b00410cb938a21mr1942883wmg.2.1707727240942;
        Mon, 12 Feb 2024 00:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETewwtqLbxjzoDSj+831GmqFlV/0DnIaMKNLh0MA71pbX5jBO0GDvqQvWCXBDxN5PkRYmwPA==
X-Received: by 2002:a05:600c:1549:b0:410:cb93:8a21 with SMTP id f9-20020a05600c154900b00410cb938a21mr1942874wmg.2.1707727240630;
        Mon, 12 Feb 2024 00:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRkHUtzwTURdZuRbf9Z43bDKeogkeC44JmCjqDtkU37lAxTaD/ViJaCuKMOXth5hP1tpa9JeSAW5r6g1Uk8un5SdLLQrwudeuRp/8uMdLg4SiFdDhN5w7dpL2PJPcy6JdIxuwsALVBQejYUzIHHSz+oVMXn310ZJSb8BH5UV/DX4inwnN1YPAQyIkx2Tb2R3KqCuHCKzsMH2bmWy/5VDZ/B12oKxy3kPPip5E/mGNUFX4d8Wj79VdYIkGx/9BYxOU3GUkr4JkYI6Q=
Received: from gerbillo.redhat.com (146-241-233-147.dyn.eolo.it. [146.241.233.147])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b0040fe0bb761dsm7841799wme.16.2024.02.12.00.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:40:40 -0800 (PST)
Message-ID: <91b5cc167fceec357d6f3c54c8c67ff315a3c610.camel@redhat.com>
Subject: Re: [PATCH net v2] selftests: net: cope with slow env in gro.sh test
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>,  Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
Date: Mon, 12 Feb 2024 09:40:38 +0100
In-Reply-To: <20240209111550.1880ac56@kernel.org>
References: 
	<c777f75ac70e70aabf1398cefa5c51c0f4ea00f2.1707330768.git.pabeni@redhat.com>
	 <20240209111550.1880ac56@kernel.org>
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

On Fri, 2024-02-09 at 11:15 -0800, Jakub Kicinski wrote:
> On Wed,  7 Feb 2024 19:36:46 +0100 Paolo Abeni wrote:
> > +    if [[ ${test} =3D=3D "large" && -n "${KSFT_MACHINE_SLOW}" ]]; then
> > +        echo "Ignoring errors due to slow environment" 1>&2
> > +        exit_code=3D0
> > +    fi
>=20
> Would it make sense to also add "&& $exit_code -ne 0" ?
> It may be useful to see in logs how many times we actually
> ignored the error?

Yep, I'll send a v3.

Thanks!

Paolo


