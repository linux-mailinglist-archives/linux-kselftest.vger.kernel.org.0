Return-Path: <linux-kselftest+bounces-34208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06AACC531
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFEA3A405E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CB1A23B6;
	Tue,  3 Jun 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl3T/yn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFC433C8
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949455; cv=none; b=uAFwVypJ36Y3xXtU5lOWlVobnTKk7+W/fk8/gnVWbBiFWlQerzeJv34rDuewSz5uY2j1WCrxTwiSrDWVqwn5/CVhPfI4J86pWee+Bh8T1rWd/k1nc0osFLS6JJy1+IbuMuBaup2apTfmLSVNOjw3dCrBnLDoiegCgfiPU+8t7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949455; c=relaxed/simple;
	bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSAHWZHZ0vvyaMmbRf8EL6K8T0g+7KkXrzmkUBe1SDVUyTthohHdqCuvm4+ZmfP+OcAj7f08+q23292JCVVQblHWOmL7nVoPuh+JOzJAyBlT6e24s3c7I9fEVknGRUcFBNT0lKq+JZiIgLT1FmatAvTxBD19oN8Q71GWeBrHGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pl3T/yn9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748949450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
	b=Pl3T/yn9xts61ahKkjlmVXSo7MYh1SDfkknErtjScn8PEKlLOJkUqXXQyG67R7LwiJOc7m
	MIcrk8WXdcltlrPt7t/4eLyYfb9xeLZZYJnX2guV0pWZRXEie4GSA/BEHRgsLcCPakG80J
	8Q0e7pgPyqx+oNX9yqOSPC4AMQIqny8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-43jW-oU5Px-cGl4vMAvvYg-1; Tue, 03 Jun 2025 07:17:28 -0400
X-MC-Unique: 43jW-oU5Px-cGl4vMAvvYg-1
X-Mimecast-MFC-AGG-ID: 43jW-oU5Px-cGl4vMAvvYg_1748949447
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso3691282f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 04:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949447; x=1749554247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
        b=m7DKvY3TsshfN8izhzRHlprlVcb8Uh/utPaK5ArINAIX4CMHG/SDGEbURhQweK/rSf
         3ViXBUlu+IayJhnquB8amZeeSvJk4Gg6UQsfJwMIfrAo2JicxX/J3PdsVgj0Mtu0DFyQ
         /KsjHCxwvdU64p2PgAW7L8w4fX25+OQ5QxRjPnAd5KrdSMCNg2Lr/4NG0cWtgtPCfsMB
         Fb1FO58rO4N0GezDof2n3U7g2ZlHuBldWCsLWj9v7+xjRGThOCWr+imY+/FyqP4gVY8j
         YpWHHXwdsMLq/5iisBQArL5wFWSuCEtIFlcopqlt+d0a1tP6GCXU6LsixXh6dF3tzlI+
         UPpg==
X-Forwarded-Encrypted: i=1; AJvYcCU+kmhvoIZIKvNYmYiFTomLVNm9GbK3Wpgoj38e315bh2Xt0YUJ1gLQY0DM4xAiStm+/jMYbLCzxvbqJW0/oZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB60Em1OKacXLrnZJLCS8x85O9l12QQK7Jj/xtao8TOfKOgukX
	/lmPqpx8/2O5JpX4UIeEpIJGEzfTrN0AoHzlI3+6ovU2zia4JRIA7r0swQAD/cUGue6Zz9GHZI8
	Y/OiQ/Oe9GAUHTJM9NADV2k/NPJUlockwTj8rsmUsJ4W1dmIi05FpnuIuwaM1izNHcRStZQ==
X-Gm-Gg: ASbGncvGcHbOAOPgrbU4zI+3We/3tCBRz2Lq/RKGdn4w3A4j/GOL/8SJsm4ytKVhP6r
	dKrM7/5ZlZ9LsyMHClthRkDBKhFbSLkmVBkhlRf4W4ekx2efvNXCRu+dDn2g01ggGPjG3wsUrv+
	QGifqYHyGOPVDYmFXa6a63sAm4/I1vHr/oXU3lV3pmIZ+RCnGhdvRHM/2Y6+zz+rCpJ5bXUmB4Y
	VlOmC3qreIA+y7s3t6KfCRd+7Kt2zvo1Pj/7uTBKFnjkVgDB2VkHY9/5DHnFFDMXyEg+FNtOQvp
	96Xy9zxDrPX95vVO98UqUB5w4jqsQljCdxONBwTOfDCM9FlFwPBmwhYG
X-Received: by 2002:a05:6000:2388:b0:3a4:d939:62f9 with SMTP id ffacd0b85a97d-3a4fe3936ddmr9924189f8f.31.1748949447422;
        Tue, 03 Jun 2025 04:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgHkfoSSvodaKiarQ8d4Om1K+dozYk7SljBPcJ37SJ+JrlXuJ7W8CXUiisgniU4ysWii3mJw==
X-Received: by 2002:a05:6000:2388:b0:3a4:d939:62f9 with SMTP id ffacd0b85a97d-3a4fe3936ddmr9924156f8f.31.1748949446990;
        Tue, 03 Jun 2025 04:17:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d1fsm156897935e9.20.2025.06.03.04.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:17:26 -0700 (PDT)
Message-ID: <bc91b431-9cb5-400a-afee-f5cbfda11788@redhat.com>
Date: Tue, 3 Jun 2025 13:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: add configs for the TSO test
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org
References: <20250602231640.314556-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250602231640.314556-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 1:16 AM, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> new file mode 100644
> index 000000000000..ea4b70d71563
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -0,0 +1,6 @@
> +CONFIG_IPV6=y
> +CONFIG_IPV6_GRE=y
> +CONFIG_NET_IP_TUNNEL=y

I think the above it's not strictly needed, because it's selected by gre
and vxlan (indirectly), but it should not hurt, nor I think we have
minimal non redundant knobs list in other config files.

/P


