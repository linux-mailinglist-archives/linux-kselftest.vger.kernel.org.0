Return-Path: <linux-kselftest+bounces-44785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B015C34389
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 08:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464F5466B92
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AB2D2483;
	Wed,  5 Nov 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQhh/5Qe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A812D0C8F
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327598; cv=none; b=F7WiZTTqasKGk8+Ph7OJTWDRptwQenMEFxQlZwDQfdVnGpnHnKjQCJ2cnuit++YV8TVW2BA3s2db6IAIknB1swCmo1sJJn9RsP5YtQHmUCezW931YUGMTh3NHn5fYBmhiNm4aH7Y9bvLGTCB6hnIfzPuUojf7G/BSm1u4EG2igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327598; c=relaxed/simple;
	bh=LdTnDSxNZBXjDx7hbd4YSkNL6Ic1axoqxA3e5rGwXRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nikb4BpBmoUW1D7KWmm6iIIk1D1b7UI5GWvZ+fl2iehoZhkJ2QWTV34pSCA5PsontIhV64I/1tjXXd1lfWgnagj94EIY4N4dBBq6o51xigeWAZkb1qwzzE+YWZKah3Od6OrJc9otqEZ7LWNNztaL1uMRDq3NjarsJg064aLGEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQhh/5Qe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-292fd52d527so64904425ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762327596; x=1762932396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfyM/8vqHeCTzj3QmjEypBM8G6UG0t8t1e4R4RozbuE=;
        b=IQhh/5QeCmghP/usLtothAW0ZH36W9P6wz9pbRjJpU6H40b3mZ8PeyFdPpMI/cvm8E
         LuBls7jO++YGC0rLIRkWd8SX9JILbcsH4f6WzXnVGbdYvA2zEe0KHrP0lg+qCR2goMww
         FCQIGLDDPjT42RsHEnRDRp4LBccECndEyt1bQecBBWDoBBaFFbnFvMx6xD0iJYeSMnXc
         ropLgZAH8LJtsVDsSymrj9KSeyPCbkKJ9XqdJewPCA0gEGrdQ2XaXoFvbF6urpJPSxbR
         +W09xFo+UoKVeK6qW601QIkkeOOZikzuzQ0O4Q8h8k5NaGWn1njf6VLjSyMqR77kK0B4
         HXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327596; x=1762932396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfyM/8vqHeCTzj3QmjEypBM8G6UG0t8t1e4R4RozbuE=;
        b=BqNH0Dp22Hs/27eyqVSXjMPyqLp0tBET6NpKD/9ZxMW23SQYm9YXoZPnUIoffgnjbu
         XQ0m/O1EjakzIA+ul4XVuxzhJASNBCyAjbldhPk92b5JENjxteSbQVd3joTg+NVK2lDq
         3C1Bb1x5zxrhdfcmfFTG9CGAdludOCpdY29mwfqNcqAw6FULoZref52OTxStK+9bQa2/
         fYUNI/qJeLBRhWHfxmkw0aXQG09tX085dJ8FWrQbdQMQ7j3G3ZvsF+UAsf2HBrZVCQmz
         zpnsjrs9+R93pXo5iRsWoHZmMXZiKgMG8FVHyeyaTd6h/4/SfgtEzz5roFjzVnpfG9pz
         C0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXencClDLlQ5/GO8/RSVvQHIAP6HnF5uwgEH1OeyzoKru9gBVfRXXQ/zrwx0tIUODuYJKxL14oPgRXXr5p0GyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nc0/HupcGrrpzX3hs/dlciZya0w35KN7eKaljNf+dT3G/FM5
	h4az9sXKaX07qMBNGr0+3E39jdFFrFhOIFiyHBNBGN0GSxE0BltCEMNe
X-Gm-Gg: ASbGncvuUhUYF40E8l2vAv0Z29c1r82j3+9jGlvZEbHN3GF9vYmAwe/ze0e/hPs0xoi
	44O+Z4na5h/56t//V7qQiPiKXGb38Nzv93EHrZWeIxDUmqB4wZ2qFR4v+VZ6ZU+6zHVFHL2NkTz
	j85/ppaS/1Z/1+rZsb9vHGzmCy6GPJmHkfcS4/rs5agplxswIF3E97S3FwVjcKAsdw/8EbZJKv3
	BYR6pvSfUPx6p6/wx3VNRqCVZti7JxK4KjKuOTHJmiHEv5Q8sJB8vtSIRlXZZiwppQ0olKzJYVw
	tWhyJz6BcZvrzuQB55SEd+Z9ZluvSvQowenZEZSG1+ivJCnzaW+9Rltg7K8cBePp4YlqjmHKuUZ
	JdyMkj8gOFltobX8q4WIrE96D1AE0cP0eGlZmtc2R8fzOM+no6T/qFOgUjm17kZi3e4IZt8n9KC
	MJVmilYj1dG5GXjas=
X-Google-Smtp-Source: AGHT+IEOMVkwWrIGuENRWKmUQBRQUqq7cCWrETYO7qxGemtZUKXL3uWNBldA5iIsvA0q+Q16MWP1oQ==
X-Received: by 2002:a17:902:c401:b0:295:5668:2f1d with SMTP id d9443c01a7336-2962ada6455mr31522165ad.41.1762327595676;
        Tue, 04 Nov 2025 23:26:35 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998671sm50365355ad.35.2025.11.04.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:26:35 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bonding: fix NULL pointer dereference in actor_port_prio setting
Date: Wed,  5 Nov 2025 07:26:20 +0000
Message-ID: <20251105072620.164841-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Liang reported an issue where setting a slave’s actor_port_prio to
predefined values such as 0, 255, or 65535 would cause a system crash.

The problem occurs because in bond_opt_parse(), when the provided value
matches a predefined table entry, the function returns that table entry,
which does not contain slave information. Later, in
bond_option_actor_port_prio_set(), calling bond_slave_get_rtnl() leads
to a NULL pointer dereference.

Since actor_port_prio is defined as a u16 and initialized to the default
value of 255 in ad_initialize_port(), there is no need for the
bond_actor_port_prio_tbl. Using the BOND_OPTFLAG_RAWVAL flag is sufficient.

Fixes: 6b6dc81ee7e8 ("bonding: add support for per-port LACP actor priority")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

BTW, the logic in bond_opt_parse() may also need an update after we have
f2b3b28ce523 ("bonding: add slave_dev field for bond_opt_value"), as we
may need range checking on slave options in future. But this should
be another patch and not urgent as this one.

---
 drivers/net/bonding/bond_options.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 495a87f2ea7c..384499c869b8 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -225,13 +225,6 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
-static const struct bond_opt_value bond_actor_port_prio_tbl[] = {
-	{ "minval",  0,     BOND_VALFLAG_MIN},
-	{ "maxval",  65535, BOND_VALFLAG_MAX},
-	{ "default", 255,   BOND_VALFLAG_DEFAULT},
-	{ NULL,      -1,    0},
-};
-
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -497,7 +490,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.id = BOND_OPT_ACTOR_PORT_PRIO,
 		.name = "actor_port_prio",
 		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
-		.values = bond_actor_port_prio_tbl,
+		.flags = BOND_OPTFLAG_RAWVAL,
 		.set = bond_option_actor_port_prio_set,
 	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] = {
-- 
2.50.1


