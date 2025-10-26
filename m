Return-Path: <linux-kselftest+bounces-44065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A1C0A5BB
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B394E5A04
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED60274FD0;
	Sun, 26 Oct 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkQKIbN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DC35B150
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472878; cv=none; b=KCDIM4icj+JnTmiymzIV1SYNSKX40QXkPo5XZYS1iIZXc7nEJkmgs4eQ9eYILw91P+VoS9lcWA/+Casx193WyoiuQ+0Ri6tddTe5WHhObx+SJx1vEJGmi0WOkHe7cp2HjtVrQykuWfYedtymFPGsXTvD0z+lb49v7efGkadHLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472878; c=relaxed/simple;
	bh=7KD5dGgax9bTmRFpWBp6doF76wbbIxJPMbGDcdBfxus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq4xRI8dgTpg7rFPMRUcjJvOVfHbTanw8zK89X7owCFRbjft/5A4JYIMncaczp1Skcf86z+9APkonJ8hW9bKHqg36DFCQtaAKkzgw1iCaLjgQM+yiX763br5fm0pnzD53KMYfNesTcckMoakuZ9UFXE6L+jsLqOyhLcINsZdAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkQKIbN0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-292fd52d527so37107415ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472875; x=1762077675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RfGStvJcl4TjNSGKHIZE9j5tm2qV6cEHrkxmBAThP0=;
        b=QkQKIbN0k/9rTMbSZPy21PHzbhewJKcThqGeNCas8ByZ8//PVoid9TkVxc0Wvlb35O
         0W9ZxXl2JrUF5Z1ueincG0OqbgM+8X+IyGeDGgePlj2cgEs/SdCAxK3+crUC9FoZbJzK
         byhmKxb7bfuLxVCt4EBC31QAEDRO4W88AsxUDftEH7mGfKLkSIEd8nDIfKDgiB8bjea1
         FHqASKbSjI6aQ9aIgENVURW+b5CuogJTF9fCA6JzWWdIOssF6whmzGLYkhS6Qy0F9Nxs
         FchEZ0Kvo8NRAMnhN14jZMIgQokQ03PfnptANDDLVuanQfEwY7W9W/4uosaQ/bCpL2Z9
         mJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472875; x=1762077675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RfGStvJcl4TjNSGKHIZE9j5tm2qV6cEHrkxmBAThP0=;
        b=e3HDLpkXXBSMNRujurdtDy+0Rw/6U3rpvI5ERhlwmBMfpffajxDZBlZ0xfjAXCqxrl
         8PS20+Lk20G8EAFzgWwrili1v1cpJPq3cKODGCyGWUJK/yiaUmSOx0dwn6YpWH65l7nW
         ByezGBplXspnJ8z5U7CjmBxtF1lacGX/Pji4lJHGWkXGz1r8YD1hdT3ydnWjt0ef04xd
         aXaq4FB9v47/gMN4jiRPIW2s0UDH3SleSqlq7L5Vxe7s8bkzgJynjglLWn3MzwWswt/A
         MfnIaBuntzhKs9rqvBorDPRd0rAfhAldJfwgiXD0zECZXsPN8ebsQMhBV6SJyNlhpPC2
         ERcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdg01WooTPUkkz82r/X0J9xP1nt7lGgMHolQdvAd7KkmXuqwigKQUbVNbMnqlTQzRPDzeu6Ec0O0Iz5bj8bK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf6k6pXbLYJd1c1TMdh79lfx1Q8PSB/DGlVNYrKxS8RZXV4ei
	Uqc62+E1neZi2S1NRZvejLO2aQo/tsi272HdkXj/YgEG2cbwgf/KcleS
X-Gm-Gg: ASbGncuk0t8T/YytHoTc87E/1kmgwDCu638P3SEhpJy0QBM6ZCPGdnhp7vVICcsUw/R
	GwKYyp3RmIICSQ3BFcJnI8UGOZh6KmbVpr/1q5c0n2riTFRCYKWt+bs4NY2c5NFNX+rki/V1lfP
	KcfFDE/2cVUsa15mHirEBq2u6946SDmQ/SoAaRCyWyp933HRg0180pmUfLyrWSFDh6XQBjnqUcK
	l2E7oEVmIoCIKeEpsu1+5Svo5X7fV4TF7u6w3B4OiJdhMMS7nhJiRAj5w7Yg+vx6jL0ZhCpduQd
	4SRp6w3rQJ83mB8CUXek0x/rCYVGefMJcAhgJwqYYZgOXKBKkYQ1kyRay8jGpLcDOvBy0jFt3DA
	x/ci7K6ICXk+mHHgGMa7Wc9Wh8ay86TV8bYaUrbDbdbkS2tX32tpfpsGASKHzcBezDnxPRDf+3y
	2TuqeNaxzAEOl+KXFbh5k=
X-Google-Smtp-Source: AGHT+IFKNOKTau/QQRGqY0zzzctIn/ja6Be2Y4OB0k/nayMvBEyR1iUbx77eiYu6XXPZj9O6THlOLQ==
X-Received: by 2002:a17:903:2f05:b0:275:f156:965c with SMTP id d9443c01a7336-2948ba5ae75mr89132875ad.52.1761472874942;
        Sun, 26 Oct 2025 03:01:14 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d099b6sm45719905ad.33.2025.10.26.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:01:14 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com,
	xandfury@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v3] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 15:30:25 +0530
Message-ID: <20251026100104.3354-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102634-relive-glutinous-df0c@gregkh>
References: <2025102634-relive-glutinous-df0c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Fixes: 7553f5173ec3 ("selftests/tty: add TIOCSTI test suite")
Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
v3:
- Add fixes tag as suggested by Greg KH.
v2:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


