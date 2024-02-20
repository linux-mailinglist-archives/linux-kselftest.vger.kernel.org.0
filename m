Return-Path: <linux-kselftest+bounces-5000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5185B1AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 04:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7A31F221C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 03:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C856B69;
	Tue, 20 Feb 2024 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a8MUyTXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832858200
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401091; cv=none; b=utw7F2pKLd/XguWLRt32lcXQkVPDjWUIXzsq3wdhLvB4aMu1w89yNUV9ttWR7S0mbX59dkKIBbwfmjFsqrs5yJd6m4cJHBECk2nv5t70qM8RR0s2Z4WcnDNG2iQ2RAnzQ4RYSvZndv0LEPy73eGk/8URhiO6FpNyU9Z+IAV92zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401091; c=relaxed/simple;
	bh=6+Gbjw6HF7/xondO+kClgQlDhke7d2kt7MutGrzeEn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bsS9an/PTTaNxveJkWNyucVNgOQ0WNL/bmcAiN0hgCsLNek0ktqAqmsqUCITFS/yx7vsBI3CxrAcHDpr9a+t+vw6SlXED2B62wC8M8hq9JxJqjMAsgDuhQdu0TuKzQ0eflpZNoqmppeJz1qe9Zw4de5kjXWVc/dNyCE2Ie5SM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a8MUyTXR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1d746ce7d13so32803245ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 19:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401090; x=1709005890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Snh1k6Nld5+bv3WZ3l7dPau1Zu+9Ra2XDZxa5NzBZqk=;
        b=a8MUyTXR7yP1fLN1nWIOnw2HxG5Xy5AKZOcM+fOaja0wIen1PJiPqjXrO8h/NibpX4
         D9PJg+qoSd0oNjgJW4PVFh05q3U7EqAo+MtViXgXFa7YQBvTQFUKcaykgLnwxtN8et2t
         tDoyWJ1RII2Z7PIJX4qFup3JK4LW9ZbXWhOnhOIyGs+l+mU05KxP5z+ldChlBMsGFixA
         kOq7LrQOqbogP8HhJMIq2Ny5kWZlCbbVKXlqmmsiKJZpG5mjGpI//Mj8eeHfIQKeYuPj
         DoTVW4iRKohrMrX8Y/GD/FNcl4ttyc8kshUif4PASLqtXSNJHDgSbQM0QUGyyPo9j/NY
         G1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401090; x=1709005890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Snh1k6Nld5+bv3WZ3l7dPau1Zu+9Ra2XDZxa5NzBZqk=;
        b=XW4sKudk+nenZtGJ77iKOE1M22mQl1LiCmen6APm4wxVCwTdJ8IJuWr29haVmzqmmy
         OLUPCFZq5Pj7pgrCxR1cJYBQniHRqX9VBe2HZNEgSylY2y0Ok6bAXGH8vN/6tldNVPvD
         1bQoE3DimfhgcNQPg0/2owPgpB0YvchOXFMyUfhNhk3VZ+7UAx5Ca4FK5d80uhb6NH1b
         IzxW1RH86Zr7V0WGRhYcwRDmbg5Z8ykH2AGVla4dXdCSlqKlwHmPZ50iLZFuS1Dv88cH
         3s5u2tOFevWDW3uxjleshuFD2LTEGCSK4HGhpZffSsl5DADVn0qCxV50aGotBWbhZaFc
         G8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXf51WY6X4j7RHD5iHkAf7JhZtA05xYagywXR+I5rOFXyK6oMRJ2m5I1b0THKyFKKTJKzsefUn+TtpyWW64uubgF2McjnDJkhZ/i8JXY5uB
X-Gm-Message-State: AOJu0YyPwbJra+nDPymsmii+SRgzXDZVPazaR2E3OMZ/oIvBMtiOO6t1
	KE2zS79HjPZu3l0qki2TDbSPH0scQcWNxO0ggQvxHjgBOxn8W/S6xZ3Tn/nEmBw=
X-Google-Smtp-Source: AGHT+IE50Pp+2/Wa8GXXWTQqvcE4yzBnlnYNnnShgb/W714yZn0SAXzbdPgA3nC1n82GoyzcKq2MiQ==
X-Received: by 2002:a17:902:6806:b0:1db:cbff:df15 with SMTP id h6-20020a170902680600b001dbcbffdf15mr7399748plk.9.1708401089700;
        Mon, 19 Feb 2024 19:51:29 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:29 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 4/5] libbpf: add the function libbpf_find_kernel_btf_id()
Date: Tue, 20 Feb 2024 11:51:04 +0800
Message-Id: <20240220035105.34626-5-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new function libbpf_find_kernel_btf_id() to find the btf type id of
the kernel, including vmlinux and modules.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 tools/lib/bpf/libbpf.c   | 83 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  3 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 87 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..44e34007de8c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9500,6 +9500,89 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	return libbpf_err(err);
 }
 
+int libbpf_find_kernel_btf_id(const char *name,
+			      enum bpf_attach_type attach_type,
+			      int *btf_obj_fd, int *btf_type_id)
+{
+	struct btf *btf, *vmlinux_btf;
+	struct bpf_btf_info info;
+	__u32 btf_id = 0, len;
+	char btf_name[64];
+	int err, fd;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	err = libbpf_get_error(vmlinux_btf);
+	if (err)
+		return libbpf_err(err);
+
+	err = find_attach_btf_id(vmlinux_btf, name, attach_type);
+	if (err > 0) {
+		*btf_type_id = err;
+		*btf_obj_fd = 0;
+		err = 0;
+		goto out;
+	}
+
+	/* kernel too old to support module BTFs */
+	if (!feat_supported(NULL, FEAT_MODULE_BTF)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	while (true) {
+		err = bpf_btf_get_next_id(btf_id, &btf_id);
+		if (err) {
+			err = -errno;
+			goto out;
+		}
+
+		fd = bpf_btf_get_fd_by_id(btf_id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			err = -errno;
+			goto out;
+		}
+
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(btf_name);
+		info.name_len = sizeof(btf_name);
+
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			err = -errno;
+			goto fd_out;
+		}
+
+		if (!info.kernel_btf || strcmp(btf_name, "vmlinux") == 0) {
+			close(fd);
+			continue;
+		}
+
+		btf = btf_get_from_fd(fd, vmlinux_btf);
+		err = libbpf_get_error(btf);
+		if (err)
+			goto fd_out;
+
+		err = find_attach_btf_id(btf, name, attach_type);
+		if (err > 0) {
+			*btf_type_id = err;
+			*btf_obj_fd = fd;
+			err = 0;
+			break;
+		}
+		close(fd);
+		continue;
+fd_out:
+		close(fd);
+		break;
+	}
+out:
+	btf__free(vmlinux_btf);
+	return err;
+}
+
 static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 {
 	struct bpf_prog_info info;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..ca151bbec833 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -306,6 +306,9 @@ LIBBPF_API int libbpf_attach_type_by_name(const char *name,
 					  enum bpf_attach_type *attach_type);
 LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,
 					  enum bpf_attach_type attach_type);
+LIBBPF_API int libbpf_find_kernel_btf_id(const char *name,
+					 enum bpf_attach_type attach_type,
+					 int *btf_obj_fd, int *btf_type_id);
 
 /* Accessors of bpf_program */
 struct bpf_program;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..73c60f47b4bb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		libbpf_find_kernel_btf_id;
 } LIBBPF_1.3.0;
-- 
2.39.2


