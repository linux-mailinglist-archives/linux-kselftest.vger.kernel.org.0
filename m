Return-Path: <linux-kselftest+bounces-38924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C6B258E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B15217DE67
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945A1917FB;
	Thu, 14 Aug 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEHTfYrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB213B284;
	Thu, 14 Aug 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134456; cv=none; b=GeG7ODQA9jyD0aG+0L7+SxBUVrg0GCA0NRKQDBB2FCIeCEh+lfz49CPkC/h6bWY4r6/nJzKIbcQtlYT/xXfiv8JX/zN1AYX85L/Z75uRvpzkI6it2Jqd82ePKWi+4TTwSpvxLFncDyN4GhsT98EQ6fLsMoENArD5/DVqJa5LCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134456; c=relaxed/simple;
	bh=m4lYhJOAX6OzhCoxvxa3w7Bi06OVgYOFkg8XRvWCN1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhpKkbgRB/JsJP59md1j0T2kdJcGzhmMSSkUzsWFIcP+nXkhhMBjbHdg11hFJFyV0dUHgGWM/yZm1j+xZNzeKSxMqB5OS1K2KmmjvbItioGsaDMa910RaP8B5mXUTpzJNAON8kXjuNgY1xNFuc4sN7Ai0hfcDGH9dRjMl/wMIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEHTfYrR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea79219so580523b3a.2;
        Wed, 13 Aug 2025 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755134455; x=1755739255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY+gN+RE9yc44nXCY62WmJ+eFktjeTQkc8/RADp1XWQ=;
        b=lEHTfYrRgIP0WAx2XuYfiSQVFjD8EudQKCJwQrPGKF3ddTkyWNrV/SZetopOnCc+ID
         4O/npYfo/3oTumcMjTs8j6xgBqZOSK6CXWFL9qGQQYf9JXTejAmJO/VosY2k3+yRoiGa
         bD5FJzoUUwbvF5REltdAUiYX+7/jr/IKO0amTLf1bym++3o0p3Pajvrh/9LZuY3HflTb
         VyWbtYYv2eFg4bR5QKEa/2tbASEKAp3jVXf3o5verjXLt5NFLSWsRR0SAPF3KqE/JSdW
         qdT+8MaDOxAIC2E0zpqnWgvDKOQwIPsb6nhnS80QiRbsKJh8kFCwHF4i6L8y9mDmLp+v
         d4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755134455; x=1755739255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY+gN+RE9yc44nXCY62WmJ+eFktjeTQkc8/RADp1XWQ=;
        b=ReH2CgmMr+SL89xx9ABkoqZdPVWC7u1Q/3ZzOpaLwrJyR9YXjhj4TekK9XIUi0E5QF
         NHUH9j+yaA8cZN1jK6TQsYtYOujB18D4Mwf4rjkEZOdAdjleJqTsIvWXS5S4ktVU72ix
         pX9RUP2XMi+LkSkQwThY+JxcD2rCS+6QftRbSU2IG+gOMkrob7s3vvMPJSlrOIewParz
         Zdh6vdxZeLN2wNKHtUJvXxB4/LlG4FZwol3n5oUVfl2LeInuZIrQPPNdNhXVA0Iuvazh
         LcTukKZAwoo2NorbJusmUW9pDXx8F6t/uSSWPkXyGyQ1vTb7BJaVqIkyJ6z0ubCy+Dee
         jAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLk/nboEHoMnvweI2xSwPB+I8Om2iJTInhRaFglAHR5fEqmm4qkilqVXZCzhr9HThswhHCMHOxSnZSONVycnJ@vger.kernel.org, AJvYcCW2bJwKshLigZ9lwGofAwic/4b/d1nar+G+hf2SZl/hbGKVKUgV1shrGoQOVRfdSaK7kmi1sXCpZrs1@vger.kernel.org, AJvYcCX0HelfjGOfB48y9PDxxac2A6ai6IxrqZEXuqnQ3sMrbuC67kRJCvYAzpHiYjiPFRwJVYihxrjYhU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbq4t6237OL7DlciYhVHCkJL9Kb63/MgCirtK12YH5XasVVLE
	5KcV6x5oGlhXaaRgKfqa1GUQPe5LF7caFVyFaesiDiwwMVAf8F9BQkFs
X-Gm-Gg: ASbGnct/1SaZP8cBgeTYOmQRn7mvIYXnelujUehdfc/60duuSSsACVojCPlK1Pb6azN
	FSD2g2pu4/tOd/8PUydXvMN7iFudRoSIDjEjANtiewjnVM/ajpGOgQWegxBc3PCa+VD5EGMkdbd
	G+ZTyPj1W33hwWf60V3s1Wh6O35pduHXlE9VInYLRAa6ypBI/px0quwAi3c4Lhw/ldMvYQ790FF
	JZ9IVD5DN/9JMufR8iELS6+edCEeU8v7X2OmVfr9tMn2atHWeK2JDRz6YspXb51JgfuWkq5VSVo
	5S2/J7CLMcqvQJ+LOphGimlKXYPm/XjO8EK3kPS/UXHxLyTD/9VsBUax7Fwn5AkVSAr8KxG6bqf
	/6Sp/c50SbBElw0sXCOXrhQ==
X-Google-Smtp-Source: AGHT+IGc9mRGpcx6RCRKtzBKovcaJTPERpE45hilmapfqOdxJN9UfEAzEDSb1oTISgTR20bGmnWDEA==
X-Received: by 2002:aa7:88d5:0:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-76e2fc43fa5mr1710919b3a.9.1755134454538;
        Wed, 13 Aug 2025 18:20:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf531sm33049596b3a.92.2025.08.13.18.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:20:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 36E1442A57A5; Thu, 14 Aug 2025 08:20:49 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tim Bird <Tim.Bird@sony.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 1/2] Documentation: ktap: Correct "its" spelling
Date: Thu, 14 Aug 2025 08:20:45 +0700
Message-ID: <20250814012046.21235-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814012046.21235-1-bagasdotme@gmail.com>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=bagasdotme@gmail.com; h=from:subject; bh=m4lYhJOAX6OzhCoxvxa3w7Bi06OVgYOFkg8XRvWCN1c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlzLU7xVRkmL+RuS5Hyy/RxOLf63MeLITcSuxhum7tXv Y5mmTOto5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABORuMzIcGLK2Xl807PXbLLs 6N5ZM70407b46bfU0vRnodIrct4Zz2JkWHdrvV250FET8WknldNmWd9qW/jjdePMdZtE6h5eW3t oGScA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Fix possessive adjective "its" spelling.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/ktap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 414c105b10a9f8..54fac3d3bf7b05 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -5,7 +5,7 @@ The Kernel Test Anything Protocol (KTAP), version 1
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-by a number of projects. It's website and specification are found at this `link
+by a number of projects. Its website and specification are found at this `link
 <https://testanything.org/>`_. The Linux Kernel largely uses TAP output for test
 results. However, Kernel testing frameworks have special needs for test results
 which don't align with the original TAP specification. Thus, a "Kernel TAP"
-- 
An old man doll... just what I always wanted! - Clara


