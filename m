Return-Path: <linux-kselftest+bounces-2580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C0821E58
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 16:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2F01C2242F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF312E7E;
	Tue,  2 Jan 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBGP0+KB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163212E6B;
	Tue,  2 Jan 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f9fac086bso72766526d6.3;
        Tue, 02 Jan 2024 07:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704208150; x=1704812950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMS55Vzekx4T3pQgk1uVM7+XggMIpgc3xmmxIF8jTeY=;
        b=mBGP0+KBZZ5RVjbTox05T7TLZeWMS5Mah6/1rkZVpVHcgaTbl5HrzlL/9aKUOAadXx
         MzpiIKsw9nBqTf80bjtnMTP7qR02WbxaCxyvFbf4GFiQcid7r1MvpCcpluQ1hUKV+XrG
         S8S0FWWQifdnKIx8y/vNQ/66FwP316x7GRO/i5998wEsB0Tbg2BfC/brUIL8lR5h9qxm
         f2zUbJb43Uc4CM/vMnPB4GAZfSV0K45Ro499Zn1s9GJuwQVQOduhDg9HS6Wofz1r4c3s
         n4aMY+37TKhYnw2K/eG7xSlwu1/v7l8Gxcv35iEm8wEYZMaKAsgEQ8kr2L1DwSRUBgLU
         OeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208150; x=1704812950;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMS55Vzekx4T3pQgk1uVM7+XggMIpgc3xmmxIF8jTeY=;
        b=kT5Hic3wDvIZMnaka5cjIxpfJZefBBQQ/cDy2c8/DpfJzmeMo7iVzLEFXpcx4Z3svh
         MuTBqO3XQYKit7SQGJavOyNTZwFEJbBUypmnBCIlV8H2lDzeNmy2atrjfOTpt9MffiFu
         dhI6JYA1Bibu+X804/qi6HEAwpoE85FBSnW0mk7dSnosSkIU8LKGT8rN7AdMrYxe2XUj
         frrfuX2+FnrTrSgztqOhN08/FxoGz7Vz4srfSIsDfTcz0rcLJIRJTxArCrL3TCS6FomE
         W7U/3+8+/1ZKOi3McR54IoaMHM5inEJZRa4yk3IIShbjwxzd0mPkpj8WfJ4F5C4MWz3J
         bXqA==
X-Gm-Message-State: AOJu0YxvhlSMjIuS0XC0EInWGnGV5x8cE1py/lI9Fvh2Qrby0ZQ9ZZH2
	T53yR7wMkp2Z8YDaDhh8fbs=
X-Google-Smtp-Source: AGHT+IGWbSLusYM73Mvn3tf3GQ41JzvUWrvoogxoINH6YdIWkyWIMUa/huqymo1ygkFfvYp485HL0A==
X-Received: by 2002:a05:6214:e8c:b0:67f:8dfb:b6b1 with SMTP id hf12-20020a0562140e8c00b0067f8dfbb6b1mr28230780qvb.5.1704208149845;
        Tue, 02 Jan 2024 07:09:09 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id n5-20020a0ce945000000b0067fa1179b57sm8875424qvo.131.2024.01.02.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:09:09 -0800 (PST)
Date: Tue, 02 Jan 2024 10:09:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 lixiaoyan@google.com
Message-ID: <659427152812e_2907a12946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <5bd9a1c7-63e8-4f5e-a749-c7eeeaed3c42@gmail.com>
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <5bd9a1c7-63e8-4f5e-a749-c7eeeaed3c42@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] selftests/net: fix GRO coalesce test and
 add ext header coalesce tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently there is no test which checks that IPv6 extension header packets
> successfully coalesce. This commit adds a test, which verifies two IPv6
> packets with HBH extension headers do coalesce, and another test which
> checks that packets with different extension header data do not coalesce
> in GRO.
> 
> I changed the receive socket filter to accept a packet with one extension
> header. This change exposed a bug in the fragment test -- the old BPF did
> not accept the fragment packet. I updated correct_num_packets in the
> fragment test accordingly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for adding the second test.

> +static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext_payload)
> +{
> +	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
> +	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
> +	char *exthdr_payload_start = (char *)(exthdr + 1);
> +
> +	exthdr->hdrlen = 0;
> +	exthdr->nexthdr = IPPROTO_TCP;
> +
> +	if (ext_payload)
> +		memcpy(exthdr_payload_start, ext_payload, MIN_EXTHDR_SIZE - sizeof(*exthdr));

minor nit, in case this gets respun: ext_payload is always true.

