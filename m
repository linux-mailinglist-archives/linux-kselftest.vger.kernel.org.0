Return-Path: <linux-kselftest+bounces-10563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AD8CBC33
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8932B1C21180
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067027C6CE;
	Wed, 22 May 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGl0X/bI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17B7D3F8
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363765; cv=none; b=Fud5JRalymrA1oaTel1ou8Oj1Vav5F3jiIgSm0ET20WqUl8zhFEClcX+C+3TJRuacQ4qmfX0+JCSOad/K9gtYCHMavPN+Cuw7ipta4voQjoyGbMDnCbM4GFyZR/Dtgrbq/FWiNSPqDQ2j5yb9FtPCM5VkwI1Ny52XSWQFQE7j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363765; c=relaxed/simple;
	bh=1B+iTRkM26xJDQ0//STek9xRvnM84UISSi2Pz/0R1YU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcH9w2df+93ekQTLyQxw+lBNZSzGTDdmvlTFxM2wJFnkGLgD6EDmkudDKXo5W8SUQlnhx+l8DQe/wIFCnlrDINO8Yn6W89hI92Xq55+f5D85/P8SeMDLjTaBTOnpvlaGBWinAuiAp0h9DozT3bNo4sfh9ilJAO+DJWTZmBcc6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGl0X/bI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716363763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1B+iTRkM26xJDQ0//STek9xRvnM84UISSi2Pz/0R1YU=;
	b=QGl0X/bI4uNiCgAvidX2miqicz3sP2yCnddv91BDYL7c3ryn/RqoEOIJIJcYz2zDtmjDhN
	06NB46xFv+dkA8ArrSzfjbSlkKYRt1JLGjNJdx5Qxy5Oz7A2hRoJc5PGJ98jpZthbuF0WY
	CcrLn+7pvMSuj3imwi/9LEBJhgVoVOo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-HXUhuIm9NSWdxQLmq0sKcw-1; Wed, 22 May 2024 03:42:41 -0400
X-MC-Unique: HXUhuIm9NSWdxQLmq0sKcw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354e222dcc5so28328f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 00:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363760; x=1716968560;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1B+iTRkM26xJDQ0//STek9xRvnM84UISSi2Pz/0R1YU=;
        b=UHz2mGyUqYKF1I7zmFkiI3lvr6m4FgwEr3ehSVgwiVqi25jH/2+NyRY441OpmAIXKw
         qtZzU7gfSRq1LX3VP3bKc6MY8Yu4+DjpGzccp2PGcnEjL/JrekYdBbQmK1OspDs8Ehxt
         SNrAOLwHTRBNTMraGavIHIu1Jjf2pCnCRv0k3p4cKSKQnDJ4bNTIJ5lPteWK2/FlJAHT
         5qCW0rFlZOS1e+8kVHx+x5rBU8lU/Pt+hytp2LDJq0fZVuF76/XZE1Tgc0Kx4THM79dD
         C0Y09BqgwNY4+irED8F8UyFW/Noc/4KFC0uPFte/1WNB1nQYy/HDqpCH3DtDicTazVyx
         231A==
X-Forwarded-Encrypted: i=1; AJvYcCV3IeWmm4WlmsQrQORG0CbknbsraszJ3cWOKe9Ov9hW3ouz4AEMCdRkManVP8iuA3gw9wn2RDVFX9l1hPxHe8RPiBaq1nqzXC+s7uYx5uoQ
X-Gm-Message-State: AOJu0YxGHtAx9Ggoqe2bhWpk+0aq4eC8JDzS2isWCGKe/tBvF1Be+rXH
	TzX4TRBx4NXdo8YhZAkGfulwo6zMk3CTZQgsMdHIPDgonBoZFas3nppapSqPNfCN1n6TpHEC9ej
	T+nNyGHK3JxHXIuHz44GLGBcAta0/qvoyejBuhTzbzPv5rvkK9Zazz6F8Xu2lPbELxQ==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr8033195e9.3.1716363760488;
        Wed, 22 May 2024 00:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrNJYQNBCV6/mB0UpUckR8l2hFK7QYVo9GtdTwp5hyr0ELTVeHubB7Oy+dPQUccQniC+/LQw==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr8033045e9.3.1716363760101;
        Wed, 22 May 2024 00:42:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee934csm490842515e9.38.2024.05.22.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:42:39 -0700 (PDT)
Message-ID: <b5e333368d9e69efc6325187a23cef4f4337c738.camel@redhat.com>
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
From: Paolo Abeni <pabeni@redhat.com>
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org, 
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,  Christian Brauner
 <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@android.com, linux-security-module@vger.kernel.org, 
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Date: Wed, 22 May 2024 09:42:37 +0200
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
References: <20240522005913.3540131-1-edliaw@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 00:56 +0000, Edward Liaw wrote:
> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> redefinitions of _GNU_SOURCE from source code.
>=20
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.

I'm sorry for the late question, but what is the merge plan here?

Thanks!

Paolo


