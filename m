Return-Path: <linux-kselftest+bounces-4356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B584E58D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4571628C4D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F07EF1C;
	Thu,  8 Feb 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAjcfyUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5647B3F7
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411295; cv=none; b=X7UsJ1IMurjE+Sn/+LsI8VZR4RCNsQsA99KDM5Ru5zNFQ/ZKrpwZ1tTxQ3B9fXeIzDfqk2rOP1rox/jhBYgMb9apNeorubHZ219D/WvtSs66HBBx3NYTEQZ9um3SyENy1MrJcIn1iuoxMWS9hlLjdrF6s8INuTtSsRqevRD+eK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411295; c=relaxed/simple;
	bh=pwkbxHr+wV4lRfBW8VEFVSI9oXUQQRqg9CKvI1QBSpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWEBeOpx44ufpuXm1uLlRtqZpdWLY90FkZ+J2MV9+/4X5HvjJhX1a5WoYHnFEo2E8/vllLGaIFHZqjI24PXG7M6nn3H/aCaEeW6siiGiifxTcTwvbg1nFtkkLSs8/PbPmrnGqacgCrelrlPoFKbPOhJwI56tNqZtLM49o0xOF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAjcfyUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707411292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pr8Wnhn3ZiAH6NmrVrcRCnpAsccxFtE5CsyRB/2mlfg=;
	b=SAjcfyUUPozddTDe63Az5bIPjxBpd7JgsOYGUkdJXOTyi2PPTLkzT1gXYVAtmUqpXRrRtR
	uJyYWfgk1DKGlBVebcGKAvMULLmzoiCW+RJLcSi+tc+HxjN4wGLSYQsQPpnWXrJn8lZaS4
	BnGP0uuROphtf3Q6Dpxs9xlpcG4iTp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-RJQhP8NBOXm83u5pX1IwFg-1; Thu, 08 Feb 2024 11:54:50 -0500
X-MC-Unique: RJQhP8NBOXm83u5pX1IwFg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so116675e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 08:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411290; x=1708016090;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr8Wnhn3ZiAH6NmrVrcRCnpAsccxFtE5CsyRB/2mlfg=;
        b=Yqau+GZ3bnrUX/rPghBurnTneSPRCfACwx5dKcRZySernkyB4LhQvrBH/aW3IiyyVw
         e3Qusonn4ysniyFaHEiJ6QSFQpmcTsMTDntsHG0y3mHZV1n/EOUblTtfQp95CbtKdSwn
         CCA3CliEt4JMNrJv5ltSGZPBp5nGmf7FF0BH91Bb3nCTUl0FSCfY5bKtcspfUTWINOIQ
         nSrenA5rl2n9JNe9HjuJwVqA9lSCYxmVy46XpzBz1vkm42VGOGeYjZUHnw+AcZOnzUmI
         jX8Rx3Tx+eReJSjIKRhj45/Cn8QX+RXOCYboIFd4MYMNzYY5AHFF75nocThMEqhVtzZc
         rJew==
X-Forwarded-Encrypted: i=1; AJvYcCUTjpaV7nyGhCBFdTyReKnaDYOyDwNSBEI0DlH4WEmctbXhMqGq1+5fTWm98QdGNApxm2ZVu6tAgDzzZrrmUKHzqUEH2TdNBjOZppOU6S4S
X-Gm-Message-State: AOJu0Yw/p4j+xHMdrZt6XGK/jz+4mxLos/oA+9YtpNm4t9LfqdBvU3fd
	vfbvQvVOdc/IqUXN+dfXFx18EDxqvXezvkZfmEPs8zvQ/0HKnMAeyQ/8xaW4IeszAXnp8AkPSKi
	207cweyr/lx7ezQ4Gbsy6+J7lDPXKe4vkc2xWcXl2jvTN6+985Q5UhnyNOlGum1w6pg==
X-Received: by 2002:a05:600c:1d07:b0:40f:b8d6:7586 with SMTP id l7-20020a05600c1d0700b0040fb8d67586mr7224173wms.2.1707411289746;
        Thu, 08 Feb 2024 08:54:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7G4BId/ssFGr0z17YcvgChcToBD0X3zqKy2KqnjflxHqQfJp+eHSF/JnZPVZmS9zVqQcAhw==
X-Received: by 2002:a05:600c:1d07:b0:40f:b8d6:7586 with SMTP id l7-20020a05600c1d0700b0040fb8d67586mr7224156wms.2.1707411289388;
        Thu, 08 Feb 2024 08:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg6L0gcQvh44BJxxnlfzgJTke7NoJ8ytCozghTQaOUAHfdCrp45ZQmRtnQjkIPR6YfO7evVvpF/U9PB9vOuAq4UMg9u8XN/bGpKKn5zUpyQxV7tjhRKEejqdFNwkKoShgB8DmzEa4q9oMw/R/aKnAkmGoQxAzN2hCKm6EQNdYZonZ+SDEMzPXV4dPlGVI/osQKXEPxPoibdNRCQjrUW7foPBfx3fcFh+hI5cuZw4HokbWGlk57UpT0JeqZxbbApqPVYKXgg2g=
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id fm5-20020a05600c0c0500b00410141aa57csm2139986wmb.15.2024.02.08.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:54:48 -0800 (PST)
Message-ID: <9d79627f676484590eac5f6b54758ab315f316fc.camel@redhat.com>
Subject: Re: [PATCH net v2] selftests: net: Fix bridge backup port test
 flakiness
From: Paolo Abeni <pabeni@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	razor@blackwall.org, shuah@kernel.org, petrm@nvidia.com
Date: Thu, 08 Feb 2024 17:54:47 +0100
In-Reply-To: <20240208123110.1063930-1-idosch@nvidia.com>
References: <20240208123110.1063930-1-idosch@nvidia.com>
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

On Thu, 2024-02-08 at 14:31 +0200, Ido Schimmel wrote:
> The test toggles the carrier of a bridge port in order to test the
> bridge backup port feature.
>=20
> Due to the linkwatch delayed work the carrier change is not always
> reflected fast enough to the bridge driver and packets are not forwarded
> as the test expects, resulting in failures [1].
>=20
> Fix by busy waiting on the bridge port state until it changes to the
> desired state following the carrier change.
>=20
> [1]
>  # Backup port
>  # -----------
>  [...]
>  # TEST: swp1 carrier off                                              [ =
OK ]
>  # TEST: No forwarding out of swp1                                     [F=
AIL]
>  [  641.995910] br0: port 1(swp1) entered disabled state
>  # TEST: No forwarding out of vx0                                      [ =
OK ]
>=20
> Fixes: b408453053fb ("selftests: net: Add bridge backup port and backup n=
exthop ID test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     * Use busy waiting instead of 1 second sleep.

Fine by be, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


