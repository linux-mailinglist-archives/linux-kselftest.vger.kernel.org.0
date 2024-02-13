Return-Path: <linux-kselftest+bounces-4549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984C853078
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B9E28194D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37C3D968;
	Tue, 13 Feb 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="l7WIuQDz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E243A1D9
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827220; cv=none; b=HytFi8BF3G9d8Mb/jh/XIX2msyrM6GipmTtMLEbrcL8Y1ThI3hJuW0rpiYMNyWLram1xBLIr93fOZ5913cA87v9V0hdSo6GCRTNsHYoXI0y1PjngwHmT1vUrSqpjR3x1NZNEVG0jjhiZ97tMsmCNbvA7reYPeLF+iExHc1IcxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827220; c=relaxed/simple;
	bh=2bUi5ocU7hGIKKXsYhWjmW0y66Qa9iTEbHZUbBCfOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSk/5iUMzXXkZtdt/0dwqwV+8A+v2iKST3LyqKUdiTf2E6lcmKsqPILaRtR+CQLUPOY0stReHWyzz6uqiGhBtQAFCh0EFgCYXwf2bJ9udPT52uLfQ+LyurK03RDnyDjZurUX3edcKFSRh+Rpuxq3hNO9swKvrSZ5AIG2yiEH8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=l7WIuQDz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d1094b549cso6101961fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707827217; x=1708432017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiPjHiM2hRS+OoUkP3LtwjwT4ETlSRpcnKvPYoLHR4I=;
        b=l7WIuQDz5jQQCUfXtLRB6sf+V7xIt/qkHOpuiV3w1fbmcrL1+FBDjVV8ijwyWb7j1F
         +ZKcglSCMewJBJSKOp4ljSkjiXfIP6zQGRT9wlye+9/Ts+4D8CvfoLGiHAqR+CLS8uyr
         1QzCCMvGASIblpZNGeZEEd0XAn76JZ6FcWSZHasxOLG77/qUFoXm/SNjgNrP38jhofuN
         oG6kR43NlJXR45nNwDdbfowQI/P6NIk2UxVy0DVYtirWEwuPFopLxKbZpy43lWYXMlxj
         /guGSDC5fYr2ICeLZmL9I/rbwGA+wLqqJmgtJfTQqwtsICGcr7LKuR5lrttKgF6DHi/j
         vEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827217; x=1708432017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiPjHiM2hRS+OoUkP3LtwjwT4ETlSRpcnKvPYoLHR4I=;
        b=w4u+QIgypnuN/Fvw92Kksc5VNiVOiVFuFJYp5sbWUaGHRODnIcEFZh0DRQWm8TE3AC
         4MUmu11VUbsfI1A14HLWsazBtTFz2FWUxD5AUiqQyoaa/AOf5L1PexGzP14vztfAlB3X
         P0W+eyg7pXrvtn/eEaiwkTi8iOjom/Cels17qibBlbAWhsbOBKb1oACRRGXskhUwvHd3
         aKdAapIoWOmtiFxkaCA/nG5ssL1qO3p5EBKgcC9ZsnfUa/uf8i6wjwukvvoObbcOd/wB
         ge2chzfNtRblHGWhAyshe2rq3UPn1rF9GH3lUi6CbMwrsnsMOszN8iRPD5fprWhyzIKQ
         9EKg==
X-Forwarded-Encrypted: i=1; AJvYcCVDVFle5+Afwk4Mk42bcLXnzBvTDYqyqOPm47zvi51Mlmy+TVNp1vCiNIqtn3pSe+e8gX5cwJ09C6mcoh9/S6R6tKQ9ZXusIpN1tkzTfBZv
X-Gm-Message-State: AOJu0YyYmzMS0oF/YRI9noKNTCuhRqDGSnljT7VdAu0RIyWU2g+mbMDL
	mtxUOhUNZFZf1rSW7wl8hXmGI+uApIUqBgaC58l74hEniBosi8lg+ezbuAJftXI=
X-Google-Smtp-Source: AGHT+IEt67WUBHbKpCxVtemm/Vm7tBxAQm62HxQJ0X7AMI9PDt8IG937eE32+LLj0r6JPBOUwbI8pg==
X-Received: by 2002:a2e:87cb:0:b0:2d0:dfa7:8a87 with SMTP id v11-20020a2e87cb000000b002d0dfa78a87mr6577428ljj.8.1707827216914;
        Tue, 13 Feb 2024 04:26:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3t52NRpuLVWSjP60f+B3gFgGqGMkEgJbn/JTKGOAbhNlQzBS9KzWwy+lM+Xk7C58NBXRTGq5Wqa0N9OBBX6X+qf3QDhqjLQ5jYSd4eQTd8ICqCpY0sREytYemlYT7QsVxCroAQEx6iOqGQbWTTgVbgnKxncJzY3/FYOhI50REQZw/pRJqBkjlrmORshYgUFUwQ50gbU72XgxcJ1l/
Received: from fedora.fritz.box (aftr-82-135-80-242.dynamic.mnet-online.de. [82.135.80.242])
        by smtp.gmail.com with ESMTPSA id jx6-20020a05600c578600b0040ffd94cd27sm11444420wmb.45.2024.02.13.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:26:56 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tools: selftests: Remove unnecessary semicolons
Date: Tue, 13 Feb 2024 13:23:18 +0100
Message-ID: <20240213122317.1883-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
 tools/testing/selftests/kvm/access_tracking_perf_test.c         | 2 +-
 tools/testing/selftests/timers/nanosleep.c                      | 2 +-
 tools/testing/selftests/timers/nsleep-lat.c                     | 2 +-
 tools/testing/selftests/timers/set-timer-lat.c                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index b36de42ee4d9..e2ff8ea1cb79 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -186,7 +186,7 @@ static void *task_producer(void *input)
 
 		for (i = 0; i < batch_sz; i++) {
 			if (!pthd_results[i])
-				pthread_join(pthds[i], NULL);;
+				pthread_join(pthds[i], NULL);
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 3c7defd34f56..447e619cf856 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -239,7 +239,7 @@ static void vcpu_thread_main(struct memstress_vcpu_args *vcpu_args)
 		case ITERATION_MARK_IDLE:
 			mark_vcpu_memory_idle(vm, vcpu_args);
 			break;
-		};
+		}
 
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 	}
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index df1d03516e7b..34e61507fa1f 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index edb5acacf214..d839fa4e6e08 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..d60bbcad487f 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -80,7 +80,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.43.0


