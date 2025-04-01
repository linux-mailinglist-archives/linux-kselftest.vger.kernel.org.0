Return-Path: <linux-kselftest+bounces-30002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D008FA7839A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A813B1267
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B821660F;
	Tue,  1 Apr 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VrE5U6Q3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8322214A93
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540560; cv=none; b=Gaz6rPux3R1kfanjopQmmbVZRtb1UnCLXCg4O8w3RfZd+DzMw8GPwV/+HQzWa0tYOEnd2JrBOX2kvjsm1Up8n6vg1ERnYMo9BBlpwqF5So6R0LDMNBu5GegrhTfFuhfMrmOPODdGebabZk2kCXnw3M+vrt1y54xF2V3X3Oa7lAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540560; c=relaxed/simple;
	bh=7f358SFWcNF01KixZAOdk7JW7C28LBiBgCh8D1STrA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXdEqS19mW71jaVXCAfsgTigwulWvf2MvXjAqQJmIDJUGQA1J61SmLQFTZbtafVO+aKUajzQR30cSjobi35Q4L6R5HAChrfPueJjpMOAqH/wpNKOh0tixKUGXK8XPw9pt9W6lmtsCGDLSUtW2yvVfkCTAMioEgGWpDa8bTx0/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VrE5U6Q3; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2c75830b455so3711289fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743540557; x=1744145357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGgBmKURFrUHto8RQWqSBytYldTDlTLz4TpMdWnsHRk=;
        b=VrE5U6Q3jvN+w3UQAiz4r405izZrJbr09mmkkSjtT61ljyZh8H4pIf02vTXg9EgF8P
         6WhR2gd/S8rG2OamIX2SXBjPFGInmXW5E7o8UMs/zsyO8rpV6lQSAAJlvapVmFTogMaD
         4kZpycgDU2u++PblsadWLSY7WehCx3V0Px4l6KvQ9BZ8ANoUKZ7hlVFyhqffUUtUXMjA
         zMfe4pCe5iQGlOzbLcMLNvIzUDgmM/ZviLXuSXAmlhOH2S5R/9KfJaSSknJg9GkQAJMZ
         q9HfMoJjQCfEjdBiXw1aDSJWmOAPgAi4fQkWGhoCDOfWG35wUwtP1WnlEt0V+CrWl3Au
         s50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540557; x=1744145357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGgBmKURFrUHto8RQWqSBytYldTDlTLz4TpMdWnsHRk=;
        b=rYIRUTi80liK9rDgjn6uPVnsl2dQEVgPcGKZnw0gsXAj59GMUbg/3kLxPnVWNBXAqJ
         M/tmFGQDfX9v5meWXXihyp3QolVUAbPrIJRcvazhxPgIr5iFqOruKedSBr/IZ5RL6yX5
         1vDOB1+hqSsw/VYDtP/Xicl4Wt4l4SJpabMQeMx1SlkA27zzbhKsQdipA2mLR2V7Mbeh
         09uXHXQUWgp4t5NmMa+hmDhn7dFMWQmje+2iaU613wmrJh5d9w2DxAE/E9U5KVVeufS5
         N47A8T7ymeHZLs12iLb3xZbEIFLFRvea0D8CyBNCPUXfZA2eM8TtP1qIrC+EPYpQlhil
         O5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZfXo89q2ZipKj9IsUWWvjer2q5sjAYZkSyKRqCaf/JvkHQEH+9I6AOOeSlpNEX/JVPAtIHF3A2jtpj/xzXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIkwLun65UN/Mm7dn+JbEgI4E1/UUJh6BAL3IgpWQ6l/rexoT7
	AQgeHgmr7+jwHkZeKWypWK35jepQmt5Dt/JL09BpVJYO+kUMIE7TWfPqQ06J8uuMQ3oOUJdRat9
	fRmPcygg5eEAvQu4AoLp5ytPKgFlPMrrG
X-Gm-Gg: ASbGncuvyLMuOVFGqk38EQHQAYa2o3aGP6QqwZ/nZbjr9g0yHxyKmBpqH5PacK9Tij8
	t6o/dMpA8aW2suV8xN1s6xHefWAs2Am0dFymWqcT+jtJ+Tw5x4VyPgYqqPh5s+ud++qkB0JnjZ7
	inIg1vfHubzHL3sn49rk1rQKK766U39G7JVocgdTNHhSfjGWs5l/lcQib878ih59RI1cgIQZ3RD
	re+vq33fvMsY/MXpEFtBDdiKaxcicsNE2meU6F/a5Rykrp0tfqELUq8vH+X8Ur4NjGXKZAI/RBb
	8kgtsp8q59CrKvNTuhCulvmgOcR2f4dySX1DUMWajHeGtY0EBw==
X-Google-Smtp-Source: AGHT+IHT7tuEyz+8ZJfFEve9qQLewq55VRij2JfH0oFJeVdDPpIS9H4oxcQmw8lVwKWstaifysOw9lQ/JNUK
X-Received: by 2002:a05:6871:a583:b0:2c3:f8e3:bdb9 with SMTP id 586e51a60fabf-2cc38230b64mr2788695fac.28.1743540556932;
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c86a3d3c80sm566879fac.5.2025.04.01.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 18B8F340351;
	Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0EC2EE4161D; Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 01 Apr 2025 14:49:09 -0600
Subject: [PATCH 2/2] selftests: ublk: kublk: fix an error log line
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-ublk_selftests-v1-2-98129c9bc8bb@purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
In-Reply-To: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When doing io_uring operations using liburing, errno is not used to
indicate errors, so the %m format specifier does not provide any
relevant information for failed io_uring commands. Fix a log line
emitted on get_params failure to translate the error code returned in
the cqe->res field instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index d39f166c9dc31721381184fb27d68347ecab81b6..91c282bc767449a418cce7fc816dc8e9fc732d6a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 
 	ret = ublk_ctrl_get_params(dev, &p);
 	if (ret < 0) {
-		ublk_err("failed to get params %m\n");
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
 		return;
 	}
 

-- 
2.34.1


