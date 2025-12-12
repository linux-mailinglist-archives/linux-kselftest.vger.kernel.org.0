Return-Path: <linux-kselftest+bounces-47483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A56CB7EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C252030528DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5330E0D6;
	Fri, 12 Dec 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HBy1DLVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106C274646
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516629; cv=none; b=FUp7eUaw7pgyoU7lvoX12wiH1ejjkJSHw8a/y8ox6pklwrTdCZ2k4GxOye3WMoRvCDlV1tgQ9PHkWI2XHbqCbosxkmJRWuQ5xjUfpbWPh8WBse1PAP6dmn4Cjv2KM71Zu68s7DQIx9fxA7AYv8DrpUV74jQmITOQ7JxA0XoJ6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516629; c=relaxed/simple;
	bh=hMDvcWZRxsHgEupNzfRaoWl4qKW471diyO0Q/xWeRr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjoJzgvKCdPrQRMPx8/4DLndEOpqdYRZPNp5iJm4dL+9y89GcJG7AfHSOMeeqMEXSWHy02EuaBFkVDDTk8AFSM1MtOtdwyID2I7noQ1W5FlAB1necrtDZys57LgbTdt0cJ/mVPFsGNWaUEEi0lC+CuLTLo/qokIowLv9bzyjs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HBy1DLVT; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-37baf2d159bso1731791fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=HBy1DLVTGAnUtGwUUqE/Pq5Hgx8CrAe48oFI6xO/E6M+7IyApCXkCa6S0D06PMLPQn
         P14k7ZsFZHIaqYusE9SBV7ILaGyaWTzFI6I5IY1s0f9js3Qz++kmkZuWHQ6eRmUKya93
         UR6BObUNbXMd3KcQi6MBAcsOzdpkPyEwnzArm9ACBYLwqCjvTSn/j9cB+MSpSuov3+8T
         zTE0tv8YO5PhBzuK329wlMJnAiL74Adhw+C60W11NlOd3I+7Fp0wk74iDibgchEZLPoM
         e9ssqexsiLF++poBefY0h2JrVgvmxx50dqIq+1aagn0DsMDqM4o3rzzCAa4rlqAZkpEH
         ZrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=vEWVGIwz0RwvoVQwMeHTyXGPeXVA0ERk2vF+rbKT5i6JZj3GbW7P7S+SUIpmpeeGe3
         Eb2XNX4P0Wkn9S30sfG0xbWxicAwH0VxNYTLLZkHhD0JR3PhyI3ClPYMel0zUY8h3SCc
         iNms4OnBpG30uZp+lw0qxf1dOmu6jv+14b3KcKZHXrremeAraBN5iFmDCR14fgG7jPG3
         dhdkGZ117FVFR0XgwIh6lONq8cgFwf+in0YAtEXOpqTQEkVZMV4zPKj/fQqxsEabys5K
         Su4G2DJ3vfT21+Po6erE7QOsvYSzh5yfHhvNsLQBBrzNaXs/AmeCrwiLrCt0vmTuL6tz
         mUvw==
X-Forwarded-Encrypted: i=1; AJvYcCVkAUc3huWS6HTUo+MGSMkQwdxt4zS0RIXd2n90mGgqPHm96JkqnS/xIvH+QxtRxektFZZDJ52xschYEXU0BHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJs4b++zeF/0Bg0D7DisuAWWfhjt/r7h0M+7QAn28s1lhHEWZ
	zgoTMiyrINS1Ai7nTZNyjfD8kQFYFneQzz8rGTmQPvbbN8jkvl2ZdkeISZW+rZIVDdSa7g7iA+c
	UgynbQIRom5O/vgfFIpi7iyAW4uqiyjCz93j/
X-Gm-Gg: AY/fxX4p93onlcWoG5cQUeE13IOYmix0aGRxW1nHQ80WaYeqPQX8iZCq3LuUiVVVx11
	GAD/LbRZ5TOxDRlAr67PVAi88o9CWvW48nIY4noUyj8S7lWiw6syMOC4XHC/wyMqFQSBwb+QI+I
	xmayh44Tfl4zTthd5Y9iSZjj1t2TLuuY51zx+20hFRYzaLskLz31yeOHpWMPqeq+qCcGAOr8eX6
	DlNaWRLVr7llsPfDgabMw6R0t11YCc9xD+xbgbgAfYqF4wtAFb2rLhZ0AqAl2ncgpZjhzTI067A
	jwNsoT1AzSxAXRSsMFSuSkNpD4w3T6v64uiKADE2VRX4+4IojMa2dUTlu7YTWkpzDNnUah3pqi9
	ZVA9wBticvWEizHUmT275Y2SU3DfXfVohhi878k9+sw==
X-Google-Smtp-Source: AGHT+IGtF7eyo8lXcOR8WUkH9+guQzHvCZGlU7C+InJFwFhMRt+x3f30HEC/DWoVBssc+TB5k2rM71vsdf3i
X-Received: by 2002:a05:6512:10d1:b0:594:2a33:ac17 with SMTP id 2adb3069b0e04-598faa21734mr115979e87.2.1765516624456;
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-598f2f72a24sm939705e87.40.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D2A56341DDC;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CE18BE41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/8] selftests: ublk: remove unused ios map in seq_io.bt
Date: Thu, 11 Dec 2025 22:16:52 -0700
Message-ID: <20251212051658.1618543-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ios map populated by seq_io.bt is never read, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 507a3ca05abf..b2f60a92b118 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
 			printf("io_out_of_order: exp %llu actual %llu\n",
 				args.sector, $last);
 		}
 		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
 	}
-	@ios = count();
 }
 
 END {
 	clear(@last_rw);
 }
-- 
2.45.2


