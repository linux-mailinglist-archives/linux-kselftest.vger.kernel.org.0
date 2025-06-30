Return-Path: <linux-kselftest+bounces-36098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556BAEDCDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205CD3AC502
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1977286D62;
	Mon, 30 Jun 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf795Doa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06599272E7E
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286837; cv=none; b=Gvrek653qMo3XbXLGlTBzznrcOTyPeO+gVq7+dZDp9tQxvSbXjyavcP36VmVl82/8gYCqy3m2HGGCAK96XcmzeRO/wmUMOF/VfTwbrPYdcU16RZN6iar7OKDWdE96PCkCwE0EFyCbD5yzYhwC1IVjWzJCLdXDJw6rHhvU8q8d54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286837; c=relaxed/simple;
	bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2Ong24xBT0WyrNY8zsKkD2pRvuk/DrlvYmS17frveM265RNK4mI5FiiC4ZkQQ/rH75x/s0j82KAUTyIvuy2N/ywGGQNZR1PcLGRf8Br9qCgnW0Ln8gKqztc+Xbwu7iq2bahgjPPPXVuZthftnNsWyqfhfJpPmn7FrkQJvOdm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf795Doa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
	b=Rf795Doa4okwsmeuQYg4LADxRBqEQKaSmtTR0mqfXj6zjA954NGYn7HcrllBMAXzwCcaKS
	3/ELOsVCAl5cG2tV1kTDHZ4mav/SE7g6Ax3P922z0giglL9VuDNplJGSrQToruhIJ4pFz3
	IWzQMXEqR4MNOapWHin7P3/b3leigG4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-7P681oNjPZGPZ8sVuf-XWg-1; Mon, 30 Jun 2025 08:33:53 -0400
X-MC-Unique: 7P681oNjPZGPZ8sVuf-XWg-1
X-Mimecast-MFC-AGG-ID: 7P681oNjPZGPZ8sVuf-XWg_1751286832
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad56a52edc5so377242466b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 05:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286832; x=1751891632;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
        b=dQIN4AYhuS4gglkFGNWFdyzyKtDyCE/cShEThgDidjml3E+BwSqWRgK/Zp+N+05ilb
         5EHNzyigl+F2hTes4Kq5QInukF/XGZMhqvK6gyUxVzBxJrVeGX31OTeYZ3zEd2aKFZnJ
         BpYOXcBCRpctMpJISNJV/Rm4yvX5uPbzv3V3AWMksJvPYkq/7UnNZQHqxhDOZum5S0bC
         BYj71YDqMMpUxNEpmnwSnXC67kzcpjhP+Onn/ZkZ3cEZFW0CjmXazamGBW9tLoQHV8oi
         q13d0JOddt5kM6pp1Yszm894f9MJR3DAc+/mIUT18wyPpm4Axd7pSwAAWQD7V0Gk8vUo
         Vddw==
X-Forwarded-Encrypted: i=1; AJvYcCVMZfrv0pfLhRUrJv+mwbyoU8B5sEjviArvAnWz/36VWlrL7D2YHD+fwNeTcC2/WBXBsezTtzKD8LE5bkKrzUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFIXL2DD3Kh9Pa0sr6f9irAPBEHjq1fKoeFxVgrVtH0D27nhs
	l3408525i6+ez4XQRwM0pxKbwVhUV8VKd1Qj9MWbNqkXDnqO34XGcsp7NOwmgXpEVh9SiT2f9Rx
	jihgwFGlGGMGNUp5esHQpBrMlA7BMp6l0431OtQHGsdWL1G3eaitG6forvwIo7xStZjTkiA==
X-Gm-Gg: ASbGncvJuOpmkrK6f13koK/OXMDGQOXCkn4mURBTGDKkbrVI167wfCQ1looxtSdw2YM
	jhqcZXTShoDoVnmkXePuBHSSCsBTw6sF4fwrHt9P9vZkNd8V8bFw0M6tlBHLZKvdPuzAlnEH0aN
	rQyZvQV3EYgYhwgfZ5xm+ui3Hr5Xl0ZXtjRlz0YGGVLGiSGDAkat1IGEvEddrKCjWVCFW/UyxIt
	JD2lsH4CRxlApiSpdoTdQYdaY+yj3WQSSkAdD3XtheRNPN9td/24dc2ZXPy57NOF/rlkZdXakjp
	MTe7lnC/zhj3C2S7z9s=
X-Received: by 2002:a17:907:608e:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae3500e02a9mr1046996366b.34.1751286832237;
        Mon, 30 Jun 2025 05:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcjceK9RvEHC88OQB5r6+jBRwjCnSu1XO6IF/59hEXlyuOAfoc1Cs5C8c3NNtvik13ennRiw==
X-Received: by 2002:a17:907:608e:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae3500e02a9mr1046993066b.34.1751286831785;
        Mon, 30 Jun 2025 05:33:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01237sm678103266b.98.2025.06.30.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:33:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 14A7B1B37D1B; Mon, 30 Jun 2025 14:33:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded
 linux/version.h
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Jun 2025 14:33:49 +0200
Message-ID: <877c0th0ia.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
>
> While I'm at it, sort the includes.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@i=
ntel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


