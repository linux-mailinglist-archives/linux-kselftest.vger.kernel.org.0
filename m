Return-Path: <linux-kselftest+bounces-14030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D7939753
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C311F22726
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DA634;
	Tue, 23 Jul 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLRm3oz+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350C18D;
	Tue, 23 Jul 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693651; cv=none; b=O9LAlp4yFWdCn42fQ40vU0uywYroz48hIANECabymDf00ChL4JER46GGNkC3+Tlw1j4XMOj1qhAvONs9yKlrqbWD7sqcOLyQzySiJ0ZxYl1xe4dmNR0W35kNFBJWlZvj66vhwfhUQLZodPXxmvAJr0aj9LBmClCiH3udSEqATHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693651; c=relaxed/simple;
	bh=7pqJ3J20waZnXX8P018M/Gzx0aSlsmuQoWJWr6wcj4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPJSE06ZLcx19wAe9i9hCg5fjtI6vHJ0QggV6tr3/+GKm0jpFZlwzCwU9YiTLBSw0WIXx3VKMyIMhjmH3wBTbSIw9Ge131TwKS+B2XosuhBoQ7hleElTPfv4F6o/560d6CQ5UYWsNR3vPscIEcXDIDlZgMQURL12pnj1iPyYpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLRm3oz+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc566ac769so1383505ad.1;
        Mon, 22 Jul 2024 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693649; x=1722298449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbxVyQbDQlMb/OjU+04+gpn/ZuusWjk+eEOd0jqrQbo=;
        b=lLRm3oz+UamlVEnPAuAljCTAAMFgqZtvWgfTpTnP2flB6PVYOnDzDy89IWow7NQlS0
         QkgM2RKDe1nFFk9eDibFAqZEDNSwxuZ8v7OZVa7nUxJLsMEn85RTLZuDpe8TOzQyxIhM
         4UwpbnVsNYygPCHuQCdbsHcfvRVsMW0utRCV8k73B8JRe7ub6lN+hFGdmWzKehOE5jP9
         mz2AqEykWItQoVivsU6dRoBNoEqkJJ2uKeeiiekkHA+Vw50EHW3+zMlP394JIogywexW
         hx+X0+zcNikXkZq7R5GK9dBObhdvxt+wucKyA6BWDkgSW8v/Uxb6mqNDrN+3SIP55fR8
         cuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693649; x=1722298449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbxVyQbDQlMb/OjU+04+gpn/ZuusWjk+eEOd0jqrQbo=;
        b=kZHkofXOIYB2La+55rr2P+u69ElA/0JXz/gv6S6qaLbk9lchzuc5fsJ7D3x/E1Vx14
         LA9VX0VNTr8zYpZcSwbakF7OmiKQszBV0gn1yYGX2ZWK1APg7hSpDaDQzWS2Fxuu4hQA
         IuvIVJG28yB96FbCxfYHgxy8hs1xrRG+5ARMnFz71YX0MRXw3cvVpq9nI/xQMzTN7Xs9
         Hfpl52X7tyVO1urb4ep0AVaXapdEitOZcZ4lNIYKNfWvELkhdSg/uZpZZnDqC//6w84Q
         fnmAzSLn/Pwr13rMPRwzuTtQzcPgZ8LJvupgdkBwDKy62JPJf+kCpCL1c+ak83x3TvTO
         OeNg==
X-Forwarded-Encrypted: i=1; AJvYcCU/v4w0a6TRtdwS7KEpTSjONQwMo3zVPDrjF0FhU0Q4gFhxAuvyYOpJidaB5WEu/TrCuPSGLCoVcy0/KRrfQrphIthYrHNloEz4AvVCjTvd
X-Gm-Message-State: AOJu0YzRMmbiJaqFeYU4tcTtYstYQaueMxQY+ZKZnM2z5M7O0cnRYMGB
	Gvy/rOWeOBp/AfGZR2cZKotzCwDczb0jDaKUJAWaX/8G/4JwJ1IMqoghcX6H
X-Google-Smtp-Source: AGHT+IE4m2Or6gT784/wBXHvxM+Q0dqpDY4maWyYTuYDa463SAie3HdkblQkQ92KTnXgAJEToxGMlA==
X-Received: by 2002:a17:903:22cb:b0:1fb:9627:b353 with SMTP id d9443c01a7336-1fd7451fce1mr70806745ad.12.1721693648065;
        Mon, 22 Jul 2024 17:14:08 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48e7c4sm61395485ad.307.2024.07.22.17.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:14:07 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Add support for MIPS systems
Date: Mon, 22 Jul 2024 17:13:27 -0700
Message-Id: <cover.1721692479.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721541467.git.tony.ambardar@gmail.com>
References: <cover.1721541467.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Hello,

This series includes two fixes to support builds targeting MIPS systems.
The patches have been tested both with the kernel-patches/bpf CI and
locally using mips64el-gcc/musl-libc and QEMU with an OpenWrt rootfs.

Patch 1 adds support for MIPS system includes when compiling BPF.
Patch 2 fixes a MIPS GOT issue when linking uprobe_multi.

Feedback and suggestions for improvement are welcome!

Thanks,
Tony

v1->v2:
 - improve CFLAGS handling per Andrii's suggestion

Tony Ambardar (2):
  selftests/bpf: Add missing system defines for mips
  selftests/bpf: Fix error linking uprobe_multi on mips

 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


