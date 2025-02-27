Return-Path: <linux-kselftest+bounces-27712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0DEA4753D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 06:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965363AFA70
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C71EB5EB;
	Thu, 27 Feb 2025 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdTPNYWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688A4A1C;
	Thu, 27 Feb 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634417; cv=none; b=EGykP5+kUMQFFs3kKWFLVQCkFteLec+hZnmTY2JRrQt8zdxPA3Seg0hV9duzadcTwCm0pfzM/NKSukjd0Om5ZY+ZsSRQT/1OqYmFRzVKZd4/iMhUNx0XYgRfUslmQdvMP4caJzPgOWOJDeCPdWdaWdMwCCk8YNTrRCY0wYIKGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634417; c=relaxed/simple;
	bh=OogzRiEpbjtgSK6sDQWxx1V9c9JXMnM3avl43bK29Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAqyrLKG0jwgNFxv7g8LwLaNhlmivWoqw4+kby1gSX4Whj9v10eBo0eBoYD2mS6jN9hXlb8aQzpplbyFIIfMAxvr4K5ZPH1BUiP1AeL84082bC4Qur/dhuUQr1pwMXvDrhV/yH9tohwqnr5x/k126XgiCO0cIWteklACTju6K1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdTPNYWC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fe93d7a588so895780a91.2;
        Wed, 26 Feb 2025 21:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740634415; x=1741239215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynkJy/ZeUoYmdFTVOPFkon+xQ74UuvAwMbGa9xWrZ1c=;
        b=RdTPNYWCU+6UhlablUub9SJ2UniVaVfpfP+O8LF8p/vmkmE+3y0rBPIRUeMPoSxI0f
         I81ChBAp6AfI1ycZ82muD0HP1YoJVoKhN+VHSA58oGZENjmgp9xsSp+49dqmpo/qDYs6
         Z7c11e6pm+ubfZPXKWc0yx3g70v+OsMGfmf5j9hWDVW8E/ak7CqOStAI3ycd3DhbOAgw
         h7VnKuBzYuInF9MZ6lerT0gzlGyigSg922jjTLjK2nZ4Ywrl7jP/gYffkeaTeFbpVonP
         /bfin4p9WTqz3Xdz0bQ0p4aToke1ELyCtHAgFLMyqss3ujxnIhjvoUIHNwfDL8lYYuYy
         RUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634415; x=1741239215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynkJy/ZeUoYmdFTVOPFkon+xQ74UuvAwMbGa9xWrZ1c=;
        b=w2Wd9W/DD20HfwCiVBacBDtdWm3LkZVIBaOPP9e+KduFwEUVw01BzLhKK6YzhkfW13
         0iRaIlMmDyiFTj92qM+DwKYRAZPMKvhiWUOkYkQRzNCeoqssOEUSR2RX6c2/pCjWi7GB
         BgQYV4RKOxVUh01KqhL1KLbOAIb5z+RzA8iX+nWergdMUQIkPijLGgkoLD2qjG84L0Rj
         ulG2t3gYd6oOVxw2csROFB1nFGH0t59BRHGLZclo/ilmupoH1nPYuuMMUTIlgYCay3nu
         cR7mbDlaaFOP0MO388Yj43b0geNJ2h0myv3qDGere5coGdW6eBnHLJePVNlx2UMgqkSJ
         OmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyRwxyo93f1gEimjrJEisVjfgLOUizADb9E48kkRa2MdfFOWA6b462JFfwM7NTOxMJHzt4mvs+AFkoqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/coPHsRMAqhlyZosv2qcxdJtwY7XGTqgB/suMz5qbjQFYLLY8
	MVCBpn7XUxNp6+0CFS2BWUq18bovo+tIWW/WpIbPuxYzsGfbWAWW6drxzXXVB8I=
X-Gm-Gg: ASbGnctoUMX/InSFR3ak+3fHP4nd9f1ECIqk9NFa4k8tEvLu1fs81EFAL6eYmqNj6el
	Sn3V8Mpb5YHWfganbG7mOcP3vULnl/sr2y9ZzMhpfilSiANe37aVlpXdOnlgavE/DrzWsdv9eVe
	+aWzd2KP+/mE6ys103lKFvhrtxMnU9JFhCf22F4eX+JkY2M/vS8vUC0vBPB+Hld5peIQG+8seWW
	Tppljtq0xJEcLj2ft5s5Tka9uxiw6tmONX2sHkGUeKaRJBOWtzrXsx1SPzK12wtZmYhRQ/AwxZh
	JZX56/atHXzE+4lr1B5i3bh4ZbimxlUyPCBInpMOyRc=
X-Google-Smtp-Source: AGHT+IEjBAyGaBvS29DmuA2osVvnDuT6cGrcQVmjktjAN3E9R4cvK/P8TFcT5Lc8y9NHKDMPZVdy/w==
X-Received: by 2002:a17:90a:d00d:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2fe68ada48emr15638269a91.13.1740634414700;
        Wed, 26 Feb 2025 21:33:34 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6753143sm582407a91.4.2025.02.26.21.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:33:34 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3 0/2 RESEND] update kselftest framework to check for required configs
Date: Thu, 27 Feb 2025 10:59:25 +0530
Message-ID: <20250227053322.114215-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kselftests does not have a generalised mechanism to skip
compilation and run tests when required kernel configuration options
are disabled.

This patch series adresses this issue by checking whether all required
configs from selftest/<test>/config are enabled in the current kernel

Siddharth Menon (2):
  selftests: Introduce script to validate required dependencies
  selftests/lib.mk: Introduce check to validate required dependencies

 .../testing/selftests/check_kselftest_deps.pl | 170 ++++++++++++++++++
 tools/testing/selftests/lib.mk                |  15 +-
 2 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/check_kselftest_deps.pl

-- 
2.48.1


