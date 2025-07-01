Return-Path: <linux-kselftest+bounces-36185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D992CAEF9A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAE1C050A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1423506D;
	Tue,  1 Jul 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH/OonXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977614A60C;
	Tue,  1 Jul 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375004; cv=none; b=uEm+uYhgPWOhnswjsUYUtWzQlReIeM5KpZPoiOZXWtL+s5ZqBesloZ/Cm9poNh+llTq33GNnUQqHswtn0iYIGzwSFkdtHO6sU02+ZI7XSQAIxZga8EQyILv76rlzpbCw24+R1nE6zfXeIum5/IOiqHpoOlyMYmfVN9ecm5ix6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375004; c=relaxed/simple;
	bh=6X6qPun53xDchjpSRE9dYfr31uAuoiS5oedrX2u7uZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epkEIi78ktLIBbbuglP8GCXndHUCROogCGk2aP6MLnZ0egE41E3SfCs146Sj/kKgMLcyntORS+kLSaPUNcX7EUd92/9o7wzfe+ljKTF4kzVPMVYE62wYeGpn303Qe9ihLyb+24fMNV72MePsiOh1PGHuWik9GaAX5fHRXyL7gSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH/OonXS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4757425a12.2;
        Tue, 01 Jul 2025 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751375003; x=1751979803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVcI3obUDlDvlugturYa2IMjNszU4+SQTl5pW6Uiz2o=;
        b=NH/OonXSkIORC4dKX+4DQ5lHzu2d37Y7M9aKaFLWSzdjLAnL52yrywes1sZ3xULexs
         w+u0iX1YkBaf75DdDPp+ruPa5ePfxMBVUN97AQYQ+zwrhyKju7AR8w80zOsE/2qjifPU
         TkJKPGctGNmB77584yC2+heOuRk+BJ+WhGfU2VvrGI/037omkrUzIHT8Q00Nw0Rfnu/X
         URpOyQek1bowZZ3GgS1WcZbtUGDJkRSa08Ah9QAFx9UdV5nYBK9JF/Jah4SQJbiy9rfz
         PtHzhtECeIPjLhwqctNpUY2rleBAnWBuXYRUFPZYjSexQocHM+BCEnuE0Oe2v6UZowUg
         hgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375003; x=1751979803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVcI3obUDlDvlugturYa2IMjNszU4+SQTl5pW6Uiz2o=;
        b=kL/O4V/XN0VMtizAC/avdOmNEhZ0wb+GY0WtmCcvAIyZMD/S1TFWBOraGtPXKlH+ni
         Gfpq7tgksYcDVLBa7YckWKXIW3S6/Gfdtd5ojCOp6vJCC5Ipzrp50nKwavrVxZZaYIFK
         J8aLpmMqJBjyzMjlckzCi11h+/FYHq1ZzJ/rAH2vXKm7vFrgVS/qApIal5/zxiGeVrN2
         jC0KXycP/75UX2HowNI1wouTtmp77BcByUDRqpmH3b28c51T74k2q5DSycZVOD4wUPSR
         pwJ+8yudNXRuThkgrIgvahUEtGZxOWPKMcoENWGkll0PdBqyVPpY0JyGzf1/iuRrsxdr
         hDxg==
X-Forwarded-Encrypted: i=1; AJvYcCVcL298f/ZsakDB8vwGUOqzK48UhZIb8sKucILcgEUpX+x36ul/iPVMEemYuqBcByP9JYtVqX/VkS7rJnwJ4hrM@vger.kernel.org, AJvYcCVuietod7mWi1CJf6iCozoJs3YpFZBiYWVv9SR072eP2G/JlRS9AOIDVUjJQyR9DMHPWBUryVcV1KGh5lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+CaILGZEOv4VRbymv2dPOXc6z7haQ3esruEDESkD1+9P3ZEI
	kV+rkqIwec6huJoobpHCn27kC7cxi0m8MKGg2PwwJx1/SBRCTO42qcnO
X-Gm-Gg: ASbGnctNe8Va6r43Y8hfyIOZAOAUL8uL03h/TvSI20IuDKmaffNvEifgeXXrrbVqTSV
	NrlYRgA/VqLzCs6We5y9kTbGJAEn5p0hN5BMpPZSQa4FW8LSN6dppbw1SH1rPTy5eM1OkGZqUr9
	GNl+nuusOPgvXFEJefAIdIXN5HvkrfJBuQU3zMocvSPl3b7K97we1kA9ueurnWmK9fYyks8Lurb
	VoJozzG8F9L2ogWL5nU1fEmy0njxFy+ojjFco0VJZUPLoaCjFsql8YzWWdYVwHK2Tm5hw7ANMb1
	z+rIKIzSuJ7ICQOwtSk1PeBg6R3tC5un9gL3Z5Fazc17U4/zmiXi6YtBr+ag2+2+L27DsSkMlge
	7I4u7WT2X
X-Google-Smtp-Source: AGHT+IE+/HLkERC531DcUcGWUU8RN4AfiK2M9TcfBl036ejse4qyXmt/cJy2Sc4qf7ES0RShO+2zKw==
X-Received: by 2002:a17:90a:da8f:b0:313:176b:7384 with SMTP id 98e67ed59e1d1-318c8ed841fmr27266065a91.11.1751375002666;
        Tue, 01 Jul 2025 06:03:22 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1b49sm107917975ad.22.2025.07.01.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 06:03:22 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v2] selftests/mm: Add process_madvise() tests
Date: Tue,  1 Jul 2025 21:03:20 +0800
Message-ID: <20250701130320.3790-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701030614.68902-1-sj@kernel.org>
References: <20250701030614.68902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae Park,

Thank you very much for your thorough review and encouraging feedback!

I will address all of these in the next version.

Thanks again for your time and valuable input!

Best regards,  
Wang Lian

