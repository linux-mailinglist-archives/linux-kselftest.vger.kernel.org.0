Return-Path: <linux-kselftest+bounces-27894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C492A499D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C23188D9FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7A026AABD;
	Fri, 28 Feb 2025 12:50:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCF24169E;
	Fri, 28 Feb 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747045; cv=none; b=gZ36iCSClQhS1UID7mljfKj3BBifBCW6TORzc/aT4SYLqhQOvXnuBf820a6SVauL6pEgAccnQcVy8fPIMlIxrerj7zZ7d+YKyuB9FXq8I7JGveuo84zuZ7I5SEtWsyIjk3xHRQJZnDXedVUyfuTVKPVvb1BTy9xrBoKrINLDUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747045; c=relaxed/simple;
	bh=EuNVp8z3++mrhPK2m1ue9Hk3T3UfhFDPlzWASwctmxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e/nvbYsgSS6glRRCkEHKMZPBhhyCSOKwDGBLsxPIpnK/Bf2xWX7GtJSyVbvYKtyJ9bBCvcwVldJs+NQfxParE0UYim6tkt9WdTuOSB0JlBh8NolY/mIoDqikxpdGHP0VrsWu/zwAYN2kIsAwhPX8jVzBS850PqpxutY2A6oljEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so3917508a12.0;
        Fri, 28 Feb 2025 04:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747042; x=1741351842;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQCVjtAdGYLZyDRajofcdbb+AJ1lQTIhLgamy1ixjjs=;
        b=qQRuKw8374gsACUWxrrWzxn3SlwQ72OWNPno1cXaPQ9ZjvOroc42MxRfN7s08EMc1u
         b6LbtHV6aQbVdJpT7V5dt/jkTXGr9am8DLkpY4qR3WMo0lzNqNBnkkiUc6Z6WdamF8uw
         njvGYDQ14nNqcMV5Gy6F3yOsmFmi6A20hXZLTOXWdhJulyzDQwxognXmOhiy+FnqzM2Z
         sIBqwod4E6QiswvB40KtAgLWUieEa1cg17kpORNqfkothFR1AZEgOX/9aAfFU+B9Ixr3
         ZmC0w7aQTtYKCVYcsxEDX8TJ78xjqOr2U+3TJewgIY9NcHJmzOUklnF/V/em4/6nDpY5
         e9uw==
X-Forwarded-Encrypted: i=1; AJvYcCUlC7NTZIdEHOTxwuq+dV9EHvqkQgE0b9LaAyPD6zcYUQKH0rmfOYlMF2voIYqizmNPENwAFBOloJ8=@vger.kernel.org, AJvYcCUuh5pqt4kxj1+rJxh+Oz73sp0JMWOyLErwNN1QHpm2kAK2hPlt/dpTFj4xA3SXebsDpMch7c2Zqbfr8NyL@vger.kernel.org, AJvYcCWtifDc7IV31v0gFkD+/lT1tT8cc4nnkCRB62KidDLhN+Xvq/UauqIO/cVOeoojcS+U6mWCKsu5dZFONHgOoE3L@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dKTI2XIymnrY74RgrP+CuidyZsqogkH2Bt7mO0jTABtyJr5G
	Z40yySYyVXla3qaf7WyexNDI+UNARRfVfaaaErsjTpupPt4FaIbC
X-Gm-Gg: ASbGncui/x8Fk0obilRuYqrsjTmZaYh5bddFAfRe3U/kabhOrkKvzBq4O6DhkjJ95DF
	D82dadUnD+L+ceCPMV+lBeI3jHvIKqICXtLxojfgv4UJ7pgS3Q27mX6QpeMRhMVPPIeg+KoAa1y
	qeSUzD3IkcNpqh6TOdAc0M9bh7w2KzGJGqwznTd0balDXpUNt64OYU02fdX1z1y8UG42Ivko7os
	zogmGpM1DWMz3g9hE428HxbM9nnJGudKfxk0Jvxx1latvVN82aDCLuT0GA+VrF26tcu2iaXDcSP
	fwXesSgTEXNLsFYn
X-Google-Smtp-Source: AGHT+IGBbena9+3YSHkdWVzW2Tn6scWunoqaZEb2ntm63xsfQ8TO5zZbm2rTPlnx0XgNg5RDpDfV7A==
X-Received: by 2002:a05:6402:354c:b0:5e0:8a34:3b5c with SMTP id 4fb4d7f45d1cf-5e4d51fef15mr3114383a12.0.1740747041391;
        Fri, 28 Feb 2025 04:50:41 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb610dsm2408227a12.58.2025.02.28.04.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:50:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/8] netconsole: Add taskname sysdata support
