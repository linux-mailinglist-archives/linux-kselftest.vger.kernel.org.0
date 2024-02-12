Return-Path: <linux-kselftest+bounces-4527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F2851E06
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147D11F219A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109A47F64;
	Mon, 12 Feb 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/5osxVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2B47F58;
	Mon, 12 Feb 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767021; cv=none; b=Pj34Q6lahQt20l4ZAHrp3dwmraqq4eukwMeM6xOQ/gfoLHw0iVRTxMYRXfw0P+KPt9SINMW7buaNIK+MYCI5QqMgWcTB40RDxBwH17Nsv+3Ic/sWQhYvR37kH8ddcqcB4C/fTwNaLkACrmfnyA17CSqvVMugFu165VwCe3F2Flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767021; c=relaxed/simple;
	bh=T0sehhjp1xWfnMxeOoCLszKthu4iGg8Z5jE5Gow6vMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xn+Msa+uw7ZknLTe4tcB8lQUakrD7iK+/vZq7m2dSulnsa3cas5c3dJa7KJmnMXL3ExUMf+nbXvIvgXEjBiGFrqDTuLHqOO8LoOQzFZCdW/EG0ISQjca9w+fl5baa9trtUUB7RRaxID+OF+NrUOVcp0GPefRYZ0sT0XUFWmw++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/5osxVK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so20889666b.2;
        Mon, 12 Feb 2024 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767017; x=1708371817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3vo9bp4gTksdR64ewvsApQF1O1XOI2NpsvTDAM0jX0=;
        b=A/5osxVKog1zY6lWUStqGLkdihrOWK3eI+zT2tZtfAxZAM8AvX+56a2Qfj4+YN4nMS
         IyCdF8KO7lSURtLXTvjbifby3sbNGLNH8KonTWAcj6biRKkx1X8RSuyRBhtaUtS1Io6r
         0od3YxYZNju9PMJdRWbXZt0Kn3d2xR/XS21vV8ekjHWmN92HHDt2M+hH0I47n+knDpVb
         03GEosKPx/ucKLPT1mXuF1sqg9OYK1xR05MCJ8IPpaSC3v2xwML8CTp8c3RGGVJctDeG
         X1o0GAbhxJBCJPYi21NhSEQXaT4RCgOdJi5/wntULwVEXT1WSB3fb9/7n8HikmHaIGPf
         8YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767017; x=1708371817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3vo9bp4gTksdR64ewvsApQF1O1XOI2NpsvTDAM0jX0=;
        b=Td3WyyTK/DmKq1oiAbXXI+8zZqsfJaZov27dh4WDv3M3r23b2w1cOBRzOcMQQNpngq
         eeYh8gI+RmQXJD6LVTWCWh4VkQ8h7v/P4C/FtMTktJrRXsF83xxvebKnuCxkS+yRsszw
         4jeryaGpXZWYgILk+wGp1u94v5kvsR8SuMq6UJz+nOlo8xHE9qwrfXxc5CXO+st+cRF5
         hj1ZfY35/v1xpwvOvbL+ZRPlP0QmpWxFdffVrOSarOXotzSGjf+U2nMFPltwGorY0/fB
         cBXtOj1uN4/qoNvG5ZyHjD3IJVegojcxTwbwp1jFDva+oT8B7bkiZ3gs0PJPRicFiRze
         k7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXMT+kzkWPAVcqWW+xgbhy+1bxC4gM7aJF4mzZj3kWaN1Pm7QruuWQbJDATH4TQxaf+xTD7/mn+qJ+R7c0d6NzKWazr/M6/XJMx1QYQ
X-Gm-Message-State: AOJu0Yx8jv6LURPfmyUMUhw5bXLdwQkKiH9yQAGQRZ6iahYpOvOI0puE
	OtsdHNq8NBpgrXoMjifG4sZfr0yKdirn8OWhu2OugTlZ/W5WyinH
X-Google-Smtp-Source: AGHT+IE7yigdKLPrssuNF0+DK51FR9eDvN/BkekJpQ0YRHo4CDw2MhxBYxDAHbV0fBzl3QdlTPNydg==
X-Received: by 2002:a17:906:c318:b0:a3c:ee88:b600 with SMTP id s24-20020a170906c31800b00a3cee88b600mr358304ejz.47.1707767017591;
        Mon, 12 Feb 2024 11:43:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaPcNnEqSOx5xmBXr4oPJxnbdhaRcWotPyFCOGuyrisp6R8oDGY8nM7U1oZh9qbTRbpVdTKZgep3cnPEM213tAUpxX/vWhyvvbF1/Gen7glHRCh1Yxbd+XnAM+nb7cyqsolXHt/SCjvCIhYrxc7ZQlhwIizQG6SvLi2p4e2RqYYiRJN3iWZ7ce8nCwFWJES3bu+jX8rSeAvyeMoZvFplWRN+PqLsT/QD6I8ooJo7jH/EZ9B7l2BRehTqt9j4D4759K
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:37 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] selftests: add missing gitignore files and include
 generated objects
Date: Mon, 12 Feb 2024 20:43:35 +0100
Message-Id: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOd0ymUC/32N0QrCIBRAf2Xc5wy1tlFP/UeMUHfnLjgNtVEM/
 z3bB/R4DhzOBgkjYYJrs0HElRIFX0EeGjCz8hYZjZVBcnnmgguW0E0ZU35YymR9iMj6UUnT8lP
 fdQg11Coh01F5M9fUv5yr8hlxovd+ug+VZ0o5xM8+XsXP/n2sgnGGuhOaX9SoeXuziyJ3NGGBo
 ZTyBYK9TezJAAAA
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=2076;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=T0sehhjp1xWfnMxeOoCLszKthu4iGg8Z5jE5Gow6vMo=;
 b=VI1nGBe+i3vNYwuDZEFPIb1hVKz6OMDvASuDHzixDrY9tuV3yfSZn2Em7pyH6ll9HFYsROH3d
 0GpiooV+liXDlVaNvEy+Ux8YTjm/JXAnilci/uX3VkTxiwefJIlR6Qw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series aims to keep the git status clean after building the
selftests by adding some missing .gitignore files and object inclusion
in existing .gitignore files. This is one of the requirements listed in
the selftests documentation for new tests, but it is not always followed
as desired.

After adding these .gitignore files and including the generated objects,
the working tree appears clean again.

The new version includes a missing entry fot the .gitignore in damon,
which was reported by Bernd Edlinger <bernd.edlinger@hotmail.de>, who
also proposed a patch for it as well as for other missing .gitignore
files covered by v1. Bernd has been added to the corresponding patch as
the reporter. If a different tag is desired, I am fine with it.

To: Shuah Khan <shuah@kernel.org>
To: SeongJae Park <sj@kernel.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v2:
- Remove patch for netfilter (not relevant anymore).
- Add patch for damon (missing binary in .gitignore).
- Link to v1: https://lore.kernel.org/r/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com

---
Javier Carrasco (4):
      selftests: uevent: add missing gitignore
      selftests: thermal: intel: power_floor: add missing gitignore
      selftests: thermal: intel: workload_hint: add missing gitignore
      selftests: damon: add access_memory to .gitignore

 tools/testing/selftests/damon/.gitignore                       | 1 +
 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 tools/testing/selftests/uevent/.gitignore                      | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240101-selftest_gitignore-7da2c503766e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


