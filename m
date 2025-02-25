Return-Path: <linux-kselftest+bounces-27401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690FA432FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C92172E01
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19541136352;
	Tue, 25 Feb 2025 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGKXgsRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529E38DD1;
	Tue, 25 Feb 2025 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450278; cv=none; b=G1fLICuKYoOiRsowWLlwlQcCeyH9y9e0LCX8y0pyrfnZTaxfYxtNaOTNnwgTptUxgjUahTBEuF+ZIHvTs9Lh8QKyk4lDPIDWG/Yiu1xKFN4F1+71JyQYs22wWqLDRzc6p63/mpZD7BojA7Rw5MJzB685WJfwJ+PJBks/2dReiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450278; c=relaxed/simple;
	bh=DpksTJSb4j/ATW59F2HwSfc/OSb7paCv2PAf/vMZoF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qt6j4pBRCG4VbnjbjHIqAGRw5g0C/dL7Foi9tHEwY38iAXS3D5ckb+du0Se/FIYICx1MuyTol4hgtwuA39FnEZDeC6gdcI7OgWY83ZoRZdnocx1nAERD6pxnvZBM+xCmYyWkf7OvO4dfCWHuZJg973sePb2tTcEiqda052yJRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGKXgsRE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e66a7e2754so40526916d6.3;
        Mon, 24 Feb 2025 18:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740450275; x=1741055075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEfyPPBTeKStGDGpfSNDF3cOWQtH3sIOWk57hC8LSc4=;
        b=SGKXgsRE50Ocq65s+4CqGY4Dd7CHIM1krcj6ogDduO20s+a5SRl+9s/+Dwh7x75HzP
         JHQYlSYaP0wAcQGnOhB7ufIFcybSSKLFb+6xXNfyGR+WkAm05Pd7El7oNRIV1i+X3+Ma
         /PqzwFsoDh13bBXWffKSzWArIBjMTIEzkk7fQsDpuSmzk/pd6a30J56//J7pvpPUQt0V
         YB1lj8dyjxR01CdMISfUAdszkRAV7t3NjxfmmCcch+V+YuoMZ/dd50Wt/tpaE1oYEfc7
         dzNNc+mQ0JAbtVj6C+TMaz91sm9/nrw6E8EMgtzqpPJdbcVFWrPtCvJxdSYf8hqcdsR7
         0FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740450275; x=1741055075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEfyPPBTeKStGDGpfSNDF3cOWQtH3sIOWk57hC8LSc4=;
        b=B4sr/2sBrXBn/h+eTEhrgISd/FFO7AuPTbydblEkP1/gcC3ib1XsxHAdz8LW+GP99V
         GwyKQDdsqI74ztiMSZnEP1Atwd8lLEZGUnFJr7NG6DmFmqKcSzfiQX/lUEVFO+kytZ1h
         G+odch3Kgx+oBRnn6unnE+krWalEby05tzg6oI8/oHu6/mSJzp86I1DQlrRTUypMeynx
         T3nE2NGXojD8vODR8FPlCCBCTnQfxnuC0wnboLY7BbI2FCzWVnmdh6NyUvISDZGCZbCu
         1/RP4v6MhA156O2wXBVRiMhyCLd3mOcpSeXOmfw3+63p5QJsfu2i7VZ8HCvi8tt+10SX
         xMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1SrRqzFgPtgIq16qzAqujP7/JmGqkm/iXmuO8AEWm5D1R9FjbkNFOoWdvgszhQ6yp4AM3payDwhuwwUnwSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzsikVeyDaiUGoyyg0olBkoFkYrC1DR2DPYFuZxUApiungYEC
	CdYlV3duk4tqHm5DtEWdX1KhT9/Kr4JNwIRK6BRRHHE1yFdGFIqx/RV5gA==
X-Gm-Gg: ASbGncswRXj3qMkHFLXXq0dQbRu4EI7aI3x+LHEvlPAA0S05giGATfrlG1UszV1tJCS
	ibVkK9JsOx/vWZrJfmUyGqlo/ABBmWL1iKyeb9o4iNIJi/MFg2LCUx45jFqJtQrHGbgS++u7Uff
	ctwEE3bDs7OZEDxWhRgS9B4h+PsJ3BrMV2zuUesoQ9srLap+ebk1IjckRX44JaegIABtyXPcHip
	uqLPjr9bKaJsjafpfePIKKQG+7AQY89YstS52Xp4h3Mo0LZ8otSYs6DMEkvTfqmLiDj6w9baabz
	FF7trGIGhLtRwb/tkUpzPfid1Twgbk7Y4GbSgEcFzXaXSsd9hdvyia2xzu3q/5NpVbRy88lRsfa
	yEPSJtv/Ty0ZeVP0tPK+/aVlw1A==
X-Google-Smtp-Source: AGHT+IE42oC/4OLqAnv8aB71Y6UNwiOougp0wx4tj3WFwbadgg4/ysQwd043qbniEAWYhob7BqwG1Q==
X-Received: by 2002:a05:6214:1c44:b0:6e4:407c:fcfc with SMTP id 6a1803df08f44-6e6ae7c9a17mr192265476d6.4.1740450275367;
        Mon, 24 Feb 2025 18:24:35 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b09c5b8sm4368996d6.55.2025.02.24.18.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:24:34 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/2] expand cmsg_ipv6.sh with ipv4 support
Date: Mon, 24 Feb 2025 21:23:57 -0500
Message-ID: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Expand IPV6_TCLASS to also cover IP_TOS.
Expand IPV6_HOPLIMIT to also cover IP_TTL.

A series of two patches for basic readability (patch 1 is a noop),
and so that git does not interpret code changes + file rename as
a whole file del + add.

Willem de Bruijn (2):
  selftests/net: prepare cmsg_ipv6.sh for ipv4
  selftests/net: expand cmsg_ipv6.sh with ipv4

 tools/testing/selftests/net/Makefile      |   2 +-
 tools/testing/selftests/net/cmsg_ip.sh    | 184 ++++++++++++++++++++++
 tools/testing/selftests/net/cmsg_ipv6.sh  | 154 ------------------
 tools/testing/selftests/net/cmsg_sender.c |  90 +++++++----
 4 files changed, 240 insertions(+), 190 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_ip.sh
 delete mode 100755 tools/testing/selftests/net/cmsg_ipv6.sh

-- 
2.48.1.658.g4767266eb4-goog