Date: Fri, 28 Feb 2025 04:50:16 -0800
Message-Id: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAmxwWcC/2XOwQrCMBAE0F8JezbSrKSWnPwPKZImW92DqSZpU
 Er/XWyLF8/DvJkJEkWmBEZMEKlw4iGAEbgT4G42XEmyByMAK9QVqqMMlN0Q0sWNMVLIEl190L3
 VHXkLOwGPSD2/FvEMgbIM9MrQrkmk58iJ8xb/FozYfPz6nkriu0TdePQ1NuqoTTksxo1THuJ7u
 VvUgqxNVH/PipKVROWa2lLTu8qfPHVsw36IV2jnef4AoUdL2P0AAAA=
X-Change-ID: 20250217-netcons_current-2c635fa5beda
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=leitao@debian.org;
 h=from:subject:message-id; bh=EuNVp8z3++mrhPK2m1ue9Hk3T3UfhFDPlzWASwctmxg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwbEes1NS7ZqTroFBCIkT12YMSfLfW/KqcMrJv
 i3j8FEfcbaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8GxHgAKCRA1o5Of/Hh3
 bTtLD/wM3An0Eeu/qJwa4dQL5xpKBvUZRqV3xnVlumZOL2u7r85RQdEgCcalYPkbQcypMQFgeKn
 EUikyn+8OBd3bVckxIbc7zT45gDXpB0ykgPBhqBAUFoNoGUOU430M11COdsXkuQyGxoOnJKrxHL
 /gMxuFIOVEoJl4auDjSHxUHpYD8SExXfzxjSgOtaHzzv9HMX99GBU6TYmQ37QZYOTqmuMYvs+Id
 LLX1GN9oAG6E6hDuTui6kkfSAh2l4mJlkBHwrsSE0grwJXC6/5ZVX9bQ8AIUsOCsuoQVnZgCwQP
 ZSgKlLnUap1io1M01XvfgQ7rwlbDOw7d8Q+ZTmX3VH0wJlUusVH0/EqS7E9WiuWwuvfo2KEc10m
 c3UKFiR1KJ/pjLMIHfyOO5eH7l/2hVQnDwqFCDqmXVAyilW3dt45mGwTC2iAjl4qb5j2uaHQqDN
 9bBvQO6BX43xWx/yZU+/kfoIVg9R/7SXAr9EP7Qa8/G0+lPkk9QaD12FRQ2Lefqlqq32t5xrwN6
 hNvcEoqVrFpPNi1QdpUcvl9sO5+0LAVWDzDmBdmNGy3l+5hIUe3HHCp2jvRyWGhE/sZ8Yh5Adnl
 9jorHzDFjnxPKLq+oIwr13uHMLM82KiA+hMMKBq/ABKhaZiemnuZGsh2i2DnvwZBEeLSqcuRGdb
 xfVGrL5rDrqzD7A==
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
 * Patch to covert a bitwise operation into boolean
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
Changes in v2:
- Add an extra patch to convert the comparison more stable. (Paolo)
- Changed the argument of a function (Simon)
- Removed the warn on `current == NULLL` since it shouldn't be the case.
  (Simon and Paolo)
- Link to v1: https://lore.kernel.org/r/20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org

---
Breno Leitao (8):
      netconsole: prefix CPU_NR sysdata feature with SYSDATA_
      netconsole: Make boolean comparison consistent
      netconsole: refactor CPU number formatting into separate function
      netconsole: add taskname to extradata entry count
      netconsole: add configfs controls for taskname sysdata feature
      netconsole: add task name to extra data fields
      netconsole: docs: document the task name feature
      netconsole: selftest: add task name append testing

 Documentation/networking/netconsole.rst            | 28 +++++++
 drivers/net/netconsole.c                           | 95 ++++++++++++++++++----
 .../selftests/drivers/net/netcons_sysdata.sh       | 51 ++++++++++--
 3 files changed, 153 insertions(+), 21 deletions(-)
---
base-commit: 56794b5862c5a9aefcf2b703257c6fb93f76573e
change-id: 20250217-netcons_current-2c635fa5beda
prerequisite-change-id: 20250212-netdevsim-258d2d628175:v3
prerequisite-patch-id: 4ecfdbc58dd599d2358655e4ad742cbb9dde39f3

Best regards,
-- 
Breno Leitao <leitao@debian.org>


