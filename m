Return-Path: <linux-kselftest+bounces-27215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC9A3FEC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B63A3049
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94933253F0C;
	Fri, 21 Feb 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFc0oUwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105C253B72
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162362; cv=none; b=mkJ1pykkV0WkwqGQK7C34tiF+x9DdLby652fGoezuoIEpxX/4Eb798qtkSQl+BWaUDl1yAVwJJyCb1xtgphooyMKzCrOiJxPRsxx3a0ZjJPKJj5VNMQ6N82eTp1sKIU08yFzPPO2IVl4v+td+C3E7y0eYQGGreFD6Cr/Ia0GhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162362; c=relaxed/simple;
	bh=Jd3sS0uhGXgTw9um/6BzDZdcnVVUyQaC/pjolFnZ02M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HsitDBxnWVLZU43Kbnw2DuWwxHcF9Kt5I0w2X/WMT97DjmZPX5k42Si6mJ6H7iu0aNnzbxVabIXdeW+nEQK0WhTZ0KOZj9n+9D9bwJNk8ThBm8jP3IyGX/naaUc7QoePzGAZxWhChtitYwpS8G/eMj4nqKML7xt1lQ9NgMLTbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFc0oUwi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso12607515e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162359; x=1740767159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTW4zFHgqMTpKYtsmp9+cjJMhtMM4lVL076gYjHeNng=;
        b=RFc0oUwiD/QeWDpIxa0dDUicD/kdqhmSfuHQ6ZvEmLwg5KUDPIH0RBnnpL/k2HH0J2
         xRRIeK6wOh4twSFeR82nH4RZEmY7kdx0chDJjIxwLgPvYO+fEJ6EcfZ2cjp5CQbAVRFW
         6U+ir3Tryi0/pSrDcSLYAHRx3YqcMy+Xbj5UCZYDlg3KJqMcmfud8Ny7BhhHGmRLTso3
         fGJ62tetieZF4F+UZrhMyBEXQrKzJmPQhVm7rqdGQ+jyHMLXQZ+5KA6r3SEYws40uHx+
         HQrQ80gOcAdkNB1l7Q/wSzGjNSMgpFHuNCY2XkqtFPfE0xlB0ZbIViqwNaW9CEaF6ISE
         8sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162359; x=1740767159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTW4zFHgqMTpKYtsmp9+cjJMhtMM4lVL076gYjHeNng=;
        b=Ni1f6g9UU/ROKtz3Cql1wSvo4UDPa8sSh0kD60DBUJx23+BO5+bM8OaqVL9woPPIOo
         jVWzztUQkOls/uuBo+IBv1yal9OJeWtKN0vtapiuC1jbrHN1CJWSBVtnr45nbdF9LQe0
         PALOw8DhJ1fs5pdVbVlo9zMufWNBF35nzTF7+zHS+Go3HGbgMyoG1rGDr5wI2mc/cniR
         uUAQF6zAbknwR1mpaosQnoe+cM3P9LOi8AUE+KCTbLqS19dxoTWbkFNzKKMD0E+sgvi/
         qI9AXsRADnKl8cUqqFr0QjXordTxY6/VRalb5BnBvzOCd2LNP+SzFMD+dyiRXSE60Viy
         8QLA==
X-Forwarded-Encrypted: i=1; AJvYcCWAeLuSCGehVoQMRjQizqozWLDUl8u1KJ0wGEDyEV6yDrtvkdc2odcM9ef12vqoX4oq9/QOKy37GampZrBU7AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYW85QzJ93UUPaexLE/qT3iD/6dP1Atc0WiVM6DwstPQZa6/hV
	zwQAncW3hARnm6rVzeA4WZjpnozz+DB2G4uF6rwZg4yPYgTghBAqynE8kTWI63YtOg2787DFHqU
	NJB85Ky6asg==
X-Google-Smtp-Source: AGHT+IH+lec5x9erUgvTpG9GeO/CGpjb1ve0Ipn83JFb9w83c23OEehpnp+ZQ8agucCyadGiN7t3B4OuYtYozw==
X-Received: from wmrs7.prod.google.com ([2002:a05:600c:3847:b0:439:80fc:8bc0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-439ae1d7bb2mr32069955e9.1.1740162359413;
 Fri, 21 Feb 2025 10:25:59 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:45 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
Subject: [PATCH v2 6/9] selftests/mm: Print some details when uffd-stress gets
 bad params
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

So this can be debugged more easily.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372..be0c93f24fccd618f52d54ff36d9a5540f420e46 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -456,7 +456,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
+			nr_pages_per_cpu, bytes, page_size, nr_threads);
 		usage();
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


