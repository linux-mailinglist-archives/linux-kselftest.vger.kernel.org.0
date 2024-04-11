Return-Path: <linux-kselftest+bounces-7713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55F8A1B52
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E421F21107
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC198060E;
	Thu, 11 Apr 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdR4V1l8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AF7FBA1;
	Thu, 11 Apr 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851285; cv=none; b=XseI6KVG0fnFghnqv9sYxlERMCO5+FbP/bH8kcZAzCkdh+pJaff76ju4zD3RIl37lrXLxUCbc1d02sxDB1S3amHxI8ngwe2ZvXUjl7U5mhabMU00YQLYtyBbKCyrrBz92pmCSlTLEunoibWRYa/WVJ5pzG/6hjs3XEn2MmJacsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851285; c=relaxed/simple;
	bh=Cw0zvuIdVmuYUkx4Hke8FVPCC3oOeCxhuN1POiGgFgM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BXNvwGGfrr4C/cb5M9BR6lS2qbU8N0e8JhGYBBy2gyNXbiqeGynTOcc9iXmlQFQZO9R+sfdm3ukcDMpyBiJrJKOFfG5GlOjOmb4aTCTUj8+SDpsr8ZLgR7b+Snh6HJEoePIbL2huFdI8hOihC4J2l7sVjwfjQdwNDItdRFdahns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdR4V1l8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b3d05e945so112456d6.2;
        Thu, 11 Apr 2024 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851282; x=1713456082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt2QHmzA0e84Wi+PAyMqEYd5/+zB31AprzqaRqpvLq0=;
        b=HdR4V1l8eOwrqpigSxb4zI/SzMYi5ShhKyiYlQdP7rwKIjEHb2jzQGOiY8driX4GXS
         8oVlvotdGWBOADU1Megy5gLZVqOPAaPfkcR2O/usHHitVMXPtuXkg+dLyhvzcXtNjHOK
         AUVSAXWK61B6tOc0jK/5L0eXXl/kVOHLbwJbskTq7ruRoDeXqVKv3KDiNl8CPP/vbzJc
         u00ENUh8HvkYQXvGgu7jKDPTv3+d/HYLNc2xGz0RfyvRmHINJrUGVpw74z/wPp4Unrsh
         QCjSsS2xoznI6zDmfQtxN5HeZRItIEIS3faV/kjYGLwCX1WsUs5r2nNTd7TXQAv5MXCN
         /r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851282; x=1713456082;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vt2QHmzA0e84Wi+PAyMqEYd5/+zB31AprzqaRqpvLq0=;
        b=fiq8W0E25S93XZSuJcBh7Lkh6DgfaSi6Ts3XhkTNybO/nKBCa/KoCZ2m9oLmsx35Yf
         JQuPOzL6FVxtQ6QJNQnEr58YjZIXKi1FzYlQC98SXj+82MW+tErOEzpYwxLJ90tTZ19/
         47o70W7TuhiRED866cemSR89ZigcCKHWx40sLc+yT/dg9ToPn5j7su9kw/scY14KlPQy
         L13K/e1lkiOR/pZDoVq82cZMs6rrfNThpEKIi5NmeCB6OEiZHks82G91uDqxT561QkiD
         HhTmQbcMfyqqlDC+QamwF0JAa4grnyZtniygkDhZah0Yy/3mS/3ROf/wFFKmP84ucuRV
         c38A==
X-Forwarded-Encrypted: i=1; AJvYcCVEsbJEPkzKzQRcv6s68KQWRbZeyE9clNAO66W+vI5n5u1KVCc34pGVZNfASL0tM5CRalrVOunhDUlq24mIIPPuOv1xJHKmBivE6EFls9AzCOzUIWPq3GmJksLYyKO+5DpErwY/MX87
X-Gm-Message-State: AOJu0YzA62Cf6XIRXCoEYE8RCO1+XfZAnYzDs1YnuOHixonFpswClm8n
	MDWYxx4zWBLxpdpKofRsgnzjtysnJXCUur032za7/AiwXgVb1y3tYfZ25g==
X-Google-Smtp-Source: AGHT+IHfoF2JHXq1BzcvGnY7Z+cREWLeIa9wG442gmI6NJ8oAmwULfikx1Zzu4Oeto42bwee6+wqHQ==
X-Received: by 2002:a05:6214:5983:b0:69b:5475:8a06 with SMTP id qp3-20020a056214598300b0069b54758a06mr1395qvb.21.1712851282552;
        Thu, 11 Apr 2024 09:01:22 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id jy20-20020a0562142b5400b006986d9c6b6asm1100305qvb.112.2024.04.11.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:01:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:01:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 yan@daynix.com, 
 andrew@daynix.com
Message-ID: <66180950c2888_2f1f4c2944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240411051124.386817-2-yuri.benditovich@daynix.com>
References: <20240411051124.386817-1-yuri.benditovich@daynix.com>
 <20240411051124.386817-2-yuri.benditovich@daynix.com>
Subject: Re: [PATCH net v2 1/1] net: change maximum number of UDP segments to
 128
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yuri Benditovich wrote:
> The commit fc8b2a619469
> ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> adds check of potential number of UDP segments vs
> UDP_MAX_SEGMENTS in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> The number of segments for UDP packets is validated vs
> UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
> quest-to-guest path but does affect packets sent to host, for
> example.
> It is important to mention that UDP_MAX_SEGMENTS is kernel-only
> define and not available to user mode socket applications.
> In order to request MSS smaller than MTU the applications
> just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
> no limitations on socket API level.
> 
> Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

No need for a cover letter for a single patch btw.

