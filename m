Return-Path: <linux-kselftest+bounces-20796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483A9B2B9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A601F1C21DAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4918E341;
	Mon, 28 Oct 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD8z4mXa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273E155744;
	Mon, 28 Oct 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108140; cv=none; b=gcLdi63dm8dw9zgI9ZCpmO8sW+WZAdx0utKUgPTJ61eiiiT1cGV3PyrlJpMDvHJGCf5rgEm/ZWETz2Eu78uFaNM1hqZ9jj7a1HN5DxSlaL2+DOo15Mra5ZspazQPtLP5ZqJRm3p7HKo6pBDbBPKW5I09rzynhOACAZE4Q+5D8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108140; c=relaxed/simple;
	bh=1xLSzKHe1GGEJ0z0ie9jcyKew1Ekg9jOq+7qM4LEs4k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=M4mQXI1pM9kNjtQ4f2uSYKfc+ccNwmsD0w1mCB06ifiPrzVZKuw39yrbrE1tieWlhSllGJx/ZIiNZF7I2MRB23kSwzLu4bdBbSdubRsYv8EwZl5Ch4z4p0FzMVQbUrIdNZgdyV5ZJmixuwUadLZvWI2b2BkGnkBk1Wp3p8VatVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD8z4mXa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43159c9f617so40228755e9.2;
        Mon, 28 Oct 2024 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730108137; x=1730712937; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xLSzKHe1GGEJ0z0ie9jcyKew1Ekg9jOq+7qM4LEs4k=;
        b=iD8z4mXaPh2pEjvUdLVeeAMuNCXk/tC0SS2OjbGjcqu1md6RQ6MjdONGQIL4g14RU4
         lGVximczL/pgtn4vYj/ajBpGvHpQQsCyhvzwXX6YgPnNdUKbNr9T14c4pnh6Twg9qOpZ
         IjQ2eqNmuSKoy5Uai3pdC2pRiMwDJCQa0bxR8sLuB7h8BCgLYdWdKs/YKXbX/CSLxDBn
         /1bbh1LoCI46I3hwAglQhHFMSFZXhNsTbCHvts6ZZeCtisIKujm0CSHFOi4oQmtZj4Ax
         DZilOgkqjR6+Ky7ILzYJr89GjvoyJwnrttDsE4JdsDIPuPzFqyh0H3mKzasMzsxIF9a+
         qIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108137; x=1730712937;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xLSzKHe1GGEJ0z0ie9jcyKew1Ekg9jOq+7qM4LEs4k=;
        b=YUxTyZxuxoyJLZu66pJ5OCRtPQL1MQR3XU2v126HguqI/sNREGOgyLCpcdX+kZk4KX
         FgTSEeLc9JQpU67Y5uxbtdvdSSvPz+Vi38bIwPJ2Vjnp84/kW61omBDk9aya0AYTB7fB
         JEE2RvKMPpm74c1d1EBuHWu8yUj0kSilN1dzMdlTGPcMJ5bJ6k20o6PsqCGTjnDp6zXu
         ywxi/pjlTHsBkYbMuHLthNIPcC/bUuFepJ5ZeNkSAtWriPqWRL4+gG2LAx8eqWKAZgj8
         6kP/7eB7HQi2IbQx+DzFvzLd2n/M9djyoZG28ZM40j8uU1/SPOu10vfrPmtsHiW7yr9+
         lcrw==
X-Forwarded-Encrypted: i=1; AJvYcCU9DI+yE0c3+wdwtVwwWfokVKqHprpT5kXm17wIP4HPQNa67v34ZKlC0uxKrtzPuZ1uHIMJxxOY@vger.kernel.org, AJvYcCUdt/evCD7GrFRTfmPTkpg9JrGPcDGB1eBl2ZRZa9oO6f5EKBZ0E953gSCw7Ha46jASxw8KvA25Jjo0lv8G9Uil@vger.kernel.org, AJvYcCUpuuWwsjeXky0g74uiLDkrLzLYrvvI8JGN5qE7tYzYtzH+S/K3SiYudzqFIGYQNFrRnC5Mfls91tWhu80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuE3q3LzF0sgzA/Zs32ZRphrRvjmWGDvi+3Ztc3ZwxsHH4QA0
	NCSWRje58W2Q6tsas/vFk+cg8VMpXBivXic3zQVNKex1P685n/kMMwV2kg==
X-Google-Smtp-Source: AGHT+IHUMTU6asWT8OCzQlwfhSgv1lTFG5PXHONENrgG8beai824mHwTT76W8XevaHGE9Y+DamEFqg==
X-Received: by 2002:a05:600c:5118:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-4319ac6f848mr70292885e9.2.1730108134901;
        Mon, 28 Oct 2024 02:35:34 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b570:335a:e9b5:2b42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b54303fsm133428765e9.7.2024.10.28.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:35:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  sd@queasysnail.net,  ryazanov.s.a@gmail.com,  Andrew Lunn
 <andrew@lunn.ch>,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 01/23] netlink: add NLA_POLICY_MAX_LEN macro
In-Reply-To: <20241025-b4-ovpn-v10-1-b87530777be7@openvpn.net> (Antonio
	Quartulli's message of "Fri, 25 Oct 2024 11:14:00 +0200")
Date: Mon, 28 Oct 2024 09:14:50 +0000
Message-ID: <m2bjz4wpv9.fsf@gmail.com>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
	<20241025-b4-ovpn-v10-1-b87530777be7@openvpn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Quartulli <antonio@openvpn.net> writes:

> Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
> with a maximum length value.
>
> The netlink generator for YAML specs has been extended accordingly.
>
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

