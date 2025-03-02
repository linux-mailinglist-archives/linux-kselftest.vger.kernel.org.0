Return-Path: <linux-kselftest+bounces-27987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451EA4B4CE
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332123AF029
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F21EE7DA;
	Sun,  2 Mar 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Fo9BNc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25B1EE7C2;
	Sun,  2 Mar 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949192; cv=none; b=UkQowrdmAR7wxhfxZxYlUzQ0BJYBL//cQAJNag7+IjCL5uvwEb6nk1KY7Y52WgP779tITXvg5WE+NRc+wlpcGkUMnCjC+jdSvJP9eKG3DfM2U2Jt2+oF+izdcEK3OpNBwV/LR65PlrTKej/p7HNyLW8dT4mh3gXs7LUEi0NN5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949192; c=relaxed/simple;
	bh=EVIO+v/24deXKLU+C/wwhMKi5wh1ne632eIVRSTpl8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxSHFUSlWLXAIPiCaAkh5sDBwmj+lSNDRrYceSTrWdUXKmzWaERxNui/T2NudWo835v8arhm6Z1tecs5rhRB8cV+7oUsmtx4dLzyxpfr0pe/UTd77FdCcdl0+/UvAzxMu6QXwQV2CyHvDQ3ejuiC8YpgaZsise1s/OdFMsitJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2Fo9BNc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fee05829edso2086489a91.3;
        Sun, 02 Mar 2025 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740949190; x=1741553990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQrtmbgkWsv2v1++udS4nQSusBShrLN0fVmDuyn05Ns=;
        b=B2Fo9BNczPBYogbo2RKEY4/U6qTJjSwSwgG6+t7q/F21Uwj9SZ1rs0puuI6zHGGG5v
         qCj11RW+lCFIaazI+PB//Hi0Qd4+LVGWJL9NiEfl2eqMbJwBz70PCb7vpZ8F0LPlCuyu
         qguuAzWTqO/ubp7PXIutZLqoY376be29stgXKgOk71r3NfPwpbnazV5wPVpNzU5suOFz
         5AVfITZMp8w3kq4RFhszAflENmyt+JqkmhWcAImhcO/fzo1CLKHUHL1I0BSB3TTabZ6V
         q/1/FI1tYVQTM/CqzKdLrujgj9z1D97Xdc4LCzs3+jCH1wOeu1CjH7FN388VJMLLSZ1m
         sQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949190; x=1741553990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQrtmbgkWsv2v1++udS4nQSusBShrLN0fVmDuyn05Ns=;
        b=UFpU6k76fMMqB4kU5gifdTum7CYuT4Kzeo5/3utwT2pwlhVZl/vvrxhYH8W5hrvxQJ
         zt2MEmAzT4PwIjvnA42IKgUL0585UO9worZ5+XDxeUYeWXi507wAmBKMEWlnrpG35b9E
         KDDSkOl2hJgDeFeDsRBja58BHzFzc1iGl9vMSkTtF3xArjLIs6rfFgDHYeSat/uTFpS5
         ZywMSqCbdO2i+2lRH/M2GVrKonNvx+EHw+u7t7W0gNkhfHWifJoEsx8qN14iD+eVrXG1
         rpNo/1WsC1FZ/MigQyJ9qVbokgh+iBO0aQIwUU2OA1GXkRwCFfWNrbqfAIg5qSSQgWZx
         w+hg==
X-Forwarded-Encrypted: i=1; AJvYcCUCpECHezUAA1ku7uWDX64lJmARjuWAl+zwc/Vhd7RMxjfj6/jQyU0GnZP3+ee7sjPmfYo2qRGdLT/3OjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzynF2S0uqrwO/sMCQZfnLC+HJrD6KL6WLIWnEAxsyhQBfS5AQd
	x7WLODI7XmvwBtHKORu4/tsKsXtK7QqSMZCRY3z0nmls7mIhUxrCOSbTe0jVi4w=
X-Gm-Gg: ASbGncs/bRSfWtgR3ddzTNNpgVRrvYzjJKIxdpz1GkSZywVNlGDpvRwC0udCGkz/Vbb
	v1Vw27l6HWh6pE+MVx/JOkDkzEDeeDB233tmqpligcyLQRTB2LMEPrv8rxzPR396eGxsv8ptReK
	AN+eari56CfjcaPDylK7W+DC1UScTgLC+B99zdnBhXvHb6YzkNEcI++fbHeELycZz5uoVP0LHzK
	wXvZQM/Lu/vZ3p75dsve+02rAMqQG1dzKXhi5Ta8BZcyKBdn3McDhab2VUVpCW91CGmnRw75yZH
	tLIxjfDAcw3qeLu+rW3Mkw6tXyns/W4qTWgNQAmnCVKgVrjNDAQH8gWzfdJQDLyS/R4=
X-Google-Smtp-Source: AGHT+IF9O8QedaP2MUJJC4zNM1xUSKwwwNhDawRWlQxBE5Cv3vAyXIZUVaWAvolbX2E0fdfvLlCPdQ==
X-Received: by 2002:a05:6300:8987:b0:1f3:29a9:6197 with SMTP id adf61e73a8af0-1f329a963efmr728338637.18.1740949190420;
        Sun, 02 Mar 2025 12:59:50 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec3e05sm6827947a12.49.2025.03.02.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:59:50 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 2/2] selftests/pidfd: Fix missing header
Date: Mon,  3 Mar 2025 02:22:46 +0530
Message-ID: <20250302205859.14782-3-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302205859.14782-1-simeddon@gmail.com>
References: <20250302205859.14782-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation errors caused by the missing sys/ioctl.h header
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 222f8131283b..4c8a0253a64f 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -17,6 +17,7 @@
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <linux/ioctl.h>
+#include <sys/ioctl.h>
 
 #include "pidfd.h"
 #include "../kselftest_harness.h"
-- 
2.48.1


