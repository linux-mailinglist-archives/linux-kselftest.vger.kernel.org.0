Return-Path: <linux-kselftest+bounces-35640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E745CAE4CE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C53AA06C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A0278767;
	Mon, 23 Jun 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz99Rg04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E19242D68;
	Mon, 23 Jun 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703685; cv=none; b=YIltx0wqIwbnMDaPkpOVeavR2+ZGprvH8ljCA+6xqe68BpklJzE8f55OjdgfIKRe/9G8dqdi8ufIUVtN2tjDUBtZ2WJlKZF9XjDpyb5jGr1Z8LBaiOlmG69/ifzQLt/frK/YiJQ6166uhJ6CaL99mC5p9ptbWsoxSvhxBQhgSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703685; c=relaxed/simple;
	bh=xjO1fMe22Jaq4EfwiQGsg+pOSrk3eS2XnMdZUXlcSYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7UN12/xCkeVjwL/lB+/d3a9Q5AuQ4j+v2Xjwtjh31atvMhfpVFmP5+TlhOBt/fJo69ty4fOtKyoRyeiPzdwSIktiQ/025pKCOrj5s406wlKGIOlpF6+msUyw5EAeVtKZTB5xcohx3aobBY10DWi32ZxNee2uRJ5kqS6a77eWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz99Rg04; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74264d1832eso5756267b3a.0;
        Mon, 23 Jun 2025 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750703683; x=1751308483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zV1oDEAS/vgPXZB0E98XPXxtO6/7/BkH9zWvruYfUv0=;
        b=jz99Rg04kq+5Lyxtyt3lSPAl4ia6hWC+RVXtBkEIkOAzyEpDK11mAhY8QxP94Ikwqx
         L3Sfo93aNoTjA+ncjyAFBMKVfbgI4w19Ukc6EpWGvDORXuLaKwd/miyR9H4fujzJOn1W
         cFjCQG/KK/AfAk5sFI1vnKLzTRhksa/qpmGBeBD5E0y2nN2GXCPRqwE2w+ld2AMzYsGk
         cwDzsCVLoYJPs0c69HGMYKtEtznxAEibYR1XrR9sl9zT8aM2zN8sFuhxW398JJ3jq5Q9
         +2hewrtqI6DH/abO797baz8IkpjbbMZLOdh4Kiycc+WhBxoJtuID7A6kS8WYQ6h4m5Js
         oYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750703683; x=1751308483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zV1oDEAS/vgPXZB0E98XPXxtO6/7/BkH9zWvruYfUv0=;
        b=C2cfmPvd2wLECeCgJG9pb61JnE5KuZGw+VCLiD6BlWGpQKROZuQAmgILHRAccHYYv2
         JX7fVFTa3I9IBGaB3MNpe3Ok/KQ7TR7hGnh91GNKxTyZdrhhvSDwXbSuz4m36gFyJNiK
         eoAMlCKSxT/6Zz9KrGlWJ7xMNjSANsPwCnTg+l4GINBF7kdi8BBpGN12c7u0BqQxXLBY
         iBUHBgQ4FPOlT93OanWqcodOhZ1B/iCryRpZb3KO+t2WrabpRR2jAfVqeziPT+/PvvLL
         WG1KiYU0WUNRwCeWK6NqiWMCVn94IhHIDj4hkYbb1GeqLEnvCtRAN0qb645SFRynSYsR
         +VNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKonn8F4q2cNyjA0Dr/4IRLvb+seiKz1jhlvSj9DuwrPqSpHOWXRimljx3Ljn4u/CuZ0YFXGDEWIIA3Sc=@vger.kernel.org, AJvYcCVy7dtiPcVoDZ4WAK3R1biXvexvvt9cOr2cLxvOpoShPfmAMN4LH39n7LEM7ORA/ozb8w8+RkdOmld+tp0HKJs9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GWwxZ58fKDSZtQnUYsKuWwADXJrZTXWjd+t73iVF7nDJwToH
	hVUKaU9UFiz0QrxZv29+WMhcgODX3q28kj1qyg6SIHl1BPoUY4tZHLXUpP60qemA
X-Gm-Gg: ASbGncu2r3dR1JzX4Cq4luHp8ixqkGWZHF6/pfnkx1NJg+SD/bTnDmIwPAFAPm7xW13
	cNHwBfGqKiqvXIIgP5TJq77+kh2BKWVprZWjbI/aEOCJr9mRiHS1NE1eah/MPaexCZsXC/7gV3L
	PDrdxXF+Sd+DIgfD0VGx+JFg8XC9tcgu0VC5lHT5jraHIjLOFmqgsDBQiwkgq8x2xsYXeczXJgH
	qBL/xZ4v+RAlLHize9co5ZeDaKVx8WTcFWwnqFCVYuwL6N/32Exb3zOKtFYYZP1z9iBehuA0Tlu
	w/NoMYzTkc9x3/2Ga5mMVsw72R3xVzlY9ZhhKMYjnIG436a5fn/ruL/F81WNdtX+
X-Google-Smtp-Source: AGHT+IH+8Rz4nyS+SsDsXTf8cDsY/zbLgN/bbs3ip/7BUvQfo0uOZ2R0DjFgXe5hfXV7s+zZSmM7rQ==
X-Received: by 2002:a05:6a00:2e99:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-7490d67f737mr18775964b3a.20.1750703683359;
        Mon, 23 Jun 2025 11:34:43 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:c8bc:68c3:c88e:7a72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a49f3a8sm9119603b3a.62.2025.06.23.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:34:43 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: shuah@kernel.org
Cc: oleg@redhat.com,
	ldv@strace.io,
	akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] selftests: ptrace: add set_syscall_info to .gitignore
Date: Mon, 23 Jun 2025 11:34:06 -0700
Message-ID: <20250623183405.133434-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the set_syscall_info test binary to .gitignore to avoid tracking
build artifacts in the ptrace selftests directory.

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 tools/testing/selftests/ptrace/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index b7dde152e75a..f6be8efd57ea 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -3,3 +3,4 @@ get_syscall_info
 get_set_sud
 peeksiginfo
 vmaccess
+set_syscall_info
-- 
2.43.0


