Return-Path: <linux-kselftest+bounces-6171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EFE877C87
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82221F20FDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162B1642F;
	Mon, 11 Mar 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7warfEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F231642B;
	Mon, 11 Mar 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148898; cv=none; b=qaLBtuTZz39/W48pT5jRHr60cm04jOIoUiS5VWt2qpLv3wqlD3UuAtF3Z8F+y8s/qpd5+4Mb5K3nHJe+W6JSaYEhvNcHXnq5y7Z1f9Q0O53gD1iJgdPgfppGmWRhhLXtclAOTfyaFntYI8u+A6ntQNFEKorRagryWplR6Sopbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148898; c=relaxed/simple;
	bh=GVbr1/fS1wvn76XTylvE5OL/EQRMM9H9ThuJC6BQ5A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F3h2biVujuypC9jQiQKlnxwVmH7wesMMR2IkKDOZxWPKJIDJnLWTbZ5zaPOTX7eIHCctwa/kAghaVXFeiHj2ZuGVU0PaJ1E04a6LiKEWCdyNmD7WDMYQ03EZLQMuOQWDEr7DK/XYFWHmPAEAWU/b+kJsU5UEnHSQans2/b5YmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7warfEt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2505352e6so60550871fa.3;
        Mon, 11 Mar 2024 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148895; x=1710753695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+GcVXdcO9QKtnQAcCLqs2Ny4ab4g7aLnhL8kh6HOy8=;
        b=b7warfEtX2LtRPifET499KeWBkg+Jbu/zU3oUuY9iZXwcYkLfLrGdqqAoKSqE87lgV
         sHMEVCkOdevuMZr3K5lxX/NoOz68PgigvW9nLWWj2jrtxQ8xALQ8xnJ7PHhdhOK5I9MK
         XE1aScZNktqXP2kG96FAaqujK71ys4/J/77wEgHyWxfOkfPa/GjXCM/u29WF+DzrbpOt
         2j+ea0xtOUoTBGnOyNBcUL1bc97OwkUk/oyh5omYAFLmGb1lhZRkWkTwoNvRwp9BFG4Q
         /iJfgqxdrmesHDK+aWkHUpdlm9wm1t69bmnRuoKTLwb2as9QxjAwvyDVFhCv5SF3VrNa
         trhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148895; x=1710753695;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+GcVXdcO9QKtnQAcCLqs2Ny4ab4g7aLnhL8kh6HOy8=;
        b=vSu2fJWH287nihGtxo6S5PXbgcXV1BFpoSugWAZu4iyYIMQUecNf6jNkEj5X+nTUwv
         TLAVUlNxLHDH/wSMTA7OfrTLT9bVuM1ONPYa2GktgKKttHYfTdc/zL4QR75YfenR4dhU
         IAVMiWmB1joUTVsxifhQM770NXkeLpa5i13mph69OV0OTvZOJwd2ORz6KoK97zgvwZ83
         7oZqxRG58evAFIJRsiDv3eGLD5Alp24DJLbtDxShA0ESyxRoMIdPUheWgcBSwddyZZpB
         8ngVZpjhd0WOeivAkryYC9IzwLqCS8Mhy2ud4/M0rkpt/rbE8JkfDlbE9htw5KWuMmXx
         7jGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkpS5PVU4/CLnGrULNFZr9zFyXmF2zFzV49AShDy4+Up7mAEC2LQ7bNhKK82Uzu9Bl2gApRRkxhqNUpuylBc5UHgI8UuUaPdQeRogqNd+p5Tuy9UQtkLTPEA+W0vLRfFzKmCslJglKiei+YFySgqF+Cbk74EaqQbCEoyI0QJmEPTNm/svv
X-Gm-Message-State: AOJu0Yy8tAvOgemMxJZ2K0hne73HyIZoyOG1chGlj/4O90p3gI6WofD+
	lubVFALVzlOqncvZhxNT0QbO3xH+TLH9Cc6vvkx2V50CJzjG7Y95
X-Google-Smtp-Source: AGHT+IF/mVYs7RwzHMtzyKiKUdkLdENmM9Gi8g1QgX4e0dUeruZb1iGkzoY4fimwsOQtYWyz2/aKfg==
X-Received: by 2002:a2e:9487:0:b0:2d2:ad40:a7de with SMTP id c7-20020a2e9487000000b002d2ad40a7demr3875262ljh.20.1710148894406;
        Mon, 11 Mar 2024 02:21:34 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00413128042d0sm13672681wmo.48.2024.03.11.02.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:21:34 -0700 (PDT)
Message-ID: <f79a26d8-c6d1-43b1-b872-6705417b4101@gmail.com>
Date: Mon, 11 Mar 2024 10:21:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
 <65ed8c9d8dc5a_193375294e6@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <65ed8c9d8dc5a_193375294e6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are
>> relevant only to tcp flows, and as such they're used to determine whether
>> the packets can be merged later in tcp_gro_receive.
>>
>> These checks are not relevant to UDP packets.
> 
> These are network protocol coalescing invariants. Why would they be
> limited to certain transport protocols only?

Thanks for the review, I'll fix the typos.
I replied to Eric's comment about the relevancy of these checks for UDP.

