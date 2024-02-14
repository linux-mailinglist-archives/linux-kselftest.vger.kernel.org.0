Return-Path: <linux-kselftest+bounces-4673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685485530C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 20:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9CF9B2C75B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FE13B7B8;
	Wed, 14 Feb 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ur3hbKrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1D13B7A9;
	Wed, 14 Feb 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938064; cv=none; b=G6VIL4UZwYz5f8jEPPBV7lXmDZ+N14s03Jra2raJ4942YXZd/YOJRgobfmPTA3EevkhZGUPt9iW9PtTNYA4dfmUNK7KOuid+SVsI9X2W+SIz88nbtSlICVbpQfeaScTtYuzRNN6z1Q2ubyHR2EnexG/qlu27N+3emJiQfL/fXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938064; c=relaxed/simple;
	bh=14BaVx8cuHZCZSoRpr+rbi+jknLxUXS3sryXnLK+89s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ozlfDEHeDrY/QXA1sijOIP4r89xWtLkkHfljfK02VeXTk64GF82v603osT4GjC9pt/A0YNucvjb8m82b8RlktJE61hNJ0PHQV5m2nQh5urZWfmFvark+AF73jPf1Et5mdW+lMbhxDj0z/Yul5vW0ZtT2gB0Wrgr2IBimLLlAu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ur3hbKrq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0a479a6cbso111044b3a.0;
        Wed, 14 Feb 2024 11:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938062; x=1708542862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS+0qaKLpt8lT9N1wmj76XGmLNXI3ICb4bQ8lj6EZNY=;
        b=RY5iI7JKTJ8V8hFSymHXhC6XxG+xiNyonSf6maY1yna7t3aESISvpLa/A+5PIF//K5
         lCiPc7HYvWaQd9jwYFRW/XFhNbBTCrUZW8eSNqxb9ZnWlskAQroh+JBEcMrsEE4NcRyJ
         jUfUzc2j8C40CdUpLb0fU9eBL9cFBNsbqXqmO5QdstjyZPHss7IX3mseFxWnakrhuOVq
         iAKlkkWtJwg/rSktwZEDCibagp4DwSVvYR2g2aL+4+dAqRBuOpybg3Or9bhGpAb6+Rws
         AG47VPsIjYWIG5LH0xu03XOvuYHbw8uriuWum/35dkJvAlnodF47QbEQt8iSJgwbzfzU
         XBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUdzYMGNmMZ521f5fFpqSZYPI31uYXMlCNuEujo4sDnkJKucWf6JdKep+vURsthJVbnBesrodPWmfkPb+QnNsGTXAYPoJuFSXtDWmv
X-Gm-Message-State: AOJu0YwtqXOBekxEI8uPa+vUGM+3Qz9GfgFNLgfRXTeHwBiv/7Yq50Nd
	N7CRYq9wmseFUDZaCj60hOAixf+giFz4CaV0l274ay5wmhkek4BN
X-Google-Smtp-Source: AGHT+IH7ooCb5KSY4SSuPAdacKRPF6aKGNWqgf5qrXG4aBKfAXSy0m6/IfY2awqb2YdOW3oGTwlFbg==
X-Received: by 2002:a05:6a21:3944:b0:1a0:6f99:7287 with SMTP id ac4-20020a056a21394400b001a06f997287mr2361233pzc.61.1707938061788;
        Wed, 14 Feb 2024 11:14:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUYfyxipVjWSQOmW5NfLXJ5bSfqPo6q2e45scyrFzYp6KrCYccWgFGyIpz0U6J1dG4j/VqRNBk4tuL+IrTzUckOl70CneeZPLF4OkQI9JwRkrLdMfK9ukX9Cv6LrigRaEpr1PEibU5W5uFlrIFb43qDWEyPFplLer7KN04Y3q2hdujKmRaQaH+dLxUHYz6fEkmQGqE9PYbrgs=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t187-20020a6281c4000000b006d99f930607sm10420142pfd.140.2024.02.14.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:14:21 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707938060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FS+0qaKLpt8lT9N1wmj76XGmLNXI3ICb4bQ8lj6EZNY=;
	b=Ur3hbKrqW2rAbRCU2dKCACKHEY+DDvzxvdD23iuGSEY5eppKJo/ZcLYDJlzLe5yxWzCnSV
	qbjUkGSJbGdFur338koYI/e7L9FDKGjsBjiAUlniCDCgUtTHQ/d59cl5PE1DWqiQAG0MxY
	rYEgoJDgyfSwDYBvzT+j8fLu79nU34x9HN1uEC8r05801gxmemCLftUEYFOngWG8jZjz/N
	FSrSkefbp5Pxr3iGjPXD4rBD99RX4y84msaoZuTeRMLNELg2oJCO/zEHwVRDv1jFUjxAlL
	vpoOr87hd+LPPMP99HXYBIzEn0Mh0xGQGRouhV2TDq78fQW74BS1R4OEzqAZhQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Wed, 14 Feb 2024 16:15:00 -0300
