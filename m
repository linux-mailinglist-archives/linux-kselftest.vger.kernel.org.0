Return-Path: <linux-kselftest+bounces-43272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79991BE1411
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDF419C6E45
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C77226541;
	Thu, 16 Oct 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysao4obe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAB15D5B6
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581734; cv=none; b=sFGMdhF4Ik62o6HOBbWrin7ikvMdhakd8/RSdbCoBVKRkqQKTxLg5l3JllHMOfKqsVOixr7wieFJfsLK/mpkDIvqeNtxQhICEzvjbXgS3xKrAOFIrLYnrz4IirB0gYHufkQ5wxFkETbZ6g+BtMXh9xBSrjBJaQnW1uC+sVg+2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581734; c=relaxed/simple;
	bh=LP1O6z1IQDBpbTbRpeF8L3pbsetSmzmu2sMTOE7s14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb1cxlhDuzlFnd/Jbx3g7x4a1PdcVR2BltuQjPXpbp89m17brMCZcDJOzPZaG5qBFPGqlylPZ96qpkMtCTzIipYzRqaN3JUX4vAFUDPjhFzaTUOhco/YkmmdSXte08g7C1HK714GwcgdFYMKTQWOBSSB1mamf0h+2kLL04HqhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysao4obe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78125ed4052so325808b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760581732; x=1761186532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=Ysao4obettxCwIcFjV6atFhQkKQS9fiyjg2rhI2ioKadfW6K7ejqTveU3g5vqMDgvl
         u8F/ijT9QMt/LbPH7ZIE/97ZVGKQxn6MTqAfUKXK8+CegfEtMwkadEfv93/eyGgIYohq
         nWjiYwuv79IyVs1bt69JaoyhCK013/j0ZhWPNPgLaQwDkYxoz2K+3wpaVFKG47YEHpPo
         mwyot05TwLxOeacJcY2lsCLploQluvgqYKaAgp5HzmjDKHGsIZzaIdJfXvgxl7TTcT4H
         2GD3IsiO6ZW6DPFgpAvUqjVJJmv9LVzhUTg75zkb1XNcQDOb7eQ3YjGPc+e6h72KF9iR
         sWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760581732; x=1761186532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQYI9aMN/71Ae7zrFJ51S5MhKJWD3D6+joKw3dHdQmA=;
        b=FHqfLVXXUuAViEEk6ufKLhR5wG8MSmlTprEyCMC5FB29q62bZi9Y+ytrcn5PRx3BJL
         ckLfT29I9CTL4VDq2HBeiQu7BFJUpWfQj0Ijp/fIUeirl4SYcIpM143QGWjXnqn8M/Gv
         Lvm5hSCkW1VvNjMmCLCXzYRIG0wkHRGJaDY4unRhUyDDjd4NbQFT4n8bSw4I9goV3M72
         udo0kxIZIN+u0B0/pLzXJaxKfKtG7qX3NnuxdUQ1+Keh4LrXHUvzi5Fr1Jjkiva+VcX0
         kUt2qQnzievYkpKWbuMrnlJZeAPN3lJnkGCF259W0iL0KbCuqmla8Fh60SLpB+PcXvSK
         UzFw==
X-Forwarded-Encrypted: i=1; AJvYcCUg5+qy+7O1tiWyPgj9HlSe8Io72w76wKi3fGkhPxdnJcFQdTLnKR/2qpCI/jNVlbN4LxfLLGcj8ZKrORblUU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJQLdN3Pd6KgHEOr1znPqz9fjpC9HwiPWOFZRAbcEJQYF8+k6
	MDmmaA34lefNSf9dNa6ksCcdJd41FDhbUxNVK6vxWul3V6e3m1pNLQG9ER5eEE77/3eVfg==
X-Gm-Gg: ASbGncsQv4YuGrrTVGO4+vZoCFnNE9qusZ42pnp6sjP5gbiLzUuRq5yf6sGXevqgZMy
	jmB2y8KSTPDXUi8JamPyHoMuZO6pBYv+kpGSLs8TE3O4dK/UJuH6yefNBx+o+GibA0Qp5zjPH+Z
	qcD3mDdI/4hXG8xx8+ehiyy/doaBTI8sMQ6rpj9SUjWjcMT419WNKe1zPl8LhQgExQaIPXW2aKi
	2Yjf16OB7uJjsYtgLZdG/flkFMYAwLZYMqaBUZXvrSsk1QWQqqPhdKVvQCoifh8bNkGv4M4lyTy
	f7yaUdxi5S1AsQBm6cdX29kQUWNsZVvKurapQcXypJFsAfqTY8VrFgV8UtcI5/acZt20A+JHGSm
	beO5o2e9vRLrucDRvstSkQPJQT9zFQpdtU+pUXscaFEkLekxtbJDYA2vFZhiSWSgxfaDa6JjCCu
	snmkDPy8Nf5yy+EqIH5DIlN/EFCpIPdK5ZTCKw34U=
X-Google-Smtp-Source: AGHT+IFuqPT0J0veFe0yzcdPJPOifMos7ZUqhF8H3BBTiuHa78iT/YFUtlOxJl8k19dv/ZPmbtm27w==
X-Received: by 2002:a05:6a00:22ca:b0:781:275a:29d0 with SMTP id d2e1a72fcca58-79387051fa6mr35422135b3a.16.1760581732526;
        Wed, 15 Oct 2025 19:28:52 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d2d2b29sm20319608b3a.55.2025.10.15.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 19:28:51 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH v3] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 10:28:46 +0800
Message-ID: <20251016022846.3152565-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index fbf0d9c2f58b..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-- 
2.51.0


