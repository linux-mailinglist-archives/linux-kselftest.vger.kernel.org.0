Return-Path: <linux-kselftest+bounces-23818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F989FF7C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 11:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62FD1622F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4171917C2;
	Thu,  2 Jan 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqNh6hrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909C28E3F;
	Thu,  2 Jan 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812312; cv=none; b=EwAitwhVA/wAaQsI4HQHTWjByQzFMv5RPe+HKn5+KdUzg8gX+ggf1OlguXTPBfu7LxP08yOXShX6orkMKs2wTMm27rrW4+wlGlob38EY8348nEAKjgJh/OsxB9l2+rH7uJ0NdKmGKAZ5uyykIlZ4piEkcv0BV7f9BEsO/pnoxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812312; c=relaxed/simple;
	bh=UdX+LC8QFkqFPOsSGfkOypZVYpzRKThjF0BkpSFJizs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ublzNmH6C7xInhG0/0AbZWDvz2Nul87VrL+uEbYG7DiUFrxLhBfUaihNiWFSRbk0L5HFWtECmKpFYNckztHg2Du1s5hz57z2BOaR3KTOgCgPndcSSn1pjmd2z6Zx8/jglkQYJQSDrrgxz2/vfYra+d+Jrw9DuDTNlcZtckZ0tsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqNh6hrZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21683192bf9so151691395ad.3;
        Thu, 02 Jan 2025 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735812310; x=1736417110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIpUJOUJ94ircpbugzOEHhzHO7GnbVjKN86XJtnxb1U=;
        b=FqNh6hrZ6Gm61wKSQJPdS2zVEtpJRNJpEFxsbpnZR+qm49s2rbxVVE+n+ntwpFABgO
         xhMvr0swzJDADIsohI/nKzxip1AnUeEnGkkiJFk8dJyWVCcCfAhfKp2147MNgh316T4W
         +514Te7O52NgYov4VDQIxZIhWmj+2TJMQq7BbOZtrQ5wJvfbWf3X3nTQ/y5x//vj8Ad1
         nfl/kGEuHf8XJofYHdLt1dUfJspiYJxjEL13UDrPCu/iPIobNq3/RJSEkagIo23nE1aN
         QCb8NIrZj8oSmg9L+ynH6DnWNn9QozkjcizzQLTpa4V9fTnZjg6sT9XvtyR2yxVvMZu+
         KQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735812310; x=1736417110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIpUJOUJ94ircpbugzOEHhzHO7GnbVjKN86XJtnxb1U=;
        b=wQEm56zKbOojjvHymhJL8IhYrw0ZH2VM8/EPaqwpweZoPtMF/UA8Snx6vlXoUJq0IY
         3PORClm/MPD9LAVet7rUvZiCLW2Dap0c546k7BfSZgKjPfqoZNXa3hetTLq3/h6oW+yS
         uSBNf2I6TkGHXuRSfNP0DQa/pdEVjWydbo+HrWyyoVOTppHslvy0lvg3dpolX69YYi2b
         1PxDBPaE4pm3SRpCSLHMua8t6htR3yPSCdp7HxN+MLb1+mjwUMFLvOLx90VOfLF3RUq+
         GdlL2l7b2CVWgWfu01u24yWQbOBCHWC5KqMRPaLbxa2U5n+WUTcwcYuAQT/jfmZ4N9Fb
         v5Og==
X-Forwarded-Encrypted: i=1; AJvYcCX6hEiPEWBMlGdZq7pLeULXa3jGdeoYtTjS2ihHnGNxrz5CHmkAUXdgDYcVr6neazt7FjXn3adwNq3EAwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwesTf2PJjda7KMTkja+ke3UGG+8/DV4FwckNAPeAcb7TmCLNEJ
	ucJF8Cl3M4drVn+9Me8BLnTCKljQjCyRVfUv16u7lbXqzA6IxPDy
X-Gm-Gg: ASbGncsObOdfAFfJ7phdxDylji459mqUb2V+1ehn99qUxOKsNOjxoO9OWYTzGk+pRKh
	Xhq5EclfTUE3wK8/E+UkTE9Uuq2CuYryWMkxMHH/7dlxAqrqIR0Tk96/pkmsvaNow+4vh3rpuzZ
	UKcJLxa5eDtIB37ko7l9jK8R/Z1FCr9sGbUbmG9yGXW26hL4p7PIfIUijH4/dbHcx4c+k2M1XTB
	3VWgXAI8tyBR0N6L+mIXh1+sghoWw0d2lk0BYPyn20gEl/9XQ8ggttXtvNsk9hDaGvoXA==
X-Google-Smtp-Source: AGHT+IGDqnOHMhef8ShtjH9773i0Iq3OXqnTW3FPVExKLsLrmajjLqQ1VN4+aXTx7gdPjvTwe62R4A==
X-Received: by 2002:a17:902:ce83:b0:216:5b8b:9062 with SMTP id d9443c01a7336-219e70dd21cmr676531455ad.54.1735812309666;
        Thu, 02 Jan 2025 02:05:09 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7457sm219759945ad.201.2025.01.02.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 02:05:09 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v7 0/2] selftests: tmpfs: Add kselftest support
Date: Thu,  2 Jan 2025 15:34:57 +0530
Message-Id: <20250102100459.1291426-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version 7 patch series replace direct error handling methods with ksft
macros, which provide better reporting.Currently, when the tmpfs test runs,
it does not display any output if it passes,and if it fails
(particularly when not run as root),it simply exits without any warning or
message.

This series of patch adds:

1. Add 'ksft_print_header()' and 'ksft_set_plan()'
   to structure test outputs more effectively.

2. skip if not run as root.

3. Replace direct error handling with 'ksft_test_result_*',
   macros for better reporting.

v6->v7:
         - Improve the handling of failure macros.
v6 v1: https://lore.kernel.org/all/20241219152929.4005003-2-cvam0000@gmail.com/
v6 v2: https://lore.kernel.org/all/20241219152929.4005003-3-cvam0000@gmail.com/

v5->v6:
         - Skip if not run as root.
v5 v1: https://lore.kernel.org/all/20241112143056.565122-2-cvam0000@gmail.com/
v5 v2: https://lore.kernel.org/all/20241112143056.565122-3-cvam0000@gmail.com/

v4->v5:
         - Remove unnecessary pass messages.
         - Remove unnecessary use of KSFT_SKIP.
         - Add appropriate use of ksft_exit_fail_msg.
v4 v1: https://lore.kernel.org/all/8db9feab-0600-440b-b4b2-042695a100b5@linuxfoundation.org/       
v4 v2: https://lore.kernel.org/all/63d5e3bb-9817-4a34-98fe-823a9cac7c16@linuxfoundation.org/

v3->v4:
         - Start a patchset
         - Split patch into smaller patches to make it easy to review.
  Patch1 Replace  'ksft_test_result_skip' with 'KSFT_SKIP' during root run check.
  Patch2 Replace  'ksft_test_result_fail' with 'KSFT_SKIP' where fail does not make sense,
         or failure could be due to not unsupported APIs with appropriate warnings.


v3: https://lore.kernel.org/all/20241028185756.111832-1-cvam0000@gmail.com/

v2->v3:
        - Remove extra ksft_set_plan()
        - Remove function for unshare()
        - Fix the comment style
v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/

v1->v2:
        - Make the commit message more clear.
v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u


thanks
Shivam


Shivam Chaudhary (2):
  selftests: tmpfs: Add Test-skip if not run as root
  selftests: tmpfs: Add kselftest support to tmpfs

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.34.1


