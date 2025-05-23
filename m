Return-Path: <linux-kselftest+bounces-33560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64589AC1ADC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB184E2767
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3522154F;
	Fri, 23 May 2025 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsY5Zht2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453221EFFAC;
	Fri, 23 May 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972801; cv=none; b=IM2+R541DSYo+UsZhFdOrPDNMJ+s9g+1o9G1zhxaIv4Y230CLV3JcnXChFfyHie5IBvxpk+JE4yRMbBhy501ppBXR7dA3dqM+z9hVgeWSxy8MCSMhVT+xuLk6RLFoDy3dIf5wFlhA+CODpSezJ9UHivMwUBX9cu4w/APf9qM+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972801; c=relaxed/simple;
	bh=Sj7m6EM7kndCHsPvRtfATw9pHhcHJtt1zDi6ri9XT5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bqoRpgmMJSN6di+c6tUH9h3QhqxQjEkVD1VzbyXQISHaclOCxdn3B7Cuiocc6F0qYxAB7Zuo/kJYaCNgIdrJPwZkSsJpf7AIQwdQ7BW8Xc3UEhHZcRHlzRAkq+T5fhfACAFeZHECupwm8QtIivBd7mwGiHNdC5GiVYh3IY7hvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsY5Zht2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e542e4187so6437906a91.3;
        Thu, 22 May 2025 20:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747972799; x=1748577599; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoUaDf9sklz66/nXsi99JBqWi7v39+C/PJqdOEBvY4c=;
        b=OsY5Zht2j8SdCN+JWjK4bRCbZgdhCW+MxDsrdRKyeY5GsIEVU1svjhVFG0Xho25yTi
         2kwYwmkVrrnI+ehrKzl2RDb8Y1T1iyw/D6KZcrb7KBZ9+HDp/Lm/qogiajj00GnpVKFG
         Dnxd/iatxADTYnePLmbWFHQb6Hsaft2IBd2EExioaa8KdC/84d3FfzcdWTdFG80VKx8J
         rip4hioNsgOBxTNiNXbns27x1zg/T9W0DQCewAUEScMYVVjl1mPUp3Fu1iL9uYJ/OWlT
         +ArXcicxgZVIkIiKJUoOwP9Wfv0Fvi5FnYBu4q2zvnVfpb5YVB1NCkv6V532x2GvvrR0
         nGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747972799; x=1748577599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoUaDf9sklz66/nXsi99JBqWi7v39+C/PJqdOEBvY4c=;
        b=ov0IJMtTGLa2OsC20mIc8qE/5iH33OpmwkDFWGBY5IjUcWgKSMftM98Uv2+qTNcijt
         tyt+1rgDrKikSpuv4Bt9JoVammhJ6mBVgJY6/wtRwW5ueWAvp3WULAvffwd5KJWXkWGV
         yLXUDa0J4IIM2OdWHvpZ1DGo3aw3yvjV/IYeZZMqBrqNpVRD/mCWQHClJeDxU8mG1mfd
         ea8D8iBiyfpidzPNF0beT69mNg+I/wu0NGXNrrLT3IFEVv8R3FXn5vLu48/HT+owvXTA
         SB6u95583kGcJOodkkLyp8GcPUE6jKSbJrEnYKh6ihKGcSVUooqNDAS762wT7NHk6Rzc
         heNg==
X-Forwarded-Encrypted: i=1; AJvYcCV7QKHEbb5oChqxV6YnrJxJEswPsye5zo5HMalsiMvV3XYopMLXx8UYXeFA386pdYfyJLppAvQfHtUjklRH42s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsIXHC9a13zHGVeZHPklDOBuHI2kL8kpMMFFinHH5JO1+15XE
	m/YU8h9Y4GGq1lWQtan68tVmJq4gCTVK0sx4gorn/nSrWt7U4YTAmFG2
X-Gm-Gg: ASbGncufM7e9KxtWt6JSZbsls/9iPlLhWzI/B2yh6BnqHP1d5MceuO1ktTkGaFW+Ljd
	J4wiz2Q3U1m05o9/Ke2n3NLh4YjvcnaWqZbh1tES1V018ChB1yra4/sqixHJfAFdXCGr0s+6WOm
	epgfkhgoYX8TrI/+LXcErMksfJAaKrXtnKpcDjgs4hi5Z2zltwowpILeahAit5yjNcy1a2Q4Ypn
	qV1YsV4XTPYBM/JIlO14NgU2lDQHgjkdYiBaR8/mOlngNBD0Qonstzkh5rl3uAGBjvs4hB82jos
	cLT7JwUJTUoVbmIsbziiw0TVvc3/qUdjLu1anS5taLhdcUyddWu/kLvwfh6roVzHazZo
X-Google-Smtp-Source: AGHT+IEIiA+D0qQyxvTOmBXHIAVCDDhXMSPK+IhMRA0cF96xdqi3Y/mxBxAyjZlzOIhAF3ZkrM3lqg==
X-Received: by 2002:a17:90b:1ccc:b0:30e:823f:ef3a with SMTP id 98e67ed59e1d1-30e823ff012mr41569578a91.30.1747972799271;
        Thu, 22 May 2025 20:59:59 -0700 (PDT)
Received: from brak3r-Ubuntu ([2401:4900:4e66:e488:f144:96a:edee:4588])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b158fsm6328162a91.8.2025.05.22.20.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 20:59:58 -0700 (PDT)
Date: Fri, 23 May 2025 09:29:55 +0530
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] selftests: timers: valid-adjtimex: fix coding style issues
Message-ID: <aC_yu6Ll2E-3qRHj@brak3r-Ubuntu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch corrects minor coding style issues to comply with the Linux kernel coding style:

- Align closing parentheses to match opening ones in printf statements.
- Break long lines to keep them within the 100-column limit.

These changes address warnings reported by checkpatch.pl and do not
affect functionality.

changes in v2 : 
- Resubmitted the patch with a properly formatted commit message,
following patch submission guidelines, as suggested by Shuah Khan.

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c
b/tools/testing/selftests/timers/valid-adjtimex.c
index 6b7801055ad1..5110f9ee285c 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -157,7 +157,7 @@ int validate_freq(void)
                if (tx.freq == outofrange_freq[i]) {
                        printf("[FAIL]\n");
                        printf("ERROR: out of range value %ld actually set!\n",
-                                       tx.freq);
+                              tx.freq);
                        pass = -1;
                        goto out;
                }
@@ -172,7 +172,7 @@ int validate_freq(void)
                        if (ret >= 0) {
                                printf("[FAIL]\n");
                                printf("Error: No failure on invalid
ADJ_FREQUENCY %ld\n",
-                                       invalid_freq[i]);
+                                      invalid_freq[i]);
                                pass = -1;
                                goto out;
                        }
@@ -238,7 +238,8 @@ int set_bad_offset(long sec, long usec, int use_nano)
        tmx.time.tv_usec = usec;
        ret = clock_adjtime(CLOCK_REALTIME, &tmx);
        if (ret >= 0) {
-               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
tmx.time.tv_sec, tmx.time.tv_usec);
+               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
+                      tmx.time.tv_sec, tmx.time.tv_usec);
                printf("[FAIL]\n");
                return -1;
        }
--
2.43.0


