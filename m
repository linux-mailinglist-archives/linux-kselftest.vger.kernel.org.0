Return-Path: <linux-kselftest+bounces-36813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659CAFE48C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04E05A042B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F594286D42;
	Wed,  9 Jul 2025 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjrom2Sk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB51FBEA8;
	Wed,  9 Jul 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054445; cv=none; b=LzoZh2kzPwNrq4AfOw2RhVkyxSKg5TNRBUNYrmORQE5Km1ma/s2EkHUHu8URkDSVHd6GR1dAfieoUk9ut/1giHBzg7lwJTX8zcpi0ZqmNd8ojXK8o+KUIpJWDLB/lt/1OsUvom41snXXyWpI38NR0tRfhZtZTkLvBLz7jB3Vu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054445; c=relaxed/simple;
	bh=/EJLC4FVEnxKIgl2+yXcXEV0kh1futP1d7ZaXOrvLXI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Y0oCZV61ZTArHfVU+CVJbtcK5xI7TJfdu6eRHp2sBmM06RBYyXUXi/yxDiUN8gRsxS0Um35FSdWJAIJZjd7kDyeAAeVf0cvckCoxs1gVIcbt5CT5wJVoRahwqaDP3yGpx0EGCiUCNUcoYhdblYa8x1x4VCB7a+7leEusRMmggHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kjrom2Sk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so7117605e9.1;
        Wed, 09 Jul 2025 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054442; x=1752659242; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EJLC4FVEnxKIgl2+yXcXEV0kh1futP1d7ZaXOrvLXI=;
        b=Kjrom2Sk64kN43YYgn1oMlEPdTK5MwS0hXv+yUGyR1vsE7itl+UIyyt1Z3o/DYoxpG
         oWK2Z7XV56xREf1iuQ9ki0HIYm9sXngSoPUb0PxyMGPtzjMQ6I8SRvcY7zEOfVRX4KuS
         NMfb6TUtvkiwgVi5vYRTB4tpfmezs/jn7CBeXUaCuY3RynXf4mBoUdAIrRwkbAivur3J
         78XBaT2nhoZL1mLu7KYw9WrbUN3zu7IsgVZdVuetz2qndoXmQjMC68GIO/VVofDWd+6Y
         twTMjh5GklynfPPePmJbnsXuk9Cr1a8YZN0sKpFAeqwWzCiGfadfFSviLm/0q3KPywwe
         w74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054442; x=1752659242;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EJLC4FVEnxKIgl2+yXcXEV0kh1futP1d7ZaXOrvLXI=;
        b=bNgoS5dSiztnxXjvJeuXGwRim+cVmKmAa2UbXUk5J8hueT/uAQSL2cJsLYBs6R3vMs
         nSob05RsYeETEwhc+BKJgUM2zC2gP341eI7BdGVK4QGwOg2dwWIPsw0AJWf6wNHFQlWE
         I11tXRLqGw8rfTXMvrrjsSedX2KncPRFpAGO9qXnijgHf3iTeaiAUxC9wlp5154h7Ddv
         uyJoG3qpGK5DHTgrEFsF6GQRrmx32qOoNm/5nR0zlptmiq8AhOThFHKN970htdMi0SUA
         /Rb1C3khAvw80VTKbawlPzbl9bCOeDCj4w2o1IQdUOXJAjPrZTvPwAjH6gpJebzIRwRt
         FFyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXWDdLvnOsLyktv0iCWXRa6QvhiKqRd+0ok4R5Fbsnj7pQmCI95mR5pnKwjK23Wro9YueXdLxXJ8Jdd8SEv5o=@vger.kernel.org, AJvYcCXO6z5mNDxUPJH/yXb612YGB7VdQ6bZ8ZGr/EEWs+aK6ma6a3Q3Yq8awFFbq3sNxuSOMiPeTRzp@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGuDoeusSIMvqd5MO5AbEoaj1nv9DAKYhr6PDuoTAkZAW6r2F
	1O2693zB+Ya1byTWW+DelUN/68haLtyrdiDgCRQerI0BHwb1svrpBCNxoFxEFg==
X-Gm-Gg: ASbGncuiWSLE0RGZ9lsWKh4Ra6HKTSDYh6p4oXo2EuzvPXJvApmpehnUiAVLs4RVsDX
	RDA34n24zcWmO5TVtQSw+zJezJBgCY1+axOBqzGnbjgx93MOLrvMVtPHiR8G7R0hCEyUDCWWVlz
	7q3ZBlPtK4Urr59WHgRAuW4fbrlHBmOiZYfLtQ1wdRtfomSyO0g6fexTcgfKASZZefhUXHKTkSg
	niVO2kUiSvApnCi33a41gbpySTno1zSi1aIze+232IMtXldB1y5uC/Rl67a3mbexsix4K2qJrQk
	viQbzC7sp54PjVXQFVvhZvPolavzH+l9s3ntfp/oMm2jCoJLmrlq0MzE40uIWnpS5aNYuM/QkA=
	=
X-Google-Smtp-Source: AGHT+IFBqU0gV4XzQTxyVY6kxBPnEt2VFScsHTAPgcLfXUB3bULxQ0iz23VRhePhI+JxY3/7kIVurg==
X-Received: by 2002:a05:600c:8b0d:b0:454:b97a:486e with SMTP id 5b1f17b1804b1-454d5602748mr16196135e9.10.1752054441625;
        Wed, 09 Jul 2025 02:47:21 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:45f7:200e:5b3:9ce8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c6c9sm15125947f8f.89.2025.07.09.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:47:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  shuah@kernel.org,  maxime.chevallier@bootlin.com,
  ecree.xilinx@gmail.com,  gal@nvidia.com,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] tools: ynl: decode enums in auto-ints
In-Reply-To: <20250708220640.2738464-3-kuba@kernel.org>
Date: Wed, 09 Jul 2025 10:05:30 +0100
Message-ID: <m2cya97mzp.fsf@gmail.com>
References: <20250708220640.2738464-1-kuba@kernel.org>
	<20250708220640.2738464-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Use enum decoding on auto-ints. Looks like we only had enum
> auto-ints for input values until now. Upcoming RSS work will
> need this to declare an attribute with flags as a uint.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

