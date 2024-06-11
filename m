Return-Path: <linux-kselftest+bounces-11640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A1902F35
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 05:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2C71F233CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 03:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3E16F90A;
	Tue, 11 Jun 2024 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJmJ0s1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62313D615
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077749; cv=none; b=qJG41xvkUYOmDiODciHRzEDCf1lRUWUnk4i8dfLaktBK0UP9HaI1v8T3h5mHI3Jxv7RfU6iNrssB0sHVG4Rbq47Ks4NK51rM0MEF7AzLDELl6Mi54Ebmt/YNNeU8vGHNYHt/G0q22mVL+3GAkzxSTkvYk2FmHgFT/m8lJ7n6oFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077749; c=relaxed/simple;
	bh=mvTHHduyDyQDcSxw/5hAysI9ob7z1i3HgWonMeyK0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT+LqAeAEOr2XUR23fho2gDyu0lTiIZKtGnYO+SayNv3ClTeSoSQbBeYDSoHJo7+tKmDGofAAANHbY02cPiSqpUd3ieyHcjGoi51875YFTq6yC3JF0OAsq1Pc/iLlKKV2hPMHOOhlvDzT8klLieM2qN3pOqQ6uBySebr8hjvk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aJmJ0s1n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so38552285ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718077747; x=1718682547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbet/qCsm/2TCPHjObU4qdEEAftnzY0yLDlxMiRcwWc=;
        b=aJmJ0s1nNCfok8MN5htb3ghFfug89AbR6nQZ3dodzgMbQzYF14rEzCz0ZHUiLP8bUR
         AfvBPAozQFav9HDj2Gz5iKDBFyBCrlhiLbZ6i3ZPQ9cHgYUgvHnv5W1fa2zKIpwwmScc
         hrosDXehtUM5lw1lQ7AkQfi8BGOVgsm7bsf9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077747; x=1718682547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbet/qCsm/2TCPHjObU4qdEEAftnzY0yLDlxMiRcwWc=;
        b=qlxUwwxUvty5dVmeXTqkF2FaXvqxSsjH9j/F/492jsgxB/CLw325Pz3B8742gaUNox
         nFcEnAuW50a/PL8B4CcquO3ruYFCJz7YRZ2RW89007ppm2OwfWh5Ry3FNNWs8fsPON/K
         sUMb5ObgG/Fj19JPDExpCOQt7P8Cbr0yapGHqSCyR0y5091z0MsMN1q54eNOLLMfHSAk
         VKKzJ7J3qPD33cIeWVFJPSiQs+xowezlaP6iSLpuzObgfXnct8bM01VQJd/U7c1HUkO8
         mYVXykZyvqkTox6JpZj4bFVH9xqkWW7n5ik9CjjG21yvG+DPeUEYfFnazqjPomvszcPl
         EPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVba+gebTwDL/AZhkPzPEZiINJ+4zgSpiBLG85n9XruMtqbmKNhxvZ83e6RinLm3BEKo8yMRCY3QnV7YFTYsA3sSbbQ7/thbtlzccDz+Yvi
X-Gm-Message-State: AOJu0YwDyuQzb60BUEs7m3Siaby7GdYnB7F1lZRCzqmkICvezfAjpdNW
	eXqqOmJiO9//LN6HtHA57c3SzOOio2BbiakxGLnwkJ6WnfZkr2K26nPnCoETBA==
X-Google-Smtp-Source: AGHT+IHc486Sh9GK7vNVE/HuV4p1o7cMvnyauzgMICmENuV9dbEIiRZJ2+tr8DYeGg7g0SkFrMxJuw==
X-Received: by 2002:a17:902:a617:b0:1f7:1b42:42f3 with SMTP id d9443c01a7336-1f7287bc2a5mr14848415ad.18.1718077747267;
        Mon, 10 Jun 2024 20:49:07 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6bd7e05d4sm90373605ad.191.2024.06.10.20.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 20:49:06 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
Date: Tue, 11 Jun 2024 03:49:00 +0000
Message-ID: <20240611034903.3456796-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
didn't have proper documentation. This led to a lot of confusion,
especially about whether or not memfd created with the MFD_NOEXEC_SEAL
flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
MFD_ALLOW_SEALING to be sealable, so it's a fair question.

As one might have noticed, unlike other flags in memfd_create,
MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
is to make it easier to use memfd in the most common way, which is
NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
vm.noexec to help existing applications move to a more secure way of
using memfd.

Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
Those are based on the viewpoint that each flag is an atomic unit,
which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
designed with the intent of promoting the most secure method of using
memfd, therefore a combination of multiple functionalities into one
bit.

Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
year, and multiple applications and distributions have backported and
utilized it. Altering ABI now presents a degree of risk and may lead
to disruption.

MFD_NOEXEC_SEAL is a new flag, and applications must change their code
to use it. There is no backward compatibility problem.

When sysctl vm.noexec == 1 or 2, applications that don't set
MFD_NOEXEC_SEAL or MFD_EXEC will get MFD_NOEXEC_SEAL memfd. And
old-application might break, that is by-design, in such a system
vm.noexec = 0 shall be used. Also no backward compatibility problem.

I propose to include this documentation patch to assist in clarifying
the semantics of MFD_NOEXEC_SEAL, thereby preventing any potential
future confusion.

This patch supersede previous patch which is trying different
direction [3], and please remove [2] from mm-unstable branch when
applying this patch.

Finally, I would like to express my gratitude to David Rheinsberg and
Barnabás Pőcze for initiating the discussion on the topic of sealability.

[1]
https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/

[2] 
https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/

[3]
https://lore.kernel.org/lkml/20240524033933.135049-1-jeffxu@google.com/

v2:
Update according to Randy Dunlap' comments.

v1:
https://lore.kernel.org/linux-mm/20240607203543.2151433-1-jeffxu@google.com/


Jeff Xu (1):
  mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.2.505.gda0bf45e8d-goog


