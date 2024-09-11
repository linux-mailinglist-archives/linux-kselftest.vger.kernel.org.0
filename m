Return-Path: <linux-kselftest+bounces-17737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E23974E7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D441F23D26
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B017A596;
	Wed, 11 Sep 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QASijEmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439C5D915
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046885; cv=none; b=lcE1uvwe/Jxd2v9XBAUF4kkJgjnw3KJ/Kpgg9bqEBCjjMlIOCQ+1avjqB+SXwWqrbBwWLON77v/KLKtprqAKdvSI9ryTAG65qJNu1swmJciuvwkkLxV6ZTj0r9jKiVCTpaHci9V/yo5Er6OPYcXlsLXHpp55NgkLcE62/OdkPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046885; c=relaxed/simple;
	bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMoGiFrgRKFc8K6AJw7CUYEUMBYts+BL2sPtuzl0erT9CxgWmHN8+UDuTvX6dZrRy2Ka0iYoTkC7wyQ1fKQ776GzQwBFPDAZ9mSAgHIkwdWZsf8EpOCFt2HzDRkU9ZZjmH3doq8d+uGZ0rxPYKQhrs2Q+KWXvbTlStOXFfe7aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QASijEmw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
	b=QASijEmw1OFfNvisVK/bQRRuKoMakTj5zeCsdZRp7H+UCeP6GUbYWn7a7rniucdaYoyCXi
	k+9F36I958vEgSZrjfZ38D2eaXk4vChByDV9e+KA9L729Gmb8AHBjlzsFw22Z/Qv+9QNUm
	RHMeS2kQR0BMpSXEVmu27R2yjx6dxx0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xM63pN-KPb-5BLG2_qJtjA-1; Wed, 11 Sep 2024 05:28:01 -0400
X-MC-Unique: xM63pN-KPb-5BLG2_qJtjA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d10954458so351717666b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 02:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046880; x=1726651680;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daqri6JZZQqA0i5W9IXSOaZAiDltFhNX7cyJZa1EE8c=;
        b=Hp5e8eHe1iims7Z/GFEwqwos1PfJ4tHofWWh8N6keYk5D3gpQ7j99k2qj5b3sV5sU6
         96r9TRKh3JblG+YaQWDcLnGaKzkr+D6sfzMLDQWXb7VPVcBEHvo25Fp0RK+HrKbPBLwz
         5oNxx8Y5nyvDyadAxTqZLE3cJwwFquih8sbnaB+cxpxEfdS7FmEGohp+3AzLcuH6QCu5
         aGuCogyR3gTYesmbD1zKocRWiOjMSpc6IKwzhWo3jZqnEx5U0gelirWzBKrRu8c8phSk
         hQlKQqXlpi25PvEhHEyHTqwS+dgJ85UotF4oIY++x/RBONmt2h1xIpkEa8i9lBFdK4zK
         PIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXzJpRfFWBWYRz29caoW6p4SuinrGZtUiy2fXCxVvc0heZrK/58NeeYohN0V5IWv/27SB+kgrCTw1r/263xzD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvi4gvYtGbBH+e42HP2IymoUrGzXVTkatakd21C4wcyHM99T4u
	TGnL82bEG95IBknao9AXaIcKHZovYo/7AL9ods8mLq7t8qXuwujcLfzqRENilk98lYZLrj12hT3
	gEAa8YOjV7KkKgVICbRS2ARckKcggYp1T3otqaDxoOG94G1tM4Rn2BTlPomDawg/3Zg==
X-Received: by 2002:a17:907:97ce:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8ffab186e2mr337838866b.20.1726046879926;
        Wed, 11 Sep 2024 02:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnHzlMw1tu+Z+GQSp2X0RZmYzG1Uff+btBKKc7jIg8BK8u9Kh8sOEAmodgVs3w55sADXPe2w==
X-Received: by 2002:a17:907:97ce:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8ffab186e2mr337832966b.20.1726046878759;
        Wed, 11 Sep 2024 02:27:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a901c737f09sm16779066b.30.2024.09.11.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4C8F6152C4FE; Wed, 11 Sep 2024 11:27:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
 <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 linux-kselftest@vger.kernel.org, Florian Kauer
 <florian.kauer@linutronix.de>
Subject: Re: [PATCH net v4 2/2] bpf: selftests: send packet to devmap
 redirect XDP
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
 <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 11 Sep 2024 11:27:57 +0200
Message-ID: <874j6mee02.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> The current xdp_devmap_attach test attaches a program
> that redirects to another program via devmap.
>
> It is, however, never executed, so do that to catch
> any bugs that might occur during execution.
>
> Also, execute the same for a veth pair so that we
> also cover the non-generic path.
>
> Warning: Running this without the bugfix in this series
> will likely crash your system.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


