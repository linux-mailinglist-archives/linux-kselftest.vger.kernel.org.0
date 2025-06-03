Return-Path: <linux-kselftest+bounces-34194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520BBACBECF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AFB171BA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30641188735;
	Tue,  3 Jun 2025 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuPdcSp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985ED2AF0A
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920825; cv=none; b=qdO0YhH1EAYeMQMHD6dpSH63sGUSg41t6OipEZ72TW4iNH86L+y0bi7/8PdgzIBIdhCPGOM415Kusuk2bjoUNbHW6I33cr4oWuRWQczR+ifyaynnNCDpYxdr9gF6/ELSV4lDF3TFidHPfEPI3Xt0VyMIThPtO1xNCfjUHju57dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920825; c=relaxed/simple;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtawHN72mudkc9OJkiw3LqKD5VnWFTHR6LqJwm4ARIpQp8EVAgTozZSKYYTDXDgO3+a/GT1opKK/2QJhJ0uHEZHYHLu4J8+AwN6sx7D42L4bA6MNnzboBE/0rULCzz9WWJGXsuHSkUm0Myba1VhHrjjf3UvygE0FUHEPi8R7SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuPdcSp/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748920822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	b=iuPdcSp/XlsxpxkRAshQJ8juRJA7K2r9ClLrH3oStkWkZLrXjHNDjthmLXyIKpOTBm6Xgn
	dVGXY4O2SQnar3lWOcGbL5LDMou1qiq9hVoKVI1p7kDVNQOi4w48v19fcQMD79phyF/+By
	CC+YSSJy3wxBaY6AziRVa7PZdR7ErbY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-G_lIR1VUMlaLR1GABnjlCA-1; Mon, 02 Jun 2025 23:20:21 -0400
X-MC-Unique: G_lIR1VUMlaLR1GABnjlCA-1
X-Mimecast-MFC-AGG-ID: G_lIR1VUMlaLR1GABnjlCA_1748920820
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31220ecc586so4372980a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920819; x=1749525619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
        b=UXSfptyU/Xvh88z51DRYdIkJCqkmDDm8P+qsbfkIaECJRk3nmeZTuOmWQ+mwzgPvJ9
         lH8uOrFqu9k/S3Gz8lmCCCWBbDX0ggPvgQqD5gncYnjKGDuWLEqelyjkMPtafQBd/TGH
         WSQ+GdEWQWcCHaOjjqaMkPTsfDUyT7hx7VvZ8CCYd0xkge6lYk7C3xsEk51VAw8xVytp
         aflwnyx9qrQl2MvQ4+UnR9LblB4YR5gPfnwQnzobmFJ8v63SqFrbwU5HlYLetZlwCBkt
         RrYkVmweCRxcYqUhDcGesfajWcRNmmwTtiXz7E2CsTK9tWYOeuoTHZH7VS2lHgMeepxH
         9HSA==
X-Forwarded-Encrypted: i=1; AJvYcCU7uKPjrfKyqchUS8ChSsQOVAEj3a+PbkdotJMwosO0MkZmpP5gkl+G1hj0UlsrlgQ+J66VR9mvJE3gn/hTD6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbr0EiWsPNGYzGcDu/QPHMBgjl4lCEAw/7Hu70A02wljYQIrot
	NR2EdtTaIxQhIFOovq3NsaiOTZ/cfjg09r2O8jY8t5Gkwdb9Jl6nanHUHM4bz2Tri+Ql/sPbP2f
	BYoD6W6iEzg5zgLjBEfQT5POWjfMlNjpU8GtR4Biw0SrcmhON/zsPzgKp4kPd7kqOrDmRW4e0g1
	NPEXjlRmkswfKP/BC2w0wRI4p5nk5JX2HdevF6NwAOrTSADObgvD3jXRk=
X-Gm-Gg: ASbGncs9DH4zE35kV7HIrzfPo8Bo2w1F9mWqlGxFjiTfo2JN/TPr7dEwl53kpf+ORVO
	0fI3HlAFLBl/qAa6Pn9o8+1REqZLrtKiApD6QNYuYvLPi/nwMmiNUgFSmj4ZIi62+LLkSDw==
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id 98e67ed59e1d1-3124150cd29mr24182676a91.13.1748920819229;
        Mon, 02 Jun 2025 20:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMKoDoVhANJXhkEH8PMyc1LxUezj6sEzlWUU8w4Uyd+7t0SdHYB02l6iAUnHMY64ChUWPuoGBpUpLK5iNRSqc=
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-3124150cd29mr24182639a91.13.1748920818809; Mon, 02 Jun 2025
 20:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-2-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-2-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:20:06 +0800
X-Gm-Features: AX0GCFvi3ezIBQa7yKxnmidSOgr8eNk-oM266seJU5yCRwglxX_y22dfD-57w2A
Message-ID: <CACGkMEuwb+EcT=W5OwbZ=HOf=d56cZFKF5aYPx0iCLOZ630qNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 02/10] net: flow_dissector: Export flow_keys_dissector_symmetric
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> flow_keys_dissector_symmetric is useful to derive a symmetric hash
> and to know its source such as IPv4, IPv6, TCP, and UDP.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


