Return-Path: <linux-kselftest+bounces-27164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8CA3F673
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9BF8631C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913C20B210;
	Fri, 21 Feb 2025 13:52:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774E20B1EE;
	Fri, 21 Feb 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145938; cv=none; b=pjUbYmScS5SRX1Mk0SFt+P9pUIzjcKi8zHRWTGcNO7hiD43aVB8VE2PJafSRXd1qm2hG0onnlKTCxySboYxyVbrbf6u97/hYcbfditaCgqpByOQjp//UgkixjD52XUWuBiMPcLXpNZ02Z7rlnhP4FCroKDD3uHGWLz5VyF8qwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145938; c=relaxed/simple;
	bh=KNyRJ5gPHfOGhVm0BSRcfzsZfkbzWBQYKqTFFX+aN1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jWNAD7ayYWtVgJXTsLAv/n5dRzKr6IwcqEmNguvfuubmxX5YAevVElO5snTwJDwHM76mGfV1CE4Mdg+wSTRvtRdgzll1E5T36TVRHHagoJMMYPQUdQFjAKcbjAQasEVTgGIhtWvgYDNlUB20Z6krGqBN6KeYSgK/og5EDpSDyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so3566597a12.1;
        Fri, 21 Feb 2025 05:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145935; x=1740750735;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3oFKAHX+y7IXkxMkoz08VOctLMaAIQOwDYtmMeUUrk=;
        b=OrD9sonN9hQKfRMj5fLN99Wr95/CYHrkLWsJWALMCUmjH6MF+tBbho7AAJiGSVwnPR
         BDJFSATbHsZpngxgFvCVmukhByR6d2h68Ryf/K85FMbWpg828MZQRHcACyls9T7h5t7G
         +LadwsMw8IENNYRinbjpRlGQbxKsZ4EYbpM5OU58YTSw2R5Adz/yzK3eRY3wN2B/BT++
         zVzJHhvoInspF1EUOZS86C9yovLWHkd9GBFVcycPR4h1ewX3pZQOCLiFmoyKcErY34bb
         CmxKyKqjj9rDb+ComQAuvNfen/PWgX8FsxmMMkqJJ2BSXhas50HGjofHd4Fuykeg0Rgb
         A6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsNQwqyTg+V9EPHgV/z42X6K4mxYQZkeS89XUmVuwB/KmUjmdIXTF33ORZB9mAq8jzelN9awqq4g21XTT3@vger.kernel.org, AJvYcCWvfUABxFBe6TSfdjAu05wZximRXX8ZAr5wHJXrZwjAZEYsy/MSw75noUK3cz6OXp1TTvp7MfSHxrtBQYsE8iJN@vger.kernel.org, AJvYcCX4rEkW/7gAs5WGZkNO0F+52gDmmW/VPPKLGp7YWdl/yLKrlVn1PPJBPO5QgW8D6F9Y/MORYn9mjGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEbLdP4B0ODjZuhTyIW+ptlR/85RjJqFKqS5vVrBEZDpE+9qa
	Kn1N2pIqM6MZtanP6tprN0626xI5v5LkXpiZ7t+zj2LQpnaCEPqCrAgXvQ==
X-Gm-Gg: ASbGncuAd7cEknIEubxuEqBd+g1RVXQAvuDtEgRtL3kP0eMshxo7gHKIkgsBszG8ltc
	fTxr0jwHD4SzEgVE4MbrqJawHc36AYlvCHHcuxBbZyDvGKqWWz+raLHxsJg049r5xtU4fMhuqAY
	MGJfXQK5l3xq7zxqhRPCar7waev0LAA28anixsgruKzccaNLDND9SXd5STTWsq9N/2AROzo6IjA
	g0uQHvqlUthlYZG8PGuKCjpNY5YdAaDpBKA4U5CLQlXTbx2s2wFWz/gqwgpM63bCyqJApuo2sYl
	mIQpq5NunYiFRmPn
X-Google-Smtp-Source: AGHT+IFa7iRLy/hgX1BmFYjDm4LnPVjvrh/qouy0nlzcXeQk/glGT1aFhCh7Oy0oarhJdx5Q5Y9XqQ==
X-Received: by 2002:a17:907:2d14:b0:abb:feb0:547c with SMTP id a640c23a62f3a-abc09e38f64mr311411666b.51.1740145934323;
        Fri, 21 Feb 2025 05:52:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323225fsm1646605366b.24.2025.02.21.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:52:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/7] netconsole: Add taskname sysdata support
