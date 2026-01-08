Return-Path: <linux-kselftest+bounces-48489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B290BD01D1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0889B3002511
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33142C3CF;
	Thu,  8 Jan 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T37dA/CC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE242A802
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864017; cv=none; b=OKJ7rpNQbU5qR8JtAoOy3EN2TJwOlYDC5kyz4aO8JzuuPLTSJFWbYAR6K6VJn0lrgRi7oi4oVPgHZJw/JzzMKh1TomaVuIaOGIcFrXA8yquLrMoluTF01DEyLLkdEd3N498QppYqZL/UK1jKgWGd37GpycI2zadjmjiuVJYLNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864017; c=relaxed/simple;
	bh=PiJrliNo49PVFk6YqUqyrLpt/1vol3cyy/KFRXn0phY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9s5wDaQyaJ9eQgcbwJM9qXg6Y/xp4hmuY8Gf6S+Vp9NXGS98wldlejlFksiJCXn72IhtJ+gZBFGE56fW4tuYvvWNR5Ob+88IxKJeKE2YjndFzRaxg5aujx2oPpcR5OBM4YvMbKNHcm6rZYpBs7gRgrfJ3GMWppIG1E0RuFC+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T37dA/CC; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b6691baa33so46137085a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gYSUwYEgMWI4Ieo19W+aEnMIj5tPHnMNxItk+xKc5E=;
        b=T37dA/CC6v9AjB+Bp+nyMQuX++L/kggGszYxm4Mb7NPwE6ksnRQYU3DPcyspF+Q43G
         Ty3u+lp6U3eDge3CEGLFnio2Jvhc3LkEa23SscN21rT6r/rptsagV7sSUlafhizddOep
         EoKlyh8vLl0jTMZjp9n3p3Be2irJAdD2A3GAq3Udz7pn+oHKodNXIbe6PZgKffpMe4HI
         FcGHxJIJVVBE3ImAZ5ATID7lM2yZxulzJnbDr1u5mAMbcYOHpD2T7kReGUm05tBOYbiO
         gdrgwihMsZ+VemNbfUDx+EE84mHI/bd7I2QhXkFrrSuOqMFF15FMIJr5KqwGyerfgNG0
         C4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gYSUwYEgMWI4Ieo19W+aEnMIj5tPHnMNxItk+xKc5E=;
        b=aMK/3FDM8XHujTCNtRv1c6jAK2nr7wvEh3CYynztG47+HEtyPr8Y/vg23ze4KxZb6X
         3ThwAeGylQ46vz5KNJirVsYykyumLK0l0DifEP752ezgDoaWBCAFzAGjq5OJFGQoM+/+
         x2FiD3cYnHEv8xd3OjshVeiTn6UIL7gC/mfGeCjO1+9GpzsbFRRiZW7ipsigOHVrKXSZ
         Tj2QHmDc/uc6wx18UMHAHwlaweymV/avkzsDCJmhLQvITmtBztwnOmSA381B5SChPta+
         2iwkUhklyp8BRN1S4js/R1ZgSpqr+J7QnOf5SfwRuXrhS8Zzg7RdID2Rjrti28WJVx1G
         BByQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBN/7YJiTW7CJAtvMeoVaZlW7VoZF3rv7l43A10qaLdIV3qj9Mq/5rNwI7Lmnn7JzvBVNs16kzDxZGNqVTbhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzB+45BhHRsJiOYxOwyvnIxEYMQJmOKMTLAzIRjgfLvOGv4Xq9
	3FpKvwlEKiuwWzg84rG7UpVetnWeffRenZGgrHZQnHk0/l1AW8FiZZcUXCfoncM7RTZuNCc7vjK
	ouDBRX76cGi/hIZ2sVncLYU8h+D19YIdCXAZL
X-Gm-Gg: AY/fxX5pdRoleuCatYbeyD9OmVXUZ5BEFtxw4gXvoEJG9XNaG98lrHgsMu7YbXrEqXo
	nIHL3PfhJBKM3799M1e4CMVi1x6SvXPG98DotdwjFTOp2X6oBd4ohWtUwz8lFHicvmknJl4wT+F
	AlQXhm4e2aLrJ7KQIh+aj5v/Zqt1AM4BKCXe4iWfsiJ6WpNwPcQMxh0+3sf9G9LjtILpZ4OzauK
	vtrsMZd65k651S7uMREuz1zFPQ0GfJOasl+fRc82YrzF9yMy4Q8tv0jyDy35VR/zh6ruohWMGhB
	glBaPkvn6Vigpd520PC6oJM7hmBss4py1+0HZttYm8dSsXocTb/jHBODofQClfW/wY1P0keZnc4
	xY9itspRNkr8pK0Jahg3EwMQr8mU+J6pA8ubS+KuBAA==
X-Google-Smtp-Source: AGHT+IEK4gUUkQ77Hl6lEgaX0rnIgLGftUw30eNtSq2wguSWSJrTS5mtAVCSkVWAW8KZbMvlfdT+D1gYFTz5
X-Received: by 2002:a05:620a:370a:b0:8b2:1f04:f8b with SMTP id af79cd13be357-8c3893e7e43mr538957685a.6.1767863997610;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077093b36sm9310326d6.2.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BE3D5341DAF;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B844EE42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 12/19] selftests: ublk: display UBLK_F_INTEGRITY support
Date: Thu,  8 Jan 2026 02:19:40 -0700
Message-ID: <20260108091948.1099139-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for printing the UBLK_F_INTEGRITY feature flag in the
human-readable kublk features output.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..261095f19c93 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_UPDATE_SIZE),
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_INTEGRITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.45.2


