Return-Path: <linux-kselftest+bounces-18669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A798AB26
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC9A1F23CA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F359198E92;
	Mon, 30 Sep 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuOOHBn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA718EAB;
	Mon, 30 Sep 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717664; cv=none; b=kIi+Lk1UnTcn3EL3o3VJd14yNf8d0bQhmORUv7ZpFJBZzk+rvqyruTUDS77my6/NgvphrYydPgDWPJdvrkvp7vHmYioXDv71mxQvwjrZnCrCUkMx7Yu9Rszp+g9eSlKkn1/EdfhucIqAjdzjuUY3SAnyo/nG3l4WsL+/bs/isI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717664; c=relaxed/simple;
	bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wpf+fWOy/wBHAnw43VQ4BBw/Jv2AIVcE/j+Rvv2VxorZwaxZ9IRJ1qfAFLFTZxxrmpdyrvkmzGK6ze/GGwFY/l4+Zo+YRydI//+nZ9KcuY12MbHoXNTk+EFiD42cPtRv7+QIlaz0WKsgDoLoSfT8zjkRWCF2TBuhvt0Xbsjpv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuOOHBn9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e5e758093so37143375e9.1;
        Mon, 30 Sep 2024 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717661; x=1728322461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=DuOOHBn9UgsCBLx1rlfQbw0CjQKr8NRGxcoxopoEHodVMBn8ZXe66CKAwK2QvBLERv
         bAtfaVlyT3nAZ6fWRbiJFvfMUYArH/L2ogM3ogpqfaa6x+je3y8ilxTuZP9BEmDrHzyD
         mxVeWRkyO5L3/970fT47sXstdlahsu3jgDocof2fZ6JgMKINLGRFSL9JAVoseuITP1jR
         qbO6Ef9axP3f+OZfMyM7Oe45Nn2yxvw2w8QzqoWEV1TPyDmoBq17vwKeiD9TMqpDruTX
         wdMNxg186RsqEgjvlM+8L0jAAMs9j6wse+1Yds2WaPMGnjIOVaqhvqn1GGiTGIeVcSQ5
         M0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717661; x=1728322461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=KmCwQdiUbWKDG795KhUaep9ZrKCYvCAZ6U0BEFKz/1UBY+Sq6J4cwjZ4Aq0ud3Q1dn
         uNgWOgD8J+x5YOWyswKrrxcijX0PVmC66Bdi1oUTz85gyvl7rj06E75OqheRbeZDeNUa
         OMYiPGrQhx4quHngbHPm0EKNmVuJSQiEEVq790g/+Y/4G0e6ZU9Rdmid7anogtT01cpR
         CIDsx8VFdpX3aSnoNupQlJ00eN7BH8zkpSSD+eQor7pt8yXVFRjZrLUIvyKB1HSarW/8
         tsG0xKhIGZsIZE7wzUf5J99stgOMJnR5F8OlYfgeNLBx+Hb0Ds5CBqaoqHJOri6YXnA0
         AdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCViU22tBrdUjZmM06SJzaLvME4RHxAbCrOjEi5v5KZLv673kZOyzZrXSxgxHABg0em9CCqSeSlAVa2eSqnXFp86@vger.kernel.org, AJvYcCWAiclPqPJ44VLJbWAD/PMuDpKQQWM0UB5wcNVW0XoPPGOEk2eitWedtUERTJcmnO9/nIsHrhBNoBraVA==@vger.kernel.org, AJvYcCXCo0GmcNXD8tePKuUh1wRMs43+DTmCqAVNsQfR5TiOUPn3/wxRvhL0JZmQP4RUxjowW179MB/Tkgo+GrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOR1rChN57e7I7IXKLODlHKcr6uist8M8lwlGLWJmFx/j4YOod
	+Gs36d82ofGikeW4CJp/hOq61KIzlmFW7DgGuyaVj1CMjwO69xrK
X-Google-Smtp-Source: AGHT+IEBZo9SqdB2jRSf88twMMjrMHvTlAzKDcplvIU3zIHKUhFSE8Mvf/s+/KtpUIjmfUdI6837xw==
X-Received: by 2002:a5d:6807:0:b0:37c:ce45:96f2 with SMTP id ffacd0b85a97d-37cd5b1f317mr6447425f8f.50.1727717660440;
        Mon, 30 Sep 2024 10:34:20 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm9706942f8f.3.2024.09.30.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:34:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 19:34:10 +0200
Subject: [PATCH 1/3] selftests: net: add msg_oob to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-selftests-gitignore-v1-1-65225a855946@gmail.com>
References: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
In-Reply-To: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727717657; l=629;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
 b=rkVfi9/8JtgTEk8CJPQcSsbCZHlvVJLi0s/LUgGfuOpYFUDDpeFpg8Xdsm5aCqGsqB28MxJ4H
 u27HgVyOBYfDFEHlTuYgJHmiawgrzCp6iG99jb95I46IspWuhaeB2UR
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This executable is missing from the corresponding gitignore file.
Add msg_oob to the net gitignore list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..9dcdff533414 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+msg_oob
 ncdevmem
 nettest
 psock_fanout

-- 
2.43.0


