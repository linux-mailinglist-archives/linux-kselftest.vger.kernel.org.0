Return-Path: <linux-kselftest+bounces-16207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36995DE76
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7190282F89
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ECB17A58A;
	Sat, 24 Aug 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6cmhD1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9E1799B;
	Sat, 24 Aug 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510326; cv=none; b=VMw+W7yVWm3fJd4JVdmI7PApNrWdoSza11Qm0iu4ZdaDTN75K1I5bYTRtT8a8l1j8yInLbFR2dBBP1voha84KVNjiF8OgOdsb2m8oVoqqp2+0vgfxb6JZVUiUT8osQEmVlGW038M00REpv590phqE0jXrH0e+aGsBqqfBt3NaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510326; c=relaxed/simple;
	bh=3VlX5AIbTArku8zzjD1w6iIfmrY7QFk40tFR/LZEaVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTPjHNEhm70NLLF144Oc7DHmsB7DJsNR/GRnags/Ggl1DLO7BdDjboks/TIVAZjIitIxdrOL2YZzV3a9iPVdB6Gom0dU60ZJXJyDF6i74D8fAcK5x47j29oua2/OZIyUyKPBdy52nOaZiY1ylAcVl3qeC54QgN8dkg7cApeING4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6cmhD1Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b0c5b1adfaso27774397b3.0;
        Sat, 24 Aug 2024 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510324; x=1725115124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqf/4XeJ+EZsRXY5NtNf2SH60OkcPdbLs/5YIVTLI2o=;
        b=X6cmhD1YxNO4Fr7hALYfflbz5/DAO+86Y5MmBWQRpOitOzLsJaXpqDUPmq6pjECTNS
         wFWICfHyKY5Xvhf3h06b8nLin7aO95dQyndoWM8aErfTtxC5rTZid/3W2EGP47DYheGa
         Wow5lOCuWnUXzEkrpru0O+hBObxw2uYgMRvZ4IbE4nt+LdLkrnj7m3GNs9u79XymFHAf
         yT6g9E5Vvl8TsiXUeCwFqu3ZuxhKtsDWEf1j+EG/fWEk+1urpV078PSTChB4ajAji3rB
         eNpotFiho/BgiHIlSR5Xkw7yc433FBONkDrupTUea4+fIhax6ezwzWNsTYOm0M3cgTtq
         EwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510324; x=1725115124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqf/4XeJ+EZsRXY5NtNf2SH60OkcPdbLs/5YIVTLI2o=;
        b=h7rTIexRUX4zY/qXU+fil4u41mISe+mCfk2jrb8oEyPJ9qeHt9TMzUeSMkzCFyGYUP
         CzPYPEUzeo8cx5gH8etEakCwHkxXK7XFPB10C8j1pV30EsutCfk7bn6qCll8zBMYKDhQ
         whMLQ7UjvPA9diBLcM2yHUmp3wTvIDVq2iKW47itMYdkiBankjs7WzES3v5JIpTL2wcX
         BEUqcU3JBcxaoynDyrziewmmiOAqEEV/XPl0rszw13vwnGh4cLZaMqIA9H5MpfgwLxpk
         X2wl9c/G8yuU+0+NdoTnZnB5bP4tGy+37qjVDvMKUMVwmBYTAlm5cOkdbeuawv2SVXJR
         TkQw==
X-Forwarded-Encrypted: i=1; AJvYcCUu4w4h7Hv5fGNh5WSjwPEewTN/kuhs7xRFbQR8aP4h7yjpuVLiIrARsnXyoerrU8DIp+YTrQ6zh4UYWVU=@vger.kernel.org, AJvYcCVircfARk3DAPbwoiVfM2Uf/TEmDL6R2WVTAkZu1IUcSIY5BsvaeuTmv5ycPW+ADlzQRnaQAT1pdFUyf8bFQx8w@vger.kernel.org, AJvYcCW2En67YTf/e/Ls1CRqwtVUb/1IjQZM9wdOPoFYZl9bElBsnJfPW7+ePb6P0V7pt6n9+yztBYUA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+oj7woFIP2CPd/TiStlpq4N/FmKG+WBN8Gh0i9SowKfAFjZm
	bSCfp/as1+FGailjUe/gBsoUSfh/3ModQCq+w8uImpdW2xFfTav5
X-Google-Smtp-Source: AGHT+IFblOQE/QFqOJo8brKLahprxljEnCHnixrEx5DVHm0F5cQXDAz9kvkm1cLvPkjDlcpaultLOQ==
X-Received: by 2002:a05:690c:3246:b0:6b5:71b2:13da with SMTP id 00721157ae682-6c62915ad9emr51652677b3.32.1724510323975;
        Sat, 24 Aug 2024 07:38:43 -0700 (PDT)
Received: from localhost ([2600:1700:6165:1c10:7f22:cda9:4042:3473])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753434sm8767067b3.41.2024.08.24.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 07:38:43 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: david.hunter.linux@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell script
Date: Sat, 24 Aug 2024 10:38:37 -0400
Message-ID: <20240824143837.228874-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823190828.214443-1-david.hunter.linux@gmail.com>
References: <20240823190828.214443-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn on the execution bit for the shell script file. The test is skipped
when downloaded from the linux_mainline source files.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
V1 --> V2 
	- Split the patch into two separate patches (one for each issue)
	- Included subject prefixes
---
 tools/testing/selftests/net/test_ingress_egress_chaining.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/net/test_ingress_egress_chaining.sh

diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
old mode 100644
new mode 100755
-- 
2.43.0


