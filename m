Return-Path: <linux-kselftest+bounces-18300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C64984624
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070302845FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9041AAE00;
	Tue, 24 Sep 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djGUSJog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468B1A76AE;
	Tue, 24 Sep 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182159; cv=none; b=qtG19OAM4hknGGGO/pA4Nkb86P5FAXkGUOT+ZsP8NdO5cGpoevpP6g4kxkM8Oh36ZrqGldibTCaA0EQqosF53lGPVL1m1xqQjA3HtWD1hdA9Gwbv2kvIlOL04LvOBddhi0cnFe+PdznNuJRwq1iuk7npY6OE/hAn+3qJinSW4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182159; c=relaxed/simple;
	bh=DQFhk2Xfl6f1y5hk5SxYNNhg7czkXk8NfS7M9Ov5Pfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRq20zZky4PCBQL5sDL5KUnoEJ2AlUdeVYHBO64LKvWLslEelrjme0dJOEKDaulVTfPg9JBuqk/217gPqq2MkIkO4fUYMU0l6MJgr8GEAddK5SmvRnIW8xQxlPgnN745ZrgUJ9SIM3aisiFkUSw3RMBF3fO/Qj1sIN4vzMCbzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djGUSJog; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso6079813a12.0;
        Tue, 24 Sep 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182156; x=1727786956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28VW7EwQBNCUsGBY6nmA5GEGAmkoiAr6aGKyGIUZeJY=;
        b=djGUSJogBhe2vVTZw3nc4O7f4/n6keO49zs4x6OuLfoq9yxD1uu1/3LEQZGXI4V+nT
         4YnaE+yAbMhnE5sshAEYmU65dyKTgHToAra07p1PP03Qx7waNwswzUeebB/unvSW20O0
         ZLWM7SBtbNC0TcnrsbAdzbqDAqVKryYND6TQrEC896Jby/y8RhsUZLyonPllJ+eTLgOo
         r7Z8RN/Nm1r3wbkijP9vtVUk+d+QT8pIXHDGIn4JNXv64c3hJsY2tdvzyILZezWFTImx
         dtiAY1nIsSa3fcy2DHxhBQZQMG4dh5VcKBFoO2z770Rvc/qvZjMbttNp75LfSFMxwPAp
         QNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182156; x=1727786956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28VW7EwQBNCUsGBY6nmA5GEGAmkoiAr6aGKyGIUZeJY=;
        b=FJuWA0gbFMTtlP9c3weZ2ZniORsav5dZc1+j4Eq0gyCSuxCY3++kEJNzMi/WhJDQ8l
         eLEbuxn5BMVYxUugv2KvPaA67bUxiDG3PhHr2oDXYPqmetqhCwKVOHBjkozSHfUctakS
         KO/Yl69W5hRjsjBLxAkTjfD4peaa1Bdm65ut1QaMPQmWqh8npH7JPaBdePAcUgIqp/TJ
         iv90TYfXotW/HQd+GZq9znZIoPEyoBs3CfpDB8tzoG1ryqAw0GVzVJJG8uZv4MZ7+aeb
         sQ7s76OI/tYPPiNg6WPkBxbHEUVonCqlzvs6wg3qJuGFbx478VW1bgr1VkUuQi+XoLs+
         jhVg==
X-Forwarded-Encrypted: i=1; AJvYcCUUrqXITJ9ZYhFd/IfmckPzuGphbICK+7qF9jYZaFU1/ViugkW/sj5vovCOLpS64p+a34YJ7OQOIW9Pug==@vger.kernel.org, AJvYcCWM3H8PAnxk5noiM/bsgYd2HoYM0iUDcsuCYoakH6bIxdp7yzExLm1ni13Ur18xbPbgv6j1czFz+KuvI7w=@vger.kernel.org, AJvYcCXD/mPp5ZAP1S2mu0mrqJd9DyjQx5uxbMypIkVNSQX44c2IpFyKeWwGOkvSP0rMCmtbmf2NJtQm@vger.kernel.org
X-Gm-Message-State: AOJu0YyppaI294SfagAZOG38KF76KdmrYHF6JdkE80wF9c7HNot/4XOK
	ZGWEC5qJwqetfFSAP2bW4TDNW+XV/kDq3H8BSbeiR8FVtvz25J8e
X-Google-Smtp-Source: AGHT+IGHq0lFRZI3QZZ42Hh81KnJgeEK9Vgxx8RO6sSCFg/TmIc+cQbOP5FusfdV4o7rAbq4jJfynA==
X-Received: by 2002:a05:6402:1ec1:b0:5c2:7727:6109 with SMTP id 4fb4d7f45d1cf-5c464a7f49emr13729206a12.30.1727182156303;
        Tue, 24 Sep 2024 05:49:16 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm704932a12.61.2024.09.24.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:49:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Sep 2024 14:49:08 +0200
Subject: [PATCH 2/4] selftests: rds: add include.sh to EXTRA_CLEAN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-selftests-gitignore-v1-2-9755ac883388@gmail.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182152; l=786;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=DQFhk2Xfl6f1y5hk5SxYNNhg7czkXk8NfS7M9Ov5Pfw=;
 b=KsCocAqpSh+R57/NaKdxVKPhv2xkW/pwS+4mfVYdWsmrY/jykiDUauQQ9c+/Jg/eM/Ced/bhA
 Xh5jefpRrDXDlI46BVLfLYd4CiX9KEHbvnQXG7Ik77XjuOE5Zr1DzE3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The include.sh file is generated when building the net/rds selftests,
but there is no rule to delete it with the clean target. Add the file to
EXTRA_CLEAN in order to remove it when required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..0b697669ea51 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -7,6 +7,6 @@ TEST_PROGS := run.sh \
 	include.sh \
 	test.py
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk

-- 
2.43.0


