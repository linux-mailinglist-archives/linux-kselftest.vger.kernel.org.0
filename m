Return-Path: <linux-kselftest+bounces-6343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0287CACD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16331C22202
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15817C6B;
	Fri, 15 Mar 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ4Y0VJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDC17C66;
	Fri, 15 Mar 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495393; cv=none; b=g/TM81U8xb3xo6fAd+1yGcKB/XvVhzI4auLWU9GC3C5rG1Y8PAsj8LIImTLM5vsJKc2oKGJWqJ4DMyxksD7XLB5A+p/NgAqN+C4dHnSmYAmW990Am7fWiGvK7IFHQxF55wIL3a+iUeO/XNqwKYnegQwcGywaZrJigUBTS/CgEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495393; c=relaxed/simple;
	bh=VgyR9/qh5SvA5TrFhzFHvJ6YsXi9BlJT3v7qlQZYuoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S/Mg1/tK7qiu+2OB2bBfzgVIPJOAp6o8kTxw494MhvQjSMvtMG9Uv0PsPQSFFRepv/3ISqEGfyAgtKbgQ/CR3/gouhJq+IgoEm4Bhp5zU+1WrrXwhdpdDi6/3cLzItoGzd1KPQ18grsF3z7fshWInZCbHrtSdweFwAyprz8i/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ4Y0VJO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41403b203e0so681105e9.3;
        Fri, 15 Mar 2024 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710495390; x=1711100190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJTv+jCFSNgUGswO7FXJc0Lm26VLRiBRl5ZlHIS2q+A=;
        b=MJ4Y0VJOI+Rj+ewA8IqIwzO4RHIyiLbT7yPIExDWJCq/tnOW2povxHgfOGFi+EVZe3
         s/DtkpYC+uSmuBfH8x2NNUPsxpvuMNclnJ//IB3wr7sqSuFX1lBnKz0stiTfYtunQut5
         owx/g0/igpO4hpUJ6Tfp21tqvo0Y9X8wuPlam68pSM02NpJw+ZXm5Pys7vUFqiFwpv3f
         ckuQMPkVzLNfuALZ+50uZ117n97vUz6gaDD+i14AOC+qivQyMohnRoxnDC95Oc7QnMOe
         ozu5FftmyOIHm04lULKY1PiH3VfikmZUaywIJFhOgWkbLa9PbTaX9WUaDXZKvlyt4qdc
         pvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495390; x=1711100190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJTv+jCFSNgUGswO7FXJc0Lm26VLRiBRl5ZlHIS2q+A=;
        b=jUbKsUkSG7e1Y549LTgunuJ5VxG31BHvVi63YDHD1YE1RWisWJzgQ7eeYdqvAKZmX5
         I59O1uYYQ0zmCuPMKvD5Hw/fk+9FvRdmUOd3taidYWHc7IN+Y9XYNHW1inhibJFw84Mr
         JSFygBfZ6/73G9OIgzTH7QZQSr+1GQyO2VSLr8qEYyn4Rxhrek6sAG87xNkL/S28LmKc
         rzpYF/EUhY0Pt0BK58UrEKRs12qZw2UijzqofIo+y6vpZLiVI7zUX6zRB7Yws4b56AVO
         /LnliewWPrxdNKqET91vK5wM2V6Z+kRQdnu1nVJkBowTWJ7AsTvNbvAD198mz5xjBZo2
         Mjpw==
X-Forwarded-Encrypted: i=1; AJvYcCWAlYTPu33e/JuU2mbPel5MuqdLpgycRPcHFCUbFOkv40TBa3krmkZWTySbMU0KPuGihLTKNdJLZWZVw5+VJl4EE4Rb6IRkeaSmlWDUajZpI4/lt9O4D7GgRbo0B9whDd0qaEIB/9SZO5+er2mGA8BQj+qArO3Lzx5SMW5fWarTG7EM
X-Gm-Message-State: AOJu0YyiAfTuL+mhQb+2HFExq7JjSA/IjeBTjmC/w97e6NmtQMHzUsbb
	h0xDVySD6/vloHnqBy3BJm1wrLta3dui5q6TlujkIG4bv3o2smMY
X-Google-Smtp-Source: AGHT+IEoKXdqYZ7z7nKgWADnipOKrnv6Eesx2OFOohN1P1Y4ePV4yX8maQRJ2mf+EaidEc6k6Vm2nQ==
X-Received: by 2002:a05:600c:19cd:b0:413:ea5a:7787 with SMTP id u13-20020a05600c19cd00b00413ea5a7787mr3018899wmq.22.1710495390374;
        Fri, 15 Mar 2024 02:36:30 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b004132f9cf053sm8314827wmq.33.2024.03.15.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:36:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Remove second semicolon
Date: Fri, 15 Mar 2024 09:36:29 +0000
Message-Id: <20240315093629.2431491-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index d2ea0435f4f7..7d707d8068a4 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -125,7 +125,7 @@ struct compat_vcpu_runstate_info {
 	uint32_t state;
 	uint64_t state_entry_time;
 	uint64_t time[5];
-} __attribute__((__packed__));;
+} __attribute__((__packed__));
 
 struct arch_vcpu_info {
 	unsigned long cr2;
-- 
2.39.2


