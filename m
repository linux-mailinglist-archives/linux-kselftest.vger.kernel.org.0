Return-Path: <linux-kselftest+bounces-14708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33637945E08
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6451C20DF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A761E2899;
	Fri,  2 Aug 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDHU9Iws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13D1DF670
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602743; cv=none; b=m+lF5IpH8NBUEAg5TwjLJxFdRHKWWdLHFcHKCNptwd1HNQAE8IYvbsXsBJkj2PpenZHEXE6Sq1iLhEUHOiHR3a3LCdSyhzoplnhQ5eEaOnz6yenCInx2B8IVRG10mLNCiJszpuOydSYo4IFgw3RkB86hY08FPHuFD//GvWNk/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602743; c=relaxed/simple;
	bh=tiHV62W1WLgEASnBkRMbzZagftzo0qxoQXN58XE/beQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqvTYWPatXDJ+p4Ng4npkB57/47kjiYAQg5+VAg7aeo5aKd/E4epnaEynBjD8mvQMAXER6Jp5PIcJhKJJ5pHrh2KVyJrdk8+UJvKgBCKnURkc2zgVAZcuPlh0lK3DMuFSghI+m0Q0/lA4JAoP3esf45XsxcfvW9Ar6CgMMQ8EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDHU9Iws; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2d582e31so95321081fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722602740; x=1723207540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQadfcLj0dbMeA91m7FGzai+vkUYG1DvlG0x0uq/CWQ=;
        b=BDHU9IwsyPc8Kxp6Shf6D8mk5SRsKDOGAWneg8zYgzdz5YTHBLQGRjGuxaDas1svgF
         Doj6+F/qllxfgLvKESC/OnZQYBpRsCOsfNvrn9pfLNmwjyD50+8Olnu6EGmw57aK6vnL
         DXtWkTWmKWJ9RTsYE2/wW9PasY0/UsUEN5F8JUAJA2j55E80ctkj+HcWH7SXQxWrNMUc
         1MyHfVByzmIJQcrNNtq4scXxfaT3gOM6vnIG6wsCH5MwU3ArARUyOS7s/ERt7Q0LQt7T
         zRCOGzn+imRxRyrqyBE1E9uSsRx5BWIJd4CYEXH9EnA7gZHbBUONxdcUgbCPALAWM73/
         dTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722602740; x=1723207540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQadfcLj0dbMeA91m7FGzai+vkUYG1DvlG0x0uq/CWQ=;
        b=YEQSWUvygpDPZhU3APyQ8xshlAaH/qL+APIg+sW5VXMEUoq8x9pOZRU8tUYr6bhvb7
         F5pUmFe7kwbtmVuoeSWtmZEY4jo9WCiyfZax3FxqDfDo620LJr0s3RDvDKMkR+suA41t
         lZD4LeVI+wap1cmojyhrLgY6yIHgXUi5bcdrgprl2MqAykBKsSQF5Fy5McdW3ptxZsyu
         V2pnZYzJrmgc37gsuPm+zpgof4AyrXEjk0d9sT01qEevSPzm4cLZYugny7nSHSuIp8cE
         fJhIyk8SLjZfwl21v7DGhuvkapuIdx6tH/JiGqPQr9e6NxeS9vaoFHIErjJ61R5zh9GS
         hxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhL9bUewJjkz+B3TI8QeaB4GVbqokkpsWTD8sGfYYDaI5m2D3/FWDeOHQVjkKEYK6VZMuTpwCRDJbnl6paaC2dGXaiJ28m2C4m/YqGvfB
X-Gm-Message-State: AOJu0Yxvz7vEqtfgHGA+CUaPTDdKR6S+70jNt0RFYuV+p3zYt40oZ8ax
	C0ov10yNaKs5KF8ObnXVypZG9cdsQAxLKID8zcoM77QyWXFJsQh3B+HtJd951mk=
X-Google-Smtp-Source: AGHT+IGPr/cTRmNKJixkMUcjn1GhBezt4VMjTUceJqHStS9ST6UWMb+IoVyz7mZbggjMOS71BVFYIA==
X-Received: by 2002:a05:6512:3e15:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-530bb385315mr1973294e87.34.1722602739950;
        Fri, 02 Aug 2024 05:45:39 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e6fsm218765e87.39.2024.08.02.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:45:39 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	shuah@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] selftests: rust: config: add trailing newline
Date: Fri,  2 Aug 2024 14:45:35 +0200
Message-ID: <20240802124536.2905797-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If adding multiple config files to the merge_config.sh script and
rust/config is the fist one, then the last config fragment in this file
and the first config fragment in the second file wont be set, since
there isn't a newline in this file, so those two fragements end up at
the same row like:
CONFIG_SAMPLE_RUST_PRINT=mCONFIG_FRAGMENT=y

And non of those will be enabled when running 'olddefconfig' after.

Fixing the issue by adding a newline to the file.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/rust/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rust/config b/tools/testing/selftests/rust/config
index b4002acd40bc..fa06cebae232 100644
--- a/tools/testing/selftests/rust/config
+++ b/tools/testing/selftests/rust/config
@@ -2,4 +2,4 @@ CONFIG_RUST=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLES_RUST=y
 CONFIG_SAMPLE_RUST_MINIMAL=m
-CONFIG_SAMPLE_RUST_PRINT=m
\ No newline at end of file
+CONFIG_SAMPLE_RUST_PRINT=m
-- 
2.43.0