Date: Fri, 21 Feb 2025 05:52:05 -0800
Message-Id: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWFuGcC/z3NQQqDMBBA0auEWRvQkajkKkUkTcZ2Fh3bJAZBv
 HtpK11/eH+HRJEpgVU7RCqceBGwqqkU+LuTG2kOYBVgjabGptdC2S+SJr/GSJI1+q41szNXCg4
 qBc9IM29f8QJCWQttGcZfifRaOXE+8/9g1enjxw9UEj80miFg6HBoemNLC+NxvAFS9ibKrwAAA
 A==
X-Change-ID: 20250217-netcons_current-2c635fa5beda
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=leitao@debian.org;
 h=from:subject:message-id; bh=KNyRJ5gPHfOGhVm0BSRcfzsZfkbzWBQYKqTFFX+aN1E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuIUMuvyHww9/83zLB/3J7lliuhDrECh6+YQMA
 HyDbAQ3F3SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7iFDAAKCRA1o5Of/Hh3
 bcwYD/9XZxrNdkpAp5bo4apGu8GIx/ziwjEtvxWilweM8ZgP5c5C9tHfsKFZpd1pmHL8SoQZaLG
 vhRlS8VuQSInsv/6gX7hzfvscmfZA9BdZDvnsvwfNj+bAzDSNk5Wnwp+O13ThDcjdtQUtCUJ2jK
 abPZJ6hYYY9O5fhOnWUe0wihT0IBNkHbIFnwATI7L9j4jK2VI0R5XjocG+qKV9gGTCBQuEFrToR
 fdjadTkBEPJ/ukIbbr7PjqvW306kfdH8J7TbuTe+3UUhXn4IuZERdiraPWu82en6YAWtu8QecVl
 pyqUv1N4wvI3wYpPpl9nTFuwAwYfqzM9oA+8TiKgwgiBIZVUj4raRl+UtpCawGkmGqNZAzzqqJP
 7jmfKnVRP4c9z1Mhdq7JVbia8Hpm6sa82Dw0org8O6Jfht0O967sjmx6ymRFucAngifEEPkU7BE
 CPAR+f8zrJsapCirWm3PMVTLoIBQYBTA8lJtBgAN8BIttmdgTS6wDMAzO4iD7L5nubeyA8mXCyT
 61eE9hNAYZUAl6VE55u7nyCWFlXBfoiFNmELea+a1P0SG683bRe6P8nQORwCPfPZhQ7aBun2jmI
 pe5uWN1quZuyifIk/bOkhnLH8s2DZuxT2HwsiP4Qi4p53BI88ABRGE85zDUBP9X+KnZBPJyHCVH
 TqFCrjCMrCthPeQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new feature to the netconsole extradata
subsystem that enables the inclusion of the current task's name in the
sysdata output of netconsole messages.

This enhancement is particularly valuable for large-scale deployments,
such as Meta's, where netconsole collects messages from millions of
servers and stores them in a data warehouse for analysis. Engineers
often rely on these messages to investigate issues and assess kernel
health.

One common challenge we face is determining the context in which
a particular message was generated. By including the task name
(task->comm) with each message, this feature provides a direct answer to
the frequently asked question: "What was running when this message was
generated?"

This added context will significantly improve our ability to diagnose
and troubleshoot issues, making it easier to interpret output of
netconsole.

The patchset consists of seven patches that implement the following changes:

 * Refactor CPU number formatting into a separate function
 * Prefix CPU_NR sysdata feature with SYSDATA_
 * Add configfs controls for taskname sysdata feature
 * Add taskname to extradata entry count
 * Add support for including task name in netconsole's extra data output
 * Document the task name feature in Documentation/networking/netconsole.rst
 * Add test coverage for the task name feature to the existing sysdata selftest script

These changes allow users to enable or disable the task name feature via
configfs and provide additional context for kernel messages by showing
which task generated each console message.

I have tested these patches on some servers and they seem to work as
expected.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (7):
      netconsole: prefix CPU_NR sysdata feature with SYSDATA_
      netconsole: refactor CPU number formatting into separate function
      netconsole: add taskname to extradata entry count
      netconsole: add configfs controls for taskname sysdata feature
      netconsole: add task name to extra data fields
      netconsole: docs: document the task name feature
      netconsole: selftest: add task name append testing

 Documentation/networking/netconsole.rst            | 28 +++++++
 drivers/net/netconsole.c                           | 98 ++++++++++++++++++----
 .../selftests/drivers/net/netcons_sysdata.sh       | 51 +++++++++--
 3 files changed, 156 insertions(+), 21 deletions(-)
---
base-commit: bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
change-id: 20250217-netcons_current-2c635fa5beda
prerequisite-change-id: 20250212-netdevsim-258d2d628175:v3
prerequisite-patch-id: 4ecfdbc58dd599d2358655e4ad742cbb9dde39f3

Best regards,
-- 
Breno Leitao <leitao@debian.org>