Subject: [PATCH] kunit: make kunit_bus_type const
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-bus_cleanup-kunit-v1-1-1a38323eed73@marliere.net>
X-B4-Tracking: v=1; b=H4sIADQRzWUC/x3MQQqAIBBA0avErBNGE4quEhGlUw2FhWYE0t2Tl
 m/xf4JAnilAWyTwdHPgw2XIsgCzjm4hwTYbFCqNSmoxxTCYnUYXT7FFx5doNBpb1ROSRMjd6Wn
 m5392/ft++PjoXGMAAAA=
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=14BaVx8cuHZCZSoRpr+rbi+jknLxUXS3sryXnLK+89s=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlzRE1VNxJ8zR76D76j3o1iSdYcKAZFek0I1i9g
 kBNS2hyioWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZc0RNQAKCRDJC4p8Y4ZY
 phfeD/9Akfm8qZNJqn7s6OryAmRmpgQ+u0OjFB074u/3vxiwy8kZ6mJ7bXt8H6ntI7aWc5BOWMZ
 ZG5iyJLHSCbk54saLS1+z24lajvslmUhewBBj1B3hYTeCN0WLv/zj9jbbu7papZbrFIv2ihyvIR
 4M9sS/tuY5WyDfhN6REEG2DekiVcy+LQfIlPil3xtEiJTQRGrt7W5Ulyyc2FKjKQpacytKCiC3i
 nkd/UImp7YvF8nHwWbinXJB5EPz3MlPbSeq7j3e/6u9mU3Gty9p+UntvLN7X0QRmU+/DzJ6MqKV
 ClnO16bswJ9HgFwrdxXZe+MEhpK1To0gYBmien06D8qYkQMwM9K8k/I7iSHQHl0EN5zVJDkCZ+Q
 iasMt7BmyVIHFUaMi0212cBANa7WAV7PajaETLjhkeGF2jPWI1qTRwG0Z1AGNnT/YWDfVZT1PzO
 fUwPRP9X1Za0Svt6qNv1Dqc8amsF6hkon7WbE7PZgEKIEqAvhJNB3TljrPXxwzEp3bQxg5G+RUw
 iX0E7j1ghzZvKg8IAn+F2XrMuD4LHso1VC7hM39lhiC7E+8J9bOivZ3JTTRWWrWrEy2C4eTMioh
 DQKXtyZu8MmCpLpn0yJVeR/MEyD6OcVUvOXLQ9GNUT8kasLi9r96aH2fiYb+j3DG2mnGQC5mhEZ
 xBqxZSKPbRSdIfw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the kunit_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 lib/kunit/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index f5371287b375..d23b8fb166d8 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -35,7 +35,7 @@ struct kunit_device {
 
 #define to_kunit_device(d) container_of_const(d, struct kunit_device, dev)
 
-static struct bus_type kunit_bus_type = {
+static const struct bus_type kunit_bus_type = {
 	.name		= "kunit",
 };
 

---
base-commit: 76021a887a50892fd969cd42a5f3467f5696e50e
change-id: 20240214-bus_cleanup-kunit-840cd37b0e10

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


