Return-Path: <linux-kselftest+bounces-38477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD9B1DA7B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14C31AA37FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9625E814;
	Thu,  7 Aug 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V23mZAUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294A25DCE5;
	Thu,  7 Aug 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578785; cv=none; b=d8ueqcdS468pzZtKEL+z4pvT9hmLZm0xEQiZxq+eaAZ//SfEuoEQlx+1T4L5dg46Trgg4Ho0BybW5HAP0JOn5VlR3a/bVm+PAqN7Ep2jJsigeHffjoln29MMsnwAjfgNq9iqCcP4b4LO/v1q7XMoYuxEwUQdgB8XLnVOpmYYkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578785; c=relaxed/simple;
	bh=FaaExgSgYdjOaVJfimhL+ae/usc6C6i9av2RGziIJIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kP2oP3RobAQOCR7Jxyew7p3a9XWfu0xcWjeMB81+wY8N3RPzKX13pIfy9AuUTdo/la0FK/fm2aCfAucg4WUuTDkD7RGL9HQp99wUcY+GeMJm/BVWE/vknuUGEY/LtLlHvtZR+oFMkLyApH5Sg4IW/vzp6wiK+1osCPBRoRPtDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V23mZAUK; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-879d2e419b9so770790a12.2;
        Thu, 07 Aug 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578783; x=1755183583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gfuti96j1DWdp4sE/vCi6HTL8gGK7hRu0UOwmloMQdo=;
        b=V23mZAUKPDeR4ageCzi9YSDAcVqgVCgKfWVbV7UAKbHUNRGNBjzlqxVznO5vrnj8Ey
         s+IRrWomvjGxBkHbDVLOHV8oQ0X9N8RVn7lYWe5TtQTV4cXuMIE5dGN6KaH+Lhyp0liy
         LdeVnvSTXXGvq2MKmxN+Wla8nFrwRwiCwdZNyReq256l9k4lUiyS+X/6E62pjJsycVq7
         Xfv4FMQkpKZCII9SRZfKbsufZ8kul9xB5zGtyXd6gzXIFti4IU9opuUog8TOtseqFQky
         q3ONuaF349ZQKVMlA39os1AliclFXOEQPKIHp5CpYmBh6HpqdMA7giDD6eZByTtxXBII
         MNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578783; x=1755183583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gfuti96j1DWdp4sE/vCi6HTL8gGK7hRu0UOwmloMQdo=;
        b=AE9F+zNQhMW7WacO/O444UEidpfuNpZhe+r/7SCUsEpMuOWGWqbz3X4pvt8TwdDKRC
         B46vby4NVNYp3i8Oz86+3Hzj7tVoR503sjU3/OUP8C9Zl6yvfJd5zi6inF0rB+8c3j/W
         DhsjCo19XDQ0YqHU6EO8feGsVDL4iRwTVGRZ0oEdh0NPzzE1TAzrbvjptNWIp3hkbkn9
         EetFwq7KbIiiR9LudqCh/EjvGiY4zMEz4forShwrbXc4daIzWlVUsSLn068cKivHPwD6
         35NX6NAUPrc9m2FsJKK2ENT/1hjPkkqOAQMz0eQ0lYvZJvUy2a7NR416apPa/jFa0kQz
         y/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUfIQCtXRmBJ1t/NF6Qo+HHg2MpzaU0f4Zr8lUebIYY0XtqFdq/00lfw9BRR64WTBNP/1IAf41dwTR5/czXc3oI@vger.kernel.org, AJvYcCUtMjWvFvhD6btzPjU+dsOrFzsad/e1MDaggXD4/1uBPaV1/OnN8gXA9EgJWsLndjYkqXtC3KXDxM7mIgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltqvJwNY9Z3/yVC1H/iWmCy7EqSo0uYnHoxYgpJjVIc4U+fF1
	qX2/eX3SLRcByVy0CqLLf7Ub0EeSE/zMgzeXvAJLEMxac38f7cpNVSUpCWpUJcG1clIW8obZ
X-Gm-Gg: ASbGncuneCst5dFKi4SkvXmBSLveDhjr33zZM8Qj6m76ZDW8a/YcBD7nJk4dEoz6n1l
	hA5siIRFoK4ILo6BX7T9LZ8q1PoXYH1G+aPCDNSJidBOyLBy7lwhQnpx347bszqy/gHAAziIhQb
	TDtA8CJIkgILIOkeCISTIYkwUNioGePc1FLgSzlF6K4e1B5uEbZ2iF6/EvkycSGr+IWloRdQ4Vi
	i3+BxXMcb1PwPmDOdq0zpOWVtTN3bRCU+3wDOQwIR0UtqpcnUvFLa3lz99YRpPGxkDTwDG200aO
	d1G2ADrFzvgABxfVwxF9HYZ+b2ef3C5xdwK3WdmqY3TUuf1VfHWC2GnjmoqiAhiS9JJ4cZkG1+R
	/58DHT5IBO7k4vJm8X1H/mtLh0SBpeZt6Mg==
X-Google-Smtp-Source: AGHT+IGPxQPuvHlgEiFt5T/XzMzu+ViboT+tVdh2HEe6EhYCrfjWstnNjANJfZY2GjcUT2QPBTC6DQ==
X-Received: by 2002:a17:903:b87:b0:240:3c64:8626 with SMTP id d9443c01a7336-2429ee6e786mr87749225ad.5.1754578783384;
        Thu, 07 Aug 2025 07:59:43 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([213.130.142.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm188254875ad.79.2025.08.07.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:59:42 -0700 (PDT)
From: dayss1224@gmail.com
To: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Dong Yang <dayss1224@gmail.com>
Subject: [PATCH v2 0/3] KVM: riscv: selftests: Enable supported test cases
Date: Thu,  7 Aug 2025 22:59:27 +0800
Message-Id: <cover.1754308799.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

Add supported KVM test cases and fix the compilation dependencies.
---
Changes in v2:
- Delete some repeat KVM test cases on riscv
- Add missing headers to fix the build for new RISC-V KVM selftests

Dong Yang (1):
  KVM: riscv: selftests: Add missing headers for new testcases

Quan Zhou (2):
  KVM: riscv: selftests: Add common supported test cases
  KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
    `rseq-riscv.h`

 tools/testing/selftests/kvm/Makefile.kvm              | 6 ++++++
 tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
 tools/testing/selftests/rseq/rseq-riscv.h             | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1


