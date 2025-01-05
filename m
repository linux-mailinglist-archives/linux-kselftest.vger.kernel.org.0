Return-Path: <linux-kselftest+bounces-23915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE599A018AA
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AB0161C58
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE1130499;
	Sun,  5 Jan 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsDyFWEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471057C93
	for <linux-kselftest@vger.kernel.org>; Sun,  5 Jan 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066540; cv=none; b=OEaazDFHKlJf1ayqIK79zkFMfHkOUDQf8aUJfkHr4hX5HcsC5iUTowrfhGwSTEkxpBT7sUCypHm3dDH8ljdz+K/oTz3zMhl386T1aby0b9hrC78A98k0oMh7VbA0dmjktI/dxUV1Ueh7gUMKeaZzM5T9JYhKTWqTkbhA/6YSJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066540; c=relaxed/simple;
	bh=7L9ByarG82VQIQZiqcsiZ5vKOMJLdlSkWqoCUexnngQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mcN/nE8AkEUyrqhEXWGopUDz/OFLSMWV6n+dK3SMlqncXAsumvzvQl4AJaQ+BEFZC5XbFOqw62RVA16Ap0Ke+bkt1Et5IUufEqL7GcusD4Bi6gtrPjauoitbt19nCc2TnXZT2lWLGI3EUsL45sZqyme01WR2hM0t0tDZRm2r728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsDyFWEL; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5189105c5f5so7067580e0c.0
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Jan 2025 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736066537; x=1736671337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2slI3HZOfX662CqU+CyvEyDvwQcyKSthqjp9QTlo934=;
        b=NsDyFWELysV/cPIrOaJYHEbaur63KwOQCrh6JQuo2DjdYNu9AWHYJulJ4Dczcz/wB6
         kv5Q/k5rp8+cCiOU6Rpijlnq20gLm92a6v5ty5FXGuPKW4EHaJTw0cX//QCCGcWZ5MXP
         6CIWT0tQjLpx3OqhCEIwgL1eVa+F1TOC6KWsCsmJX/1qLLQYZdGgbSobb1xVcnzWBXCR
         rINODSaNX3xNx/rdhe2891KfhfnC+QfwHDVP+L9QgwJYBgjBD3HXEFxR7vqGFOEDNsxn
         31Rq3wP/iut4E65E2LGBGPs9tKRvnI6235G0IJ5J+Qbj8PM460WckfevNyWzUjvUreTK
         ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736066537; x=1736671337;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2slI3HZOfX662CqU+CyvEyDvwQcyKSthqjp9QTlo934=;
        b=Nzm/4WMrONiqhkn0rUKNMBGGZU21HdPuRH9j8Od9om7Y+Oobg/kpI02dFkKWP3P/7B
         fYIaqbpklclgJiRwe3QQHU5fKGFn0ohnAaTGGkGLZZnO6lrmTYEc4Z/OLE8c8Df5L6Li
         xx23YiaiTxNtOA5MaxYC3vKL+6Ffc93GNeLeHfReX+pGLDyL3kfq+343aZ5ro2Hh8PTT
         2OEpbGBcPgAyy0mcamHfSwv1nz307aUk0pMyeio8g9wEO4lUt61IPy7fJ8b3XnbXLiNH
         61y30EqeD5ID8ET6f0+k5jsikc+Kjgc1vFXiTB8kPH3JxH3S/wLiOAxk1wBDFqOJry7x
         uE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSTQkXex4FmFGkuZm9CjwmlwgUwjdrj/TbL74ctvg608fB0xF70NSdVnbiL5Gs+AcF6MpguLQBjVVv4lD+PBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+5iBaBuby1GvnqGBhxJecVqs6VqliXchN3SJ9CVf1MdLhWNr
	upTYg55W+DqiukguZ14O2LVf1hzhO055JWPamDIakBqs/gtqj3QTwXSUZj71GBpGIsqKH3hwoG9
	1ngJbdaQ/LGWwmUwuXPgrEegC1XC3bQJMFKxC3g==
X-Gm-Gg: ASbGncv/cEkqRNwydMfOp9c5ze0XuF8qPVP3X1Fgyf3rSJUa1hDGabzRfXMvn+lk4wS
	2goXrY8kkH5LLA+a03LQBfZJBg5EAeMKGADSktLI=
X-Google-Smtp-Source: AGHT+IESZBYT1KgJtkzvY6N5m3b7nV5aJaVfVbLNS6I6Vq/LSvI4synW71xSLKVBpAoNRau1qyzEQpTF5JucTdwNPKU=
X-Received: by 2002:a05:6122:8c15:b0:518:9582:dba2 with SMTP id
 71dfb90a1353d-51b75d67f88mr37948743e0c.10.1736066537136; Sun, 05 Jan 2025
 00:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 5 Jan 2025 14:12:05 +0530
Message-ID: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
Subject: rust/kernel/lib.rs:17:12 : warning: the feature `new_uninit` has been
 stable since 1.82.0 and no longer requires an attribute to enable
To: open list <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Sasha Levin <sashal@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following kselftest rust builds failed on sashal/linus-next.git
due to following build warnings / errors.

Good: 829d8581c398a96deea1d6bc78578950347dcbec
Bad:   b2d472701a703596889c3fd067fd8929aeffc4be

Build error:
--------------
warning: the feature `new_uninit` has been stable since 1.82.0 and no
longer requires an attribute to enable
  --> /rust/kernel/lib.rs:17:12
   |
17 | #![feature(new_uninit)]
   |            ^^^^^^^^^^
   |
   = note: `#[warn(stable_features)]` on by default

error[E0658]: use of unstable library feature 'box_uninit_write'
  --> /rust/kernel/alloc/box_ext.rs:41:12
   |
41 |         Ok(Box::write(b, x))
   |            ^^^^^^^^^^
   |
   = note: see issue #129397
<https://github.com/rust-lang/rust/issues/129397> for more information
   = help: add `#![feature(box_uninit_write)]` to the crate attributes to enable
   = note: this compiler was built on 2024-11-26; consider upgrading
it if it is out of date

error: aborting due to 1 previous error; 1 warning emitted

For more information about this error, try `rustc --explain E0658`.
make[3]: *** [/rust/Makefile:425: rust/kernel.o] Error 1

Links:
-------
 - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-rc4-6237-gb2d472701a70/testrun/26563483/suite/build/test/rustgcc-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-rc4-6237-gb2d472701a70/testrun/26563483/suite/build/test/rustgcc-lkftconfig-kselftest/history/
 - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-rc4-6237-gb2d472701a70/testrun/26563483/suite/build/test/rustgcc-lkftconfig-kselftest/details/

metadata:
----
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2rByIOiC9ssqI7NjEPY7IcRs8SN/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2rByIOiC9ssqI7NjEPY7IcRs8SN/
  toolchain: rustgcc
  compiler: 'name': 'gcc', 'version': '14', 'version_full': 'gcc
(Debian 14.2.0-8) 14.2.0'
  config: rustgcc-lkftconfig-kselftest
  arch: arm64


 --
Linaro LKFT
https://lkft.linaro.org

