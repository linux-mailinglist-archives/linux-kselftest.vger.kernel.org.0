Return-Path: <linux-kselftest+bounces-6632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2388C633
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 16:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF65F3067DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641813C67A;
	Tue, 26 Mar 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8NWE2NM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778631E484;
	Tue, 26 Mar 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465351; cv=none; b=S9kRVjBM4ESdE3/b4H/wL2KrIbUALhZImhdqJlRPcIva+OVwALAQRRbPmIfAfvb+KWU6pS9z9iZ7vZJOVtg5Ph9nGwYycIIY2Gfv00KDKgoATl8x+TqARjIzg2QNokjKiD87AffD/B2k8Z7iuFXSK35LaGdaV66I9hGNyAxV+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465351; c=relaxed/simple;
	bh=iQrxAiOyf3CwR5nnrMUtNDY+/b8r72mv1Ifri/TfCVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjaSvSo366RffYK2GZpHiDYJWBj9mdt1pxCSEntLTBLeZiaSitsKXiRv3vyBobs9LZ7qJlDWMuMCbWok+aYyDJ7nzP6LyYg/8+EXLna37SeStsiaqAdNLxnfsEpmd5nUqErnUTQeADJ3IskaYDe+ZpbG9W0G9822iJWgA4NBBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8NWE2NM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so92984941fa.1;
        Tue, 26 Mar 2024 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465348; x=1712070148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hsnt5/Fl7rxcLS3/8zPxOL+vJi5J39AzCAfQSaLLx8=;
        b=g8NWE2NMbBzlep619EsMHdfdkZXguCMBhWxgodN/NLCRXsPzV4/aNc0Wpfl30SjBrb
         hu6bj2qc0brRCNXL+DVBFRQsxq/dWYDXVdYKXAg5TgFTA3EmXPCtnFvKrdJkxKiGSBtw
         i+/3OT80q60SVANLg6N28nMHOshpnXYjB/cBrePzhHdGnjvdR6kZq9cKS9flTmgs6CeG
         hNlVESNKAbm8lJpJZgMPR+TBvo/x6ZMk983FzNLkInsKeBDfI3u+9iAl6tF97L/x9ihb
         YCoGzW8ZVr/gPEPz4NwSjn9qXpN/6kVsl8enbTYYV424usVLX+2zD1Yk/QFNnhIg7q60
         vaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465348; x=1712070148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Hsnt5/Fl7rxcLS3/8zPxOL+vJi5J39AzCAfQSaLLx8=;
        b=mO+A42SVaCwN0vdVD6DpowHTr5fOaAa5W0LsU03mYqvR1er4VObjlAaWhAsJkaan8a
         xDsz2eV0jFoUV3LdcOhLX1XojpgdLmWppOLV8IAeZumTAa4wKmzFjEnyJl/K7c7tcZ6k
         QJmbgnVCJzHmlhN1B6/wmBhGG+cGAGEpYpryLxN4+GvvhgJS8C0ROBIGdywzcbJwvPCZ
         dSW1Hvg+izmMNm1xHV7RfAImYkUIv0FMv0tGstkyrMoIC965LsI5BPqyLGG4vC3UgXrG
         4uz0jQeNNih3Ck5uuav1o/1mdD1uk2RZM1i4cONTNuLfIDJy4k8X2fSI5zgrdXIlU60A
         680Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlm/HdPmq79mSfsLxbeAZHSZALmEAip4ERqFEuRrBNvMET/qvoVmSZQI4hazvC9or+ZIx2GG3tgbtCB5G9U/hnCVVXe1bhIaDAnbmuC/rmW6JyjvoD/arKcYzA+O8HE4HfAkpHKWQ3U/ysCUXtlidwjSc9Ohc0zzYbBLI8r2MmVFCtewyq
X-Gm-Message-State: AOJu0YxkR7V0Cqg41viWv+6t8FVgCmuNbDbisKg3yjE8SDs3zG82FUXK
	t6NrclXwUndML2Mj2QU2wOS+Y4oBPEXQU9PzlEnuZ3hdhOZSX9JkqOiHzZyi
X-Google-Smtp-Source: AGHT+IHpexITbWll6oy2e6Yq4d/eN+YCh9NgpVg6Ox7pCdRLuCYg8fqZasutwDfMYb9k6ShkQFhh3Q==
X-Received: by 2002:a05:651c:547:b0:2d6:c5d7:8477 with SMTP id q7-20020a05651c054700b002d6c5d78477mr1085122ljp.36.1711465346996;
        Tue, 26 Mar 2024 08:02:26 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00341c6b53358sm7902295wrb.66.2024.03.26.08.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:02:26 -0700 (PDT)
Message-ID: <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
Date: Tue, 26 Mar 2024 16:02:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> 
> I do not understand this patch 4/4 then.
> 
> Why bother moving stuff in net/ipv4/tcp_offload.c if we plan to move
> it back to where it belongs ?

Willem also pointed that out, and I agree. I'll post a v5 and move this
functionality to gro.c. Currently, gro_network_flush will be called from
tcp_gro_receive and in a separate series I'll fix the bug by calling
gro_network_flush in skb_gro_receive or adding it to
udp_gro_receive_segment - whichever is better.

This patch is meaningful by itself - removing checks against non-relevant
packets and making the flush/flush_id checks in a single place.

