Return-Path: <linux-kselftest+bounces-16887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6C966F75
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 07:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F681C219C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C514EC5E;
	Sat, 31 Aug 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKJhoH2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593D13AD3D;
	Sat, 31 Aug 2024 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083136; cv=none; b=Xlwb3+lcvrfLTw5PDEuPS85pqZArJptQDZ1JR7vkRVQZAsvtqBemp6aStT86xrUGurD4H/6vn2Cy0ia42qFPucoiWXkPCQeRlsjMT8I47ypvgOmxxhKwUWb0Ion7mrDXyBFbOWXw+h3+nMschlOEm2+jGWM5m7TXHWIrKL4BNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083136; c=relaxed/simple;
	bh=q3Wuq33aLi01g9ygWkAP1UGHO/jUi8qpa3vP+xajyec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDszAgX57j0o65Blz/RGjWQCrZ41RsPClpiSxCsqhdD9ARrHER7Q9Bcd7g/8ftY5AgOP7rTSFIcJjaR7kLQ+IE/ZIJUEDMjSFXJajZ/X631PdJm+nfO5Y13+4PlDGemIlspCvnt6DuC0Wf/T/h/C7nQhnKYJfPzXlqaKoS9SnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKJhoH2u; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so2180481b3a.0;
        Fri, 30 Aug 2024 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083134; x=1725687934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqlavdjoL1y1b4KwI2TSOSURutoAJBt5H47AjJPg0aQ=;
        b=QKJhoH2uKzC2JyMn7RQNXksuc58Il4jyofcEMBIbTbEblnmHSWqAXNsir1iB1UVbpJ
         oSb49DoaX5/vkFJQgNVG9vRFBtVxaRLw26I+r8zf6K0I7+CfwG+Hdy3o6tZgF8xcZGO+
         W1vsk9Dy20U0Y/x2njJZgLQ6Uzs/C9cScH4wMintZLJM1PlXLJZZQ2UaeMVsuIMY5dEG
         VIXo0TqczNbPlM6JPv1rUIDjpb4SMkE2c3iozQuAp+NXNPaxMdbfEkgQxi4S/B7hI7gI
         8+3R0fNvURqTvgESIGNUvkrtqQcrbhkrTeciKSOVdIVZJKyRkFpaO5S/2Akq0jrBATql
         86hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083134; x=1725687934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqlavdjoL1y1b4KwI2TSOSURutoAJBt5H47AjJPg0aQ=;
        b=TpbdvjO/CQImcpCQILNFdZuJ2LTux6YZfyFYSG/a/hXdxVe8W+sqmD9Mt8MdvEvKuo
         D9CkZfqYLU6I9GbkiDOFgMpd0+kirFky7EdGezRdHLmALnBo73MvtX0P0sSO4B0CdTBZ
         zrtXp+M16AA70JQH2K6G3ez6qNUeN4U9JKO5cCyCCKTpvi0rRIgUrfKiUBs3hXk0/fGd
         DFkqMgfnA/Yd0nB13lmhuN5/ru7dTfq/+6YGvKT+br1llHw8mnwQP5zUoUcRF+uFtqmW
         E+UkfeStAa196LwRjEPeX+lxHwwAV5af0KGvGNE0GXtb8QPzzKq4Ol3ePHdc4XPkEJN1
         3NGg==
X-Forwarded-Encrypted: i=1; AJvYcCU62YpAn8bxGnjrW9dJ1cCVMJRWQ4TDRo70/wmKLHQrD9kZoawp/OWoKFjY4No8uQnr+Zs=@vger.kernel.org, AJvYcCUu6x6OpthnjdasJctFgrFH/PloTfe6okHNEQz1zCJYrVSMu2U1EIpchz+EIrwvLXCL/C99yAdQH1XmUv8m+kcd@vger.kernel.org, AJvYcCVmiDfOPDpxNVC6a4afdN+4yecOJ4I0byNw8SL2QkzU8UoEbSwww7XMb+xfzRNTxAblqu22bPyOqSNDkz5B@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEDtohFwoSM78FXi51CQK0k4k9McKpNqHE7sFjn0Wk9b9eKCw
	jDu8qPplJPTE0f/EnRnaaePYT9Zxl7oP+ZKanIqvYESt3RNRAGLo
X-Google-Smtp-Source: AGHT+IHA71pfDSeosRO+Y8ZMei4/VW5D6nM6p56TFPHWYfNG8wGCB4E+MrMr5uXquDdTpRBaQTaYnQ==
X-Received: by 2002:a05:6a21:394a:b0:1c6:a576:4252 with SMTP id adf61e73a8af0-1cecdee3d61mr2447426637.8.1725083134203;
        Fri, 30 Aug 2024 22:45:34 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3949sm7343649a91.48.2024.08.30.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:45:33 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	aha310510@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf,v2,0/2] bpf: fix incorrect name check pass logic in btf_name_valid_section
Date: Sat, 31 Aug 2024 14:45:25 +0900
Message-Id: <20240831054525.364353-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch was written to fix an issue where btf_name_valid_section() would 
not properly check names with certain conditions and would throw an OOB vuln. 
And selftest was added to verify this patch.

Jeongjun Park (2):
  bpf: add check for invalid name in btf_name_valid_section()
  selftest/bpf : Add a selftest test case to check for incorrect names

  kernel/bpf/btf.c                             |  4 ++-
  tools/testing/selftests/bpf/prog_tests/btf.c | 34 ++++++++++++++++++++
  2 files changed, 37 insertions(+), 1 deletion(-)

