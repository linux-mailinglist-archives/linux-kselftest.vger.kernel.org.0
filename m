Return-Path: <linux-kselftest+bounces-47379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF7CB4BA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8179300E451
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 05:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692F285058;
	Thu, 11 Dec 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eY+tE0oU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C018FDDB
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430194; cv=none; b=Hw45AwWTiixu+Ub0PRSe6boOQUbvifYs75t1Ag7G0SYRG5H3D902Vam63U75XMTSXujoXjhGQCE2vIY6WwX/NRsG6NaWvYZOoNPumDLEyaNp4mHQY7fQT6MdBpN+KWxGkpxVxGC1aen5dWnSdYSx6hBDIgvtLYj6w0j9cS56dLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430194; c=relaxed/simple;
	bh=2Kuiif2dhHsWPbvITqBFFhHHPdqylQ/rqZvih2fi9gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRlLVFiwlZiBMA+C2p180uz43+c03niSx5gh2Eeg8tnu/yl4kbCt/nEf05odg4E+wh3ZUemAMWd2se8kp9TOGoQ36ZRnO5f3vcYi2ioPw9mR37AcFVOq8ZI3JTPMlN0QIXwjW0tBwCPCo+pHsr9POqDRPpju9sQH9PBbQpA+YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eY+tE0oU; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-295351ad2f5so1129255ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430192; x=1766034992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L5ySB+zP/+ngwEt9P7uRrvQEemvqRZ5JaxXp8HWdYg=;
        b=eY+tE0oUHg1Sqfq+ilJmo9wEhSXL6F/gH1vlNwGxZX/Fhky0+/CVhBuaLSnwSRgMbo
         r+ZeFivMU6Er/evciFOPVvpOeUkS3Az4+WaoXxYBlBd19cTdXdTxj50EG5HzUCun3Y+3
         HK6lW/Ugn/TaSQIcdTlts6Yucj3u7Y4B3WBPx7W2DcR6co4az+z8t0Ih1S/V1vvJexk0
         mDQCeezdSn9IjqINBe+I157O3aVIZHqaRqQsmwlu5Al0ysLGkzvQplPhI/KwONmdABmH
         qaYIYpHVd0tv91/eEx5Bz7YZcpQchEEIuGlscwVk0lu8Rl+PVd3PdxcMdD+wxALOK/qr
         QWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430192; x=1766034992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/L5ySB+zP/+ngwEt9P7uRrvQEemvqRZ5JaxXp8HWdYg=;
        b=dEYvm4dT/KQ+w7urFSWtsbVQt+bKbzxNpUWXggqqEYJ5SOFBNRleICKNdHBroNGG52
         2eeeV4Ne+IbAnUBbmv7+cziGEhIEAFYSmHNQ7Q1rBrAguRc2vw2UstHgtFnf3TDpfysd
         O79BXgAfnw6huQquhFATdg3dmGTVnqrBVYbzNdRJaC+yqle/PuPYyQSfT/173KysZV2A
         6PmZCV9bzwqzYl48SY7NPaAnuQngbkGtCf2T27/nwV1CRNZi74B8rPH+3USlP+Ch/wME
         56UDkOcQmaNeGLbGe2Fb4b2kRmi/S18WIgN2pdQ+P1WwFamhHT7OAkSQQt8SDkANeHGg
         hmbg==
X-Forwarded-Encrypted: i=1; AJvYcCV20i8GQ94tTQW+fFYf7N4n5raZ+kTSpEVI+C03PHHuw0Jd87CfUXReb6uHuibqL4NaNyhlRbfEPtyTcKGXZ8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrAcLfM4TEGZO26xNFIvBKg3qjXJOItvS7FN9UhLmKPcx7+BV
	XUZC1cVDhzJJex4xM6bu7gpEYv2Z7vqQRaFmdnGqiMQO97wH6Sw7ygmeoKbc0U1ZWcWZECeb0Nj
	9op8S2rVtRSe1oRq+chKiuxVJSmmXdAUXI7GL
X-Gm-Gg: AY/fxX6UPBVAkU54EbrJll+g2n4dEkPuDCSPNqfGXEpGoX8dL0KW19+5cSniVFSMZq+
	WoODhOmXqMJt/DQUF6LMwSlP3sv3LDHDvTmqhrP6Pb1AzGuTRCP90fqulsr5kWZqeMqb7U9o8m5
	U2/8MMuGz3OBB0owqH/0iJmWuJOTbp3XOeG8hnVTryxuYZtezTPpY6JfeXVK/PA4Q+DuIv03MOI
	bIh5B0t74CT43PLSnoz8c5N6jjtFN26gPlTwwwi7Zc01DnpwRw/5glav6vV8Nto8OvxVOPL8cYW
	zkSVQnenY2Z309BfNWWqZ2ai9l7X8O84fcu/2FclyZD3Fb3Qhj5esZcB/dbiaJKauZgybvkJ2SL
	h0inYytw/f8m2FdryVzZ4aWzgG1wSi7ydhdTxkua0Ag==
X-Google-Smtp-Source: AGHT+IH8WKveI6H+vWfK0UUbFaVJR8xJcdqZMu1+kP/Km+1TUj2IgDadCIrCvsLyDPsHNoLshHkWfyq+njh8
X-Received: by 2002:a17:902:e807:b0:299:db45:c5a9 with SMTP id d9443c01a7336-29eed3234b5mr9070595ad.9.1765430192066;
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee98825e9sm2100645ad.7.2025.12.10.21.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8C7FC34079F;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 89EE4E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/8] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Wed, 10 Dec 2025 22:15:56 -0700
Message-ID: <20251211051603.1154841-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 272ac54c9d5f..507a3ca05abf 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,11 +2,11 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
 */
 BEGIN {
-	@last_rw[$1, str($2)] = 0;
+	@last_rw[$1, str($2)] = (uint64)0;
 }
 tracepoint:block:block_rq_complete
 {
 	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-- 
2.45.2


