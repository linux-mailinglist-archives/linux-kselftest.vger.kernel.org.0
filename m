Return-Path: <linux-kselftest+bounces-6170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829E877C79
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418131F2104D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A714291;
	Mon, 11 Mar 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoNP/pKR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B511725;
	Mon, 11 Mar 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148716; cv=none; b=OTlMUlsNwqQIC4XGcEm2ZAZpLet9g/gTlBQEX/kEaGEb9yEwaZMhAujQSIp4+tNU2o66nllbtqeOb7RtxgZfXUfact+J2KPOwR/ic50MSHekqhWrxo29nHxaW8D/Gt23tSVlV5TFohTYp5JZ6Ie8IVMPCLjOpx6gyGbqC+VxPgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148716; c=relaxed/simple;
	bh=J4jr8Nj1C74GgqQYi+iZpfykkkAoiiD0M5AXL0/pJwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7kT/6X/2/8r1oiAKp9fRZaLv0YFt1rCtiMsoGULlGJgwVCCkuERHteDtKQ/OPbH/d2wLxOHEKXo574niIIxb4Rka5bRRazwS5ZxrNnHsdqUZLXxRR4o3L2G8dhsydoyTZjeL5XNAU8ujIXiiVMJY6jn6nAX7446HMc8Dmc5etI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoNP/pKR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4132a436086so3808925e9.2;
        Mon, 11 Mar 2024 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148713; x=1710753513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbqKzLJ5nYzAiRDltlyNyfUgOESvxNq1tUNr15ZO288=;
        b=YoNP/pKRhnzKC6sRXr9m83SY678QVF1oz8XYV9XkZkmsw5Tnae95actDvA6UY0XJcS
         9EMW+okI2l123VqzwGHph5MUrNF71hr/+qOrwesmwU4BuAbjAjfu4PbqRN77+WURDXip
         /6UZSCAD1SFNr2uypSxIXG09oXnNHQ+KJY+/hCDL++jJ0yODd5stonmKoeUi6W8/3tNj
         V359DrN6e2oeDzHHmrc3P1nz/Xmns51TUrM50BIcRgStqAofg1FOe1E+kbyM5LjEwhUF
         Eb+IaADh/nDUsuQTior7DXiXuOcKqwUZgxJ62ppdYderhLJHzfJzGWDa8UXoIpkjJlBt
         Eg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148713; x=1710753513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JbqKzLJ5nYzAiRDltlyNyfUgOESvxNq1tUNr15ZO288=;
        b=LziIExIbc4rzgmeaiuwnuCqN0JTv8ts7w0cpxHAviTKp7S+Dsmz7C+P8k79Dwkg1Nt
         z53madpNJDUMVz7Ock51i5iNHtV9AxH2rnOCtzgx2DouFFknP1ruHtF8QndtJSFv6VgH
         PCgNlnLHftxqbqsOc89Nny87xjyZETZfBn+ULk7q9yZfHsmtSugOiOBu8omLa4fMbVxk
         iDKRAbwnpEhIrAhTveTIOtRW+hKNll9wtm6xn+Of9Z4DYjEBh+zbEPTnh7nrB2xliVVk
         41+8P36eBfV+uqQb3x87+ysZM/ydSDWBd1Oy1eebDGgQNfHev0plpTE09f0kxnnqP5aT
         GPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsdT2x6iKnMeodft4kuFJv97z7RWMobZZxH4+LiQ3yLhoSr0hUmR7s+PmIP/11QcEgNOlGhsRDWH3fjerVrlhIOJeSVxlyqP054G6jZk8FbmKEXa/3T+gLcPrECnQE7MpGNkLVHOEPWOJ2qOeuwlXEuCpWj02dJOemCbxhV8VmRFTfGYRA
X-Gm-Message-State: AOJu0YxD5viyIKRFx/SSi8Eh2qC20W9r1FOJDk6O3p9etTKpaormUGKJ
	LSzxQpxmU1ovFkuH2yAB5uopz9FcPXRXrerlXyaYfunY8LmqfGdl
X-Google-Smtp-Source: AGHT+IHz6EhEngVFDAog7ttdlt/LibXaHDHHwuT07CnNnxofI4EM5T/eUx7a+P3GTAt+O/gwngnHyg==
X-Received: by 2002:a05:600c:3556:b0:413:1013:cc7f with SMTP id i22-20020a05600c355600b004131013cc7fmr4250696wmq.29.1710148712913;
        Mon, 11 Mar 2024 02:18:32 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b004132f3ace5csm269938wms.37.2024.03.11.02.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:18:32 -0700 (PDT)
Message-ID: <967ed173-b556-4bfc-b3c8-ff0fc902b951@gmail.com>
Date: Mon, 11 Mar 2024 10:18:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru,
 shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
 <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Sat, Mar 9, 2024 at 4:35 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are
>> relevant only to tcp flows, and as such they're used to determine whether
>> the packets can be merged later in tcp_gro_receive.
>>
>> These checks are not relevant to UDP packets.
> 
> I do not think this claim is true.
> 
> Incoming packets  ->  GRO -> GSO -> forwarded packets
> 
> The {GRO,GSO} step must be transparent, GRO is not LRO.

Sorry, I should rephrase myself. The patch preserves the
current logic in GRO. These L3 checks (ttl, flags, etc.) are written to
NAPI_GRO_CB(p)->{flush,flush_id}, and NAPI_GRO_CB(skb)->is_atomic - and
all of these are currently used only in tcp_gro_receive.

