Return-Path: <linux-kselftest+bounces-25367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6EA21F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4071648F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6A18C910;
	Wed, 29 Jan 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDOaAtN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FD1474A7;
	Wed, 29 Jan 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161392; cv=none; b=tgS97XUOL/ABtXHgvtLuKERGZKfgIRyJTHeR0QdX4G2SdqnymeMUmDjptPrS3HTw6djh8qZelmGCgc/lwGMzZIIbnWHLM+Xu1bguyXsc8i+YSb7kXEogJPjyq4pC2l8G9su8auo8yCsbvPkKiSbF14AQ/Ik2MrXeRP5/sRWrC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161392; c=relaxed/simple;
	bh=HbUxNn+oCkvj5uMAczLofHZxwqIihYit1aiJ13tq3Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUcUy8A86JR7zu2AhZqGk2CmrJpdd5JkjeP9QQ/O/p6EA4QN5JQhoHBLE+Nhde62EsRDOkAA/F2own0SBGVANdZA5zOBd8K6mYun2wSg2TSu5uOb26u1YBOKnBrPQA3WrmsbozxKNUcNFDNBxJPjhfyQYEMtS3EtaeI+KNyxfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDOaAtN1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283dedso72941505e9.3;
        Wed, 29 Jan 2025 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161388; x=1738766188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7JcfwatOuuKw0iCqm/4LAbbsAlPH2LBTwQgByq6Ptk=;
        b=YDOaAtN1i+yI4Ui1/mwvA1FmNCTwc5gpcwcgi5Hduorh4+sP4C3apS7j02aNIJwRBc
         KBvwQhN9+GOwbRrZu5ldExPlrmMhCYFNsSrN4LTx5uz4EPvSM5PlgiapjH9WKi9/198U
         Y0l1qhZcovv/5wSilRL090ishVK4nDck/ZYnXAmSpHANh6xr0HhV9PpF0OkH+q46L8OK
         +B4GqCyUTH2VXj3kynJCMIyqaUnsERWbrehYmzq7d/35f7WDDMrj7SgXM3vtPOcRd5++
         jeJRa1Tx4iX7X2WVBVtZFfLZn/sbMQ4hgL3UAqKOOrIYhRXSJ0RAksMxj90ITgePFVve
         NYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161388; x=1738766188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7JcfwatOuuKw0iCqm/4LAbbsAlPH2LBTwQgByq6Ptk=;
        b=Nyt6YAJLNxkx1iJFv/fTOyZbp8mVMjlww0GIRvG9vwtI+uYXbLfY6GXkSKHfVTL5H1
         EB0xH8vZrIcXwbVBZnKh8NeNCBnnHyUm0kR7sqITFpaw4458dA4qutoEoEdJ7sbhd2h8
         Ao4lStS4cW0TIWbGXoWwH4DrLFbdTya78XLUJioaqtI3P+y1qZb9vvsbAXFgDAHM2mLm
         Nos+pj1OPVwPTw+HAJJMcEhuR1jNoQv9vt6gCuRs9rf8EyOJ57mvNro1PmNsf0tuaRtj
         /1tdNDJRHuhekfgHA4vRt0b9EaJACL9n9dGJ2mCeo+q8/+uI+51eg+NMD+AtZI+facvf
         2qRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4GoQY111lQw1Bmt0qUMlxXjEC3MP37odfD5lL3o4erwHYtYJtt21uZ+0RVLeo/UQ+NITgmJUMuCO0BKOmnvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyorMQM/lX2FszzVEypax6HKTgpTtVoKTWr6JAXTWHSR+gt8mVG
	v1PJAiNZ+hMyO1elRnwF+ETRGo6mhzf0gXyK8GKBhQH7ATanEa0wBbq9IUeR
X-Gm-Gg: ASbGncu4HTFjYQnJ8Oj+oItUAuhGIo/Do01vkNNcKCoQXPTcrgD8GNlEabWJv0IBtjD
	51/nP3K40Dz37FtcCeddn/gODXhBcZoH/3SegYWaIAtlknI6g3omb+gcSZcgzNMck0YRuXbchZG
	FWaJur514M5CWQxy3cOG2U9yoVOFG26ykBlyW8DN1Uztn6T0IYnh9soZxbXafbF717RTmm3QVgf
	b0IJ6TISYAD+AQ3cMcwF8aAjWHyZY8Fzg4wsnVra6w2IEq4CozRN3LWPcKS6NbySKXRxjUIcuI7
	zfbyeEA9Os2L9zH4EmgwOmVQdhYDOmUChLmpoQ==
X-Google-Smtp-Source: AGHT+IEOeT2IYfrAWkX0Pn30wrHwB0F+zZqwypKKf0s/CFLiCS6xCIRwcMo+Lj6m94xFPwN+/ueMJQ==
X-Received: by 2002:a05:600c:4f08:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-438dc40d553mr23626335e9.21.1738161387977;
        Wed, 29 Jan 2025 06:36:27 -0800 (PST)
Received: from localhost.localdomain ([2001:4c4e:1eb5:de00:1ff8:8b09:84cb:1239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df36sm26472465e9.25.2025.01.29.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:36:27 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	davem@davemloft.net,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next 0/1] selftests: net: Add support for testing SO_RCVMARK and SO_RCVPRIORITY
Date: Wed, 29 Jan 2025 15:36:00 +0100
Message-ID: <20250129143601.16035-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After submitting the patch implementing the SO_RCVPRIORITY socket option
(https://lore.kernel.org/netdev/20241213084457.45120-5-annaemesenyiri@gmail.com),
it was requested to include a test for the functionality. As a first step, write 
a test that also validates the SO_RCVMARK value, since no existing test covers  
it. If this combined test is not suitable, I will provide a standalone
test specifically for SO_RCVPRIORITY and submit it separately.

Anna Emese Nyiri (1):
  add support for testing SO_RCVMARK and SO_RCVPRIORITY

 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/so_rcv_listener.c | 147 ++++++++++++++++++
 tools/testing/selftests/net/test_so_rcv.sh    |  56 +++++++
 3 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
 create mode 100755 tools/testing/selftests/net/test_so_rcv.sh

-- 
2.43.0


